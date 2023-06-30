var debugMode: false -- this can be toggled through build settings.
var wutface: false

on debugMode do
    log("[DEBUG] The operating system has began the initialization.");
    onProgressDone(define status: "OK");
end

devFail()
    log("A device has caused an error. The system has halted. (0x222921921-A_CIA)")
    wait && halt
end

-- load drivers for the device

init device: core.dla
init device: display.dla && wait

-- initializes everything else, this dla is heavily hotswappable/plug and play.
init device: nec.dla && wait
on debugMode do
    onProgressFailFrom(device: nec.dla, define status: "FATAL") && call devFail()
    onProgressDoneFrom(device: nec.dla, define status: "OK")
end

-- Initialize the modules. On runtime, modules will load in an order.
module.init("core");
module.init("containerize");

-- these must be called in a container.
-- module.init("CIA");
-- module.init("desk");
-- module.init("finalize");