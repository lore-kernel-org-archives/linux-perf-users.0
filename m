From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH 0/6] perf/imx_ddr: Add namespace for i.MX8 DDR Perf
Date: Fri, 17 Apr 2020 08:29:56 +0000
Message-ID: <DB8PR04MB6795285BBB9DC3A7198C23DDE6D90@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20200222104621.2258-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB4618C0A8DD9BAB2A529CDCECE6EA0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <a2cc0772-4f5d-aba3-1f5c-7d4eef7a3f72@huawei.com>
 <DB7PR04MB461803AD15E47AA880F0915DE6EA0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <55836919-41b5-0834-f7a7-1a2a34535677@huawei.com>
 <bd67910e-1522-39cd-5527-b9b18f3da96d@huawei.com>
 <DB8PR04MB6795996085AD2167E2358907E6C30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <ccab39b0-c84f-e529-4067-07466b5433a1@huawei.com>
 <VI1PR04MB68000808CEE4BC23403C35A0E6C00@VI1PR04MB6800.eurprd04.prod.outlook.com>
 <ca2db002-975a-ffe0-2dfc-c85f4e6205bb@huawei.com>
 <VI1PR04MB6800F2A5949F0AFAF2E82CE0E6C00@VI1PR04MB6800.eurprd04.prod.outlook.com>
 <0b3999b8-c307-6b4a-1a1b-e90b45f50b61@huawei.com>
 <DB8PR04MB67957F63165ACC0483F6AE39E6D80@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <8341b035-2fac-52dd-45d1-2bf6f5ea4ba4@huawei.com>
 <DB8PR04MB67952380E7240167C7E81178E6D90@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <1952b369-f3fd-845f-650b-3c0464e37016@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <1952b369-f3fd-845f-650b-3c0464e37016@huawei.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: John Garry <john.garry@huawei.com>, "irogers@google.com" <irogers@google.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Zhangshaokun <zhangshaokun@hisilicon.com>, "will@kernel.org" <will@kernel.org>, Linuxarm <linuxarm@huawei.com>, "acme@kernel.org" <acme@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Jiri Olsa <jolsa@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-perf-users.vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMOW5tDTmnIgxN+aXpSAxNjoxNQ0KPiBUbzog
Sm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IGlyb2dlcnNAZ29vZ2xlLmNv
bQ0KPiBDYzogd2lsbEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgYWNtZUBrZXJu
ZWwub3JnOw0KPiBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT47IEppcmkgT2xzYQ0KPiA8am9sc2FAcmVkaGF0LmNvbT47IFpo
YW5nc2hhb2t1biA8emhhbmdzaGFva3VuQGhpc2lsaWNvbi5jb20+Ow0KPiBMaW51eGFybSA8bGlu
dXhhcm1AaHVhd2VpLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNl0gcGVyZi9pbXhfZGRyOiBBZGQgbmFtZXNwYWNlIGZv
ciBpLk1YOCBERFIgUGVyZg0KPiANCj4gT24gMTcvMDQvMjAyMCAwNjo0OSwgSm9ha2ltIFpoYW5n
IHdyb3RlOg0KPiA+PiAgIHNtbXV2M19wbWNnLnRyYW5zYWN0aW9uICAoNDkuNTYlKQ0KPiA+PiAx
MjQ5MDI0NzMgICAgICBzbW11djNfcG1jZy5jeWNsZXMgICAgICAgKDQ5LjU2JSkNCj4gPj4NCj4g
Pj4gICAgICAgICAgMS4wMDExNjcyNDYgc2Vjb25kcyB0aW1lIGVsYXBzZWQNCj4gPj4NCj4gPj4g
U28geW91IGNhbiBjb21wYXJlIHRoaXMgdG8geW91cnMuDQo+ID4+DQo+ID4+IEkgZGlkIGhhdmUg
dG8gZml4IHdoYXQgbG9va3MgbGlrZSBhIGJ1ZyBpbiBtYWlubGluZSBvbiB0aGF0IGJyYW5jaDoN
Cj4gPiBUZXN0ZWQgb24gcHJpdmF0ZS10b3BpYy1wZXJmLTUuNy1zeXMtcG11LWV2ZW50cy12MS1k
ZWJ1ZyBicmFuY2gsIEREUiBQZXJmDQo+IGNhbiB3b3JrIG5vdywgdGhhbmtzLg0KPiA+IFBsZWFz
ZSByZW1lbWJlciB0byB1cGRhdGUgSlNPTiBmaWxlcyB3aGljaCBub3RpZmllZCBiZWZvcmUuDQo+
ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gSm9ha2ltIFpoYW5nDQo+ID4+IC0tLT44LS0tLS0N
Cj4gDQo+IA0KPiBvaywgZ29vZC4gU28gd2l0aG91dCB0aGlzIGZpeCBJIHN1cHBsaWVkLCBpdCBk
aWQgc3RpbGwgbG9vayB0byB3b3JrIGZvciBtZSwgYnV0IHdpbGwNCj4gbG90cyBvZiBjb21wbGFp
bmluZyBmcm9tIHBlcmYuDQoNCkFncmVlIQ0KDQo+IEFueXdheSwgSSdsbCBsb29rIHRvIHNlbmQg
dGhpcyBzZXJpZXMgc29vbiwgYW5kIEknbGwgdXBkYXRlIHRoZSBpbXggSlNPTnMgYXMNCj4gcmVx
dWVzdGVkLiBZb3Ugd2lsbCBuZWVkIHRvIHRoZW4gYWRkIGEgZnJlc2ggc2lnbmVkLW9mZi1ieSB0
byB3aGF0IEkgc2VuZC4NCg0KRmVlbCBmcmVlIGFkZCBteSBzaWduZWQtb2ZmLWJ5IHRhZyBkaXJl
Y3RseToNCglTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAu
Y29tPg0KDQpBZnRlciB0ZXN0LCBJIHdpbGwgZ2l2ZSBteSBUZXN0ZWQtYnkgdGFnLg0KDQpUaGFu
a3MuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiB0aGFua3MsDQo+IGpvaG4NCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
