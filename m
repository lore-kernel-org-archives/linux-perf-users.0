Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9F2046A9;
	Mon,  4 Aug 2025 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309364; cv=fail; b=hk/q28CcZMlgexQ+Z26X6M4p0mTGen5tUSconqKzhPWQbzaNS1cDic7ND02X7WWnd98E8Rk/tdizcVuVPiaC8CFAAn0hn/7lLeshrLz8gGG2q3PL/wPHnhU9hV1mFQBpZP06E1MorhqTjtwTvLUFphFE/kOOX60nQNt1qXFH0cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309364; c=relaxed/simple;
	bh=/UEfibRortkyrxqD+QjnolQcLNR3oW0IAXiRxTYDU4A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fB2VpJRazpHoSvq8sVb+zBALdjguNnrRfNegxlby2mWUM6GTwCLn6YMNcjXLDquJHIyO2CV7KBOGJx8teslgizhWdIYp/jKtw0nLrXRL8Fys8CcR5L6sAC3dtckX0je88B17dwVcSf0Z4JFdMYvk5Xkoz6KkXCp0KP272qpiC9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHwpbKeb; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHwpbKeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754309362; x=1785845362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/UEfibRortkyrxqD+QjnolQcLNR3oW0IAXiRxTYDU4A=;
  b=HHwpbKebGXZWPllPNuBVBuAYFhHdBM2PYVV1FK4mu0pwVwrHsTLVFYcQ
   gGx5oTLnS9oB05d4/umUEerU3NBUSc6ktRcv1DMtXO+B2dUA2UUcQbsPk
   Qp2PEWT58G55p/J8gPgQff/0asXP6APnoRYyBBXl51F6VwyZkzqO/1z5X
   3kqHu7li+pYHgySE6wnIpK9tAkmxdA6rB5BvD7CRgB8ATaNC99RbNlA0e
   Pl7Ty4Ry9uRH9zTHKvdoDP2pvrHs92kyLPMJsKicLOaijRj3EJLccl2aF
   CRUthiLrjVusq19/idmOCjtDmZCIsJRvy3cTBo+V8hAiFVo1yJULg9srY
   Q==;
X-CSE-ConnectionGUID: rOLjfQuwQQ6NXcmG4MgsHQ==
X-CSE-MsgGUID: sJrrlQVQSxiwQChRf7xZbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56439292"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56439292"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 05:09:22 -0700
X-CSE-ConnectionGUID: 4vjI9ojhTXqyHDXha1vpjg==
X-CSE-MsgGUID: iwO2RaebQ2OMPx47Edyj9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168596822"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 05:09:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 05:09:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 05:09:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.75)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 05:09:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIMhXqeKRlm1EtJ/LUUTQAsPlHAkh/PvHrgc/KywxDqAQ9vUFQfeQ7qrNiUvhY5yhDEUuMdaQLzaC0B0pwcIF7cdaImMxgbcC41BFONbtzYT7P9SByQ3Ahs4Gwzc0PzzMs0zxzqqRqmHhnnsN6X0yJsivoXu8Lq4Y6fxoun7osMJ8Jst8jze+xt9nh9Uq3fVtaP9hczIhwDuHHZnBdr9Xt8lseInokfFrl4BzQX4rk3GuopFTwulmgBkYp/IudZsnll/okrtxGiFvWBQRE2v+seV8bNz0Qcz906iGbNRZTO0k2hLvMH6Wo0KQ++w8KKpE0/4HMbHGGwGqBcFTywPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct39mho3hYvXgjRZul9ZSo/zsVBPr6M6tMY6sJa22Iw=;
 b=RYSvpzdfQShSP7LeRXLTgwcIVjiNWkh+6SLWzNsl0mr8A2QwntSfESle6KCHljI881zmnKgbNswalZtvFCe3rjTPiXWj1oX4zHXBvg7Okc2lMi8KfatFZWCgcORwfy6S9DI9+FERNrKGJop1rPlLyhtKedjNn5musURZYhtrbKrEYOZVasiJ83kJ9MWT8hUbURvKJiwqBx2O08iUKKPAvhnAEqUuV7fZ0wjUEg06U8lfpURqYc2tEybiqh1TKurIE0SnSxyQzFkP7YUkODuO41SI4mn95Bgn3vDUqwWGnoTNgvlLOTPGS+mNqSpC58hCw5RbBQt8hMK3wMu2mpK7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 12:08:38 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 12:08:38 +0000
Message-ID: <e2cc8ea1-28b1-4dab-aa42-b6aca486dbd7@intel.com>
Date: Mon, 4 Aug 2025 15:08:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf auxtrace: Avoid redundant NULL check in
 auxtrace_mmap_params__set_idx()
