Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEB7211472;
	Tue,  3 Jun 2025 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933294; cv=none; b=N/alH9R8MZDTFY4N9ZSGavKS9TXeoF5V6Iaw4A1zRiRPJF22j1qqOLT35Wb6DxJKHE43BbeC0VhvqRfXppQ1h6swRpocs76OIiaMidoPo/vtbf6bc4i93kZrKhrTnZyWWjFZyMOv36DCKuOGjq1xQRMSATwSg+9AcoTbTgcVbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933294; c=relaxed/simple;
	bh=LHnlvV2psFWSQzBb0ccN3jNUfgM+ntSpC/MXqdDoyrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=hXtJxClBVC2gH5RhOJSHo9QeEha8CA6emwO9wxtDvkYNy/bTEBVDNtii1d9pp4GTLF9pxz4EPSIS6IlDC/jnxYMD8sZ2eb4t/1qUb7rqDS/ZNOHWm7H8xp9JTJVr2omWYuJwrsDZOc4BOkNqP9uuzrsnauHtKp3c8fPF+GqqPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=X0E23+qK reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="X0E23+qK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=SoTDWzjXsQ/Zg5zUJWRO9wNxudG0F5M1LKS0zzLg+pM=; b=X
	0E23+qK9GTwu6XU4p1EEyiqDATtGmrp7hQucSNZPV1WFUygHICzLeqeG7IFjkL6f
	A5sdeYN1R1ZbjHBh5mRMPGWZH17E6kAywD7k1/BJDaLwwLhu6vpc3xw4PZxypN0I
	joaKK9CW2koAgS2zy+8WT3XJ+aGWxqDD2051RvOh8w=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Tue, 3 Jun 2025 14:47:25 +0800 (CST)
Date: Tue, 3 Jun 2025 14:47:25 +0800 (CST)
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
In-Reply-To: <aD6YpfGz3MUfedHC@e129823.arm.com>
References: <19514ed5.5692.19734522326.Coremail.00107082@163.com>
 <aD6Xk2rdBjnVy6DA@e129823.arm.com> <aD6YpfGz3MUfedHC@e129823.arm.com>
