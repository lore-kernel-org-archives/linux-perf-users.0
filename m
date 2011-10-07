From: Arun Sharma <asharma@fb.com>
Subject: Re: Profiling sleep times?
Date: Thu, 6 Oct 2011 17:05:22 -0700
Message-ID: <4E8E4242.5050707@fb.com>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>  <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins> <4E8E2417.2000903@fb.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000109090104020802000900"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59553 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756790Ab1JGAF7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Oct 2011 20:05:59 -0400
In-Reply-To: <4E8E2417.2000903@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Vagin <avagin@gmail.com>

--------------000109090104020802000900
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/11 2:56 PM, Arun Sharma wrote:

> i.e. select() should be weighted by 4x vs nanosleep() as confirmed via:
>
> perf script | grep comm=foo
>
> foo 15516 [006] 2291.187831: sched_stat_sleep: comm=foo pid=15516
> delay=4054262 [ns]
> foo 15516 [006] 2291.187832: sched_stat_sleep: comm=foo pid=15516
> delay=4054262 [ns]
> foo 15516 [006] 2291.188895: sched_stat_sleep: comm=foo pid=15516
> delay=1053565 [ns]
> foo 15516 [006] 2291.188896: sched_stat_sleep: comm=foo pid=15516
> delay=1053565 [ns]
> foo 15516 [006] 2291.188897: sched_stat_sleep: comm=foo pid=15516
> delay=1053565 [ns]
>
> Andrew, are you already working on user space patches?

Attached is a quick hack (mainly meant as a RFC to get the discussion 
going).

After the patch I get the expected result:

      0.16%              foo  [unknown]          [k] 0
                        |
                        --- schedule
                           |
                           |--79.26%-- schedule_hrtimeout_range_clock
                           |          schedule_hrtimeout_range
                           |          poll_schedule_timeout
                           |          do_select
                           |          core_sys_select
                           |          sys_select
                           |          system_call_fastpath
                           |
                           |--16.87%-- do_nanosleep
                           |          hrtimer_nanosleep
                           |          sys_nanosleep
                           |          system_call_fastpath
                           |
                            --3.88%-- pipe_wait
                                      pipe_read
                                      do_sync_read
                                      vfs_read
                                      sys_read
                                      system_call_fastpath

We still have the issue that per-process profiling doesn't work.

  -Arun

--------------000109090104020802000900
Content-Type: text/plain; x-mac-type=0; x-mac-creator=0;
	name="0001-Use-delay-instead-of-sample-period.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-Use-delay-instead-of-sample-period.patch"

