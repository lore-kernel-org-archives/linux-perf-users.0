Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424159;
	b=KBznP5zAQ8MhONnVkLxismBNMWJM9CHITQBovGlbmQCQNVQqrYAUwNtpSPENPEy4W8yu
	 ItotI2dZo4nkRYqwmqDfgHCJ5cKeins5sXeci7/ESjfu3pLwqPakKZH5PKtuEUHFLgPG0
	 pQ1nPRViMySftoslTMbfVktX+98zU/JxkbD2gsrkWnXiFiSU7Er51dfpx8Q0oHXGrMeE8
	 swj+1mPiggm6S2J+jeoL78XrH3wYUZzDCxrRqpO+pwc0a1V23jiweb3anLIZGSRucBDLk
	 B1ejmA8aP3hENFeglALbJLtBZqkrWZ4NH3kEnw/FD0+QJ/J+MJcU4EUx2pNfWt8gxWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424159;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=pdCSnO3vFDLEtKHfqKwTbrDh775Mc8mkkHWJ0WsIDsg=;
	b=V9q0zztOAptkKtKvbxlOewS+EObeiQrta4YxOuBmq2hghrZ/UVaD/SvD9l53F3aKL4gS
	 /wiPTkTSoO8r8eByiCZjt6jqMkrG55gxlzZJG9MXQRILrOmHQLNGNkbrDq9fMCPoo74J/
	 GLMNLbVuv3s5aC0+Jn15GCFe9wpR2ByNkhBYwe9g2LBv88KJc6OI2DnO5Y0tpks6LSUZC
	 pRNdddIdtRF4bSWqoQkNBHjVlrP/VY1F+c7CdjQu85rreAyhzwcrtwif7L8gP412t1fIE
	 onS43lckd5SuckS6fpXT/yvqv/WyfRDuw4TUsDzXCYXxjGfkv8BTqZaQxcFdhk78EfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=Tqs2eo2c;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 38E78606A31A;
	Mon, 23 Nov 2026 08:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E78606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=Tqs2eo2c
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.11
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, Atish Patra <atishp@rivosinc.com>, Anup Patel
	<anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBwZXJmIGt2bTogRml4IFJJU0MtViBWTS1leGl0IGR1?=
 =?gb2312?Q?ration_accounting?=
Thread-Topic: [PATCH] perf kvm: Fix RISC-V VM-exit duration accounting
Thread-Index: AQHdaqsYju6/93onaUCoF9GUXgxXLbc7e2zQ
Date: Mon, 23 Nov 2026 08:55:43 +0000
Message-ID: <10d466045b764b7590abaef251df06c1@baidu.com>
References: <20261102091809.2215-1-lirongqing@baidu.com>
In-Reply-To: <20261102091809.2215-1-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1795424150;
	bh=pdCSnO3vFDLEtKHfqKwTbrDh775Mc8mkkHWJ0WsIDsg=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=Tqs2eo2cJ2gC0XqUpwyJOq2mvUT1Cw5+v3HAQtFQr4y2GS0FL9s8vGvMfovqaQPIE
	 fpEFdvaeQLe4Xc+xNNq03CJUt/nqDB7RctPshWzgtUmawnb4rLi2G4ZDCdKYBYEO7t
	 3sxUiIcs4ErMJFU6y2HbzyctchFaibvysDAUKpExcPsEZWcYV4PDeGV4+dkHN/3L+6
	 ywpnoVUd3CvV5rk8/x4H+YiE4qkEV1SC1K83XM/aXaJSeHIA8+jT4TILecNTDAH5eK
	 DQvlWgIh4+6TA3mwFa11CB7sbpg8T1vmIUG6cRumpMALlsKYHAkwNHbeTKBsRPsyx1
	 IboryRSl74vZw==

