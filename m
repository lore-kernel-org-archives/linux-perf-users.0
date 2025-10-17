Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2F2773E4;
	Fri, 17 Oct 2025 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723707; cv=fail; b=lJ1XvVTvrsEXnTZIjqErSrCfgMn99rk6wjybJsNYcmowqia/YX35Fnr80FVYP4oOobI4gsi/dG1PHX/8rfzImwPLqml4j/Rd8gyrx/+9Cbeb0pGbZjzXBHbRhgasTxayD3sB6/DcFkPvaE5Ci5jjqb0uk8w6aBjEaz19BXRQATQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723707; c=relaxed/simple;
	bh=Hr/P8gN3YUekGarbqlLmxQjWKoD1MSGzFSBO3Q06WEQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rci6WJ9n3t8Fal2wiNbMOCxnH6/Su4zmReskLkyqMOVZ9cAGGqahBPIBO5Zr7QLcZFvi/z2uidGbXgTJUbyDLyA7R8XQIea5hLVehNvFMnSCBMR2Oz4pE/jmIqkJhdaiix2e/BoevAtOLb0LRnD/jiV2YAaFY6ZREcEJ+lEt9+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjFnCZPr; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjFnCZPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760723706; x=1792259706;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Hr/P8gN3YUekGarbqlLmxQjWKoD1MSGzFSBO3Q06WEQ=;
  b=XjFnCZPrRBb2o4IGdUAji/7XoulpsL8Y4eyVNW6MVcEYDVZf6por1Kqk
   +AKm+5G9OF4j8Jj9ke3sZV6G3gQccg5XQlSF8avnfB1/lLZ/znPMj0jkE
   gMI/6WzTCFiOuHp2Rj32SSXjLIlEbcEA70lTjhnlfW8NIex8oWsI9mDow
   0D+Ih39FKBcajgu+ACJYVgad3t5ubUd87ambO7hsCVFwKUJMb/nZVc6UY
   8vqDQ1pGZmjRt1Iri9FogaucxmHqevcBxs13devByUKwD3cNALzNvJDTk
   TPLYfoiMMxHqDxhnAcp4gxBA5zbWtbInpKhi7xAMuZvbcBtHM3qV2xrP0
   A==;
X-CSE-ConnectionGUID: eNcj1iY0RyGTLXk/GF0r8A==
X-CSE-MsgGUID: pmCl/iu7R4OpzsdmiYQp9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="80385814"
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="80385814"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 10:55:02 -0700
X-CSE-ConnectionGUID: xewwoV6/QmCiwJm8A4VrIQ==
X-CSE-MsgGUID: CuEDqfGIRImoRQ2wrsA+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="186818031"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 10:55:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 10:55:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 10:55:01 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 10:55:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXifttEUEUYfw8nKBH4SR0dgB1nN1pAZIRQLCs0lovIA/Z1iEjXozMeoqKtLrFKynQEO/gAzUfAx+ddHn/+BAgqLYzJvz97ioavgtEj0lUHoen5eleB3Doe/S141u5pevDGlgzUphrLyzamO3knqgSA0oZRpDc1GeVJxLtekUSL8Fi2dAthwKZs6BlD9qgoEiOlJj2KvfKtoJm1yND0QK2FMxTplJ6U4Lznka2l2wE1NpN8jsCeG12pnVps2VRjEU/qs2TtbSAAi48fs6lsHUqN8hw+RHYl1S4e5CvpeRmo7mBDynkN2AdefQ3tdJbjaqGPJcGomVIuIo0yX87rDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr/P8gN3YUekGarbqlLmxQjWKoD1MSGzFSBO3Q06WEQ=;
 b=MT4a586akdLeChOFZFZ2uvJmL7PO5SjRz2PVa8qI0rwD6x+UEvu3M8FZo8TPnQEQgK6iWP102x8adsa9EjikbdQUbNeNpB08GNJYsYYQm0FhyWF+MjmVgS6o3Y+cU5rR/X5GjR6c+OcH0JOzd35JhAVEGyciheeSnuq3JYBx6i1+JapiCm9J3937PSTTSsY1bZreGphc6zXUJb8J+iXnD22/f+ttyrDLkxeZvx2f+VlmhCmVaACQQ+9XTMprXCwFrdQXrtq9dPVTvp1E6H7LXzusqxQ+9llDXqrUMJuRc83iC7cPzP3zszrb4cdYaT4WwuFpQmdd0hsa+07WQe9mvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 17:54:58 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 17:54:58 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "dapeng1.mi@linux.intel.com"
	<dapeng1.mi@linux.intel.com>, "irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH v1] perf parse-events: Make X modifier more respectful of
 groups
