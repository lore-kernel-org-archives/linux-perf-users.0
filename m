Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4250BA21;
	Thu,  5 Mar 2026 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701349; cv=none; b=iewYEwye8+ohbwjvHInrav3hVD/kh5xmGr+0biZNQxas9Syls/1xpVCRqpwdsLR8nH0L8bVbc47hmynCOlSsm0LZZh39UHULx4rVzZFxETlalpiQ7ZJNFa/+WJSKWOBPJ6URTPyt4WbNy9hNXFqMoq4Wq41iOCuPVl4v3Dv7PUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701349; c=relaxed/simple;
	bh=l665niY4fjbYT4SMS/ny9uoFatDgmnrBtS9TpBtyjP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7aiMJNPf2UyyvqgRboCyqZxGZJEFsn64KYDaiNFuxYVA0069zEx8yaUm5i7r9QOzzeymFkTSt47WUoiUgXnwkYxOXY1iQW917oXv5djzFUteTMkI8WD3a2GWJ4/7Yl5fkoqfGm0nWDxmb6+pNYtMkcnzzHvUFDua/V33j2OL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wPfi/a/Z; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wPfi/a/Z"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l665niY4fjbYT4SMS/ny9uoFatDgmnrBtS9TpBtyjP0=;
	b=wPfi/a/Z8/OXDB5YgL+MEwJvQWTP7tTOa/yPQbN5/mm/aD2ahnocSGQNahK3Ms+19SueGwTtH
	T2QZ+sIOXUMNUthaohIRhDAYrakZoQRpfJ7NjjSUQtLfDW9OT4gKHfFhOcPmW8KBZEGAvefxey7
	Lfomm8skJJnYSk2U3xNZKhc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fRNhh3rMRz1prR4;
	Thu,  5 Mar 2026 16:57:24 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F1CC40561;
	Thu,  5 Mar 2026 17:02:18 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Mar 2026 17:02:18 +0800
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Mar 2026 17:02:17 +0800
Received: from kwepemq200002.china.huawei.com ([7.202.195.90]) by
 kwepemq200002.china.huawei.com ([7.202.195.90]) with mapi id 15.02.1544.011;
 Thu, 5 Mar 2026 17:02:17 +0800
From: duchangbin <changbin.du@huawei.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: duchangbin <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf: Add layout support for --symfs option
Thread-Topic: [PATCH v3] perf: Add layout support for --symfs option
Thread-Index: AQHcqWv7qgRFvdXDEU29kITXQZ801LWe/w8AgACrhIA=
Date: Thu, 5 Mar 2026 09:02:17 +0000
Message-ID: <dd08137f2d2e4d39a37d4c50552f8a86@huawei.com>
References: <20260301192455.1053900-1-changbin.du@huawei.com>
 <aaknIOp-PrDNCf-L@z2>
