# Features

- **base64**: [`to_b64`][to_b64][], [`from_b64`][from_b64][], [`b64?`][b64?] and bang versions
- **digest**: [`md5`][md5], [`sha1`][sha1], … and bang versions
- **flag**: [`flag`][flag], [`flag!`][flag!], [`flag?`][flag?] (apply/check a flag format)
- **rot**: [`rot`][rot], [`rot13`][rot13], [`rot_all`][rot_all] and bang versions
- **hex**: [`hex2dec`][hex2dec], [`dec2hex`][dec2hex], [`to_hex`][to_hex], [`from_hex`][from_hex], [`str2hex`][str2hex], [`hex2str`][hex2str], [`hex2bin`][hex2bin], [`bin2hex`][bin2hex], [`from_hexipv4`][from_hexipv4], [`to_hexipv4`][to_hexipv4], … and bang versions
- **case**: [`randomcase`][randomcase], [`alternatecase`][alternatecase] and bang versions
- **cgi**: [`urlencode`][urlencode], [`urlencode_component`][urlencode_component], [`urlencode_data`][urlencode_data], [`htmlescape`][htmlescape], + decode/unescape opposites and bang versions
- **bin**: [`to_bin`][to_bin], [`from_bin`][from_bin], [`str2bin`][str2bin], [`bin2str`][bin2str], [`hex2bin`][hex2bin], [`bin2hex`][bin2hex], … and bang versions
- **leet**: [`leet`][leet] and bang version
- **dec**: [`dec2str`][dec2str], [`str2dec`][str2dec], [`hex2dec`][hex2dec], [`dec2hex`][dec2hex] and bang versions
- **xor**: [`ulxor`][ulxor], [`alxor`][alxor], [`urxor`][urxor], [`arxor`][arxor] and bang versions
- **misc**: [`istrip`][istrip] and bang version
- **defang**: [`defang_ip`][defang_ip], [`defang_uri`][defang_uri], [`defang_domain`][defang_domain], [`defang_email`][defang_email], + refang opposites and bang versions
- **network**: [`ipv4?`][ipv4?], [`ipv6?`][ipv6?], [`ip?`][ip?], [`uri?`][uri?], [`domain?`][domain?], [`email?`][email?]

[to_b64]:https://noraj.github.io/ctf-party/yard/String.html#to_b64-instance_method
[from_b64]:https://noraj.github.io/ctf-party/yard/String.html#from_b64-instance_method
[b64?]:https://noraj.github.io/ctf-party/yard/String.html#b64%3F-instance_method
[md5]:https://noraj.github.io/ctf-party/yard/String.html#md5-instance_method
[sha1]:https://noraj.github.io/ctf-party/yard/String.html#sha1-instance_method
[flag]:https://noraj.github.io/ctf-party/yard/String.html#flag-instance_method
[flag!]:https://noraj.github.io/ctf-party/yard/String.html#flag!-instance_method
[flag?]:https://noraj.github.io/ctf-party/yard/String.html#flag%3F-instance_method
[rot]:https://noraj.github.io/ctf-party/yard/String.html#rot-instance_method
[rot13]:https://noraj.github.io/ctf-party/yard/String.html#rot13-instance_method
[rot_all]:https://noraj.github.io/ctf-party/yard/String.html#rot_all-instance_method
[hex2dec]:https://noraj.github.io/ctf-party/yard/String.html#hex2dec-instance_method
[dec2hex]:https://noraj.github.io/ctf-party/yard/String.html#dec2hex-instance_method
[to_hex]:https://noraj.github.io/ctf-party/yard/String.html#to_hex-instance_method
[from_hex]:https://noraj.github.io/ctf-party/yard/String.html#from_hex-instance_method
[str2hex]:https://noraj.github.io/ctf-party/yard/String.html#str2hex-instance_method
[hex2str]:https://noraj.github.io/ctf-party/yard/String.html#hex2str-instance_method
[hex2bin]:https://noraj.github.io/ctf-party/yard/String.html#hex2bin-instance_method
[bin2hex]:https://noraj.github.io/ctf-party/yard/String.html#bin2hex-instance_method
[from_hexipv4]:https://noraj.github.io/ctf-party/yard/String.html#from_hexipv4-instance_method
[to_hexipv4]:https://noraj.github.io/ctf-party/yard/String.html#to_hexipv4-instance_method
[randomcase]:https://noraj.github.io/ctf-party/yard/String.html#randomcase-instance_method
[alternatecase]:https://noraj.github.io/ctf-party/yard/String.html#alternatecase-instance_method
[urlencode]:https://noraj.github.io/ctf-party/yard/String.html#urlencode-instance_method
[urlencode_component]:https://noraj.github.io/ctf-party/yard/String.html#urlencode_component-instance_method
[urlencode_data]:https://noraj.github.io/ctf-party/yard/String.html#urlencode_data-instance_method
[htmlescape]:https://noraj.github.io/ctf-party/yard/String.html#htmlescape-instance_method
[to_bin]:https://noraj.github.io/ctf-party/yard/String.html#to_bin-instance_method
[from_bin]:https://noraj.github.io/ctf-party/yard/String.html#from_bin-instance_method
[str2bin]:https://noraj.github.io/ctf-party/yard/String.html#str2bin-instance_method
[bin2str]:https://noraj.github.io/ctf-party/yard/String.html#bin2str-instance_method
[leet]:https://noraj.github.io/ctf-party/yard/String.html#leet-instance_method
[dec2str]:https://noraj.github.io/ctf-party/yard/String.html#dec2str-instance_method
[str2dec]:https://noraj.github.io/ctf-party/yard/String.html#str2dec-instance_method
[ulxor]:https://noraj.github.io/ctf-party/yard/String.html#ulxor-instance_method
[alxor]:https://noraj.github.io/ctf-party/yard/String.html#alxor-instance_method
[urxor]:https://noraj.github.io/ctf-party/yard/String.html#urxor-instance_method
[arxor]:https://noraj.github.io/ctf-party/yard/String.html#arxor-instance_method
[istrip]:https://noraj.github.io/ctf-party/yard/String.html#istrip-instance_method
[defang_ip]:https://noraj.github.io/ctf-party/yard/String.html#defang_ip-instance_method
[defang_uri]:https://noraj.github.io/ctf-party/yard/String.html#defang_uri-instance_method
[defang_email]:https://noraj.github.io/ctf-party/yard/String.html#defang_email-instance_method
[defang_domain]:https://noraj.github.io/ctf-party/yard/String.html#defang_domain-instance_method
[ipv4?]:https://noraj.github.io/ctf-party/yard/String.html#ipv4%3F-instance_method
[ipv6?]:https://noraj.github.io/ctf-party/yard/String.html#ipv6%3F-instance_method
[ip?]:https://noraj.github.io/ctf-party/yard/String.html#ip%3F-instance_method
[uri?]:https://noraj.github.io/ctf-party/yard/String.html#uri%3F-instance_method
[domain?]:https://noraj.github.io/ctf-party/yard/String.html#domain%3F-instance_method
[email?]:https://noraj.github.io/ctf-party/yard/String.html#email%3F-instance_method
