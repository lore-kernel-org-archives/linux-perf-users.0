Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0E1C6BE;
	Thu, 27 Mar 2025 04:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743049496; cv=fail; b=HYb4ZP9Mk2hy0BQc2f3aIAR57SQ/T5quJHo7Nitl1yDOQpx2/E2mZzW1RtNWSHzhBchdWHIKoRA9dRzAkIHDdDPQ4OLMDWU0DiuBX4z18JouT5RCNPWPLfkK3UL888zTNmzvirDagJA1/DugVZkyTH13rYjXk4MANOVZ8qEX0Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743049496; c=relaxed/simple;
	bh=G9tnyTlJ+/e6s80b1utpjzLrwj93gPZLSvwMcKd7IhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ON6rgjj4VjitExpilcc78F/AhAxOKPtH3khjKT5OMp/wcQ0eKEHArAUjHHprFI3X4ot1rgT86d10U8Em0D97sQJHyS5iqAKt1YW6SuUgLPftbSITCGxHF/i9U0g1/PRoHoEqIA4l/Pufvww2X018TfQb16Etj7g3oAl+lNPb9bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iVgRB4gD; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iVgRB4gD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743049494; x=1774585494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G9tnyTlJ+/e6s80b1utpjzLrwj93gPZLSvwMcKd7IhY=;
  b=iVgRB4gD/fxnR4mYpEtw7qR5ZErJLjATqx+JpznKL29bt6De7l3PPUwq
   vkAxjPm1w3jjW2pXiAJ6lhan+euS1eO/AD8SCFunzEJSW9PssC4VgCJXW
   qm6DW56AtQKB6oBA8CpOBf2Po2c8qthb63wZkE9lpNMp+0lls5vOtVDlu
   /FYBfaVGMztsRW56+i6jiQj8FFAVRAMlXQHYhDPwAffLlJ/Yrf+63O7w0
   hhUdXL1Kpei29st8htx5QPj9GMR/p/ItUUzksrLgl/92bvSfdYAjV893X
   HwVJOjJcUees85PeR34V41Eu1TnnJqwW6GuQk4cVyZW3ohjnsFCKfrHJq
   A==;
