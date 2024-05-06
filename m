Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7AD1E4A6
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013621; cv=none; b=s7hKTRFRavo6MtY2F7dNCiREXCnAidEqpxHAvR9rUsJzcll5PRGPNWi9iQ3d61HbV1YplvCsHLhGSZBP+LNSlCy1V1AkGo0GENb8xTqtHCDU8wqr0K7DytFp9VlYwGNEdmV55ZOPR5DYXyOWP/1BRzlGGD1azNCisJsrAJ4UvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013621; c=relaxed/simple;
	bh=ucELDPNatlRU71mDWhjsw//vbzlUTxosSYPrhngAvdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fPhLnNe2bmpy3m/nAXqQFg/ZpypR0TlDOTcLhyfqcwIpa43A+9OmSolxDPUFzsO+nmVj0YOP4GrvGUWSxnqxVvC10E+OKPCPRAFd0KbpYuzyon4FQdoOLNSfMHgxYPK+nifUKD0pFONX4JL4kov2uHr28qZniqXSij8JCtN85qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-131-hssn0c3wNJ-tT2peWui_oA-1; Mon, 06 May 2024 17:40:10 +0100
X-MC-Unique: hssn0c3wNJ-tT2peWui_oA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 6 May
 2024 17:39:31 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 6 May 2024 17:39:31 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Jules Bashizi Irenge <jbi.octave@gmail.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Topic: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Index: AQHamYq9w5OrjuroEEyWIm0jPSXs6bGEJ7/A///xsQCAAGdE0IAABEeAgAMqc3CAAVRfAIABXupw
Date: Mon, 6 May 2024 16:39:31 +0000
Message-ID: <264d983efe164f7d8e665fb7d330ad7a@AcuMS.aculab.com>
References: <Zi57-TMgU19puaQM@octinomon.home>
 <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
 <ZjPApuDc0gL9Pchm@octinomon.home>
 <424d62cd084a4aaeb1067ee0af8e98ea@AcuMS.aculab.com>
 <CAHk-=whCS468impcODViZuWxhQSqi4mqFCo3wbrsb=1SB0CXUg@mail.gmail.com>
 <e909d487c4c3468f8f20c952fe46c89c@AcuMS.aculab.com>
 <CAHk-=wg8JOO9e4wAD11vKVndXsuzhVFw547x9nRXKyFS1QRkGA@mail.gmail.com>
