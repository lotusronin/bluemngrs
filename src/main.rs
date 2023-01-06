use bluez::management::*;

fn main() {
    println!("Hello, world!");
    let mut stream = ManagementStream::open().expect("Failed to get Management Stream");
    let vers = get_mgmt_version(&mut stream, None).await.expect("Failed to get Management Version");
    println!("mgmt vers: {}.{}",vers.version,vers.revision);
    let controllers = get_ext_controller_list(&mut stream, None).await.expect("Failed to get Controllers");
    for (con, con_t, con_bus) in controllers {
        println!("{:?} ({:?}, {:?})", con, con_t, con_bus);
        let info = get_controller_info(&mut stream, con, None).await.expect("Failed to get controller info");
        println!("  Name: {:?}",info.name);
        println!("  Short Name: {:?}",info.short_name);
        println!("  Addr: {:?}",info.address);
        println!("  Supported Settings: {:?}",info.supported_settings);
        println!("  Device Class: {:?}",info.class_of_device);
    }

}
