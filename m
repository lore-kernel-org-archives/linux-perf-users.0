From: James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 6/6] perf tools: arm-spe: fix record hang after being
 terminated
Date: Wed, 15 Jan 2020 12:02:10 +0000
Message-ID: <e581ed83-97d2-f37e-b1c1-b13b24e601c8@arm.com>
References: <20191218075455.5106-1-tanxiaojun@huawei.com>
 <20191218075455.5106-7-tanxiaojun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191218075455.5106-7-tanxiaojun@huawei.com>
Content-Language: en-US
Content-ID: <2A8D9264D0A62944978321BDFF361D87@eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tan Xiaojun <tanxiaojun@huawei.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>, "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>, "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>, "songliubraving@fb.com" <songliubraving@fb.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Kim Phillips <Kim.Phillips@arm.com>, Jeremy Linton <Jeremy.Linton@arm.com>
Cc: "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>, "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>, "liwei391@huawei.com" <liwei391@huawei.com>, "liuqi115@hisilicon.com" <liuqi115@hisilicon.com>, "huawei.libin@huawei.com" <huawei.libin@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, nd <nd@arm.com>
List-Id: linux-perf-users.vger.kernel.org

SGkgWGlhb2p1biwNCg0KSSd2ZSB0ZXN0ZWQgdGhpcyBhbmQgaXQgYWxsIHNlZW1zIHRvIGJlIHdv
cmtpbmcgT0suIEkgb25seSBoYXZlIG9uZSBmaW5hbCBjaGFuZ2UgdG8gcHJvcG9zZSwgdGhhdCBp
ZiB3ZSB1bnNldCBwcmVjaXNlX2lwLCBhbG9uZyB3aXRoIHRoaXMgY2hhbmdlIA0KaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LWFybS1rZXJuZWwvMjAyMC1KYW51YXJ5
LzcwNTcyMC5odG1sIHdlIHdpbGwgZ2V0IGZlZWRiYWNrIGlmIGFuIGV2ZW50IGlzIG5vdCBzdXBw
b3J0ZWQgaW4gcHJlY2lzZSBtb2RlLg0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2Fy
bS1zcGUuYyBiL3Rvb2xzL3BlcmYvdXRpbC9hcm0tc3BlLmMNCmluZGV4IDBmY2FlZmQzODZhNi4u
YTNjMjNkMjg5NDgyIDEwMDY0NA0KLS0tIGEvdG9vbHMvcGVyZi91dGlsL2FybS1zcGUuYw0KKysr
IGIvdG9vbHMvcGVyZi91dGlsL2FybS1zcGUuYw0KQEAgLTkzNyw2ICs5MzcsNyBAQCB2b2lkIGFy
bV9zcGVfcHJlY2lzZV9pcF9zdXBwb3J0KHN0cnVjdCBldmxpc3QgKmV2bGlzdCwgc3RydWN0IGV2
c2VsICpldnNlbCkNCiAgICAgICAgICAgICAgICAgICAgICAgIGV2c2VsLT5jb3JlLmF0dHIuY29u
ZmlnID0gU1BFX0FUVFJfVFNfRU5BQkxFDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IFNQRV9BVFRSX0JSQU5DSF9GSUxURVI7DQogICAgICAgICAgICAg
ICAgICAgICAgICBldnNlbC0+Y29yZS5hdHRyLmNvbmZpZzEgPSBTUEVfQVRUUl9FVl9CUkFOQ0g7
DQorICAgICAgICAgICAgICAgICAgICAgICAgZXZzZWwtPmNvcmUuYXR0ci5wcmVjaXNlX2lwID0g
MDsNCiAgICAgICAgICAgICAgICB9DQogICAgICAgIH0NCiB9DQoNClRoYW5rcw0KSmFtZXMNCg0K
T24gMTgvMTIvMjAxOSAwNzo1NCwgVGFuIFhpYW9qdW4gd3JvdGU6DQo+IEZyb206IFdlaSBMaSA8
bGl3ZWkzOTFAaHVhd2VpLmNvbT4NCj4gDQo+IElmIHRoZSBzcGUgZXZlbnQgaXMgdGVybWluYXRl
ZCwgd2UgZG9uJ3QgZW5hYmxlIGl0IGFnYWluIGhlcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBX
ZWkgTGkgPGxpd2VpMzkxQGh1YXdlaS5jb20+DQo+IFRlc3RlZC1ieTogUWkgTGl1IDxsaXVxaTEx
NUBoaXNpbGljb24uY29tPg0KPiAtLS0NCj4gIHRvb2xzL3BlcmYvYXJjaC9hcm02NC91dGlsL2Fy
bS1zcGUuYyB8IDEwICsrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9hcmNoL2Fy
bTY0L3V0aWwvYXJtLXNwZS5jIGIvdG9vbHMvcGVyZi9hcmNoL2FybTY0L3V0aWwvYXJtLXNwZS5j
DQo+IGluZGV4IGViYTY1NDFlYzBmMS4uNjI5YmFkZGE3MjRkIDEwMDY0NA0KPiAtLS0gYS90b29s
cy9wZXJmL2FyY2gvYXJtNjQvdXRpbC9hcm0tc3BlLmMNCj4gKysrIGIvdG9vbHMvcGVyZi9hcmNo
L2FybTY0L3V0aWwvYXJtLXNwZS5jDQo+IEBAIC0xNjUsOSArMTY1LDEzIEBAIHN0YXRpYyBpbnQg
YXJtX3NwZV9yZWFkX2ZpbmlzaChzdHJ1Y3QgYXV4dHJhY2VfcmVjb3JkICppdHIsIGludCBpZHgp
DQo+ICAJc3RydWN0IGV2c2VsICpldnNlbDsNCj4gIA0KPiAgCWV2bGlzdF9fZm9yX2VhY2hfZW50
cnkoc3Blci0+ZXZsaXN0LCBldnNlbCkgew0KPiAtCQlpZiAoZXZzZWwtPmNvcmUuYXR0ci50eXBl
ID09IHNwZXItPmFybV9zcGVfcG11LT50eXBlKQ0KPiAtCQkJcmV0dXJuIHBlcmZfZXZsaXN0X19l
bmFibGVfZXZlbnRfaWR4KHNwZXItPmV2bGlzdCwNCj4gLQkJCQkJCQkgICAgIGV2c2VsLCBpZHgp
Ow0KPiArCQlpZiAoZXZzZWwtPmNvcmUuYXR0ci50eXBlID09IHNwZXItPmFybV9zcGVfcG11LT50
eXBlKSB7DQo+ICsJCQlpZiAoZXZzZWwtPnRlcm1pbmF0ZWQpDQo+ICsJCQkJcmV0dXJuIDA7DQo+
ICsJCQllbHNlDQo+ICsJCQkJcmV0dXJuIHBlcmZfZXZsaXN0X19lbmFibGVfZXZlbnRfaWR4KA0K
PiArCQkJCQkJc3Blci0+ZXZsaXN0LCBldnNlbCwgaWR4KTsNCj4gKwkJfQ0KPiAgCX0NCj4gIAly
ZXR1cm4gLUVJTlZBTDsNCj4gIH0NCj4gDQo=