X-NTES-SC: AL_Qu2fCvWYvEov4yGbZekZnEYQheY4XMKyuPkg1YJXOp80iCXQ3wodeXBxJkTkwcOOJiWSvxe8aSZS7+RTe4BFYbChV4TaPaKSjKDs55PotH6X
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5d17f1d7.666d.197348b78d1.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgD3L9t9mj5o9qwSAA--.26411W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkBJhqmg+kwHr9AAFsX
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDMgMTQ6Mzk6MzMsICJZZW9yZXVtIFl1biIgPHllb3JldW0ueXVuQGFybS5j
b20+IHdyb3RlOgo+PiA+ID4gYXR0YWNoX3N0YXRlIGRvZXNuJ3QgcmVsYXRlZCBmb3IgZXZlbnQt
PnN0YXRlIGNoYW5nZS4KPj4gPiA+IGlmIG9uZSBldmVudCBhbHJlYWR5IGNsZWFyZWQgUEVSRl9B
VFRBQ0hfQ09OVEVYVCwgdGhhdCBldmVudCBpcyBjYWxsZWQKPj4gPiA+IHZpYSBsaXN0X2RlbF9l
dmVudCgpCj4+ID4KPj4gPiBNYXliZSB0aGlzIGNvbmNlcm4gY291bGQgYmUgY2xhcmlmaWVkLCB3
aGF0IGFib3V0IG90aGVyIHN1YnRsZSBpbXBhY3RzLgo+PiA+IFRoZSBjaGFuZ2Ugc2hvdWxkIGJl
IHRob3JvdWdoIHJldmlld2VkLCBpZiB5b3Ugd2FudCB0byBwdXNoIGl0IGZ1cnRoZXIuCj4+ID4K
Pj4gPiBJdCB0YWtlcyBtZSBtb3JlIHRoYW4gYSBtb250aCB0byBmaWd1cmUgb3V0IGEgcHJvY2Vk
dXJlIHRvIHJlcHJvZHVjZSB0aGUga2VybmVsIHBhbmljIGJ1ZywKPj4gPiBJdCBpcyAganVzdCB2
ZXJ5IGhhcmQgdG8gY2FwdHVyZSBhIGJ1ZyBoYXBwZW5zIGluIHJhcmUgc2l0dWF0aW9uLgo+PiA+
Cj4+ID4gQW5kIHlvdXIgcGF0Y2ggaGFzIGEgZ2xvYmFsIGltcGFjdCwgaXQgY2hhbmdlcyBiZWhh
dmlvciB1bm5lY2Vzc2FyaWx5Lgo+Pgo+PiBUQkgsIHRoaXMgcGF0Y2gganVzdCBjaGFuZ2Ugb2Yg
dGltZSBvZiAiZXZlbnQtPnN0YXRlIiB3aGlsZSBkb2luZywKPj4gQXMgbXkgYmFkIG1pc3MgdGhl
IGRpc2FibGUgY2dvcnVwIHBlcmYuCj4+IEkgdGhpbmsgdGhlcmUgc2VlbXMgbm8gb3RoZXIgc2lk
ZSBlZmZlY3QgZm9yIGNoYW5pbmcgc3RhdGUgd2hpbGUgaW4KPj4gcmVtb3ZpbmcgZXZlbnQuCj4+
IEJ1dCwgTGV0J3Mgd2FpdCBmb3Igb3RoZXIgcGVvcGxlJ3MgcmV2aWV3Lgo+Pgo+PiA+ID4KPj4g
PiA+IEFsc28sIHlvdXIgcGF0Y2ggY291bGRuJ3Qgc29sdmUgYSBwcm9ibGVtIGRlc2NyaWJlIGlu
Cj4+ID4gPiBjb21taXQgYTNjM2M2NjY3KCJwZXJmL2NvcmU6IEZpeCBjaGlsZF90b3RhbF90aW1l
X2VuYWJsZWQgYWNjb3VudGluZyBidWcgYXQgdGFzayBleGl0IikKPj4gPiA+IGZvciBJTkNBVElW
RSBldmVudCdzIHRvdGFsX2VuYWJsZV90aW1lLgo+PiA+Cj4+ID4gSSBkbyBub3QgdGhpbmsgc28u
Cj4+ID4gQ29ycmVjdCBtZSBpZiBJIGFtIG1ha2luZyBzaWxseSAgbWlzdGFrZXMsCj4+ID4gVGhl
IHBhdGNoLCBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjUwNjAzMDMyNjUxLjM5ODgt
MS0wMDEwNzA4MkAxNjMuY29tLwo+PiA+IGNhbGxzIHBlcmZfZXZlbnRfc2V0X3N0YXRlKCkgYmFz
ZWQgb24gREVUQUNIX0VYSVQgZmxhZywgd2hpY2ggY292ZXIgdGhlIElOQUNUSVZFIHN0YXRlLCBy
aWdodD8KPj4gPiBJZiBERVRBQ0hfRVhJVCBpcyBub3QgdXNlZCBmb3IgdGhpcyBwdXJwb3NlPyBU
aGVuIHdoeSBzaG91bGQgaXQgZXhpc3QgYXQgdGhlIGZpcnN0IHBsYWNlPwo+PiA+IEkgdGhpbmsg
SSBkb2VzIG5vdCByZXZlcnQgdGhlIHB1cnBvc2Ugb2YgY29tbWl0IGEzYzNjNjY2Ny4uLi4uQnV0
IEkgY291bGQgYmUgd3JvbmcKPj4gPiBXb3VsZCB5b3Ugc2hvdyBhIGNhbGwgcGF0aCB3aGVyZSBE
RVRBQ0hfRVhJVCBpcyBub3Qgc2V0LCBidXQgdGhlIGNoYW5nZXMgaW4gY29tbWl0IGEzYzNjNjY2
NyBpcyBzdGlsbCBuZWVkZWQ/Cj4+Cj4+IFNvcnJ5IGZvciBteSBiYWQgZXhwbGFpbmF0aW9uIHdp
dGhvdXQgZGV0YWlsLgo+PiBUaGluayBhYm91dCBjcHUgc3BlY2lmaWMgZXZlbnQgYW5kIGNsb3Nl
ZCBieSB0YXNrLgo+PiBJZiB0aGVyZSBpcyBzcGVjaWZpYyBjaGlsZCBjcHUgZXZlbnQgc3BlY2lm
aWVkIGluIGNwdSAwLgo+PiAgIDEuIGNwdSAwIC0+IGFjdGl2ZQo+PiAgIDIuIHNjaGV1bGRlZCB0
byBjcHUxIC0+IGluYWN0aXZlCj4+ICAgMy4gY2xvc2UgdGhlIGNwdSBldmVudCBmcm9tIHBhcmVu
dCAtPiBpbmFjdGl2ZSBjbG9zZQo+Pgo+PiBDYW4gYmUgZmFpbGVkIHRvIGNvdW50IHRvdGFsX2Vu
YWJsZV90aW1lLgo+Pgo+PiBUaGFua3MuCj4KPkFuZCBhbHNvLCBjb25zaWRlcmluZyB0aGUgeW91
ciBwYXRjaCwgZm9yIERFVEFDSF9FWElUIGNhc2UsCj5JZiBpdCBjaGFuZ2VzIHRoZSBzdGF0ZSBi
ZWZvcmUgbGlzdF9kZWxfZXZlbnQoKSB0aGF0IHdvdWxkbid0IGRpc2FibGUKPnJlbGF0ZWQgdG8g
dGhlIGNncm91cC4gU28gaXQgd291bGQgbWFrZSBjcHVjdHgtPmNncnAgcG9pbnRlciBjb3VsZCBi
ZSBkYW5nbGVkCj5hcyBwYXRjaCBkZXNjcmliZS4uLgoKTm8sIEkgZG9uJ3QgdGhpbmsgc28uCmNo
YW5nZSBzdGF0ZSBiZWZvcmUgbGlzdF9kZWxfZXZlbnQoKSwgdGhpcyBpcyB0aGUgc2FtZSBiZWhh
dmlvciBiZWZvcmUgY29tbWl0IGEzYzNjNjY2NywgcmlnaHQ/CkFuZCBubyBzdWNoIGtlcm5lbCBw
YW5pYyBoYXBwZW5lZCAgYmVmb3JlIGNvbW1pdCBhM2MzYzY2NjcuCgo+Cj4+IC0tCj4+IFNpbmNl
cmVseSwKPj4gWWVvcmV1bSBZdW4KPgo+LS0KPlNpbmNlcmVseSwKPlllb3JldW0gWXVuCg==
