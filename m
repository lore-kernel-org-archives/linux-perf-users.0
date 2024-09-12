Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B0184558;
	Thu, 12 Sep 2024 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134888; cv=none; b=Jfh2Q6L0+tLpXH8SEyu24SNgHvxuo8vQus4bsoEQ2cCP8wRnQfhrB7wumUq5HaNVUZMzh/aXqJdkTuQoXVqBkiiRBiIXwz7h21OBoSvwl9u/9K5QCYxZMthqlDJpqFdJYasIZOY2V6X1BIfN4cKStziCxKrvu/KL9iJTXBUvYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134888; c=relaxed/simple;
	bh=b4QTAz5snlatzUhbRAUxPDYebjaCYwwojI+ef5Tcn3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lu+RO58z2KiXSN79pcFBvFju5+F4GiXZFphagVH3JMO0iPjvHdEDR5KMXwvo5DWbVbgX/1PS7q82O7OBBQXmsNuw6atqU38LBAitwwGQQVTlABFus0Dr8bY8e8UQLjPUAg5ajw2SQzguGAxESAr3UAepeUT1y3sbGVeAP7omrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X4CQx1sVHzfc21;
	Thu, 12 Sep 2024 17:52:25 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 42C05140390;
	Thu, 12 Sep 2024 17:54:36 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 12 Sep 2024 17:54:35 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Thu, 12 Sep 2024 17:54:35 +0800
From: duchangbin <changbin.du@huawei.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: James Clark <james.clark@linaro.org>, duchangbin <changbin.du@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf ftrace: Detect whether ftrace is enabled on
 system
Thread-Topic: [PATCH v2] perf ftrace: Detect whether ftrace is enabled on
 system
Thread-Index: AQHbBDGecvxeNbxUKk+LVH61YHizzLJR2IKAgAAl6wCAAeyYAA==
Date: Thu, 12 Sep 2024 09:54:35 +0000
Message-ID: <b0d2446f5eed4c0b91cd853ea8033417@huawei.com>
References: <20240911100126.900779-1-changbin.du@huawei.com>
 <c37492e5-6a1a-4506-810c-ec59056ee85b@linaro.org> <ZuGNhhzlTaAQaZXj@x1>
