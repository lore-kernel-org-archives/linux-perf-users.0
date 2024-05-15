Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4584E1C3;
	Wed, 15 May 2024 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752662; cv=fail; b=jAEjKsT/t5ya/YjL+R43RM3/s+VASngx12akdeAOc2m+Iyu3BKoiqY1dVgwJ0tmLvE8DDHuJOcsbk6fwZNjJRqd58Qo8GWP/4avAUSFsA+Rt9eiLzC2a2DuLhuEFi11chaXRLBPxu+xZkloImV1jaE8kofBCTJ26vGpH4xhy9lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752662; c=relaxed/simple;
	bh=SY8DuBNkqIK0de4yRMMt2mt0lVOFsqn4vQYwd5eEIOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SFoUUG5qXidOve/Eo1BJTbadgaxl1bsjzzNYeFM1ECI/aYWRZPBdagy8iz/3cluOLmqTqjxaz3cWxuUniCq+xvQK8VDdG+bgmWKXwAbWkXjG52UwDRsMsp7i4znp68ZKmbDj3n+KPATeEicv3XsUW5tLQVHWmb72EuAc6bLyjuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZtMXN4f; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZtMXN4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715752660; x=1747288660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SY8DuBNkqIK0de4yRMMt2mt0lVOFsqn4vQYwd5eEIOc=;
  b=mZtMXN4fwJbMrnG8QMFM7RX4kfAr8aWyHydHIQzcqi6Xt9O8z9QujjVN
   mc4Hz/ddbTCgrPXsLUk/umikq8E2eiZ/kpYFPpOC8lJfchCzhUI/qNFJl
   L7h+mVD/t7OcPdRG/H9yeWZ5gXY65l/RGaQ/dDmYyVUrTDIARtRvn8tvW
   cpjyQ//W7Z1wyIsoT818aAuK/U2DEwt8uFLTX9x4ZvZxi9hNPpyETm6v9
   4KcAjJa0WDWaopRvd0WDZ9Bq1tzhPkcjpr4XBjYCOaJzbX51jO7LtP/s8
   yzU0p53yi1JqOpD6dUH2AIMpLkfzVojSxVPxCF9hDXpneU3JwljxYDwJ/
   g==;
