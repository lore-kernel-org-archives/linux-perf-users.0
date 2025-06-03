Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FDB12B73;
	Tue,  3 Jun 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955864; cv=none; b=td/Flo8VmkwFbjqpNQxiEzIQznVkP/cbIgIvTi/9Y9utK38UjvQks66ulSBgNigJJNDKc4C8Fy5mOLVBxQ0pAZofedFGz60XEVaVsdBgePqRk0fMmlBna2lJPszpmNKagyaDOmYNCBQyChi1aIBeJEwCLvmg+T5grM8UPelYJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955864; c=relaxed/simple;
	bh=LTts8eyV7N64hZQZ+j7Pro9m/Qtt9yprFoJa2t2YSxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DMYXDBHHMN3BTW/LYWYKfHIBeEhElVNsIL0n283cHV+NRw3Aa63RQUT9F0OnOeS0WiyMTP8MNMhOcbxhsIi4VMlRgo71YEbXMKdWASVgyjFjc1CfhrTPAx6E5pdFEjhlhDejH3XL2E5Y0aMC0yig5/R1bIksp2LCkLyIwmvyi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=KP/1y5Ep reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="KP/1y5Ep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=e1P63WWpE/yNP0EnN6fBqKkEw4tP8IuvstsE1GFOMro=; b=K
	P/1y5EpnFFZ93GZc3fRvoMm1P9M57iQLhPhIcchf4rhs6yBNw4F7kC6hXR2Ih+nW
	5lHdcc3Bvf4afWiKUCb/z5gLXy+gZGm1U8oY2fb2oSYntHGtRIxwmoI2TSNKZzM9
	jOAunHGzsulNznkhz/J431Nv7q25fPXE7hfbVIatQU=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-120 (Coremail) ; Tue, 3 Jun 2025 21:03:55 +0800 (CST)
Date: Tue, 3 Jun 2025 21:03:55 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mingo@kernel.org,
	yeoreum.yun@arm.com, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: restore __perf_remove_from_context when
 DETACH_EXIT not set
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250603125440.GA35970@noisy.programming.kicks-ass.net>
References: <20250603032651.3988-1-00107082@163.com>
 <20250603083304.34132-1-00107082@163.com>
 <20250603091352.GJ21197@noisy.programming.kicks-ass.net>
 <2633d43d.ae30.1973564f5e5.Coremail.00107082@163.com>
 <20250603125056.GI39944@noisy.programming.kicks-ass.net>
 <20250603125440.GA35970@noisy.programming.kicks-ass.net>
X-NTES-SC: AL_Qu2fCvWeukAo4ymYY+kZnEYQheY4XMKyuPkg1YJXOp80qiTS4SchZ25qJnLK9PmtFz2moQmoVjhMwclIUoR1QJjNy9VRbwqI51t+XSovUR5d
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6487969b.b907.19735e42e05.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eCgvCgD3X9K88j5oPBETAA--.38060W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkBVhqmg+7Kd6qAACsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDMgMjA6NTQ6NDAsICJQZXRlciBaaWpsc3RyYSIgPHBldGVyekBpbmZyYWRl
YWQub3JnPiB3cm90ZToKPk9uIFR1ZSwgSnVuIDAzLCAyMDI1IGF0IDAyOjUwOjU2UE0gKzAyMDAs
IFBldGVyIFppamxzdHJhIHdyb3RlOgo+PiBPbiBUdWUsIEp1biAwMywgMjAyNSBhdCAwNjo0NDo1
OFBNICswODAwLCBEYXZpZCBXYW5nIHdyb3RlOgo+PiAKPj4gCj4+ID4gKEFzIHllb3JldW0ueXVu
QGFybS5jb20gcG9pbnRlZCBvdXQsICB0aGUgY2hhbmdlIGluIHBlcmZfcmVtb3ZlX2Zyb21fY29u
dGV4dCgpIG1hZGUKPj4gPiBwZXJmX2V2ZW50X3NldF9zdGF0ZSgpIGhhcHBlbmVkIGJlZm9yZSBs
aXN0X2RlbF9ldmVudCgpLCByZXN1bHRpbmcgaW4gcGVyZl9jZ3JvdXBfZXZlbnRfZGlzYWJsZSgp
Cj4+ID4gbm90IGNhbGxlZC4pCj4+IAo+PiBBYWgsIGQnMGguIExldCBtZSBzZWUgd2hhdCB3ZSBz
aG91bGQgZG8gdGhlcmUuCj4KPkRvZXMgdGhpcyBoZWxwPyBUaGlzIHdheSBldmVudF9zY2hlZF9v
dXQoKSB3aWxsIGNhbGwKPnBlcmZfY2dyb3VwX2V2ZW50X2Rpc2FibGUoKS4KPgo+Cj5kaWZmIC0t
Z2l0IGEva2VybmVsL2V2ZW50cy9jb3JlLmMgYi9rZXJuZWwvZXZlbnRzL2NvcmUuYwo+aW5kZXgg
ZjM0Yzk5ZjhjZThmLi5hZGJiMDM3MjgyNWYgMTAwNjQ0Cj4tLS0gYS9rZXJuZWwvZXZlbnRzL2Nv
cmUuYwo+KysrIGIva2VybmVsL2V2ZW50cy9jb3JlLmMKPkBAIC0yNDk0LDkgKzI0OTQsOSBAQCBf
X3BlcmZfcmVtb3ZlX2Zyb21fY29udGV4dChzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsCj4gCWlm
IChmbGFncyAmIERFVEFDSF9SRVZPS0UpCj4gCQlzdGF0ZSA9IFBFUkZfRVZFTlRfU1RBVEVfUkVW
T0tFRDsKPiAJaWYgKGZsYWdzICYgREVUQUNIX0RFQUQpIHsKPi0JCWV2ZW50LT5wZW5kaW5nX2Rp
c2FibGUgPSAxOwo+IAkJc3RhdGUgPSBQRVJGX0VWRU5UX1NUQVRFX0RFQUQ7Cj4gCX0KPisJZXZl
bnQtPnBlbmRpbmdfZGlzYWJsZSA9IDE7Cj4gCWV2ZW50X3NjaGVkX291dChldmVudCwgY3R4KTsK
PiAJcGVyZl9ldmVudF9zZXRfc3RhdGUoZXZlbnQsIG1pbihldmVudC0+c3RhdGUsIHN0YXRlKSk7
Cj4gCgpPaywgSSB3aWxsIGdpdmUgaXQgYSB0cnkgYW5kIHVwZGF0ZSBsYXRlci4K