In-Reply-To: <ZuGNhhzlTaAQaZXj@x1>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <046E3428A206EA478A8DFF5DBDAE3668@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgMDk6MzE6MDJBTSAtMDMwMCwgQXJuYWxkbyBDYXJ2YWxo
byBkZSBNZWxvIHdyb3RlOg0KPiBPbiBXZWQsIFNlcCAxMSwgMjAyNCBhdCAxMToxNToxOUFNICsw
MTAwLCBKYW1lcyBDbGFyayB3cm90ZToNCj4gPiBPbiAxMS8wOS8yMDI0IDExOjAxLCBDaGFuZ2Jp
biBEdSB3cm90ZToNCj4gPiA+IFRvIG1ha2UgZXJyb3IgbWVzc2FnZXMgbW9yZSBhY2N1cmF0ZSwg
dGhpcyBjaGFuZ2UgZGV0ZWN0cyB3aGV0aGVyIGZ0cmFjZSBpcw0KPiA+ID4gZW5hYmxlZCBvbiBz
eXN0ZW0gYnkgY2hlY2tpbmcgdHJhY2UgZmlsZSAic2V0X2Z0cmFjZV9waWQiLg0KPiANCj4gPFNO
SVA+DQo+IA0KPiA+ID4gQEAgLTE1ODMsNiArMTYwMSwxMSBAQCBpbnQgY21kX2Z0cmFjZShpbnQg
YXJnYywgY29uc3QgY2hhciAqKmFyZ3YpDQo+ID4gPiAgIAlpZiAoIWNoZWNrX2Z0cmFjZV9jYXBh
YmxlKCkpDQo+ID4gPiAgIAkJcmV0dXJuIC0xOw0KPiA+ID4gKwlpZiAoIWlzX2Z0cmFjZV9zdXBw
b3J0ZWQoKSkgew0KPiA+ID4gKwkJcHJfZXJyKCJmdHJhY2UgaXMgbm90IHN1cHBvcnRlZCBvbiB0
aGlzIHN5c3RlbVxuIik7DQo+ID4gPiArCQlyZXR1cm4gLUVOT1RTVVA7DQo+ID4gPiArCX0NCj4g
PiA+ICsNCj4gPiA+ICAgCXJldCA9IHBlcmZfY29uZmlnKHBlcmZfZnRyYWNlX2NvbmZpZywgJmZ0
cmFjZSk7DQo+ID4gPiAgIAlpZiAocmV0IDwgMCkNCj4gPiA+ICAgCQlyZXR1cm4gLTE7DQo+ID4g
DQo+ID4gUmV2aWV3ZWQtYnk6IEphbWVzIENsYXJrIDxqYW1lcy5jbGFya0BsaW5hcm8ub3JnPg0K
PiANCj4gQXBwbGllZCBhbmQgYWRkZWQgdGhlc2UgY29tbWVudHM6DQo+IA0KPiBDb21taXR0ZXIg
dGVzdGluZzoNCj4gDQo+IERvaW5nIGl0IGluIGFuIHVucHJpdmlsZWdlZCB0b29sYm94IGNvbnRh
aW5lciBvbiBGZWRvcmEgNDA6DQo+IA0KPiBCZWZvcmU6DQo+IA0KPiAgIGFjbWVAbnVtYmVyOn4v
Z2l0L3BlcmYtdG9vbHMtbmV4dCQgdG9vbGJveCBlbnRlciBwZXJmDQo+ICAg4qyiW2FjbWVAdG9v
bGJveCBwZXJmLXRvb2xzLW5leHRdJCBzdWRvIHN1IC0NCj4gICDirKJbcm9vdEB0b29sYm94IH5d
IyB+YWNtZS9iaW4vcGVyZiBmdHJhY2UNCj4gICBmYWlsZWQgdG8gcmVzZXQgZnRyYWNlDQo+ICAg
4qyiW3Jvb3RAdG9vbGJveCB+XSMNCj4gDQo+IEFmdGVyIHRoaXMgcGF0Y2g6DQo+IA0KPiAgIOKs
oltyb290QHRvb2xib3ggfl0jIH5hY21lL2Jpbi9wZXJmIGZ0cmFjZQ0KPiAgIGZ0cmFjZSBpcyBu
b3Qgc3VwcG9ydGVkIG9uIHRoaXMgc3lzdGVtDQo+ICAg4qyiW3Jvb3RAdG9vbGJveCB+XSMNCj4g
DQo+IE1heWJlIHdlIGNvdWxkIGNoZWNrIGlmIHdlIGFyZSBpbiBzdWNoIGFzIHNpdHVhdGlvbiwg
aW5zaWRlIGFuDQo+IHVucHJpdmlsZWdlZCBjb250YWluZXIsIGFuZCBwcm92aWRlIGEgSElOVCBs
aW5lPw0KPiANCkkgdGhpbmsgd2UgY291bGQgY2hlY2sgdGhlIG1vdW50IHN0YXR1cyBvZiB0cmFj
ZWZzIGZpcnN0LCBhbmQgdGhlbiBjaGVjayB3aGV0aGVyDQp0aGUgZnRyYWNlIG5vZGUgZXhpc3Rz
LiBJZiB0aGVyZSdzIGEgcGVybWlzc2lvbiBpc3N1ZSBpbiBjb250YWluZXIsIG1heWJlIHdlDQpz
aG91bGQgYWxzbyBjaGVjayB0aGUgZXJybm8gb2YgYWNjZXNzKCkuDQoNCj4gUmV2aWV3ZWQtYnk6
IEphbWVzIENsYXJrIDxqYW1lcy5jbGFya0BsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBD
aGFuZ2JpbiBEdSA8Y2hhbmdiaW4uZHVAaHVhd2VpLmNvbT4NCj4gVGVzdGVkLWJ5OiBBcm5hbGRv
IENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAcmVkaGF0LmNvbT4NCg0KLS0gDQpDaGVlcnMsDQpDaGFu
Z2JpbiBEdQ0K
