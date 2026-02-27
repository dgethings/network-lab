# Cisco Licenses

You need to add Cisco IOS-XR license files here:

- `r1.lic` - License for router r1
- `r2.lic` - License for router r2

**For lab/testing purposes:**
- Use a 90-day evaluation license from Cisco
- Or use a development license if you have one
- Contact your Cisco account team for options

**Alternative:** Use a different containerlab image type that doesn't require licensing (e.g., Nokia SR Linux, Arista vEOS, or generic Linux routers).

To switch device types, edit `../lab1.yaml` and change:
- `kind:` - device type
- `image:` - container image
