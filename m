Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA3309EFA;
	Fri,  5 Jun 2026 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686507; cv=fail; b=NDLxhXYZZpm7GMCk+dui8vDjFsm4Y/tBiPZKEkDE0eZY+3PPOstxvHKsSOf9VbCQIKHBvyDtrC6fQ3crDawhV77gANJTQkhxc2vCeGs6v82xgNVvc1SnosVaQgfxKccsIaNoVaPdU15UOXhskGZnL6m+2uGoQbm9kTbiNUPBCRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686507; c=relaxed/simple;
	bh=xpofD5YnTNYDzDJWEpcHLKrXrkW/cGW+OrSWgNI5GHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I6CtNjl4jLBVTMz+0ALj3WfX2aCwLTAn7qTLdubvuriFD9q19MZL2bkTiDxlcpG4gnJojpfO2NgL+cVwLK6umUXc31vdDLe6M+UwEdKWdlxI1NuDUcFpotrYGF7pyl7w2wSEgDPhvn1IwJIbpCUkIAfsF83TTPWGyG9mY3up/4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNVp+WPZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNVp+WPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780686506; x=1812222506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xpofD5YnTNYDzDJWEpcHLKrXrkW/cGW+OrSWgNI5GHU=;
  b=GNVp+WPZv9ChC2v26VaLIJpHuPlr8sjTt0gznz685aqbd2MptpX4NvZX
   1SYufeEIYmTYZFFnbvuMvh78svclKJy53xnBkP6NRBULj+yrlLu7VxI5J
   YcstW5oWTpdclziYJaz15sIKOLJTfwWSsYflj3cLm5OmGsWsTr3DnZaMJ
   iPizoefnDsKAFfXMfimneS/ABd40u88ZS3ub+AGirJkPJbM+GyZ3zMsx7
   aEpJdNPuZeJd4BsAzAQhb1kS+dUpJRSqgEo76XBGyM92zA144FrxEVlfO
   pPW/SKnsbQr/2+rLh3cFX1T5kqJ/yyWUn7GghXDhSL653Q7zP1wbf/nw7
   w==;
