From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Thu, 29 Oct 2015 15:58:16 +0000
Message-ID: <1446134296.3203.27.camel@synopsys.com>
References: <C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
	 <1445166916.9672.10.camel@synopsys.com>
	 <87a8rf6a6p.fsf@tassilo.jf.intel.com>
	 <C2D7FE5348E1B147BCA15975FBA23075F44C9E9A@IN01WEMBXA.internal.synopsys.com>
	 <8761235rwe.fsf@tassilo.jf.intel.com>
	 <C2D7FE5348E1B147BCA15975FBA23075F44CAFF9@IN01WEMBXA.internal.synopsys.com>
	 <20151019093549.GK3816@twins.programming.kicks-ass.net>
	 <C2D7FE5348E1B147BCA15975FBA23075F44CB023@IN01WEMBXA.internal.synopsys.com>
	 <20151019095157.GM3816@twins.programming.kicks-ass.net>
	 <C2D7FE5348E1B147BCA15975FBA23075F44CB43D@IN01WEMBXA.internal.synopsys.com>
	 <20151020101133.GA17308@twins.programming.kicks-ass.net>
	 <C2D7FE5348E1B147BCA15975FBA23075F44CB4BF@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:44678 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbJ2P6W (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Oct 2015 11:58:22 -0400
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F44CB4BF@IN01WEMBXA.internal.synopsys.com>
Content-Language: en-US
Content-ID: <5DBBFCF0CCBB7E488A58FF1FCF05652B@internal.synopsys.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "andi@firstfloor.org" <andi@firstfloor.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "acme@redhat.com" <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "giladb@ezchip.com" <giladb@ezchip.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "noamc@ezchip.com" <noamc@ezchip.com>

SGkgVmluZWV0LA0KDQpPbiBUdWUsIDIwMTUtMTAtMjAgYXQgMTA6NDUgKzAwMDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gVHVlc2RheSAyMCBPY3RvYmVyIDIwMTUgMDM6NDEgUE0sIFBldGVy
IFppamxzdHJhIHdyb3RlOg0KPiA+ID4gPiBDYW4gd2UgdXNlIGV4aXN0aW5nIHN5c2NhbGwocykg
LSBhZ2FpbiB0aGlzIGlzIHdoYXQgb3VyIGdvb2Qgb2xkIHB0aHJlYWQgbGlicmFyeQ0KPiA+ID4g
PiBjb2RlIGRpZC4NCj4gPiA+ID4gDQo+ID4gPiA+IHN0YXRpYyB2b2lkIF9fcHRocmVhZF9hY3F1
aXJlKGludCAqIHNwaW5sb2NrKQ0KPiA+ID4gPiB7DQo+ID4gPiA+ICAgaW50IGNudCA9IDA7DQo+
ID4gPiA+ICAgc3RydWN0IHRpbWVzcGVjIHRtOw0KPiA+ID4gPiANCj4gPiA+ID4gICBSRUFEX01F
TU9SWV9CQVJSSUVSKCk7DQo+ID4gPiA+IA0KPiA+ID4gPiAgIHdoaWxlICh0ZXN0YW5kc2V0KHNw
aW5sb2NrKSkgeyAgIDwtLS0tIGF0b21pYyBFWGNoYW5nZQ0KPiA+ID4gPiAgICAgaWYgKGNudCA8
IDUwKSB7DQo+ID4gPiA+ICAgICAgIHNjaGVkX3lpZWxkKCk7DQo+ID4gPiA+ICAgICAgIGNudCsr
Ow0KPiA+ID4gPiAgICAgfSBlbHNlIHsNCj4gPiA+ID4gICAgICAgdG0udHZfc2VjID0gMDsNCj4g
PiA+ID4gICAgICAgdG0udHZfbnNlYyA9IDIwMDAwMDE7DQo+ID4gPiA+ICAgICAgIG5hbm9zbGVl
cCgmdG0sICgodm9pZCAqKTApKTsNCj4gPiA+ID4gICAgICAgY250ID0gMDsNCj4gPiA+ID4gICAg
IH0NCj4gPiA+ID4gICB9DQo+ID4gKnNodWRkZXIqIHRoYXQgaXMgcXVpdGUgaG9ycmlibGUuDQo+
ID4gDQo+ID4gVGhpcyBtZWFucyBhbGwgeW91ciAnYXRvbWljcycgYXJlIGJyb2tlbiBmb3IgYW55
dGhpbmcgU0NIRURfRklGTyBhbmQgdGhlDQo+ID4gbGlrZS4gWW91IHNpbXBseSBfY2Fubm90XyBy
dW4gYSByZWFsdGltZSBzeXN0ZW0uDQo+IA0KPiBUaGUgY29kZSBhYm92ZSBpcyBmcm9tIHVDbGli
YyBvbGQgdGhyZWFkaW5nIGxpYnJhcnkgd2hpY2ggd2UgZG9uJ3QgdXNlIGFueW1vcmUuDQo+IFRo
ZSBOUFRMIHZlcnNpb24gZG9lc24ndCBoYXZlIGFsbCBvZiB0aGlzIHNvbmctbi1kYW5jZSBhbmQg
cmVsaWVzIG9uIGZ1dGV4ZXMuIFRoZQ0KPiBjaGFuZ2Ugd2UgYXJlIHRhbGtpbmcgYWJvdXQgaXMg
b25seSBmb3IgdGhlIGF0b21pY3MgaW4gcGVyZiBpdHNlbGYuIEkgZG8NCj4gdW5kZXJzdGFuZCB5
b3VyIFBPViB0aG91Z2guDQo+IA0KPiA+IChhbHNvLCBmb3IgQUNRVUlSRSB5b3Ugd2FudCB0aGUg
UkVBRF9NRU1PUllfQkFSUklFUigpIF9hZnRlcl8gdGhlDQo+ID4gdGVzdC1hbmQtc2V0IGNvbnRy
b2wgZGVwZW5kZW5jeS4pDQo+IA0KPiBBYnNvbHV0ZWx5IGFuZCBpbiB0aGlzIGNhc2UgaXQgd2ls
bCBoYXZlIHRvIGJlIGFkZGVkIGJvdGggaW5zaWRlIHRoZSBsb29wIGFuZCBvbmUNCj4gYXQgdGhl
IGVuZCB0byBjb3ZlciBib3RoIHRoZSBzY2VuYXJpb3MgIQ0KPiANCg0KSSdtIHdvbmRlcmluZyB3
aGF0IGFyZSBvdXIgcGxhbnMgZm9yIG5vdz8NCkFyZSB3ZSBnb2luZyB0byBhY2NlcHQgcHJvcG9z
ZWQgZml4IGp1c3QgZm9yIEFSQyBpbiA0LjQgKGFuZCB0byBhbGwgc3RhYmxlcyB0aGVuKQ0Kb3Ig
d2UnbGwgdHJ5IHRvIGNvbWUgdXAgd2l0aCBtb3JlIGdlbmVyYWwgc29sdXRpb24/DQoNCi1BbGV4
ZXk=
