Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20468C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E0861059
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbhIIOPg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:15:36 -0400
Received: from mail.kdab.com ([176.9.126.58]:44423 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237771AbhIIOP0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 10:15:26 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2021 10:15:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:organization:message-id
 :date:date:subject:subject:from:from; s=dkim; t=1631196508; x=
 1632060509; bh=rX5wAxvhzBqaPutgANwk6rhrhT4irrGgygClxnvaFv4=; b=J
 1ko0Vv2kicBx3yU4W12kaRJcDAEk5RvgfkM2fzjRf8KOeJxj3XRhkD9BM/M6pZtq
 K8LAS0Iu5LCIPf5dzltiukW2iqT5jGCpLJn5sX3xahsOQ3bdQYYofscinhDEaTkL
 Rzy8owO5M84C9T+4jap9UM/Thdqx6iRLq26JlDC1sc=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Reducing impact of IO/CPU overload during `perf record` - bad
 handling of excessive yield?
Date:   Thu, 09 Sep 2021 16:08:27 +0200
Message-ID: <9270373.m2mTvpyXtE@milian-workstation>
Organization: KDAB
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1890170.DFHle8d8iY";
 micalg="sha256"; protocol="application/pkcs7-signature"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--nextPart1890170.DFHle8d8iY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey there!

I'm trying to profile an application that suffers from overcommit and 
excessive calls to `yield` (via OMP). Generally, it is putting a lot of strain 
on the system. Sadly, I cannot make `perf record` work without dropping (a lot 
of) chunks / events.

Usually I'm using this command line:

```
perf record --call-graph dwarf -z -m 16M ...
```

But this is not enough in this case. What other alternatives are there? Is 
there a `perf record` mode which never drops events, at the cost of maybe 
stalling the profiled application?

Generally though, looking at the (partial) data I get from perf, it seems like 
it does not cope well in the face of excessive calls to `yield`. Take this 
example code here:

```
#include <thread>
#include <vector>
#include <algorithm>

void yieldALot()
{
    for (int i = 0; i < 1000000; ++i) {
        std::this_thread::yield();
    }
}

int main()
{
    std::vector<std::thread> threads(std::thread::hardware_concurrency() * 2);
    std::generate(threads.begin(), threads.end(), []() {
        return std::thread(&yieldALot);
    });

    for (auto &thread : threads)
        thread.join();

    return 0;
}
```

When I compile this with `g++ test.cpp -pthread -O2 -g` and run it on my 
system with a AMD Ryzen 9 3900X with 12 cores and 24 SMT cores, then I observe 
the following behavior:

```
perf stat -r 5 ./a.out 

 Performance counter stats for './a.out' (5 runs):

         18,570.71 msec task-clock                #   19.598 CPUs utilized            
( +-  1.27% )
         2,717,136      context-switches          #  145.447 K/sec                    
( +-  3.26% )
                55      cpu-migrations            #    2.944 /sec                     
( +-  3.79% )
               222      page-faults               #   11.884 /sec                     
( +-  0.49% )
    61,223,010,902      cycles                    #    3.277 GHz                      
( +-  0.54% )  (83.33%)
     1,259,821,397      stalled-cycles-frontend   #    2.07% frontend cycles 
idle     ( +-  1.54% )  (83.16%)
     9,001,394,333      stalled-cycles-backend    #   14.81% backend cycles 
idle      ( +-  0.79% )  (83.25%)
    65,746,848,695      instructions              #    1.08  insn per cycle         
                                                  #    0.14  stalled cycles 
per insn  ( +-  0.26% )  (83.40%)
    14,474,862,454      branches                  #  774.830 M/sec                    
( +-  0.36% )  (83.49%)
       114,518,545      branch-misses             #    0.79% of all branches          
( +-  0.71% )  (83.67%)

           0.94761 +- 0.00935 seconds time elapsed  ( +-  0.99% )
```

Now compare this to what happens when I enable perf recording:

```
 Performance counter stats for 'perf record --call-graph dwarf -z ./a.out' (5 
runs):

         19,928.28 msec task-clock                #    9.405 CPUs utilized            
( +-  2.74% )
         3,026,081      context-switches          #  142.538 K/sec                    
( +-  7.48% )
               120      cpu-migrations            #    5.652 /sec                     
( +-  3.18% )
             5,509      page-faults               #  259.491 /sec                     
( +-  0.01% )
    65,393,592,529      cycles                    #    3.080 GHz                      
( +-  1.81% )  (71.81%)
     1,445,203,862      stalled-cycles-frontend   #    2.13% frontend cycles 
idle     ( +-  2.01% )  (71.60%)
     9,701,321,165      stalled-cycles-backend    #   14.29% backend cycles 
idle      ( +-  1.28% )  (71.62%)
    69,967,062,730      instructions              #    1.03  insn per cycle         
                                                  #    0.14  stalled cycles 
per insn  ( +-  0.74% )  (71.83%)
    15,376,981,968      branches                  #  724.304 M/sec                    
( +-  0.83% )  (72.00%)
       127,934,194      branch-misses             #    0.81% of all branches          
( +-  1.29% )  (72.07%)

          2.118881 +- 0.000496 seconds time elapsed  ( +-  0.02% )
```

Note how the CPU utilization drops dramatically by roughly a factor of 2x, 
which correlates with the increase in overall runtime.

From the data obtained here I see:
```
    98.49%     0.00%  a.out    libc-2.33.so        [.] __GI___sched_yield 
(inlined)
            |
            ---__GI___sched_yield (inlined)
               |          
               |--89.93%--entry_SYSCALL_64_after_hwframe
               |          |          
               |           --89.32%--do_syscall_64
               |                     |          
               |                     |--71.70%--__ia32_sys_sched_yield
               |                     |          |          
               |                     |          |--64.36%--schedule
               |                     |          |          |          
               |                     |          |           --63.42%--
__schedule
               |                     |          |                     |          
               |                     |          |                     
|--32.56%--__perf_event_task_sched_out
               |                     |          |                     |          
|          
               |                     |          |                     |           
--32.07%--amd_pmu_disable_all
               |                     |          |                     |                     
|          
               |                     |          |                     |                     
|--23.54%--x86_pmu_disable_all
               |                     |          |                     |                     
|          |          
               |                     |          |                     |                     
|          |--12.81%--native_write_msr
               |                     |          |                     |                     
|          |          
               |                     |          |                     |                     
|          |--8.24%--native_read_msr
               |                     |          |                     |                     
|          |          
               |                     |          |                     |                     
|           --1.25%--amd_pmu_addr_offset
               |                     |          |                     |                     
|          
               |                     |          |                     |                      
--8.19%--amd_pmu_wait_on_overflow
               |                     |          |                     |                                
|          
               |                     |          |                     |                                
|--5.00%--native_read_msr
               |                     |          |                     |                                
|          
               |                     |          |                     |                                
|--2.20%--delay_halt
               |                     |          |                     |                                
|          |          
               |                     |          |                     |                                
|           --1.99%--delay_halt_mwaitx
               |                     |          |                     |                                
|          
               |                     |          |                     |                                 
--0.55%--amd_pmu_addr_offset

```

Is this a dificiency with the AMD perf subsystem? Or is this a generic issue 
with perf? I understand that it has to enable/disable the PMU when it's 
switching tasks, but potentially there are some ways to optimize this 
behavior?

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart1890170.DFHle8d8iY
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
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwOTA5MTQwODI3WjAo
BgkqhkiG9w0BCQ8xGzAZMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQg
NFgOpw4ZHdY2ufmSRC3Y4Staz5SOV1ZoIeOPJyzIzuwwDQYJKoZIhvcNAQEBBQAEggEATfgngjix
/+XX+okGOQnOZVReR005GF00g5XK2BOogzzdY/z04g4dF2vFUS5Vs8zg8RNIBvvASnXkQo16KOlH
0s4YwBIo918bX/goYwDr1E2f+HVNnXBPL/Wr7pBKHiq5Dmnh9nuzDEPuONzNNctcTR3OGjX4ZTZw
4oafMolGqxccG51meUCT03D56Yg5Y9KgLf5h1Qvr+5tu/kY7R83HoEBDzbT1Wyorq8mOic1Abs4c
RiO3tB5g82f0hVij4GFtR7G/fI22wlt/wRZDP1R/NAWiHHYaHT4zIzwYfhERLviXLvevW4GIErW1
iie5XkydqXnirsI7L+bDg00nzRhLkAAAAAAAAA==


--nextPart1890170.DFHle8d8iY--


