Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D05C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 11:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhKVLD5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:03:57 -0500
Received: from mail.kdab.com ([176.9.126.58]:63320 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhKVLD5 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 06:03:57 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2021 06:03:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:organization:message-id
 :date:date:subject:subject:from:from; s=dkim; t=1637578512; x=
 1638442513; bh=JON6recpJy2qLTHLTDRojQDG20z9RivwyX8g592TLA8=; b=L
 VKnYu8QOn6pfFFn20aDYQ17UM6nfNLH+fic9ehIbgoOd09o3u5b7ch5hbPMw8ujf
 otslr75996k7NzezdOOP/I7XH7Y7AXtQkr/yskrHM8FrIFzoPdPcByRdn1+lEaKa
 rvM8qrAQlPpHyfkOj14iMAQROvhw9J1qD9ZDKMUQyw=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: /sys/kernel/tracing/events permissions
Date:   Mon, 22 Nov 2021 11:55:11 +0100
Message-ID: <2315137.Eos4xDj3du@milian-workstation>
Organization: KDAB
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2328279.vQON7ckpMK";
 micalg="sha256"; protocol="application/pkcs7-signature"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--nextPart2328279.vQON7ckpMK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

a recent kernel update on my arch system has lead to breakage with regard to 
accessing trace events from perf. For example:

```
$ perf record -e sched:sched_switch ls 
event syntax error: 'sched:sched_switch'
                     \___ can't access trace events

Error:  No permissions to read /sys/kernel/tracing/events/sched/sched_switch
Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list available 
events
```

When I then try to run the remount hint from the message above, which used to 
work just fine, then the error persists, because:

```
$ mount | grep tracing
tracefs on /sys/kernel/tracing type tracefs 
(rw,nosuid,nodev,noexec,relatime,mode=755)
tracefs on /sys/kernel/debug/tracing type tracefs 
(rw,nosuid,nodev,noexec,relatime,mode=755)
```

and:

```
$ ls -ld /sys/kernel/tracing/
drwxr-xr-x root root 0 B Mon Nov 22 08:39:15 2021 /sys/kernel/tracing/
$ ls -ld /sys/kernel/tracing/events/
drwxr-x--- root root 0 B Mon Nov 22 08:39:26 2021 /sys/kernel/tracing/events/
```

How should this be handled? Is it now required to manually `chmod` the 
`events` folder, or is there another means to allow non-root to record kernel 
trace events?

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart2328279.vQON7ckpMK
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEekw
ggWBMIIEaaADAgECAhA5ckQ6+SK3UdfTbBDdMTWVMA0GCSqGSIb3DQEBDAUAMHsxCzAJBgNVBAYT
AkdCMRswGQYDVQQIDBJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNV
BAoMEUNvbW9kbyBDQSBMaW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMw
HhcNMTkwMzEyMDAwMDAwWhcNMjgxMjMxMjM1OTU5WjCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
Ck5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkw
ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCAEmUXNg7D2wiz0KxXDXbtzSfTTK1Qg2Hi
qiBNCS1kCdzOiZ/MPans9s/B3PHTsdZ7NygRK0faOca8Ohm0X6a9fZ2jY0K2dvKpOyuR+OJv0OwW
IJAJPuLodMkYtJHUYmTbf6MG8YgYapAiPLz+E/CHFHv25B+O1ORRxhFnRghRy4YUVD+8M/5+bJz/
Fp0YvVGONaanZshyZ9shZrHUm3gDwFA66Mzw3LyeTP6vBZY1H1dat//O+T23LLb2VN3I5xI6Ta5M
irdcmrS3ID3KfyI0rn47aGYBROcBTkZTmzNg95S+UzeQc0PzMsNT79uq/nROacdrjGCT3sTHDN/h
Mq7MkztReJVni+49Vv4M0GkPGw/zJSZrM233bkf6c0Plfg6lZrEpfDKEY1WJxA3Bk1QwGROs0303
p+tdOmw1XNtB1xLaqUkL39iAigmTYo61Zs8liM2EuLE/pDkP2QKe6xJMlXzzawWpXhaDzLhn4ugT
ncxbgtNMs+1b/97lc6wjOy0AvzVVdAlJ2ElYGn+SNuZRkg7zJn0cTRe8yexDJtC/QV9AqURE9Jnn
V4eeUB9XVKg+/XRjL7FQZQnmWEIuQxpMtPAlR1n6BB6T1CZGSlCBst6+eLf8ZxXhyVeEHg9j1uli
utZfVS7qXMYoCAQlObgOK6nyTJccBz8NUvXt7y+CDwIDAQABo4HyMIHvMB8GA1UdIwQYMBaAFKAR
CiM+lvEH7OKvKe+CpX/QMKS0MB0GA1UdDgQWBBRTeb9aqitKz1SA4dibwJ3ysgNmyzAOBgNVHQ8B
Af8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAIMAYGBFUdIAAwQwYDVR0fBDwwOjA4
oDagNIYyaHR0cDovL2NybC5jb21vZG9jYS5jb20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5jcmww
NAYIKwYBBQUHAQEEKDAmMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJ
KoZIhvcNAQEMBQADggEBABiHUdx0IT2ciuAntzPQLszs8ObLXhHeIm+bdY6ecv7k1v6qH5yWLe8D
Sn6u9I1vcjxDO8A/67jfXKqpxq7y/Njuo3tD9oY2fBTgzfT3P/7euLSK8JGW/v1DZH79zNIBoX19
+BkZyUIrE79Yi7qkomYEdoiRTgyJFM6iTckys7roFBq8cfFb8EELmAAKIgMQ5Qyx+c2SNxntO/Hk
Orb5RRMmda+7qu8/e3c70sQCkT0ZANMXXDnbP3sYDUXNk4WWL13fWRZPP1G91UUYP+1KjugGYXQj
FrUNUHMnREd/EF2JKmuFMRTE6KlqTIC8anjPuH+OdnKZDJ3+15EIFqGjX5UwggYQMIID+KADAgEC
AhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UE
CBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJV
U1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UE
CBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
IExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975
Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK
8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oH
ox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLt
piK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B
0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHY
m8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjAS
BgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAE
CjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VT
RVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/Bggr
BgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0Eu
Y3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUA
A4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8
zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8J
fqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmN
HdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdN
uO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRd
Wyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq
4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLw
rymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uY
dBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8m
ybM2JzCCBkwwggU0oAMCAQICEHR8gsPqhWo7MMOepQh9ypIwDQYJKoZIhvcNAQELBQAwgZYxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
GDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1
dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMjAwNTEyMDAwMDAwWhcNMjMwNTEy
MjM1OTU5WjCCAVkxCzAJBgNVBAYTAlNFMQ8wDQYDVQQREwY2ODMgMzExEjAQBgNVBAgTCVZhZXJt
bGFuZDEQMA4GA1UEBxMHSGFnZm9yczEYMBYGA1UECRMPTm9ycmluZ3MgdmFlZyAyMQ8wDQYDVQQS
EwZCb3ggMzAxJjAkBgNVBAoMHUtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCMR0wGwYDVQQL
ExRBIEtEQUIgR3JvdXAgQ29tcGFueTFDMEEGA1UECww6SXNzdWVkIHRocm91Z2ggS2xhcsOkbHZk
YWxlbnMgRGF0YWtvbnN1bHQgQUIgRS1QS0kgTWFuYWdlcjEfMB0GA1UECxMWQ29ycG9yYXRlIFNl
Y3VyZSBFbWFpbDEVMBMGA1UEAxMMTWlsaWFuIFdvbGZmMSQwIgYJKoZIhvcNAQkBFhVtaWxpYW4u
d29sZmZAa2RhYi5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8vdk66W4eo0O1
1Dh3zPXW/zrkwzzxRR0Air/VRxAIG5q/klE9mF2gsGBPXQpCtDMvkuvSLQ+5mR50Cb+V+4Y9n0W6
98JoyQHYAo6uswLyTchcF6IVckkkZrm1RD1DXnlIHpCsacO7PDDxMslzFs5XZfRkH4F1SKkiVwup
/Nsn0z12SGRzxSUUxr4VHZgIqgRGqVSbVJfjtTRigAu+fmXUXHs0bMRv8TonzrDRlN61m1UakrFu
qvKAgXYfZULZ52IKNK/jq8nPHJDD9oOr5pVi4Yx9GyVeMM0qNPC74fJnGh7lOpJiAcqYBEis73lm
U+RtH3Bj85Qdqvwxo3bf7s1zAgMBAAGjggHOMIIByjAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+o
mULPyeCtADAdBgNVHQ4EFgQUMc6p+s2l6xbyh8jLYeP7fQrRiW4wDgYDVR0PAQH/BAQDAgWgMAwG
A1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYM
KwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1Ud
HwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhl
bnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcw
AoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25h
bmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20w
IAYDVR0RBBkwF4EVbWlsaWFuLndvbGZmQGtkYWIuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBW3rFX
47Cnu8JMNm8row/96V8xGwPzir9lEpnasNxi+GhvQjGzvoP5oxMoBJ+hgD8fMk5X15IDuKa9KVHb
BzBG9kOPGB4h/89voWpzWIVy7Q3k+dPByfghbufR+83TvN20lV9VqXYjPeYypHlD/vJ4Z8iWn3s3
0iUfYr1CCr8zoje1hijPM9A0wN7K8iCtIc4OAfJpwKsXMCNAv1SdxD196vCKrTnWiEmAw0g8FpDM
GWIww0+2Qq+Peeoe53+34GetRPIbS5jPlCEy7xgC8c7qoJTNzhCyVENRByoA5dsLzK+Nv0IT1h2C
gu2w5VxHo0DjlCmYddu46uwpWjKpNuhaMYICbTCCAmkCAQEwgaswgZYxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1Nl
Y3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9u
IGFuZCBTZWN1cmUgRW1haWwgQ0ECEHR8gsPqhWo7MMOepQh9ypIwDQYJYIZIAWUDBAIBBQCggZMw
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjExMTIyMTA1NTExWjAo
BgkqhkiG9w0BCQ8xGzAZMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQg
1urPCm5F35DSwNElwTWBTwILkz+G875V6kerj9jzhhUwDQYJKoZIhvcNAQEBBQAEggEAdLwMj86F
GkD/NWWlrO3R/J+z2l0aIuapubGTeSIUMAnS0hltsByN45lJzms3ncggmKpzYS82mOJ1C2ObmCxK
hXaiP92f55J9kbGbP3FC+yV2enxS54yRPGF6wKKeZHFBnqcjQVBKVb/yW+G1bgpt6awkT/yLQrox
v1Jn/mxXLLGuXS8NKGDh9Sk25AnUqFzAwR5plFp2zNm/An5xFrzsMkMSua8ARuKpw4jdDYoGv8di
70NyLBG3dOLds26PGeW0UEg3f3Fvi4WG+5cmi46cElfA77OIqJAj1xFUvzONnFmwBQ8YpSWYAnQf
bQSenpA5u1fW4BKcxmkEEckmQzLSMQAAAAAAAA==


--nextPart2328279.vQON7ckpMK--