X-CSE-ConnectionGUID: 2tqaFW0HSFeA+MCNCaHyLA==
X-CSE-MsgGUID: ZPZslmCPQiqDk2/9ZEfAsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11996373"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="11996373"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:57:39 -0700
X-CSE-ConnectionGUID: x3CktciAS8yEpyH8vmTHgw==
X-CSE-MsgGUID: 56o4DkHFRJugFvU0aK4ppw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="30872469"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 22:57:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 22:57:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 22:57:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 22:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBii3kZrlRNx6wKErVkp9A7RXs44VC2rUvNhgjnmWzUKQXokaGj58KTsrqoUVAoIU1sSjuR0JATB7gURcTP3CEe9DZ5dyicOeC1fN0BqQmCo7vaDs651cHakrE0f7STn+kHBABG5R0+b6GWsoy5GICkytbVuQ2PSSGDwAdnknCXI2uql4IZG5jsShnmeca6O/ZVA7vec23u17Nj2ljaNDOhdp6jmyHefplcrYyysIYIuYgWNg3WhsRsdy42XsguVnvTHwFI31AE/vCq46aF1wGyqnioBgXEzmC/5Qb5hpJt/CfGasXJ1yfSMD1C0zlyOCw3JAZyfAwyvQkbAOk2mhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY8DuBNkqIK0de4yRMMt2mt0lVOFsqn4vQYwd5eEIOc=;
 b=Rxt7J+0taNI+g7/aA6nkFY0Th5BJMu3Vlgj8tT1iOJjg5yJ3GsS0iZanPTxnrF4l8Bc1jGSK/0f78IY85Z5+4/rsbAqnNHdjhIw6fTkmAoOobhAOesSuXWgSy764Xx4L2byh36+qDlgssGkNTs+AUL88SncFlZ8kgwS0gyfl5gWVoI5ldmKuCNbX67u8fyzv3MRTynSzJcCviOW+pHfBPOh3SLgFM3x5Xsr5si3QVdBCdh9bWZ325eFz5FcpJr5twkiUgpVi7dUQNv8dKJGJ5+Y3vRlq8sHDzM6YAOPb5PxPjJAbCi+rG+0shKm+Sz4cg9YVmCbm/zpGnoGYaGWJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CH3PR11MB8592.namprd11.prod.outlook.com (2603:10b6:610:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 05:57:36 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 05:57:36 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHagg0bJu1HXMAx+EKTfolw5tlMzLFT6nUAgAADChCAIpCggIAAE36ggAAP1wCAAStEAIAAH34AgCAmeLA=
Date: Wed, 15 May 2024 05:57:36 +0000
Message-ID: <CO6PR11MB5635CC88D0855FA485C383A9EEEC2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-3-weilin.wang@intel.com>
 <CAM9d7cjBfTM2bjkrvN5XWcXJ=OyBOU06fBN=+eWnDSdP2dkD4A@mail.gmail.com>
 <CO6PR11MB56351C2AB4BE15C5371E29C2EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjORNS9h7v6p2fg8OXsZMpeBODzTSCQNZ5zAea-baFKNQ@mail.gmail.com>
 <CO6PR11MB5635C7D8C91FEDA17EC4BCDEEE112@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chSCQViX=VjgqdVn5un0J5MpGsGDGncUyY-K4=oPvvfQA@mail.gmail.com>
 <CO6PR11MB56359754A01778EA3EA53981EE102@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cj2Zmd_FMBzf=H6K6jRmYLYuR6mpcyhC0_neTvur0=pyw@mail.gmail.com>
In-Reply-To: <CAM9d7cj2Zmd_FMBzf=H6K6jRmYLYuR6mpcyhC0_neTvur0=pyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CH3PR11MB8592:EE_
x-ms-office365-filtering-correlation-id: 9103f773-2916-4fff-c830-08dc74a3eb9b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Z3RrbW9iWE0rNXovVlJZckk2YTlURlN6K1VBY2pobXpJTVU4eFBGeTRKclNu?=
 =?utf-8?B?MzJZaUhWVndoL3dHV2ZOVFNSdnpUWG81bFZPM2EzK1VmTjdzVjZ4NzBRQlVZ?=
 =?utf-8?B?TnlWOS84ZjNNUHV2N1U2V1RnVDBZZ2o0UnJyVXJ3NWVrQTFPTGptc2orOHNI?=
 =?utf-8?B?Uk9WUHUwWG5NOTdDeTRyZ1ppT29GWE5wUXU4RVFITVNGTzl1TmNYc1htcW5h?=
 =?utf-8?B?WjJkcUk0dFlQR1BVeHByd1VlM0FLU1Z4eHBZdENTTjVaNmF1S00zZjZJeWE3?=
 =?utf-8?B?Q0wzdkNWSThDQW5OWFZiK3dtSGVRcUJTM21oSUpFeGs0dlBPaWFuOHpkZjY3?=
 =?utf-8?B?Z2h4Qm13MmJkMExUQXNiVUR0b1ltdVowalpxc2JiNFUrV09uU09xZ1M3Yk1D?=
 =?utf-8?B?M1E2TnpudWI2NHArRTQ3RGJqUW9UL3EvVnpTTE1GSXUvSkl0bElGK3NndGJ4?=
 =?utf-8?B?aUhTY1ZxaGowcE9xL0ZSeU9XODZIMHVvbEhsUitiKzRpZU5LYnd0elVEbCtZ?=
 =?utf-8?B?VE1Na082dUhOb1U2SlRPQ1ZpUnNjY3c2ZjJva1NPaHVUOXdsNUorcXNONiti?=
 =?utf-8?B?L05EMmN3Y0FoanZaVTZGQ2xYSGFza1Vid3d3Ukk0NlBFclpEYWg1eFJIdXhT?=
 =?utf-8?B?b1AwTXRJQitvNDVmWktxa29jRVprOXJwWU80NVZ4RlI2cUVJbUIzSFdXQ0dI?=
 =?utf-8?B?K2pNLzNCZytBWnd3cUZTS1JtUzhXdHZmY3llZmlGMTNtZ1krS2JyUkxGSU5h?=
 =?utf-8?B?TDI2RVZwcnJOd1VYbCtpcklLY3R4RDZ6QlZBVGVsM0RITE8wWFNhejRLSGNE?=
 =?utf-8?B?SUM5SFY2RlJ1WldsTjBwSzMzL3BUelBjMzhXRGhYNGRIcUlnNWRWV3hBWGJQ?=
 =?utf-8?B?aXB6MWNWSGVMcDRtTm5aekdNRG8yaXFKMk1zYWROQlB0bGRPeDRvbEI5eHNw?=
 =?utf-8?B?T0s3amZkQkpqRUFacjZTUDZsREhvQU1pT2NMVFl6K1UzYUdYUWxsVlNtNjRZ?=
 =?utf-8?B?dHNsS2J2eU1vdS9EcFVjVzdubURKemw0UkhDMFdmVlNmdU9JWlZieklOV0pt?=
 =?utf-8?B?RWNuWC9KUDF6dTFicmY5Y3dHRjU4UGV3WHNWMkpGYU9vWitJY2NPdVdNdVpr?=
 =?utf-8?B?NWM1S1dpWk9wWC9DRTF0QmlMcjF1SnRrT2tQT2NiMnU5T20wZW5kbmVnYWhF?=
 =?utf-8?B?S29sTUdMZ1BDZFRkU1liRFV1UHU0RSt6Rldvb1hBLzgwcDByNU4wTGpFTEpi?=
 =?utf-8?B?amhjM1JtVEF3QkVOcEhpQllrREtOQnNlT29JZDRKeXU5OU1IR0l3d2Flb0pW?=
 =?utf-8?B?WGk1OUdWYTJDS293VGVNRTJ2TG03UDFETWZUSUlTSnFEZUt4WnBYWjRYZ2xt?=
 =?utf-8?B?T1ZJc0ViS2JkZTF4cDhneE9ZZ2xxRUNoS0ZXV0x5aVJYSVc4a0ZDeEZ5S25l?=
 =?utf-8?B?Ykx3SjFqWWNYRFBjOExpVGhuUXo4d0k1VzcwdWNCblg3U242TkhWMFZHVHlm?=
 =?utf-8?B?TW01aG5WeE95QWtpbFVMUFNncFhJeFU2STdGL29TSkN5dVVxRWlTWG0zVjFw?=
 =?utf-8?B?Y0gwTjduaWhUWGZEaXhZUUtvT1BlMTZLTFpidG5lSVpFck5OMkVLTlZJeXgz?=
 =?utf-8?B?dUhIT2I5a2hqSFllRWQrV2xJVUhYdFNTejVwTXJyR05PWk40dUJNRUdDYVRq?=
 =?utf-8?B?OWJjMmxHcGxnZXpLZ1NRaWg4eG1YYVYzOVhoSHkyLy9nU1p2cFNzWnZMUk9m?=
 =?utf-8?B?NUFaTkdrVkVWMTFQaXBOckM1dFNmbTlmdTdBdG1JRXlScGwzYnlQVHFxUHpu?=
 =?utf-8?B?NzBLeVFnZE9zRmNIOWJQUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnFSN3JpRnBZMUF2ckRFT1pJZlVBNit0STgwTkZtT2FhSjUrYWZlQVpYbDlD?=
 =?utf-8?B?T2lBV0tlQnV5VGlEb3VTRFA1SEkyNVNiUjhEYjlXY3BzUWdLMDI0Ym9YVkdB?=
 =?utf-8?B?cHpCa1lnOWVGZ0hDUFRYeFhrc2RKZWV4T05NeDFuSE1laENJS212SEUvQ0dZ?=
 =?utf-8?B?WWZWZW1ESENURWhuZ3VXQllNNWsvQW9XUVBpMEs3bktTQUkwTkNNcXpPYVhm?=
 =?utf-8?B?aHlrN2diN0s0WCt6TVBUTC9sbnh2MEdYRFoxLzVsVG9zTkRhN1cxUEdtWEFq?=
 =?utf-8?B?dmppa0RvYUJLcnZEYnBwQktXb1p0bk9qeFVZNkhWNWxxZXU4WWRnTXVIQ3lC?=
 =?utf-8?B?dzhveDNxSXpmVkRselVYMnZCcDFmaWtKYnFWR2JrbXpjbjl0UkdWTWFWTW9V?=
 =?utf-8?B?QU94d3ZWQkNiU2M5MXZ2NDJnWkFROEZwZ2xvQ29ScTBKSmJUZXlNR09HMHZw?=
 =?utf-8?B?b2JvbnN0SjZFNUt4dlMzd3BERVNSTWd1ZW1GRkdLdzZSMkVaeGVWblk5amk2?=
 =?utf-8?B?RkJuYndHU3Z4ZGROZ2V3a2QvalpuSVBJWVZMQ210K3FIY1FtWGY4dEdZc1Z2?=
 =?utf-8?B?RzRyVkdhU1lPR0pqUmRXTGpHZjkzZVFTVUxkaUJoZWdyZzcySE5VUlRuMHU3?=
 =?utf-8?B?RE5pVlBvem9VYUw1YW9oZ1NYSGcvMG5wdzA4cjdCWUE0aWN4VzI0WUlUNGND?=
 =?utf-8?B?ZjJJT3JKdmxJQlN4cm5sVE03WEVQZFdtZm9YeFVTQm51dFptOUc2VERQMnpW?=
 =?utf-8?B?OXp2dFFiTE5QYXJvc3R3Y3hKeUJVODRPbzJieUNKNkl0V2dhQ0JaZnl0anEz?=
 =?utf-8?B?NG5RK3IrZEswL0xXdnIzZXVuU2JzdzVqbkwvUzNzT0JHNko3ZytYZVM2VXdY?=
 =?utf-8?B?Q2ZWUXJZK1lmdTJiTkpwK0p0dzNEYzl0UW94TFNOV3J4TllEdjJvS2xIdkxY?=
 =?utf-8?B?UlFaUVo2OERnajBZenRwN1lFd2JGZXIzTWhmUlp4ZUV1SU1qVlJkQzBkY29B?=
 =?utf-8?B?WHpWWGtSVEZtZElpUngwSnE2cTFhbzB2eW1zdmhCdFJjMjUyTmFiL0FGaEd5?=
 =?utf-8?B?WW4xbW5Kc3pzb3VNa1ZoMVl3RThSckh6N2hTWmx6WHptZE5PVjJ4MEdqT3Jz?=
 =?utf-8?B?WXVVVnUvRnJpWldXbmNYdy8yOE1EcHdPd09Pa2w3YTlpazhLMUwrOUlhZ0Vl?=
 =?utf-8?B?N051RWlQaXozeUhwd1AyMkp5NkkzOHVPQ2RzL1d3MWRHSXJjMjd0UDZKbk9L?=
 =?utf-8?B?MGt6djJ1dXIzMzdLK2U1WG9MdUdZVmhtVW8xemNQN2paM0hJMFBudU9HNGdw?=
 =?utf-8?B?T1VWMHFKQjRpWTZGOTZHWVl4Y0dMa254SU9QS3pndXFRMDJFcVRWZWRoZlFu?=
 =?utf-8?B?UGMrbWRMRFNqNUNSTTJ3T3NMQzdKc2IzMU9Cb3Q1bXNldzR6VGpMODJzaUtY?=
 =?utf-8?B?Y0w1eGkwRE8xdVQ1OFkySjMyMFJWWXN4N3MxMnZTVGtQdUphWHZjR3RIUG5B?=
 =?utf-8?B?OUI5dDY2b3oyK0drRmRXYmt6aklZZDdVOUpEWncwNFpuRTNnVVl4ZXYvMjhs?=
 =?utf-8?B?TCsvMVE0d2U3S1JpdUo1S1g4am5rd04rd2tTSVdxeTNGbVdxZlA0NHRkeG5S?=
 =?utf-8?B?amxFM2NKMnRpSjRhQzVTdng1dkZ0ajJFOVAvbDBHZlJNTHAwWXFod0p2bXpZ?=
 =?utf-8?B?ekpoU1lCa1NLbURxUE52VHlzNk5nd1kwL1FTOXVOUmtHUHdRYnZzWHA1WXM3?=
 =?utf-8?B?dEhobGNzUnh6VVdKcGpZeWlnOEszTjFOcCtlTG1EbnlraWpweFFnWFB5aTBS?=
 =?utf-8?B?RzM5Qy9jUUVnSHZnU210NTBFLzkzcng2bjlZT3VPMFl5TDZXTDRibDg3Wkwy?=
 =?utf-8?B?c2tzU0cxanc0OHBoaklmQjhBUDdrM2NEWmF5RmhkK3NkSEtKTG5nQXd1NkJD?=
 =?utf-8?B?ZjhDNmprenFBTzVkR2I2U2xGV01BSHVvUXN5eTZOREV5aHZIcEZvQ3lYNWhC?=
 =?utf-8?B?cEtoTkhPN1I5aDdTT21pcHpwb3lhR2tLM3RZZTUxVnRVTW4wNldRRnA4NGxC?=
 =?utf-8?B?NTZNY2tXRTR5YUwzNVJiTmJaYnlMM0l5WW1rcXlCbWhKa0NJRXR3MG5sclJI?=
 =?utf-8?Q?UIKSWaaXpY4L/C76kibvdQb5m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9103f773-2916-4fff-c830-08dc74a3eb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 05:57:36.0896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zup0F+01vtA1x9vDeZ30jMEeKgdFvgksvXdKiA3ALTbLfTEF5r43Ge30d2WxgNDA04fnRpHc1BPO19ugOV87gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8592
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDI0LCAyMDI0IDEx
OjUwIEFNDQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6
IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVs
bw0KPiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQu
b3JnPjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hr
aW4NCj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpv
bHNhQGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJm
LXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5
bG9yLCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNh
bWFudGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0Bp
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY2IDIvNV0gcGVyZiBzdGF0OiBG
b3JrIGFuZCBsYXVuY2ggcGVyZiByZWNvcmQgd2hlbg0KPiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0
IHJldGlyZSBsYXRlbmN5IHZhbHVlIGZvciBhIG1ldHJpYy4NCj4gDQo+IE9uIFdlZCwgQXByIDI0
LCAyMDI0IGF0IDEwOjA44oCvQU0gV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+
DQo+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+IEZyb206IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9yZz4NCj4gPiA+
IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDIzLCAyMDI0IDQ6MDYgUE0NCj4gPiA+IFRvOiBXYW5nLCBX
ZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPiA+IENjOiBJYW4gUm9nZXJzIDxpcm9n
ZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4gPiA+IDxhY21lQGtl
cm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1v
bG5hcg0KPiA+ID4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4NCj4gPiA+
IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBr
ZXJuZWwub3JnPjsgSHVudGVyLA0KPiA+ID4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNv
bT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+ID4gPiBsaW51eC1w
ZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
VGF5bG9yLA0KPiBQZXJyeQ0KPiA+ID4gPHBlcnJ5LnRheWxvckBpbnRlbC5jb20+OyBBbHQsIFNh
bWFudGhhIDxzYW1hbnRoYS5hbHRAaW50ZWwuY29tPjsNCj4gQmlnZ2VycywNCj4gPiA+IENhbGVi
IDxjYWxlYi5iaWdnZXJzQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IHY2IDIvNV0gcGVyZiBzdGF0OiBGb3JrIGFuZCBsYXVuY2ggcGVyZiByZWNvcmQNCj4gd2hlbg0K
PiA+ID4gcGVyZiBzdGF0IG5lZWRzIHRvIGdldCByZXRpcmUgbGF0ZW5jeSB2YWx1ZSBmb3IgYSBt
ZXRyaWMuDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBBcHIgMjMsIDIwMjQgYXQgMzoxNuKAr1BNIFdh
bmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ID4gLXN0YXRpYyBpbnQgX19ydW5fcGVyZl9yZWNvcmQodm9pZCkNCj4gPiA+ID4gPiA+
ID4gPiArc3RhdGljIGludCBfX3J1bl9wZXJmX3JlY29yZChjb25zdCBjaGFyICoqcmVjb3JkX2Fy
Z3YpDQo+ID4gPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIGludCBpID0g
MDsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIHN0cnVjdCB0cGVic19ldmVudCAqZTsNCj4gPiA+
ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4gICAgICAgICBwcl9kZWJ1ZygiUHJlcGFyZSBw
ZXJmIHJlY29yZCBmb3IgcmV0aXJlX2xhdGVuY3lcbiIpOw0KPiA+ID4gPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiA+ID4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAicGVyZiI7DQo+ID4gPiA+
ID4gPiA+ID4gKyAgICAgICByZWNvcmRfYXJndltpKytdID0gInJlY29yZCI7DQo+ID4gPiA+ID4g
PiA+ID4gKyAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1XIjsNCj4gPiA+ID4gPiA+ID4gPiAr
ICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAiLS1zeW50aD1ubyI7DQo+ID4gPiA+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgaWYgKHN0YXRfY29uZmlnLnVzZXJfcmVxdWVzdGVk
X2NwdV9saXN0KSB7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJlY29yZF9hcmd2
W2krK10gPSAiLUMiOw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZWNvcmRfYXJn
dltpKytdID0gc3RhdF9jb25maWcudXNlcl9yZXF1ZXN0ZWRfY3B1X2xpc3Q7DQo+ID4gPiA+ID4g
PiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ICsgICAg
ICAgaWYgKHN0YXRfY29uZmlnLnN5c3RlbV93aWRlKQ0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1hIjsNCj4gPiA+ID4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gPiA+ID4gKyAgICAgICBpZiAoIXN0YXRfY29uZmlnLnN5c3RlbV93aWRlDQo+ID4gPiA+
ID4gJiYgIXN0YXRfY29uZmlnLnVzZXJfcmVxdWVzdGVkX2NwdV9saXN0KQ0KPiA+ID4gPiA+ID4g
PiB7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHByX2VycigiUmVxdWlyZSAtYSBv
ciAtQyBvcHRpb24gdG8gcnVuIHNhbXBsaW5nLlxuIik7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRUNBTkNFTEVEOw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgfQ0K
PiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hf
ZW50cnkoZSwgJnN0YXRfY29uZmlnLnRwZWJzX2V2ZW50cywgbmQpIHsNCj4gPiA+ID4gPiA+ID4g
PiArICAgICAgICAgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9ICItZSI7DQo+ID4gPiA+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgIHJlY29yZF9hcmd2W2krK10gPSBlLT5uYW1lOw0KPiA+ID4gPiA+
ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArICAg
ICAgIHJlY29yZF9hcmd2W2krK10gPSAiLW8iOw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgcmVj
b3JkX2FyZ3ZbaSsrXSA9IFBFUkZfREFUQTsNCj4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
PiA+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiBTdGlsbCBJIHRoaW5rIGl0J3Mgd2VpcmQgaXQgaGFzICdwZXJmIHJl
Y29yZCcgaW4gcGVyZiBzdGF0IChkZXNwaXRlIHRoZQ0KPiA+ID4gPiA+ID4gPiAncGVyZiBzdGF0
IHJlY29yZCcpLiAgSWYgaXQncyBvbmx5IEludGVsIHRoaW5nIGFuZCB3ZSBkb24ndCBoYXZlIGEg
cGxhbg0KPiA+ID4gPiA+ID4gPiB0byBkbyB0aGUgc2FtZSBvbiBvdGhlciBhcmNoZXMsIHdlIGNh
biBtb3ZlIGl0IHRvIHRoZSBhcmNoDQo+ID4gPiA+ID4gPiA+IGRpcmVjdG9yeSBhbmQga2VlcCB0
aGUgcGVyZiBzdGF0IGNvZGUgc2ltcGxlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEknbSBu
b3Qgc3VyZSB3aGF0IGlzIHRoZSBwcm9wZXIgd2F5IHRvIHNvbHZlIHRoaXMuIEFuZCBJYW4gbWVu
dGlvbmVkDQo+ID4gPiA+ID4gPiB0aGF0IHB1dCBjb2RlIGluIGFyY2ggZGlyZWN0b3J5IGNvdWxk
IHBvdGVudGlhbGx5IGNhdXNlIG90aGVyIGJ1Z3MuDQo+ID4gPiA+ID4gPiBTbyBJJ20gd29uZGVy
aW5nIGlmIHdlIGNvdWxkIGtlZXAgdGhpcyBjb2RlIGhlcmUgZm9yIG5vdy4gSSBjb3VsZA0KPiB3
b3JrDQo+ID4gPiA+ID4gPiBvbiBpdCBsYXRlciBpZiB3ZSBmb3VuZCBpdCdzIGJldHRlciB0byBi
ZSBpbiBhcmNoIGRpcmVjdG9yeS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE1heWJlIHNvbWV3aGVy
ZSBpbiB0aGUgdXRpbC8gYW5kIGtlZXAgdGhlIG1haW4gY29kZSBtaW5pbWFsLg0KPiA+ID4gPiA+
IElJVUMgaXQncyBvbmx5IGZvciB2ZXJ5IHJlY2VudCAob3IgdXBjb21pbmc/KSBJbnRlbCBDUFVz
IGFuZCB3ZQ0KPiA+ID4gPiA+IGRvbid0IGhhdmUgdGVzdHMgKGhvcGVmdWxseSBjYW4gcnVuIG9u
IG90aGVyIGFyY2gvQ1BVcykuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTbyBJIGRvbid0IHRoaW5r
IGhhdmluZyBpdCBoZXJlIHdvdWxkIGhlbHAgZml4aW5nIHBvdGVudGlhbCBidWdzLg0KPiA+ID4g
Pg0KPiA+ID4gPiBEbyB5b3UgbWVhbiBieSBjcmVhdGluZyBhIG5ldyBmaWxlIGluIHV0aWwvIHRv
IGhvbGQgdGhpcyBjb2RlPw0KPiA+ID4NCj4gPiA+IFllYWgsIG1heWJlIHV0aWwvaW50ZWwtdHBl
YnMuYyAoaWYgaXQncyBiZXR0ZXIgdGhhbiBhcmNoL3g4Ni8uLi4pID8NCj4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IFllcywgdGhpcyBmZWF0dXJlIGlzIGZvciB2ZXJ5IHJlY2VudCBJbnRlbCBDUFVz
LiBJdCBzaG91bGQgb25seSBiZSB0cmlnZ2VyZWQgaWYNCj4gPiA+ID4gYSBtZXRyaWMgdXNlcyBl
dmVudChzKSB0aGF0IGhhcyB0aGUgUiBtb2RpZmllciBpbiB0aGUgZm9ybXVsYS4NCj4gPiA+DQo+
ID4gPiBDYW4gd2UgaGF2ZSBhIHRlc3Qgd2l0aCBhIGZha2UgbWV0cmljIHNvIHRoYXQgd2UgY2Fu
IHRlc3QNCj4gPiA+IHRoZSBjb2RlIG9uIG5vbi0ob3Igb2xkLSlJbnRlbCBtYWNoaW5lcz8NCj4g
Pg0KPiA+IEFsbCB0aGUgZXhpc3RpbmcgbWV0cmljcyBpbiBub24tKG9yIG9sZC0pSW50ZWwgQ1BV
cyBzaG91bGQgd29yayBhcyB1c3VhbC4gU28gSQ0KPiB0aGluaw0KPiA+IGV4aXN0aW5nIG1ldHJp
YyB0ZXN0cyBzaG91bGQgd29yayBmb3IgaXQuDQo+ID4NCj4gPiBJZiB3ZSB3YW50IHRvIGFkZCBh
IGZha2UgbWV0cmljIHVzZXMgdGhlIDpSIG1vZGlmaWVyIGZvciB0aG9zZSBwbGF0Zm9ybXMsIHRo
ZQ0KPiBtZXRyaWMNCj4gPiBzaG91bGQgZWl0aGVyIGZhaWwgKGlmIHRoZSBmYWtlIG1ldHJpYyB1
c2VzIGFuIGV2ZW50IG5vdCBleGlzdCBvbiB0aGUgdGVzdA0KPiBwbGF0Zm9ybSkgb3INCj4gPiBy
ZXR1cm4gYWxsIDAgcmV0aXJlIGxhdGVuY3kgZGF0YS4NCj4gPg0KPiA+IFNvLCBJJ20gbm90IHF1
aXRlIHN1cmUgd2hhdCB3ZSB3YW50IHRoZSBmYWtlIG1ldHJpYyB0byB0ZXN0IGZvci4gTWF5YmUg
d2UNCj4gY291bGQNCj4gPiBjb250aW51ZSB1c2luZyBleGlzdGluZyBtZXRyaWMgdGVzdHMgdG8g
ZW5zdXJlIGFsbCB0aGUgZGVmaW5lZCBtZXRyaWNzIHdvcmsNCj4gY29ycmVjdGx5DQo+ID4gaW4g
ZWFjaCBtYWNoaW5lIHVuZGVyIHRlc3Q/DQo+IA0KPiBJIHRoaW5rIGl0J3Mgb2sgdG8gcmV0dXJu
IGFsbCAwIHJldGlyZSBsYXRlbmN5IGZvciBmYWtlIHRQRUJTIG1ldHJpY3MuDQo+IEl0J3MganVz
dCB0byB2ZXJpZnkgdGhlIGJhY2tncm91bmQgcmVjb3JkICsgcmVwb3J0IGxvZ2ljIHdvcmtzIG9r
Lg0KDQpIaSBOYW1oeXVuZywNCg0KQWZ0ZXIgdGhpbmsgbW9yZSBhYm91dCBob3cgVFBFQlMgYW5k
IG1ldHJpY3Mgd29yaywgSSBmZWVsIHNob3VsZCBkaXNjdXNzIG1vcmUgDQphYm91dCBkZWZpbmlu
ZyBhIGZha2UgVFBFQlMgbWV0cmljIGluIHVuc3VwcG9ydGVkIHBsYXRmb3Jtcy4gDQpJZiB3ZSdk
IGxpa2UgYSBhZGQgZmFrZSBtZXRyaWNzLCB3aGVyZSBzaG91bGQgd2UgZGVmaW5lIGFuZCBzdG9y
ZSB0aGVzZSBtZXRyaWNzPyANClNob3VsZCB3ZSBhZGQgdGhpcyB0eXBlIG9mIG1ldHJpY3MgZm9y
IGV2ZXJ5IHBsYXRmb3JtPyBBbGwgdGhlIG9mZmljaWFsIG1ldHJpY3MgDQp3ZSBwdWJsaXNoIGFy
ZSBkZWZpbmVkIGJ5IGFyY2hpdGVjdCBhbmQgc3RvcmVkIGluIEpTT04gZmlsZXMgdW5kZXIgc2Vw
YXJhdGUgDQpkaXJlY3RvcmllcyBmb3IgZWFjaCBwbGF0Zm9ybS4gSSB0aGluayBpdCBpcyBub3Qg
YSBnb29kIGlkZWEgdG8gcGxhY2UgZmFrZSBtZXRyaWNzIA0KdG9nZXRoZXIgd2l0aCByZWFsIG1l
dHJpY3MuIENvdWxkIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYW55IG90aGVy
IA0KbWV0aG9kIHRvIGRlZmluZSBmYWtlIG1ldHJpY3MgZm9yIHRlc3Rpbmc/DQoNClRoYW5rcywN
CldlaWxpbg0KDQo+IA0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo=
