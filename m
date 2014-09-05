From: Tong Shen <endlessroad@google.com>
Subject: Re: Fix Symbol Address for ET_DYN
Date: Fri, 5 Sep 2014 11:40:01 -0700
Message-ID: <CAPp4yYwhEhmbtKwX6YxgYBT52_3TQhrS-FVYGsTneHD1cbv6sw@mail.gmail.com>
References: <CAPp4yYwTHbXiypxR_1WJGS9DYQNJ24t_Ykdo_sfQ48Ak-K3Z7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11392304fd095d050255cb52
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:52230 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbaIESkC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 5 Sep 2014 14:40:02 -0400
Received: by mail-qa0-f52.google.com with SMTP id f12so11213918qad.39
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Sep 2014 11:40:01 -0700 (PDT)
In-Reply-To: <CAPp4yYwTHbXiypxR_1WJGS9DYQNJ24t_Ykdo_sfQ48Ak-K3Z7g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

--001a11392304fd095d050255cb52
Content-Type: text/plain; charset=UTF-8

Sorry, wrong patch...

On Fri, Sep 5, 2014 at 11:38 AM, Tong Shen <endlessroad@google.com> wrote:
> Hi linux-perf-users,
>
> It's actually a patch, and I didn't find a development mailing list
> for perf, so I just post it here. If this is not the right place to
> post patches, could someone direct me to it? Thanks in advance!
>
> In tools/perf/util/symbol-elf.c, we don't adjust symbol address for
> ET_DYN type of ELF files because we think ET_DYN is always
> relocatable.
>
> But that's not necessarily true; there are some non-relocatable ET_DYN
> ELF files. For those files, we should still adjust symbol address.
>
> Suggested patch attached.
>
> Thanks.
>
> --
> Best Regards, Tong Shen



-- 
Best Regards, Tong Shen

--001a11392304fd095d050255cb52
Content-Type: text/x-patch; charset=US-ASCII; name="perf.patch"
Content-Disposition: attachment; filename="perf.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzpvanod1

ZGlmZiAtLWdpdCBhL3BlcmYtMy4xMi4wL3Rvb2xzL3BlcmYvdXRpbC9zeW1ib2wtZWxmLmMgYi9w
ZXJmLTMuMTIuMC90b29scy9wZXJmL3V0aWwvc3ltYm9sLWVsZi5jCmluZGV4IGE5YzgyOWIuLjA2
MDZjNmYgMTAwNjQ0Ci0tLSBhL3BlcmYtMy4xMi4wL3Rvb2xzL3BlcmYvdXRpbC9zeW1ib2wtZWxm
LmMKKysrIGIvcGVyZi0zLjEyLjAvdG9vbHMvcGVyZi91dGlsL3N5bWJvbC1lbGYuYwpAQCAtOTE1
LDcgKzkxNSwxMCBAQCBpbnQgZHNvX19sb2FkX3N5bShzdHJ1Y3QgZHNvICpkc28sIHN0cnVjdCBt
YXAgKm1hcCwKIAkJfQogCiAJCWlmICgodXNlZF9vcGQgJiYgcnVudGltZV9zcy0+YWRqdXN0X3N5
bWJvbHMpCi0JCQkJfHwgKCF1c2VkX29wZCAmJiBzeW1zX3NzLT5hZGp1c3Rfc3ltYm9scykpIHsK
KwkJCQl8fCAoIXVzZWRfb3BkICYmIHN5bXNfc3MtPmFkanVzdF9zeW1ib2xzKQorCQkJCXx8IChz
eW1zX3NzLT5laGRyLmVfdHlwZSA9PSBFVF9EWU4KKwkJCQkJJiYgc2hkci5zaF9hZGRyICE9IHNo
ZHIuc2hfb2Zmc2V0CisJCQkJCSYmIGVsZl9zZWNfX2lzX3RleHQoJnNoZHIsIHNlY3N0cnMpKSkg
ewogCQkJcHJfZGVidWc0KCIlczogYWRqdXN0aW5nIHN5bWJvbDogc3RfdmFsdWU6ICUjIiBQUkl4
NjQgIiAiCiAJCQkJICAic2hfYWRkcjogJSMiIFBSSXg2NCAiIHNoX29mZnNldDogJSMiIFBSSXg2
NCAiXG4iLCBfX2Z1bmNfXywKIAkJCQkgICh1NjQpc3ltLnN0X3ZhbHVlLCAodTY0KXNoZHIuc2hf
YWRkciwK
--001a11392304fd095d050255cb52--