PiANCj4gRnJvbTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiANCj4gVXNl
IGt2bV9leGl0IGFzIHRoZSBzdGFydCBldmVudCBhbmQgdGhlIGZvbGxvd2luZyBrdm1fZW50cnkg
YXMgdGhlIGVuZA0KPiBldmVudCBmb3IgUklTQy1WIFZNLWV4aXQgc3RhdGlzdGljcy4gS2VlcCBk
ZWNvZGluZyBzY2F1c2UgZnJvbSB0aGUgZXhpdA0KPiBzYW1wbGUuDQo+IA0KPiBCZWZvcmUgdGhp
cyBjaGFuZ2UsIFJJU0MtViBtZWFzdXJlZCBndWVzdCBydW50aW1lIGFzIFZNLWV4aXQgdGltZS4N
Cj4gDQo+IEZpeGVzOiBkYTdiMWI1MjVlOTcgKCJwZXJmIGt2bS9yaXNjdjogUG9ydCBwZXJmIGt2
bSBzdGF0IHRvIFJJU0MtViIpDQo+IFNpZ25lZC1vZmYtYnk6IExpIFJvbmdRaW5nIDxsaXJvbmdx
aW5nQGJhaWR1LmNvbT4NCg0KcGluZyANCg0KW0xpLFJvbmdxaW5nXSANCg0KDQo+IC0tLQ0KPiAg
dG9vbHMvcGVyZi91dGlsL2t2bS1zdGF0LWFyY2gva3ZtLXN0YXQtcmlzY3YuYyB8IDE0ICsrKysr
KystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9rdm0tc3RhdC1hcmNoL2t2
bS1zdGF0LXJpc2N2LmMNCj4gYi90b29scy9wZXJmL3V0aWwva3ZtLXN0YXQtYXJjaC9rdm0tc3Rh
dC1yaXNjdi5jDQo+IGluZGV4IDk2N2JiYTIuLjA5YzljN2QgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L3BlcmYvdXRpbC9rdm0tc3RhdC1hcmNoL2t2bS1zdGF0LXJpc2N2LmMNCj4gKysrIGIvdG9vbHMv
cGVyZi91dGlsL2t2bS1zdGF0LWFyY2gva3ZtLXN0YXQtcmlzY3YuYw0KPiBAQCAtMzEsMTMgKzMx
LDcgQEAgc3RhdGljIHZvaWQgZXZlbnRfZ2V0X2tleShzdHJ1Y3QgcGVyZl9zYW1wbGUNCj4gKnNh
bXBsZSwgIH0NCj4gDQo+ICBzdGF0aWMgYm9vbCBldmVudF9iZWdpbihzdHJ1Y3QgcGVyZl9zYW1w
bGUgKnNhbXBsZSwNCj4gLQkJCXN0cnVjdCBldmVudF9rZXkgKmtleSBfX21heWJlX3VudXNlZCkN
Cj4gLXsNCj4gLQlyZXR1cm4gZXZzZWxfX25hbWVfaXMoc2FtcGxlLT5ldnNlbCwga3ZtX2VudHJ5
X3RyYWNlKEVNX1JJU0NWKSk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBib29sIGV2ZW50X2VuZChz
dHJ1Y3QgcGVyZl9zYW1wbGUgKnNhbXBsZSwNCj4gLQkJICAgICAgc3RydWN0IGV2ZW50X2tleSAq
a2V5KQ0KPiArCQkJc3RydWN0IGV2ZW50X2tleSAqa2V5KQ0KPiAgew0KPiAgCWlmIChldnNlbF9f
bmFtZV9pcyhzYW1wbGUtPmV2c2VsLCBrdm1fZXhpdF90cmFjZShFTV9SSVNDVikpKSB7DQo+ICAJ
CWV2ZW50X2dldF9rZXkoc2FtcGxlLCBrZXkpOw0KPiBAQCAtNDYsNiArNDAsMTIgQEAgc3RhdGlj
IGJvb2wgZXZlbnRfZW5kKHN0cnVjdCBwZXJmX3NhbXBsZSAqc2FtcGxlLA0KPiAgCXJldHVybiBm
YWxzZTsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgYm9vbCBldmVudF9lbmQoc3RydWN0IHBlcmZfc2Ft
cGxlICpzYW1wbGUsDQo+ICsJCSAgICAgIHN0cnVjdCBldmVudF9rZXkgKmtleSBfX21heWJlX3Vu
dXNlZCkgew0KPiArCXJldHVybiBldnNlbF9fbmFtZV9pcyhzYW1wbGUtPmV2c2VsLCBrdm1fZW50
cnlfdHJhY2UoRU1fUklTQ1YpKTsgfQ0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGt2bV9l
dmVudHNfb3BzIGV4aXRfZXZlbnRzID0gew0KPiAgCS5pc19iZWdpbl9ldmVudCA9IGV2ZW50X2Jl
Z2luLA0KPiAgCS5pc19lbmRfZXZlbnQJPSBldmVudF9lbmQsDQo+IC0tDQo+IDIuOS40DQoNCg==
