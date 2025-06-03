Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E972356C3;
	Tue,  3 Jun 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959415; cv=none; b=ULR0fjBLpD6gi9ngFr9p+V2HlhoxkuQhq3zDxEnwV49UkkjIctJhEnOS4LOvVnnlxA6bFAxlUtrxuWCgUekDGp4UvEX+AVbZMMyICX5ELYtCLeha0cCELEz5zQtKsq2oBFtwpgpODwnsSTQaYBRG1DUndpXlJBfWzg2B9J7olJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959415; c=relaxed/simple;
	bh=pwIE30QMCig7fjCkc2DTK/ld/x9ovYw2kzOaBb+RcWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=pHby0zIrOrtCKL8O131yhsazpqjy6AyTQuqRs+fCTn8XGZnuLClKQpUg7Uaims9oTxC9QDJiwxk2Px+IwXugejXbtY8QmnzJBjOGpQCuRwrspyi/1cFjA34OqwprEntnUZqoO5O8JHuqn0B7EAKtbfGIiIhbickHqYOAW36qSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=PVg/kYSG reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="PVg/kYSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=M7Al/KHLw0HvdtmRejhXZXVdVgs2fxQYH6vUcx0wuok=; b=P
	Vg/kYSGk1uYctobUjzplZZm0geCnR2cqShwYdHE44kyBoL8SyWHBjgq2AhtpPI5c
	N4JFyEgCffW6sOL2Fw2ESaQwIYPdXszFxR138X6p80vSCgpF3sm3gVmD+IdvTbJ9
	QremQwkEwX6G51Q8mxIj7O1q5mf6g58AWcz74ByggM=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-103 (Coremail) ; Tue, 3 Jun 2025 22:02:03 +0800 (CST)
