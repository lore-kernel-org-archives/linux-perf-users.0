From: Tong Shen <endlessroad@google.com>
Subject: Re: Fix Symbol Address for ET_DYN
Date: Thu, 11 Sep 2014 11:21:40 -0700
Message-ID: <CAPp4yYzRwoTBzH1_TwcdvAOryZppV9-BwnX2bOtN1qrEqrdBww@mail.gmail.com>
References: <CAPp4yYwTHbXiypxR_1WJGS9DYQNJ24t_Ykdo_sfQ48Ak-K3Z7g@mail.gmail.com>
	<20140911150123.GH10158@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c2a3ec772baa0502ce3d32
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:38807 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaIKSVn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 11 Sep 2014 14:21:43 -0400
Received: by mail-qg0-f49.google.com with SMTP id j5so7819637qga.36
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2014 11:21:42 -0700 (PDT)
In-Reply-To: <20140911150123.GH10158@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org

--001a11c2a3ec772baa0502ce3d32
Content-Type: text/plain; charset=UTF-8

Hi Arnaldo,

Thanks a lot for the comment!

I fixed the coding style and added a helper function with comments, as
you suggested :-)
See attachment.

On Thu, Sep 11, 2014 at 8:01 AM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Fri, Sep 05, 2014 at 11:38:02AM -0700, Tong Shen escreveu:
>> Hi linux-perf-users,
>>
>> It's actually a patch, and I didn't find a development mailing list
>> for perf, so I just post it here. If this is not the right place to
>
> You can post it here, but please add the maintainers to the CC list, so
> that we can more quickly see your message.
>
> Comments below:
>
>> post patches, could someone direct me to it? Thanks in advance!
>>
>> In tools/perf/util/symbol-elf.c, we don't adjust symbol address for
>> ET_DYN type of ELF files because we think ET_DYN is always
>> relocatable.
>>
>> But that's not necessarily true; there are some non-relocatable ET_DYN
>> ELF files. For those files, we should still adjust symbol address.
>
>> Suggested patch: (HTML subpart now allowed in this mailing list...)
>
>> +++ b/perf-3.12.0/tools/perf/util/symbol-elf.c
>> @@ -915,7 +915,10 @@ int dso__load_sym(struct dso *dso, struct map *map,
>
>>               if ((used_opd && runtime_ss->adjust_symbols)
>> -                             || (!used_opd && syms_ss->adjust_symbols)) {
>> +                             || (!used_opd && syms_ss->adjust_symbols)
>> +                             || (syms_ss->ehdr.e_type == et_dyn
>> +                                     && shdr.sh_addr != shdr.sh_offset
>> +                                     && elf_sec__is_text(&shdr, secstrs))) {
>
> Please try to follow kernel coding style in these tools, i.e. the &&
> should be at the end, the expression on each line should be aligned just
> after the opening parens.
>
> If, like in this case, you find something not following that style, take
> the opportunity to fix it :-)
>
> But back to your change, I'll have to look at this code further, just
> looking at the excerpt above I find it way too confusing, and your patch
> makes it even more so...
>
> Can you introduce some suitably named helper that has those extra
> conditions you're adding now and then add it to this conditional?
>
> I.e. make it somethine like:
>
> -               if ((used_opd && runtime_ss->adjust_symbols)
> -                               || (!used_opd && syms_ss->adjust_symbols)) {
> +               if ((used_opd && runtime_ss->adjust_symbols) ||
> +                   (!used_opd && syms_ss->adjust_symbols)   ||
> +                   syms__some_suitable_name(syms_ss, &shdr)) {
>
> And then add your explanation of these kinds of files as a comment over
> this new function, please?
>
>>                       pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
>>                                 "sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n", __func__,
>>                                 (u64)sym.st_value, (u64)shdr.sh_addr,
>
> Best regards,
>
> - Arnaldo



-- 
Best Regards, Tong Shen

--001a11c2a3ec772baa0502ce3d32
Content-Type: text/x-patch; charset=US-ASCII; name="perf.patch"
Content-Disposition: attachment; filename="perf.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzyfa5hy0

ZGlmZiAtLWdpdCBhL3BlcmYtMy4xMi4wL3Rvb2xzL3BlcmYvdXRpbC9zeW1ib2wtZWxmLmMgYi9w
ZXJmLTMuMTIuMC90b29scy9wZXJmL3V0aWwvc3ltYm9sLWVsZi5jCmluZGV4IGE5YzgyOWIuLmY5
YmQ0ODggMTAwNjQ0Ci0tLSBhL3BlcmYtMy4xMi4wL3Rvb2xzL3BlcmYvdXRpbC9zeW1ib2wtZWxm
LmMKKysrIGIvcGVyZi0zLjEyLjAvdG9vbHMvcGVyZi91dGlsL3N5bWJvbC1lbGYuYwpAQCAtNjcz
LDYgKzY3MywyNyBAQCBzdGF0aWMgdTY0IHJlZl9yZWxvYyhzdHJ1Y3Qga21hcCAqa21hcCkKIAly
ZXR1cm4gMDsKIH0KIAorLyoqCisgKiBpc19ub25fcmVsb2NhdGFibGVfZHluIC0gY2hlY2sgaWYg
RUxGIGZpbGUgaXMgRVRfRFlOLCBidXQgbm90IHJlbG9jYXRhYmxlCisgKiBAZWhkcjogRUxGIGhl
YWRlciBvZiB0aGUgRUxGIGZpbGUKKyAqIEBzaGRyOiBhIHNlY3Rpb24gaGVhZGVyIGluIHRoZSBF
TEYgZmlsZQorICoKKyAqIEZvciBFTEYgZmlsZXMgd2l0aCB0eXBlIEVUX0VYRUMgYW5kIEVUX1JF
TCwgd2UgYWRqdXN0IHN5bWJvbCBhZGRyZXNzZXMgaW4KKyAqIHN5bWJvbCB0YWJsZSBpbiBkc29f
X2xvYWRfc3ltKCkgc28gdGhhdCBsYXRlciB3ZSBjYW4gYWx3YXlzIGxvY2F0ZSBzeW1ib2xzCisg
KiBieSBzeW0uc3RfdmFsdWUgKyBtYXBfYWRkcmVzc19vZl9FTEZfZmlsZS4KKyAqCisgKiBCdXQg
RUxGIGZpbGVzIHdpdGggdHlwZSBFVF9EWU4gbWF5IG5lZWQgYWRqdXN0aW5nIGFzIHdlbGwsIGlm
IHRoZXkgYXJlCisgKiBub3QgcmVsb2NhdGFibGUuIFRoZXJlJ3Mgbm8gc3RhbmRhcmQgd2F5IHRv
IHRlbGwgaWYgYW4gRUxGIGZpbGUgd2l0aCB0eXBlCisgKiBFVF9EWU4gaXMgcmVsb2NhdGFibGUu
IE9uZSBwb3NzaWJsZSB3YXkgdG8gZG8gdGhhdCBpcyBjaGVja2luZyBpZgorICogc2hfYWRkciA9
PSBzaF9vZmZzZXQgZm9yIC50ZXh0IHNlY3Rpb24uCisgKi8KK3N0YXRpYyBib29sIGlzX25vbl9y
ZWxvY2F0YWJsZV9keW4oR0VsZl9FaGRyICplaGRyLCBHRWxmX1NoZHIgKnNoZHIsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVsZl9EYXRhICpzZWNzdHJzKSB7CisJcmV0dXJu
IGVoZHItPmVfdHlwZSA9PSBFVF9EWU4gJiYKKwkgICAgICAgZWxmX3NlY19faXNfdGV4dChzaGRy
LCBzZWNzdHJzKSAmJgorCSAgICAgICBzaGRyLT5zaF9vZmZzZXQgIT0gc2hkci0+c2hfYWRkcjsK
K30KKwogaW50IGRzb19fbG9hZF9zeW0oc3RydWN0IGRzbyAqZHNvLCBzdHJ1Y3QgbWFwICptYXAs
CiAJCSAgc3RydWN0IHN5bXNyYyAqc3ltc19zcywgc3RydWN0IHN5bXNyYyAqcnVudGltZV9zcywK
IAkJICBzeW1ib2xfZmlsdGVyX3QgZmlsdGVyLCBpbnQga21vZHVsZSkKQEAgLTkxNCw4ICs5MzUs
OSBAQCBpbnQgZHNvX19sb2FkX3N5bShzdHJ1Y3QgZHNvICpkc28sIHN0cnVjdCBtYXAgKm1hcCwK
IAkJCWdvdG8gbmV3X3N5bWJvbDsKIAkJfQogCi0JCWlmICgodXNlZF9vcGQgJiYgcnVudGltZV9z
cy0+YWRqdXN0X3N5bWJvbHMpCi0JCQkJfHwgKCF1c2VkX29wZCAmJiBzeW1zX3NzLT5hZGp1c3Rf
c3ltYm9scykpIHsKKwkJaWYgKCh1c2VkX29wZCAmJiBydW50aW1lX3NzLT5hZGp1c3Rfc3ltYm9s
cykgfHwKKwkJICAgICghdXNlZF9vcGQgJiYgc3ltc19zcy0+YWRqdXN0X3N5bWJvbHMpIHx8CisJ
CSAgICBpc19ub25fcmVsb2NhdGFibGVfZHluKCZlaGRyLCAmc2hkciwgc2Vjc3RycykpIHsKIAkJ
CXByX2RlYnVnNCgiJXM6IGFkanVzdGluZyBzeW1ib2w6IHN0X3ZhbHVlOiAlIyIgUFJJeDY0ICIg
IgogCQkJCSAgInNoX2FkZHI6ICUjIiBQUkl4NjQgIiBzaF9vZmZzZXQ6ICUjIiBQUkl4NjQgIlxu
IiwgX19mdW5jX18sCiAJCQkJICAodTY0KXN5bS5zdF92YWx1ZSwgKHU2NClzaGRyLnNoX2FkZHIs
Cg==
--001a11c2a3ec772baa0502ce3d32--
