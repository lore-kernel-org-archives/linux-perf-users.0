Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0322D6401;
	Mon,  9 Mar 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046086; cv=none; b=aubqN7/99/zRea5SJl1s4dxjH5S82oAzaJkPbgMHOoJb0T0jslUyeUqK7UAglIy/f/y1a9BVpBXw1D1ro4dByRa2T8ZI2S/Bw0IEPenJ6707u2vgp9BzR3RVhxrG38qqUpVGpoPsTE6+gM/bYvEX+bEo7+9JrtNCRtfs/v7EPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046086; c=relaxed/simple;
	bh=YNjN3U3QMmmOB/PUlZ3OptwFm10INMeeYqTIMWwh5bs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VpOGcEzm2DepSlL1Dalj0dTiWt9tIil2M3pHEjYX/s9FJbPSJ/5danHQT3nWNMNwT5heDWjAi2qXRA5K1XE01G5MboNHK6tPlu0IZdAcBtzdx6974Pea/2dClmxd/xQJ9DnZk4TWDKtqWuHz2syWGEVdS4JBtH14YuNzLHCCI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=E6Us1ZA7; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="E6Us1ZA7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YNjN3U3QMmmOB/PUlZ3OptwFm10INMeeYqTIMWwh5bs=;
	b=E6Us1ZA7yGJHJq02U0vnVseMg0JWSYa6N3oVWXbnRiEUE6goRuP33ris4uctX1vUVj3NRLpX5
	xa96G/N+OyAJiC2UMwxNtKQ9ofhS/4uVKTCBFRo1ns8Tvi9X4CIOHLay8CTOaHoLaXUz+GWgyb1
	6ZipFfHPy9kaVTlATTnwkqs=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fTrBH2rbyz1prL6;
	Mon,  9 Mar 2026 16:43:03 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id CA08720104;
	Mon,  9 Mar 2026 16:47:59 +0800 (CST)
