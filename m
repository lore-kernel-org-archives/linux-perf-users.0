Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4022EB1D;
	Tue,  3 Jun 2025 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933724; cv=none; b=mf8WzhX+0QUIjIJdycX6iSDxbXcx7mDielFRln5aik0Datprw9cXy5uttYVrSjxn3MIdNP8astQSYEnstF24EKDt5OqXkijwuL+qyZCv+zQqrDQn1oM9bLN3lk7Vwm1gBkiqliv2JucB2uEMgAARQ2NtiNAzBw8E93jGltn2aHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933724; c=relaxed/simple;
	bh=sCRpWwME+Mbt3J0XUqv5P9arPzVIC0WtJOh+8X7Ci/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IBE6Hj5UzpWnaAAyAfZNc/QR7+S9+nCQOvyjREjlJfBgrGGDkZj/48D4N/DWrbqROkje3HNagkPfQadV747qZdc5RqBF90HOMQ87HYoH6lVZUwa4OWpvCks9WjmS8uzONdIwAabQO/Pmv6Hj3xL8DicPspU2N1gSKlY/3D5j6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HDjndiHD; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HDjndiHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=sCRpWwME+Mbt3J0XUqv5P9arPzVIC0WtJOh+8X7Ci/k=; b=H
	DjndiHDgL9RwomRluS1eJ7K5RpfByle8fER9udenNTfcOnzJN5jNndw89RdSr+q9
	gCtgjXFbuwJvKnAr3J2fWkvkFjpuzy5zZwyKF6L6qjLJyMBv9VrBpv6sJ+v1mGT1
	8JCObhhmDh9imASDZAWpV0apH6tDInaaCDwOnGhZ+s=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Tue, 3 Jun 2025 14:54:35 +0800 (CST)
Date: Tue, 3 Jun 2025 14:54:35 +0800 (CST)
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
X-NTES-SC: AL_Qu2fCvWYvE4s4yKQY+kZnEYQheY4XMKyuPkg1YJXOp80iCXQ3wodeXBxJkTkwcOOJiWSvxe8aSZS7+RTe4BFYbCvBmCFCyPKl5VdSW4IYej5
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5238de9d.6895.1973492091b.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgD3L9srnD5o9K8SAA--.26502W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkBJhqmg+kwHr9AAHsV
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
dGhlciBwZW9wbGUncyByZXZpZXcuCj4KClRoZSAqcmlzayogaXMgdW5uZWNlc3NhcnksIHdlIGNh
biBjb25maW5lIHRoZSBzY29wZSBvZiBERVRBQ0hfRVhJVC4KV2h5IGtlZXAgbWFraW5nIGdsb2Jh
bCBjaGFuZ2VzIHdoZW4gY29uZmluZWQgY2hhbmdlcyBhcmUgYXZhaWxhYmxlPwoKCkRhdmlkCg==

