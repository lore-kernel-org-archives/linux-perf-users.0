Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331AB1DC98F;
	Wed,  1 Jul 2026 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892532; cv=none; b=i5E3xQ5D74yC3GtDMk68uT/Wxz3sC7SGQvg8gMKWE/jEjizY1s62MGV6dqKKE07p2CevWSLapYijE0VesQhcLWa/uHVB9lxbL1ZD3kfKS3QuI5+ISOchMMOkbgHr1qtZX6SBGIXsMyPXgeLdTGgpdIFkm6T+uz6xKFcSvqF8myE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892532; c=relaxed/simple;
	bh=b1YJoCECPw47UZqtcr8NXODQ0ZKHkObPGe+76heJ+dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=laTMHmHV9Q6HqKU2ibpoR3FyWZoe/FzYfuCRAlfx1savb72kObq5RhXpwJM4v0AvNqqKIKR748ORAc8uPc4QdvSvz2RPvN0klYjiz9ez0wxUJMEcqTa3vxdodHEh2YTH1jz7fABywXLqvPTftzAsvwiqWr2WR6usdNScuPJeUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqskR6Trhz1k1vj;
	Wed,  1 Jul 2026 15:55:11 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqskR5pwVz1k1vj;
	Wed,  1 Jul 2026 15:55:11 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id DEDDD3008F68;
	Wed,  1 Jul 2026 15:53:10 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 1 Jul
 2026 15:55:11 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Wed, 1 Jul 2026 15:55:11 +0800
From: Qi Liu <liuqi@hygon.cn>
To: Peter Zijlstra <peterz@infradead.org>
CC: "mingo@redhat.com" <mingo@redhat.com>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jing Li <lijing@hygon.cn>, Zhenglang Hu
	<huzhenglang@hygon.cn>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCAxLzNdIHBlcmYveDg2L2FtZC91bmNv?=
 =?utf-8?Q?re:_Add_common_PMU_helper_functions?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMS8zXSBwZXJmL3g4Ni9hbWQvdW5jb3JlOiBBZGQg?=
 =?utf-8?Q?common_PMU_helper_functions?=
Thread-Index: AQHdCQv6o68Qd8dC5kysbUObNUqjorZXtlKAgACTV6D//3rugIAAhrYA
Date: Wed, 1 Jul 2026 07:55:11 +0000
Message-ID: <fbe67fd6dd8f4521b529a2d816f64303@hygon.cn>
References: <20260701034413.718872-1-liuqi@hygon.cn>
 <20260701034413.718872-2-liuqi@hygon.cn>
 <20260701070013.GJ48970@noisy.programming.kicks-ass.net>
 <dab0dd2b31d14bef9fdc9d0c887dc460@hygon.cn>
 <20260701075117.GO48970@noisy.programming.kicks-ass.net>