X-CSE-ConnectionGUID: UoAbnWmpSf+nJ5jg0oM0ig==
X-CSE-MsgGUID: JscdECzOTamc5ObdRrRYuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="85378850"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="85378850"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 12:08:25 -0700
X-CSE-ConnectionGUID: tirAivpjQOmPYhfmElQqvw==
X-CSE-MsgGUID: aBazDmTAT9iyqYnWoKFVWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="243819543"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 12:08:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 12:08:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 12:08:24 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 12:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJnZMZxJwHVt4miZn5WCCxaWDVTlHo41qMwgno20+f1l5xR/FJf4c/m4IoQ4409921tXTtYVE/XB7RjW79qszll3qZJtE1gyWcJdL9hKloEpbc3OKipn01IrHgKwJ9MW4GaAhyJVcyDwvkqDSiKcA8ybrVm2UkMr5XNI+VwqvFdDraCMbcxEFC+HSdxzfe9r7bF7oBnbVSPCuK1NYTT0k1ETeo6ex8Wx/BTRkXKgrgUufEZqQYsaBPMRgQAvh1euni7zqpq5sbF8LAKJSOWAQCf4D6VxsoG5aLGLJqrZAHstK7vXHVIWN5heohH5QUTa6OVBdEAxc8bn7FshHAARMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpofD5YnTNYDzDJWEpcHLKrXrkW/cGW+OrSWgNI5GHU=;
 b=h0Iy/vJHn/biQ1/f94bK+WaoebwAymyFqGfd1lHQkwL5Cbg5CuE1ebHAuA+zUlauBDfe6Y62lp2i9K5EbSXhhu7+O9XPxzL/NieGADPic8yuFEyHhfCVvrwC50A1n207XFEqxko76H9E+n1+9dJhR63jj4G/jZCAaqMNaYPtuaGKvUDF5yxWdMKlCJoV+GU+IUupCteiUCwie/aOjDPvH89P1ELGgfyzXzJShPZmJ/LdkzO9eGsRP8uhCm4c9nSM8vGGBT8f8pg67q1bSjXJFR9Bda0NbJDZXAuVIUFuXdgV2hGj9iRkTJqK+IJchmig1SlrCXfWDG8eMnsUNT2ovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by IA1PR11MB8198.namprd11.prod.outlook.com (2603:10b6:208:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 19:08:20 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 19:08:20 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
	<irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>, "Chen, Zide"
	<zide.chen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>,
	"Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [PATCH 8/8] perf/core: Fix kernel register info leak via hardware
 skid
Thread-Topic: [PATCH 8/8] perf/core: Fix kernel register info leak via
 hardware skid
Thread-Index: AQHc9IkUKVh3Fs/mn0mMhApO/B4yobYwVEMA
Date: Fri, 5 Jun 2026 19:08:20 +0000
Message-ID: <6e3a013359d6d0691a9ed3294520accaa36592c6.camel@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
	 <20260605011136.2043393-9-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260605011136.2043393-9-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|IA1PR11MB8198:EE_
x-ms-office365-filtering-correlation-id: 38d0b741-7a12-460e-2da3-08dec335cf13
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|10070799003|11063799006|921020|56012099006|4143699003|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: Hbn2Ov7/zGV9L+LGHrRl/h3BDveoeTFFvfCM+4BQhqZOBYJEPcTZfahlEOb+KSVpMpoYnD+J2i9qNIz0+35owXk0Rlzd6GPR5KgmfkXFoSmDkBXEs68jOvcXL7DdWzrXNFt+RZh3aMQrqcFe0h65gidnCXJ3R8fArSDqFnWcPA4gLU5GTIkOdg4LVf8goaUQ3A2H0UciKFK46YHIoK+UniNBrkMArDMq9CpvjAaS/N0P2iO+l9im81DIEjVssctz1A69wcwr9utlQpByT6m8a2HyAU5v+meKYQCXBL4AHsmKiVhm9a5uFpjxX8TAk78vd/Q3PLYX5bkUY/RHvDJT+bd4pk3Pl0fhG4GCUQthXF83SpWEqMqGg7XImjOQFim5CXpHNnBbndzfRJPyix89oFbY3BNh7TsnBrXh1q3TMtiQRBYetSKc7CDsAksQt38Cu5FjAfkLrcPB6HP3Mk76/UDRMR2L1wuIyMrBK4X+y87bn+LH9xYIJlOA166Htkg25bo2ZWgvdZGwKLKQC55qWyNpbH+72TG/0pCyXEU0/lGKvCQTa2cxikfSx70cJK1WPlkpJKJiCce79zDBlok41NvVno7KiQQu8e61LRbkxHDosWuKNSfsn6jZnUyH4cB2MwM749xB6lvgDMACsX2O2a07hqmE6P13MZv3Kjv+l8JgQq/kzqMyo3nSSuMGrtO6LwsunJEEs6ZuskUxU/LVPhnumUxByzLbjKoiSadCIJdcaqjCbtDq+JNCYBCTh3L67S1Vo9DWuoqsgMA+aD1l9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(10070799003)(11063799006)(921020)(56012099006)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHV6Ukd0ekVGZWhvc2pFWVVobXBRbk5sWEorTnYxeEM2OWdMOEpGL2VTNjVz?=
 =?utf-8?B?b2tnc09GUTRmSSs5RVE1R1pkRTEwdmhEOXZIeVpsbWZXSHU4Nm9hSkRlc3VJ?=
 =?utf-8?B?RndTNGxVcDJhWC9CNDZEaDJIOFp6NStxZE5EdmVoc25vWUVQWG9KSHhtUDJ4?=
 =?utf-8?B?dzRscXJ0RS93V2RhQW5sR1pXeThUSE41SWZrUXplc1h1cDNLYUVtSHhDbHpl?=
 =?utf-8?B?VXdZM3drQ054RllTT0pqYUZqc0JNdjIzK2pkSE5YcEoyNEJJV3NQWmZuVXJX?=
 =?utf-8?B?dDdBZDNPaDBHOXBkNW9UVWFXQlh0RmtZVDRrOVBrU0hXN1RySDU3aXc3bWxD?=
 =?utf-8?B?c2xWSnoyd1VIN3Y1MmF0OHRDYUpOL25EaWVacTdyRE9EWVZlYWE2V1A1dTIw?=
 =?utf-8?B?TmhKeWVhbUNFdTZrT2tNb2JTdWtmd0tiSU5VT1F6WFY2cUE3Qm1oZXN2azNF?=
 =?utf-8?B?dXFKNkRRenh3RXZmcjc3cHR3VFNsUjFHa3NOTEJkT2d3NXZ5UlU5bDR0NHFU?=
 =?utf-8?B?MVJSMDM2ellTQ1Q3blZmSTM1MWFQdzFHQlpCd1VrTVhwMDE4MjBsYnVoWnZH?=
 =?utf-8?B?bzJ0cFkxTkJ5TXVxVHZLaUNpeW1qYktvK2oxenpTUXZkQ3gzUWMzTnlrbFV2?=
 =?utf-8?B?SHljSmJseGRTTWNReXRyeWdTeFNiaWowLzkzcExxMEgwTitGUEo4V2xsY3Jh?=
 =?utf-8?B?cWcxdklkdkdESnJHMzRRaE8yY0d3eElvTURIOW5VQUtwcm1wTnNSQWpxbyto?=
 =?utf-8?B?Um8yM3dScGw5Q1g3T2tHeFRJL1gwVVk4Wk44K0Ewd0hLVFpyTjh5VXRVVkU2?=
 =?utf-8?B?QnRPOXYzUkljZTFMNkw1OUtOZEpPZEtFc2JDZW1yTGRFOFgxckRPa0djd29h?=
 =?utf-8?B?VGRrWDJYRTJyeFJ0NnEzcUtXWGJ3RlR1TjJGc1JiUStraG9URzJhdVoyVE1z?=
 =?utf-8?B?UXJ6QiswTlJEaUMxUklEbHlQNkF0N0ZMNThhWnFpK3krQ2paWEtWQW4vcXRQ?=
 =?utf-8?B?UUdiREsyUXZjUUZFc2dmMWNYbWpkV2wyMkdTVjc2Z1dpem1jVytjTFlINXFU?=
 =?utf-8?B?eUFUQURoWmNIb1oydGRrZkNwbFVRaExSN0ZwVFlQd1lIOXRMeFloekxSczNm?=
 =?utf-8?B?RlA4aW1ydUxLenhOYnhpSFErRVRvYXVoYzZsKzZYWVNYUlNya3J2V2RQd3N0?=
 =?utf-8?B?NlY4QldXS2s4aEhEODVCeU5BY1o1NUI2cHpESUpBTnFWYkIwZXFjSWpqMndL?=
 =?utf-8?B?TWJFVXVMZEVueTdUWjVEcXJyY3BGN1R0czFtVGNmc1NhY05OZmlTTUlabnNZ?=
 =?utf-8?B?dFJpSlB5NmRBdXdYOUlhaHUvUEJsemlWZ29KUHNaWlpwTVAvMzRsMGVmbHRV?=
 =?utf-8?B?Q3F3WWxEYXJya0orSnZHVFkyb2x0T0MwYjh2QzFRelpRVmJIQWdNNm1kMU5o?=
 =?utf-8?B?V1VrN1YvTG9IN2l3Wm1EQW5Qb055aW0zTEttbndoMDl4bjlmMXU2Mnpmakk0?=
 =?utf-8?B?K2s2bjVmT2hBemMwYWEzN1pjaXloYnBUSTNObG9OZ3h2bGNoVlNOemw4V3Uy?=
 =?utf-8?B?V3NmcGwzRU5SS0lGR04ra2tySzBFMU8vTzlxdU11TisxMkY1Y0E4ZlhxMlhO?=
 =?utf-8?B?VTVha2NDY2ZrL0xMWnhkMkx3ckhzYWtZRDJjUGRMb21Hancrb2hkNWQxaCt3?=
 =?utf-8?B?UktJTWZKVzN6WGx4RUk3Wk44V0pBNDd6Wmt1RVpXc29NZ0E1aW5STlA5OEMz?=
 =?utf-8?B?MHhtSUZWc1dRaXJ3RklRbWtZOU1QMG1HZ0JvelNQZGxnQVpQc1dMV2dPWis4?=
 =?utf-8?B?Ti9QeHlNdDJmb1hnWUxWSHhscHF6SURJL3J0L0lhaUNuTkJ1R0d4TGhBMmls?=
 =?utf-8?B?Mm1DQWpwTlNLVkZ6U3lWbDFEYjN0QnpJNEJFRFUwcVp3Sy9YQmRaMkNyK1Fj?=
 =?utf-8?B?UmFjSHpkWHVEMDg2UlpTUXNBV3ZXM3RqOWZBNm5ENndxcUQwSVdjSlVob1Fk?=
 =?utf-8?B?QXF5TmFyWDY4NnFrc2JuZk93YWlTdkJCMmVlaGRXek9oQ1ZDM2J4d3hxN1Zj?=
 =?utf-8?B?aTZ3Z0ZhV0Njend2c0FCd1I5NU5SdDRpU292Y0Rvem1uTzVPR2RHbFhjSEhm?=
 =?utf-8?B?dTJRM3dWUlpCYVBNNHVEb1NGdnZQc1J2OEhxWnBzUnhpdkZOOTlQeFNCamdw?=
 =?utf-8?B?eDRkOXB2eEpQUkk4UUN0Tm9zTGQ0K0gzREJGNnlSekw1bWQyQ2RlTzZ5bng4?=
 =?utf-8?B?ZEFSUTZONU9WZGxTQ3ZMNHhYL1VHV2hLKzAvMjlqMkd6bm9weVF1bVRsRDdp?=
 =?utf-8?B?K1lqc2hMSVd6T2Roa3JkL1IxM0ZXdmd6TnFNdWl1b01SWFQ0L2x2R0o5ejhO?=
 =?utf-8?Q?bLPxk0Mz1JlshicMUbta039Ha4ytr1jjVcyM6kUK8/WOX?=
x-ms-exchange-antispam-messagedata-1: 468pAzATJQ5O9g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CA707229EAA48449F964D4A9219012F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pr70cPBHFRVp82idq9yF1EZuzFnYuxwvJWr0K1PG6qimyF9AWtCgJOdotXNFdqZhjbBVpuA8/yJQDaFKZdZbvo8M2vMrWyhG/I0k6uuGQFLfs45s0AclDDs8alBVHb61fwIbAVMl6ON/VhITCPN2cJ3s36zlVfFaB7idD3UoLB5dX2DgRPifr4/6yPi5CX1wXFGMDfLFOQADNS7YXalRz3tdco12X85CWTg6NcxErbj2P0qAgGZjGYI9Q5xdqy1wjAQ4nb8g4aQF2AiPLy5q7JUXqQ9yFzur7q2FHLV9ku2BZOqTKoJUczm5XR0C/+YfDu/RRZwJP9YWdkUsxihRQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d0b741-7a12-460e-2da3-08dec335cf13
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 19:08:20.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDHhng7UwLe6OiG1dXrFufvVV78sww1a1vdsnjBxvnGiGJZ7QlVppaW8R6dMgXOo5OL69IcjdT2h0CiMApcyEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8198
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDA5OjExICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IEFu
IHVucHJpdmlsZWdlZCBoYXJkd2FyZSBwZXJmIGV2ZW50IHVzaW5nIGV4Y2x1ZGVfa2VybmVsPTEg
Y2FuIGxlYWsNCj4ga2VybmVsDQo+IHJlZ2lzdGVyIGRhdGEgdG8gdXNlciBzcGFjZSB2aWEgUEVS
Rl9TQU1QTEVfUkVHU19JTlRSLiBEdWUgdG8NCj4gaGFyZHdhcmUNCj4gc2tpZCwgYSBQTUkgbWF5
IHRyaWdnZXIgYWZ0ZXIgdGhlIENQVSBoYXMgYWxyZWFkeSBlbnRlcmVkIGtlcm5lbA0KPiBzcGFj
ZQ0KPiAoUmluZyAwKSwgYnlwYXNzaW5nIHRoZSBwZXJmX2FsbG93X2tlcm5lbCgpIHByaXZpbGVn
ZSBiYXJyaWVyLg0KPiANCj4gVGhpcyBzZWN1cml0eSB2dWxuZXJhYmlsaXR5IGlzIHNldmVyZWx5
IGV4YWNlcmJhdGVkIGJ5IHVwY29taW5nDQo+IHN1cHBvcnQNCj4gZm9yIFNJTUQgcmVnaXN0ZXIg
c2FtcGxpbmcgdmlhIFhTQVZFUywgd2hpY2ggY291bGQgZXhwb3NlIHNlbnNpdGl2ZQ0KPiBrZXJu
ZWwNCj4gRlBVIHN0YXRlcyAoc3VjaCBhcyBhY3RpdmUgY3J5cHRvZ3JhcGhpYyBrZXlzKS4NCj4g
DQo+IEZpeCB0aGlzIGJ5IGVuc3VyaW5nIHRoYXQgc2FtcGxlZCByZWdpc3RlciBkYXRhIGlzIGRy
b3BwZWQgaWYgdGhlDQo+IGV2ZW50J3MNCj4gZXhjbHVkZV9rZXJuZWwgYXR0cmlidXRlIGlzIHNl
dCBidXQgdGhlIFBNSSBjYXRjaGVzIHRoZSBDUFUgaW4ga2VybmVsDQo+IG1vZGUuDQo+IA0KPiBM
aW5rOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MjkwODU2MTMuQ0NBRkIx
RjAwODkzQHNtdHAua2VybmVsLm9yZy8NCj4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4NCj4gQ2M6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IERhcGVuZyBNaSA8ZGFwZW5nMS5taUBsaW51eC5pbnRlbC5jb20+DQo+
IC0tLQ0KPiDCoGtlcm5lbC9ldmVudHMvY29yZS5jIHwgMjAgKysrKysrKysrKysrKysrKy0tLS0N
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvZXZlbnRzL2NvcmUuYyBiL2tlcm5lbC9ldmVudHMvY29y
ZS5jDQo+IGluZGV4IDc5MzVkNTY2Mzk0NC4uYjczMjZiYzNhY2QwIDEwMDY0NA0KPiAtLS0gYS9r
ZXJuZWwvZXZlbnRzL2NvcmUuYw0KPiArKysgYi9rZXJuZWwvZXZlbnRzL2NvcmUuYw0KPiBAQCAt
NzgwMCwxMCArNzgwMCwyMSBAQCBzdGF0aWMgdm9pZCBwZXJmX3NhbXBsZV9yZWdzX3VzZXIoc3Ry
dWN0DQo+IHBlcmZfcmVncyAqcmVnc191c2VyLA0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgdm9p
ZCBwZXJmX3NhbXBsZV9yZWdzX2ludHIoc3RydWN0IHBlcmZfcmVncyAqcmVnc19pbnRyLA0KPiAt
CQkJCcKgIHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiArCQkJCcKgIHN0cnVjdCBwdF9yZWdzICpy
ZWdzLA0KPiArCQkJCcKgIGJvb2wgZXhjbHVkZV9rZXJuZWwpDQo+IMKgew0KPiAtCXJlZ3NfaW50
ci0+cmVncyA9IHJlZ3M7DQo+IC0JcmVnc19pbnRyLT5hYmnCoCA9IHBlcmZfcmVnX2FiaShjdXJy
ZW50KTsNCj4gKwkvKg0KPiArCSAqIEhhcmR3YXJlIHNraWQgY2FuIGxlYWQgdG8gUE1JIGlzIGRl
bGl2ZXJlZCBhZnRlcg0KPiArCSAqIHRoZSBDUFUgaGFzIGFscmVhZHkgZW50ZXJlZCBrZXJuZWwg
bW9kZS4gSW4gdGhhdCBjYXNlLA0KDQpTb3JyeSB0byBuaXRwaWNrIGJ1dCBpdCBtaWdodCBiZSBi
ZXR0ZXIgdG8gc2F5ICJIYXJkd2FyZSBza2lkIGNhbiBsZWFkDQp0byBhIHNjZW5hcmlvIHdoZXJl
IGEgUE1JIGlzIGRlbGl2ZXJlZC4uLiINCg0KT3RoZXIgdGhhbiB0aGF0LCBMR1RNLg0KDQpSZXZp
ZXdlZC1ieTogVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQoNClRoYW5r
cywNClRvbQ0KDQo+ICsJICogdXNlci1zcGFjZSBzYW1wbGluZyBtdXN0IG5vdCBleHBvc2Uga2Vy
bmVsIHJlZ2lzdGVyDQo+IHN0YXRlLg0KPiArCSAqLw0KPiArCWlmIChleGNsdWRlX2tlcm5lbCAm
JiAhdXNlcl9tb2RlKHJlZ3MpKSB7DQo+ICsJCXJlZ3NfaW50ci0+YWJpID0gUEVSRl9TQU1QTEVf
UkVHU19BQklfTk9ORTsNCj4gKwkJcmVnc19pbnRyLT5yZWdzID0gTlVMTDsNCj4gKwl9IGVsc2Ug
ew0KPiArCQlyZWdzX2ludHItPnJlZ3MgPSByZWdzOw0KPiArCQlyZWdzX2ludHItPmFiaSA9IHBl
cmZfcmVnX2FiaShjdXJyZW50KTsNCj4gKwl9DQo+IMKgfQ0KPiDCoA0KPiDCoA0KPiBAQCAtODY5
NCw3ICs4NzA1LDggQEAgdm9pZCBwZXJmX3ByZXBhcmVfc2FtcGxlKHN0cnVjdA0KPiBwZXJmX3Nh
bXBsZV9kYXRhICpkYXRhLA0KPiDCoAkJLyogcmVncyBkdW1wIEFCSSBpbmZvICovDQo+IMKgCQlp
bnQgc2l6ZSA9IHNpemVvZih1NjQpOw0KPiDCoA0KPiAtCQlwZXJmX3NhbXBsZV9yZWdzX2ludHIo
JmRhdGEtPnJlZ3NfaW50ciwgcmVncyk7DQo+ICsJCXBlcmZfc2FtcGxlX3JlZ3NfaW50cigmZGF0
YS0+cmVnc19pbnRyLCByZWdzLA0KPiArCQkJCcKgwqDCoMKgwqAgZXZlbnQtPmF0dHIuZXhjbHVk
ZV9rZXJuZWwpOw0KPiDCoA0KPiDCoAkJaWYgKGRhdGEtPnJlZ3NfaW50ci5yZWdzKSB7DQo+IMKg
CQkJdTY0IG1hc2sgPSBldmVudC0+YXR0ci5zYW1wbGVfcmVnc19pbnRyOw0KDQo=