Thread-Topic: [PATCH v1] perf parse-events: Make X modifier more respectful of
 groups
Thread-Index: AQHcP4c7k+/xHk1fnkK2AGIp+YX5WLTGnz6A
Date: Fri, 17 Oct 2025 17:54:58 +0000
Message-ID: <6ffbfa494002d3ed85a160c2f2a6e1881dfdd304.camel@intel.com>
References: <20251017165753.206608-1-irogers@google.com>
In-Reply-To: <20251017165753.206608-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS0PR11MB8018:EE_
x-ms-office365-filtering-correlation-id: fa33da6a-a456-4b95-ea2f-08de0da64989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?MjhTM3p1ekxCQWZRdzdCNll6NzZ2ZDNkV1QwT1ZTSkhFY1JzZVNxaW5tUkdX?=
 =?utf-8?B?bVZydFc1WXgvRmxidW9MNHdBREhUQWVpYVRvWStna01Mb0ZLeENxUHgxMGdr?=
 =?utf-8?B?SmFiUTNjWngvQ0p5MjRnQnlvbjd4bm5VOWJSNVVxdk9EbWU3Vm5xSVJBUWRl?=
 =?utf-8?B?WDlkbU1Ya0M2QXNZeUlraEFjaVMrQzRScG5razlBRjVBVmlUcUNaY2lKYU8y?=
 =?utf-8?B?THBMUVNMSXd0djh5WEptTUR2ckpYaWcyZEY0Vy9Zd0hoY0RSMU5zN0xXZ05u?=
 =?utf-8?B?dWc1bTd2dTgzaStMcjBZNXRLcWJIdUp0MnpsNHlreHdzKzBSMVN2U0l5NDBN?=
 =?utf-8?B?S1NCSjYvYlBEVTljb1dZVk5GdkhwMnEwQkpVSWdIcEgwSkZDT00rQ1ljVVk0?=
 =?utf-8?B?VDZIWFRHbktRdExHNFl5RzlZZXJoRmJZMVRpSkNldUNDZG5EaENBaTZ4bXRn?=
 =?utf-8?B?S2Y5aWc5T2FzeHZMYnM1WGdtRzN1NW15YmVKQUZWMHV2bk4zRHNITDRLSHUr?=
 =?utf-8?B?MnkvZGNsQWU5UUE4cWZkUmdsOEtSbVdaUTZUWHJlRXM1SWZSM1lJUjBDOTE4?=
 =?utf-8?B?d0dTUEtZOHJBeXpRc3VxTEpsUHoyUFpFUE83M1czRE51UytrMmx5ZDVUM2ZT?=
 =?utf-8?B?TWlQeEk3dnVKOFBJVmtmY1pYOEFENzJxMEpDVktMbGM0Z0FpV0pBeE1VU2lr?=
 =?utf-8?B?R3ZPNUFMQXE4aksvMmo1cTU5UjVBRU15YUs2MXVOVGFyVW85VnAyc2xGbTlq?=
 =?utf-8?B?OHRtS2hmM1J4N3kvM3JacE9lZDd2MlBtMTZPSFBUWWR0c2RxSXNrN1JONjJi?=
 =?utf-8?B?MFhUWktIUHVxdkFwanJFTTJlTVgvSWJSUXBjYytQaVZmRVhHanBUUHVYL2Mr?=
 =?utf-8?B?NnFNRjFsK3drL2tnWExsMWNEZGYrcXV6NC85eWRpaGVkNUc2bVRlRlFlMkdK?=
 =?utf-8?B?Ui9PeW9NQmczVkxrSmQwVFFuOFY2aVk1TkVySDZHYVNYRW5TMm5tTjJMQTVX?=
 =?utf-8?B?RTczUnBlWjNJclFqbytCeWtpeGdPTCtKL3g3bkpTeURRcFhnd21ETGJDNVgv?=
 =?utf-8?B?b2Rkb2YybDVsY0w3LzJ3N2d5YXFoV2NrTkNLOHkxTzFGYXpITFpxalVOS1VC?=
 =?utf-8?B?eDNPT2poWkllOHA3aDVZVHJJT1pRSlBPaUthSE9CdU1NTVVuSTV1S2RJOTRa?=
 =?utf-8?B?cEd1WThTZHJKYVp6Vm4yUDM5dUVzdTAvVld6UVFkb2FiQi93ZVVpL2l3T1Bw?=
 =?utf-8?B?TlI2NWVnRkdWUmZaa084YytGOC9MN0xLM0NUbWdLUG5qSnhzSlErek8wQ2lH?=
 =?utf-8?B?cEVaV09qQmRkNCtwTXFZcy9vZnZlUVFGUnNnZUNyb3A2YWg1clZHMHc3QUJI?=
 =?utf-8?B?ZkxJeko3M0xzV2d3MWlodFhoL01OYVYxblpsYlZsT3U3L0Y0aTJrbmE2YkJh?=
 =?utf-8?B?VDBzQk8vTEpXMGYxRmpMeGd3M2JZcGJIYU1YeVEvZEhmTW8vOGI1Y1g4R1or?=
 =?utf-8?B?ZkJUL0JIOCtmYm52UHRXcEd2WkVFUXBiNU1kWFdLQ0pHWEM2N0tER2phbUsx?=
 =?utf-8?B?TEdTeWpRelNTRjlrK2hnYm5GSlZyOFZZT1VYL0xvS21HY2paVkJqZmNIcldy?=
 =?utf-8?B?bnpjcTFYU1ZHdjBHYXR0c2k3MmtaN29lRDMxbzFrV21ONWh2b2tQZ296N1hM?=
 =?utf-8?B?MnpQRitKZFE5bnMxUVFwSUNZbHNHTlVjU2I5VmZYSlM2UTZPTmlSM3dqY0N1?=
 =?utf-8?B?c0F2amcvcE1XY3lxWklPWFFQWmgwcnVDU1VNaDkvckRZSjBpOTc4NHRQcVgr?=
 =?utf-8?B?TDhyOEgxR0hzcndmMmpjRSs2dkxXTHVnMW1KeitnTGZ2WnNzSW5uZC9LcjdJ?=
 =?utf-8?B?MS93QmZFWDU5Rm9SbmhFdENFMjkrNFlENFc4d3k0RjdhQnRUbmMxdFlWUnlv?=
 =?utf-8?B?eWZqWVVScFdaSVJtUWtKL0hFWGY0VUt6bTQ2MFpVQjRkVURXNTBrNU9odlo0?=
 =?utf-8?B?c1Bra3lwUnhaYnA4bkQwc0dXSzhoZkxQY01yZlBydUE3K0hiV1lvL2JtYzNq?=
 =?utf-8?B?VUR2eXhybm9ZWkljWlNIUXBhZXFxSGRPSG1WUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2VhNGRpTi9MSi9BeE5rZUxHME4xeE4xdUdHL2RXQysvQ2hWcTc5Qk9HNEtY?=
 =?utf-8?B?RldOSDZyOHkvK2lnb0xMUmpGYUFmY2J4cVBWTURYekxza3hzSmRvNXlBSkhi?=
 =?utf-8?B?bU1ZWlNzdk5MVlU3WGNHaW1Kc0tad0o3SGl5amZETXd5WldDZ3M3Ly9CQmZq?=
 =?utf-8?B?Q2N1M1FEdkhjSTZmTS8rYUFxL2dKbVFkOFpabFlsSlBCeTF2Tm5OSWpZRnFn?=
 =?utf-8?B?Rzd6a0o0bjI2REVYRWo0WmlXK0lYc2VXMFpjZTgxc2hRN2k1WWYzNFBZMnEw?=
 =?utf-8?B?b0QyYkR3Ymo4aS96NFlTL2hqeUxmd2ZBYURNaG9SRy9QMUhMdFNPMzVycFRp?=
 =?utf-8?B?NUloZEtFNmh3L2xsU2toNHNiUU15S0xYaGtJVG05akR3RU4xNkRUQ0FoUVlr?=
 =?utf-8?B?OFZVem5iR2VyV0pFSW0zdkVBQWtlUUFnQ1JKMWFvWGlSeVBhMDJXdlYzOTFG?=
 =?utf-8?B?Vk1MQjViN1dxMHlyQ3ZOSTkvZVo4dmhvUGQzcHAwUjhNd21yRngyT3NMU0E3?=
 =?utf-8?B?WDk2OGZJb2dDYkVPK3lubkpVdW5vOW0zeXZuQklQb25PWXlxeU1MOTE5UnA0?=
 =?utf-8?B?dElyTWlnZ3lqVldWWlMrZDJ6ZjNQb0NUMHRNL3VJb043R1RqTTNkSFRrNlJ2?=
 =?utf-8?B?TmtNenNmUUdkdEMraHlNNUtJWjhmS1dvYjdVZ0NobEh3U0tBdm83dG5aZTVT?=
 =?utf-8?B?U05IMm80TlhwS2lrcnhBM0JEVStrSlBZSTRtc1Q2VG5kK2lVVjl6NTZOZXFm?=
 =?utf-8?B?UWpvVFIzQ1RuZUoxM2NiSytiQ3JRZy9qT3l1WjdtZGM0N0tOaHNDdnJjNXFk?=
 =?utf-8?B?NkgrTnlvdjFlNjRuZW8rMU5kakhGSkpIdFR4eW9rMitxa3pjRHkyOUMzemlG?=
 =?utf-8?B?eldtL3pFay9xcGh4aEhGTFRXWDhQd0E1emZ4ck03L0UzTmJpS0IzNHZNNWQ1?=
 =?utf-8?B?QjVHL2tsNHlSOTErNUw0cUxWU2c3TmN0UnZlejRjLzRFZGo2c29RSGc5RTBz?=
 =?utf-8?B?QzJ3UGw5T3Zvd0xCQ2NZQ3FrSGxLdmU5NFZoaFJXU1dsQmE2b0Mwb0w2WUpw?=
 =?utf-8?B?RUk3NnBOY0Y0ZjRseHpsRGJWMm5qeFpmUko5RTJwUlBialdZZUZsNlVSQ3lO?=
 =?utf-8?B?b1o0K0RBUHYxNHRUSWJ4NmlRMEQyN2QvWlZPRklxbXYyY0h2eitGR0YzVFFK?=
 =?utf-8?B?UXRSUWh4NjVWQVFtT2VWeG5JTkdDVXpvNlpHRWpERHM4MWNZajJuSzJ3bjc1?=
 =?utf-8?B?bTQxQXFRSG5hdHYvSlBoTXRST3UybTVUc0NMV1FrOU14WGNsMC9HSzcyZW5C?=
 =?utf-8?B?Z3lDQmg0NUNvaWo3M0xEaFVNR1RON0lzQUNkRkhMbncxTHlWWG92Rkx1aVVz?=
 =?utf-8?B?TVRhbENPOU9hTGJzQVBZN1ZRdmJ3bTFNdUQyWWtSVnJOdjVXRC9GQlU5ak1E?=
 =?utf-8?B?amY5bUhwMnh3anNoS1R0T2xTaDNqTjQ0RVR0c2dBdldyL3FHMk5tU3RBV1VI?=
 =?utf-8?B?N2tWdzI5YXUxWEN5TTNVN0xiWTR3bmRuVGtMWEVydTdraWJKQS9URDVXdEw5?=
 =?utf-8?B?MlhTK0QwbUt2S0lKamZEL25DRGE2a1FMT0lhL1AwUFNUWk5CRzMySnpSUlQx?=
 =?utf-8?B?KzVWUWhHZnA0U2RkMnMzVCtXQXhCby8yWFJUZURxUTdseFNsSlVHS1pNbXNJ?=
 =?utf-8?B?OHVUd3FUdkU0YzFnM0VhcFdYWDQ5eFpOUGlqZlMvdXlRclVPdGJmRm9ndU5Y?=
 =?utf-8?B?UDRkUjY4Wk4wM2NKREY2M053dDh2RExrSXBBajZCRHd5QVVXOE9xWDBkdmdx?=
 =?utf-8?B?bVNjTHBObzBUOFRsNjg0bk0zVWcwTkgrZFQrdHBPSzljMUkvb2ViZTY4Q0E0?=
 =?utf-8?B?bUgxK0xJWVh4dTR2R2ZGcWt2M0FHaXEzNnN2YWxpSmFhblhJMFBveUVPaVQ5?=
 =?utf-8?B?dUpQcWVwUWtpZHNEMW1pbzU3R0t3TXJhMUt0ckprWkQxbnFTdDZBbXAyV0FR?=
 =?utf-8?B?WGxQcHZTc3ZLdWp5Y3dod3ZPMXlLSDNPVjFLdE5pTWdGemhxRkVvMUltZFRI?=
 =?utf-8?B?UlhyVUlyemg5VlkwZ05ZTCtrYlBhNDJWYkozWFZNQSt4bnltVWdUT2wvajlO?=
 =?utf-8?B?SElBQ0JndzFELzF0K25oSUErZkhBd3ZmK09uOFlLVk9GUEk5T3FNd0lUY3Ev?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7560787B0DB740488514DCD8356FD442@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa33da6a-a456-4b95-ea2f-08de0da64989
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 17:54:58.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmnXcbA3Zrj2CB+/ti6jK2JuLkLSsz1hXQYRjKQg+598mw9iodi0rMxtAe+niU/KPfpH5JDStaJrEv+T4xynRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8018
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTEwLTE3IGF0IDA5OjU3IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBF
dmVudHMgd2l0aCBhbiBYIG1vZGlmaWVyIHdlcmUgcmVvcmRlcmVkIHdpdGhpbiBhIGdyb3VwLCBm
b3IgZXhhbXBsZQ0KPiBzbG90cyB3YXMgbWFkZSB0aGUgbGVhZGVyIGluOg0KPiBgYGANCj4gJCBw
ZXJmIHJlY29yZCAtZSAne2NwdS9tZW0tc3RvcmVzL3BwdSxjcHUvc2xvdHMvdVh9JyAtLSBzbGVl
cCAxDQo+IGBgYA0KPiANCj4gRml4IGJ5IG1ha2luZyBgZG9udF9yZWdyb3VwYCBldnNlbHMgYWx3
YXlzIHVzZSB0aGVpciBpbmRleCBmb3INCj4gc29ydGluZy4gTWFrZSB0aGUgY3VyX2xlYWRlciwg
d2hlbiBmaXhpbmcgdGhlIGdyb3VwcywgYmUgdGhhdCBvZg0KPiBgZG9udF9yZWdyb3VwYCBldnNl
bCBzbyB0aGF0IHRoZSBgZG9udF9yZWdyb3VwYCBldnNlbCBkb2Vzbid0IGJlY29tZQ0KPiBhDQo+
IGxlYWRlci4NCj4gDQo+IE9uIGEgdGlnZXJsYWtlIHRoaXMgcGF0Y2ggY29ycmVjdHMgdGhpcyBh
bmQgbWVldHMgZXhwZWN0YXRpb25zIGluOg0KPiBgYGANCj4gJCBwZXJmIHN0YXQgLWUgJ3tjcHUv
bWVtLXN0b3Jlcy8sY3B1L3Nsb3RzL3VYfScgLWEgLS0gc2xlZXAgMC4xDQo+IA0KPiDCoFBlcmZv
cm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6DQo+IA0KPiDCoMKgwqDCoMKg
wqDCoCA4Myw0NTgsNjUywqDCoMKgwqDCoCBjcHUvbWVtLXN0b3Jlcy8NCj4gwqDCoMKgwqAgMiw3
MjAsODU0LDg4MMKgwqDCoMKgwqAgY3B1L3Nsb3RzL3VYDQo+IA0KPiDCoMKgwqDCoMKgwqAgMC4x
MDM3ODA1ODcgc2Vjb25kcyB0aW1lIGVsYXBzZWQNCj4gDQo+ICQgcGVyZiBzdGF0IC1lICdzbG90
cyxzbG90czpYJyAtYSAtLSBzbGVlcCAwLjENCj4gDQo+IMKgUGVyZm9ybWFuY2UgY291bnRlciBz
dGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoNCj4gDQo+IMKgwqDCoMKgwqDCoCA3MzIsMDQyLDI0N8Kg
wqDCoMKgwqAgc2xvdHPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDQ4Ljk2JSkNCj4g
wqDCoMKgwqDCoMKgIDY0MywyODgsMTU1wqDCoMKgwqDCoCBzbG90czpYwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKDUxLjA0JSkNCj4gDQo+IMKgwqDCoMKgwqDCoCAwLjEwMjczMTAxOCBzZWNv
bmRzIHRpbWUgZWxhcHNlZA0KPiBgYGANCj4gDQoNCkhpIElhbiwganVzdCBjb25maXJtaW5nIHRo
ZSByZXN1bHRzIG9uIGFuIEFsZGVyIExha2U6DQoNCiUgc3VkbyAuL3BlcmYgc3RhdCAtZSAne2Nw
dV9jb3JlL21lbS1zdG9yZXMvLGNwdV9jb3JlL3Nsb3RzL3VYfScgLWEgLS0NCnNsZWVwIDAuMQ0K
DQogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoNCg0KICAgICAg
ICAyMywwOTcsMzQ2ICAgICAgY3B1X2NvcmUvbWVtLXN0b3Jlcy8NCiAgICAgICA2NjYsOTEwLDk3
NCAgICAgIGNwdV9jb3JlL3Nsb3RzL3VYICAgICAgICAgICAgICAgICANCg0KICAgICAgIDAuMTAx
MzY5OTgyIHNlY29uZHMgdGltZSBlbGFwc2VkDQoNCiAlIHN1ZG8gLi9wZXJmIHN0YXQgLWUgJ3Ns
b3RzLHNsb3RzOlgnIC1hIC0tIHNsZWVwIDAuMSAgDQoNCiBQZXJmb3JtYW5jZSBjb3VudGVyIHN0
YXRzIGZvciAnc3lzdGVtIHdpZGUnOg0KDQogICAgIDEsNzc1LDU1NSwxODAgICAgICBjcHVfY29y
ZS9zbG90cy8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQooNTAuMDglKQ0KICAgICAx
LDkxMCwwNzMsODcyICAgICAgY3B1X2NvcmUvc2xvdHMvWCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KKDQ5LjkyJSkNCg0KICAgICAgIDAuMTAxMzY4MjgzIHNlY29uZHMgdGltZSBlbGFw
c2VkDQoNClRlc3RlZC1ieTogVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+
DQoNClRoYW5rcywNClRvbQ0KDQo+IENsb3NlczoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8xOGYyMGQzOC0wNzBjLTRlMTctYmM5MC1jZjcxMDJlMWU1M2RAbGludXguaW50ZWwuY29t
Lw0KPiBGaXhlczogMDM1YzE3ODkzMDgyICgicGVyZiBwYXJzZS1ldmVudHM6IEFkZCAnWCcgbW9k
aWZpZXIgdG8gZXhjbHVkZQ0KPiBhbiBldmVudCBmcm9tIGJlaW5nIHJlZ3JvdXBlZCIpDQo+IFNp
Z25lZC1vZmYtYnk6IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+IMKg
dG9vbHMvcGVyZi91dGlsL3BhcnNlLWV2ZW50cy5jIHwgMTYgKysrKysrKysrKy0tLS0tLQ0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9wYXJzZS1ldmVudHMuYyBiL3Rvb2xzL3BlcmYv
dXRpbC9wYXJzZS0NCj4gZXZlbnRzLmMNCj4gaW5kZXggM2FlYzg2YWViZGM2Li4xYTVkYTkzZjQw
OTQgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9wYXJzZS1ldmVudHMuYw0KPiArKysg
Yi90b29scy9wZXJmL3V0aWwvcGFyc2UtZXZlbnRzLmMNCj4gQEAgLTE5NzMsMTQgKzE5NzMsMTgg
QEAgc3RhdGljIGludCBldmxpc3RfX2NtcCh2b2lkICpfZmdfaWR4LCBjb25zdA0KPiBzdHJ1Y3Qg
bGlzdF9oZWFkICpsLCBjb25zdCBzdHJ1Y3QgbGkNCj4gwqAJICogZXZlbnQncyBpbmRleCBpcyB1
c2VkLiBBbiBpbmRleCBtYXkgYmUgZm9yY2VkIGZvciBldmVudHMNCj4gdGhhdA0KPiDCoAkgKiBt
dXN0IGJlIGluIHRoZSBzYW1lIGdyb3VwLCBuYW1lbHkgSW50ZWwgdG9wZG93biBldmVudHMuDQo+
IMKgCSAqLw0KPiAtCWlmICgqZm9yY2VfZ3JvdXBlZF9pZHggIT0gLTEgJiYNCj4gYXJjaF9ldnNl
bF9fbXVzdF9iZV9pbl9ncm91cChsaHMpKSB7DQo+ICsJaWYgKGxocy0+ZG9udF9yZWdyb3VwKSB7
DQo+ICsJCWxoc19zb3J0X2lkeCA9IGxoc19jb3JlLT5pZHg7DQo+ICsJfSBlbHNlIGlmICgqZm9y
Y2VfZ3JvdXBlZF9pZHggIT0gLTEgJiYNCj4gYXJjaF9ldnNlbF9fbXVzdF9iZV9pbl9ncm91cChs
aHMpKSB7DQo+IMKgCQlsaHNfc29ydF9pZHggPSAqZm9yY2VfZ3JvdXBlZF9pZHg7DQo+IMKgCX0g
ZWxzZSB7DQo+IMKgCQlib29sIGxoc19oYXNfZ3JvdXAgPSBsaHNfY29yZS0+bGVhZGVyICE9IGxo
c19jb3JlIHx8DQo+IGxoc19jb3JlLT5ucl9tZW1iZXJzID4gMTsNCj4gwqANCj4gwqAJCWxoc19z
b3J0X2lkeCA9IGxoc19oYXNfZ3JvdXAgPyBsaHNfY29yZS0+bGVhZGVyLT5pZHgNCj4gOiBsaHNf
Y29yZS0+aWR4Ow0KPiDCoAl9DQo+IC0JaWYgKCpmb3JjZV9ncm91cGVkX2lkeCAhPSAtMSAmJg0K
PiBhcmNoX2V2c2VsX19tdXN0X2JlX2luX2dyb3VwKHJocykpIHsNCj4gKwlpZiAocmhzLT5kb250
X3JlZ3JvdXApIHsNCj4gKwkJcmhzX3NvcnRfaWR4ID0gcmhzX2NvcmUtPmlkeDsNCj4gKwl9IGVs
c2UgaWYgKCpmb3JjZV9ncm91cGVkX2lkeCAhPSAtMSAmJg0KPiBhcmNoX2V2c2VsX19tdXN0X2Jl
X2luX2dyb3VwKHJocykpIHsNCj4gwqAJCXJoc19zb3J0X2lkeCA9ICpmb3JjZV9ncm91cGVkX2lk
eDsNCj4gwqAJfSBlbHNlIHsNCj4gwqAJCWJvb2wgcmhzX2hhc19ncm91cCA9IHJoc19jb3JlLT5s
ZWFkZXIgIT0gcmhzX2NvcmUgfHwNCj4gcmhzX2NvcmUtPm5yX21lbWJlcnMgPiAxOw0KPiBAQCAt
MjA3OCwxMCArMjA4MiwxMCBAQCBzdGF0aWMgaW50DQo+IHBhcnNlX2V2ZW50c19fc29ydF9ldmVu
dHNfYW5kX2ZpeF9ncm91cHMoc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkNCj4gwqAJICovDQo+IMKg
CWlkeCA9IDA7DQo+IMKgCWxpc3RfZm9yX2VhY2hfZW50cnkocG9zLCBsaXN0LCBjb3JlLm5vZGUp
IHsNCj4gLQkJY29uc3Qgc3RydWN0IGV2c2VsICpwb3NfbGVhZGVyID0gZXZzZWxfX2xlYWRlcihw
b3MpOw0KPiArCQlzdHJ1Y3QgZXZzZWwgKnBvc19sZWFkZXIgPSBldnNlbF9fbGVhZGVyKHBvcyk7
DQo+IMKgCQljb25zdCBjaGFyICpwb3NfcG11X25hbWUgPSBwb3MtPmdyb3VwX3BtdV9uYW1lOw0K
PiDCoAkJY29uc3QgY2hhciAqY3VyX2xlYWRlcl9wbXVfbmFtZTsNCj4gLQkJYm9vbCBwb3NfZm9y
Y2VfZ3JvdXBlZCA9IGZvcmNlX2dyb3VwZWRfaWR4ICE9IC0xICYmDQo+ICsJCWJvb2wgcG9zX2Zv
cmNlX2dyb3VwZWQgPSBmb3JjZV9ncm91cGVkX2lkeCAhPSAtMSAmJg0KPiAhcG9zLT5kb250X3Jl
Z3JvdXAgJiYNCj4gwqAJCQlhcmNoX2V2c2VsX19tdXN0X2JlX2luX2dyb3VwKHBvcyk7DQo+IMKg
DQo+IMKgCQkvKiBSZXNldCBpbmRleCBhbmQgbnJfbWVtYmVycy4gKi8NCj4gQEAgLTIwOTUsOCAr
MjA5OSw4IEBAIHN0YXRpYyBpbnQNCj4gcGFyc2VfZXZlbnRzX19zb3J0X2V2ZW50c19hbmRfZml4
X2dyb3VwcyhzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KQ0KPiDCoAkJICogZ3JvdXBzIGNhbid0IHNw
YW4gUE1Vcy4NCj4gwqAJCSAqLw0KPiDCoAkJaWYgKCFjdXJfbGVhZGVyIHx8IHBvcy0+ZG9udF9y
ZWdyb3VwKSB7DQo+IC0JCQljdXJfbGVhZGVyID0gcG9zOw0KPiAtCQkJY3VyX2xlYWRlcnNfZ3Jw
ID0gJnBvcy0+Y29yZTsNCj4gKwkJCWN1cl9sZWFkZXIgPSBwb3NfbGVhZGVyOw0KPiArCQkJY3Vy
X2xlYWRlcnNfZ3JwID0gJmN1cl9sZWFkZXItPmNvcmU7DQo+IMKgCQkJaWYgKHBvc19mb3JjZV9n
cm91cGVkKQ0KPiDCoAkJCQlmb3JjZV9ncm91cGVkX2xlYWRlciA9IHBvczsNCj4gwqAJCX0NCg0K
