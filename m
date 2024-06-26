Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57733CFC;
	Wed, 26 Jun 2024 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719368820; cv=none; b=ih7EE3oBI1U4AE382GOVFayTAq/hFf2xJgwigsmGWHC/OMSuT+f61y23xm7OINmt+xPptNv9/+ciWRElUh/0KYwIRpRooMXRh0zSAeVjYufUQfcEYYJXvrJlYICu+tT776ko46NHB0OdgJXwB/HrCC97alRD5QMBXlVUSQg0ZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719368820; c=relaxed/simple;
	bh=4sv6GkcBtIMVu6YqAkBTIFOuXy/QrdA6g9iW/ATOHCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CccOUjAf+HYc97zdXzKDuPClGZO9GdnMHAKpuUDySirz3z8qwwJdRxQXEdfvN6bz0OFbQ3nXWj4LCn7oFKD7ISGgkthBCNCt2Xta+e/HgAKV3/PnBBGjr+Jm83JG4ioxAQBNS3P8AJqeLTICjzYargWZFl8w1zGL8SEFerI5t34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W857p4TBJz1SF2T;
	Wed, 26 Jun 2024 10:22:30 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 424DB140382;
	Wed, 26 Jun 2024 10:26:54 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 10:26:53 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Wed, 26 Jun 2024 10:26:53 +0800
From: duchangbin <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: duchangbin <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, "Liang, Kan"
	<kan.liang@linux.intel.com>, "Nick Desaulniers" <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v4 1/5] perf: support specify vdso path in cmdline
Thread-Topic: [PATCH v4 1/5] perf: support specify vdso path in cmdline
Thread-Index: AQHaxrEVrjKiye8CdEijfxK9i0rUjrHX8X6AgAFhooA=
Date: Wed, 26 Jun 2024 02:26:53 +0000
Message-ID: <7eef4826a2f3494ea1dc92ed98d543fb@huawei.com>
References: <20240625033740.223009-1-changbin.du@huawei.com>
 <20240625033740.223009-2-changbin.du@huawei.com>
 <5a9e8dae-e9d9-4a97-98f5-d76be9068342@intel.com>
