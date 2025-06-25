Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F45223;
	Wed, 25 Jun 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865289; cv=fail; b=C0uBOZA0TsLFH9S+eD+jqJnDrH1AwhsritvzaV4Ou6h70y9BTHywY1L8HBF8nFeh6iyUdFWyqMpzW4LszHwvEiLj1HUQwY2AyIZ1dzDnBdQ5EjBoT3UKpbhMuhK9z4cbEZ6710cqWs8CEAvK8NFuOpBBH8b83+xOtq3lqvq+xbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865289; c=relaxed/simple;
	bh=NKzzWjECHfhikVJzfUYjGRyIpMamKs9CdmHKgyMAr1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HZLcwsbKOmM0CN/mB+oDWUmEQNU4Rx8J+yalXM57feA8dDBM7fn5QFC0MUOxiAAQ7gsvM6+Q+jbzsMbHvuqPpM/TZfMIypLpkilGrHO7Sivn29wiHY+gUQpvu2vy8GgTLvTic2umw97SB7HLQx8JHLqID3Aiegrsz/LFAnDHfWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Anr2vA+f; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Anr2vA+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750865287; x=1782401287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NKzzWjECHfhikVJzfUYjGRyIpMamKs9CdmHKgyMAr1E=;
  b=Anr2vA+fMWxHtuvX3b3Yq6jq++1HXdWhDV9+h4xvlFnWYx0TwAGhORJt
   fnsnAsDf0fHT7/KYRIXfiMVwMAhTurPDMvjLV4y0KVFcnXCKgNpf5/yJn
   XBIV6ipxh+USXHHgw1avBA+TvvR7e0JvgAslG2hqVPE1Yvr2Ba5IRmZUo
   y5BCe6LuND60xrsDyhqRJBpr2vlEWDLcdWxtH9468KT/Cv5syYMCGN7nS
   rKuzENFCkYSwdJH2AparW9hbd1VG1dH+fYKCPLupRU/YOkax962R5dntL
   AUHcy2o0O008viJ9UIllmoeogKDy48IV9xg5czvdRK84fY895U2aY8zj1
   g==;
X-CSE-ConnectionGUID: DoB6Y5LvS7iFsYY2+LvmRg==
X-CSE-MsgGUID: VM69PQUsR7igQr/Xir4HFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53076231"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53076231"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:28:07 -0700
X-CSE-ConnectionGUID: NJFeqq+rQdOgohxELJb4MA==
X-CSE-MsgGUID: hYpKy95kSp2Kg8n2yvjMFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152376901"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:28:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 08:28:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 08:28:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 08:28:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GegbxNZz6vf42Brlwhnk7lCXZeZ5oNwi4LeKr4B4d20T2Y74apxu+CNXGG3Gj8l1uHgHyHtUTFEbWcgMX72clScAHl9m1OUBU7vZcsZH1j672niFi35Z7hm3cXq7rXGewLHtWCTLVI6+DYFg3axbf6RjLeTlF0LI9qMKeXGl53F2QQMolWLfUxGRalXoapny9Cq9NG0Jq/yWJzjNWVpnhf7VkTtHWDRNMPFWf1VHv/TGmUfTCQyp+94r8r0/98qh1N6BzjFS4OLstw8p7SIk10caRfMsShpGuIPofyyWp3AY9CkNDW0anluy/65akLJz1r7ROl7w1pETdcgvCKpi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKzzWjECHfhikVJzfUYjGRyIpMamKs9CdmHKgyMAr1E=;
 b=lPdIcXelv27yW3eN7R8GZw0XaTIACpB+bDGmrS4INZGkqQlmLiNFN++C7xSsQ9WqlMu3cDFOtRCMfSi1ySvJMko+gkieg+UrwCVsxUCykbCm+AUbnnPIOlt29i4zJh9kbohEUf8rbaYUUgo0AzP1rhT/zAWNMzuYth5b1H+iaUZWDiGQqRS+nrZakg/aYGlaUSViuVGd0eoJ0OuilJYFtTZjkHHRQUxbg6Hbx9rudNxdBBpYe/Yj47fTCMmvXLqOtHmdUBLZMRuiqVsucn5fh0Rh4U9xaZe2CYz37cn0sFmhwN4nbk2QwpaHOVC/jzmsV3SZ8bWWODu7Pd+0XpYSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 15:28:02 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%7]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 15:28:02 +0000
