Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137E1A08C4;
	Thu, 12 Sep 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139423; cv=none; b=R0im5MJXJwvCAoZC/nHaz1g762AqqH/AfpUFio0zVMylYZUvKoVTiDZGtUWp82/00U2e8jaY4alBX7ugvIwFFZQmn66CREYibiFwBNotqtwGXwf4aBLLpkK12LBU0vV1zHa7AewW3M9g4W+wT4ZDT4dr1vpV/Wip8D1rehmxPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139423; c=relaxed/simple;
	bh=L3MUCMKtkTguWF9pBToUYcRy9e1ieedTm1iuky8Pw6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nirHP20INJsrAkkmJ1RHmtq22TeCakb+V26qhn++ZpbxykCnYCTZug3Co6+fy1GneO3LZdznC+JrrMlw6OYLa/VJSzcuOVkF1plq88ACEcnWyYKFp+WJTxSpmZbbBA9zIIXKguVTQ6Dx8ONyqPiWIzPjX6QsgKMZWw7uTykvBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X4F8W64g6z20lDc;
	Thu, 12 Sep 2024 19:10:03 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E2B3214013B;
	Thu, 12 Sep 2024 19:10:10 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 12 Sep 2024 19:10:10 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Thu, 12 Sep 2024 19:10:10 +0800
From: duchangbin <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: duchangbin <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, "Liang, Kan"
	<kan.liang@linux.intel.com>, "Nick Desaulniers" <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "Wanghui (OS Kernel Lab,
 Beijing)" <hw.huiwang@huawei.com>
Subject: Re: [PATCH v6 8/8] perf buildid-cache: recognize vdso when adding
 files
Thread-Topic: [PATCH v6 8/8] perf buildid-cache: recognize vdso when adding
 files
Thread-Index: AQHa3jimIYtCUWpsdU+ECcILatWtFrJSACMAgAJL8QA=
Date: Thu, 12 Sep 2024 11:10:10 +0000
Message-ID: <953cc060c1a24e36abf797918824d13e@huawei.com>
References: <20240725021549.880167-1-changbin.du@huawei.com>
 <20240725021549.880167-9-changbin.du@huawei.com>
 <68f29f30-f0f8-4cda-a99a-68f51838dcd7@intel.com>
