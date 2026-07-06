Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73333FE369;
	Mon,  6 Jul 2026 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338333; cv=none; b=ZzmKTxJyEJolV/rWILC9Zp/7zOyqAsnKjTvb2i3JR3pTcXKOggsL6MBPicp1VSV0EriV7UppXHLOHxaisYs5bWp4MNkD162Z04fvOYQt3lsOpzFx1Y8L/LCoZv7FWuzvJWHD51LmudGVF+1rOkBW/d9cvFVj0KQtS8Iogr0TYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338333; c=relaxed/simple;
	bh=lXPregIhXCecpY+h4I9VvH9CK6f3/td05rdAl7slTlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uv6NCgr5I3diXUV+WYY+9DfzgMpk1ha+N9rsNmTFKKmtzqhaPw882uw9biCDF/Fkko0owSAYh1ksQifM7wX/fGhYzl5D0DER84J7ptBeGpxsrvwMoT12ISW31+bizWQNRVd3dzR695ujSYtjHgyY/Vyz5f++24czQf/H0+cANDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gv2bX4bBLz297MK;
	Mon,  6 Jul 2026 19:45:12 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gv2bW2lJ5z297MK;
	Mon,  6 Jul 2026 19:45:11 +0800 (CST)
Received: from cncheex06.Hygon.cn (unknown [172.23.18.116])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 7F5C15966;
	Mon,  6 Jul 2026 19:45:07 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex06.Hygon.cn
 (172.23.18.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 6 Jul
 2026 19:45:11 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Mon, 6 Jul 2026 19:45:11 +0800
From: Qi Liu <liuqi@hygon.cn>
To: Borislav Petkov <bp@alien8.de>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jing Li
	<lijing@hygon.cn>, Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMC8zXSBwZXJmL3g4Ni9hbWQvdW5jb3JlOiBB?=
 =?utf-8?Q?dd_common_helpers_and_Hygon_support?=
Thread-Topic: [PATCH v2 0/3] perf/x86/amd/uncore: Add common helpers and Hygon
 support
Thread-Index: AQHdCTzQ1fO6vHifPUawyxvlEdFI3bZY/pGAgAdAk1A=
Date: Mon, 6 Jul 2026 11:45:10 +0000
Message-ID: <7a2ac50cf004421bb6dadfa7f488b70b@hygon.cn>
References: <20260701093417.1312443-1-liuqi@hygon.cn>
 <20260702023625.GIakXOqdXpW3GVkk8E@fat_crate.local>
In-Reply-To: <20260702023625.GIakXOqdXpW3GVkk8E@fat_crate.local>
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

SGkgQm9yaXMsDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkhIA0KDQpUaGlzIG1ha2VzIHNlbnNlLiBJ
IHNlZSB0aGUgY29uY2VybiBhYm91dCBpbnRyb2R1Y2luZyBjb21tb24gaGVscGVycyB0b28gZWFy
bHkgd2hlbiBBTUQgYW5kIEh5Z29uIG1heSBzdGlsbCBldm9sdmUgZGlmZmVyZW50bHkgaW4gZGV0
YWlscy4NCkZvciB0aGUgbmV4dCByZXZpc2lvbiwgSSBjYW4ga2VlcCB0aGUgSHlnb24gc3VwcG9y
dCBzZWxmLWNvbnRhaW5lZCBieSBjb3B5aW5nIHRoZSBuZWVkZWQgQU1EIGxvZ2ljIGZpcnN0LCBh
bmQgYXZvaWQgaW50cm9kdWNpbmcgYSBnZW5lcmljIGNvbW1vbiBsYXllciBhdCB0aGlzIHN0YWdl
LiBJZiB0aGUgaGVscGVycyByZW1haW4gaWRlbnRpY2FsIG92ZXIgdGltZSwgd2UgY2FuIGFsd2F5
cyBjb25zb2xpZGF0ZSB0aGVtIGxhdGVyIGluIGEgc2VwYXJhdGUgY2xlYW51cC4NCknigJlsbCBh
bHNvIHJldmlzaXQgdGhlIHN5bWJvbCBleHBvcnRzIGFuZCBkcm9wIHRoZW0gdW5sZXNzIHRoZXJl
IGlzIGEgY2xlYXIgbW9kdWxlIGJvdW5kYXJ5IHJlcXVpcmVtZW50DQoNClRoYW5rcywNClFpIExp
dQ0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPiANCuWPkemAgeaXtumXtDogMjAyNuW5tDfmnIgy5pelIDEwOjM2DQrmlLbk
u7bkuro6IFFpIExpdSA8bGl1cWlAaHlnb24uY24+DQrmioTpgIE6IHBldGVyekBpbmZyYWRlYWQu
b3JnOyBtaW5nb0ByZWRoYXQuY29tOyBuYW1oeXVuZ0BrZXJuZWwub3JnOyBhbGV4YW5kZXIuc2hp
c2hraW5AbGludXguaW50ZWwuY29tOyBqb2xzYUBrZXJuZWwub3JnOyB4ODZAa2VybmVsLm9yZzsg
bGludXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IEppbmcgTGkgPGxpamluZ0BoeWdvbi5jbj47IFNhbmRpcGFuIERhcyA8c2FuZGlwYW4u
ZGFzQGFtZC5jb20+OyBSYXZpIEJhbmdvcmlhIDxyYXZpLmJhbmdvcmlhQGFtZC5jb20+DQrkuLvp
opg6IFJlOiBbUEFUQ0ggdjIgMC8zXSBwZXJmL3g4Ni9hbWQvdW5jb3JlOiBBZGQgY29tbW9uIGhl
bHBlcnMgYW5kIEh5Z29uIHN1cHBvcnQNCg0KKyBBTUQgcGVvcGxlIHdobyB3b3JrIG9uIHRoaXMg
Y29kZS4NCg0KT24gV2VkLCBKdWwgMDEsIDIwMjYgYXQgMDk6MzQ6MTRBTSArMDAwMCwgUWkgTGl1
IHdyb3RlOg0KPiBUaGlzIHNlcmllcyBhZGRzIGluaXRpYWwgSHlnb24gdW5jb3JlIFBNVSBzdXBw
b3J0Lg0KPiANCj4gSHlnb24gdW5jb3JlIFBNVXMgdXNlIGEgcHJvZ3JhbW1pbmcgbW9kZWwgY2xv
c2UgdG8gdGhlIEFNRCB1bmNvcmUgUE1VLCANCj4gc28gdGhpcyBzZXJpZXMgZmFjdG9ycyBvdXQg
YSBzbWFsbCBzZXQgb2YgY29tbW9uIGhlbHBlcnMgZm9yIHBlcmYgDQo+IGV2ZW50IGhhbmRsaW5n
LCBjb3VudGVyIGFzc2lnbm1lbnQgYW5kIHBlci1DUFUgY29udGV4dCBtYW5hZ2VtZW50Lg0KPiAN
Cj4gVGhlIEh5Z29uLXNwZWNpZmljIHN1cHBvcnQgaXMga2VwdCBpbiB0aGUgSHlnb24gZHJpdmVy
LiBUaGlzIHNlcmllcyANCj4gc3VwcG9ydHMgdGhlIEh5Z29uIERGIGFuZCBERiBJT0QgUE1Vcy4g
Tm8gSHlnb24tc3BlY2lmaWMgbG9naWMgaXMgDQo+IGFkZGVkIHRvIHRoZSBBTUQgZHJpdmVyLg0K
PiANCj4gQ2hhbmdlcyBzaW5jZSBSRkM6DQo+ICAgLSBBZGRyZXNzIHNhc2hpa28gYm90IHJldmll
dy4NCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gICAtIFJlbmFtZSB0aGUgaGVscGVyIG5hbWVzcGFj
ZSB0byBhbWRfdW5jb3JlX2NvbW1vbl8qIHRvIGF2b2lkDQo+ICAgICBhbiBnZW5lcmljIHVuY29y
ZV9jb21tb25fKiBwcmVmaXgsIGFuZCB0byBrZWVwIGl0IGRpc3RpbmN0DQo+ICAgICBmcm9tIHRo
ZSBleGlzdGluZyBhbWRfdW5jb3JlXyogbmFtZXMuDQo+IA0KPiANCj4gUWkgTGl1ICgzKToNCj4g
ICBwZXJmL3g4Ni9hbWQvdW5jb3JlOiBBZGQgY29tbW9uIFBNVSBoZWxwZXIgZnVuY3Rpb25zDQo+
ICAgcGVyZi94ODYvYW1kL3VuY29yZTogQ29udmVydCBBTUQgZHJpdmVyIHRvIGNvbW1vbiBQTVUg
aGVscGVycw0KPiAgIHBlcmYveDg2L2FtZC91bmNvcmU6IEFkZCBIeWdvbiB1bmNvcmUgUE1VIHN1
cHBvcnQNCj4gDQo+ICBhcmNoL3g4Ni9ldmVudHMvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAg
MTcgKw0KPiAgYXJjaC94ODYvZXZlbnRzL2FtZC9NYWtlZmlsZSAgICAgICAgICAgIHwgICA0ICsN
Cj4gIGFyY2gveDg2L2V2ZW50cy9hbWQvYW1kX3VuY29yZV9jb21tb24uYyB8IDQwMyArKysrKysr
KysrKysrKysrKyAgDQo+IGFyY2gveDg2L2V2ZW50cy9hbWQvYW1kX3VuY29yZV9jb21tb24uaCB8
IDExNCArKysrKw0KPiAgYXJjaC94ODYvZXZlbnRzL2FtZC9oeWdvbl91bmNvcmUuYyAgICAgIHwg
NTU2ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL3g4Ni9ldmVudHMvYW1kL3VuY29y
ZS5jICAgICAgICAgICAgfCA1NzggKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCAgICAgICAgfCAgIDIgKw0KPiAgYXJjaC94ODYvaW5j
bHVkZS9hc20vcGVyZl9ldmVudC5oICAgICAgIHwgIDIwICsNCj4gIGluY2x1ZGUvbGludXgvY3B1
aG90cGx1Zy5oICAgICAgICAgICAgICB8ICAgMyArDQo+ICA5IGZpbGVzIGNoYW5nZWQsIDExOTIg
aW5zZXJ0aW9ucygrKSwgNTA1IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUgDQo+IDEwMDY0NCBh
cmNoL3g4Ni9ldmVudHMvYW1kL2FtZF91bmNvcmVfY29tbW9uLmMNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL3g4Ni9ldmVudHMvYW1kL2FtZF91bmNvcmVfY29tbW9uLmgNCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL3g4Ni9ldmVudHMvYW1kL2h5Z29uX3VuY29yZS5jDQoNCkknbSBzdXJl
IFJhdmkgYW5kIFNhbmRpcGFuIHdpbGwgZ2l2ZSB5b3UgbW9yZSBpbmRlcHRoIGNvbW1lbnRzIGJ1
dCB0aGUgZ2VuZXJhbCBkaXJlY3Rpb24gd2l0aCByZXVzaW5nIEFNRCBjb2RlIG9uIEh5Z29uIGlz
IHRvIGNvcHkgaXQgZmlyc3QgZm9yIHlvdXIgcHVycG9zZXMgYW5kLCBsYXRlciwgd2hlbiBpdCB0
dXJucyBvdXQgdGhlIGhlbHBlcnMgZG8gcmVtYWluIGlkZW50aWNhbCwgdGhlbiB0byBtZXJnZSB0
aGVtLg0KDQpWcyBkZWZpbmluZyBjb21tb24gaGVscGVycyBub3cgYW5kIHN0aWZsaW5nIHlvdXIg
YW5kIEFNRCBkZXZlbG9wbWVudCBieSB0cnlpbmcgdG8gc2hvZWhvcm4gY29tbW9uIGhlbHBlcnMg
d2l0aCBhbiBhcmNoaXRlY3R1cmUgd2hpY2ggaXMgaGVyZSBhbmQgdGhlcmUgYSBiaXQgZGlmZmVy
ZW50Lg0KDQpBbHNvLCBJJ20gbm90IHN1cmUgYWJvdXQgYWxsIHRob3NlIGV4cG9ydCBzeW1ib2xz
IGd1bmsgLSB3aHkgd291bGQgY29tbW9uIGV2ZW50cyBoZWxwZXJzIG5lZWQgZXhwb3J0cyB0byBt
b2R1bGVzIGJ1dCBtZWgsIFBldGVyIHdpbGwgZ2l2ZSBoaXMgdGhvdWdodHMgaGVyZS4NCg0KQWxz
bywgU2FzaGlrbyBoYXMgY29tbWVudHM6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAy
NjA3MDEwOTQ4MDguNUM4QkMxRjAwMEU5QHNtdHAua2VybmVsLm9yZw0KDQpUaHguDQoNCi0tDQpS
ZWdhcmRzL0dydXNzLA0KICAgIEJvcmlzLg0KDQpodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3Rn
bHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KDQoNCg0K

