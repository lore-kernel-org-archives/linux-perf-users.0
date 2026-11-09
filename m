Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201536;
	b=kCv61hVoW6Dlg0jMGPJxBVzpU2DMgaDVFxjnfel49vbMomlOtTv683CabUpdycKK/Al9
	 7Hx0tRRH2E+7rhEdl4WzC4FzZvptYhilpWcRVNOgijI9g84jGGxgiFdf4I35JcEjYGGTC
	 brlVAaGfce8bP+VjRh6//NVZjVKoS5QjRcp396qZLXmt5Wg7woqruVIofwK6meGaif0vj
	 KqNe30rAQox0GwGmJe2yS97ElVuRlzUnnTJHCHYEYZEg+v2IRYD82IcFCgKecuufxzxr4
	 l1YRL/o/AWWMW10lWxE+/krO3dYnsl++yiXxSpcfLgHg1bpdCNNvQURCknPJgvd2dhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201536;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=Q8psQZsCNkuCQJ/0SE6gHtV3T9khaxfO8NoGBf1WRiU=;
	b=C2ubqbwHx3ub4+nGSFtz90Zs0qgRQki1LBvw+DzHbTTtdV3WpxSqA8opsNT6W54zL/lA
	 Ry7XFi4IP4ogGLOVyZPgweDQVrBEjYugC36WIq9RIjs9i3mq8ld5QRWiZvRkyiCaJ9js/
	 yzn6bne4uUgAaEhGue6+Ttw+oUzZB1tzJeSVLIDWUF97tpdPHZ8V5YgcZT1874i/0xOGs
	 kWzExOhy4piYW20Al/Tpet5kI259sJcg/WvRBwUNDYpNuB/JhLe9aysW2OfkZFtBro2Wg
	 j7DId2AejM50K8GuS89w95g2leC4wbMmhXlp4Yn0UuFhG2eCobBIiTI6JHG/z7RNNDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=KecyytpZ;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1866F606A31C;
	Mon,  9 Nov 2026 05:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1866F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=KecyytpZ
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.12
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, Alexander Antonov
	<alexander.antonov@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBwZXJmIGlvc3Rh?=
 =?utf-8?B?dDogUmVsZWFzZSB0aGUgcG9ydCBsaXN0IGlmIGNvbW1hbmQgYWxsb2NhdGlv?=
 =?utf-8?Q?n_fails?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gcGVyZiBpb3N0YXQ6IFJlbGVh?=
 =?utf-8?Q?se_the_port_list_if_command_allocation_fails?=
Thread-Index: AQHdbZUoiUZEvH9QHE+2fHHGQnrbh7ckromAgACJr5A=
Date: Mon, 9 Nov 2026 05:18:44 +0000
Message-ID: <8ad8deabd84448da837c279c670a5e17@baidu.com>
References: <20261106021840.2186-1-lirongqing@baidu.com> <avFUi_R0dzVEaT2X@z2>
In-Reply-To: <avFUi_R0dzVEaT2X@z2>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794201529;
	bh=Q8psQZsCNkuCQJ/0SE6gHtV3T9khaxfO8NoGBf1WRiU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=KecyytpZxf4Axm9bN+eVBzg5DkhzK+zMUoXe+NIBXZDXllCRwe2oEcgrFneMND9W6
	 GOz8pFDu0/WSO2BANaW8jP+V4OhSi7zMBO/QXuc7e9RYVErnrTgDEHGvqaPTq+up/d
	 HR+I1C6zK1qRMUkU/EufQEgupd+fhNCwE0jyocNStTK4spbbNBCOhCNeA5r7SoeSCt
	 knaWwvEhJlXMfCbYxqlp3ksTqRnNjSAQxR4a3nO6ia2ZaSck7Ihw/ghdkNM1PBRJ8B
	 Vl6sAjk4ACJD2o2E8hC7B6iXPdl9OxP3i8v00XqdvwDjoHXEAKcDEPx+Cf+rKJLmTC
	 C/w2/D+qyQs7Q==

PiANCj4gVGhpcyBwYXRjaCBkb2Vzbid0IGFwcGx5LiAgQ2FuIHlvdSBwbGVhc2UgcmViYXNlIG9u
dG8gdGhlIGN1cnJlbnQNCj4gcGVyZi10b29scy1uZXh0Pw0KPiANCk9rLCBJIHdpbGwgcmViYXNl
DQoNClRoYW5rcw0KDQpbTGksUm9uZ3FpbmddIA0K
