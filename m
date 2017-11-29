From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf test shell: Fix check open filename arg using 'perf
 trace'
Date: Wed, 29 Nov 2017 18:27:47 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1711291656270.9416@Diego>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="571116033-1809409242-1511976469=:9416"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932776AbdK2R1u (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Nov 2017 12:27:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F1C9C05686E
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2017 17:27:50 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Jiri Olsa <jolsa@redhat.com>, Arnaldo de Melo <acme@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--571116033-1809409242-1511976469=:9416
Content-Type: text/plain; charset=US-ASCII

Hi Arnaldo, Jiri and others!

Posting a fix for perf test "Check open filename arg using perf trace + vfs_getname".

The commit f231af789b11a2f1a3795acc3228a3e178a80c21 adds an exception for s390x to
use openat() syscall instead of open(). This exception is not s390x-only, thus I
adjusted the test to accept both open and openat syscalls, no matter which arch it
runs on. Does it sound reasonable to you?


When testing on 4.15.0-rc1, I also hit the following issue:

# perf probe "vfs_getname=getname_flags:72 pathname=result->name:string"
Failed to find 'result' in this function.
  Error: Failed to add events.

# perf probe -L getname_flags 
[...]
     72         result->uptr = filename;
     73         result->aname = NULL;
[...]

# perf probe "vfs_getname=getname_flags:72 pathname=result->uptr:string"
Failed to find 'result' in this function.
  Error: Failed to add events.

... When the probed var is changed to "filename", it seems to work:

# perf probe "vfs_getname=getname_flags:72 pathname=filename:string"
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=filename:string)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1


So maybe the second attached patch is necessary too, not sure. Just thinking
that "filename" might be less change-prone, as a func. arg... ?

Thank you.

Cheers,
Michael
--571116033-1809409242-1511976469=:9416
Content-Type: text/plain; charset=US-ASCII; name=perf_test_shell_fix_check_open_filename_arg.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LRH.2.20.1711291827470.9416@Diego>
Content-Description: 
Content-Disposition: attachment; filename=perf_test_shell_fix_check_open_filename_arg.patch

Y29tbWl0IDUyNmYyMjAxMjU0ZjhkYTc1MGU3MjJiODkzYWYxOWI3ZDRmMjY0
MGQNCkF1dGhvcjogTWljaGFlbCBQZXRsYW4gPG1wZXRsYW5AcmVkaGF0LmNv
bT4NCkRhdGU6ICAgVHVlIE5vdiAyOCAxNzo0Nzo0OSAyMDE3ICswMTAwDQoN
CiAgICBwZXJmIHRlc3Qgc2hlbGw6IEZpeCBjaGVjayBvcGVuIGZpbGVuYW1l
IGFyZyB1c2luZyAncGVyZiB0cmFjZScNCiAgICANCiAgICBUaGUgZm9sbG93
aW5nIGNvbW1pdCBhZGRlZCBhbiBleGNlcHRpb24gZm9yIHMzOTB4IHRvIHVz
ZSBvcGVuYXQoKQ0KICAgIGluc3RlYWQgb2Ygb3BlbigpIGluIHRoZSB0ZXN0
Og0KICAgIA0KICAgIGNvbW1pdCBmMjMxYWY3ODliMTFhMmYxYTM3OTVhY2Mz
MjI4YTNlMTc4YTgwYzIxDQogICAgQXV0aG9yOiBUaG9tYXMgUmljaHRlciA8
dG1yaWNodEBsaW51eC52bmV0LmlibS5jb20+DQogICAgRGF0ZTogICBUdWUg
Tm92IDE0IDA4OjE4OjQ2IDIwMTcgKzAxMDANCiAgICANCiAgICBTaW5jZSB0
aGUgcHJvYmxlbSBpcyBub3QgczM5MHgtc3BlY2lmaWMsIHRoaXMgcGF0Y2gg
bWFrZXMgaXQgbW9yZQ0KICAgIGdlbmVyaWMsIHNvIHRoZSB0ZXN0IGhhbmRs
ZXMgYm90aCBvcGVuKCkgYW5kIG9wZW5hdCgpIG5vIG1hdHRlcg0KICAgIHdo
aWNoIGFyY2hpdGVjdHVyZSBpdCBpcyBydW5uaW5nIG9uLg0KICAgIA0KICAg
IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUGV0bGFuIDxtcGV0bGFuQHJlZGhh
dC5jb20+DQoNCmRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rlc3RzL3NoZWxs
L3RyYWNlK3Byb2JlX3Zmc19nZXRuYW1lLnNoIGIvdG9vbHMvcGVyZi90ZXN0
cy9zaGVsbC90cmFjZStwcm9iZV92ZnNfZ2V0bmFtZS5zaA0KaW5kZXggMmE5
ZWYwOC4uMzMyMTJkYSAxMDA3NTUNCi0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMv
c2hlbGwvdHJhY2UrcHJvYmVfdmZzX2dldG5hbWUuc2gNCisrKyBiL3Rvb2xz
L3BlcmYvdGVzdHMvc2hlbGwvdHJhY2UrcHJvYmVfdmZzX2dldG5hbWUuc2gN
CkBAIC0xNywxMCArMTcsOCBAQCBza2lwX2lmX25vX3BlcmZfcHJvYmUgfHwg
ZXhpdCAyDQogZmlsZT0kKG1rdGVtcCAvdG1wL3RlbXBvcmFyeV9maWxlLlhY
WFhYKQ0KIA0KIHRyYWNlX29wZW5fdmZzX2dldG5hbWUoKSB7DQotCXRlc3Qg
IiQodW5hbWUgLW0pIiA9IHMzOTB4ICYmIHsgc3ZjPSJvcGVuYXQiOyB0eHQ9
ImRmZDogK0NXRCwgKyI7IH0NCi0NCi0JcGVyZiB0cmFjZSAtZSAke3N2Yzot
b3Blbn0gdG91Y2ggJGZpbGUgMj4mMSB8IFwNCi0JZWdyZXAgIiArWzAtOV0r
XC5bMC05XSsgK1woICtbMC05XStcLlswLTldKyBtc1wpOiArdG91Y2hcL1sw
LTldKyAke3N2Yzotb3Blbn1cKCR7dHh0fWZpbGVuYW1lOiArJHtmaWxlfSwg
K2ZsYWdzOiBDUkVBVFx8Tk9DVFRZXHxOT05CTE9DS1x8V1JPTkxZLCArbW9k
ZTogK0lSVUdPXHxJV1VHT1wpICs9ICtbMC05XSskIg0KKwlwZXJmIHRyYWNl
IC1lICdvcGVuKicgdG91Y2ggJGZpbGUgMj4mMSB8IFwNCisJZWdyZXAgIiAr
WzAtOV0rXC5bMC05XSsgK1woICtbMC05XStcLlswLTldKyBtc1wpOiArdG91
Y2hcL1swLTldKyBvcGVuKGF0KT9cKChkZmQ6ICtDV0QsICspP2ZpbGVuYW1l
OiArJHtmaWxlfSwgK2ZsYWdzOiBDUkVBVFx8Tk9DVFRZXHxOT05CTE9DS1x8
V1JPTkxZLCArbW9kZTogK0lSVUdPXHxJV1VHT1wpICs9ICtbMC05XSskIg0K
IH0NCiANCiANCg==

