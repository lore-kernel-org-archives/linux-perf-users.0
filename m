Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F221F5434;
	Tue,  3 Jun 2025 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933031; cv=none; b=fLjrUWg28OVfxDcqK0cspNboTOpRQuH+3QmhMFNtjQUV2djiO0qdZQCkaJKBzhL90FRFzhPyof5g5RLx62I25WxaY5GH+y7KtAWE8XNgAuVQQgNXnYEjpHqCWDeaG7tlO+aEJM80vr78mFN5ZTTHKVTjc1nGxDkJPHMh7+KSmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933031; c=relaxed/simple;
	bh=Y7/rdOvJv+OyFP6IYlnGIXp9XhL0vcnUkspyUuCL/4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IBXJhKSSZT29eyHS/yKb62+OZ3ZRfxHQNHhClrPVG6Wc5TAD1Ay0IV+0zwk/NyxB4KDN84conP8VGL9X5O233PcT9A6ILoPybnjfnv33pVNBTsLtZS/wok2o/aiGJgug6Kd0momznNkP1LK8Kr1yAO0LHYvxEIBQBrTIO2chCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=W7o39eNJ reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="W7o39eNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NJzwztshk1K+O6yW7svw0/bxaRb7Clc2JFqcaILc+gQ=; b=W
	7o39eNJ0dHesCweDEyUIAbyICpcLV63JhdQLMJqpedVSCXttBfNWV8NUVItQdxDW
	c3y3ZvnopV/SC3CUndBlVovKd/xDL7hgKEGcQ9H1QclBBYGnEuRjuY4eLJiTX41P
	DoI8Bmo4f0yXVMChkdfpFqFgyn8pdHf7CfctrE36KI=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Tue, 3 Jun 2025 14:42:50 +0800 (CST)
