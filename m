Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B61DF268;
	Mon,  2 Jun 2025 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871161; cv=none; b=DxwEvIJ5PRr2wJ09wJ+BDGM/UWpll14H9RnuF3skMJaCOB5wcJfnqPgtgrdP3zeSOG27hNCzWP0GV61eohc1ngvtZii7tdRXioYNh6mz1+8kLjJJJmhlFohQodwDT7ThGswzXqPOGQ0zzHHucayOLNQHwMpHS9vYGyh7Wk3dRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871161; c=relaxed/simple;
	bh=lGR5dh/b9pSOtmxD58z16Q+D/oH+sJq9yRhL81tkykM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=pfgvvim3gI2qRmIk1mKj1K4dmbA3Zqt6RiRfwG+jlNLckuQ/VE0oOq+3u7c3f5TI7lHhxFkvzOuCmE9zkwe5yYWBd1JMkXEnwg22XHd97SYyFOIHe3rbvqxa70tzeEPMZEyj/H/koDAxLCa3oyec98xARLdeQ5chm1ghbg18WF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=erMsSDcb reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="erMsSDcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=YwJ4lFFE74PWfvzqS14PJgI/Tfbz45EjcENVUG/e3n8=; b=e
	rMsSDcbmg9katZMXPnHGQS/6u1uJEPoZDJ3i2AJO+93Qk/1qfrqUakTzHKLqsKGV
	ldXMhy1ZgRprwu8fep+YHxWl0j1wq2PAw3MBXASVbHqJb1YLYSWKNMrWzIDF2Kqh
	luZRahM9l7bS/Vj+MGgq3rd1l0vnQV4i/YgViefvr8=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-146 (Coremail) ; Mon, 2 Jun 2025 21:31:59 +0800 (CST)
Date: Mon, 2 Jun 2025 21:31:59 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mingo@kernel.org, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG][6.15][perf] Kernel panic not syncing: Fatal exception in
 interrupt
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aD2kz52p5NHpuXk3@e129823.arm.com>
References: <aD2TspKH/7yvfYoO@e129823.arm.com>
 <aD2kz52p5NHpuXk3@e129823.arm.com>
X-NTES-SC: AL_Qu2fCvScvkkq7yKeYukZnEYQheY4XMKyuPkg1YJXOp80tCb35R0deXBSNHzmwcOpGS+tvxeeQh5u5OJYWIdxWoNBEXKsLzWoiqeaYS9jxpma
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1f4a84e5.32ca.19730d781aa.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kigvCgDHD6rQpz1oHlUSAA--.53824W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBVgqmg9nIb5ZAADsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDIgMjE6MTk6MTEsICJZZW9yZXVtIFl1biIgPHllb3JldW0ueXVuQGFybS5j
b20+IHdyb3RlOgo+SGkgRGF2aWQsCj4KPj4gQmVmb3JlIEkgc3RhcnQgdGVzdGluZywgSSBmZWVs
IGNvbmNlcm5lZCBhYm91dCBmb2xsb3dpbmcgY2hhaW46Cj4+Cj4+IC4va2VybmVsL2ZvcmsuYzoK
Pj4gYmFkX2ZvcmtfY2xlYW51cF9wZXJmOgo+PiAgICAgcGVyZl9ldmVudF9mcmVlX3Rhc2soKQo+
PiAgICAgICAgIHBlcmZfZnJlZV9ldmVudCgpCj4+ICAgICAgICAgICAgIGxpc3RfZGVsX2V2ZW50
KCkKPj4KPj4gVGhpcyBwYXRjaCBzZWVtcyBjaGFuZ2VzIHRoZSBiZWhhdmlvciBpbiB0aGlzIGNh
bGxjaGFpbi4KPj4gV291bGQgdGhpcyBoYXZlIG90aGVyIHNpZGUtZWZmZWN0Pwo+Cj5XaGF0IGJl
aGF2aW9yIGlzIGNoYW5nZWQgeW91J3JlIHdvcnJ5IGFib3V0Pwo+Ym90aCBlcnJvciBwYXRjaCBp
cyBoYW5kbGVkIGJ5IF9fcGVyZl9yZW1vdmVfZnJvbV9jb250ZXh0KCksCj5UaGVyZSB3b3VsZG4n
dCBiZSBubyBwcm9ibGVtIHNpbmNlIHRoaXMgcGF0Y2gganVzdCBtb3ZlIHRoZQo+dGltZSBvZiBk
aXNhYmxpbmcgY2dyb3VwIGJlZm9yZSBjaGFuZ2luZyBldmVudCBzdGF0ZS4KPgo+YWxzbywgdGhl
IGNncm91cCBldmVudCBpcyBmb3Igb25seSBjcHVjdHggbm90IGFkZGVkIGluIHRhc2tjdHguCj5T
bywgdGhlcmUncyBubyBlZmZlY3QgZm9yIGV2ZW50IGF0dGFjaGVkIGluIHRhc2tjdHguCj4KPlRo
YW5rcy4KPgo+LS0KPlNpbmNlcmVseSwKPlllb3JldW0gWXVuCgpBbSBJIHJlYWRpbmcgaXQgd3Jv
bmc/IApUaGUgY2FsbCBjaGFpbiBJIG1lbnRpb25lZCBhYm92ZSBkb3NlIG5vdCB3YWxrIHRocm91
Z2ggX19wZXJmX3JlbW92ZV9mcm9tX2NvbnRleHQsCkl0IGlzIGEgZmFpbCBwYXRoIGluIGZvcmss
IHdoaWNoIGhhcHBlbnMgcmFyZWx5LCBidXQgc3RpbGwgcG9zc2libGUuIEkgZ3Vlc3MuLi4KCkRh
dmlkCgo=
