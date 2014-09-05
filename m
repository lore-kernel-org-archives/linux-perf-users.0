From: Tong Shen <endlessroad@google.com>
Subject: Fix Symbol Address for ET_DYN
Date: Fri, 5 Sep 2014 11:38:02 -0700
Message-ID: <CAPp4yYwTHbXiypxR_1WJGS9DYQNJ24t_Ykdo_sfQ48Ak-K3Z7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e01294f66e316c4050255c441
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:62435 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaIESiD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 5 Sep 2014 14:38:03 -0400
Received: by mail-qc0-f179.google.com with SMTP id l6so12839488qcy.10
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Sep 2014 11:38:02 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

--089e01294f66e316c4050255c441
Content-Type: text/plain; charset=UTF-8

Hi linux-perf-users,

It's actually a patch, and I didn't find a development mailing list
for perf, so I just post it here. If this is not the right place to
post patches, could someone direct me to it? Thanks in advance!

In tools/perf/util/symbol-elf.c, we don't adjust symbol address for
ET_DYN type of ELF files because we think ET_DYN is always
relocatable.

But that's not necessarily true; there are some non-relocatable ET_DYN
ELF files. For those files, we should still adjust symbol address.

Suggested patch attached.

Thanks.

-- 
Best Regards, Tong Shen

--089e01294f66e316c4050255c441
Content-Type: text/x-patch; charset=US-ASCII; name="perf.patch"
Content-Disposition: attachment; filename="perf.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzpv7s5w0

SGkgbGludXgtcGVyZi11c2VycywKCkl0J3MgYWN0dWFsbHkgYSBwYXRjaCwgYW5kIEkgZGlkbid0
IGZpbmQgYSBkZXZlbG9wbWVudCBtYWlsaW5nIGxpc3QgZm9yIHBlcmYsIHNvIEkganVzdCBwb3N0
IGl0IGhlcmUuIElmIHRoaXMgaXMgbm90IHRoZSByaWdodCBwbGFjZSB0byBwb3N0IHBhdGNoZXMs
IGNvdWxkIHNvbWVvbmUgZGlyZWN0IG1lIHRvIGl0PyBUaGFua3MgaW4gYWR2YW5jZSEKCkluIHRv
b2xzL3BlcmYvdXRpbC9zeW1ib2wtZWxmLmMsIHdlIGRvbid0IGFkanVzdCBzeW1ib2wgYWRkcmVz
cyBmb3IgRVRfRFlOIHR5cGUgb2YgRUxGIGZpbGVzIGJlY2F1c2Ugd2UgdGhpbmsgRVRfRFlOIGlz
IGFsd2F5cyByZWxvY2F0YWJsZS4KCkJ1dCB0aGF0J3Mgbm90IG5lY2Vzc2FyaWx5IHRydWU7IHRo
ZXJlIGFyZSBzb21lIG5vbi1yZWxvY2F0YWJsZSBFVF9EWU4gRUxGIGZpbGVzLiBGb3IgdGhvc2Ug
ZmlsZXMsIHdlIHNob3VsZCBzdGlsbCBhZGp1c3Qgc3ltYm9sIGFkZHJlc3MuCgpUaGFua3MuCgpT
dWdnZXN0ZWQgcGF0Y2g6IChIVE1MIHN1YnBhcnQgbm93IGFsbG93ZWQgaW4gdGhpcyBtYWlsaW5n
IGxpc3QuLi4pCgpkaWZmIC0tZ2l0IGEvcGVyZi0zLjEyLjAvdG9vbHMvcGVyZi91dGlsL3N5bWJv
bC1lbGYuYyBiL3BlcmYtMy4xMi4wL3Rvb2xzL3BlcmYvdXRpbC9zeW1ib2wtZWxmLmMKaW5kZXgg
YTljODI5Yi4uMDYwNmM2ZiAxMDA2NDQKLS0tIGEvcGVyZi0zLjEyLjAvdG9vbHMvcGVyZi91dGls
L3N5bWJvbC1lbGYuYworKysgYi9wZXJmLTMuMTIuMC90b29scy9wZXJmL3V0aWwvc3ltYm9sLWVs
Zi5jCkBAIC05MTUsNyArOTE1LDEwIEBAIGludCBkc29fX2xvYWRfc3ltKHN0cnVjdCBkc28gKmRz
bywgc3RydWN0IG1hcCAqbWFwLAogCQl9CiAKIAkJaWYgKCh1c2VkX29wZCAmJiBydW50aW1lX3Nz
LT5hZGp1c3Rfc3ltYm9scykKLQkJCQl8fCAoIXVzZWRfb3BkICYmIHN5bXNfc3MtPmFkanVzdF9z
eW1ib2xzKSkgeworCQkJCXx8ICghdXNlZF9vcGQgJiYgc3ltc19zcy0+YWRqdXN0X3N5bWJvbHMp
CisJCQkJfHwgKHN5bXNfc3MtPmVoZHIuZV90eXBlID09IEVUX0RZTgorCQkJCQkmJiBzaGRyLnNo
X2FkZHIgIT0gc2hkci5zaF9vZmZzZXQKKwkJCQkJJiYgZWxmX3NlY19faXNfdGV4dCgmc2hkciwg
c2Vjc3RycykpKSB7CiAJCQlwcl9kZWJ1ZzQoIiVzOiBhZGp1c3Rpbmcgc3ltYm9sOiBzdF92YWx1
ZTogJSMiIFBSSXg2NCAiICIKIAkJCQkgICJzaF9hZGRyOiAlIyIgUFJJeDY0ICIgc2hfb2Zmc2V0
OiAlIyIgUFJJeDY0ICJcbiIsIF9fZnVuY19fLAogCQkJCSAgKHU2NClzeW0uc3RfdmFsdWUsICh1
NjQpc2hkci5zaF9hZGRyLAo=
--089e01294f66e316c4050255c441--