From: "Li, Tianyou" <tianyou.li@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "Guo, Wangyang" <wangyang.guo@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Add --buildids-blacklist option to perf archive command
Thread-Topic: [PATCH] Add --buildids-blacklist option to perf archive command
Thread-Index: AQHb2Or9KXdwjseE1EOTt25Q2grrVbQSv6wAgAFZC8A=
Date: Wed, 25 Jun 2025 15:28:02 +0000
Message-ID: <MW4PR11MB82899DCA76DC72B7BE36FFA4957BA@MW4PR11MB8289.namprd11.prod.outlook.com>
References: <20250609035542.2364525-1-tianyou.li@intel.com>
 <aFrzSpvzzWeHdyJ5@google.com>
In-Reply-To: <aFrzSpvzzWeHdyJ5@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB8289:EE_|SA1PR11MB8253:EE_
x-ms-office365-filtering-correlation-id: f61e6e27-4bcb-4f0b-d2ed-08ddb3fcdfc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ry9QajhkZXNCRmhBVWZkK1JHeTVvM2d3b1NhQTkzYkxJL2pHYndXZjRjZGhL?=
 =?utf-8?B?b0E0MGxBanJhT1VCZTZGT09Dc2Rkdld6R21QeDc3c0VOTWcveWg1OHJuYTlL?=
 =?utf-8?B?NjlBS2Fnb1EzeklxNXpZNm1ic25wdDZXM1I5NE1qNkhEUUIzZXYzTkQ0dElk?=
 =?utf-8?B?eGVDSzhvZFVuT29rUFV3RHBvaXMrMzRQemJpM0xjdGttc3pWZWxYclhrdi9r?=
 =?utf-8?B?SUgvajFyNTBoak1HNGFlL2ozSWFWRmt1OGdGeEY0eW9sTWs5WU4zSEZWWUFW?=
 =?utf-8?B?ZkswWWlHUDEwclNEZXdYak8rSHVRb2VSblVUaU1qMDBBeE1uQVpHbmNQaHlO?=
 =?utf-8?B?MFNrc1JtQTN6T3oxaUFraWYvTjhNK3NkWFAzQmRLZWZNaksvTXU0QWZnZzR6?=
 =?utf-8?B?L01DUHRyTnlVSmlEeDU5Mmlka0V4c3hORWRxam9Dd0U4NE9LNHMxV3JSZVY1?=
 =?utf-8?B?cko1QklOTlF2aW5JWnlxUURVTUE5N0dFWFFwMDgrSEQ5emcwRmNaQ2FCNnZQ?=
 =?utf-8?B?NVJjZk05c2RVQWhtOGZ0MytlNDIvK0tyR0VGMGpUNjlxTEtybzc1WEU5bTli?=
 =?utf-8?B?ZWhQYnphTXJtcDZVSUcyVndnTzlzUDV6OFFzcTRBb1dBVHh4V3dzRkYxd0dT?=
 =?utf-8?B?ZkVQZU54Rk9tQXJWS2FpQjZMNnIxdmsyYThrVGFPcVRrckNndmdDcmRYaHV4?=
 =?utf-8?B?MjVzYjlhUTFOY0o4d2FjRXQwVEtVaEhHc3dOOXRkZW5ZRndodFBpaE1hdjZH?=
 =?utf-8?B?ZDR6ZFdPdk5UL3NaTVRURk8wTC9LOStHUjl6YU9sZCtUaFZXaWJRTEw4Q2xp?=
 =?utf-8?B?QVRPRis3YWVMd0RkZUpRTXB4ZGE1RGhtaDlabE53YTJGeWczNXl6Smk1TWsr?=
 =?utf-8?B?cmtPWHp5Q0xXbnhFblliRGo4WktvU3Axa2dOdzh5KzNoS0ZYQTdiS3ErVG9T?=
 =?utf-8?B?OE4xUUlRQkEwNmM0d0orNzJCM3FrMTM3UElzN3h1U0dTNG9Bd2x2NWR0TWZx?=
 =?utf-8?B?Z1QvMkwwUVpHQ2Z4NjNpa09wQ0hHNHRlbkk0WXlycXNpL2IvSCtVVklrZ1Vz?=
 =?utf-8?B?eklBZkRlU3c1eklUV2dsYlZOU3NCZmE2T2dxci9nWndnTnZDaE95TUc4Yi9z?=
 =?utf-8?B?VnJaMUZlVHQ2SEpocGFTY1l5TzJHS2pyVXFDMjhJdzdpMkxlbXZySENtMitQ?=
 =?utf-8?B?WFhPakM2V3pRdGx6bW13WlQ2dGJIbkwvcExIT0xJY2IzOVNxM21QcGx3QXp2?=
 =?utf-8?B?TFBDNk5Xemgvb3k3NGgxajNJbGhvZjVYWGhuYUxVVDd1VFFQamlKNnFNbzM2?=
 =?utf-8?B?em9rZkxPSHdUSzB4QSs0V3ZtNUk0TGxlbzhzODF2NHFwR1djK2xONHVkN0hW?=
 =?utf-8?B?eTlFa2pYdVlTWUhCSnl1OENUZVBud2FlSFpqc3VKOHFhbVlpa0tXSkpoVElu?=
 =?utf-8?B?VGllMk1vd094VUVPSWhpQXdYTjBNRXFNRklHUjBGSW93dkg4ejFjRzhId1Ux?=
 =?utf-8?B?Sk16YjcxNU9pYWU1TzJBSUlwMUpFRzJGU2Y3OHFDTDJIZjNKeThGQUNtL0xE?=
 =?utf-8?B?QTB2VmVMenZvMGZJLzZaOVhLNHptUThndjRaMmswZ1plQncvNVNYODZBSzZq?=
 =?utf-8?B?Tmx4a0RNV3hnMGFlTEl6V0FkcHlIaWsxWE9PYXNjOVV5SW9rMCtkeW5Gd095?=
 =?utf-8?B?R3BaR0N2OVp1TlI2UkpwVWRBMFNjU2t5a3FQd1BKWnJxRmJhUnFsTVNZeVZk?=
 =?utf-8?B?Uld5bUxMVDBUV21aQml0ZG11V3BuSHk3OUd0L1B5d0o4VmJxdHFSaUVaTDI2?=
 =?utf-8?B?QzNxckdjQ0tRNUlkdUVoY2dUbFYweHVvU0k3OW1LRkZGOFhnU3A2ZmkyVDBG?=
 =?utf-8?B?dDVCM1o5NGxHS1ZjWGVubTIxQUc0QU96V0VPbkNlQ3piclF5Y2liQS9Ldmda?=
 =?utf-8?B?c1EyOVBraHFIK05MUm9LRDlyNDBhbzg4QkloMThLNlZLeVc0VXFxaERBcVFl?=
 =?utf-8?Q?24lOldxUUv7bjM9PXzQvXjzX3K6HgY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEg3NXNaWlN5TDRTUXNJREhBUW44ejlSYkpiREl1blBRSVJ1OFZGU1pCRjZ3?=
 =?utf-8?B?eGdxVktvcUE2cmMvSjRvRzNnYU9vWjZJazdRMGsvS05IeHgzNUVxaEN6VFZt?=
 =?utf-8?B?MmxwZmZuN3RnVkhTR25sdERHRkY3SHVzaHRGTUR6aUM0bjBOUUZHSlRWTlB2?=
 =?utf-8?B?amUrSkdUODYzb1J6NStZMnNMUkFRaFVKVnAvWksxRUQvNkNlamdrTWlOS0JK?=
 =?utf-8?B?UW96eGtibHkxb3NtdnRkdW1NZWFLRHdFWERIcGw0SHloWXJoNUl3dTVoM3Bm?=
 =?utf-8?B?dk5UTTlSaDRQbGZBdFc3djZXY0FxMWVEUjk3NG80NmhXazBINjRMc0FJUnVH?=
 =?utf-8?B?TXpaN25RKzhsdDEwT09KQlJUL2J4MHhSeDJlMFdOT1h1cS93VVorNUNuZ1VU?=
 =?utf-8?B?NWlIWGl1TWZiMkxYRzV1ZmFzNGFDbzNwZ05XdzcrVlFZdG1VZ3VTYytMYW1B?=
 =?utf-8?B?NWhEMThKSFYralBON1ZHc2pyWUlDcTFlcHhVN0NaNnliTTFrNUlPeUVJUUdp?=
 =?utf-8?B?TDhZZVpkT3JML2RoSDc5QlE1Yk5uSGZQMUk2SThyM3JSbGd3d3UrQjFSWnlx?=
 =?utf-8?B?NFpkS0YvVUdYSmZsa1VBNGRqZWh6SHN4RVVadCs2NHRxWU5zVm1qeDJsRndl?=
 =?utf-8?B?TU5FdXhkTGt1bFUxcVpML0UxNGR5aDBTbjdyRnBvLzJUWkFuamt5R25xcFRp?=
 =?utf-8?B?bnpxNC91cW1uaWVHcWs1R0NzWXZHVkFzUjhmTVVNc1pDNnpTalBSK3lqZ2dZ?=
 =?utf-8?B?TGN3WjhyQXFOeHpuU2lNUUZNZXZNeVFnVHljajk4UGpCaWNNK0dmQjYzdGgw?=
 =?utf-8?B?YVBHTHpzUUs4QkZkcjVobGdHV0EyQTZBRWI1dlc5MFl0czA1SUhaVXJnNXpU?=
 =?utf-8?B?eEsveHJtSHE4VjhNVGRhSk9MU2tyeUk2bENNS2dhZGFXSlB4NXNUSXRNZWJ3?=
 =?utf-8?B?bGZLZGFsb3pneUhiUjhDcFUrZFNRSk0rYzd2Y084YTZkMkxuZm5lNUJBa2tG?=
 =?utf-8?B?Y1JKMzBGT3pqemxaTWZacHBzemZkUHY1YmhrcUl3STF0OG9kS3RmL1A4U0Ez?=
 =?utf-8?B?K2tBYzJrWkRVdjAvYXhmVlE0Nm1KN296YndnSFNyVDV1NVF1dmFaR0xRQ3VZ?=
 =?utf-8?B?eCtpWFBFWWRjUmNxMllEWERndjhGT0k5b3BBVWduVXQ5SE5saUp3YmZSNk5x?=
 =?utf-8?B?TjQzbzlCMUR4WUpPSTk4N2xkaFNPcCtDR1MzTm9GKzRWZDFtc25pMXNBbm5X?=
 =?utf-8?B?ZDd0ejRnNVV5Zk9tMjh4eEU5d2c4RzVkOVhTM1ZiQkl5cVM1ZEhyUVc4TXN2?=
 =?utf-8?B?dlhab1ZMK2FMOFI4Vno4LzRYckM0bVorNkZKcTlNNTI5am5YWnFYUHZ2eWZm?=
 =?utf-8?B?NlFiMXpVOUtnbXltbGE2cy9oMkZrdWIySGdwV1pyUTAwK3NJVURqRC9iU0RG?=
 =?utf-8?B?Q1ovNVh5U0ZpYkhzenhrdlR5ampOeldHSGdHakJtMDl4dmZDc0JXS2N5REMx?=
 =?utf-8?B?MUM2UGdlQXJRUk84clRqU2NlaWRRNnVnWEFIZzNSVmZVMEFDM3I2YUMxdFJ0?=
 =?utf-8?B?UlFuRlhJcklXRFpHUGVkOStHblZ3bXBaRHBWVkQ0dkRxdktnckU4ZnprTW5h?=
 =?utf-8?B?eFB6azBIdmVZN2JURXlvNjlMZmF2OXdFcDFFcGIwbWg1YkZyMTBLMUtralM5?=
 =?utf-8?B?RmFUWko2aUIwM09KK09vL2hGNEU3MlZjTWU5dURmUnA5Q0ptVVRXUUZmR0VU?=
 =?utf-8?B?Yi80UEF6SE9xWERlaUVCdlF5clpPTmpuNytIMlVQUUxFbG82QnAyZFRtdGpW?=
 =?utf-8?B?dmdQK1h2NURxeTlNYWVLQmFoMFVhRHRzNHh4dmRNQWZYMG5CUnNwckM0MEFT?=
 =?utf-8?B?emRFZHNVOGJSQ2Nxand1YlB0M2p2ejVuWlJrK0I1TXp1UWt1Tzg3azluSkxG?=
 =?utf-8?B?eVYrcHJzWmdlbDRVT01oTndGQnRoZU9xZm9US0NWWlJrN1JxdUkvYmd3bUNI?=
 =?utf-8?B?MUdZK1hMVnZlbzl6eDVoQ01XT2xuTTY1RHNLRStsVHJRRDhFNXN5L1Nkam1w?=
 =?utf-8?B?MUNkZ1BsbTZwelpWUVN1alAxd1lRR2xuRmp4RTlrNDQ3TTJ1QnJySFBKY0tj?=
 =?utf-8?Q?YO6GAIuz+rhJobLDjIcMDK6TW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61e6e27-4bcb-4f0b-d2ed-08ddb3fcdfc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 15:28:02.3906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiKNY+T5lgRMI+dEkPJn9EQZX261mqnS6KfuSOhnmZEKFJ5+wXilE/qNH/n53LVNUF2oEUKrpNDYmkXeBkFXJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com