Date: Tue, 3 Jun 2025 14:42:50 +0800 (CST)
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
In-Reply-To: <aD6Xk2rdBjnVy6DA@e129823.arm.com>
References: <aD6Xk2rdBjnVy6DA@e129823.arm.com>
X-NTES-SC: AL_Qu2fCvWYvUEs5iCeZ+kZnEYQheY4XMKyuPkg1YJXOp80iCXQ3wodeXBxJkTkwcOOJiWSvxe8aSZS7+RTe4BFYbCc4d9Jz2f4Rj+jg9I0Cwlc
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4939eff.64be.19734874658.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgDHr9prmT5ov6oSAA--.26836W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkBJhqmg+kwHr9AADsR
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDMgMTQ6MzQ6NTksICJZZW9yZXVtIFl1biIgPHllb3JldW0ueXVuQGFybS5j
b20+IHdyb3RlOgo+SGkgRGF2aWQsCj4+ID4gYXR0YWNoX3N0YXRlIGRvZXNuJ3QgcmVsYXRlZCBm
b3IgZXZlbnQtPnN0YXRlIGNoYW5nZS4KPj4gPiBpZiBvbmUgZXZlbnQgYWxyZWFkeSBjbGVhcmVk
IFBFUkZfQVRUQUNIX0NPTlRFWFQsIHRoYXQgZXZlbnQgaXMgY2FsbGVkCj4+ID4gdmlhIGxpc3Rf
ZGVsX2V2ZW50KCkKPj4KPj4gTWF5YmUgdGhpcyBjb25jZXJuIGNvdWxkIGJlIGNsYXJpZmllZCwg
d2hhdCBhYm91dCBvdGhlciBzdWJ0bGUgaW1wYWN0cy4KPj4gVGhlIGNoYW5nZSBzaG91bGQgYmUg
dGhvcm91Z2ggcmV2aWV3ZWQsIGlmIHlvdSB3YW50IHRvIHB1c2ggaXQgZnVydGhlci4KPj4KPj4g
SXQgdGFrZXMgbWUgbW9yZSB0aGFuIGEgbW9udGggdG8gZmlndXJlIG91dCBhIHByb2NlZHVyZSB0
byByZXByb2R1Y2UgdGhlIGtlcm5lbCBwYW5pYyBidWcsCj4+IEl0IGlzICBqdXN0IHZlcnkgaGFy
ZCB0byBjYXB0dXJlIGEgYnVnIGhhcHBlbnMgaW4gcmFyZSBzaXR1YXRpb24uCj4+Cj4+IEFuZCB5
b3VyIHBhdGNoIGhhcyBhIGdsb2JhbCBpbXBhY3QsIGl0IGNoYW5nZXMgYmVoYXZpb3IgdW5uZWNl
c3NhcmlseS4KPgo+VEJILCB0aGlzIHBhdGNoIGp1c3QgY2hhbmdlIG9mIHRpbWUgb2YgImV2ZW50
LT5zdGF0ZSIgd2hpbGUgZG9pbmcsCj5BcyBteSBiYWQgbWlzcyB0aGUgZGlzYWJsZSBjZ29ydXAg
cGVyZi4KPkkgdGhpbmsgdGhlcmUgc2VlbXMgbm8gb3RoZXIgc2lkZSBlZmZlY3QgZm9yIGNoYW5p
bmcgc3RhdGUgd2hpbGUgaW4KPnJlbW92aW5nIGV2ZW50Lgo+QnV0LCBMZXQncyB3YWl0IGZvciBv
dGhlciBwZW9wbGUncyByZXZpZXcuCj4KPj4gPgo+PiA+IEFsc28sIHlvdXIgcGF0Y2ggY291bGRu
J3Qgc29sdmUgYSBwcm9ibGVtIGRlc2NyaWJlIGluCj4+ID4gY29tbWl0IGEzYzNjNjY2NygicGVy
Zi9jb3JlOiBGaXggY2hpbGRfdG90YWxfdGltZV9lbmFibGVkIGFjY291bnRpbmcgYnVnIGF0IHRh
c2sgZXhpdCIpCj4+ID4gZm9yIElOQ0FUSVZFIGV2ZW50J3MgdG90YWxfZW5hYmxlX3RpbWUuCj4+
Cj4+IEkgZG8gbm90IHRoaW5rIHNvLgo+PiBDb3JyZWN0IG1lIGlmIEkgYW0gbWFraW5nIHNpbGx5
ICBtaXN0YWtlcywKPj4gVGhlIHBhdGNoLCBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MjUwNjAzMDMyNjUxLjM5ODgtMS0wMDEwNzA4MkAxNjMuY29tLwo+PiBjYWxscyBwZXJmX2V2ZW50
X3NldF9zdGF0ZSgpIGJhc2VkIG9uIERFVEFDSF9FWElUIGZsYWcsIHdoaWNoIGNvdmVyIHRoZSBJ
TkFDVElWRSBzdGF0ZSwgcmlnaHQ/Cj4+IElmIERFVEFDSF9FWElUIGlzIG5vdCB1c2VkIGZvciB0
aGlzIHB1cnBvc2U/IFRoZW4gd2h5IHNob3VsZCBpdCBleGlzdCBhdCB0aGUgZmlyc3QgcGxhY2U/
Cj4+IEkgdGhpbmsgSSBkb2VzIG5vdCByZXZlcnQgdGhlIHB1cnBvc2Ugb2YgY29tbWl0IGEzYzNj
NjY2Ny4uLi4uQnV0IEkgY291bGQgYmUgd3JvbmcKPj4gV291bGQgeW91IHNob3cgYSBjYWxsIHBh
dGggd2hlcmUgREVUQUNIX0VYSVQgaXMgbm90IHNldCwgYnV0IHRoZSBjaGFuZ2VzIGluIGNvbW1p
dCBhM2MzYzY2NjcgaXMgc3RpbGwgbmVlZGVkPwo+Cj5Tb3JyeSBmb3IgbXkgYmFkIGV4cGxhaW5h
dGlvbiB3aXRob3V0IGRldGFpbC4KPlRoaW5rIGFib3V0IGNwdSBzcGVjaWZpYyBldmVudCBhbmQg
Y2xvc2VkIGJ5IHRhc2suCj5JZiB0aGVyZSBpcyBzcGVjaWZpYyBjaGlsZCBjcHUgZXZlbnQgc3Bl
Y2lmaWVkIGluIGNwdSAwLgo+ICAxLiBjcHUgMCAtPiBhY3RpdmUKPiAgMi4gc2NoZXVsZGVkIHRv
IGNwdTEgLT4gaW5hY3RpdmUKPiAgMy4gY2xvc2UgdGhlIGNwdSBldmVudCBmcm9tIHBhcmVudCAt
PiBpbmFjdGl2ZSBjbG9zZQo+Cj5DYW4gYmUgZmFpbGVkIHRvIGNvdW50IHRvdGFsX2VuYWJsZV90
aW1lLgoKSXMgdGhpcyBleHBsYWluaW5nIHRoZSBwdXJwb3NlIG9mIGNvbW1pdCBhM2MzYzY2Njcg
PwpJIGFtIG5vdCBhcmd1aW5nIHdpdGggaXQuIEFuZCBJIGFsc28gbm90IHN1Z2dlc3QgcmV2ZXJ0
aW5nIGl0LiAoaXQgaXMganVzdCB0aGF0IHJldmVydGluZyBpdCBjYW4gZml4IHRoZSBrZXJuZWwg
cGFuaWMuKQoKPgo+VGhhbmtzLgo+LS0KPlNpbmNlcmVseSwKPlllb3JldW0gWXVuCg==
