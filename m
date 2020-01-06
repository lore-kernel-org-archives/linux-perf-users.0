From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 20/20] tools lib: Fix builds when glibc contains strlcpy()
Date: Mon, 6 Jan 2020 17:03:26 +0000
Message-ID: <bd755ddc840a485098f9e51d2692f39d@AcuMS.aculab.com>
References: <20200106160705.10899-1-acme@kernel.org>
 <20200106160705.10899-21-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200106160705.10899-21-acme@kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: 'Arnaldo Carvalho de Melo' <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Vitaly Chikunov <vt@altlinux.org>, Dmitry Levin <ldv@altlinux.org>, Josh Poimboeuf <jpoimboe@redhat.com>, kbuild test robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

RnJvbTogQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+IFNlbnQ6IDA2IEphbnVhcnkgMjAyMCAx
NjowNw0KPiANCj4gRnJvbTogVml0YWx5IENoaWt1bm92IDx2dEBhbHRsaW51eC5vcmc+DQo+IA0K
PiBEaXNhYmxlIGEgY291cGxlIG9mIGNvbXBpbGF0aW9uIHdhcm5pbmdzICh3aGljaCBhcmUgdHJl
YXRlZCBhcyBlcnJvcnMpDQo+IG9uIHN0cmxjcHkoKSBkZWZpbml0aW9uIGFuZCBkZWNsYXJhdGlv
biwgYWxsb3dpbmcgdXNlcnMgdG8gY29tcGlsZSBwZXJmDQo+IGFuZCBrZXJuZWwgKG9ianRvb2wp
IHdoZW46DQo+IA0KPiAxLiBnbGliYyBoYXZlIHN0cmxjcHkoKSAoc3VjaCBhcyBpbiBBTFQgTGlu
dXggc2luY2UgMjAwNCkgb2JqdG9vbCBhbmQNCj4gICAgcGVyZiBidWlsZCBmYWlscyB3aXRoIHRo
aXMgKGluIGdjYyk6DQo+IA0KPiAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBleGVjLWNtZC5jOjM6
DQo+ICAgdG9vbHMvaW5jbHVkZS9saW51eC9zdHJpbmcuaDoyMDoxNTogZXJyb3I6IHJlZHVuZGFu
dCByZWRlY2xhcmF0aW9uIG9mIOKAmHN0cmxjcHnigJkgWy1XZXJyb3I9cmVkdW5kYW50LWRlY2xz
XQ0KPiAgICAgIDIwIHwgZXh0ZXJuIHNpemVfdCBzdHJsY3B5KGNoYXIgKmRlc3QsIGNvbnN0IGNo
YXIgKnNyYywgc2l6ZV90IHNpemUpOw0KPiANCj4gMi4gY2xhbmcgaWdub3JlcyBgLVdyZWR1bmRh
bnQtZGVjbHMnLCBidXQgcHJvZHVjZXMgYW5vdGhlciB3YXJuaW5nIHdoZW4NCj4gICAgYnVpbGRp
bmcgcGVyZjoNCj4gDQo+ICAgICBDQyAgICAgICB1dGlsL3N0cmluZy5vDQo+ICAgLi4vbGliL3N0
cmluZy5jOjk5Ojg6IGVycm9yOiBhdHRyaWJ1dGUgZGVjbGFyYXRpb24gbXVzdCBwcmVjZWRlIGRl
ZmluaXRpb24gWy1XZXJyb3IsLVdpZ25vcmVkLWF0dHJpYnV0ZXNdDQo+ICAgc2l6ZV90IF9fd2Vh
ayBzdHJsY3B5KGNoYXIgKmRlc3QsIGNvbnN0IGNoYXIgKnNyYywgc2l6ZV90IHNpemUpDQo+ICAg
Li4vLi4vdG9vbHMvaW5jbHVkZS9saW51eC9jb21waWxlci5oOjY2OjM0OiBub3RlOiBleHBhbmRl
ZCBmcm9tIG1hY3JvICdfX3dlYWsnDQo+ICAgIyBkZWZpbmUgX193ZWFrICAgICAgICAgICAgICAg
ICBfX2F0dHJpYnV0ZV9fKCh3ZWFrKSkNCj4gICAvdXNyL2luY2x1ZGUvYml0cy9zdHJpbmdfZm9y
dGlmaWVkLmg6MTUxOjg6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gaXMgaGVyZQ0KPiAgIF9f
TlRIIChzdHJsY3B5IChjaGFyICpfX3Jlc3RyaWN0IF9fZGVzdCwgY29uc3QgY2hhciAqX19yZXN0
cmljdCBfX3NyYywNCg0KV2h5IG5vdCBqdXN0IGFsd2F5cyB1c2UgdGhlIGxvY2FsIHZlcnNpb24g
YnkgcmVuYW1pbmcgaXQ/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=