Received: from kwepemq500003.china.huawei.com (7.202.195.117) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 16:47:59 +0800
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 kwepemq500003.china.huawei.com (7.202.195.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 16:47:59 +0800
Received: from kwepemq200002.china.huawei.com ([7.202.195.90]) by
 kwepemq200002.china.huawei.com ([7.202.195.90]) with mapi id 15.02.1544.011;
 Mon, 9 Mar 2026 16:47:59 +0800
From: duchangbin <changbin.du@huawei.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf: Add layout support for --symfs option
Thread-Topic: [PATCH v3] perf: Add layout support for --symfs option
Thread-Index: AQHcqWv7qgRFvdXDEU29kITXQZ801LWe/w8AgACrhICABkVLgA==
Date: Mon, 9 Mar 2026 08:47:59 +0000
Message-ID: <2f617208b9fd42b682380a3306c2603b@huawei.com>
References: <20260301192455.1053900-1-changbin.du@huawei.com>
 <aaknIOp-PrDNCf-L@z2> <dd08137f2d2e4d39a37d4c50552f8a86@huawei.com>
In-Reply-To: <dd08137f2d2e4d39a37d4c50552f8a86@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemq200002.china.huawei.com (15.02.1544.011)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EEC2404B6C0674DB783990DAE9649A4@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCBNYXIgMDUsIDIwMjYgYXQgMDU6MDI6MTdQTSArMDgwMCwgZHVjaGFuZ2JpbiB3cm90
ZToNCj4gT24gV2VkLCBNYXIgMDQsIDIwMjYgYXQgMTA6NDg6MDBQTSAtMDgwMCwgTmFtaHl1bmcg
S2ltIHdyb3RlOg0KPiA+IEhlbGxvLA0KPiA+IA0KPiA+ID4gQEAgLTI0OTEsMTYgKzI0OTIsMzYg
QEAgaW50IHN5bWJvbF9fY29uZmlnX3N5bWZzKGNvbnN0IHN0cnVjdCBvcHRpb24gKm9wdCBfX21h
eWJlX3VudXNlZCwNCj4gPiA+ICAJCQkgY29uc3QgY2hhciAqZGlyLCBpbnQgdW5zZXQgX19tYXli
ZV91bnVzZWQpDQo+ID4gPiAgew0KPiA+ID4gIAljaGFyICpiZiA9IE5VTEw7DQo+ID4gPiArCWNo
YXIgKmxheW91dF9zdHI7DQo+ID4gPiAgCWludCByZXQ7DQo+ID4gPiAgDQo+ID4gPiAtCXN5bWJv
bF9jb25mLnN5bWZzID0gc3RyZHVwKGRpcik7DQo+ID4gPiAtCWlmIChzeW1ib2xfY29uZi5zeW1m
cyA9PSBOVUxMKQ0KPiA+ID4gLQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gPiArCWxheW91dF9zdHIg
PSBzdHJyY2hyKGRpciwgJywnKTsNCj4gPiA+ICsJaWYgKGxheW91dF9zdHIgJiYNCj4gPiA+ICsJ
ICAgICghc3RyY21wKGxheW91dF9zdHIgKyAxLCAiZmxhdCIpIHx8ICFzdHJjbXAobGF5b3V0X3N0
ciArIDEsICJoaWVyYXJjaHkiKSkpIHsNCj4gPiANCj4gPiBJIHRoaW5rIGl0J3MgYmV0dGVyIHRv
IGZhaWwgd2l0aCBhIG1lc3NhZ2UgaWYgdW5rbm93biBsYXlvdXQgaXMgZ2l2ZW4uDQo+ID4NCj4g
QWdyZWVkLiBUaGUgY3VycmVudCBpc3N1ZSBpcyB0aGF0IGlmIHdlIHVzZSAnLCcgYXMgdGhlIGRl
bGltaXRlciAodG8gbWFpbnRhaW4gYQ0KPiBjb25zaXN0ZW50IHN0eWxlIHdpdGggb3RoZXIgb3B0
aW9ucyksIGFuZCB0aGUgcGF0aCBpdHNlbGYgY29udGFpbnMgYSBjb21tYSwgaXQNCj4gd291bGQg
cmVzdWx0IGluIHRoZSBmb2xsb3dpbmcgYW1iaWd1aXR5Og0KPiAgLSAvcGF0aCxmbGF0IOKGkiBz
eW1mcz0vcGF0aCwgbGF5b3V0PWZsYXQNCj4gIC0gL3BhdGgsaGllcmFyY2h5IOKGkiBzeW1mcz0v
cGF0aCwgbGF5b3V0PWhpZXJhcmNoeQ0KPiAgLSAvc29tZSxwYXRoLyDihpIgc3ltZnM9L3NvbWUs
IGxheW91dD1wYXRoLw0KPiANCj4gRG8geW91IGhhdmUgYmV0dGVyIHN1Z2dlc3Rpb25zPyBVc2lu
ZyBhIGRpZmZlcmVudCBkZWxpbWl0ZXIgKGUuZy4sIDogb3IgOyk/DQo+IA0KRmluYWxseSwgSSd2
ZSBkZWNpZGVkIHRvIGdvIHdpdGggdGhlIHNpbXBsZXN0IGltcGxlbWVudGF0aW9uLiBUaGUgcmVz
dWx0IGlzOiBpZg0KdGhlIHBhdGggY29udGFpbnMgYSBjb21tYSwgdGhlIGxheW91dCBtdXN0IGJl
IHNwZWNpZmllZCwgb3RoZXJ3aXNlIGFuIGVycm9yIHdpbGwNCmJlIHJhaXNlZCAodGhlIHBhcnQg
YWZ0ZXIgdGhlIGNvbW1hIHdvdWxkIGJlIGluY29ycmVjdGx5IHJlY29nbml6ZWQgYXMgdGhlDQps
YXlvdXQgb3B0aW9uKS4NCg0KLSAvcGF0aCDihpIgc3ltZnM9L3BhdGgsIGxheW91dD1oaWVyYXJj
aHkNCi0gL3BhdGgsZmxhdCDihpIgc3ltZnM9L3BhdGgsIGxheW91dD1mbGF0DQotIC9zb21lLHBh
dGgvIOKGkiBlcnJvcg0KLSAvc29tZSxwYXRoLyxmbGF0IOKGkiBzeW1mcz0vc29tZSxwYXRoLywg
bGF5b3V0PWZsYXQNCg0KPiA+IFRoYW5rcywNCj4gPiBOYW1oeXVuZw0KPiA+IA0KPiA+ID4gKwkJ
c2l6ZV90IGRpcl9sZW4gPSBsYXlvdXRfc3RyIC0gZGlyOw0KPiA+ID4gKwkJY2hhciAqZGlyX2Nv
cHkgPSBzdHJuZHVwKGRpciwgZGlyX2xlbik7DQo+ID4gPiArDQo+ID4gPiArCQlpZiAoZGlyX2Nv
cHkgPT0gTlVMTCkNCj4gPiA+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+ICsNCj4gPiA+ICsJ
CXN5bWJvbF9jb25mLnN5bWZzID0gZGlyX2NvcHk7DQo+ID4gPiArDQo+ID4gPiArCQlsYXlvdXRf
c3RyKys7DQo+ID4gPiArCQlpZiAoIXN0cmNtcChsYXlvdXRfc3RyLCAiZmxhdCIpKQ0KPiA+ID4g
KwkJCXN5bWJvbF9jb25mLnN5bWZzX2xheW91dF9mbGF0ID0gdHJ1ZTsNCj4gPiA+ICsJCWVsc2UN
Cj4gPiA+ICsJCQlzeW1ib2xfY29uZi5zeW1mc19sYXlvdXRfZmxhdCA9IGZhbHNlOw0KPiA+ID4g
Kwl9IGVsc2Ugew0KPiA+ID4gKwkJc3ltYm9sX2NvbmYuc3ltZnMgPSBzdHJkdXAoZGlyKTsNCj4g
PiA+ICsJCWlmIChzeW1ib2xfY29uZi5zeW1mcyA9PSBOVUxMKQ0KPiA+ID4gKwkJCXJldHVybiAt
RU5PTUVNOw0KPiA+ID4gKwkJc3ltYm9sX2NvbmYuc3ltZnNfbGF5b3V0X2ZsYXQgPSBmYWxzZTsN
Cj4gPiA+ICsJfQ0KPiA+ID4gIA0KPiA+ID4gIAkvKiBza2lwIHRoZSBsb2NhbGx5IGNvbmZpZ3Vy
ZWQgY2FjaGUgaWYgYSBzeW1mcyBpcyBnaXZlbiwgYW5kDQo+ID4gPiAgCSAqIGNvbmZpZyBidWls
ZGlkIGRpciB0byBzeW1mcy8uZGVidWcNCj4gPiA+ICAJICovDQo+ID4gPiAtCXJldCA9IGFzcHJp
bnRmKCZiZiwgIiVzLyVzIiwgZGlyLCAiLmRlYnVnIik7DQo+ID4gPiArCXJldCA9IGFzcHJpbnRm
KCZiZiwgIiVzLyVzIiwgc3ltYm9sX2NvbmYuc3ltZnMsICIuZGVidWciKTsNCj4gPiA+ICAJaWYg
KHJldCA8IDApDQo+ID4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+ICANCj4gPiA+IGRpZmYg
LS1naXQgYS90b29scy9wZXJmL3V0aWwvc3ltYm9sLmggYi90b29scy9wZXJmL3V0aWwvc3ltYm9s
LmgNCj4gPiA+IGluZGV4IDNmYjVkMTQ2ZDliMS4uNGYxZGJkMWViZDk5IDEwMDY0NA0KPiA+ID4g
LS0tIGEvdG9vbHMvcGVyZi91dGlsL3N5bWJvbC5oDQo+ID4gPiArKysgYi90b29scy9wZXJmL3V0
aWwvc3ltYm9sLmgNCj4gPiA+IEBAIC05LDYgKzksNyBAQA0KPiA+ID4gICNpbmNsdWRlIDxsaW51
eC9saXN0Lmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3JidHJlZS5oPg0KPiA+ID4gICNpbmNs
dWRlIDxzdGRpby5oPg0KPiA+ID4gKyNpbmNsdWRlIDxlcnJuby5oPg0KPiA+ID4gICNpbmNsdWRl
ICJhZGRyX2xvY2F0aW9uLmgiDQo+ID4gPiAgI2luY2x1ZGUgInBhdGguaCINCj4gPiA+ICAjaW5j
bHVkZSAic3ltYm9sX2NvbmYuaCINCj4gPiA+IEBAIC05Niw2ICs5NywxOCBAQCBzdHJ1Y3QgaW50
bGlzdDsNCj4gPiA+ICANCj4gPiA+ICBzdGF0aWMgaW5saW5lIGludCBfX3N5bWJvbF9fam9pbl9z
eW1mcyhjaGFyICpiZiwgc2l6ZV90IHNpemUsIGNvbnN0IGNoYXIgKnBhdGgpDQo+ID4gPiAgew0K
PiA+ID4gKwlpZiAoc3ltYm9sX2NvbmYuc3ltZnNfbGF5b3V0X2ZsYXQpIHsNCj4gPiA+ICsJCWNo
YXIgKnBhdGhfY29weSA9IHN0cmR1cChwYXRoKTsNCj4gPiA+ICsJCWNoYXIgKmJhc2U7DQo+ID4g
PiArCQlpbnQgcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKwkJaWYgKCFwYXRoX2NvcHkpDQo+ID4gPiAr
CQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gPiArCQliYXNlID0gYmFzZW5hbWUocGF0aF9jb3B5KTsN
Cj4gPiA+ICsJCXJldCA9IHBhdGhfX2pvaW4oYmYsIHNpemUsIHN5bWJvbF9jb25mLnN5bWZzLCBi
YXNlKTsNCj4gPiA+ICsJCWZyZWUocGF0aF9jb3B5KTsNCj4gPiA+ICsJCXJldHVybiByZXQ7DQo+
ID4gPiArCX0NCj4gPiA+ICAJcmV0dXJuIHBhdGhfX2pvaW4oYmYsIHNpemUsIHN5bWJvbF9jb25m
LnN5bWZzLCBwYXRoKTsNCj4gPiA+ICB9DQo+ID4gPiAgDQo+ID4gPiBAQCAtMTY5LDYgKzE4Miwx
MSBAQCBzaXplX3Qgc3ltYm9sX19mcHJpbnRmX3N5bW5hbWUoY29uc3Qgc3RydWN0IHN5bWJvbCAq
c3ltLCBGSUxFICpmcCk7DQo+ID4gPiAgc2l6ZV90IHN5bWJvbF9fZnByaW50ZihzdHJ1Y3Qgc3lt
Ym9sICpzeW0sIEZJTEUgKmZwKTsNCj4gPiA+ICBib29sIHN5bWJvbF9fcmVzdHJpY3RlZF9maWxl
bmFtZShjb25zdCBjaGFyICpmaWxlbmFtZSwNCj4gPiA+ICAJCQkJIGNvbnN0IGNoYXIgKnJlc3Ry
aWN0ZWRfZmlsZW5hbWUpOw0KPiA+ID4gKw0KPiA+ID4gKyNkZWZpbmUgU1lNRlNfSEVMUCAic2V0
dXAgcm9vdCBkaXJlY3Rvcnkgd2hpY2ggY29udGFpbnMgZGVidWcgZmlsZXM6XG4iIFwNCj4gPiA+
ICsJIlx0XHRcdFx0IiAiZGlyZWN0b3J5Olx0TG9vayBmb3IgZmlsZXMgd2l0aCBzeW1ib2xzIHJl
bGF0aXZlIHRvIHRoaXMgZGlyZWN0b3J5LlxuIiBcDQo+ID4gPiArCSJcdFx0XHRcdCIgImxheW91
dDogICBcdExheW91dCBvZiBmaWxlcywgJ2hpZXJhcmNoeScgbWF0Y2hlcyBmdWxsIHBhdGggKGRl
ZmF1bHQpLCAnZmxhdCcgb25seSBtYXRjaGVzIGJhc2UgbmFtZS5cbiINCj4gPiA+ICsNCj4gPiA+
ICBpbnQgc3ltYm9sX19jb25maWdfc3ltZnMoY29uc3Qgc3RydWN0IG9wdGlvbiAqb3B0IF9fbWF5
YmVfdW51c2VkLA0KPiA+ID4gIAkJCSBjb25zdCBjaGFyICpkaXIsIGludCB1bnNldCBfX21heWJl
X3VudXNlZCk7DQo+ID4gPiAgDQo+ID4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL3N5
bWJvbF9jb25mLmggYi90b29scy9wZXJmL3V0aWwvc3ltYm9sX2NvbmYuaA0KPiA+ID4gaW5kZXgg
NzFiYjE3MzcyYTZjLi5hYzFiNDQ0YThmZDggMTAwNjQ0DQo+ID4gPiAtLS0gYS90b29scy9wZXJm
L3V0aWwvc3ltYm9sX2NvbmYuaA0KPiA+ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL3N5bWJvbF9j
b25mLmgNCj4gPiA+IEBAIC05Myw2ICs5Myw3IEBAIHN0cnVjdCBzeW1ib2xfY29uZiB7DQo+ID4g
PiAgCQkJKnRpZF9saXN0LA0KPiA+ID4gIAkJCSphZGRyX2xpc3Q7DQo+ID4gPiAgCWNvbnN0IGNo
YXIJKnN5bWZzOw0KPiA+ID4gKwlib29sCQlzeW1mc19sYXlvdXRfZmxhdDsNCj4gPiA+ICAJaW50
CQlyZXNfc2FtcGxlOw0KPiA+ID4gIAlpbnQJCXBhZF9vdXRwdXRfbGVuX2RzbzsNCj4gPiA+ICAJ
aW50CQlncm91cF9zb3J0X2lkeDsNCj4gPiA+IC0tIA0KPiA+ID4gMi40My4wDQo+ID4gPiANCj4g
PiANCj4gDQo+IC0tIA0KPiBDaGVlcnMsDQo+IENoYW5nYmluIER1DQoNCi0tIA0KQ2hlZXJzLA0K
Q2hhbmdiaW4gRHUNCg==
