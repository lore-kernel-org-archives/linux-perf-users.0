Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CDA17A30B;
	Tue,  3 Jun 2025 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935977; cv=none; b=fg1CjoT6wRCdCPdCne91Ca5U6a5MXq7BFf1o1GLZS+H0Q5BgY/2TFH0SPOPHLbmDRN+L5O0EYxrpgBwggtP9+D9x5OiABjzUKd/2PLc76QV9wwM5SQ1Bikj+Y2z/+BHVgqXWPjHxf1JEUNlxKRI7oAeb//nD0rD1ZOwRwzEsgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935977; c=relaxed/simple;
	bh=UvNxCZi+nmqCK2ifD1WQQyfVWz6NyXvb25aFg6Dz7Aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=pIVBBXQmUboZVrqPdZft8g/XndBldmmZev0Nt0Yx5OjN2POw0m/XX3mx04HW1+42YsmegNuqoFL7tGgSFNksaVddgR3NLN6wbereDO46oVzmvzDRQqFuCBSAlrzaMwi0WFpej4er0wZCkOMyWTM7jN3AiXpQFGFjvzYevCF0Tgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=eYoiMlpH reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="eYoiMlpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NmxBiOt618uk9BNeoRG9umvui5AtXNog1jxGt57zgkQ=; b=e
	YoiMlpHrVAWN6M0Kc4ZfVnRQjf6U/qH0/O0ziZKRp/PmG5xqoFfeKRDwRxq3bpIE
	+MKngU+VN60SpFHYWK6dBV5j9W6HZCw7f4RawMNO50jxCpaW0prCj5N83e2EpuHI
	NgEcW6D3mdD0XCtgO6NAYOK23lOiNBA0R/xOt1fV0M=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Tue, 3 Jun 2025 15:31:36 +0800 (CST)