RnJvbSBhMmQ2ZTA2OThlZWJiMDM4YjJkOGU4NDUxMzcwMDhkYzM0NzhjYzUxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIFNoYXJtYSA8YXNoYXJtYUBmYi5jb20+CkRh
dGU6IFRodSwgNiBPY3QgMjAxMSAxNjo0ODo0NCAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIFVz
ZSBkZWxheSBpbnN0ZWFkIG9mIHNhbXBsZS0+cGVyaW9kCgotLS0KIHRvb2xzL3BlcmYvYnVp
bHRpbi1yZXBvcnQuYyAgICAgICAgIHwgICAgNiArKysrKysKIHRvb2xzL3BlcmYvdXRpbC9w
cm9iZS1maW5kZXIuYyAgICAgIHwgICAgNiArKysrLS0KIHRvb2xzL3BlcmYvdXRpbC90cmFj
ZS1ldmVudC1wYXJzZS5jIHwgICAyMCArKysrKysrKysrKysrKysrKysrKwogdG9vbHMvcGVy
Zi91dGlsL3RyYWNlLWV2ZW50LmggICAgICAgfCAgICAxICsKIDQgZmlsZXMgY2hhbmdlZCwg
MzEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90b29scy9w
ZXJmL2J1aWx0aW4tcmVwb3J0LmMgYi90b29scy9wZXJmL2J1aWx0aW4tcmVwb3J0LmMKaW5k
ZXggZDdmZjI3Ny4uNjgyMTU5NyAxMDA2NDQKLS0tIGEvdG9vbHMvcGVyZi9idWlsdGluLXJl
cG9ydC5jCisrKyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi1yZXBvcnQuYwpAQCAtMjUsNiArMjUs
NyBAQAogI2luY2x1ZGUgInV0aWwvZXZzZWwuaCIKICNpbmNsdWRlICJ1dGlsL2hlYWRlci5o
IgogI2luY2x1ZGUgInV0aWwvc2Vzc2lvbi5oIgorI2luY2x1ZGUgInV0aWwvdHJhY2UtZXZl
bnQuaCIKIAogI2luY2x1ZGUgInV0aWwvcGFyc2Utb3B0aW9ucy5oIgogI2luY2x1ZGUgInV0
aWwvcGFyc2UtZXZlbnRzLmgiCkBAIC0xMTEsNiArMTEyLDExIEBAIHN0YXRpYyBpbnQgcHJv
Y2Vzc19zYW1wbGVfZXZlbnQodW5pb24gcGVyZl9ldmVudCAqZXZlbnQsCiAJCQkJc3RydWN0
IHBlcmZfc2Vzc2lvbiAqc2Vzc2lvbikKIHsKIAlzdHJ1Y3QgYWRkcl9sb2NhdGlvbiBhbDsK
KwlzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICphdHRyID0gJmV2c2VsLT5hdHRyOworICAgICAg
ICAgICAgICAKKwlpZiAoYXR0ci0+dHlwZSA9PSBQRVJGX1RZUEVfVFJBQ0VQT0lOVCkgeyAK
KwkJc2FtcGxlLT5wZXJpb2QgPSB0cmFjZV9nZXRfZGVsYXkoc2FtcGxlLT5yYXdfZGF0YSwg
c2FtcGxlLT5yYXdfc2l6ZSk7CisJfQogCiAJaWYgKHBlcmZfZXZlbnRfX3ByZXByb2Nlc3Nf
c2FtcGxlKGV2ZW50LCBzZXNzaW9uLCAmYWwsIHNhbXBsZSwKIAkJCQkJICBhbm5vdGF0ZV9p
bml0KSA8IDApIHsKZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9wcm9iZS1maW5kZXIu
YyBiL3Rvb2xzL3BlcmYvdXRpbC9wcm9iZS1maW5kZXIuYwppbmRleCA1ZDczMjYyLi5lNzE3
OWZmIDEwMDY0NAotLS0gYS90b29scy9wZXJmL3V0aWwvcHJvYmUtZmluZGVyLmMKKysrIGIv
dG9vbHMvcGVyZi91dGlsL3Byb2JlLWZpbmRlci5jCkBAIC0xOSw5ICsxOSwxMSBAQAogICoK
ICAqLwogCisjZGVmaW5lIF9HTlVfU09VUkNFCiAjaW5jbHVkZSA8c3lzL3V0c25hbWUuaD4K
ICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KICNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1
ZGUgPGN0eXBlLmg+CiAjaW5jbHVkZSA8ZmNudGwuaD4KICNpbmNsdWRlIDxlcnJuby5oPgog
I2luY2x1ZGUgPHN0ZGlvLmg+CkBAIC0zMCwxMyArMzIsMTMgQEAKICNpbmNsdWRlIDxzdGRs
aWIuaD4KICNpbmNsdWRlIDxzdHJpbmcuaD4KICNpbmNsdWRlIDxzdGRhcmcuaD4KLSNpbmNs
dWRlIDxjdHlwZS5oPgogI2luY2x1ZGUgPGR3YXJmLXJlZ3MuaD4KKyN1bmRlZiBfR05VX1NP
VVJDRQogCiAjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+CisjaW5jbHVkZSAidXRpbC5oIgog
I2luY2x1ZGUgImV2ZW50LmgiCiAjaW5jbHVkZSAiZGVidWcuaCIKLSNpbmNsdWRlICJ1dGls
LmgiCiAjaW5jbHVkZSAic3ltYm9sLmgiCiAjaW5jbHVkZSAicHJvYmUtZmluZGVyLmgiCiAK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC90cmFjZS1ldmVudC1wYXJzZS5jIGIvdG9v
bHMvcGVyZi91dGlsL3RyYWNlLWV2ZW50LXBhcnNlLmMKaW5kZXggMGE3ZWQ1Yi4uNzhiNzE5
NCAxMDA2NDQKLS0tIGEvdG9vbHMvcGVyZi91dGlsL3RyYWNlLWV2ZW50LXBhcnNlLmMKKysr
IGIvdG9vbHMvcGVyZi91dGlsL3RyYWNlLWV2ZW50LXBhcnNlLmMKQEAgLTI5NDQsNiArMjk0
NCwyNiBAQCB2b2lkIHByaW50X3RyYWNlX2V2ZW50KGludCBjcHUsIHZvaWQgKmRhdGEsIGlu
dCBzaXplKQogCXByZXR0eV9wcmludChkYXRhLCBzaXplLCBldmVudCk7CiB9CiAKK3NpemVf
dCB0cmFjZV9nZXRfZGVsYXkodm9pZCAqZGF0YSwgaW50IHNpemUgX191bnVzZWQpCit7CisJ
c3RydWN0IGV2ZW50ICpldmVudDsKKwlpbnQgdHlwZTsKKwlzdHJ1Y3QgZm9ybWF0X2ZpZWxk
ICpmaWVsZDsKKworCXR5cGUgPSB0cmFjZV9wYXJzZV9jb21tb25fdHlwZShkYXRhKTsKKwor
CWV2ZW50ID0gdHJhY2VfZmluZF9ldmVudCh0eXBlKTsKKwlpZiAoIWV2ZW50KSB7CisJCXdh
cm5pbmcoInVnISBubyBldmVudCBmb3VuZCBmb3IgdHlwZSAlZCIsIHR5cGUpOworCQlyZXR1
cm4gMDsKKwl9CisKKwlmaWVsZCA9IGZpbmRfZmllbGQoZXZlbnQsICJkZWxheSIpOworCWlm
ICghZmllbGQpCisJCWRpZSgiY2FuJ3QgZmluZCBkZWxheSBmaWVsZCBpbiB0cmFjZSIpOwor
CXJldHVybiByZWFkX3NpemUoZGF0YSArIGZpZWxkLT5vZmZzZXQsIGZpZWxkLT5zaXplKTsK
K30KKwogc3RhdGljIHZvaWQgcHJpbnRfZmllbGRzKHN0cnVjdCBwcmludF9mbGFnX3N5bSAq
ZmllbGQpCiB7CiAJcHJpbnRmKCJ7ICVzLCAlcyB9IiwgZmllbGQtPnZhbHVlLCBmaWVsZC0+
c3RyKTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC90cmFjZS1ldmVudC5oIGIvdG9v
bHMvcGVyZi91dGlsL3RyYWNlLWV2ZW50LmgKaW5kZXggZjY3NGRkYS4uNTg3YjU1MyAxMDA2
NDQKLS0tIGEvdG9vbHMvcGVyZi91dGlsL3RyYWNlLWV2ZW50LmgKKysrIGIvdG9vbHMvcGVy
Zi91dGlsL3RyYWNlLWV2ZW50LmgKQEAgLTI2NCw2ICsyNjQsNyBAQCB1bnNpZ25lZCBsb25n
IGxvbmcgZXZhbF9mbGFnKGNvbnN0IGNoYXIgKmZsYWcpOwogCiBpbnQgcmVhZF90cmFjaW5n
X2RhdGEoaW50IGZkLCBzdHJ1Y3QgbGlzdF9oZWFkICpwYXR0cnMpOwogc3NpemVfdCByZWFk
X3RyYWNpbmdfZGF0YV9zaXplKGludCBmZCwgc3RydWN0IGxpc3RfaGVhZCAqcGF0dHJzKTsK
K3NpemVfdCB0cmFjZV9nZXRfZGVsYXkodm9pZCAqZGF0YSwgaW50IHNpemUpOwogCiAvKiB0
YWtlbiBmcm9tIGtlcm5lbC90cmFjZS90cmFjZS5oICovCiBlbnVtIHRyYWNlX2ZsYWdfdHlw
ZSB7Ci0tIAoxLjcuNAoK
--------------000109090104020802000900--
