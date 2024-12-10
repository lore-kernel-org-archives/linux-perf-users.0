Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73237DA6C;
	Tue, 10 Dec 2024 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814399; cv=fail; b=aniMSerOPmuDmYSoHajWMXpaCDRzK9opyQKavnBtLfLNxGTT4cmJ9akbYsnUEI3A2bDflSqtyB0WtUFsNVgmeNXJW3Ost7Z1VY+Eu/yfgj4amGmUsudkw/yBHhLU5FFMo6OLdbYdo4UWEKhh8eCnbFw0+mXf2e/VwFbmsYi+LCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814399; c=relaxed/simple;
	bh=VUC7ZfpevODfKVVeimjZMGl4f/DB4T4MpHYxhwyk2Z4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D7U8qkXGoRCUTjhO1J1amznxx66vijXbuSxDEBxOl935lFWnv/bfueSfZKdIocfcJlZUyJF/bbfqnJBnJeEZPsqSKa+0eyV7H3q/PZuG9+sX1LdlG1WEKAknvolTTyLLgKjk4GuZVmlS6iq2kNR6Kmr508xu+yMrrzoapNSfhrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eCu6EpSi; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eCu6EpSi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733814396; x=1765350396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VUC7ZfpevODfKVVeimjZMGl4f/DB4T4MpHYxhwyk2Z4=;
  b=eCu6EpSijXyyUqe/o+PStYUm0wXXPBvfb96r1q29c8sl9KHWNtpyqrrL
   X2/jDk/JagJfliGe+Xg+YHysLHOvIidbWh252vXeHx1dXOMD/bx70b5er
   +vPLUowns+LlU4bPi6eRRPfgHVAqqk2eWVwEOYR4y3kFYYfTy4znka/sU
   +hwVLKeFuC0cH8nNXqFD8Rj9C3xTRA2whowUIheJe010jFb+sh1djhcYM
   jRdX8JUGJ+b6DLj/1T/7CRcdEpWSQjrJ0gJlaYekio8KoR14dPrVnbas5
   GPz6Lp8k23FPTFO8TJ8EgpeThEhHe5GTWwX9vW4Pyr+z8zTXoGbWV/QuG
   w==;
X-CSE-ConnectionGUID: iiCVT4eUSMmeQDO5CecoYg==
X-CSE-MsgGUID: 6ptgdL9QTx2mq5r55q5Igw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="139833004"
X-IronPort-AV: E=Sophos;i="6.12,221,1728918000"; 
   d="scan'208";a="139833004"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 16:05:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=citqmjr2Dr6ggv4GnPUEPWEJHdSQvW+qS9TaocPKCeTLEQ1YUn5cKbrKMpfka+0NAfbwX0Uhnn5jYhMlEb70qYro/DxURQGx0qUBkKgEi/AF+XWJxU6Ea63iHbC+zWcRm/bZXQiXVkewUf7wGA50AWlEJ1ds2sI4BB34CRURYA15l7ynSP27mGkYWf7AY+brnJUNVgr7oSxLHYvgwoHwbhk5k6A5G3D0js0vFQcKyrE9EfVEbIjdJ0To4tUEEvhKTpG+grZxKmWBtmCdiIZDrsghSx92u8cMUcgO5qLaQI1eR6KDdM6imxcUj0Vw0RlXofct0EdwzJakb5yFam4KkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUC7ZfpevODfKVVeimjZMGl4f/DB4T4MpHYxhwyk2Z4=;
 b=OfCmBBCff6CGtuGVMrkDJZOrk4CB7jKW1Y1yZXy/0rl5boR4Xvcp2xlT2S9nf0CbTDyTW+rr46ww/b/ThzLceixRUNWTQDzPkz7/EFgU3EW8Ju7K9p8BMtBNLNn+rv4vsYkXmXvE/5lxzo8qMQs1AKQB+7memzwh/34tGlINSj6QviHvPskpEjH5gVjlUcgCND0CTqM9B9sYrJz9a69gz22j0vf/BcrOXvASXZTdLG6CXOm0wOFoxI1DGbMwDGuNoH1cCNwnqxdPVCZwqpkWeVnesQQIw4XH0dU9Yh3sKPVp5adOpPOBO9TVRE0enVyOJxkpGEZsiRVciyZWpAhvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com (2603:1096:604:12c::9)
 by OSOPR01MB12344.jpnprd01.prod.outlook.com (2603:1096:604:2db::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 07:05:16 +0000
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe]) by OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe%7]) with mapi id 15.20.8230.008; Tue, 10 Dec 2024
 07:05:16 +0000