To: Gautam Menghani <gautam@linux.ibm.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <kan.liang@linux.intel.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250804110602.23422-1-gautam@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250804110602.23422-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0301CA0094.eurprd03.prod.outlook.com
 (2603:10a6:6:30::41) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA3PR11MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f719dd-b453-42b4-3ff5-08ddd34fa4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDZZSTJ4bjBYVmx0dHFsSUdNQ1VJK1VwWXpxbldxZGlDNmNsNE1WL3Z2ejBp?=
 =?utf-8?B?V2orSVp1WmI1d0VHRE5YdHlmUFdBNTR6K21abXhkR0UxUWliK2ZOblM0eTVX?=
 =?utf-8?B?WHRBNWQ4R0NKWnFDT1M0VjhDR3JmSGgrVEN6RWt2SXZTdTYxUmd6WEErSGpS?=
 =?utf-8?B?M000Ky84VUNUQXdjbXNOcUNkbytHbUtIVGtlQ1VtWE1TVCtlWGcxT1FkQkty?=
 =?utf-8?B?SVVlc0EzbW5kUXU4MUswanJXY2RZQjF4MHdjUHM1SjBOaVh3cHJsNE94UXBY?=
 =?utf-8?B?QnVSYTE1d09QTHFnRjZRcjlSTXhnbGNxckNpblZVUGQxakdqY1Avc0lFYm9H?=
 =?utf-8?B?YUwxWXJEUFNLcTB0dXlCaHhTUzIySzh3eW5LNVhmVVZKQ3FkQ2s4a2o5OG40?=
 =?utf-8?B?RmtQQXFvWTM3S1RnTk5VcTBweUtzQnk0RkRoRTJESC9aZCtSYllNT3BwRWxQ?=
 =?utf-8?B?UzBqeC9JdHlCN3pVTFVBNkxEU0lHb1gyajN2OVN5WS9tYXloekd3VG44SkNt?=
 =?utf-8?B?VFV6R3BLcXhWOEd1VUJtVUg2SnNjL0pWUytldERzdVNEK0U2bUo0TmUvcThD?=
 =?utf-8?B?cVFJWGt6d09LOG1xcGVxTnRuM2RDMC9hNk5lcVpnV084ckJyZnB3VWs1UWZY?=
 =?utf-8?B?ZVhYdUEzRnNXV0paVFh1QkxSWVVUdzR6eEZxcWQ3OUs5QzNWU0I4enR3eWp6?=
 =?utf-8?B?M3JCRTNRZ0lBWVhCL21ObllvVUt1L04rVzhBcVVCaUdNNmlUVkpwTHFERHlM?=
 =?utf-8?B?S2lzaHErK0VRNWxOYmg1UUhFblJHU2pIUlVXRnNQZXR4VTE1RGlRMG43N29B?=
 =?utf-8?B?KzNFcXYrZXREOXVZQW50L1VjRGI4RE1CNTVJL3c0QUZwNGEzUVdoVy9XeG8z?=
 =?utf-8?B?dkFiRm5BbGlRcmdnRTFKNWhQMkY4QVBMc3U4NlIzMmFjUkh4YkJTRk9McWV1?=
 =?utf-8?B?Z2JpQ3JMWEt4dlZzOU5MZ2xEU3FGdVRzZlZqaXlwY2pWU2JPU3dHOTluVWIz?=
 =?utf-8?B?R3BRYnpWUC9vWHIxcThVNytNLzAySW14QWwrZVZRRm9uZHdnTnFDYXgyZC9q?=
 =?utf-8?B?dzhyRk1xZlFWRUNMcmpxczdleUtNOWhXZkk1cldTZWcveUI0SUV3V1lFQVhi?=
 =?utf-8?B?VDVYWnlDTjMxOXQ4U0VRV0pHNWVsTGxnTm41YkJqbm5sOE1uV0ZUOG9KK3FZ?=
 =?utf-8?B?TVBrQmRWejN6VmNmOVo0SHVZZDEycGpkOGZrc0NUQThwMVp2azQzRW9LRVUx?=
 =?utf-8?B?SWlJbGFWNmhJcmdMeE40VjdIL2NtdFhOcDVZcWRWdGRWbWJ2VUhhV0lmSEwz?=
 =?utf-8?B?bnZmT0Ztai84eElWZGowSHBxMzRVUGpSdU5iYWhyU2MvOVVTcEVXZzQzNWgx?=
 =?utf-8?B?ZjNEVzhGemUyb05yU1I4ZW9NY0ZyaTR1Rkx2amRMcE5LQVZmeHdZNnpWQW1S?=
 =?utf-8?B?K3RUeU5BNDhtT0pSL3pYUHFrN1R0bG03eFZ5dzRoUWp5ZkdaMkFIM09mL3lM?=
 =?utf-8?B?UW1uSHFwNjhDUDBMM2FrQ09JbWw0K1hKRFRFNGMzcnFVTjB1MFgvRmtNQnJu?=
 =?utf-8?B?SWlxRVg2Nmw5VFA0dDFZc0ZBZnd5VTJYVjY2TFAzM09ZSE9nak43dUV2T1JP?=
 =?utf-8?B?aVptZGVhekorR2MwV0labDM3Mys0NzNMNHEwSWpKQlpnaGMwWHV5REorVDl1?=
 =?utf-8?B?eVc5dENVMU9UK1FGazI3SmQ5K2ppQ3pCdmgvdm9oc2ZvUlJuUW9UdUJCMGlq?=
 =?utf-8?B?WUxVK09vRDFGOHJXUTE0Y2VVbEZ0L1BXc3k3LzlQcjZrWTNNZ3F4YW53dEZq?=
 =?utf-8?B?eE51em42QWhTYnU2c0VWRTBWWlVMZUNtbXM5aEJkVkZqcVZNdUJtZnpZREN6?=
 =?utf-8?B?ZWtxaXlFVldJb3FVUHJHWGxnc1lsWTFaREw0Q0FvY2tZNjVQZ0tCa2o2YVRm?=
 =?utf-8?B?b3o5THEwZ0R3Q0RERnRsRHRSUHVHdjRKWTFpTjNvQXZkTGx1TEVNTjRKR2Z0?=
 =?utf-8?B?S3M5dWVTMmlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0EvK3NOWmtSOER2SmE1MU1udUtmK0tZWE5iQnFvci9vekZYY0dqdHgvMjBT?=
 =?utf-8?B?bThPY3dNZGttNHlHRHF2K25GV29MeXI1bTNydERzb0RSN1RpYnJaaUR6bVJa?=
 =?utf-8?B?U3RrUm1sY2pKZ05QZzdmSUMwTmI2QkM1N2RkVVlTN2dWUnBMRFRkb0x0V1JH?=
 =?utf-8?B?bVBjRjlHVFFuM0FVd2hOWWZlbkVZMFB3V25oR1hNTGNWMVh5aUFFeldaNHZM?=
 =?utf-8?B?dXB1RzNQbndQRmk2L0UydysrOG1uVnUzQzJFWGRzeEthaVY5ZVprSHYwakNX?=
 =?utf-8?B?c3JJTGl5TWhnSUs4M05IaVF5WEJjSzNOUFZvKzNFcENFNVVKZDZHMmZadzhz?=
 =?utf-8?B?MlVWM0d3M000V0hqRFFnMjlLb2gxemkyNkJrTDg1Q1V0RjBLdXMra0JPRWlW?=
 =?utf-8?B?d2I1Q2Frb2tucGFrUXhpOXdSZnhaazZCcDZaRDlzdWVrNnZuenRpMmFra09U?=
 =?utf-8?B?ZldBNkh2MGhyTDRHajNQa1YwSmhUZkdIZnVyQnJ6K0wxSjFITFR3dis1REdE?=
 =?utf-8?B?b0dRd080b0xtN2RSM1lPbDZoTzc1VFVwZ2FLVHNIU0hyVGJYVUVXZjJYd2Vj?=
 =?utf-8?B?Mmh1QXRlR1JnandEbm1oRzBXeHcwRmc1d2F5ZDRVYkJPUmV5LzZQK2JCS2lj?=
 =?utf-8?B?WFI4MmJLOXhrUEx1TXRCMG5ON0IzWXNqZVkwdjNhQkIrK2ZTajhGU2hEOXcv?=
 =?utf-8?B?RnF1VHVRYkZ0K1BxcnJubUV1STJhYUhaL2UvQldsNEpuT20wNnl3Si9lVHMw?=
 =?utf-8?B?WkJCamlwM3JpSkdhdzJERU40TnFkcEZRa1VUWW9TRTdDek5WME9Sa3dmUjlr?=
 =?utf-8?B?TW9EMU9GMC8wWklTbCtHUldGaXhpbUZsVzNnMm43SVNzOFl6VzU4YURFSmJU?=
 =?utf-8?B?WVFweVBRSm5lM1NWRXhOWjhsMFhnWFIwQmJTYUp2bFVFNFgxM3RmN3JnQjND?=
 =?utf-8?B?VjhIRE5yNEhNTWttL3BSM0lOUTY3V1loc0NqS1lDbzg2clBTQk5BL1BMdXJj?=
 =?utf-8?B?ZGk5M0hzb2JnTDRpV0F1TzU0Tk92MUN4TklJTytQd09JcnUxdHBmK0k5Nzhi?=
 =?utf-8?B?N3JHdnRRMEd0S1NTd2VaK3RCcFRGYlByVVpKOGkwellhR3Q0Wm1hWG5PL2VN?=
 =?utf-8?B?bzVIQks1Z0JoYjkvcndTSVhQVjFJbUxaVlJKSWZRRTJtaFpyOW1DeWNmaCtk?=
 =?utf-8?B?bTFTNmxxSVFPRkdPTVRqMXc1QldWRU4yK003K1dCM1NsLzhkVnVRekVOUzFB?=
 =?utf-8?B?by8zbjVKSlBVeEJZYVVOVExVcDFBNmdoaU9oOHZQQklKSnFuWjRJWFdQWWFn?=
 =?utf-8?B?Um5UWW9RNThBS09zaXVBZWR3RVp0UXRiYUJMU3pneHorUHRPc0dHNDBUMkl3?=
 =?utf-8?B?eWZ1VDdmSGJsVzg1MElnUTR4NFVEclkwajFYQVRFRTJLRHJLRjA3SVBNdmlP?=
 =?utf-8?B?Y1pyUURZSUhGUm9JQm9naGFnTmhmYWF4TUZ0M1pXL0tlNG9CVndGVmswN3oz?=
 =?utf-8?B?OEdLQ1lnY0wzQVhxYzV2NFRMRnQxalphZndNMHhvb1F6MjNlTjNqZUdsMW1n?=
 =?utf-8?B?MEN3c09sSG5iaXNsaGJOY01QbG9RSExjNDdCbmdtTkRSYlRPTnVWLzcyeGNM?=
 =?utf-8?B?Q2h4dGRCZ3lOZStRQ0FjbnZibjdoVDdUTHpPNXdQUXpyMEhsSWZZK1Qva1h0?=
 =?utf-8?B?elFmbHZZOTN6eCtoYWNVVVZHcUd2TGRCcGw3RlNudjkwZm1SZnA1VGx1amo4?=
 =?utf-8?B?NVl1NEJNMGgrMWdWdUZBRGF6YUNGRVBDdHMwRXFGeUFJUklST1Y1ZkdrSFBY?=
 =?utf-8?B?TDVKZXhPZy9GNE1yYVBPZjNIV1FPcEdLK0F5T2IxMDZZNUFzZXIzNDZqZUJZ?=
 =?utf-8?B?Y0NFcDM2d0lpUVdlMkJEdzVzMFVLSitwN05Rc2ZINWpPeExRMm11eVEwZmlC?=
 =?utf-8?B?eFBzSVJPMmVVOHVRblFHT2NkOGVsZGp0WVhPODRwenhuTTFzakN4RU12a0Vk?=
 =?utf-8?B?Z1M0TXVWMGU1c2lkcFh3Q3Z3TTRSL1pBZUlQSjBOUmp4b0cvY0JzakN0N0lz?=
 =?utf-8?B?WkYxVXlBZFhxb3RzRlJVSnRVUGRRZFA2WUZSOUhMUHFHQnBWeXc1aGNKZUhm?=
 =?utf-8?B?Q0RyUzNmMHh6M1pNTW1GU3d4bWNYb0VKWCtjZnV6cjlzSHV4YUhocjdMY1VP?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f719dd-b453-42b4-3ff5-08ddd34fa4ed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:08:38.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IM8tF6nQw/nrrahrfS4AC835vRsMQ+fNIuecR6Q7Dcz7MdFmrPk7GAHoD0C8AFGmTtLXFt+Eb2mFdfvMhsph7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-OriginatorOrg: intel.com

On 04/08/2025 14:06, Gautam Menghani wrote:
> Since commit eead8a011477 ("libperf threadmap: Don't segv for index 0 for the
> NULL 'struct perf_thread_map' pointer"), perf_thread_map__pid() can
> check for a NULL map and return -1 if idx is 0. Cleanup
> auxtrace_mmap_params__set_idx() and remove the redundant NULL check.
> 
> No functional change intended.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/auxtrace.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index ebd32f1b8f12..5e437133c753 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -185,10 +185,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>  
>  	if (per_cpu) {
>  		mp->cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> -		if (evlist->core.threads)
> -			mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
> -		else
> -			mp->tid = -1;
> +		mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
>  	} else {
>  		mp->cpu.cpu = -1;
>  		mp->tid = perf_thread_map__pid(evlist->core.threads, idx);