In-Reply-To: <68f29f30-f0f8-4cda-a99a-68f51838dcd7@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <674352206418F4468498DA60930A32B9@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgMTE6MDU6MjBBTSArMDMwMCwgQWRyaWFuIEh1bnRlciB3
cm90ZToNCj4gT24gMjUvMDcvMjQgMDU6MTUsIENoYW5nYmluIER1IHdyb3RlOg0KPiA+IElkZW50
aWZ5IHZkc28gYnkgZmlsZSBuYW1lIG1hdGNoaW5nLiBUaGUgdmRzbyBvYmplY3RzIGhhdmUgbmFt
ZQ0KPiA+IGFzIHZkc29bMzIsNjRdLnNvWy5kYmddLg0KPiA+IA0KPiA+ICQgcGVyZiBidWlsZGlk
LWNhY2hlIC1hIC93b3JrL2xpbnV4L2FyY2gveDg2L2VudHJ5L3Zkc28vdmRzbzY0LnNvLmRiZw0K
PiA+IA0KPiA+IFdpdGhvdXQgdGhpcyBjaGFuZ2UsIGFkZGluZyB2ZHNvIHVzaW5nIGFib3ZlIGNv
bW1hbmQgYWN0dWFsbHkgd2lsbCBuZXZlcg0KPiA+IGJlIHVzZWQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogQ2hhbmdiaW4gRHUgPGNoYW5nYmluLmR1QGh1YXdlaS5jb20+DQo+IA0KPiBBIGNv
dXBsZSBvZiBjb21tZW50cywgYnV0IGFkZHJlc3MgdGhvc2UgdGhlbiBhZGQ6DQo+IA0KPiBSZXZp
ZXdlZC1ieTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IA0KPiA+
IC0tLQ0KPiA+ICB0b29scy9wZXJmL2J1aWx0aW4tYnVpbGRpZC1jYWNoZS5jIHwgMjYgKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9idWls
dGluLWJ1aWxkaWQtY2FjaGUuYyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi1idWlsZGlkLWNhY2hlLmMN
Cj4gPiBpbmRleCBiMDUxMWQxNmFlYjYuLjhlZGVhOTA0NGE2NSAxMDA2NDQNCj4gPiAtLS0gYS90
b29scy9wZXJmL2J1aWx0aW4tYnVpbGRpZC1jYWNoZS5jDQo+ID4gKysrIGIvdG9vbHMvcGVyZi9i
dWlsdGluLWJ1aWxkaWQtY2FjaGUuYw0KPiA+IEBAIC0xNzIsNiArMTcyLDMwIEBAIHN0YXRpYyBp
bnQgYnVpbGRfaWRfY2FjaGVfX2FkZF9rY29yZShjb25zdCBjaGFyICpmaWxlbmFtZSwgYm9vbCBm
b3JjZSkNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgYm9vbCBm
aWxlbmFtZV9pc192ZHNvKGNvbnN0IGNoYXIgKmZpbGVuYW1lKQ0KPiA+ICt7DQo+ID4gKwljaGFy
ICpmbmFtZSwgKmJuYW1lOw0KPiA+ICsJc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCB2ZHNvX25h
bWVzW10gPSB7DQo+ID4gKwkJInZkc28uc28iLCAidmRzbzMyLnNvIiwgInZkc282NC5zbyIsICJ2
ZHNveDMyLnNvIg0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwlmbmFtZSA9IHN0cmR1cChmaWxlbmFt
ZSk7DQo+ID4gKwlpZiAoIWZuYW1lKSB7DQo+ID4gKwkJcHJfZXJyKCJubyBtZW1lbW9yeVxuIik7
DQo+IA0KPiBtZW1lbW9yeSAtPiBtZW1vcnkNCj4NCmZpeGVkLg0KDQo+ID4gKwkJcmV0dXJuIGZh
bHNlOw0KPiA+ICsJfQ0KPiANCj4gZm5hbWUgaXMgbmV2ZXIgZnJlZWQuDQo+IA0KZml4ZWQuDQoN
Cj4gPiArDQo+ID4gKwlibmFtZSA9IGJhc2VuYW1lKGZuYW1lKTsNCj4gPiArCWlmICghYm5hbWUp
DQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsNCj4gPiArCWZvciAodW5zaWduZWQgaW50IGkg
PSAwOyBpIDwgQVJSQVlfU0laRSh2ZHNvX25hbWVzKTsgaSsrKSB7DQo+IA0KPiAndW5zaWduZWQn
IGlzIHVubmVjZXNzYXJ5DQo+IA0KVGhpcyBpcyByZXF1aXJlZCB0byBzdXByZXNzIHRoaXMgZXJy
b3IuDQplcnJvcjogY29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVu
dCBzaWduZWRuZXNzOiDigJhpbnTigJkgYW5kIOKAmGxvbmcgdW5zaWduZWQgaW504oCZDQoNCj4g
PiArCQlpZiAoIXN0cm5jbXAoYm5hbWUsIHZkc29fbmFtZXNbaV0sIHN0cmxlbih2ZHNvX25hbWVz
W2ldKSkpDQo+IA0KPiBVc2Ugc3Ryc3RhcnRzKCkNCj4gDQpva2F5Lg0KDQo+ID4gKwkJCXJldHVy
biB0cnVlOw0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIGZhbHNlOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICBzdGF0aWMgaW50IGJ1aWxkX2lkX2NhY2hlX19hZGRfZmlsZShjb25zdCBjaGFyICpmaWxlbmFt
ZSwgc3RydWN0IG5zaW5mbyAqbnNpKQ0KPiA+ICB7DQo+ID4gIAljaGFyIHNidWlsZF9pZFtTQlVJ
TERfSURfU0laRV07DQo+ID4gQEAgLTE4OSw3ICsyMTMsNyBAQCBzdGF0aWMgaW50IGJ1aWxkX2lk
X2NhY2hlX19hZGRfZmlsZShjb25zdCBjaGFyICpmaWxlbmFtZSwgc3RydWN0IG5zaW5mbyAqbnNp
KQ0KPiA+ICANCj4gPiAgCWJ1aWxkX2lkX19zcHJpbnRmKCZiaWQsIHNidWlsZF9pZCk7DQo+ID4g
IAllcnIgPSBidWlsZF9pZF9jYWNoZV9fYWRkX3Moc2J1aWxkX2lkLCBmaWxlbmFtZSwgbnNpLA0K
PiA+IC0JCQkJICAgIGZhbHNlLCBmYWxzZSk7DQo+ID4gKwkJCQkgICAgZmFsc2UsIGZpbGVuYW1l
X2lzX3Zkc28oZmlsZW5hbWUpKTsNCj4gPiAgCXByX2RlYnVnKCJBZGRpbmcgJXMgJXM6ICVzXG4i
LCBzYnVpbGRfaWQsIGZpbGVuYW1lLA0KPiA+ICAJCSBlcnIgPyAiRkFJTCIgOiAiT2siKTsNCj4g
PiAgCXJldHVybiBlcnI7DQo+IA0KPiANCg0KLS0gDQpDaGVlcnMsDQpDaGFuZ2JpbiBEdQ0K