From: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
To: 'James Clark' <james.clark@linaro.org>
CC: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Mike
 Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Xu Yang <xu.yang_2@nxp.com>, Jing Zhang
	<renyu.zj@linux.alibaba.com>, Lucas Stach <l.stach@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Akio Kakuno (Fujitsu)"
	<fj3333bs@fujitsu.com>, "nick.forrington@arm.com" <nick.forrington@arm.com>
Subject: RE: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu event
Thread-Topic: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu
 event
Thread-Index: AQHbNAXE9up773d9C0m6SoSVyIeLDbLd2qmAgAFgUmA=
Date: Tue, 10 Dec 2024 07:05:15 +0000
Message-ID:
 <OS3PR01MB690303F6D0FAF71ADDE7AA4BD43D2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
References: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
 <ee89c235-a126-4874-994d-b2489eb1c00f@linaro.org>
In-Reply-To: <ee89c235-a126-4874-994d-b2489eb1c00f@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MmM3NzQ3NzctNGUyZS00YWVmLThhOWItODYxOWM3YjQ4?=
 =?utf-8?B?NTZmO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTEyLTEwVDA3OjAzOjI3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6903:EE_|OSOPR01MB12344:EE_
x-ms-office365-filtering-correlation-id: d2ba177a-992b-48fc-5b4d-08dd18e8ffdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWRBYXZhU2RSV3hSL29WeUJnSVBpNkZCS1hPRDNyd2ZTU1BlQzNIQmFGNGpZ?=
 =?utf-8?B?SUYxeWlBRm1JZlk0WFE3U2R2SDhzQU5YeldMZWtodUIySzR0R3V5THpEeGtw?=
 =?utf-8?B?S096U085cDJPdkdaNEZaeWJzcmYzYXY4ekJJazdUUFlaQitlQmVMZ0lNOXFE?=
 =?utf-8?B?L1YvRWEzSVc0TSt4dzZVajUyZjN6Mk43Z1hqVU41T0NXczJtdGJaVSt6ZG5S?=
 =?utf-8?B?aTdoczM1QjJQT09GN0w4U0x0UXgvSHlWZlZoQVc1c3J4QURCSTdzbnRESGRw?=
 =?utf-8?B?Y0RFY3JiaDFIWmtjd2JSYkdJVGpVbGFyeHI0NEkxZXA3VE1ocVVQZ1MyaEJo?=
 =?utf-8?B?aWtud09CTlVBRXd2RitSV2ViQTlGU3RZVUorand2dUh1UC8zOFdURkdpYW9T?=
 =?utf-8?B?U3Y2Z2VYTGJoQ0FVTjhGeEZibWNTNlU4dkszdWVSSTJqdWRndjFrYmVwbDZ5?=
 =?utf-8?B?QXdiQWhVNGVpL0EzTEgvdzV5TFQxeDdqTmtyc2FYWGZLTmc5bHhlbzBSV3Ns?=
 =?utf-8?B?UWhEaURaU25HOTN3dHl0djJSMGwzYkViamJjMkY4TElMdkEwQVhMSmJJWVFV?=
 =?utf-8?B?OC85aHJzMmJPcWRPTkI2c3ZCTS92TktvWU9BemxReUFsSFlvWUdwOFdSdTl6?=
 =?utf-8?B?cFJvYWF3bW53RG9TUXNuVDgrenVUQ1RwcW5FM2t0RDRnY0YzNlJRYmc2SWhh?=
 =?utf-8?B?bldWa2NxWElHeWdTWitGSUZjOUhmdm5WNEgya0NBMm81T3QwZmhselg3UHhV?=
 =?utf-8?B?ZUpPckpBWktvVzlEdDFjM3RpbWRpYnU1aDJ4MlVpRDFnMDBmNmZQU0RKd2FP?=
 =?utf-8?B?MlptTmV1OFNkVmVScXNBTHp3QyswM2d3cThwdHRIMURCeFF2L1NQZy90aWpS?=
 =?utf-8?B?UU8wVVlmdHFndGlmMTc3cjdWL3J1OXJPd0QvbU40QU1kNlZMQ1dxYS8vbiti?=
 =?utf-8?B?ZzNmUFA1cjIraEZ4UTZwNFN0RGY3b2JxcUFOd25VbXZxcHQ5blhRY1pxdmV1?=
 =?utf-8?B?endPL3dEK2ptRTBBaXN0YWl0dlNaK3NuSU5XTXo0aVpMcWRPVUU0WW0wZEFC?=
 =?utf-8?B?M0lkUEQ3VnQ0T2NpSUdTQXltZlZkV2lWKzUramVWN3JwTkNuTDBjRHFKOGhn?=
 =?utf-8?B?M09SMU5tSlhqRUIzejRNelRxS3RQQThOUEcvdVRwZnBseGQ2Tm12Wm5xY0s5?=
 =?utf-8?B?cmlISnorL0kybFlxeXZTQzBNWThxQnQxT1dER1NUaXVQTjErdjltWGJBQlky?=
 =?utf-8?B?MGEvUlYwcExQVHA1UEJxYmhEMXBySnVUNmRDa2g1N29TeEtXcEJ4N2ZvZ2hS?=
 =?utf-8?B?eHBBMWxvUGtnYVVXRU9HeWRNKzVOME14RnFMVnpteVd3NklJMjNSeWo5d211?=
 =?utf-8?B?Z2VlVXh2Q3ZyYUJXSHJtN3ZiS1BSbHIvUVJGN2NCK3hPV3V3dkNmOXUvRmlj?=
 =?utf-8?B?a1pmVThVc2VkWC9EWCtGYWpPY0kxOFVQbktnSlczRERncTJnc3hraEYyeVpn?=
 =?utf-8?B?eWhDUGU4czZIcGtFNFdVMXgvcnFyLzFYd3U1c0tsekpXSHpoTERUUlEwcGFv?=
 =?utf-8?B?Uk4wci9ock9LcUp5NWZKbVM1VFJPdk44Smo2bWFEWk1lT0lDbXV6MHdaeG1p?=
 =?utf-8?B?NDhsVUV3c0lpMmRrUnh6ekYvMXZ0OXUzM3Z5empVVjlkRHlYMVdNNHBBSSth?=
 =?utf-8?B?QkFqZ2FRaXBtekI0OWdFNnpoRlU5UHc2NTI2VVpYZEZKV1F5dGVJMFF6SG93?=
 =?utf-8?B?K3dPUGVmVXUwQ0hVbS9EY3hRNHNBNUloaitGNDFZaWNUU0V4N3BKZ0lnMHgw?=
 =?utf-8?B?WWdPTVRrNllvdlM5bDFlQ1BCUmVzQ3FyZnZZeFVsVVdhZ0Job1BZMi82TDZk?=
 =?utf-8?B?eGhhL0duU3ppdndZTzUzNEphOEJWS0orY1pZTStEVGxNZ0EwTnljWDFHbHpq?=
 =?utf-8?Q?wfy6Z/yEtUynps7TR6Z2ZL3X+c2anFSw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6903.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTNtZG9Wa01kdmhKOWRqWU9XYTVQdURLR001YUlRM1BiakJYeDZOYkxEZDhl?=
 =?utf-8?B?SkZZVDF4VDdrZHdJMXhWWjF5L2s1ZU5JVjl4cXo1QWo2bFN3emgwVjJEVXEx?=
 =?utf-8?B?K3k1UlJzQTU2elp1N214NENZcWJCcXVyTG16aDJhNFNvcHIwVDltZFdLUFho?=
 =?utf-8?B?bitHTWFGc2Q4aG9PT01HVWdJbUJCcVVKd0pSNnc1Q0haVFF5cTFlemJWalVO?=
 =?utf-8?B?KzNyY1VBeEphZ2JZVSszbEo4L3o5UUhNamZCeG9ScU5Ta2NhUWxNMlBPR3JS?=
 =?utf-8?B?T3hRTkdOYWdiUkJvcWh6Zk9ZSHBaWXRxVmRUUVlrQ1R2U1ZBdDkyVTZuLzdJ?=
 =?utf-8?B?ZWxySFBhM2YwQlVuUVBJYkNYdUVGWG12MFQ2SUJmZWk2WWhPZE4zQzhNdXNa?=
 =?utf-8?B?L3Q1YzQ1N09EalZTbGpGYndlQ0xrQWhrVDJwSGNRc2ovVll2aGs3VW9BNVR3?=
 =?utf-8?B?Y1ZEL2RBbmFMNkp5K3RaQ0NGUVhjWWtZOWxDdm1aOHVhRDYwR0MvaVRka0Rv?=
 =?utf-8?B?M1hIME9mVUpCdm9qSWJHY0hFSGhVdEFWNjJNZm1ZSlhoSUpZVTc5dVBxbXJ5?=
 =?utf-8?B?WFBGZEprMGhwYVo3MnhwQ1p6QzR3ZEtVY3h2UzNjOFNHdHBGdjdtV2JFc1Av?=
 =?utf-8?B?TmtSb0lrSFIraVJNNndRcmdCREY5MWFvV285TDUrdEpZVWJVeWFMMVl5S0JP?=
 =?utf-8?B?N3dCc2F5eFlBWkk1SUZkWlo4S0V4eVRlVmNPRFVNYjNkaUpHRnIrZlBDdkVt?=
 =?utf-8?B?ZkF3OVRXUjFud0diTTBuenBwWTNFQ1E0Y2hOU2M5YmVPN3hDSCsreERrNmEy?=
 =?utf-8?B?UFN3ckI0YlBOYy9ETkkrN1p5UXh1bVc1am1URGdqczZXam5qMzJMUzVmUFhx?=
 =?utf-8?B?aTVIRVRiWWpkQUk3cHV3U0lZdWpZQTlTaUlzNGZzZ3E5bzBSamNoRDdxZ3NL?=
 =?utf-8?B?MjFQd0tVV3d4RDRyVmlUaEgyRUZMRWMrQ09XRERjazZOeis5QTg3Vy9GT1Uy?=
 =?utf-8?B?YWNQQnpRMVN4djVDTXBid1E2aXFmWE5YOUJsQStwWWg0R0dyZUtMV2VJcldE?=
 =?utf-8?B?SU1VNE9IQUZyU3hmN0pBb0pFc0ZHNzBGZjNURWROOUZZTmtOTFdWYXFkVjRz?=
 =?utf-8?B?MHlzVExiWmR2bnpTSEN0RVQ0MlYyeEhGU3Z2RE1oZ1d5OEs1amQ5M1FHbldF?=
 =?utf-8?B?c0R0M21HdDU0V0VKZ1NJY3hqcitlalR2WkRmajJ2RnNUeURKMUtjZFdFdjdH?=
 =?utf-8?B?U0FjeVh0bDhMQVl1dnJLc1g2NVlONDJyUlo4VTlJdUxDVG4xdGdIWm80VHpa?=
 =?utf-8?B?NDhYT0FpUkRBV2pUUzAvSnJKMTUwVHpkZWMrZ1hTc0RLZnhMdkZ6WE9POTcw?=
 =?utf-8?B?aGFCeGwvalN5UEtFMVI4bXBvZ3R0SlpsbFgxMmFCRDBsMlJWWTQzMEZlMTZK?=
 =?utf-8?B?VG5jMm1JR1d1bHlacEpUSlRzdDUvMnB0SUJoZFpuRTlRbjVVMmVGajJEd2hu?=
 =?utf-8?B?S05GbEdreFQvVG9MZURucUE5UmRKRGVpelBydXJzMmRoREJNVGlsSWt2UktL?=
 =?utf-8?B?V1Nyc3FTeEpVSVJlQXJLRVZyWi9aT2QzUE5BeDVweTljYXhjR0hmZzdFNlJS?=
 =?utf-8?B?OEIwbkhvYTFFUDZtak9iMmxzSm1HVXJESGpTWndnSm02ZHF0VEl0YlNWeVVS?=
 =?utf-8?B?ay9pSFBuTzlBYTBPVDVXY2xjN3JJUEtNZ2tUYzVhTGd3dndjWFljK3hYM0N1?=
 =?utf-8?B?dlM1ZnFaOUx2WGl0OEVMN3hleDdURk5FbDJPNnpTOUxJTm9ISTI3T1pZVUNy?=
 =?utf-8?B?UUFQdDRJOW5RQ1hRVnlqb0t5dms2SUFsSUFSeHAvNmJwbUdlSlRRbVdpM1Yr?=
 =?utf-8?B?aDFtRjJCSm5MZVh0allnTXVHdUV3Z0FYZkN3WGp3VHhZZTN5eXNzeGFNMGZC?=
 =?utf-8?B?QU9hOTFvKzFoNUlORGhtUEI3NkJVbnluQldSZFc4WE1hTk1jbW40dWpDQXBI?=
 =?utf-8?B?ODZZRGdnZ2gvVS9ZZllOOWVPNGNrRW9HdmtBbHdrSDdSanpZTEFNeU15TkRY?=
 =?utf-8?B?VUdRVmlXZGlrVGJaWE00dUsyNE1tblUrV2VNS0htWisrTHA2T1FQZlIyMnB5?=
 =?utf-8?B?UFVjZTdhSVVoNWNOV2hSdHZLOGFGK2VFc1JTaUJybDRodHJMdnZxb2NzOFJR?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zHAyKRXCWiB6xheaUEWLwjYHilXTYwBnNEbjmgwfUAyujd8CHg/IdPnnePl5xjPCXXSlY6YMhMW//8IzsIEEkunBA3K+CzuF4FVaMB4Cm5JAQUTjBiL5Wy9wDikl5MYmr7vlPE7z/x10R5nmVb9W7xDHys3LpMgr0d7j5cRMjOAkFEgfw72j4HrB9iyWMnY+PSWVkPKOFicLJlNMYcTKCm6Sd1QDukaa8qm3PYMUNncz1k3npcbL+r2KA5Eu1X4viHeQXyLXSobu3Zk6MtndkrNMs22NuYD3bUMcHxcoEdAQBOHfpUjwdIUB0MWtiEEK4iTYgHf8ThHIGPjSKx0LwGTkjB6+w9uGN8EGSJv5fwi9klXuAldERs/pzqrCAgyfho60UywWSmNGa75FosQ8/wD7EX8h8ITG0lvp8/wI1hMh/5aboe6o4YSxnOpO4LIjknDQ65gKD8iUKAMTjcxcNbFC66Droib0m4+DhthMHlUWsxEslfBFpVvaMldPjK/2zjxoY0cgXSBIpOynPxe60Wehqyv+S2rkqYz0WjJ4bad/BlOYkyGIJtmx8lfJzvdiLCCYd6qyMnaxKPNd7Di5nQRDFtHHo+peQoB3al87TpkE81JXZiwg7WCVRisq5q3C
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6903.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ba177a-992b-48fc-5b4d-08dd18e8ffdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 07:05:16.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2Va9uyIJNFQeLcD/+AV77OfD5RWxIRESPgWkR6FKRh2WfigudEkhbt54eT6Dlf4Av8NwjZ1Zb52fBAEjQ/mDY29cURh5rLZbyeQsQFQVks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12344

