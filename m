Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CA43AA1
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780216; cv=none; b=aqB5nEGBXB7qLse8T+g8djn8U2HBsnstSNTOuD8vVaMFdrqFZIAlhLVTz6TqUSYGNPq8l2BeCdqY1q+yreJwNYz3OeudGIwPOoKyK8Q1z1DB2LL60mKIzGp/CjjXR0Ll03iCl6OjdqP2ENPym9wSHFvtodziBizNhrPDQy3ptRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780216; c=relaxed/simple;
	bh=pLNInkafyvMJLCqKsN0JnrU6yeevnjHdwc10E04qthc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=c87F5y9Qvd9UMe5rbMdl74VkcJyBmU8dmE/soZeuUuPBjSvj0fDCLToTu14pJmcxO/zu2lCSBGOVpuA8BjW0OmH7SjDHtVqV8cmXl09DlwwioMC00A+ldDCKCIs4MNOO2YcuS7OoOsKBnET5ujiV+xJbQp0Rg2SKZIIQw6yw3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-314-7hqznp6jNDaZBaoU73xMxw-1; Mon, 09 Dec 2024 21:36:51 +0000
X-MC-Unique: 7hqznp6jNDaZBaoU73xMxw-1
X-Mimecast-MFC-AGG-ID: 7hqznp6jNDaZBaoU73xMxw
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 9 Dec
 2024 21:35:52 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 9 Dec 2024 21:35:52 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ian Rogers' <irogers@google.com>, Leo Yan <leo.yan@arm.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, Kyle Meyer
	<kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/8] perf: Increase MAX_NR_CPUS to 4096
Thread-Topic: [PATCH v1 1/8] perf: Increase MAX_NR_CPUS to 4096
Thread-Index: AQHbSGgyvtgQfnajPEC7TNZcRXSH9LLeceuw
Date: Mon, 9 Dec 2024 21:35:52 +0000
Message-ID: <74f3444d28044d858f0f696cea6485a8@AcuMS.aculab.com>
References: <20241206044035.1062032-1-irogers@google.com>
 <20241206044035.1062032-2-irogers@google.com>
 <20241206102451.GA3418674@e132581.arm.com>
 <CAP-5=fVDH6k7rW3_LXK5Y9Givs3WO5MQ8XMKsuUXXY5nQ66qDg@mail.gmail.com>
 <20241206230321.GA5430@e132581.arm.com>
 <CAP-5=fXOE3k9bmYOykpN6M9bBwLqP54MWWMGxutJ4SS2G_3MZQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXOE3k9bmYOykpN6M9bBwLqP54MWWMGxutJ4SS2G_3MZQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 8ZIsBV7rw-dpZFySdyiSQnW5c3tpkTw6TqHF8tndLPg_1733780210
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4NCj4gPiA+IEp1c3QgY2hhbmdpbmcgdGhlIGludCB0byBiZSBhIHMxNiB3b3VsZCBsb3dlciB0
aGUgbWVtb3J5IG92ZXJoZWFkLA0KPiA+ID4gd2hpY2ggaXMgd2h5IEknZCBraW5kIG9mIGxpa2Ug
dGhlIGFic3RyYWN0aW9uIHRvIGJlIG1pbmltYWwuDQo+ID4NCj4gPiBIZXJlIEkgYW0gbm90IGNs
ZWFyIHdoYXQgZm9yICJjaGFuZ2luZyB0aGUgaW50IHRvIGJlIGEgczE2Ii4gIENvdWxkIHlvdQ0K
PiA+IGVsYWJlcmF0ZSBhIGJpdCBmb3IgdGhpcz8NCj4gDQo+IEkgbWVhbnQgdGhpcyA6LSkNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MTIwNzA1MjEzMy4xMDI4MjktMS1pcm9n
ZXJzQGdvb2dsZS5jb20vDQoNCkhvdyBtYW55IHRpbWUgaXMgdGhpcyBhbGxvY2F0ZWQ/DQpJZiBp
dCBpcyAyIGJ5dGVzIGluIGEgbGFyZ2VyIHN0cnVjdHVyZSBpdCBpcyBsaWtlbHkgdG8gYmUgbm9p
c2UuDQpGb3IgYSBsb2NhbCB0aGUgY29kZSBpcyBsaWtlbHkgdG8gYmUgd29yc2UuDQpBbnkgbWF0
aHMgYW5kIHlvdSBzdGFydCBmb3JjaW5nIHRoZSBjb21waWxlciB0byBtYXNrIHRoZSB2YWx1ZQ0K
KG9uIHByZXR0eSBtdWNoIGFueXRoaW5nIGV4Y2VwdCB4ODYpLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

