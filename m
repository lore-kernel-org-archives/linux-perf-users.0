From: James Clark <James.Clark@arm.com>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Date: Wed, 15 Jan 2020 13:15:36 +0000
Message-ID: <eac2263e-07fb-ecb4-5e9f-3e215f2d4526@arm.com>
References: <20191220110525.30131-1-james.clark@arm.com>
 <20191223034852.GB3981@leoy-ThinkPad-X240s>
 <fd4f4278-fa43-86dc-1f2f-3439f19fea9e@arm.com>
 <20200113141751.GA10620@leoy-ThinkPad-X240s>
 <20200113145803.GB10620@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200113145803.GB10620@leoy-ThinkPad-X240s>
Content-Language: en-US
Content-ID: <534E256C26529C419E12813BBB4B0DF5@eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "leo.yan@linaro.org" <leo.yan@linaro.org>, Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd <nd@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Igor Lubashev <ilubashe@akamai.com>
List-Id: linux-perf-users.vger.kernel.org

SGkgTGVvLA0KDQo+IFNpbmNlIFNQRSBpcyBkZWZpbmVkIGluIEFSTXY4IGFyY2hpdGVjdHVyZSBy
ZWZlcmVuY2UgbWFudWFsIChBUk0gRERJDQo+IDA0ODdELmEpOyBzaG91bGQgU1BFIHRyYWNlIGRh
dGEgZm9ybWF0IGlzIHVuaWZpZWQgYW5kIGRlZmluZWQgaW4gQ2hhcHRlcg0KPiBEOSAiU3RhdGlz
dGljYWwgUHJvZmlsaW5nIEV4dGVuc2lvbiBTYW1wbGUgUmVjb3JkIFNwZWNpZmljYXRpb24iPw0K
PiANCkknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGV4YWN0bHksIGJ1dCB0aGUgdHJhY2UgZGF0
YSBmb3JtYXQgaXMgZGVzY3JpYmVkIGluDQpzZWN0aW9uIEQxMC4NCg0KVGhhbmtzDQpKYW1lcw0K