In-Reply-To: <5a9e8dae-e9d9-4a97-98f5-d76be9068342@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD7EF75FA422E447A377B39F2A6A74CA@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCBKdW4gMjUsIDIwMjQgYXQgMDQ6MjA6NDlQTSArMDMwMCwgQWRyaWFuIEh1bnRlciB3
cm90ZToNCj4gT24gMjUvMDYvMjQgMDY6MzcsIENoYW5nYmluIER1IHdyb3RlOg0KPiA+IFRoZSB2
ZHNvIGR1bXBlZCBmcm9tIHByb2Nlc3MgbWVtb3J5IChpbiBidWlsZGlkLWNhY2hlKSBsYWNrcyBk
ZWJ1Z2dpbmcNCj4gPiBpbmZvLiBUbyBhbm5vdGF0ZSB2ZHNvIHN5bWJvbHMgd2l0aCBzb3VyY2Ug
bGluZXMgd2UgbmVlZCBzcGVjaWZ5IGENCj4gPiBkZWJ1Z2dpbmcgdmVyc2lvbi4NCj4gPiANCj4g
PiBGb3IgeDg2LCB3ZSBjYW4gZmluZCB0aGVtIGZyb20geW91ciBsb2NhbCBidWlsZCBhcw0KPiA+
IGFyY2gveDg2L2VudHJ5L3Zkc28vdmRzb3szMiw2NH0uc28uZGJnLiBPciB0aGV5IG1heSByZXNp
ZGUgaW4NCj4gPiAvbGliL21vZHVsZXMvPHZlcnNpb24+L3Zkc28vdmRzb3szMiw2NH0uc28gb24g
VWJ1bnR1LiBCdXQgbm90aWNlIHRoYXQNCj4gPiB0aGUgYnVpbGRpZCBoYXMgdG8gbWF0Y2guDQo+
ID4gDQo+ID4gJCBzdWRvIHBlcmYgcmVjb3JkIC1hDQo+ID4gJCBzdWRvIHBlcmYgcmVwb3J0IC0t
b2JqZHVtcD1sbHZtLW9iamR1bXAgXA0KPiA+ICAgLS12ZHNvIGFyY2gveDg2L2VudHJ5L3Zkc28v
dmRzbzY0LnNvLmRiZyxhcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc28zMi5zby5kYmcNCj4gPiANCj4g
PiBTYW1wbGVzOiAxN0sgb2YgZXZlbnQgJ2N5Y2xlczpQJywgNDAwMCBIeiwgRXZlbnQgY291bnQg
KGFwcHJveC4pOiAxNzYwDQo+ID4gX192ZHNvX2Nsb2NrX2dldHRpbWUgIC93b3JrL2xpbnV4LWhv
c3QvYXJjaC94ODYvZW50cnkvdmRzby92ZHNvNjQuc28uZA0KPiA+IFBlcmNlbnTilIIgICAgICAg
bW92cSAgICAtNDgoJXJicCksJXJzaQ0KPiA+ICAgICAgICDilIIgICAgICAgdGVzdHEgICAlcmF4
LCVyYXgNCj4gPiAgICAgICAg4pSCICAgICA7ICAgICAgICAgICAgICAgcmV0dXJuIHZyZWFkX2h2
Y2xvY2soKTsNCj4gPiAgICAgICAg4pSCICAgICAgIG1vdnEgICAgJXJheCwlcmR4DQo+ID4gICAg
ICAgIOKUgiAgICAgOyAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSghdmRzb19jeWNsZXNfb2so
Y3ljbGVzKSkpDQo+ID4gICAgICAgIOKUgiAgICAg4oaRIGpzICAgICAgZWINCj4gPiAgICAgICAg
4pSCICAgICDihpEgam1wICAgICA3NA0KPiA+ICAgICAgICDilIIgICAgIDsgICAgICAgICAgICAg
ICB0cy0+dHZfc2VjID0gdmRzb190cy0+c2VjOw0KPiA+ICAgMC4wMiDilIIxNDc6ICAgbGVhcSAg
ICAyKCVyYngpLCVyYXgNCj4gPiAgICAgICAg4pSCICAgICAgIHNobHEgICAgJDQsICVyYXgNCj4g
PiAgICAgICAg4pSCICAgICAgIGFkZHEgICAgJXIxMCwlcmF4DQo+ID4gICAgICAgIOKUgiAgICAg
OyAgICAgICAgICAgICAgIHdoaWxlICgoc2VxID0gUkVBRF9PTkNFKHZkLT5zZXEpKSAmIDEpIHsN
Cj4gPiAgIDkuMzgg4pSCMTUyOiAgIG1vdmwgICAgKCVyMTApLCVlY3gNCj4gPiANCj4gPiBXaGVu
IGRvaW5nIGNyb3NzIHBsYXRmb3JtIGFuYWx5c2lzLCB3ZSBhbHNvIG5lZWQgc3BlY2lmeSB0aGUg
dmRzbyBwYXRoIGlmDQo+ID4gd2UgYXJlIGludGVyZXN0ZWQgaW4gaXRzIHN5bWJvbHMuDQo+IA0K
PiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBhZGQgdmRzbyBhbmQgdmRzbyBkZWJ1ZyB0byB0aGUg
YnVpbGQtaWQNCj4gY2FjaGUgYW5kIGVuc3VyZSBwZXJmIGNhbiBmaW5kIGl0IHRoZXJlPw0KPiAN
Cj4gVHlwaWNhbGx5LCBnZXR0aW5nIGRzb3MgZnJvbSBhbm90aGVyIG1hY2hpbmUgaXMgaGFuZGxl
ZCB2aWENCj4gYnVpbGQtaWQgY2FjaGUgZS5nLiB3aGF0IHBlcmYtYXJjaGl2ZSBkb2VzDQo+IA0K
SG1tLiBJIGFncmVlIHRoaXMgaXMgYmV0dGVyIGFsdGVybmF0aXZlIGFwcHJvYWNoIGZvciBjcm9z
cy1tYWNoaW5lIGFuYWx5c2lzLg0KV2hlbiBjb2xsZWN0aW5nIHZkc29zIHRvIGJ1aWxkaWQgY2Fj
aGUsIEkgdGhpbmsgd2UgY2FuIHVzZSB0aGUgbG9jYWwgc2VhcmNoZWQNCm9iamVjdHMgKHdpdGgg
ZGVidWcgc3ltYm9scykgaW5zdGVhZCBpZiBpdHMgYnVpbGQtaWQgbWF0Y2hlcyB2ZHNvcyBmcm9t
IHByb2Nlc3MNCmR1bXBpbmcgKHRoZSByZWFsIGNvZGUgcmFuKS4NCg0KQ3VycmVudGx5IEkganVz
dCBmb2xsb3cgd2hhdCBwZXJmIGRvZXMgZm9yIHZtbGludXggc28gdG8gcmV1c2UgbW9zdCBvZiBl
eGlzdGluZw0KY29kZS4gTWF5YmUgdm1saW51eCBpcyB0b28gYmlnIHRvIGFkZCB0byBidWlsZGlk
LWNhaGNlPw0KDQpDYW4gd2Uga2VlcCBvdXIgY3VycmVudCBzdHJhdGVneSBmb3Igbm93PyBJJ2xs
IHRoaW5rIGFib3V0IGFib3ZlIG9wdGlvbnMgd2hlbg0KSSBoYXZlIG1vcmUgdGltZS4NCg0KLS0g
DQpDaGVlcnMsDQpDaGFuZ2JpbiBEdQ0K
