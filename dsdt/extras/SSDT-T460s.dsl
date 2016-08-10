// SSDT-XHC-T460S.dsl
//

DefinitionBlock ("", "SSDT", 2, "hack", "T460", 0)
{
    External(\_SB.PCI0.XHC, DeviceObj)
    External(\_SB.PCI0, DeviceObj)
    External(\_SB.PCI0.LPC, DeviceObj)
    External(\_SB.PCI0.LPC.KBD, DeviceObj)

    // inject properties for XHCI
    Method(\_SB.PCI0.XHC._DSM, 4)
    {
        If (!Arg2) { Return (Buffer() { 0x03 } ) }
        Local0 = Package()
        {
            "RM,pr2-force", Buffer() { 0, 0, 0, 0 },
            "subsystem-id", Buffer() { 0x70, 0x72, 0x00, 0x00 },
            "subsystem-vendor-id", Buffer() { 0x86, 0x80, 0x00, 0x00 },
            "AAPL,current-available", Buffer() { 0x34, 0x08, 0, 0 },
            "AAPL,current-extra", Buffer() { 0x98, 0x08, 0, 0, },
            "AAPL,current-extra-in-sleep", Buffer() { 0x40, 0x06, 0, 0, },
            "AAPL,max-port-current-in-sleep", Buffer() { 0x34, 0x08, 0, 0 },
        }
        Return(Local0)
    }

    Scope (\_SB.PCI0.LPC.KBD)
    {
        // Select specific items in VoodooPS2Controller
        Method(_DSM, 4)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                "RM,oem-id", "LENOVO",
                "RM,oem-table-id", "T460",
            })
        }
    }
}
//EOF