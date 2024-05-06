Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08851586FE
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017449; cv=none; b=esh7qliUrZSe1OnzWao+tUSrxJaeABHy392Okk9DQTWZL3e2YKCTb1k24R6YXdfBWVhw79ux5mfbNJ4J6XGf10wTi1bmlsVhnJDY/fKEwsmWnlTuPFNnHt6oXuPY0gK7QOp/t/+9MYo10YtUVtf1W16YhP7S1AEZundkOAm2pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017449; c=relaxed/simple;
	bh=DqvtSvSi9hL1HjeZyF4VwrETVocwep7qyKq3r+NxR7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=TVFgb1VVXO/Ob5GuINd343H/HKHXeX+J7YpOkYZWFj0wknN/ThyvclGuqkWz8EwuhwmL/Lpp+F04OA5lO66r8KgDbxv++lXjALIxFJ53UygphiEsz3TEHtYnOZTVf4YwMRiElQwRuA1Zra48RxFYTYeYY/C+2y9adFvQHXRYIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-243-ZRA8JIPMOF-s-LGbncw-7g-1; Mon, 06 May 2024 18:44:04 +0100
X-MC-Unique: ZRA8JIPMOF-s-LGbncw-7g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 6 May
 2024 18:43:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 6 May 2024 18:43:25 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Jules Bashizi Irenge <jbi.octave@gmail.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Topic: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Index: AQHamYq9w5OrjuroEEyWIm0jPSXs6bGEJ7/A///xsQCAAGdE0IAABEeAgAMqc3CAAVRfAIABXupwgAADIICAABjykA==
Date: Mon, 6 May 2024 17:43:25 +0000
Message-ID: <bd71228e767a4d589afe8fbda957b74f@AcuMS.aculab.com>
References: <Zi57-TMgU19puaQM@octinomon.home>
 <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
 <ZjPApuDc0gL9Pchm@octinomon.home>
 <424d62cd084a4aaeb1067ee0af8e98ea@AcuMS.aculab.com>
 <CAHk-=whCS468impcODViZuWxhQSqi4mqFCo3wbrsb=1SB0CXUg@mail.gmail.com>
 <e909d487c4c3468f8f20c952fe46c89c@AcuMS.aculab.com>
 <CAHk-=wg8JOO9e4wAD11vKVndXsuzhVFw547x9nRXKyFS1QRkGA@mail.gmail.com>
 <264d983efe164f7d8e665fb7d330ad7a@AcuMS.aculab.com>
 <CAHk-=wh8=yVY5vJC0EgM8=-4FOFxA+0w-OoLsZDypjpjsB5www@mail.gmail.com>