In-Reply-To: <20260701075117.GO48970@noisy.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUGV0ZXIgWmlqbHN0cmEgPHBl
dGVyekBpbmZyYWRlYWQub3JnPiANCuWPkemAgeaXtumXtDogMjAyNuW5tDfmnIgx5pelIDE1OjUx
DQrmlLbku7bkuro6IFFpIExpdSA8bGl1cWlAaHlnb24uY24+DQrmioTpgIE6IG1pbmdvQHJlZGhh
dC5jb207IG5hbWh5dW5nQGtlcm5lbC5vcmc7IGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRl
bC5jb207IGpvbHNhQGtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnOyBsaW51eC1wZXJmLXVzZXJz
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmluZyBMaSA8
bGlqaW5nQGh5Z29uLmNuPjsgWmhlbmdsYW5nIEh1IDxodXpoZW5nbGFuZ0BoeWdvbi5jbj4NCuS4
u+mimDogUmU6IOetlOWkjTogW1BBVENIIDEvM10gcGVyZi94ODYvYW1kL3VuY29yZTogQWRkIGNv
bW1vbiBQTVUgaGVscGVyIGZ1bmN0aW9ucw0KDQpPbiBXZWQsIEp1bCAwMSwgMjAyNiBhdCAwNzo1
MDoxNkFNICswMDAwLCBRaSBMaXUgd3JvdGU6DQo+IA0KPiANCj4gLS0tLS3pgq7ku7bljp/ku7Yt
LS0tLQ0KPiDlj5Hku7bkuro6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4N
Cj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0N+aciDHml6UgMTU6MDANCj4g5pS25Lu25Lq6OiBRaSBM
aXUgPGxpdXFpQGh5Z29uLmNuPg0KPiDmioTpgIE6IG1pbmdvQHJlZGhhdC5jb207IG5hbWh5dW5n
QGtlcm5lbC5vcmc7IA0KPiBhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tOyBqb2xz
YUBrZXJuZWwub3JnOyB4ODZAa2VybmVsLm9yZzsgDQo+IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKaW5nIA0KPiBMaSA8bGlq
aW5nQGh5Z29uLmNuPjsgWmhlbmdsYW5nIEh1IDxodXpoZW5nbGFuZ0BoeWdvbi5jbj4NCj4g5Li7
6aKYOiBSZTogW1BBVENIIDEvM10gcGVyZi94ODYvYW1kL3VuY29yZTogQWRkIGNvbW1vbiBQTVUg
aGVscGVyIA0KPiBmdW5jdGlvbnMNCj4gDQo+IE9uIFdlZCwgSnVsIDAxLCAyMDI2IGF0IDAzOjQ0
OjExQU0gKzAwMDAsIFFpIExpdSB3cm90ZToNCj4gPiBBZGQgY29tbW9uIGhlbHBlciBmdW5jdGlv
bnMgZm9yIEFNRC1mYW1pbHkgdW5jb3JlIFBNVSBoYW5kbGluZy4NCj4gPiANCj4gPiBUaGUgaGVs
cGVycyBjb3ZlciBldmVudCBpbml0aWFsaXphdGlvbiwgY291bnRlciBhbGxvY2F0aW9uLCBjb3Vu
dGVyIA0KPiA+IHJlYWQvdXBkYXRlLCBldmVudCBzdGFydC9zdG9wIGFuZCBwZXItQ1BVIGNvbnRl
eHQgbWFuYWdlbWVudC4gIFRoZXNlIA0KPiA+IHBhdGhzIGFyZSBub3QgdGllZCB0byBhIHNwZWNp
ZmljIHVuY29yZSB1bml0IGFuZCBjYW4gYmUgcmV1c2VkIGJ5IA0KPiA+IGRyaXZlcnMgd2l0aCBh
IHNpbWlsYXIgdW5jb3JlIFBNVSBwcm9ncmFtbWluZyBtb2RlbC4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBRaSBMaXUgPGxpdXFpQGh5Z29uLmNuPg0KPiA+IFRlc3RlZC1ieTogWmhlbmdsYW5n
IEh1IDxodXpoZW5nbGFuZ0BoeWdvbi5jbj4NCj4gDQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHVu
Y29yZV9jb21tb25fc2V0X3VwZGF0ZV9pbnRlcnZhbCk7DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BM
KGV2ZW50X3RvX3VuY29yZV9jb21tb25fcG11KTsNCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwodW5j
b3JlX2NvbW1vbl9hdHRyX2dyb3VwKTsNCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwodW5jb3JlX2Nv
bW1vbl9zdGFydF9ocnRpbWVyKTsNCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwodW5jb3JlX2NvbW1v
bl9yZWFkKTsNCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwodW5jb3JlX2NvbW1vbl9zdGFydCk7DQo+
ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHVuY29yZV9jb21tb25fc3RvcCk7DQo+ID4gK0VYUE9SVF9T
WU1CT0xfR1BMKHVuY29yZV9jb21tb25fZXZlbnRfaW5pdCk7DQo+ID4gK0VYUE9SVF9TWU1CT0xf
R1BMKHVuY29yZV9jb21tb25fYWRkKTsNCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwodW5jb3JlX2Nv
bW1vbl9kZWwpOw0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTCh1bmNvcmVfY29tbW9uX2N0eF9pbml0
KTsNCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwodW5jb3JlX2NvbW1vbl9jdHhfZnJlZSk7DQo+ID4g
K0VYUE9SVF9TWU1CT0xfR1BMKHVuY29yZV9jb21tb25fY3R4X21vdmUpOw0KPiANCj4gSSBsaWtl
IHRoZSBpZGVhLCBidXQgSSBkb24ndCBwYXJ0aWN1bGFybHkgbGlrZSB0aGUgbmFtZXNwYWNlLg0K
PiAndW5jb3JlX2NvbW1vbicgaXMgdG9vIGdlbmVyaWMsIHRoZXJlIGFyZSBhIHRvbiBvZiB1bmNv
cmUgZHJpdmVycywgZXZlbiBvbiB4ODYgYW5kIHRoZXNlIGZ1bmN0aW9ucyBhcmUgc3BlY2lmaWMg
dG8gdGhlIEFNRCBmYW1pbHkuIFRoYXQgaXMsIHRoZXkgYXJlbid0IHJlYWxseSBjb21tb24gYXQg
YWxsLg0KPiANCj4gSGkgUGV0ZXIsDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcmVwbHkhDQo+IA0K
PiBZZXMsIHRoYXQgbmFtZXNwYWNlIGlzIGEgZmFpciBwb2ludCDigJQgImNvbW1vbiIgaXMgdG9v
IGJyb2FkLiBIZXJlIGFyZSB0d28gb3B0aW9uczoNCj4gQSkgYW1kX3VuY29yZV8qIOKAlCBUaGUg
cHJlZml4IGRlc2NyaWJlcyB0aGUgcHJvZ3JhbW1pbmcgbW9kZWwgb3JpZ2luLCBub3QgdGhlIHZl
bmRvciBydW5uaW5nIGl0Lg0KPiBCKSBhbWRfZmFtaWx5X3VuY29yZV8qIOKAlCBtYWtlcyBpdCBl
eHBsaWNpdCB0aGF0IHRoaXMgaXMgQU1ELWZhbWlseSB1bmNvcmUgaW5mcmFzdHJ1Y3R1cmUuDQo+
IA0KPiBEbyB5b3UgaGF2ZSBhIHByZWZlcmVuY2U/ICBPciBzb21ldGhpbmcgZWxzZSBlbnRpcmVs
eT8NCg0KJ2FtZF91bmNvcmVfJyB3b3JrcyBmb3IgbWUuDQoNClRoYW5rcywgSSdsbCByZW5hbWUg
ZXZlcnl0aGluZyAodW5jb3JlX2NvbW1vbi5bY2hdIOKGkiBhbWRfdW5jb3JlLltjaF0gb3Igc2lt
aWxhciwgYWxsIHN5bWJvbHMsIEtjb25maWcsIE1ha2VmaWxlKSBhbmQgc2VuZCBhIHYyLg0KDQpU
aGFua3MgZm9yIHRoZSByZXZpZXcuDQpRaSBMaXUNCg==

