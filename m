Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59113B440E;
	Wed,  1 Jul 2026 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892237; cv=none; b=FWSUZMkY92C19Ot4b5H6ihstVOiH5fwDE2XcvVTKwZdOFjiPWA8dujTM4tdc8bCNaADGpNkNoLkYGFi/Y5pMCaAUXEYnut+fRox1SvUKDZNSGg3jHLxhFVJP6u5ULdXPc8GnYQET6P0YNj5ePKJICW8k9cZDHv6ovcfFeU3J1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892237; c=relaxed/simple;
	bh=fejFts/2NClDW3xAZCFKKkLbnnE5A9PMh0fEUTVKJ+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJiovJIGwghIu1XLzSd0eNClqtSHcyvBnTluqPt3j+HMhuneKcfjeo8lrt8sdohMRvbs/1iZSfr/FKsHfRiM9v9IhSf6do/KHKP3m2Hcax0rRlIzTreqLahlIbFj4PB2E9+jh0A4IjjQnkjCzXmjB/uAjt/bqieSpqnibiAd3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqscn6Llkz1Q1td;
	Wed,  1 Jul 2026 15:50:17 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqscn2jVqz1Q1td;
	Wed,  1 Jul 2026 15:50:17 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 7A89C3008F68;
	Wed,  1 Jul 2026 15:48:16 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 1 Jul
 2026 15:50:17 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Wed, 1 Jul 2026 15:50:17 +0800
From: Qi Liu <liuqi@hygon.cn>
To: Peter Zijlstra <peterz@infradead.org>
CC: "mingo@redhat.com" <mingo@redhat.com>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jing Li <lijing@hygon.cn>, Zhenglang Hu
	<huzhenglang@hygon.cn>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvM10gcGVyZi94ODYvYW1kL3VuY29yZTogQWRkIGNv?=
 =?gb2312?Q?mmon_PMU_helper_functions?=
Thread-Topic: [PATCH 1/3] perf/x86/amd/uncore: Add common PMU helper functions
Thread-Index: AQHdCQv6o68Qd8dC5kysbUObNUqjorZXtlKAgACTV6A=
Date: Wed, 1 Jul 2026 07:50:16 +0000
Message-ID: <dab0dd2b31d14bef9fdc9d0c887dc460@hygon.cn>
References: <20260701034413.718872-1-liuqi@hygon.cn>
 <20260701034413.718872-2-liuqi@hygon.cn>
 <20260701070013.GJ48970@noisy.programming.kicks-ass.net>