SGksIEphbWVzDQpUaGFua3MgZm9yIHlvdSByZXZpZXcvY29tbWVudHMuDQoNCj4gT24gMTEvMTEv
MjAyNCA2OjQ4IGFtLCBZb3NoaWhpcm8gRnVydWRlcmEgd3JvdGU6DQo+ID4gICAgICBBZGQgcG11
IGV2ZW50cyBmb3IgRlVKSVRTVS1NT05BS0EuDQo+ID4gICAgICBBbmQsIGFsc28gdXBkYXRlZCBj
b21tb24tYW5kLW1pY3JvYXJjaC5qc29uIGFuZCByZWNvbW1lbmRlZC5qc29uLg0KPiA+DQo+ID4g
ICAgICBGVUpJVFNVLU1PTkFLQSBTcGVjaWZpY2F0aW9uIFVSTDoNCj4gPiAgICAgIGh0dHBzOi8v
Z2l0aHViLmNvbS9mdWppdHN1L0ZVSklUU1UtTU9OQUtBDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBa2lvIEtha3VubyA8ZmozMzMzYnNAYWEuanAuZnVqaXRzdS5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWW9zaGloaXJvIEZ1cnVkZXJhIDxmajUxMDBiaUBmdWppdHN1LmNvbT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gQ2hhbmdlICJTVkVfSU5UNjRfRElWX1NQRUMiIHRv
ICJTVkVfSU5UX0RJVjY0X1NQRUMiIGluDQo+IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL2Fy
bTY0L2Z1aml0c3UvbW9uYWthL3N2ZS5qc29uLg0KPiA+IC0gTGluayB0byB2MToNCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDExMTEwMjQ1MjkuMjk4NTg5NC0xLWZqNTEwMGJp
QGZ1aml0c3UuDQo+ID4gY29tLw0KPiA+DQo+ID4gICAuLi4vYXJjaC9hcm02NC9jb21tb24tYW5k
LW1pY3JvYXJjaC5qc29uICAgICAgfCA4NTgNCj4gKysrKysrKysrKysrKysrKysrDQo+ID4gICAu
Li4vZnVqaXRzdS9tb25ha2EvY3ljbGVfYWNjb3VudGluZy5qc29uICAgICAgfCAxNDYgKysrDQo+
ID4gICAuLi4vYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9lbmVyZ3kuanNvbiAgICAgfCAgMjAg
Kw0KPiA+ICAgLi4uL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvZXhjZXB0aW9uLmpzb24gIHwg
IDMyICsNCj4gPiAgIC4uLi9hcm02NC9mdWppdHN1L21vbmFrYS9mcF9vcGVyYXRpb24uanNvbiAg
ICB8IDE5NCArKysrDQo+ID4gICAuLi4vYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9nY3ljbGUu
anNvbiAgICAgfCAxMTYgKysrDQo+ID4gICAuLi4vYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9n
ZW5lcmFsLmpzb24gICAgfCAgIDggKw0KPiA+ICAgLi4uL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25h
a2EvaHdwZi5qc29uICAgICAgIHwgIDYyICsrDQo+ID4gICAuLi4vYXJjaC9hcm02NC9mdWppdHN1
L21vbmFrYS9sMWRfY2FjaGUuanNvbiAgfCAxMDEgKysrDQo+ID4gICAuLi4vYXJjaC9hcm02NC9m
dWppdHN1L21vbmFrYS9sMWlfY2FjaGUuanNvbiAgfCAgNDcgKw0KPiA+ICAgLi4uL2FyY2gvYXJt
NjQvZnVqaXRzdS9tb25ha2EvbDJfY2FjaGUuanNvbiAgIHwgMTQ2ICsrKw0KPiA+ICAgLi4uL2Fy
Y2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvbDNfY2FjaGUuanNvbiAgIHwgMTg1ICsrKysNCj4gPiAg
IC4uLi9hcmNoL2FybTY0L2Z1aml0c3UvbW9uYWthL2xsX2NhY2hlLmpzb24gICB8ICAgOCArDQo+
ID4gICAuLi4vYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9tZW1vcnkuanNvbiAgICAgfCAgIDgg
Kw0KPiA+ICAgLi4uL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvcGlwZWxpbmUuanNvbiAgIHwg
MjMwICsrKysrDQo+ID4gICAuLi4vYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9yZXRpcmVkLmpz
b24gICAgfCAgMjkgKw0KPiA+ICAgLi4uL2FybTY0L2Z1aml0c3UvbW9uYWthL3NwZWNfb3BlcmF0
aW9uLmpzb24gIHwgMTU4ICsrKysNCj4gPiAgIC4uLi9hcmNoL2FybTY0L2Z1aml0c3UvbW9uYWth
L3N0YWxsLmpzb24gICAgICB8ICA4MyArKw0KPiA+ICAgLi4uL2FyY2gvYXJtNjQvZnVqaXRzdS9t
b25ha2Evc3ZlLmpzb24gICAgICAgIHwgMTQ2ICsrKw0KPiA+ICAgLi4uL2FyY2gvYXJtNjQvZnVq
aXRzdS9tb25ha2EvdGxiLmpzb24gICAgICAgIHwgNDA0ICsrKysrKysrKw0KPiA+ICAgLi4uL2Fy
Y2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvdHJhY2UuanNvbiAgICAgIHwgIDIwICsNCj4gPiAgIHRv
b2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL2FybTY0L21hcGZpbGUuY3N2ICB8ICAgMSArDQo+ID4g
ICAuLi4vcG11LWV2ZW50cy9hcmNoL2FybTY0L3JlY29tbWVuZGVkLmpzb24gICAgfCAgIDYgKw0K
PiA+ICAgMjMgZmlsZXMgY2hhbmdlZCwgMzAwOCBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gvYXJtNjQvZnVqaXRzdS9t
b25ha2EvY3ljbGVfYWNjb3VudGluZy5qc29uDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
dG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvZW5lcmd5Lmpz
b24NCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJj
aC9hcm02NC9mdWppdHN1L21vbmFrYS9leGNlcHRpb24uanNvbg0KPiA+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0DQo+IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL2FybTY0L2Z1aml0c3UvbW9uYWth
L2ZwX29wZXJhdGlvbi5qc29uDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gdG9vbHMvcGVy
Zi9wbXUtZXZlbnRzL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvZ2N5Y2xlLmpzb24NCj4gPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9m
dWppdHN1L21vbmFrYS9nZW5lcmFsLmpzb24NCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiB0
b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9od3BmLmpzb24N
Cj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9h
cm02NC9mdWppdHN1L21vbmFrYS9sMWRfY2FjaGUuanNvbg0KPiA+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0DQo+IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL2FybTY0L2Z1aml0c3UvbW9uYWthL2wx
aV9jYWNoZS5qc29uDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gdG9vbHMvcGVyZi9wbXUt
ZXZlbnRzL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvbDJfY2FjaGUuanNvbg0KPiA+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0DQo+IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL2FybTY0L2Z1aml0
c3UvbW9uYWthL2wzX2NhY2hlLmpzb24NCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiB0b29s
cy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9sbF9jYWNoZS5qc29u
DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gv
YXJtNjQvZnVqaXRzdS9tb25ha2EvbWVtb3J5Lmpzb24NCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9waXBl
bGluZS5qc29uDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gdG9vbHMvcGVyZi9wbXUtZXZl
bnRzL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvcmV0aXJlZC5qc29uDQo+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gvYXJtNjQvZnVqaXRzdS9t
b25ha2Evc3BlY19vcGVyYXRpb24uanNvbg0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IHRv
b2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL2FybTY0L2Z1aml0c3UvbW9uYWthL3N0YWxsLmpzb24N
Cj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9h
cm02NC9mdWppdHN1L21vbmFrYS9zdmUuanNvbg0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+
IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL2FybTY0L2Z1aml0c3UvbW9uYWthL3RsYi5qc29u
DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJj
aC9hcm02NC9mdWppdHN1L21vbmFrYS90cmFjZS5qc29uDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+
ID4gYS90b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9jb21tb24tYW5kLW1pY3JvYXJj
aC5qc29uDQo+ID4gYi90b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9jb21tb24tYW5k
LW1pY3JvYXJjaC5qc29uDQo+ID4gaW5kZXggNDkyMDgzYjk5MjU2Li41MGZjNGIyZGYzNjEgMTAw
NjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gvYXJtNjQvY29tbW9uLWFu
ZC1taWNyb2FyY2guanNvbg0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL2Fy
bTY0L2NvbW1vbi1hbmQtbWljcm9hcmNoLmpzb24NCj4gPiBAQCAtNTMzLDYgKzUzMywxMiBAQA0K
PiA+ICAgICAgICAgICAiRXZlbnROYW1lIjogIlNWRV9JTlNUX1NQRUMiLA0KPiA+ICAgICAgICAg
ICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJTVkUgb3BlcmF0aW9ucyBzcGVjdWxhdGl2ZWx5IGV4ZWN1
dGVkIg0KPiA+ICAgICAgIH0sDQo+ID4gKyAgICB7DQo+ID4gKyAgICAgICAgIlB1YmxpY0Rlc2Ny
aXB0aW9uIjogIlRoaXMgZXZlbnQgY291bnRzIGFyY2hpdGVjdHVyYWxseSBleGVjdXRlZA0KPiBB
ZHZhbmNlZCBTSU1EIGFuZCBTVkUgb3BlcmF0aW9ucy4iLA0KPiA+ICsgICAgICAgICJFdmVudENv
ZGUiOiAiMHg4MDA3IiwNCj4gPiArICAgICAgICAiRXZlbnROYW1lIjogIkFTRV9TVkVfSU5TVF9T
UEVDIiwNCj4gPiArICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJUaGlzIGV2ZW50IGNvdW50
cyBhcmNoaXRlY3R1cmFsbHkgZXhlY3V0ZWQNCj4gQWR2YW5jZWQgU0lNRCBhbmQgU1ZFIG9wZXJh
dGlvbnMuIg0KPiA+ICsgICAgfSwNCj4gDQo+IEhpIFlvc2hpaGlybywNCj4gDQo+IFlvdSBkb24n
dCBuZWVkIHRvIGR1cGxpY2F0ZSB0aGUgZGVzY3JpcHRpb25zIGlmIHRoZXkgYXJlIHRoZSBzYW1l
LiBKdXN0DQo+IEJyaWVmRGVzY3JpcHRpb24gaXMgZW5vdWdoIGFuZCBpdCB3aWxsIHNob3cgZm9y
IGJvdGggbm9ybWFsIGFuZCB2ZXJib3NlIG1vZGUuDQoNCkFsbCBvZiB0aGUgZXZlbnRzIGFkZGVk
IHRoaXMgdGltZSBoYXZlIHRoZSBzYW1lIEJyaWVmRGVzY3JpcHRpb24gYW5kIFB1YmxpY0Rlc2Ny
aXB0aW9uLA0Kc28gd2Ugd2lsbCBkZWxldGUgdGhlIFB1YmxpY0Rlc2NyaXB0aW9uIGZvciBlYWNo
IGV2ZW50Lg0KDQo+IA0KPiBBbHNvIGluIHRoZSBjb21tb24gZmlsZXMsIHdlJ3JlIHVzaW5nIHRo
ZSBkZXNjcmlwdGlvbiBzdHJpbmdzIGZyb20gdGhlIEFybSBBUk0uIEkNCj4gbm90aWNlZCB0aGF0
IHRoZSBvbmVzIGZyb20geW91ciBzcGVjIGFyZSBzbGlnaHRseSBkaWZmZXJlbnQuDQo+IFRoaXMg
aXMgb2sgZm9yIG5vdywgYnV0IGlmIHdlIGFkZCBhbnkgbmV3IEFybSBjb3JlcyB0aGF0IHVzZSB0
aGUgc2FtZSBldmVudHMgdGhpcw0KPiBkZXNjcmlwdGlvbiBtYXkgZ2V0IG92ZXJ3cml0dGVuLiBG
b3IgZXhhbXBsZSBBU0VfU1ZFX0lOU1RfU1BFQyBpbiB0aGUgQXJtDQo+IEFSTSBpcyBjdXJyZW50
bHkgIk9wZXJhdGlvbiBzcGVjdWxhdGl2ZWx5IGV4ZWN1dGVkLCBBZHZhbmNlZCBTSU1EIG9yIFNW
RSIuDQo+IA0KPiBJZiB5b3UgaGF2ZSBhbnkgYWN0dWFsIHJlbGV2YW50IGRldGFpbHMgdGhhdCBh
cmUgZGlmZmVyZW50IGZyb20gdGhlIGNvbW1vbiBzdHJpbmcsDQo+IHlvdSBzaG91bGQgcHV0IHRo
ZW0gaW4gLi4uL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EuIEJ1dCBpZiB5b3UgYXJlIG9rIHdp
dGggdGhlDQo+IHBvdGVudGlhbCBvdmVyd3JpdGUgKHdoaWNoIGxvb2tzIGxpa2UgaXQgc2hvdWxk
IGJlIG9rKSB0aGVuIHlvdSBjYW4gbGVhdmUgdGhlbSBhcw0KPiBpcy4NCg0KSSB0aGluayBpdCdz
IG9rYXkgdG8gb3ZlcndyaXRlIGl0LCBidXQgSSdsbCBjaGVjayB0aGUgc3BlY3MuDQoNCj4gDQo+
IFsuLi5dDQo+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL3Rvb2xzL3BlcmYvcG11LWV2ZW50cy9h
cmNoL2FybTY0L2Z1aml0c3UvbW9uYWthL2dlbmVyYWwuanNvbg0KPiA+IGIvdG9vbHMvcGVyZi9w
bXUtZXZlbnRzL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvZ2VuZXJhbC5qc29uDQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjgwYmYxN2ZiOGY0Yw0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi90b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9h
cm02NC9mdWppdHN1L21vbmFrYS9nZW5lcmFsLmpzb24NCj4gPiBAQCAtMCwwICsxLDggQEANCj4g
PiArWw0KPiA+ICsgICAgew0KPiA+ICsgICAgICAgICJBcmNoU3RkRXZlbnQiOiAiQ1BVX0NZQ0xF
UyINCj4gPiArICAgIH0sDQo+IA0KPiBPdGhlciBjb3JlcyBwdXQgQ1BVX0NZQ0xFUyBpbiBidXMu
anNvbi4gRm9yIHVzZXIgZnJpZW5kbHluZXNzIEkgd291bGQgcHV0IHRoZQ0KPiBjb21tb24gb25l
cyBpbnRvIHRoZSBzYW1lIGV4aXN0aW5nIGdyb3Vwcy4gVGhlIHNhbWUgaXNzdWUgYXBwbGllcyBm
b3Igc29tZQ0KPiBvdGhlciBjb21tb24gZXZlbnRzLg0KPiANCg0KSSB3aWxsIHVwZGF0ZSBhcyBz
dWdnZXN0ZWQuDQoNCj4gDQo+IFRoYW5rcw0KPiBKYW1lcw0KDQpCZXN0IFJlZ2FyZHMsDQpZb3No
aWhpcm8gRnVydWRlcmENCg==
