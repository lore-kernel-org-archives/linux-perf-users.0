From: James Clark <James.Clark@arm.com>
Subject: Re: [PATCH] Fixes hang in zstd compression test by changing the
 source of random data.
Date: Fri, 23 Aug 2019 08:30:54 +0000
Message-ID: <94cf610f-440d-a35d-9dc0-7c4941f03386@arm.com>
References: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
 <20190822212407.GJ3929@kernel.org> <20190822212450.GK3929@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822212450.GK3929@kernel.org>
Content-Language: en-US
Content-ID: <6C07E2E6EC3E7944A2EE1BE04400FDEA@eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>, "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, nd <nd@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Linton <Jeremy.Linton@arm.com>
List-Id: linux-perf-users.vger.kernel.org

U29ycnkgYWJvdXQgdGhhdCwgSSB3aWxsIGxvb2sgaW50byBpdC4NCg0KVGhhbmtzDQpKYW1lcw0K
DQpPbiAyMi8wOC8yMDE5IDIyOjI0LCBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gd3JvdGU6DQo+
IEVtIFRodSwgQXVnIDIyLCAyMDE5IGF0IDA2OjI0OjA3UE0gLTAzMDAsIEFybmFsZG8gQ2FydmFs
aG8gZGUgTWVsbyBlc2NyZXZldToNCj4+IEVtIFRodSwgQXVnIDIyLCAyMDE5IGF0IDAxOjU1OjE1
UE0gKzAwMDAsIEphbWVzIENsYXJrIGVzY3JldmV1Og0KPj4+IFJ1bm5pbmcgJ3BlcmYgdGVzdCcg
d2l0aCB6c3RkIGNvbXByZXNzaW9uIGxpbmtlZCB3aWxsIGhhbmcgYXQgdGhlIHRlc3QNCj4+PiAn
WnN0ZCBwZXJmLmRhdGEgY29tcHJlc3Npb24vZGVjb21wcmVzc2lvbicgYmVjYXVzZSAvZGV2L3Jh
bmRvbSBibG9ja3MNCj4+PiByZWFkcyB1bnRpbCB0aGVyZSBpcyBlbm91Z2ggZW50cm9weS4gVGhp
cyBtZWFucyB0aGF0IHRoZSB0ZXN0IHdpbGwNCj4+PiBhcHBlYXIgdG8gbmV2ZXIgY29tcGxldGUg
dW5sZXNzIHRoZSBtb3VzZSBpcyBjb250aW51YWxseSBtb3ZlZCB3aGlsZQ0KPj4+IHJ1bm5pbmcg
aXQuDQo+Pg0KPj4gbWVzc2FnZSBjYW1lIG1hbmdsZWQsIGhhZCB0byBkbyBpdCBieSBoYW5kIGFu
ZCB0aGVuIGhvb2sgdXAgeW91ciBoZWFkZXINCj4+IHNvIGFzIHRvIGdldCB0aGUgY29ycmVjdCBk
YXRlLCBhdHRyaWJ1dGlvbiwgZXRjLCBwbGVhc2UgY2hlY2sNCj4+IERvY3VtZW50YXRpb24vcHJv
Y2Vzcy9lbWFpbC1jbGllbnRzLnJzdCwNCj4gDQo+IEhhdmluZyBzYWlkIHRoYXQsIHRoYW5rcywg
YXBwbGllZC4NCj4gDQo+IC0gQXJuYWxkbw0KPiANCg==
