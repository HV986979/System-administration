@@ -3,10 +3,26 @@

# Create a Request object to start building the RSpec.
request = portal.context.makeRequestRSpec()
# Create a XenVM
node = request.XenVM("node")
node.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU20-64-STD"
node.routable_control_ip = "true"

prefixForIP = "192.168.1."
link = request.LAN("lan")

# Create a XenVM
for i in range(2):
  if i == 0:
    node = request.XenVM("webserver")
    node.routable_control_ip = "true"
  else: 
    node = request.XenVM("observer")

  node.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU20-64-STD"
  iface = node.addInterface("if" + str(i))
  iface.component_id = "eth1"
  iface.addAddress(rspec.IPv4Address(prefixForIP + str(i + 1), "255.255.255.0"))
  link.addInterface(iface)

  if i == 0:
    node.addService(rspec.Execute(shell="sh", command="sudo bash /local/repository/setup_apache.sh"))

# Print the RSpec to the enclosing page.
portal.context.printRequestRSpec()