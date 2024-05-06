Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6015B106
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027187; cv=none; b=jMBocXGKBkubqv4ar1qWPv7e0Tgkv+wnMRexpuoKlZiAEvcMZkj6ZDuH8uPyNLMMTRsDqbGiHvKLeuT6VboiXT5r8OaaPUA98H1YqVsJlVdhgGs3e+YI8SFszAruBeAU5yeHWlHTtzHKbK/qia91kg6jGXAvflfEoCOT82SmORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027187; c=relaxed/simple;
	bh=DDEVdmd0kcLpzxPz3ifGRimSuneLJY7fGREA60OUpMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=g0KdUyHNAKbWk1rb16U/RrTnOVnnASvFD9PoV0YEjOsSs8DTjE2xLKeBvEIfG9G/9As39bhD2cvwZkuPI4HBN9UFpIDgzpVcKflWT0/OfDK12G2BK1dIJOzftmBbRZ3tbLtqLJ+CWoo9QwQePJEy4imOCupr4d8wFnZci8ju9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-15-6tKKbw7SM_6KGLbzgEL1Eg-1; Mon, 06 May 2024 21:26:23 +0100
X-MC-Unique: 6tKKbw7SM_6KGLbzgEL1Eg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 6 May
 2024 21:25:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 6 May 2024 21:25:44 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Jules Bashizi Irenge <jbi.octave@gmail.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Topic: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Index: AQHamYq9w5OrjuroEEyWIm0jPSXs6bGEJ7/A///xsQCAAGdE0IAABEeAgAMqc3CAAVRfAIABXupwgAAfSaWAAAmBAA==
Date: Mon, 6 May 2024 20:25:44 +0000
Message-ID: <a0bdbe9832cc40e29cd63a71cec95fba@AcuMS.aculab.com>
References: <Zi57-TMgU19puaQM@octinomon.home>
 <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
 <ZjPApuDc0gL9Pchm@octinomon.home>
 <424d62cd084a4aaeb1067ee0af8e98ea@AcuMS.aculab.com>
 <CAHk-=whCS468impcODViZuWxhQSqi4mqFCo3wbrsb=1SB0CXUg@mail.gmail.com>
 <e909d487c4c3468f8f20c952fe46c89c@AcuMS.aculab.com>
 <CAHk-=wg8JOO9e4wAD11vKVndXsuzhVFw547x9nRXKyFS1QRkGA@mail.gmail.com>
 <264d983efe164f7d8e665fb7d330ad7a@AcuMS.aculab.com>
 <CAHk-=wh8=yVY5vJC0EgM8=-4FOFxA+0w-OoLsZDypjpjsB5www@mail.gmail.com>
 <CAHk-=wiGUkPz+9gN_uwOfg-VGP4Z5UBKe-xBrn3uHMtJ85UarA@mail.gmail.com>
