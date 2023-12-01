Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C28110F3
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 04:05:49 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-206-X74kH0vROIOvVwf52dPxkQ-1; Fri, 01 Dec 2023 12:05:38 +0000
X-MC-Unique: X74kH0vROIOvVwf52dPxkQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Dec
 2023 12:05:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Dec 2023 12:05:32 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnaldo Carvalho de Melo' <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it isn't
 available in busybox
Thread-Topic: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it
 isn't available in busybox
Thread-Index: AQHaI9e+SqSraxumCUi58U+dHeCYHbCUUq5A
Date: Fri, 1 Dec 2023 12:05:31 +0000
Message-ID: <ecad5dffa8474ed8a5367e917610e707@AcuMS.aculab.com>
References: <ZWkEeqdmCHMLhLr2@kernel.org>
In-Reply-To: <ZWkEeqdmCHMLhLr2@kernel.org>
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

Li4uDQo+ICAjIENyZWF0ZSBsaXN0IG9mIGFyY2hpdGVjdHVyZXMgdGhhdCBoYXZlIGEgc3BlY2lm
aWMgZXJybm8uaC4NCj4gIGFyY2hsaXN0PSIiDQo+IC1mb3IgYXJjaCBpbiAkKGZpbmQgJHRvb2xz
ZGlyL2FyY2ggLW1heGRlcHRoIDEgLW1pbmRlcHRoIDEgLXR5cGUgZCAtcHJpbnRmICIlZlxuIiB8
IHNvcnQgLXIpOyBkbw0KPiArZm9yIGFyY2ggaW4gJChmaW5kICR0b29sc2Rpci9hcmNoIC1tYXhk
ZXB0aCAxIC1taW5kZXB0aCAxIC10eXBlIGQgfCB3aGlsZSByZWFkIGFyY2ggOyBkbyBiYXNlbmFt
ZQ0KPiAkYXJjaCA7IGRvbmUgfCBzb3J0IC1yKTsgZG8NCj4gIAl0ZXN0IC1mICR0b29sc2Rpci9h
cmNoLyRhcmNoL2luY2x1ZGUvdWFwaS9hc20vZXJybm8uaCAmJiBhcmNobGlzdD0iJGFyY2hsaXN0
ICRhcmNoIg0KPiAgZG9uZQ0KDQpKZWVwZXJzIC4uLg0KRG9lcyB0aGlzIHdvcms/DQoJZm9yIGYg
aW4gJHRvb2xzZGlyL2FyY2gvKi9pbmNsdWRlL3VhcGkvYXNtL2Vycm5vLmg7IGRvDQoJCVsgISAt
ZiAkZiBdICYmIGJyZWFrDQoJCWQ9JHtmJS9pbmNsdWRlL3VhcGkvYXNtL2Vycm5vLmh9DQoJCWFy
Y2hsaXN0PSIke2QjIyovfSAkYXJjaGxpc3QiDQoJZG9uZQ0KTm8gZm9yaygpcyBvciBleGVjKClz
Lg0KSSB0aGluayBpdCBvbmx5IGRpZmZlcnMgaW4gaGF2aW5nIGEgdHJhaWxpbmcgc3BhY2UgaW5z
dGVhZCBvZiBhIGxlYWRpbmcgb25lLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