Date: Tue, 3 Jun 2025 22:02:03 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aD77ih5zOrZyXVit@e129823.arm.com>
References: <aD77ih5zOrZyXVit@e129823.arm.com>
X-NTES-SC: AL_Qu2fCvWetksp5SCRZekXn0oTju85XMCzuv8j3YJeN500tSTX4wA4cW9GFHDV986uDAqhoAiVSRNw8OpieZNiVY7Za4YOX4w+fQJuITaH7RjT
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <45723708.beca.197361963d8.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgD3H+JbAD9oJCMTAA--.13866W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkAZhqmg+9NnRwgAHsy
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDMgMjE6NDE6MzAsICJZZW9yZXVtIFl1biIgPHllb3JldW0ueXVuQGFybS5j
b20+IHdyb3RlOgo+SGkgRGF2aWQsCj4KPj4gPgo+PiA+ID4gQnV0IHRvIGZpeCBpdCwgIGlzbid0
IGZvbGxvd2luZyBjaGFuZ2UgbGVzcyBhZ2dyZXNzaXZlPwo+PiA+ID4gICAgICAgICBldmVudF9z
Y2hlZF9vdXQoZXZlbnQsIGN0eCk7Cj4+ID4gPiAtICAgICAgIHBlcmZfZXZlbnRfc2V0X3N0YXRl
KGV2ZW50LCBtaW4oZXZlbnQtPnN0YXRlLCBzdGF0ZSkpOwo+PiA+ID4gICAgICAgICBpZiAoZmxh
Z3MgJiBERVRBQ0hfR1JPVVApCj4+ID4gPiAgICAgICAgICAgICAgICAgcGVyZl9ncm91cF9kZXRh
Y2goZXZlbnQpOwo+PiA+ID4gICAgICAgICBpZiAoZmxhZ3MgJiBERVRBQ0hfQ0hJTEQpCj4+ID4g
PiAgICAgICAgICAgICAgICBwZXJmX2NoaWxkX2RldGFjaChldmVudCk7Cj4+ID4gPiAgICAgICAg
IGxpc3RfZGVsX2V2ZW50KGV2ZW50LCBjdHgpOwo+PiA+ID4gKyAgICAgICBwZXJmX2V2ZW50X3Nl
dF9zdGF0ZShldmVudCwgbWluKGV2ZW50LT5zdGF0ZSwgc3RhdGUpKTsKPj4gPgo+PiA+IElmIHBl
cmZfY2hpbGRfZGV0YWNoKCkgaXMgY2FsbGVkIGZpcnN0IGFuZCBwZXJmX2V2ZW50X3NldF9zdGF0
ZSgpIGNhbGwsCj4+ID4gc2luY2UgdGhlIHBhcmVudCBpcyByZW1vdmVkIGluIHBlcmZfY2hpbGRf
ZGV0YXRjZWQsCj4+ID4gSXQgd291bGQgYmUgZmFpbGVkIHRvIGFjY291bnQgdGhlIHRvdGFsX2Vu
YWJsZV90aW1lIHdoaWNoIGNhY3VsYXRpbmcKPj4gPiBjaGlsZF9ldmVudCdzIGVuYWJsZV90aW1l
IHRvby4KPj4KPj4gVGhhbmtzIGZvciBjbGFyaWZ5aW5nIHRoaXMsCj4+IFNvIHRoZSB3aG9sZSBw
b2ludCAgaW4gY29tbWl0IGEzYzNjNjY2NyBpcyB0byBtYWtlICBwZXJmX2V2ZW50X3NldF9zdGF0
ZSgpIGhhcHBlbnMgYmVmb3JlIHBlcmZfY2hpbGRfZGV0YWNoKCksIHJpZ2h0Pwo+PiBJIGZlZWwg
SSBnb3QgbG9zdCBzb21ld2hlcmUgd2hlbiBJIHJ1c2ggdG8gdGhpcyBzdWdnZXN0aW9uLiBCdXQg
SSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoeSBteSBwYXRjaHYxICBicmVha3MgY29tbWl0Cj4+
IGEzYzNjNjY2NywgcmVhbGx5IGNvbmZ1c2VkLgo+Cj5JIGV4cGxhaW5lZCB0aGlzIGluOgo+ICAg
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzVkMTdmMWQ3LjY2NmQuMTk3MzQ4Yjc4ZDEuQ29y
ZW1haWwuMDAxMDcwODJAMTYzLmNvbS8KPgo+Pj4gSWYgdGhlcmUgaXMgc3BlY2lmaWMgY2hpbGQg
Y3B1IGV2ZW50IHNwZWNpZmllZCBpbiBjcHUgMC4KPj4+ICAgMS4gY3B1IDAgLT4gYWN0aXZlCj4+
PiAgIDIuIHNjaGV1bGRlZCB0byBjcHUxIC0+IGluYWN0aXZlCj4+PiAgIDMuIGNsb3NlIHRoZSBj
cHUgZXZlbnQgZnJvbSBwYXJlbnQgLT4gaW5hY3RpdmUgY2xvc2UKPj4+Cj4+PiBDYW4gYmUgZmFp
bGVkIHRvIGNvdW50IHRvdGFsX2VuYWJsZV90aW1lLgo+Cj4KPkNvbnNpZGVyIG9uZSBldmVudCB3
aGljaCBhdHRhY2hlZCB0byB0YXNrY3R4IHdpdGggc3BlY2lmaWMgY3B1Lgo+SW4gY2FzZSBvZiB5
b3VyIG9yaWdpbmFsIHBhdGNoIGlzIGZvciBvbmx5ICJERVRBQ0hfRVhJVCIgY2FzZS4KPkhlcmUg
d2hhdCBJIG1lYW4sIHRoZSBldmVudCBpcyAiY2xvc2VkIi4KPkluIHRoaXMgY2FzZSwgYmFzZWQg
b24geW91ciBwYXRjaCwgaXQgZG9lc24ndCBjYWxsIHRoZSBwZXJmX2V2ZW50X3NldF9zdGF0ZSgp
Cj5iZWZvcmUgbGlzdF9kZWxfZXZlbnQoKSwgYnV0IHBlcmZfZXZlbnRfc2V0X3N0YXRlKCkgaXMg
Y2FsbGVkIGFmdGVyIGxpc3RfZGVsX2V2ZW50KCkuCgpEbyB5b3UgbWVhbiBpbiB0aGlzIGNhc2Us
IHRoZSBldmVudCBpcyBub3QgcGFzc2VkIHRvIHBlcmZfZXZlbnRfZXhpdF9ldmVudCgpPwpCZWNh
dXNlIGluIG15IG1pbmQsIGFzIGxvbmcgYXMgYSBldmVudCByZWFjaCBwZXJmX2V2ZW50X2V4aXRf
ZXZlbnQsIERFVEFDSF9FWElUIGZsYWcgd291bGQgYWx3YXlzIGJlIHNldC4KcGVyZl9ldmVudF9l
eGl0X2V2ZW50KCkKICAgLS0tPiBwZXJmX3JlbW92ZV9mcm9tX2NvbnRleHQoZXZlbnQsIGRldGFj
aF9mbGFncyB8IERFVEFDSF9FWElUKTsgIDwtLS0KICAgICAgICAgICAgLS0tPiBfX3BlcmZfcmVt
b3ZlX2Zyb21fY29udGV4dAogICAgICAgICAgICAgICAgICAgIC0tLS0+IHBlcmZfZXZlbnRfc2V0
X3N0YXRlICAoREVUQUNIX0VYSVQgaXMgYWx3YXlzIHNldCBpbiB0aGlzIGNhbGwgcGF0aCkKICAg
ICAgICAgICAgICAgICAgICAtLS0tPiBsaXN0X2RlbF9ldmVudAoKU28gSSBhbSBzdGlsbCBjb25m
dXNlZCwgZXZlbiB3aXRoIGNwdSBzd2l0Y2gsIHRoZSBERVRBQ0hfRVhJVCBmbGFnIGlzIHN0aWxs
IHRoZXJlLgpDb3VsZCB5b3UgZXhwbGFpbiBpdCB3aXRoIGEgY2FsbGNoYWluPwoKVGhhbmtzCkRh
dmlkCgo+Cj5UaGFua3MKPgo+LS0KPlNpbmNlcmVseSwKPlllb3JldW0gWXVuCg==
