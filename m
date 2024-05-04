Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76792594
	for <linux-perf-users@vger.kernel.org>; Sat,  4 May 2024 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714863244; cv=none; b=ftgRadGki4CNDYWdBdqCEA1SuEOO4ebyz9emnly2ibwRDopR3iq/bUDHlHAc6VcC9ozbWJyZTM9XnSGSuf6YjCBlxC145EysTGnaEPbq+/DS91hAqoWI5atMlqb8T0nT/9NlH+/0cyFkNx86v4t8A4UVGCKnsYSFo6CkcCemHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714863244; c=relaxed/simple;
	bh=bseckNg7zBGJYlxy5yz6BMDMettR3MW6r3wiSIAEruo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=kIk2kk8Q7X+/HCYE1NRoogOM5TDY9yiq1QWKJK4MZF2eeWqC6yDXWks8hQwx/trj/L+TtQ4BgiwIx9eGdttceTdoOZYdH61yYlq6rePum8jU629p1tdaSXQ8qP9P3Zj6cJPnNm9i8QhvZEIAywiY0ChS6cL0ay3Uyd4T1nlTWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-43-6HxiMJNaP-m-9LSIHjw09w-1; Sat, 04 May 2024 23:53:51 +0100
X-MC-Unique: 6HxiMJNaP-m-9LSIHjw09w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 4 May
 2024 23:53:20 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 4 May 2024 23:53:20 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Jules Bashizi Irenge <jbi.octave@gmail.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Topic: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Index: AQHamYq9w5OrjuroEEyWIm0jPSXs6bGEJ7/A///xsQCAAGdE0IAABEeAgAMqc3A=
Date: Sat, 4 May 2024 22:53:19 +0000
Message-ID: <e909d487c4c3468f8f20c952fe46c89c@AcuMS.aculab.com>
References: <Zi57-TMgU19puaQM@octinomon.home>
 <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
 <ZjPApuDc0gL9Pchm@octinomon.home>
 <424d62cd084a4aaeb1067ee0af8e98ea@AcuMS.aculab.com>
 <CAHk-=whCS468impcODViZuWxhQSqi4mqFCo3wbrsb=1SB0CXUg@mail.gmail.com>
In-Reply-To: <CAHk-=whCS468impcODViZuWxhQSqi4mqFCo3wbrsb=1SB0CXUg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDMgTWF5IDIwMjQgMDA6MDANCj4gDQo+IE9u
IFRodSwgMiBNYXkgMjAyNCBhdCAxNToxOSwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1
bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTb21ld2hlbiBpdCBtdXN0IGhhdmUgZ290IGNoYW5n
ZWQgZnJvbSBhIHNpbXBsZSBhc20gd3JhcHBlciBmb3IgZGl2bC4NCj4gDQo+IEl0J3MgbmV2ZXIg
YmVlbiBhIHNpbXBsZSB3cmFwcGVyIGZvciBkaXZsLiBGb3IgdGhlIHNpbXBsZSByZWFzb24gdGhh
dA0KPiAnZGl2bCcgZG9lc24ndCBkbyBhIGZ1bGwgNjQvMzIgZGl2aWRlIHJldHVybmluZyBhIGZ1
bGwgNjQtYml0IHJlc3VsdC4NCg0KSSdkIHRob3VnaHQgKGJlZm9yZSBJJ2QgbG9va2VkKSB0aGF0
IGl0IG9ubHkgcmV0dXJuZWQgYSAzMmJpdCByZXN1bHQuDQpBZnRlciBhbGwgdGhhdCBpcyB3aGF0
IGEgbG90IG9mIGNvZGUgd2FudHMuDQoNCkkgd2FzIHRoaW5raW5nIG9mIHNvbWV0aGluZyBsaWtl
IChzZWUgaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L2g4b2o3aDRzZCk6DQoNCiNkZWZpbmUgZGl2dShh
LCBiKSAoeyBcDQogICAgdTY0IF9hID0gYSwgX2IgPSBiLCBfcTsgXA0KICAgIHUzMiBfYWxvID0g
X2EsIF9ibG8gPSBfYjsgXA0KICAgIHUzMiBfYWhpID0gX2EgPj4gMzIsIF9iaGkgPSBfYiA+PiAz
MjsgXA0KICAgIGlmIChfYmhpKSB7IFwNCiAgICAgICAgX3EgPSBkaXY2NChfYSwgX2IpOyBcDQog
ICAgfSBlbHNlIHsgXA0KICAgICAgICB1MzIgX3FoaSA9IDA7IFwNCiAgICAgICAgaWYgKF9haGkg
Pj0gX2JsbykgeyBcDQogICAgICAgICAgICBfcWhpID0gX2FoaSAvIF9ibG87IFwNCiAgICAgICAg
ICAgIF9haGkgPSBfYWhpICUgX2JsbzsgXA0KICAgICAgICB9IFwNCiAgICAgICAgYXNtKCAiZGl2
bCAlMiIgOiAiK2EiIChfYWxvKSwgIitkIiAoX2FoaSkgOiAiciIgKF9ibG8pKTsgXA0KICAgICAg
ICBhc20oICIiIDogIj1BIiAoX3EpIDogImEiIChfYWxvKSwgImQiIChfcWhpKSk7IFwNCiAgICB9
IFwNCiAgICBfcTsgXA0KfSkNCg0KV2hpY2ggd2lsbCBjYWxsIG91dCBmb3IgYSBsYXJnZSBkaXZp
c29yLCBidXQgd2lsbCBkbyBpbmxpbmVkIGRpdmlkZXMNCm90aGVyd2lzZSAtIHNvIGlzIHJlYXNv
bmFibHkgc2FuZSB3aGF0ZXZlciB0aGUgdHlwZXMgKGV2ZW4gMzIgYnkgMzIpLg0KTW9kZXJuIGdj
Yy9jbGFuZyBhbHNvIHRyYWNrcyB2YWx1ZXMgKHRvIHNvbWUgZXh0ZW50KSBzbyB3aWxsIGRldGVj
dA0KX2FoaSBhbmQgX2JoaSBiZWluZyBjb21waWxlLXRpbWUgemVybyBldmVuIGlmIHRoZSB0eXBl
cyBhcmUgNjRiaXQuDQoNCkkndmUgaWdub3JlZCB0aGUgcmVtYWluZGVyIGZvciBjbGFyaXR5Lg0K
QnV0IEknZCBhZGQgYSAndTY0ICpyZW0nIHBhcmFtZXRlciBhbmQgZG8gYSBjb21waWxlLXRpbWUg
TlVMTCBjaGVjay4NCg0KRm9ydHVuYXRlbHkgdGhlIGtlcm5lbCBkb2Vzbid0IGxldCBnY2MgdXNl
IHRoZSB4bW0gcmVnc2l0ZXJzLg0KSXQgaGFzIGEgbmFzdHkgaGFiaXQgb2YgYmxvYXRpbmcgdGhl
IGNvZGUgYnkgdHJ5aW5nIHRvIHVzZSB0aGVtDQpmb3IgNjRiaXQgaW50ZWdlcnMuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

