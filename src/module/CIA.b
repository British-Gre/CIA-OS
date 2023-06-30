-- this file initializes tools and some system functions.
-- this file is also containerized.

from core use debugMode -- unused for now.
from containerize use userReqKey

-- TODO: CVE-45-222 - A program might be able to escalate privileges here.
-- We need an engineer to fix this ASAP.

on commitDestruct through sys do
    erase => sys.init("filesystem") && wait
    erase => key
    erase => device: nec.dla * 50
    sys.forceShut()
end

on userDestruct do
    -- first we must read the user's key.
    userReqKey() && auth
    on status OK do
        read sys.userPref("destruct")
        on 3 do
            sys.promztDestruct();
            wait
        end
        sys.commitDestruct();
    end
end

sys.init("FS_tools")