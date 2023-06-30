require module core
from core use debugMode

-- as mandatory a random AES key. this function is built-in.

aes generate key

on debugMode do
    log("[DEBUG] An AES key was generated on bootime.");
end

-- the AES key will now forget itself from the system, no longer readable by the system itself.
disableSystem key

on userReqKey <= function() do -- if the user needs the key for a function, the system will read it once, and purge it from memory.
    encrypt use key
    read key => function()
    purgeMem key
    on debugMode do
        log("[DEBUG] The system read the user's AES key.");
    end
end

-- key checking. (simple)
on auth do
    userReqKey() => key
    if key is sys.keyValid?() do
        return status: OK => function()
    end
end

on init filesystem do
    read device nec.dla,4
    read address 0x555029B
    read fs
    verify fs && wait
    onProgressDoneFrom(verify, define status: "FS_OK");
end

on init purgeCache => loadSysKern do 
    wait for sys.purge();
    onProgressDoneFrom(wait, define status: "OK");
    sys.initKernelPre(define device, define status)
    on status OK do
        sys.initKernel(kernl.b);
        wait
        sys.initKernel(devKernl.b);
    end

    onProgressDoneFrom(sys.initKernel, define status: "K_OK")

    -- since we are now containerized, we must read the key and init manually.
    userReqKey(module.init("CIA"))
end

sys.init("filesystem", key); -- these interactions count as "user"
sys.init("purgeCache", "loadSysKern"); -- load the kernel after erasing the cache.