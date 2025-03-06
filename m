Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6BA33C9;
	Thu,  6 Mar 2025 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229137; cv=none; b=Zqg2gzinkNCLGP/WgUW95DAfmQEcb5CAeQOtBFMbLCsxDk50t8BuTLKjF+/FAaUtdyMIxqpMI3SascpGh0tdU+9i2O1UD7if1iALh9NxpTjEEMy8bome+4fwMuFHcSCB+v/qdDW/jCQdpToNJCBjsxTQCTLJW66rxr8hNj8Yr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229137; c=relaxed/simple;
	bh=y4qkiHrv5YzJwTFdfke6HPG9TVpJNfR6GD7LnkavQBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eLfzQhzYCO7IA4tPJGXI2c5PdEWM3lwwprt17HEfcqZWtUXujQNluu2dj/xrniEartFbVnBbgYfwB4L5Rw/DjvM4+KbVFEUaBS/d1dYFcfET+wjOsi3VnBDiXHaRHRUGjhayg/sZgtSpkmafOBZT2rMtPqFZbjlcmbXD2woO95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Dave Hansen <dave.hansen@intel.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Jiri Olsa <olsajiri@gmail.com>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "irogers@google.com"
	<irogers@google.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBwZXJmL3g4Ni9p?=
 =?utf-8?Q?ntel/bts:_allocate_bts=5Fctx_only_if_necessary?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gcGVyZi94ODYvaW50ZWwvYnRz?=
 =?utf-8?Q?:_allocate_bts=5Fctx_only_if_necessary?=
Thread-Index: AQHbjd8ZANFZJP37eUuTV7oAm1ygsrNkMLQAgAEx3BA=
Date: Thu, 6 Mar 2025 02:28:34 +0000
Message-ID: <5ddaff2748344dc4ac6290f195c8758e@baidu.com>
References: <20250122074103.3091-1-lirongqing@baidu.com>
 <Z8hV3WYuHxHBNoNV@krava> <Z8hXsvloKEb7ia3V@krava>
 <d70b6f8d-0e86-4814-bf05-4c3d9acd313d@intel.com>
 <293158f0-d36f-4569-bad3-6be1db938457@intel.com>
In-Reply-To: <293158f0-d36f-4569-bad3-6be1db938457@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex14_2025-03-06 10:28:35:265
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.37
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBKaXJpLCB0aGFua3MgZm9yIHRoZSByZXBvcnQhDQo+IA0KPiBPbiAzLzUvMjUgMDY6NTgsIEFk
cmlhbiBIdW50ZXIgd3JvdGU6DQo+ID4gSXQgbG9va3MgbGlrZSB0aGVyZSBhcmUgMyBmdW5jdGlv
bnMgYWZmZWN0ZWQ6DQo+ID4NCj4gPiAJaW50ZWxfYnRzX2VuYWJsZV9sb2NhbCgpDQo+ID4gCWlu
dGVsX2J0c19kaXNhYmxlX2xvY2FsKCkNCj4gPiAJaW50ZWxfYnRzX2ludGVycnVwdCgpDQo+ID4N
Cj4gPiBQZXJoYXBzIG1ha2UgdGhlbSBzdGF0aWMgY2FsbHM/DQo+IA0KPiBUaGF0LCBvciBhIGZl
dzoNCj4gDQo+IAlpZiAoIWJ0c19jdHgpDQo+IAkJcmV0dXJuOw0KPiANCj4gaWYgeW91J3JlIG5v
dCBmZWVsaW5nIGFzIGZhbmN5IHdvdWxkIGRvLg0KPiANCj4gV291bGQgc29tZW9uZSBiZSBpbnRl
cmVzdGVkIGluIHNlbmRpbmcgYW4gYWN0dWFsIHRlc3RlZCBwYXRjaCwgaWRlYWxseSB0aGUNCj4g
cGF0Y2ggYXV0aG9yIG9mIHRoZSByZWdyZXNzaW9uPyA8aGludCwgaGludD4NCg0KDQpJIGFtIHNv
cnJ5IHRvIGludHJvZHVjZSB0aGlzIGJ1ZywgSSB3aWxsIHRyeSB0byBzZW5kIGEgcGF0Y2gNCg0K
VGhhbmtzIHRvIGFsbA0KDQotTGkNCg==