In-Reply-To: <CAHk-=wh8=yVY5vJC0EgM8=-4FOFxA+0w-OoLsZDypjpjsB5www@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDYgTWF5IDIwMjQgMTc6NDYNCj4gDQo+IE9u
IE1vbiwgNiBNYXkgMjAyNCBhdCAwOTo0MCwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1
bGFiLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gV2UgZG9uICd0IGRvIHN0dXBpZCB0aGluZ3Mg
aW4gdGhlIGtlcm5lbC4gV2UgYmFzaWNhbGx5IG5ldmVyIG5lZWQgdGhlDQo+ID4gPiA2NC1ieS02
NCBkaXZpZGUuDQo+ID4NCj4gPiBUaGVyZSBhcmUgMzgxIHJlZmVyZW5jZXMgdG8gZGl2NjRfdTY0
KCkgc29tZSBvZiB0aGVtIGFyZSBqdXN0IHBsYWluIHN0dXBpZC4NCj4gPiBDb25zdGFudCBkaXZp
c29ycyBvZiAxMDAgYW5kIDEwMDAgYW5kIGRpdjY0X3U2NCh4X25zICogMTAwLCB5X3VzICogMTAw
MCkuDQo+IA0KPiBTYWRseSwgc29tZSBwZW9wZWwgd2lsbCBnZXQgdGhlIGNvbXBpbGUgZXJyb3Ig
Zm9yICJ5b3UgY2FuJ3QgZG8gdGhhdCINCj4gYmVjYXVzZSB0aGV5IGRpZCBhIHJlZ3VsYXIgImEg
PSBiIC8gYyIgYW5kIGdjYyBjcmVhdGVkIGEgbWVzcywgYW5kDQo+IHRoZW4gdGhleSBtaW5kbGVz
c2x5IGp1c3QgcmVwbGFjZSBpdCB3aXRoIGRpdjY0X3U2NCIuDQoNCkEgYml0IGxpa2UgdGhlIG1p
bmRsZXNzIG1pbl90KCkgLSBub3QgaGFyZCB0byBmaW5kOg0KCWxlbiA9IG1pbl90KHVuc2lnbmVk
IGludCwgbGVuLCBzaXplb2YgKGludCkpOw0KCWlmIChsZW4gPCAwKQ0KCQlyZXR1cm4gLUVSQU5H
RTsNCg0KPiA+IEJ1dCBzb21lb25lIHdyb3RlIGEgc2NyaXB0IHRoYXQgY29tcGxhaW5zIHRoYXQg
aXMgYSBmdWxsIDY0Yml0IGRpdmlkZQ0KPiA+IG9uIDY0Yml0IHN5c3RlbXMgLSBzbyBzdWdnZXN0
cyBkaXY2NF91NjQoKS4NCj4gDQo+IFllYWgsIHRoYXQncyB3ZWxsLWludGVudGlvbmVkLCBidXQg
aXQgc2NyZXdzIHVwLg0KDQpUaGUgc3VnZ2VzdGlvbiBzaG91bGQgYmUgdG8gZG91YmxlIGNoZWNr
IHRoZSBkb21haW4gb2YgdGhlIGRpdmlzb3IsDQphbmQgdGhlbiBjaGFuZ2UgdGhlIHR5cGUgdG8g
dTMyLg0KDQo+IFRoZSByZWFzb24gaXMgdGhhdCAiZG9fZGl2KCkiIF9hbHdheXNfIGRvZXMgYSA2
NC1ieS0zMiBkaXZpZGUsIGFuZA0KPiB0aGVuIGlmIHlvdSBoYXZlIGEgZGl2aXNvciB0aGF0IGlz
ICJsb25nIiAod2hpY2ggaXMgaW5kZWVkIDMyIGJpdCBvbg0KPiAzMi1iaXQgYXJjaGl0ZWN0dXJl
cyksIG5vdyBvbiA2NC1iaXQgYXJjaGl0ZWN0dXJlcyBpdCB0cnVuY2F0ZXMgd2hhdA0KPiBjYW4g
YmUgYSA2NC1iaXQgdmFsdWUuDQo+IA0KPiBTbyB3ZSBwcm9iYWJseSBfc2hvdWxkXyBoYXZlIG1h
ZGUgImRvX2RpdigpIiBiZSBhICI2NC1ieS1sb25nIiBkaXZpZGUuDQoNCk9yIGdvdCB0aHJvdWdo
IHRoZSBrZXJuZWwgYW5kIGNoYW5nZSBsb3RzIG9mIHRoZSAnbG9uZycgdG8gJ3UzMicgOi0pDQpJ
J20gc3VyZSBhIGxvdCBhcmUgdGhlcmUgYmVjYXVzZSBwZW9wbGUgd2VyZSBzY2FyZWQgaW50IG1p
Z2h0IGJlIDE2Yml0Lg0KUGVyaGFwcyBNJCBnb3QgaXQgcmlnaHQgYnkgbGVhdmluZyAnbG9uZycg
YXMgMzJiaXQgOi0pDQpCdXQgcmVhbGx5IHdoYXQgd2FzIHRoZSBsYXN0IDE2Yml0IFVuaXg/DQpJ
IG5ldmVyIHVzZWQgSUNMJ3MgMjg2IHVuaXggcG9ydCAtIHRoYXQgbWlnaHQgaGF2ZSBiZWVuIDE2
Yml0Lg0KQWxsIHRoZSAzODYgb25lcyB3ZXJlIDMyYml0LCBhcyB3YXMgdGhlIFZBWCAobmV2ZXIg
dXNlZCBvbmUpLg0KU28gd2UncmUgbG9va2luZyBhdCAxOTcwJ3Mgc3lzdGVtcyBsaWtlIHRoZSBB
VCZUIDNCMiBhbmQgREVDIHBkcC0xMS4NCkNlcnRhaW5seSBmYXIgYmVmb3JlIHlvdSdkIGV2ZW4g
dGhvdWdoIG9mIExpbnV4Lg0KDQo+IE9uIGFjdHVhbCA2NC1iaXQgYXJjaGl0ZWN0dXJlcywgZG9p
bmcgYSA2NC1idGkgZGl2aWRlIGlzIHR5cGljYWxseQ0KPiBmaW5lIChJIGNhbiBpbWFnaW5lIHNv
bWUgYnJva2VuIGNhc2VzLCBidXQgbm90IGVub3VnaCB0byBjYXJlKS4NCg0KV2VsbCBJbnRlbCB4
ODYgYWx3YXlzIHRha2UgdHdpY2UgYXMgbG9uZyBmb3IgdGhlIGZ1bGwgMTI4IGJ5IDY0IGRpdmlk
ZQ0KdGhhbiB0aGUgNjQgYnkgMzIgb25lIChhbWQgaXMgdGhlIHNhbWUgc3BlZWQgaWYgdGhlIHZh
bHVlcyBmaXQpLg0KU28gc2VsZWN0aW5nIGJldHdlZW4gdGhlIHR3byBkaXZpZGVzIG1heSBtYWtl
IHNlbnNlLg0KT1RPSCB5b3UgcHJvYmFibHkgZG9uJ3Qgd2FudCB0byBzcGVjdWxhdGl2ZWx5IGV4
ZWN1dGUgdGhlIHdyb25nIGRpdmlkZSEgDQoNCj4gVGhlIHdob2xlIHByb2JsZW0gaXMgYmVjYXVz
ZSBvZiAzMi1iaXQgYXJjaGl0ZWN0dXJlcy4NCg0KSW5kZWVkLg0KQm90aCB4ODYgYW5kIG02OGsg
aGF2ZSBhIDY0IGJ5IDMyIGRpdmlkZS4gSSdtIG5vdCB3aGV0aGVyIGFueSBvdGhlciBkby4NCk5p
b3MtSUkgd29udCAoaXQgbWF5IG5vdCBldmVuIGhhdmUgZGl2aWRlKSwgcHJvYmFibHkgYWxsIE1J
UFMgZGVyaXZhdGl2ZXMNCmFyZSB0aGUgc2FtZSAoaW5jbHVkaW5nIFJJU0MtVikuDQpUaGUgc3Vn
Z2VzdGVkIGRpdmlkZSBmdW5jdGlvbiBpbiBteSBzcGFyYy0zMiBib29rIGlzIHNldmVyYWwgcGFn
ZXMgbG9uZy4NCihRdWl0ZSB3aGF0IGRvZXMgdGhlIHRvIEktY2FjaGUgaXMgYW55LWJvZGllcyBn
dWVzcy4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