SGkgTmFtaHl1bmcsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cywgdGhhdCBtYWtlIHNlbnNl
LiBJIGhhdmUgc2VudCBhIFYyIHBhdGNoIG5hbWVkICJbUEFUQ0ggVjJdIHRvb2xzL3BlcmY6IEFk
ZCAtLWV4Y2x1ZGUtYnVpbGRpZHMgb3B0aW9uIHRvIHBlcmYgYXJjaGl2ZSBjb21tYW5kIiBmb3Ig
eW91ciByZXZpZXcuIA0KDQpSZWdhcmRzLA0KVGlhbnlvdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPiANClNlbnQ6
IFdlZG5lc2RheSwgSnVuZSAyNSwgMjAyNSAyOjUwIEFNDQpUbzogTGksIFRpYW55b3UgPHRpYW55
b3UubGlAaW50ZWwuY29tPg0KQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9y
Zz47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBN
ZWxvIDxhY21lQGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29t
PjsgQWxleGFuZGVyIFNoaXNoa2luIDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29t
PjsgSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29n
bGUuY29tPjsgSHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgS2FuIExp
YW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsgR3VvLCBXYW5neWFuZyA8d2FuZ3lhbmcu
Z3VvQGludGVsLmNvbT47IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBBZGQgLS1idWlsZGlk
cy1ibGFja2xpc3Qgb3B0aW9uIHRvIHBlcmYgYXJjaGl2ZSBjb21tYW5kDQoNCkhlbGxvLA0KDQpP
biBNb24sIEp1biAwOSwgMjAyNSBhdCAxMTo1NTo0MkFNICswODAwLCBUaWFueW91IExpIHdyb3Rl
Og0KPiBXaGVuIG1ha2UgYSBwZXJmIGFyY2hpdmUsIGl0IG1heSBjb250YWlucyB0aGUgYmluYXJp
ZXMgdGhhdCB1c2VyIGRpZCANCj4gbm90IHdhbnQgdG8gc2hpcCB3aXRoLCBhZGQgLS1idWlsZGlk
cy1ibGFja2xpc3Qgb3B0aW9uIHRvIHNwZWNpZnkgYSANCj4gYmFja2xpc3QgZmlsZSB3aGljaCBj
b250YWlucyB0aGUgYnVpbGRpZHMgbmVlZCB0byBiZSBleGNsdWRlZC4gVGhlIGJsYWNrbGlzdCBm
aWxlIGNhbiBiZSBnZW5lcmF0ZWQgZnJvbSBjb21tYW5kOg0KPiANCj4gICBwZXJmIGJ1aWxkaWQt
bGlzdCAtaSBwZXJmLmRhdGEgLS13aXRoLWhpdHMgfCBncmVwIC12ICJeICIgPiANCj4gYnVpbGRp
ZHNfYmxhY2tsaXN0LnR4dA0KPiANCj4gVGhlbiByZW1vdmUgdGhlIGxpbmVzIGZyb20gdGhlIGJ1
aWxkaWRzX2JsYWNrbGlzdC50eHQgZm9yIGJ1aWxkaWRzIHNob3VsZCBiZSBpbmNsdWRlZC4NCg0K
SW5zdGVhZCBvZiBibGFja2xpc3QsIGhvdyBhYm91dCBzYXlpbmcgaXQgbGlrZSAiLS1leGNsdWRl
LWJ1aWxkaWRzIj8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGlhbnlvdSBMaSA8dGlhbnlvdS5s
aUBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBXYW5neWFuZyBHdW8gPHdhbmd5YW5nLmd1b0Bp
bnRlbC5jb20+DQo+IC0tLQ0KPiAgdG9vbHMvcGVyZi9wZXJmLWFyY2hpdmUuc2ggfCAzNSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVy
Zi9wZXJmLWFyY2hpdmUuc2ggYi90b29scy9wZXJmL3BlcmYtYXJjaGl2ZS5zaCANCj4gaW5kZXgg
NmVkN2U1MmFiODgxLi5lNWZmODQwYWM2YjQgMTAwNzU1DQo+IC0tLSBhL3Rvb2xzL3BlcmYvcGVy
Zi1hcmNoaXZlLnNoDQo+ICsrKyBiL3Rvb2xzL3BlcmYvcGVyZi1hcmNoaXZlLnNoDQo+IEBAIC0x
Niw2ICsxNiwxMyBAQCB3aGlsZSBbICQjIC1ndCAwIF0gOyBkbw0KPiAgCWVsaWYgWyAkMSA9PSAi
LS11bnBhY2siIF07IHRoZW4NCj4gIAkJVU5QQUNLPTENCj4gIAkJc2hpZnQNCj4gKwllbGlmIFsg
JDEgPT0gIi0tYnVpbGRpZHMtYmxhY2tsaXN0IiBdOyB0aGVuDQo+ICsJCUJVSUxESURTX0JMQUNL
TElTVD0iJDIiDQo+ICsJCWlmIFsgISAtZSAiJEJVSUxESURTX0JMQUNLTElTVCIgXTsgdGhlbg0K
PiArCQkJZWNobyAiUHJvdmlkZWQgYnVpbGRpZHMgYmxhY2tsaXN0IGZpbGUgJEJVSUxESURTX0JM
QUNLTElTVCBkb2VzIG5vdCBleGlzdCINCj4gKwkJCWV4aXQgMQ0KPiArCQlmaQ0KPiArCQlzaGlm
dCAyDQo+ICAJZWxzZQ0KPiAgCQlQRVJGX0RBVEE9JDENCj4gIAkJVU5QQUNLX1RBUj0kMQ0KPiBA
QCAtODYsMTEgKzkzLDI5IEBAIGZpDQo+ICANCj4gIEJVSUxESURTPSQobWt0ZW1wIC90bXAvcGVy
Zi1hcmNoaXZlLWJ1aWxkaWRzLlhYWFhYWCkNCj4gIA0KPiAtcGVyZiBidWlsZGlkLWxpc3QgLWkg
JFBFUkZfREFUQSAtLXdpdGgtaGl0cyB8IGdyZXAgLXYgIl4gIiA+IA0KPiAkQlVJTERJRFMgLWlm
IFsgISAtcyAkQlVJTERJRFMgXSA7IHRoZW4NCj4gLQllY2hvICJwZXJmIGFyY2hpdmU6IG5vIGJ1
aWxkLWlkcyBmb3VuZCINCj4gLQlybSAkQlVJTERJRFMgfHwgdHJ1ZQ0KPiAtCWV4aXQgMQ0KPiAr
Iw0KPiArIyBCVUlMRElEU19CTEFDS0xJU1QgaXMgYW4gb3B0aW9uYWwgZmlsZSB0aGF0IGNvbnRh
aW5zIGJ1aWxkLWlkcyB0byANCj4gK2JlIGV4Y2x1ZGVkIGZyb20gdGhlICMgYXJjaGl2ZS4gSXQg
aXMgYSBsaXN0IG9mIGJ1aWxkLWlkcywgb25lIHBlciBsaW5lLCB3aXRob3V0IGFueSBsZWFkaW5n
IG9yIHRyYWlsaW5nIHNwYWNlcy4NCj4gKyMgSWYgdGhlIGZpbGUgaXMgZW1wdHksIGFsbCBidWls
ZC1pZHMgd2lsbCBiZSBpbmNsdWRlZCBpbiB0aGUgDQo+ICthcmNoaXZlLiBUbyBjcmVhdGUgYSBi
bGFja2xpc3QgIyBmaWxlLCB5b3UgY2FuIHVzZSB0aGUgZm9sbG93aW5nIGNvbW1hbmQ6DQo+ICsj
IAlwZXJmIGJ1aWxkaWQtbGlzdCAtaSBwZXJmLmRhdGEgLS13aXRoLWhpdHMgfCBncmVwIC12ICJe
ICIgPiBidWlsZGlkc19ibGFja2xpc3QudHh0DQo+ICsjIFlvdSBjYW4gZWRpdCB0aGUgZmlsZSB0
byByZW1vdmUgdGhlIGxpbmVzIHRoYXQgeW91IHdhbnQgdG8ga2VlcCBpbiB0aGUgYXJjaGl2ZSwg
dGhlbjoNCj4gKyMgCXBlcmYgYXJjaGl2ZSAtLWJ1aWxkaWRzLWJsYWNrbGlzdCBidWlsZGlkc19i
bGFja2xpc3QudHh0DQoNClRoZW4geW91J2xsIG5lZWQgdG8gdXBkYXRlIHRoZSBjb21tZW50IGhl
cmUuDQoNClRoYW5rcywNCk5hbWh5dW5nDQoNCj4gKyMNCj4gK2lmIFsgISAtcyAkQlVJTERJRFNf
QkxBQ0tMSVNUIF07IHRoZW4NCj4gKwlwZXJmIGJ1aWxkaWQtbGlzdCAtaSAkUEVSRl9EQVRBIC0t
d2l0aC1oaXRzIHwgZ3JlcCAtdiAiXiAiID4gJEJVSUxESURTDQo+ICsJaWYgWyAhIC1zICRCVUlM
RElEUyBdIDsgdGhlbg0KPiArCQllY2hvICJwZXJmIGFyY2hpdmU6IG5vIGJ1aWxkLWlkcyBmb3Vu
ZCINCj4gKwkJcm0gJEJVSUxESURTIHx8IHRydWUNCj4gKwkJZXhpdCAxDQo+ICsJZmkNCj4gK2Vs
c2UNCj4gKwlwZXJmIGJ1aWxkaWQtbGlzdCAtaSAkUEVSRl9EQVRBIC0td2l0aC1oaXRzIHwgZ3Jl
cCAtdiAiXiAiIHwgZ3JlcCAtRnYgLWYgJEJVSUxESURTX0JMQUNLTElTVCA+ICRCVUlMRElEUw0K
PiArCWlmIFsgISAtcyAkQlVJTERJRFMgXSA7IHRoZW4NCj4gKwkJZWNobyAicGVyZiBhcmNoaXZl
OiBubyBidWlsZC1pZHMgZm91bmQgYWZ0ZXIgYXBwbHlpbmcgYmxhY2tsaXN0Ig0KPiArCQlybSAk
QlVJTERJRFMgfHwgdHJ1ZQ0KPiArCQlleGl0IDENCj4gKwlmaQ0KPiAgZmkNCj4gIA0KPiAgTUFO
SUZFU1Q9JChta3RlbXAgL3RtcC9wZXJmLWFyY2hpdmUtbWFuaWZlc3QuWFhYWFhYKQ0KPiAtLQ0K
PiAyLjQ3LjENCj4gDQo=