In-Reply-To: <aaknIOp-PrDNCf-L@z2>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemq200002.china.huawei.com (15.02.1544.011)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCC984BD3C93074A88675772F43A3D12@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCBNYXIgMDQsIDIwMjYgYXQgMTA6NDg6MDBQTSAtMDgwMCwgTmFtaHl1bmcgS2ltIHdy
b3RlOg0KPiBIZWxsbywNCj4gDQo+ID4gQEAgLTI0OTEsMTYgKzI0OTIsMzYgQEAgaW50IHN5bWJv
bF9fY29uZmlnX3N5bWZzKGNvbnN0IHN0cnVjdCBvcHRpb24gKm9wdCBfX21heWJlX3VudXNlZCwN
Cj4gPiAgCQkJIGNvbnN0IGNoYXIgKmRpciwgaW50IHVuc2V0IF9fbWF5YmVfdW51c2VkKQ0KPiA+
ICB7DQo+ID4gIAljaGFyICpiZiA9IE5VTEw7DQo+ID4gKwljaGFyICpsYXlvdXRfc3RyOw0KPiA+
ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gLQlzeW1ib2xfY29uZi5zeW1mcyA9IHN0cmR1cChkaXIp
Ow0KPiA+IC0JaWYgKHN5bWJvbF9jb25mLnN5bWZzID09IE5VTEwpDQo+ID4gLQkJcmV0dXJuIC1F
Tk9NRU07DQo+ID4gKwlsYXlvdXRfc3RyID0gc3RycmNocihkaXIsICcsJyk7DQo+ID4gKwlpZiAo
bGF5b3V0X3N0ciAmJg0KPiA+ICsJICAgICghc3RyY21wKGxheW91dF9zdHIgKyAxLCAiZmxhdCIp
IHx8ICFzdHJjbXAobGF5b3V0X3N0ciArIDEsICJoaWVyYXJjaHkiKSkpIHsNCj4gDQo+IEkgdGhp
bmsgaXQncyBiZXR0ZXIgdG8gZmFpbCB3aXRoIGEgbWVzc2FnZSBpZiB1bmtub3duIGxheW91dCBp
cyBnaXZlbi4NCj4NCkFncmVlZC4gVGhlIGN1cnJlbnQgaXNzdWUgaXMgdGhhdCBpZiB3ZSB1c2Ug
JywnIGFzIHRoZSBkZWxpbWl0ZXIgKHRvIG1haW50YWluIGENCmNvbnNpc3RlbnQgc3R5bGUgd2l0
aCBvdGhlciBvcHRpb25zKSwgYW5kIHRoZSBwYXRoIGl0c2VsZiBjb250YWlucyBhIGNvbW1hLCBp
dA0Kd291bGQgcmVzdWx0IGluIHRoZSBmb2xsb3dpbmcgYW1iaWd1aXR5Og0KIC0gL3BhdGgsZmxh
dCDihpIgc3ltZnM9L3BhdGgsIGxheW91dD1mbGF0DQogLSAvcGF0aCxoaWVyYXJjaHkg4oaSIHN5
bWZzPS9wYXRoLCBsYXlvdXQ9aGllcmFyY2h5DQogLSAvc29tZSxwYXRoLyDihpIgc3ltZnM9L3Nv
bWUsIGxheW91dD1wYXRoLw0KDQpEbyB5b3UgaGF2ZSBiZXR0ZXIgc3VnZ2VzdGlvbnM/IFVzaW5n
IGEgZGlmZmVyZW50IGRlbGltaXRlciAoZS5nLiwgOiBvciA7KT8NCg0KPiBUaGFua3MsDQo+IE5h
bWh5dW5nDQo+IA0KPiA+ICsJCXNpemVfdCBkaXJfbGVuID0gbGF5b3V0X3N0ciAtIGRpcjsNCj4g
PiArCQljaGFyICpkaXJfY29weSA9IHN0cm5kdXAoZGlyLCBkaXJfbGVuKTsNCj4gPiArDQo+ID4g
KwkJaWYgKGRpcl9jb3B5ID09IE5VTEwpDQo+ID4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsN
Cj4gPiArCQlzeW1ib2xfY29uZi5zeW1mcyA9IGRpcl9jb3B5Ow0KPiA+ICsNCj4gPiArCQlsYXlv
dXRfc3RyKys7DQo+ID4gKwkJaWYgKCFzdHJjbXAobGF5b3V0X3N0ciwgImZsYXQiKSkNCj4gPiAr
CQkJc3ltYm9sX2NvbmYuc3ltZnNfbGF5b3V0X2ZsYXQgPSB0cnVlOw0KPiA+ICsJCWVsc2UNCj4g
PiArCQkJc3ltYm9sX2NvbmYuc3ltZnNfbGF5b3V0X2ZsYXQgPSBmYWxzZTsNCj4gPiArCX0gZWxz
ZSB7DQo+ID4gKwkJc3ltYm9sX2NvbmYuc3ltZnMgPSBzdHJkdXAoZGlyKTsNCj4gPiArCQlpZiAo
c3ltYm9sX2NvbmYuc3ltZnMgPT0gTlVMTCkNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4g
KwkJc3ltYm9sX2NvbmYuc3ltZnNfbGF5b3V0X2ZsYXQgPSBmYWxzZTsNCj4gPiArCX0NCj4gPiAg
DQo+ID4gIAkvKiBza2lwIHRoZSBsb2NhbGx5IGNvbmZpZ3VyZWQgY2FjaGUgaWYgYSBzeW1mcyBp
cyBnaXZlbiwgYW5kDQo+ID4gIAkgKiBjb25maWcgYnVpbGRpZCBkaXIgdG8gc3ltZnMvLmRlYnVn
DQo+ID4gIAkgKi8NCj4gPiAtCXJldCA9IGFzcHJpbnRmKCZiZiwgIiVzLyVzIiwgZGlyLCAiLmRl
YnVnIik7DQo+ID4gKwlyZXQgPSBhc3ByaW50ZigmYmYsICIlcy8lcyIsIHN5bWJvbF9jb25mLnN5
bWZzLCAiLmRlYnVnIik7DQo+ID4gIAlpZiAocmV0IDwgMCkNCj4gPiAgCQlyZXR1cm4gLUVOT01F
TTsNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9zeW1ib2wuaCBiL3Rv
b2xzL3BlcmYvdXRpbC9zeW1ib2wuaA0KPiA+IGluZGV4IDNmYjVkMTQ2ZDliMS4uNGYxZGJkMWVi
ZDk5IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9zeW1ib2wuaA0KPiA+ICsrKyBi
L3Rvb2xzL3BlcmYvdXRpbC9zeW1ib2wuaA0KPiA+IEBAIC05LDYgKzksNyBAQA0KPiA+ICAjaW5j
bHVkZSA8bGludXgvbGlzdC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmJ0cmVlLmg+DQo+ID4g
ICNpbmNsdWRlIDxzdGRpby5oPg0KPiA+ICsjaW5jbHVkZSA8ZXJybm8uaD4NCj4gPiAgI2luY2x1
ZGUgImFkZHJfbG9jYXRpb24uaCINCj4gPiAgI2luY2x1ZGUgInBhdGguaCINCj4gPiAgI2luY2x1
ZGUgInN5bWJvbF9jb25mLmgiDQo+ID4gQEAgLTk2LDYgKzk3LDE4IEBAIHN0cnVjdCBpbnRsaXN0
Ow0KPiA+ICANCj4gPiAgc3RhdGljIGlubGluZSBpbnQgX19zeW1ib2xfX2pvaW5fc3ltZnMoY2hh
ciAqYmYsIHNpemVfdCBzaXplLCBjb25zdCBjaGFyICpwYXRoKQ0KPiA+ICB7DQo+ID4gKwlpZiAo
c3ltYm9sX2NvbmYuc3ltZnNfbGF5b3V0X2ZsYXQpIHsNCj4gPiArCQljaGFyICpwYXRoX2NvcHkg
PSBzdHJkdXAocGF0aCk7DQo+ID4gKwkJY2hhciAqYmFzZTsNCj4gPiArCQlpbnQgcmV0Ow0KPiA+
ICsNCj4gPiArCQlpZiAoIXBhdGhfY29weSkNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4g
KwkJYmFzZSA9IGJhc2VuYW1lKHBhdGhfY29weSk7DQo+ID4gKwkJcmV0ID0gcGF0aF9fam9pbihi
Ziwgc2l6ZSwgc3ltYm9sX2NvbmYuc3ltZnMsIGJhc2UpOw0KPiA+ICsJCWZyZWUocGF0aF9jb3B5
KTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICAJcmV0dXJuIHBhdGhfX2pvaW4o
YmYsIHNpemUsIHN5bWJvbF9jb25mLnN5bWZzLCBwYXRoKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiBA
QCAtMTY5LDYgKzE4MiwxMSBAQCBzaXplX3Qgc3ltYm9sX19mcHJpbnRmX3N5bW5hbWUoY29uc3Qg
c3RydWN0IHN5bWJvbCAqc3ltLCBGSUxFICpmcCk7DQo+ID4gIHNpemVfdCBzeW1ib2xfX2Zwcmlu
dGYoc3RydWN0IHN5bWJvbCAqc3ltLCBGSUxFICpmcCk7DQo+ID4gIGJvb2wgc3ltYm9sX19yZXN0
cmljdGVkX2ZpbGVuYW1lKGNvbnN0IGNoYXIgKmZpbGVuYW1lLA0KPiA+ICAJCQkJIGNvbnN0IGNo
YXIgKnJlc3RyaWN0ZWRfZmlsZW5hbWUpOw0KPiA+ICsNCj4gPiArI2RlZmluZSBTWU1GU19IRUxQ
ICJzZXR1cCByb290IGRpcmVjdG9yeSB3aGljaCBjb250YWlucyBkZWJ1ZyBmaWxlczpcbiIgXA0K
PiA+ICsJIlx0XHRcdFx0IiAiZGlyZWN0b3J5Olx0TG9vayBmb3IgZmlsZXMgd2l0aCBzeW1ib2xz
IHJlbGF0aXZlIHRvIHRoaXMgZGlyZWN0b3J5LlxuIiBcDQo+ID4gKwkiXHRcdFx0XHQiICJsYXlv
dXQ6ICAgXHRMYXlvdXQgb2YgZmlsZXMsICdoaWVyYXJjaHknIG1hdGNoZXMgZnVsbCBwYXRoIChk
ZWZhdWx0KSwgJ2ZsYXQnIG9ubHkgbWF0Y2hlcyBiYXNlIG5hbWUuXG4iDQo+ID4gKw0KPiA+ICBp
bnQgc3ltYm9sX19jb25maWdfc3ltZnMoY29uc3Qgc3RydWN0IG9wdGlvbiAqb3B0IF9fbWF5YmVf
dW51c2VkLA0KPiA+ICAJCQkgY29uc3QgY2hhciAqZGlyLCBpbnQgdW5zZXQgX19tYXliZV91bnVz
ZWQpOw0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL3N5bWJvbF9jb25m
LmggYi90b29scy9wZXJmL3V0aWwvc3ltYm9sX2NvbmYuaA0KPiA+IGluZGV4IDcxYmIxNzM3MmE2
Yy4uYWMxYjQ0NGE4ZmQ4IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9zeW1ib2xf
Y29uZi5oDQo+ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL3N5bWJvbF9jb25mLmgNCj4gPiBAQCAt
OTMsNiArOTMsNyBAQCBzdHJ1Y3Qgc3ltYm9sX2NvbmYgew0KPiA+ICAJCQkqdGlkX2xpc3QsDQo+
ID4gIAkJCSphZGRyX2xpc3Q7DQo+ID4gIAljb25zdCBjaGFyCSpzeW1mczsNCj4gPiArCWJvb2wJ
CXN5bWZzX2xheW91dF9mbGF0Ow0KPiA+ICAJaW50CQlyZXNfc2FtcGxlOw0KPiA+ICAJaW50CQlw
YWRfb3V0cHV0X2xlbl9kc287DQo+ID4gIAlpbnQJCWdyb3VwX3NvcnRfaWR4Ow0KPiA+IC0tIA0K
PiA+IDIuNDMuMA0KPiA+IA0KPiANCg0KLS0gDQpDaGVlcnMsDQpDaGFuZ2JpbiBEdQ0K
