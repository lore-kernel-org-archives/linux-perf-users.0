Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88333E1;
	Wed, 30 Oct 2024 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275648; cv=none; b=kCZLxOK5/x74btLDeK7BPK0ahBZ+KgfnLBJw/xlOK1QSbpehIBMuyCsBqBysb2viJCA1wfB+xX4BoeYGaQ9shM0tiRAYMH+9Tg5KXsuswg2FgR4HuNNuSdPHnDBozq+79Mlw17Ph3Ox1jTCbF4VVwA0cCQTDvjZPtGGcmhMUhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275648; c=relaxed/simple;
	bh=AY4UigibdlHyc7P72ece5G/HJMeI6L0dArw/r4tMTMU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bhKJ2L4nEVPEFjqbwLoeHDgopaOxlGCYz1g0diXhKwZHiHOBlTWmcF9vEbiwY3ad+gYbhsJSKzdC2SbQ0hJ4anJYGYZ2bJTyUZtCF7mcBkJnOomcR0GCmnJmzJI2941ZU73TRACDsiSYd4z4DJPqugE7rHqIvnzXmU6yyM46rz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "zhiquan1.li@intel.com"
	<zhiquan1.li@intel.com>
Subject: Re: Re: [PATCH] perf/x86/intel/bts: allocate bts_ctx only if
 necessary
Thread-Topic: Re: [PATCH] perf/x86/intel/bts: allocate bts_ctx only if
 necessary
Thread-Index: AdsqoCQMn7HthvF5RJCIQTlmmSLYkA==
Date: Wed, 30 Oct 2024 07:50:20 +0000
Message-ID: <6d59c9067b7e4711a1ea7236d639a3c2@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.36
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

> > Avoid unnecessary per-CPU memory allocation on unsupported CPUs, this
> > can save 12K memory for every CPU
>=20
> Looks reasonable, but have you tested it? This driver is in serious dange=
r of
> bitrot ever since KPTI. It might save even more if we simply remove the w=
hole
> thing.
>=20

I fine to remove it, Could you send a patch to remove it

Thank

-Li