In-Reply-To: <CAHk-=wg8JOO9e4wAD11vKVndXsuzhVFw547x9nRXKyFS1QRkGA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDUgTWF5IDIwMjQgMjA6MzkNCj4gDQo+IE9u
IFNhdCwgNCBNYXkgMjAyNCBhdCAxNTo1MywgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1
bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJIHdhcyB0aGlua2luZyBvZiBzb21ldGhpbmcgbGlr
ZSAoc2VlIGh0dHBzOi8vZ29kYm9sdC5vcmcvei9oOG9qN2g0c2QpOg0KPiA+ICBbLi4uXQ0KPiA+
IFdoaWNoIHdpbGwgY2FsbCBvdXQgZm9yIGEgbGFyZ2UgZGl2aXNvciwgYnV0IHdpbGwgZG8gaW5s
aW5lZCBkaXZpZGVzDQo+ID4gb3RoZXJ3aXNlIC0gc28gaXMgcmVhc29uYWJseSBzYW5lIHdoYXRl
dmVyIHRoZSB0eXBlcw0KPiANCj4gTm8uIFRoaXMgaXMgbm90IHNhbmUuDQo+IA0KPiBPbmNlIHlv
dSBoYXZlIGEgY2FsbG91dCwgeW91IG1pZ2h0IGFzIHdlbGwgZG8gaXQgYWxsIGVudGlyZWx5IG91
dCBvZg0KPiBsaW5lLiBZb3UndmUgbWVzc2VkIHVwIHlvdXIgcmVnaXN0ZXIgc3RhdGUgYW5kIGlu
c3RydWN0aW9uIHNjaGVkdWxpbmcNCj4gb3Bwb3J0dW5pdGllcywgYW5kIHRoZSBhZHZhbnRhZ2Ug
b2YgaW5saW5pbmcgcGFydCBvZiB0aGUgY29tcHV0YXRpb24NCj4gaXMgYmFzaWNhbGx5IGFsbW9z
dCBlbnRpcmVseSBnb25lLg0KPiANCj4gQW5kIHRoZSB0aGluZyBpcywgaWYgeW91IGRvIGEgNjQt
YnktNjQgZGl2aWRlLCB0aGVuIHlvdSBqdXN0IGRvIGl0Lg0KPiBHY2Mgd2lsbCBjcmVhdGUgdGhh
dCBkaXNndXN0aW5nIG91dC1vZi1saW5lIGNvZGUgZm9yIHlvdS4NCj4gDQo+IEJVVCBJVCBTVUNL
Uy4NCj4gDQo+IFdlIGRvbiAndCBkbyBzdHVwaWQgdGhpbmdzIGluIHRoZSBrZXJuZWwuIFdlIGJh
c2ljYWxseSBuZXZlciBuZWVkIHRoZQ0KPiA2NC1ieS02NCBkaXZpZGUuDQoNClRoZXJlIGFyZSAz
ODEgcmVmZXJlbmNlcyB0byBkaXY2NF91NjQoKSBzb21lIG9mIHRoZW0gYXJlIGp1c3QgcGxhaW4g
c3R1cGlkLg0KQ29uc3RhbnQgZGl2aXNvcnMgb2YgMTAwIGFuZCAxMDAwIGFuZCBkaXY2NF91NjQo
eF9ucyAqIDEwMCwgeV91cyAqIDEwMDApLg0KSGF2ZSBhIGxvb2sgOi0pDQoNCj4gVGhlIHJlYXNv
biB3ZSBoYXZlICJkb19kaXYoKSIgYW5kIGZyaWVuZHMgaXMgRVhBVENMWQ0KPiBUSEFUIC0gdG8g
Y2F0Y2ggdGhlICJvaCwgeW91IGRpZCBzb21ldGhpbmcgc3R1aXBpZCwganVzdCBmaXggaXQiLg0K
PiANCj4gWWVzLCB3ZSBkbyBkaXZpZGUgNjQtYml0IGVudGl0aWVzIGV2ZW4gb24gMzItYml0IGhv
c3RzLCBidXQgOTklIG9mIHRoZQ0KPiB0aW1lIHRoZSByYW5nZSBvZiB0aGUgZGl2aXNvciBpcyBi
YXNpY2FsbHkgYWx3YXlzIGxpbWl0ZWQsIGFuZCBnY2MNCj4gc2FkbHkgZG9lcyBub3QgdW5kZXJz
dGFuZCB0aGF0IHRoYXQgY2FzZSBtYXR0ZXJzLg0KDQpUaGUgcHJvYmxlbSBpcyB0aGF0IGNvZGUg
ZG9lcyBkb19kaXYodTY0LCB1bnNpZ25lZCBsb25nKSAod2hpY2ggaXMgZmluZSkuDQpCdXQgc29t
ZW9uZSB3cm90ZSBhIHNjcmlwdCB0aGF0IGNvbXBsYWlucyB0aGF0IGlzIGEgZnVsbCA2NGJpdCBk
aXZpZGUNCm9uIDY0Yml0IHN5c3RlbXMgLSBzbyBzdWdnZXN0cyBkaXY2NF91NjQoKS4NClRoZXkg
c29tZW9uZSB0aGlua3MgdGhleSBjYW4gZml4IGFuIGVhc3kgJ2J1ZycgYnkgZG9pbmcgdGhlIHN1
YnN0aXR1dGlvbi4NCkV4Y2VwdCB0aGUgY29kZSB3YXMgZmluZSAoZHVlIHRvIHRoZSBkb21haW4g
b2YgdGhlIGRpdmlzb3IpIGFuZCB0aGUNCm1vZGlmaWVkIGNvZGUgaXMgZW50aXJlbHkgYnJva2Vu
IGR1ZSB0aGUgZGlmZmVyZW50IGNhbGxpbmcgY29udmVudGlvbnMuDQooTmV2ZXIgbWluZCB0aGF0
IGl0IGlzIGxpa2VseSBzbG93IG9uIDMyYml0LikNCg0KZGl2NjRfdTY0KCkgcmVhbGx5IG5lZWRz
IGEgJ211c3QgY2hlY2snIGF0dHJpYnV0ZS4NCg0KU28gdGhlIGlkZWEgd2FzIHRvIGlubGluZSBh
IDY0eDMyIGRpdmlkZSBhbmQgZG8gYSBjYWxsIGZvciBhIDY0eDY0IG9uZS4NCkJ1dCBpbmNsdWRl
IGFuIG9wdGltaXNhdGlvbiB0aGF0IGF2b2lkZWQgdGhlIGNhbGwgZm9yIGEgNjR4NjQgZGl2aWRl
DQppZiAoYXQgcnVuIHRpbWUpIHRoZSBkaXZpc29yIHdhcyBvbmx5IDMyYml0Lg0KKEhvdyBtdWNo
IGRvZXMgYSAncmV0JyBjb3N0IHRoZXNlIGRheXMgd2l0aCBhbGwgdGhlIG1pdGlnYXRpb25zPykN
Cg0KQWRkaW5nICFfX2J1aWx0aW5fY29uc3RhbnRfcChfYmhpKSB0byB0aGUgY2hlY2sgZm9yIHRo
ZSBjYWxsIHJlbW92ZXMNCnRoZSBydW4tdGltZSBjaGVjayAtIGJ1dCB3aWxsIHN0aWxsIGlubGlu
ZSB1NjQvdTY0IGlmIHRoZSBjb21waWxlcg0Ka25vd3MgdGhlIGRpdmlzb3IgaXMgc21hbGwuDQoN
CkdpdmVuIHBlb3BsZSB3b24ndCB1c2UgdGhlIHJpZ2h0IGZ1bmN0aW9uLCBvcHRpbWlzaW5nIGRp
djY0X3U2NCgpDQpmb3IgZGl2aXNvcnMgdGhhdCBhcmUga25vd24gYXQgY29tcGlsZSB0aW1lIHRv
IGJlIDMyYml0cyBoYXMNCnRvIG1ha2Ugc29tZSBzZW5zZS4NCg0KSSdtIHRyeWluZyB0byB0aGlu
ayBob3cgdG8gZG8gYSBjb21waWxlIHRpbWUgTlVMTCB0ZXN0IGZvciB0aGUNCidwb2ludGVyIHRv
IHJlbWFpbmRlcicgZm9yIGFuIGlubGluZSBmdW5jdGlvbi4NCk1heWJlIGlmICghX19idWlsdGlu
X2NvbnN0X3AocikgfHwgKHIpKSAqKHIpID0gX3JlbTsgd2lsbCBEVFJULg0KVGhlbiBkaXY2NF91
NjQoYSwgYikgY2FuIGJlIGRpdjY0X3UzMl9yZW0oYSwgYiwgTlVMTCkgd2l0aG91dA0KYW55IGlu
bGluZWQgdmVyc2lvbiBjb250YWluaW5nIGFuIGFjdHVhbCBOVUxMIGNoZWNrLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