--571116033-1809409242-1511976469=:9416
Content-Type: text/plain; charset=US-ASCII; name=perf_test_shell_fix_filename_arg.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LRH.2.20.1711291827471.9416@Diego>
Content-Description: 
Content-Disposition: attachment; filename=perf_test_shell_fix_filename_arg.patch

ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvbGliL3Byb2Jl
X3Zmc19nZXRuYW1lLnNoIGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9saWIv
cHJvYmVfdmZzX2dldG5hbWUuc2gNCmluZGV4IDMwYTk1MGMuLjM3NTk1ODIg
MTAwNjQ0DQotLS0gYS90b29scy9wZXJmL3Rlc3RzL3NoZWxsL2xpYi9wcm9i
ZV92ZnNfZ2V0bmFtZS5zaA0KKysrIGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVs
bC9saWIvcHJvYmVfdmZzX2dldG5hbWUuc2gNCkBAIC0xMyw3ICsxMyw3IEBA
IGFkZF9wcm9iZV92ZnNfZ2V0bmFtZSgpIHsNCiAJbG9jYWwgdmVyYm9zZT0k
MQ0KIAlpZiBbICRoYWRfdmZzX2dldG5hbWUgLWVxIDEgXSA7IHRoZW4NCiAJ
CWxpbmU9JChwZXJmIHByb2JlIC1MIGdldG5hbWVfZmxhZ3MgMj4mMSB8IGVn
cmVwICdyZXN1bHQuKj0uKmZpbGVuYW1lOycgfCBzZWQgLXIgJ3MvW1s6c3Bh
Y2U6XV0rKFtbOmRpZ2l0Ol1dKylbWzpzcGFjZTpdXStyZXN1bHQtPnVwdHIu
Ki9cMS8nKQ0KLQkJcGVyZiBwcm9iZSAkdmVyYm9zZSAidmZzX2dldG5hbWU9
Z2V0bmFtZV9mbGFnczoke2xpbmV9IHBhdGhuYW1lPXJlc3VsdC0+bmFtZTpz
dHJpbmciDQorCQlwZXJmIHByb2JlICR2ZXJib3NlICJ2ZnNfZ2V0bmFtZT1n
ZXRuYW1lX2ZsYWdzOiR7bGluZX0gcGF0aG5hbWU9ZmlsZW5hbWU6c3RyaW5n
Ig0KIAlmaQ0KIH0NCiANCg==

--571116033-1809409242-1511976469=:9416--