In-Reply-To: <20260701070013.GJ48970@noisy.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IA0Kt6LLzcqxvOQ6IDIwMjbE6jfUwjHI1SAxNTowMA0KytW8/sjLOiBRaSBM
aXUgPGxpdXFpQGh5Z29uLmNuPg0Ks63LzTogbWluZ29AcmVkaGF0LmNvbTsgbmFtaHl1bmdAa2Vy
bmVsLm9yZzsgYWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbTsgam9sc2FAa2VybmVs
Lm9yZzsgeDg2QGtlcm5lbC5vcmc7IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKaW5nIExpIDxsaWppbmdAaHlnb24uY24+OyBa
aGVuZ2xhbmcgSHUgPGh1emhlbmdsYW5nQGh5Z29uLmNuPg0K1vfM4jogUmU6IFtQQVRDSCAxLzNd
IHBlcmYveDg2L2FtZC91bmNvcmU6IEFkZCBjb21tb24gUE1VIGhlbHBlciBmdW5jdGlvbnMNCg0K
T24gV2VkLCBKdWwgMDEsIDIwMjYgYXQgMDM6NDQ6MTFBTSArMDAwMCwgUWkgTGl1IHdyb3RlOg0K
PiBBZGQgY29tbW9uIGhlbHBlciBmdW5jdGlvbnMgZm9yIEFNRC1mYW1pbHkgdW5jb3JlIFBNVSBo
YW5kbGluZy4NCj4gDQo+IFRoZSBoZWxwZXJzIGNvdmVyIGV2ZW50IGluaXRpYWxpemF0aW9uLCBj
b3VudGVyIGFsbG9jYXRpb24sIGNvdW50ZXIgDQo+IHJlYWQvdXBkYXRlLCBldmVudCBzdGFydC9z
dG9wIGFuZCBwZXItQ1BVIGNvbnRleHQgbWFuYWdlbWVudC4gIFRoZXNlIA0KPiBwYXRocyBhcmUg
bm90IHRpZWQgdG8gYSBzcGVjaWZpYyB1bmNvcmUgdW5pdCBhbmQgY2FuIGJlIHJldXNlZCBieSAN
Cj4gZHJpdmVycyB3aXRoIGEgc2ltaWxhciB1bmNvcmUgUE1VIHByb2dyYW1taW5nIG1vZGVsLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUWkgTGl1IDxsaXVxaUBoeWdvbi5jbj4NCj4gVGVzdGVkLWJ5
OiBaaGVuZ2xhbmcgSHUgPGh1emhlbmdsYW5nQGh5Z29uLmNuPg0KDQo+ICtFWFBPUlRfU1lNQk9M
X0dQTCh1bmNvcmVfY29tbW9uX3NldF91cGRhdGVfaW50ZXJ2YWwpOw0KPiArRVhQT1JUX1NZTUJP
TF9HUEwoZXZlbnRfdG9fdW5jb3JlX2NvbW1vbl9wbXUpOw0KPiArRVhQT1JUX1NZTUJPTF9HUEwo
dW5jb3JlX2NvbW1vbl9hdHRyX2dyb3VwKTsNCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHVuY29yZV9j
b21tb25fc3RhcnRfaHJ0aW1lcik7DQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh1bmNvcmVfY29tbW9u
X3JlYWQpOw0KPiArRVhQT1JUX1NZTUJPTF9HUEwodW5jb3JlX2NvbW1vbl9zdGFydCk7DQo+ICtF
WFBPUlRfU1lNQk9MX0dQTCh1bmNvcmVfY29tbW9uX3N0b3ApOw0KPiArRVhQT1JUX1NZTUJPTF9H
UEwodW5jb3JlX2NvbW1vbl9ldmVudF9pbml0KTsNCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHVuY29y
ZV9jb21tb25fYWRkKTsNCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHVuY29yZV9jb21tb25fZGVsKTsN
Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHVuY29yZV9jb21tb25fY3R4X2luaXQpOw0KPiArRVhQT1JU
X1NZTUJPTF9HUEwodW5jb3JlX2NvbW1vbl9jdHhfZnJlZSk7DQo+ICtFWFBPUlRfU1lNQk9MX0dQ
TCh1bmNvcmVfY29tbW9uX2N0eF9tb3ZlKTsNCg0KSSBsaWtlIHRoZSBpZGVhLCBidXQgSSBkb24n
dCBwYXJ0aWN1bGFybHkgbGlrZSB0aGUgbmFtZXNwYWNlLg0KJ3VuY29yZV9jb21tb24nIGlzIHRv
byBnZW5lcmljLCB0aGVyZSBhcmUgYSB0b24gb2YgdW5jb3JlIGRyaXZlcnMsIGV2ZW4gb24geDg2
IGFuZCB0aGVzZSBmdW5jdGlvbnMgYXJlIHNwZWNpZmljIHRvIHRoZSBBTUQgZmFtaWx5LiBUaGF0
IGlzLCB0aGV5IGFyZW4ndCByZWFsbHkgY29tbW9uIGF0IGFsbC4NCg0KSGkgUGV0ZXIsDQoNClRo
YW5rcyBmb3IgeW91ciByZXBseSENCg0KWWVzLCB0aGF0IG5hbWVzcGFjZSBpcyBhIGZhaXIgcG9p
bnQgoaogImNvbW1vbiIgaXMgdG9vIGJyb2FkLiBIZXJlIGFyZSB0d28gb3B0aW9uczoNCkEpIGFt
ZF91bmNvcmVfKiChqiBUaGUgcHJlZml4IGRlc2NyaWJlcyB0aGUgcHJvZ3JhbW1pbmcgbW9kZWwg
b3JpZ2luLCBub3QgdGhlIHZlbmRvciBydW5uaW5nIGl0Lg0KQikgYW1kX2ZhbWlseV91bmNvcmVf
KiChqiBtYWtlcyBpdCBleHBsaWNpdCB0aGF0IHRoaXMgaXMgQU1ELWZhbWlseSB1bmNvcmUgaW5m
cmFzdHJ1Y3R1cmUuDQoNCkRvIHlvdSBoYXZlIGEgcHJlZmVyZW5jZT8gIE9yIHNvbWV0aGluZyBl
bHNlIGVudGlyZWx5Pw0KDQpUaGFua3MsDQpRaSBMaXUNCg==

