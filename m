Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E0EC433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Mar 2021 13:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E84064E31
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Mar 2021 13:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhCOND3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:03:29 -0400
Received: from mail.kdab.com ([176.9.126.58]:46978 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhCOND0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Mar 2021 09:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1615813401; x=1616677402; bh=w0unVbgy7aU7aqx9L6bZSuqfvmi
 RsryT6kUKSER1Uvg=; b=GB3Ees81E8YMBqJbVq/nvWK0O9ig7ci8bj5nNvKBy0w
 J4wLv6x6oPhHDwCJ8rUcUFcHJt9qyM2PIdMXI9nyiYgSEfk2JPC8embYCkMCCMZv
 /McHoTPEtBhBlBJMC/2s8HAELe5hrcdRpQvP7TiHzgAGmA10fMsj7fzJNbIjg0bY
 =
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Aveek Basu <basu.aveek@gmail.com>,
        Till Kamppeter <till@linux.com>
Subject: Re: Linux Foundation accepted for Google Summer-of-Code 2021
Date:   Mon, 15 Mar 2021 14:00:24 +0100
Message-ID: <2992928.gD54jUj7cO@milian-workstation>
Organization: KDAB
In-Reply-To: <CAP-5=fUsFKOj3iN4h7DPAeT-GrEby8T0JJEj1zTBxw5L4q_oBQ@mail.gmail.com>
References: <CAP-5=fXevQSmPPu2d3QixSJH=8Y5cb379angt36mATj96E7ZPw@mail.gmail.com>
 <6935438.x6IAOlLzNv@agathebauer>
 <CAP-5=fUsFKOj3iN4h7DPAeT-GrEby8T0JJEj1zTBxw5L4q_oBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6450931.M2pTB9URCE";
 micalg="sha256"; protocol="application/pkcs7-signature"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--nextPart6450931.M2pTB9URCE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 14. M=E4rz 2021 18:29:09 CET Ian Rogers wrote:
> Hi Milian,
>=20
> Thanks for the email and hotspot is a very interesting project!
>=20
> On Sat, Mar 13, 2021 at 8:25 AM Milian Wolff <milian.wolff@kdab.com> wrot=
e:
> > On Mittwoch, 10. M=E4rz 2021 17:32:25 CET Ian Rogers wrote:
> > > Hi,
> > >=20
> > > I'm happy to share that the Linux Foundation has been accepted into
> > > the Google Summer-of-Code 2021 and we are looking for students
> > > interested in profiling, perf, etc. to apply to do projects.
> > >=20
> > > The main details on the Linux foundation application are here:
> > > https://wiki.linuxfoundation.org/gsoc/google-summer-code-2021
> > >=20
> > > Details on potential projects with perf here:
> > > https://wiki.linuxfoundation.org/gsoc/2021-gsoc-perf
> > >=20
> > > Please help to share, especially to students.
> > >=20
> > > Additional project ideas, mentors and help is also appreciated.
> >=20
> > As the maintainer of hotspot [1], I'd be happy to discuss how we could
> > reuse the prior art in providing a GUI around `perf report` and more.
> > Considering that hotspot is already a pretty successfull project, I
> > wonder why we have to reinvent the wheel to provide a gtk-based GUI - is
> > it really just the framework choice - Qt vs. GTK? Or are there other
> > reasons?
>=20
> There are a few issues:
>  - there's an observation that the gtk support in perf was bitrotting.
> Having a student project in this area would hopefully improve this
> situation.

Agreed.

>  - commands like perf report even in text mode are slow, single
> threaded, etc. Again, an area where a student project can help out.

Again, agreed. That is actually something that I've spent a considerable=20
amount of time on. So far, I mostly concentrated on better caching - someth=
ing=20
which has had very significant effects on the performance of hotspot for so=
me=20
perf.data workloads. See e.g.: https://www.kdab.com/hotspot-version-1-3-0-r=
eleased/

Threading wise, in hotspot, we have basically two threads - one in the=20
background process perfparser which does unwinding and symbolication. Then=
=20
another one in the hotspot GUI process, which does the data aggregation for=
=20
the various views. So far, I shied away from trying to further parallelize =
the=20
former part, as unwinding and symbolication are both heavily dependend on t=
he=20
order in which events are processed. I.e. we have to make sure to process m=
map=20
events and the like before we process a sampling event. Additionally, makin=
g=20
caching efficient is much easier in a singlethreaded context, which was so =
far=20
much more important to get right.

>  - wrt UI there is also pprof (https://github.com/google/pprof) which
> I think a web UI is interesting beyond just Qt, GTK, etc. Having the
> code be within the perf tool means that testing can be automated, it
> is easy for shared contributions, the kernel and user APIs aren't
> separated by projects..

Yes, nowadays there are tons of pretty good UI options out there - esp. in =
the=20
web context. I have not used pprof, but heard a lot of praise for the Mozil=
la=20
profiler too: https://profiler.firefox.com/

And then there's catapult which is integrated into chromium or Perfetto whi=
ch=20
is afaik used for Android? The list probably goes on and on ;-)

But in the end it would be extremely useful if perf could directly create a=
=20
pre-processed, compressed and portable result file with some command. That=
=20
could in turn use some easy-to-use binary format (CBOR, protobof, whatever)=
=20
which could then be parsed by the GUI instead of it having to reinvent the=
=20
wheel there.

> > Generally, I would love to see a proper library provided by perf that
> > could be used to do the `perf report` and/or `perf annotate` data
> > processing.
>
> There is a library interface developing:
> https://github.com/torvalds/linux/tree/master/tools/lib/perf

Ah, that's very interesting - that didn't exist back when we started=20
perfparser/hotspot.=20
=20
> But it is mainly focussed on say 'perf record' than 'perf report'.
> Perhaps you could mentor a project to refactor the report APIs, which
> could be integrated with hotspot? If so, we can update the GSoC wiki.

While I'm honored by the invitation, I'm afraid that I don't have the capac=
ity=20
to fulfil this role. I've attended GSOC myself in the past, and even mentor=
ed=20
a couple of times, so I know that doing a good job there as a mentor requir=
es=20
more time than I can spare currently :(

That said, I am very willing to be available for discussion as an intereste=
d=20
party.

> It'd be nice to refactor things like event parsing into a library, in
> part to make unit and fuzz testing easier. The event sorting is a big
> source of perf's slowness and something that should be reasonable to
> parallelize, an issue here is a lack of a thread pool and other
> abstractions. These dependencies across projects can be something that
> is tricky.

In our case, sorting isn't the bottleneck at all. But it does make=20
parallelization harder as I mentioned above. Unwinding and symbolication is=
=20
usually what's much much slower compared to just sorting a couple of events=
=20
in-memory.

Regarding missing abstractions: I'm a C++ developer myself, and having easy=
=20
access to more abstractions like hash maps and more has helped tremendously=
 in=20
improving the performance of our perf.data parser too. So yes, I again tota=
lly=20
agree with you in that regards.

> > As I said - I'm happy to discuss this topic in more detail with anyone
> > interested in this topic.
>=20
> I'm interested! There is an IRC channel #perf see www.oftc.net, but
> I'd suggest the mailing list is better for discussion. I know that BPF
> is doing regular office hours. I could imagine that similar for perf
> would be useful, but I also know that maintainers are busy folks.

I've joined that channel now.

Cheers
=2D-=20
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart6450931.M2pTB9URCE
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
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwMzE1MTMwMDI0WjAo
BgkqhkiG9w0BCQ8xGzAZMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQg
PIe02r+r0aIzxWaNjDJUY99fIdqimcngrOLT1JC0I+wwDQYJKoZIhvcNAQEBBQAEggEAgBn36Jdi
sBfzAJCBa57C6/joOs9F6gsf2vChOhEgh2iJaowNE3g0NBt6IrVL6tNOuiG2sh9xYq4eqmk/X/tF
tSAyaEPlDiv9J7Hag0LhrTxoG4OXHJLUzb6MX6eMVq2upp/jISvgQkqw8gWc7wvTeusYVAHiUOsO
pBPXr71kXs3fgwWH3UUF+sg5Vr/zU1uCQ3XNqTZZExLhaYwEsagYON8+jaDgHwvlhxgDIUdI1mWe
AS6y/FGqbB3+rfqmQoR7sJ9IAyOV6WdVt3S0wKIe2hnMgIzibaFHUELAbqmbL6PYR6T0HGMwLT1Z
Y0LtHmSTIiloBl8M32BrM+nm5vewLAAAAAAAAA==


--nextPart6450931.M2pTB9URCE--