X-CSE-ConnectionGUID: pPAOwFfzRnWAwUNK3Q4w0g==
X-CSE-MsgGUID: rgy7NC/OS3eFLv0nFifuIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="150851490"
X-IronPort-AV: E=Sophos;i="6.14,279,1736780400"; 
   d="scan'208";a="150851490"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 13:24:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDTXJ4Jdsz+LpEH2LyktFpE9aP2WD0pgnDnIT2KEuo9pOVs3ndMaDbmgdoJRGsDnqaxzN8hwtlXEMcqegpMcJlwV9IIk7t9BPhEZszro/GQeV16TEPGiEc39tNywfFP2GT4d+1mYNAeJuhUtMPQHCLVxdTEcksv+JGdjveIxntkl0EsYHkadnD5JUeZneyQXZsw3uy6oeOX3ugXS6gDJ3uoQXbMbD+9Ozs76MyGUngvu3Mk4U/WtFwqWIZ8OecKElHqVoU7m+k4gz1qVGeisU2gMTB0wxpSwzpNKFhvjt4dJW46iGUwIw2rNN5uHW4ra9Dsy1yj9uwJbjIs2UIr2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9tnyTlJ+/e6s80b1utpjzLrwj93gPZLSvwMcKd7IhY=;
 b=FQjCHHI/QiFcbwHvuSvnqerI6lUbr14gUaQtF35ffK/W4Y3/DqRn/gMXl9RjyL0KAI8JQ3LIdbuKbUs6IrAKUPQXulmPTY2BC67ogsp2CwCrg/k7wUg/Rohp1ILvS0T6Hapx9+hMSRCXMEwCuEX/FZkadHtjAploPJugn/+GLMRetPGy/eo4697QhYLA39u0c0shKXTUOoA+wdMoPU9vQ3o2Tb1O8RbALaolJkEiY28fK5krT3sAm2hZ6XTWPJTYXOOyssXD5aG1xAo4BiHrm35PnioHF9bMA8kEdYXr77TTcPuKKkK/wAGm5rq81Oe3XLZv5+5R+oXfWPIJsV4tUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB6717.jpnprd01.prod.outlook.com (2603:1096:400:9e::11)
 by OS9PR01MB12183.jpnprd01.prod.outlook.com (2603:1096:604:2e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.27; Thu, 27 Mar
 2025 04:24:39 +0000
Received: from TYCPR01MB6717.jpnprd01.prod.outlook.com
 ([fe80::182c:bcc4:3f87:81c7]) by TYCPR01MB6717.jpnprd01.prod.outlook.com
 ([fe80::182c:bcc4:3f87:81c7%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 04:24:39 +0000
From: "Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>
To: 'James Clark' <james.clark@linaro.org>
CC: 'John Garry' <john.g.garry@oracle.com>, 'Will Deacon' <will@kernel.org>,
	'Mike Leach' <mike.leach@linaro.org>, 'Leo Yan' <leo.yan@linux.dev>, 'Peter
 Zijlstra' <peterz@infradead.org>, 'Ingo Molnar' <mingo@redhat.com>, 'Arnaldo
 Carvalho de Melo' <acme@kernel.org>, 'Namhyung Kim' <namhyung@kernel.org>,
	'Mark Rutland' <mark.rutland@arm.com>, 'Alexander Shishkin'
	<alexander.shishkin@linux.intel.com>, 'Jiri Olsa' <jolsa@kernel.org>, 'Ian
 Rogers' <irogers@google.com>, 'Adrian Hunter' <adrian.hunter@intel.com>,
	"'Liang, Kan'" <kan.liang@linux.intel.com>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'linux-perf-users@vger.kernel.org'"
	<linux-perf-users@vger.kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "Akio Kakuno (Fujitsu)"
	<fj3333bs@fujitsu.com>, "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
Subject: RE: [PATCH] Remove some PMU events for FUJITSU-MONAKA
Thread-Topic: [PATCH] Remove some PMU events for FUJITSU-MONAKA
Thread-Index:
 AQHbiNpQ8JjCRF9TOkCjxP8mdt+sprNa+hOAgAGBj7CAB6SosIAAMnoAgAK3+KCAH4AOkA==
Date: Thu, 27 Mar 2025 04:24:38 +0000
Message-ID:
 <TYCPR01MB67171E88957D7FE100E6383BC1A12@TYCPR01MB6717.jpnprd01.prod.outlook.com>
References: <20250227054045.1340090-1-fj5100bi@fujitsu.com>
 <96b323eb-15b2-4b60-8522-83bf2f57694b@linaro.org>
 <OSZPR01MB6908AA7CEB24ED38F9289D6DD4CC2@OSZPR01MB6908.jpnprd01.prod.outlook.com>
 <OS3PR01MB6903726FDA70250F72A73410D4CB2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
 <36123515-a268-40cb-b010-2600c2f5c1c6@linaro.org>
 <OS3PR01MB690377379ED81FDF8D60142DD4D52@OS3PR01MB6903.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OS3PR01MB690377379ED81FDF8D60142DD4D52@OS3PR01MB6903.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ODA5YmMwYTgtNzMzMC00NGM2LWE1OTQtNjZiNmYxNGI2?=
 =?utf-8?B?NzdlO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAzLTA3VDAzOjEwOjA3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB6717:EE_|OS9PR01MB12183:EE_
x-ms-office365-filtering-correlation-id: b25b4dba-225a-425b-2064-08dd6ce74996
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHl4dW80MWErQnJaR1U5RWdueTlJZ0U1RTVjNW1uRXkwWjZHckhzMFU5WVRU?=
 =?utf-8?B?TXRJTWdRem9WODlhamNmRmhPeHdOQUtjdkNnb3pjSGQ4azdGT3F4NG51OGVj?=
 =?utf-8?B?RjlqUUErZWRiU2liTXhKeURKdnVYWjM3NEtnZUtJVjRYdFZoQkVzZE52QWJk?=
 =?utf-8?B?bVA1RDdpcVRQWmQ3OUxySlpRZlBNTkJnYktiS0d6MnpOV3JDc0VzblNYOW50?=
 =?utf-8?B?TGhsM3VLOEt5NXpnU3lqNVQvc2tXSFZhYjV5ZnBIQzBKakV5TXB3a0ZnSnZo?=
 =?utf-8?B?aElvZmQ5UVkwYU1WRU9idXNYODhBdmcvTUt6eTVuRXFJcURtWTkvRHZWSmgx?=
 =?utf-8?B?M05udExpK0V1R2NHemllUGRrekxsRWpVcWZWUkhISG1XZW54Nzd5M3pkY2NI?=
 =?utf-8?B?VEVENk5sWVI2eE5jakRNVmcrN0Rnckp2T1drNjc0ekpBL3RmdFUrMC9LZXZs?=
 =?utf-8?B?N3U4VjBabmxueTJydWo5RnNrRWZmd3Y4R1VzS3oyZks5alZxT28wZCtZc0lr?=
 =?utf-8?B?eDF5Y0EwQmkzSE9BYm1KdStnM1dkeEh0NmduRy9PeHJBQTNjbHJ2anNJR3A4?=
 =?utf-8?B?b2NML0xSbUpVWlp3SlNHeUxXdU1KZ2pkblFZaFJLYUhFOVJPZVlVT3ZsYUdp?=
 =?utf-8?B?UldjTDQ5QURaaklHRFZZa1lVdW1mVm04dmJYd3Y0NExJSFliaHR4a1VSTEZC?=
 =?utf-8?B?SnphNVpQTTdsSnV0TWVITUptbU5tVTRaRFFrRjdUTDBRakdsNjNPU1F6MUli?=
 =?utf-8?B?WnJ6Z0Q0cmxnKzlManFNWGdNb2YzVENMRHZTRmdZR1VNS25hV0V0ZGVnNTJx?=
 =?utf-8?B?NUExQ0NLRmF6WUVqSEFUZ2FZSjlhQjM1cWZnSnk3ZTN2Tk9CNzJDSVlrcUV0?=
 =?utf-8?B?Z043bmZkZlA4V2wrcG5NOERzTmgzL1FyUGc1Nnk1UlYxMEFVUk9GcGRoUGQy?=
 =?utf-8?B?REdSTUJoalRpRlRBTDRJaFAwUUx0VFJwWENWWnFMMGpFRjZva0RNa2VXQTBj?=
 =?utf-8?B?eUUyeXZKbWwyejBBdFVkZzVUQlVBdVppT29IeUJwY1hqUGtVZ0ZsS05LVndN?=
 =?utf-8?B?RHFRMC9DNHg2UkhwOVIweEh1N2JwWWRTVUI0UGYzK3dHUHdtV0tVbG90RS9i?=
 =?utf-8?B?dU9aOGFCWVM5Y0N1N0RwV21VUTBCdVVISWd5cFNReks3K20zUlBGb25JWVlT?=
 =?utf-8?B?eURpU0o2dWFpOXp3L1RlTm16NmRkZXZjamJLR2o0UXc0eFBWcXMzUmJVcTZN?=
 =?utf-8?B?RCtoajIzaGRWZFR0bGZsZ29HUGdXWWk1Q3F0SktWSWkvSXVGNnIwQTdCSGpL?=
 =?utf-8?B?M21xU0ZWRzJ3YlhkTTdRSFE5bDRCZVVnWGNjY1JUSmpMa2RqL0xWaDZQRzdy?=
 =?utf-8?B?OTMvNldoU2NUdlNleWJTOVIycjRZdG5yNnJIUjB4UlBCL1MzSWNETDJROGpa?=
 =?utf-8?B?dGJ5MllYK0VWNU04VCswTTJQbkxBaG5tZ3AvSjJtNERYc2h1cDFwamxCL2Fs?=
 =?utf-8?B?amg5QXdVUE1aTzUzMHc3WXlMSWV1ZWx5VnQ0Q0pwZFF5YStPeUF1RVpPZFB2?=
 =?utf-8?B?QmY4L3JOR0NMQ0dRdXc0YW8yNmpvanF6ZWd1S3RkNmN6S3k4UjBsWmpkeXYw?=
 =?utf-8?B?TXlCTmhQYlNvQ2dvNjdhTFJCeVhVRnFQZ2NGZFpUM05TVDFvSW1EME9kUkxY?=
 =?utf-8?B?aFJHOFVKQTg3K3JKMHpBbVg3cW9CM2U5NXJ4Qy9VeTN4NEMwTmd0VlQ0ZXJs?=
 =?utf-8?B?d0lIQVZQWVhCSnVubmc3cStRdEoxQUtiUFZTQkJCU1JlSUtNWmovY3RqQ1cv?=
 =?utf-8?B?Nk04Ukk2QnVxTHpha0ROKzNqZjAxOVBReEJscDVoQ2x1di85UExnOWNUMk5J?=
 =?utf-8?B?amNTVnZRQ0tvNjhxRkZnNTV5dWVUYXVvSUdBNVRrMmdNZVhQRG1SNEZPZmZH?=
 =?utf-8?B?c3RlSFU1a215aXZsdkRVSVY4Skd6VTRwcno2TXFpblovNzc3NE1xSnRsVTEv?=
 =?utf-8?B?dGw1cHU5VnRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6717.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXNRRjNWcU9RcHZYTFVvUGZpZ0cydDdDVE9SbEd0MWRXTmY2aG1meVhiR2NB?=
 =?utf-8?B?SE5JRysvWlk4M3lLQmFtT0pweE9UM2pJT3F2aDVaTUx0QWFZSGt6alRubGFF?=
 =?utf-8?B?RFM3cVB5empYWGpJbXpWWnRBdTI3ZDQwb1pLNXdzb1BjTWRuUURnczNYVW0z?=
 =?utf-8?B?Tk4xVlJZcHM2NWZkbUlHNFBUMVp3QnNTSG0ydzRaN3lJY1NVdWxCN0ZXZ2Ft?=
 =?utf-8?B?OW1BTi9rM2d1Zmp1ZzU5RSs1WEFiUGQ4T21Udi93RWw5RnUxZjlMdXNOYkhT?=
 =?utf-8?B?VXQrZzJIUnRtVWc2ZW02NldlT3ZGdnBJaEhScjBQMmZvdFhobG5LY0R5bVZO?=
 =?utf-8?B?UlVpTldNVzJVMk9kNGZBUlpzTEZMd3VQcTExRXFySHVaM2F5QlllYTdMNFdU?=
 =?utf-8?B?Rm1LSlIrSWFKbTM1eERyRmdrSXhCTWZobWhCRDhTa2Z5cEt6YjArL2xBenpW?=
 =?utf-8?B?bWt5RWZCU2tnblhLVmpEVTJoOWlQQ09GMTRQSXhGKzQ1ZkJCd1ZSWStRTVNv?=
 =?utf-8?B?Vm9IRTY0eVNFeWxhYk03OGNZNU1QOHpMZHI3MUJWNHgzdElXbUZHMDJpdWJC?=
 =?utf-8?B?bEs1NHpLM09sdkNiT2hMYXZXdkRuSytncEM2RXBjeXNtcmFSelUrYVpwY3Rw?=
 =?utf-8?B?MXE1aXJJdStqb1pYTVA1YWxuTnkzeWZTSjE0YUprTnlvM3NieDdVMmdPQ1NO?=
 =?utf-8?B?TmcveVNhdmRacmlqZTNTcnA4VENzNnhBL1p6M0ZraWZvUVYvbWJhc0JlQlQ0?=
 =?utf-8?B?c3lVbHVhdjRHZlFrL1lIeVdXZFJtSnNiTGNuVXQzSjkvWHZXL1RQYzNyT3JU?=
 =?utf-8?B?ZTd2NUsxUFF5c2s2WGtkcEM2MFZKM3hlY1NQVkhQVnFFQ0U5aG5NYkhHS1l0?=
 =?utf-8?B?WjZXU0JOdHZmTTdOMGlJcFpDUFpNSkVVN3p3ZWF3RFVlc0VrNWtkam5reDNi?=
 =?utf-8?B?VHh0djN0ank2eGxPaXNyRVNkU2pxb3d2YVMzRXpXZ2ZuaTJsTHlPRU5FNTZL?=
 =?utf-8?B?VjU2SGQ4TURxbzZDQVFNeVgvQ1B5Q0dKd3g2eXN0b0VWcFdXZXFWSkZkc3pH?=
 =?utf-8?B?Z2srK3VSbVExYytjd241cGpnelpZTVdxTC9NMUZwQm9LM1VKdGJ6d1FhTzFu?=
 =?utf-8?B?RHZpUVB3UTFURzlDaGVaNkd1QmgzWE4vcURoV2lqa3ZWSERERXlXSGNTWVNP?=
 =?utf-8?B?Tm5JYXlZZnVrUU5iUnJMVzV6NE5LSTNtdU1pSERrb1JYM2FtWDR1VHRYZm5R?=
 =?utf-8?B?SmJVQ3BBblI3K0dDeXJwU29pa0dKeVdZQnR2QkxpUGliM3lBTUxUQTZGKysw?=
 =?utf-8?B?bVNFak9QQ2NNbTNDT3hiMWdoTFB3d3B6aXVCSUdEQVZLVnhvV3RqakwvbzZt?=
 =?utf-8?B?VnBxOEcyWStaZ2NtNXhrZ0VTN25BWm1zaWFCbGZvWEl6Q2lKb2F2QnZvS3BS?=
 =?utf-8?B?anY2a1pKMzViTEExZ2JYSGJNVkhOV2pMdEFuVWV2OWthWkR3TkdnNkxNbzRx?=
 =?utf-8?B?QXFuRGJNS2ZhajN2S1JEb3o5Z2krSk1JVG4yMU5VQkdQQkt0NEprR3g1N0lP?=
 =?utf-8?B?ME5oUklPVXZZRUx6R2s1WkF2SldnQXArdDg1UWxGa05LSXg4OVhXSDB5QVVu?=
 =?utf-8?B?SHJ5VlFaU2N0QU9uODEvUGkybUMyMFRtN1IxZ09lVHZKSWcxWkhJMVNnaUs5?=
 =?utf-8?B?TzlLU3A4MlVrd3VSS0t2dDNJa1ZrSGJWOVVxekZGd0RJMlZFZTgyMVpuREY3?=
 =?utf-8?B?bEh6T3AwaGZEUDF3UXRZWkpZUHluMHY0MXE5dTRldnQ0Q2xJbHAwb3dVWnVh?=
 =?utf-8?B?YnI1SkRucndzWDE2TFI1SUF6a2l1OE9SQW0vU3VCcUtBWnFCcmVBN2o5eWgr?=
 =?utf-8?B?YVJaaHVnR2tKdlpMVmorWE1YelV4Umx0TTF4UGxCZmtyVGpySXh5TElmU3ln?=
 =?utf-8?B?MU5PbXFiUitHOTZzT1hvd1k1d1VkU3FZeHJBY09tdVZsclFTaXpLL01qU1o1?=
 =?utf-8?B?dmJYUFlrNTNNZnJzVC9Fb1VxaytFMnl0M3oranRjTjFoNnBRRm5ZM2Z6aTVQ?=
 =?utf-8?B?Mm1hK2MxUHFjWGFMSXJrdHF5ZGlSQmFCUmQ0cXMyRjJ5NjA5c1NJV05DcHpw?=
 =?utf-8?B?NXl5cEFVT2hZRUQyb1pZRklhbEc2eW1sc0J2cVY4RTFBRnFRYjl5ekJrbm1W?=
 =?utf-8?B?d3c9PQ==?=
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
	GFSdell/JlmH9FZ/SDQtMvnUpqY60y3b67lZf1kUmN8D/ttCuSXxoxcz/uk5vwUwJhHMz1jVRgdc8l0Gd/Y3OiLd7TRT/04wInqS9y21D6JiSY8WbyLyKEa+P86qOdqHjO+fVg3e1yykBK9pYNjGPRv18tROsRYroxSqlDhG2df5Amg9R6f/G7XHSBZQI92DOENIPYgI4QGUX8mtVwBseLyyBtnd6Pc0Tu7cBs9MJDXgysiJLaNzQHtlIBQJe/XHz33EOnu2icB4Y3fAxKOBWocho/N7Ucx3eVoYa1LE+It3pavYk7xwNCDteoUJI317j2ifvLoOZa+nYpZk0xAVlIreWSeUv4L9uBenUDk5NsWyxmdyzW/XcwkN/p/SG+HUOETXVhxC99a+sWIX/hNsyUq25M289GcwXXF7T1tgvZ/l0x9XZBS4kYaZD6iufZh/xlrSEP8aZnKZ5y2vomuG9ppmWv/MQBJJ1gVJnbzHhyDsWL6PEKN6prdGkS4mqyt0qecHoFg5dIaNtoFQ5wYau8U+3Yq4z+N/f6MPmNXmMR3HVIRUWSX2ToGTZBkUfSnguBbZmzkFtC48Izy7/qx+DWDB/JvxrOn2H/ve6l7pBagUjiw9FxD3YsqcuayMbYuV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6717.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25b4dba-225a-425b-2064-08dd6ce74996
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 04:24:38.4065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ld7l/k0akPACbw+7PI2XyyM3onQN3dxg4wN7yHCLIOLYu89ekLg7EWUwK/NJNbZahoanIDry0Hbt4ajJnzmK5z35hpu3cmLOEshYjus9BQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12183

SGksIEphbWVzDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4NCkFsc28sIHRoZSBwZXJzb24g
aW4gY2hhcmdlIGhlcmUgaGFzIGNoYW5nZWQgZnJvbSBGdXJ1ZGVyYSB0byBPa3Vuby4NCg0KPiBI
aSwgSmFtZXMNCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuDQo+IA0KPiA+IE9uIDA1LzAz
LzIwMjUgNjo0MCBhbSwgWW9zaGloaXJvIEZ1cnVkZXJhIChGdWppdHN1KSB3cm90ZToNCj4gPiA+
IEhpLCBKYW1lcw0KPiA+ID4NCj4gPiA+Pg0KPiA+ID4+IEhpLCBKYW1lcw0KPiA+ID4+IFRoYW5r
IHlvdSBmb3IgeW91ciBjb21tZW50Lg0KPiA+ID4+DQo+ID4gPj4+IE9uIDI3LzAyLzIwMjUgNTo0
MCBhbSwgWW9zaGloaXJvIEZ1cnVkZXJhIHdyb3RlOg0KPiA+ID4+Pj4gVGhlIGZvbGxvd2luZyBl
dmVudHMgYXJlIG5vdCBjb3VudGVkIHByb3Blcmx5Og0KPiA+ID4+Pj4NCj4gPiA+Pj4+IDB4MDAz
NyBMTF9DQUNIRV9NSVNTX1JEDQo+ID4gPj4+PiAweDQwMEIgTDNEX0NBQ0hFX0xNSVNTX1JEDQo+
ID4gPj4+DQo+ID4gPj4+IFRoZXNlIHR3byBhcmUgZGlzY292ZXJhYmxlIHNvIHdpbGwgc3RpbGwg
YXBwZWFyIGluDQo+ID4gPj4+IC9zeXMvYnVzL2V2ZW50X3NvdXJjZS9kZXZpY2VzL2FybXY4X3Bt
dXYzXzAvZXZlbnRzLyBpZiB0aGUNCj4gPiA+Pj4gaGFyZHdhcmUgc2F5cyB0aGV5IGV4aXN0LiBJ
dCBtaWdodCBiZSBiZXR0ZXIgdG8gY2hhbmdlIHRoZSBqc29uDQo+ID4gPj4+IHN0cmluZ3Mgb2Yg
dGhlc2UgdHdvIHRvIHdhcm4gdGhhdCB0aGV5IGRvbid0IHdvcmsgaWYgdGhhdCdzIHRoZQ0KPiA+
ID4+PiBjYXNlLCBvdGhlcndpc2UgUGVyZiB3aWxsIHN0aWxsIGxpc3QgdGhlbSBhbmQgeW91J2xs
IGJlIHdvcnNlIG9mZi4NCj4gPiA+Pg0KPiA+ID4+IEkgd2lsbCBsZWF2ZSB0aGVzZSAyIGV2ZW50
cyBhbmQNCj4gPiA+PiBhZGQgYSB3YXJuaW5nIG1lc3NhZ2UgdG8gdGhlIGRlc2NyaXB0aW9uIGlu
IHRoZSBKU09OIGZpbGUuDQo+ID4gPj4gSSB3aWxsIGhhbmRsZSBvdGhlciBldmVudHMgaW4gdGhl
IHNhbWUgd2F5IGFzIHRoZXNlIDIgZXZlbnRzLg0KPiA+ID4NCj4gPiA+IEknbSB0aGlua2luZyBv
ZiBhZGRpbmcgb25lIG9mIHRoZSBmb2xsb3dpbmcgd2FybmluZ3MgdG8gdGhlDQo+ID4gPiBkZXNj
cmlwdGlvbiBvZiBldmVudHMgd2hlcmUgaW5hY2N1cmF0ZSBjb3VudHMgb2NjdXIgb24NCj4gRlVK
SVRTVS1NT05BS0EuDQo+ID4gPiBJcyB0aGlzIG9rYXk/DQo+ID4gPg0KPiA+ID4gMS5TaW1wbGUg
dmVyc2lvbg0KPiA+ID4gIk5vdGU6IFRoaXMgZXZlbnQgZG9lcyBub3QgY291bnQgYWNjdXJhdGVs
eS4iDQo+ID4gPg0KPiA+ID4gMi5EZXRhaWxlZCB2ZXJzaW9uDQo+ID4gPiAiTm90ZTogVGhpcyBl
dmVudCBkb2VzIG5vdCBjb3VudCBhY2N1cmF0ZWx5IGJlY2F1c2UgaXQgY291bnRzIGFzIGENCj4g
PiA+IG1pc3MNCj4gPiByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIEwzIHByZWZldGNoIGlzIGEg
aGl0IG9yIG1pc3MuIg0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgIjIuRGV0YWlsZWQgdmVyc2lvbiIg
aXMgYmV0dGVyLg0KPiA+ID4NCj4gPiA+IGV4YW1wbGU6DQo+ID4gPiB7DQo+ID4gPiAgICAgICJF
dmVudENvZGUiOiAiMHgwMzk2IiwNCj4gPiA+ICAgICAgIkV2ZW50TmFtZSI6ICJMMkRfQ0FDSEVf
UkVGSUxMX0wzRF9NSVNTIiwNCj4gPiA+ICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiVGhpcyBl
dmVudCBjb3VudHMgb3BlcmF0aW9ucyB0aGF0IGNhdXNlIGENCj4gPiA+IG1pc3Mgb2YgdGhlDQo+
ID4gTDMgY2FjaGUuIE5vdGU6IFRoaXMgZXZlbnQgZG9lcyBub3QgY291bnQgYWNjdXJhdGVseSBi
ZWNhdXNlIGl0IGNvdW50cw0KPiA+IGFzIGEgbWlzcyByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhl
IEwzIHByZWZldGNoIGlzIGEgaGl0IG9yIG1pc3MuIg0KPiA+ID4gfQ0KPiA+ID4NCj4gPiA+IEJl
c3QgUmVnYXJkcywNCj4gPiA+IFlvc2hpaGlybyBGdXJ1ZGVyYQ0KPiA+DQo+ID4gWW91IGNvdWxk
IGhhdmUgYm90aCBieSB1c2luZyBCcmllZkRlc2NyaXB0aW9uIGFuZCBQdWJsaWNEZXNjcmlwdGlv
bi4NCj4gPiBUaGUgbG9uZ2VyIG9uZSBiZWluZyBhdmFpbGFibGUgd2l0aCAncGVyZiBsaXN0IC12
Jy4gSSB0aGluayB0aGF0J3Mgd2hhdCB0aGF0DQo+IGZlYXR1cmUgaXMgZm9yLg0KPiANCj4gVGhh
bmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb24uDQo+IEFmdGVyIGRpc2N1c3NpbmcgdGhpcyB3aXRo
IHRoZSBPUyB0ZWFtLA0KPiB3ZSB3b3VsZCBsaWtlIHRvIG1vdmUgZm9yd2FyZCB3aXRoIHRoZSBw
b2xpY3kgb2YgZGVmaW5pbmcgIjIuRGV0YWlsZWQgdmVyc2lvbiIgaW4NCj4gdGhlIEJyaWVmIERl
c2NyaXB0aW9uLg0KPiBQbGVhc2UgbGV0IG1lIG1ha2UgYSBmaW5hbCBkZWNpc2lvbiBhZnRlciBk
aXNjdXNzaW5nIGl0IHdpdGggdGhlIGhhcmR3YXJlIHRlYW0uDQo+IA0KPiA+DQo+ID4gRWl0aGVy
IHdheSB5b3Ugc2hvdWxkIHByb2JhYmx5IGFsc28gdXBkYXRlIHRoZSBkZXNjcmlwdGlvbiBiZWZv
cmUgdGhlDQo+ID4gbm90ZSwgc28gYWRkICdoaXQgb3IgbWlzcycgdG8gdGhlIGZpcnN0IHNlbnRl
bmNlOg0KPiA+DQo+ID4gIkV2ZW50Q29kZSI6ICIweDAzOTYiLA0KPiA+ICJFdmVudE5hbWUiOiAi
TDJEX0NBQ0hFX1JFRklMTF9MM0RfTUlTUyIsDQo+ID4gIkJyaWVmRGVzY3JpcHRpb24iOiAiVGhp
cyBldmVudCBjb3VudHMgb3BlcmF0aW9ucyB0aGF0IGNhdXNlIGEgaGl0IG9yDQo+ID4gbWlzcyBv
ZiB0aGUgTDMgY2FjaGUuIE5vdGUgdGhhdCB0aGlzIGluY29ycmVjdGx5IGNvdW50cyBib3RoIGhp
dHMgX2FuZF8NCj4gbWlzc2VzLiINCj4gDQo+IFdlIHdpbGwgYWxzbyBkaXNjdXNzIHdpdGggdGhl
IGhhcmR3YXJlIHRlYW0gb24gdGhpcyBtYXR0ZXIuDQoNCkFmdGVyIGRpc2N1c3Npbmcgd2l0aCB0
aGUgaGFyZHdhcmUgdGVhbSwgDQpmb3IgYWxsIGV2ZW50cyB3aGVyZSB0aGUgY291bnQgaXMgaW5j
b3JyZWN0LCANCndlIGhhdmUgZGVjaWRlZCB0byBhZGQgdGhlIGZvbGxvd2luZyB0ZXh0IHRvDQp0
aGUgZW5kIG9mIHRoZSAiQnJpZWZEZXNjcmlwdGlvbiI6DQoNCiJOb3RlOiBUaGlzIGV2ZW50IGRv
ZXMgbm90IGNvdW50IGFjY3VyYXRlbHkuIg0KDQpJIHdpbGwgcmVwb3N0IHRoZSBwYXRjaCBsYXRl
ci4NCg0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBZb3NoaWhpcm8gRnVydWRlcmENCg0KQmVzdCBS
ZWdhcmRzLA0KS29pY2hpIE9rdW5vDQo=