Date: Tue, 3 Jun 2025 15:31:36 +0800 (CST)
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
In-Reply-To: <aD6hVAuHGNZjrKpr@e129823.arm.com>
References: <aD6hVAuHGNZjrKpr@e129823.arm.com>
X-NTES-SC: AL_Qu2fCvWYukAi4CmQYekZnEYQheY4XMKyuPkg1YJXOp80iCXQ3wodeXBxJkTkwcOOJiWSvxe8aSZS7+RTe4BFYbCiaxmPl0qBfFD6RmcCE3Mw
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4e7a70c2.7539.19734b3ef9f.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgC3X9fapD5oqsESAA--.57356W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gBhqmg+n-RC7QADsI
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDMgMTU6MTY6MzYsICJZZW9yZXVtIFl1biIgPHllb3JldW0ueXVuQGFybS5j
b20+IHdyb3RlOgo+SGkgRGF2aWQsCj4KPj4gPgo+PiA+ID4KPj4gPiA+IEFsc28sIHlvdXIgcGF0
Y2ggY291bGRuJ3Qgc29sdmUgYSBwcm9ibGVtIGRlc2NyaWJlIGluCj4+ID4gPiBjb21taXQgYTNj
M2M2NjY3KCJwZXJmL2NvcmU6IEZpeCBjaGlsZF90b3RhbF90aW1lX2VuYWJsZWQgYWNjb3VudGlu
ZyBidWcgYXQgdGFzayBleGl0IikKPj4gPiA+IGZvciBJTkNBVElWRSBldmVudCdzIHRvdGFsX2Vu
YWJsZV90aW1lLgo+PiA+Cj4+ID4gSSBkbyBub3QgdGhpbmsgc28uCj4+ID4gQ29ycmVjdCBtZSBp
ZiBJIGFtIG1ha2luZyBzaWxseSAgbWlzdGFrZXMsCj4+ID4gVGhlIHBhdGNoLCBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjUwNjAzMDMyNjUxLjM5ODgtMS0wMDEwNzA4MkAxNjMuY29t
Lwo+PiA+IGNhbGxzIHBlcmZfZXZlbnRfc2V0X3N0YXRlKCkgYmFzZWQgb24gREVUQUNIX0VYSVQg
ZmxhZywgd2hpY2ggY292ZXIgdGhlIElOQUNUSVZFIHN0YXRlLCByaWdodD8KPj4gPiBJZiBERVRB
Q0hfRVhJVCBpcyBub3QgdXNlZCBmb3IgdGhpcyBwdXJwb3NlPyBUaGVuIHdoeSBzaG91bGQgaXQg
ZXhpc3QgYXQgdGhlIGZpcnN0IHBsYWNlPwo+PiA+IEkgdGhpbmsgSSBkb2VzIG5vdCByZXZlcnQg
dGhlIHB1cnBvc2Ugb2YgY29tbWl0IGEzYzNjNjY2Ny4uLi4uQnV0IEkgY291bGQgYmUgd3JvbmcK
Pj4gPiBXb3VsZCB5b3Ugc2hvdyBhIGNhbGwgcGF0aCB3aGVyZSBERVRBQ0hfRVhJVCBpcyBub3Qg
c2V0LCBidXQgdGhlIGNoYW5nZXMgaW4gY29tbWl0IGEzYzNjNjY2NyBpcyBzdGlsbCBuZWVkZWQ/
Cj4+ID4KPj4gPiBTb3JyeSBmb3IgbXkgYmFkIGV4cGxhaW5hdGlvbiB3aXRob3V0IGRldGFpbC4K
Pj4gPiBUaGluayBhYm91dCBjcHUgc3BlY2lmaWMgZXZlbnQgYW5kIGNsb3NlZCBieSB0YXNrLgo+
PiA+IElmIHRoZXJlIGlzIHNwZWNpZmljIGNoaWxkIGNwdSBldmVudCBzcGVjaWZpZWQgaW4gY3B1
IDAuCj4+ID4gMS4gY3B1IDAgLT4gYWN0aXZlCj4+ID4gMi4gc2NoZXVsZGVkIHRvIGNwdTEgLT4g
aW5hY3RpdmUKPj4gPiAzLiBjbG9zZSB0aGUgY3B1IGV2ZW50IGZyb20gcGFyZW50IC0+IGluYWN0
aXZlIGNsb3NlCj4+ID4KPj4gPiBDYW4gYmUgZmFpbGVkIHRvIGNvdW50IHRvdGFsX2VuYWJsZV90
aW1lLgo+Pgo+PiBJcyB0aGlzIGV4cGxhaW5pbmcgdGhlIHB1cnBvc2Ugb2YgY29tbWl0IGEzYzNj
NjY2NyA/Cj4+IEkgYW0gbm90IGFyZ3Vpbmcgd2l0aCBpdC4gQW5kIEkgYWxzbyBub3Qgc3VnZ2Vz
dCByZXZlcnRpbmcgaXQuIChpdCBpcyBqdXN0IHRoYXQgcmV2ZXJ0aW5nIGl0IGNhbiBmaXggdGhl
IGtlcm5lbCBwYW5pYy4pCj4KPkluIGNvbW1pdCBhM2MzYzY2NjcsIEkgZXhwbGFpbiB0aGUgc3Bl
Y2lmaWMgY2FzZSBidXQgbm90IHdpdGggYWJvdmUKPmNhc2UuIEJ1dCB0aGUgY29tbWl0J3MgcHVy
cG9zZSBpcyAiYWNjb3VudCB0b3RhbF9lbmFibGVfdGltZSIgcHJvcGVybHkuCj4KPj4gPiBBbmQg
YWxzbywgY29uc2lkZXJpbmcgdGhlIHlvdXIgcGF0Y2gsIGZvciBERVRBQ0hfRVhJVCBjYXNlLAo+
PiA+IElmIGl0IGNoYW5nZXMgdGhlIHN0YXRlIGJlZm9yZSBsaXN0X2RlbF9ldmVudCgpIHRoYXQg
d291bGRuJ3QgZGlzYWJsZQo+PiA+IHJlbGF0ZWQgdG8gdGhlIGNncm91cC4gU28gaXQgd291bGQg
bWFrZSBjcHVjdHgtPmNncnAgcG9pbnRlciBjb3VsZCBiZSBkYW5nbGVkCj4+ID4gYXMgcGF0Y2gg
ZGVzY3JpYmUuLi4KPj4gTm8sIEkgZG9uJ3QgdGhpbmsgc28uCj4+IGNoYW5nZSBzdGF0ZSBiZWZv
cmUgbGlzdF9kZWxfZXZlbnQoKSwgdGhpcyBpcyB0aGUgc2FtZSBiZWhhdmlvciBiZWZvcmUgY29t
bWl0IGEzYzNjNjY2NywgcmlnaHQ/Cj4+IEFuZCBubyBzdWNoIGtlcm5lbCBwYW5pYyBoYXBwZW5l
ZCAgYmVmb3JlIGNvbW1pdCBhM2MzYzY2NjcuCj4KPlRoYXQncyB3aHkgbGlzdF9kZWxfZXZlbnQo
KSBoYW5kbGUgdGhlIHBlcmZfY2dyb3VwX2Rpc2FibGUoKSBiZWZvcmUgdGhlCj5jb21taXQgYTNj
M2M2NjY3LiBIb3dldmVyIGJlY2F1c2Ugb2YgKm15IG1pc3Rha2UqLCBJJ3ZlIGZvcmdldCB0bwo+
cGVyZl9jZ3JvdXBfZGlzYWJsZSgpIHByb3Blcmx5IGJlZm9yZSBjaGFuZ2UgdGhlIGV2ZW50IHN0
YXRlLgo+WWVzLCB5b3VyIHBhdGNoIGNhbiBtYWtlIGF2b2lkIHRoZSBwYW5pYyBzaW5jZSBhcyBz
b29uIGFzIGV4aXQsCj50aGUgZXZlbnQtPmNncnAgc3dpdGNoZWQuCj4KPkhvd2V2ZXIsIGFzIEkg
c2FpZCwgdGhlIElOQUNUSVZFIGV2ZW50IGNvdWxkIGJlIGZhaWxlZCB0byBjb3VudAo+dG90YWxf
ZW5hYmxlX3RpbWUuCgpUaGlzIHRpbWUsIHlvdSBtZWFuIG15IHBhdGNoLCByaWdodD8KU3RpbGwg
aGF2ZSB0cm91YmxlIHVuZGVyc3RhbmQgdGhpcy4gTXkgcGF0Y2ggZG9zZSBub3QgY2hhbmdlIHRo
ZSBsb2dpYyBhbG9uZyAgREVUQUNIX0VYSVQgYXQgYWxsLgpDb3VsZCB5b3UgZWxhYm9yYXRlIG9u
IGl0IG1vcmU/IFdoYXQgY2hhbmdlIG15IHBhdGNoIG1hZGUgdG8gYnJlYWsgY29tbWl0ICBhM2Mz
YzY2Njc/CihIb3BlIHlvdSBhcmUgbm90IHN0aWxsIHRhbGtpbmcgdGhlIHB1cnBvc2Ugb2YgY29t
bWl0IGEzYzNjNjY2NykKCj4KPlNvLCBzZXQgZXZlbnQgc2hvdWxkIGJlIG9jY3VyZWQgYmVmb3Jl
IGxpc3RfZGVsX2V2ZW50KCkuCj5BbmQgc2luY2UgaXQncyBldmVudC0+c3RhdGUgY2hhbmdlIG9u
IHJlbW92ZS4KPkl0IHNob3VsZG4ndCBoYXZlIGFueSBzaWRlIGVmZmVjdCB0aGUgc3RhdGUgY2hh
bmdlIGlzbid0IGNhdXNlIG9mIHlvdXIKPnBhbmljLiBCdXQgbWlzc2VkIHBlcmZfY2dyb3VwX2Rp
c2FibGUoKS4KCkkgbWF5IHVuZGVyc3RhbmQgaXQgd3JvbmcsIGJ1dCBJIHRoaW5rIHRoZSBrZXJu
ZWwgcGFuaWMgaXMgY2F1c2VkIGJ5IG1pc3NpbmcgCnBlcmZfY2dyb3VwX2V2ZW50X2Rpc2FibGUo
KSwgCndoZW4gcmVib290L3NodXRkb3duLCBrZXJuZWwgd2VyZSB3YWl0aW5nIGNncm91cCBjdHgg
cmVmZXJlbmNlIGRyb3AgdG8gMCwgZm9yIGV2ZXIsIGFuZCBoZW5jZSB0aGUgcGFuaWMuCgoKCgo+
Cj5UaGFua3MuCj4tLQo+U2luY2VyZWx5LAo+WWVvcmV1bSBZdW4K