In-Reply-To: <CAHk-=wiGUkPz+9gN_uwOfg-VGP4Z5UBKe-xBrn3uHMtJ85UarA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDYgTWF5IDIwMjQgMTg6MjcNCj4gDQo+IE9u
IE1vbiwgNiBNYXkgMjAyNCBhdCAwOTo0NSwgTGludXMgVG9ydmFsZHMNCj4gPHRvcnZhbGRzQGxp
bnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IFNvIHdlIHByb2JhYmx5IF9zaG91
bGRfIGhhdmUgbWFkZSAiZG9fZGl2KCkiIGJlIGEgIjY0LWJ5LWxvbmciIGRpdmlkZS4NCj4gDQo+
IEFjdHVhbGx5LCBzb21lIG9mIHRob3NlIGNvbnZlcnNpb25zIGFyZSBqdXN0IHdyb25nIGFuZCBz
dHVwaWQsIGFuZA0KPiBkaWRuJ3QgaGF2ZSAnbG9uZycgZGl2aXNvcnMgYXQgYWxsLg0KPiANCj4g
QW5kIHdlIGRvIGhhdmUgImRpdjY0X3VsKCkiLCBhbHRob3VnaCBpdCdzIG5vdCB1c2VkIGFzIHdp
ZGVseSBhcyBpdCBjb3VsZCBiZS4NCj4gDQo+IEJ1dCBJIHRoaW5rIHdlIGNhbiBkbyB0aGUgcmV2
ZXJzZSwgYW5kIGp1c3QgdGVhY2ggImRpdjY0X3U2NCgpIiB0byBkbw0KPiB3aGF0IGdjYyBzaG91
bGQgYWx3YXlzIGhhdmUgZG9uZSwgYW5kIGxvb2sgYXQgdGhlIGRpdmlzb3IgcmFuZ2UgYXQNCj4g
Y29tcGlsZS10aW1lLg0KPiANCj4gU29tZXRoaW5nIGxpa2UgdGhpcywgcGVyaGFwczoNCj4gDQo+
ICAgLyoNCj4gICAgKiBEbyBhIDY0LWJ5LTY0IGRpdmlkZSB1c2luZyBkaXY2NF91bCAvIGRpdjY0
X2xvbmcgLyBkaXY2NF91NjQNCj4gICAgKiBkZXBlbmRpbmcgb24gdHlwZSBvZiBkaXZpc29yLg0K
PiAgICAqLw0KPiAgICNkZWZpbmUgZGl2NjRfdTY0X3R5cGUoYSxiKSBfR2VuZXJpYygoYiksICAg
ICBcDQo+ICAgICAgICAgdW5zaWduZWQgbG9uZzogZGl2NjRfdWwoYSxiKSwgICAgICAgICAgIFwN
Cj4gICAgICAgICBsb25nOiBkaXY2NF9sb25nKGEsYiksICAgICAgICAgICAgICAgICAgXA0KPiAg
ICAgICAgIGludDogZGl2NjRfbG9uZyhhLGIpLCAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAg
ICAgZGVmYXVsdDogZGl2NjRfdTY0KGEsYikpDQo+IA0KPiAgIC8qIElzIGl0IHplcm8gd2l0aG91
dCBldmFsdWF0aW5nIGl0PyAqLw0KPiAgICNkZWZpbmUgaXNfY29uc3RhbnRfemVybyh4KSBcDQo+
ICAgICAgICAgKF9fYnVpbHRpbl9jb25zdGFudF9wKHgpICYmICEoeCkpDQo+IA0KPiAgIC8qIFRo
aXMgY2F0Y2hlcyBjb25zdGFudHMgYW5kIGNvbXBpbGUtdGltZSByYW5nZXMgKi8NCj4gICAjZGVm
aW5lIGlzXzMyX2JpdCh4KSBcDQo+ICAgICAgICAgaXNfY29uc3RhbnRfemVybygoeCk+PjE2Pj4x
NikNCj4gDQo+ICAgLyoNCj4gICAgKiBQaWNrIHRoZSByaWdodCBkaXZpc2lvbiBoZWxwZXIgYmFz
ZWQgb24NCj4gICAgKiB2YWx1ZSBvciB0eXBlIG9mIHRoZSBkaXZpc29yDQo+ICAgICovDQo+ICAg
I2RlZmluZSBkaXY2NF91NjQoYSxiKSBcDQo+ICAgICAgICAgKGlzXzMyX2JpdChiKSA/IGRvX2Rp
djY0KGEsYikgOiBkaXY2NF91NjRfdHlwZShhLGIpKQ0KPiANCj4gc2hvdWxkIG5vdyBtYWtlIGRp
djY0X3U2NCgpIGRvIHRoZSByaWdodCB0aGluZyBhbmQgYXZvaWQgdGhlIDY0LWJpdA0KPiBkaXZp
ZGUgZm9yIHJlbGV2YW50IHR5cGVzICh0aGUgc2lnbmVkIHR5cGUgY2FzZSBtYWtlcyBpdCBhIGJp
dCBsZXNzDQo+IG9idmlvdXMsIGJ1dCB3aGF0ZXZlcikuDQoNCkkgZG9uJ3QgdGhpbmsgdGhlcmUg
YXJlIGFueSBzaWduZWQgZGl2aWRlcyB0byB3b3JyeSBhYm91dC4NClNpZ25lZCBkaXZpZGVzIGFy
ZSBhbHNvIHRvbyBwYWluZnVsIHRvIHNvcnQgb3V0Lg0KWW91IGhhdmUgdG8gd29ycnkgYWJvdXQg
YWxsIDQgcXVhZHJhbnRzLg0KDQpXaGljaCBpcyBwcmV0dHkgbXVjaCBleGFjdGx5IHdoYXQgSSBw
cm9wb3NlZCA6LSkNCihhcGFydCBmcm9tIHRoZSBydW4tdGltZSBjaGVjayB0byBhdm9pZCBjYWxs
aW5nIGRpdjY0X3U2NCgpLikNCkJ5IHRoZSB0aW1lIHlvdSd2ZSBkb25lIHRoZSBpc18zMl9iaXQo
YikgeW91J3ZlIG9ubHkgZ290DQo2NCBiaXQgdmFsdWVzIGxlZnQgKHdlbGwgYW5kIDEyOCBidXQu
Li4pLCB0aGV5IG1pZ2h0IGJlICdsb25nJw0Kb3IgJ2xvbmcgbG9uZycgb24gNjRiaXQgYnV0IHRo
YXQgZG9lc24ndCBtYXR0ZXIuDQoNCkknbSBub3Qgc3VyZSBvZiB0aGUgYmVzdCB3YXkgdG8gcmV0
dXJuIGEgcXVvdGllbnQgYW5kIHJlbWFpbmRlcg0Kb24gYSAzMmJpdCBzeXN0ZW0uDQpUaGUgJ3Vz
ZXInIGFwaSBpcyBiZXN0IGFzOg0KCXF1b3RpZW50ID0gZGl2dV94eHgoZGl2aWRlbmQsIGRpdmlz
b3IsICZxdW90aWVudCk7DQp3aGVyZSBkaXZpc29yIGFuZCBxdW90aWVudCBhcmUgdGhlIHNhbWUg
dHlwZSBhbmQgcXVvdGllbnQNCm1pZ2h0IGJlIE5VTEwgLSBhbmQgbWlnaHQgYmUgc3VwcGxpZWQg
YnkgYSB3cmFwcGVyLg0KDQpQZXJoYXBzIHNvbWV0aGluZyBsaWtlICh1bnRlc3RlZCk6DQojZGVm
aW5lIGRpdjY0X3U2NF9yZW0oYSwgYiwgcmVtKSAoeyBcDQoJdHlwZW9mIChiKSBfcTsgXA0KCWlm
IChpc18zMl9iaXQoYikpIHsgXA0KCQl1NjQgX3FfciA9IF9kaXZfdTY0X3UzMl9yZW0oYSwgYik7
DQoJCWlmICghaXNfY29uc3RhbnRfemVybyhyZW0pKQ0KCQkJKnJlbSA9IF9xX3IgPj4gMzI7DQoJ
CV9xID0gX3FfciAmIDB4ZmZmZmZmZmY7DQoJfSBlbHNlIHsgXA0KCQlfcSA9IF9kaXZ1NjRfdTY0
X3JlbShhLCBiLCByZW0pOyBcDQoJfSBcDQoJX3E7IFwNCn0pDQoNClRoZW4geDg2IHdvdWxkIGhh
dmUgYSAjZGVmaW5lL2lubGluZSBmb3IgX2Rpdl91MzJfcmVtKCkuDQpJIHN1c3BlY3QgdGhlICcq
cmVtJyBuZWVkcyB0byBiZSAqKHR5cGVvZigmKGIpKXJlbQ0KYW5kIHNvbWV0aGluZyBsaWtlICgw
ID8gJmIgOiByZW0pIGFkZGVkIHNvbWV3aGVyZS4NClBlcmhhcHMgKih0eXBlb2YoMCA/ICZiIDog
cmVtKSkocmVtKSBEVFJUID8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

