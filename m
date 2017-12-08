From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH v2] perf test shell: Fix check open filename arg using 'perf
 trace
Date: Fri, 8 Dec 2017 18:48:17 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1712081845230.9416@Diego>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="571116033-1820064210-1512755299=:9416"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbdLHRsU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Dec 2017 12:48:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CC7EC0AA54A
        for <linux-perf-users@vger.kernel.org>; Fri,  8 Dec 2017 17:48:20 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Arnaldo de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--571116033-1820064210-1512755299=:9416
Content-Type: text/plain; charset=US-ASCII

Hi Arnaldo, so I have tried what you've suggested and looks good.
Patch is attached. Sorry for not posting it in-text, but I need to
fix my mail client first, since it screwes some patches up due to
flowed-text...
Cheers,
Michael

--571116033-1820064210-1512755299=:9416
Content-Type: text/plain; charset=US-ASCII; name=perf_test_shell_fix_check_open_filename_arg__v2.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LRH.2.20.1712081848170.9416@Diego>
Content-Description: 
Content-Disposition: attachment; filename=perf_test_shell_fix_check_open_filename_arg__v2.patch

Y29tbWl0IDkyMjgxYTlmZjczZjk4ZDhhY2E3NTk1NTA0MzQwYTI1YzkyYjlm
MWENCkF1dGhvcjogTWljaGFlbCBQZXRsYW4gPG1wZXRsYW5AcmVkaGF0LmNv
bT4NCkRhdGU6ICAgRnJpIERlYyA4IDE4OjQzOjE4IDIwMTcgKzAxMDANCg0K
ICAgIHBlcmYgdGVzdCBzaGVsbDogRml4IGNoZWNrIG9wZW4gZmlsZW5hbWUg
YXJnIHVzaW5nICdwZXJmIHRyYWNlJw0KICAgIA0KICAgIFRoZSBmb2xsb3dp
bmcgY29tbWl0IGFkZGVkIGFuIGV4Y2VwdGlvbiBmb3IgczM5MHggdG8gdXNl
IG9wZW5hdCgpDQogICAgaW5zdGVhZCBvZiBvcGVuKCkgaW4gdGhlIHRlc3Q6
DQogICAgDQogICAgICBjb21taXQgZjIzMWFmNzg5YjExYTJmMWEzNzk1YWNj
MzIyOGEzZTE3OGE4MGMyMQ0KICAgICAgQXV0aG9yOiBUaG9tYXMgUmljaHRl
ciA8dG1yaWNodEBsaW51eC52bmV0LmlibS5jb20+DQogICAgICBEYXRlOiAg
IFR1ZSBOb3YgMTQgMDg6MTg6NDYgMjAxNyArMDEwMA0KICAgIA0KICAgIFNp
bmNlIHRoZSBwcm9ibGVtIGlzIG5vdCBzMzkweC1zcGVjaWZpYywgdGhpcyBw
YXRjaCBtYWtlcyBpdCBtb3JlDQogICAgZ2VuZXJpYywgc28gdGhlIHRlc3Qg
aGFuZGxlcyBib3RoIG9wZW4oKSBhbmQgb3BlbmF0KCkgbm8gbWF0dGVyDQog
ICAgd2hpY2ggYXJjaGl0ZWN0dXJlIGl0IGlzIHJ1bm5pbmcgb24uDQogICAg
DQogICAgU2lnbmVkLW9mZi1ieTogTWljaGFlbCBQZXRsYW4gPG1wZXRsYW5A
cmVkaGF0LmNvbT4NCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMv
c2hlbGwvdHJhY2UrcHJvYmVfdmZzX2dldG5hbWUuc2ggYi90b29scy9wZXJm
L3Rlc3RzL3NoZWxsL3RyYWNlK3Byb2JlX3Zmc19nZXRuYW1lLnNoDQppbmRl
eCAyYTllZjA4Li5lZGQxMDczIDEwMDc1NQ0KLS0tIGEvdG9vbHMvcGVyZi90
ZXN0cy9zaGVsbC90cmFjZStwcm9iZV92ZnNfZ2V0bmFtZS5zaA0KKysrIGIv
dG9vbHMvcGVyZi90ZXN0cy9zaGVsbC90cmFjZStwcm9iZV92ZnNfZ2V0bmFt
ZS5zaA0KQEAgLTE3LDEwICsxNyw5IEBAIHNraXBfaWZfbm9fcGVyZl9wcm9i
ZSB8fCBleGl0IDINCiBmaWxlPSQobWt0ZW1wIC90bXAvdGVtcG9yYXJ5X2Zp
bGUuWFhYWFgpDQogDQogdHJhY2Vfb3Blbl92ZnNfZ2V0bmFtZSgpIHsNCi0J
dGVzdCAiJCh1bmFtZSAtbSkiID0gczM5MHggJiYgeyBzdmM9Im9wZW5hdCI7
IHR4dD0iZGZkOiArQ1dELCArIjsgfQ0KLQ0KLQlwZXJmIHRyYWNlIC1lICR7
c3ZjOi1vcGVufSB0b3VjaCAkZmlsZSAyPiYxIHwgXA0KLQllZ3JlcCAiICtb
MC05XStcLlswLTldKyArXCggK1swLTldK1wuWzAtOV0rIG1zXCk6ICt0b3Vj
aFwvWzAtOV0rICR7c3ZjOi1vcGVufVwoJHt0eHR9ZmlsZW5hbWU6ICske2Zp
bGV9LCArZmxhZ3M6IENSRUFUXHxOT0NUVFlcfE5PTkJMT0NLXHxXUk9OTFks
ICttb2RlOiArSVJVR09cfElXVUdPXCkgKz0gK1swLTldKyQiDQorCWV2dHM9
YHBlcmYgbGlzdCBzeXNjYWxsczpzeXNfZW50ZXJfb3BlbiogfCYgZWdyZXAg
J29wZW4oYXQpPyAnIHwgc2VkIC1yICdzLy4qc3lzX2VudGVyXyguKikgK1xb
LiovLWUgXDEvJ2ANCisJcGVyZiB0cmFjZSAkZXZ0cyB0b3VjaCAkZmlsZSAy
PiYxIHwgXA0KKwllZ3JlcCAiICtbMC05XStcLlswLTldKyArXCggK1swLTld
K1wuWzAtOV0rIG1zXCk6ICt0b3VjaFwvWzAtOV0rIG9wZW4oYXQpP1woKGRm
ZDogK0NXRCwgKyk/ZmlsZW5hbWU6ICske2ZpbGV9LCArZmxhZ3M6IENSRUFU
XHxOT0NUVFlcfE5PTkJMT0NLXHxXUk9OTFksICttb2RlOiArSVJVR09cfElX
VUdPXCkgKz0gK1swLTldKyQiDQogfQ0KIA0KIA0K

--571116033-1820064210-1512755299=:9416--
