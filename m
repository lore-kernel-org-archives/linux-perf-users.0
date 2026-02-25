Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289D433B3;
	Wed, 25 Feb 2026 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771989257; cv=fail; b=ruHPoRaTJGhnDNKPXhfXnkgOMrZ1Fy0UtthqiGFr4BKkPOtyFC55ASwdlAAH66ygxed+xTIoxVi1Ah1ivBZr/S8vGJ2S0H2KWm90km9wKVVZ355Giku+aGbuMOzlvgC+jseSYLkUN88G6+gVHepBZ0CwKOgCN7Iwu5D758mJOYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771989257; c=relaxed/simple;
	bh=ik4hUpfs3FrnG0jlQ++0WkDR4JB4gM/l/ccMTN7DhEs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fq7EKoO/8AaPE5WFubApUbZAvHG2hblqIFA4uGE75WE8eUTjN70MmvwuPID/MbhJJALJZ5+tyl0BCaVmSNDat+IV9E3vuzGRyYmrFkjF2pwAK5fAkNiMEeN7xWhet0SYmZ/tcSeBUGjHC/c0nrp5AddUH/Ccr5s+Vm3Cg2s/UWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNMLUz7f; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNMLUz7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771989256; x=1803525256;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ik4hUpfs3FrnG0jlQ++0WkDR4JB4gM/l/ccMTN7DhEs=;
  b=HNMLUz7ff7yDFE2Ube8gyYyvfftygcLOikjaVIUcEnfggCR/kxmVaZwH
   s6MfBLfJ/WTBQ82qefRSv4+xny//0YEDYo6Hsyl3+JGl6yYxGxN55PofZ
   QJAhOiSb0ThMDxl8WF8aIXVrluimMWja+M73XoL/XID0Hg+FK/0VwPVK4
   t9VGhC/CAk5ZSlFtnDV1zAEARMjzquSZGAUJ42BHDCCSxGqkEHv8ZKdrS
   BgMJAryK9NNtsYmSOwjUaUfAm8sWrPmhJO0SavE70KAAfPlRifGPG37sq
   CuKCjG8Ubh4+DBOPHleO4rXW9P8iGlybwC/1exqVWFOix8mxE7jmri3yq
   Q==;
X-CSE-ConnectionGUID: NzcIxZBDR7GM7wx98Nm9RQ==
X-CSE-MsgGUID: iVUZcn3oSVS2nxrO23HkNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72922948"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72922948"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 19:14:15 -0800
X-CSE-ConnectionGUID: BpeKqK0DTES7LRAQELKq2g==
X-CSE-MsgGUID: OCxU5DVLRIKSRu2RkyE73g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="214911249"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 19:14:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 19:14:14 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 19:14:14 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 19:14:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+bAPrGYe2XLkPr10p4lK5vHxQxSQfGFufZAyZk0+7Cr/UEBfWWaTIVl9avH2ttgUW5+7LsIM9hdtWM4ctQJIh84YR38gL9rNXXVF7psZOPFTxch3Oy5StyihGUdYXkl97vG6rylfw/CxHWxmIALePYjzUZWCLGL8Rc6AgkDFKX9hYbVlkGNHGPyL2Fzepsr5BGp86BJV3O92bZ1P2R/cJhFbB4tgfH/02GOKA/DGWFeb32Tn9Qc/yMxeYhotdPCeFzdmQG37zRcDQGdi38c6CHbC6G1e6ZbHpA3aYHo3nbb+6Y9tHQ+N61BhH+ZI15r2qZh2+L3rUCeYflkNepKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z+wEEWzWFJWe0OA+2LIAroLOHVw8OiyA5P6PrcOZvM=;
 b=yGcgWGBPWxzRQ3+LC1P/MB8Y5ZV9Ca2Mzzf8qEp9eH5GabyeT8sk4P/uFULnx2PuLME8C9gvMKxBGKwSz/JcTEuvDV6ZtgE+tCxwNENCzmRB2wipbmhk7/XyW9Ys2ehgLl9aEgkxEYm9gCUUvNMm72GIC5e8VDdyLr+Y3p53xo9JFRt5NGHL92b+HDGjBiztbDMnWiF9jAkpyMXqbU2tW+iZ4t52uloqcPwB+Dx1HqaGXMt7UTh8dFtJAyY/4De8BIXzPadJCWfqoMD3N9xdZleJTCm/Oc8HwSqFvzz2s2c0Bjlcl5HOu1UbOF7Ba1U135vnAswSRknWCkx9iSZzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH8PR11MB7048.namprd11.prod.outlook.com (2603:10b6:510:214::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Wed, 25 Feb 2026 03:14:11 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 03:14:11 +0000
Message-ID: <5fed09bf-d20f-41b7-a280-06e4f32ba524@intel.com>
Date: Tue, 24 Feb 2026 19:14:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 10/22] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers
	<irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
CC: Mark Rutland <mark.rutland@arm.com>, <broonie@kernel.org>, Ravi Bangoria
	<ravi.bangoria@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Zide Chen <zide.chen@intel.com>, "Falcon
 Thomas" <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, "Xudong
 Hao" <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-11-dapeng1.mi@linux.intel.com>
 <c287e7fb-d504-46fe-b6dc-af28c3532be6@intel.com>
 <e57a249b-ce70-4f5a-86f5-cd86bc477546@linux.intel.com>
 <f48500c5-dfaf-4ca2-9f9d-3d3b1e9f2299@intel.com>
 <a8a35490-994c-498a-acab-478795c868b0@linux.intel.com>
 <e1e05b38-6a7e-4e09-8044-b71e4f6ffb86@intel.com>
 <7f88834b-4ebf-491b-9219-4c1170c15fe4@linux.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <7f88834b-4ebf-491b-9219-4c1170c15fe4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:a03:54::45) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH8PR11MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: a803c7b2-ac2b-46ef-621d-08de741bf29a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXEzb1BHTlYyYlBGZUU2KzBXWXVFQ3VUM3BvTzU3aVU5ZFlXaVBVUmhsN215?=
 =?utf-8?B?a1hZb0VqaXhLSlN4WTB5SFlUVk9PTzFnbnFKeTUrcDN1Zk9HUnJGeGg2QThz?=
 =?utf-8?B?WmlrL3dhem5QcUZxRDdiUXUrK29vTFJEQlYxM2xuRWI2blJhYjMvOGFGaW9q?=
 =?utf-8?B?eG85ZkhIVXVEVkFBOEQ5clAxSktNRTVZSHVmOWdwT01qTXNxUmY1WG5mQWt0?=
 =?utf-8?B?N2lVbDFXSW9SM3pqMlo4Yy9nMEtBbXdmNEZzK29MQ0ltd281VzVpKzRxd0VW?=
 =?utf-8?B?ekNPZzNmY2QzMkRscUlwOWN1YkRFQkkwU0tscC9mOXM4aHZQdU4zRXM4SHRP?=
 =?utf-8?B?eHZlMDZLWlhHNEpNVHRya2ZibGxxY3Vsc296Q2Zxa0VuU3dSZVNYSGtSc0o1?=
 =?utf-8?B?c0RiT0lieHl6N2xSajFrd2FOM2dFc0NUQXJIcTBLTEdTVlB3VlVmS2h4YjVC?=
 =?utf-8?B?NVFHRXgrRk9NOEs3TFQ2dW1CT2dYR2xnVzYwTE1rbVArZlAyK1hiUklCY3BZ?=
 =?utf-8?B?Q1FGdWs1cHZqa1JQb29rQWFBWXlMcDlsN2FuMCtkbjdoMzdmNTI0QXF1Mkk0?=
 =?utf-8?B?QVlNcnZ3YU5rR3FQM0RNZ2pUL3Y0MktrRFV5djBEOXdoM1ppcEJUWXIyczVR?=
 =?utf-8?B?NHVBR3JKSFNrTm1WTlBiQ0E2eXQ2ZWRtZk5KMlA4M0FiNER5aTR3STRFUENF?=
 =?utf-8?B?dTBCSjcxcExpdGgwOVgvU1Z4czlldDNpbWY2cVdPZVQ4dk9pK3NTdkpZZjNT?=
 =?utf-8?B?cUR3bTdxOXBxbjhFL0tuSDIzcUdzNTdDdFoyeFdjRVVnRC9IQldRQ1Q2S25C?=
 =?utf-8?B?S0pBTWM3SFI3OXZ4cDMya3RkT3d1YUl1QWwxdEdoN2RwbnJSRGZkM0V2b3lj?=
 =?utf-8?B?eHpqblozYW5VM1YxRUFNakxNV3JFaUJRc3BXTkdjOW1sSlVnMUdrOVgzZ1NW?=
 =?utf-8?B?a3FoUzBRODU5aEhPZnFEV081N0VndFVCdFBMaFRLbnZNL2hOQzgwdE5BOTla?=
 =?utf-8?B?dzFmbCt0M25qNDdmTitzR2VxdzVOVDlGbFpyZEtzamxVVi91Q011dUo3WmFm?=
 =?utf-8?B?eDBLc2VNV29sWnRmMVczbW1OREFHZ2o3TjdNdnl3eVo0QU92R2pYRC9Wd001?=
 =?utf-8?B?OXJWb0hNdThrdHBGU1NFTU4xTU1YRFRhcUNvOTgrR3l3dHVOdEtKMFh2NzdM?=
 =?utf-8?B?eWxXYW1rTGg2R3hRcTl5REF6d1l4Wnh2Rk9RcjU2WGZEQlg4TFlnUTd5UThi?=
 =?utf-8?B?TVlHYndWVHJ0R2dGWEtvMnRZd0huSVdXeW1QNTRINHNCVloxK3VWYnBCdXZU?=
 =?utf-8?B?cDJUeTdBcjNjMVVpaFdPWU45aHVSam5iSzR6clJLaWd2dDd2VjBabmY3MzVD?=
 =?utf-8?B?N3RGcnl1R1FRRTNpZDFtOFFzbm1QQllLeFdDVE05SERQMEcxQmpySE9la2FZ?=
 =?utf-8?B?ZkxuYklWd3pUVGNBM09MRitwRGJIczBwRFhBSEwwN2lnZmF6MU91eUJ0OGRT?=
 =?utf-8?B?UTVrUTJ4cW54NFA4L1dhZ3EyN0xzOFdiTkQzbjZwOGJJaHcvT1NsMlgzNUZX?=
 =?utf-8?B?U1E3RWhCTG5QTzg2aGEwVWxKV0R3cXNaRlA0VTM2encwYW5mb3FlY0VsUDE1?=
 =?utf-8?B?K3F0U1dMeUNqd1A1QkNId0dobWNDM0x4QzAxTkk0aXBJK1gyY0JkQW5KM3Z6?=
 =?utf-8?B?aDRGN3Y0U2l4Nk9IMUZlQ0pmbFB1TFF3RkJ1RlErS3hLNjAzNmhmUFk3MVlZ?=
 =?utf-8?B?dmhOSEJwL2pSR3ZaekswNktqYk5INkY5OW5aWHF0Rkd6c1k1TzRSVDBGNTZx?=
 =?utf-8?B?TVVkcnY1U2FuWkV4QWFwMWs5Qk5VYXdndjlnTFFPTmh6N3l4VGo0UzVlL3Y2?=
 =?utf-8?B?Qi9kVkk2MXcwblFDNUpsTENYNHppWTQxK3p2VHdOWS9HRHFlcEZRSkxJQWY5?=
 =?utf-8?B?T1c5a0VBQ0krSGtmRVFJcUFMY2xxTTVYaVR5OEk0VjZ0ZFpaS1pXVkJpUjlq?=
 =?utf-8?B?V0FmNlRpdGIzRVpnZEtKb2pJQm5rWlRhQlpmZThUTnZWWnNHeHovRGYyYlZK?=
 =?utf-8?B?VGhBRXhCbGt0SlV6dHBOM1VEeldGRWpKUDZyTFNCRVFZZEV0aGNTLzJ5OHIr?=
 =?utf-8?B?NUh1Q3RrdHIvdHlTbmZQai9PV29tKzNrRGgzWnVjcjBncnpYemhxUXZlb1RB?=
 =?utf-8?B?VVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEYwUUlzQXZSNks1Z1BpaksrMXROME1QMXIwUWU3bWRmTDgwT2FkaGlzTzg2?=
 =?utf-8?B?MkwxOHN1UHUzS0dsNS9sR1VIUnU4Ykt3TlV6R3hpZkorSWVBQm95WG5wSmIz?=
 =?utf-8?B?Mm9HNFQ4b0g0bzRGRHZMSFN5S0tqU3VrUFJtN2JJNWtKK2NZZm90SEVpbmZw?=
 =?utf-8?B?WnlnUjlyNGliT3ZxQlpXR0VaV2Zqdklkb2J4bWNaK1ZtOFpTeTN5b2ZaUGZO?=
 =?utf-8?B?b2JCeTNORzZQaXIrZktveDU0VFdocm1XWG5JZGU5WitPdlp3NEFLZHI1czJS?=
 =?utf-8?B?aDI0WXl5ODQ2enduQktac2R2UU9yUUcxMjBKL0hmTHk2Njl4bjd5ZUxZT1Rl?=
 =?utf-8?B?VUFvb1JTOE5xWXIyWU5YenU5N2IwQ2diWnlBdGlGaFVDUjZxU0RIbEJXK3k3?=
 =?utf-8?B?MnNuaWtjUnRZWXZKMUR6MlRoT1JidVhUREQ3dlVNQXc0cWl4QzhJZktxRTR0?=
 =?utf-8?B?a1RZSkh0STd6RkxZS3FHbzErMHNuOWNubTJxM2FCaGVoY3VlbEV6L1N1Y0dL?=
 =?utf-8?B?ZXpjQjlFanNZTkdIcjErdXVma0dvL2kxU01QNlcxSE9LbWpOVTJDb00zc1FL?=
 =?utf-8?B?OStESlhZT3Z0bnpLaWN4b2FHK205TlpUZC9oZ2ZTWHU5TWNuY1ZONDlWbkNQ?=
 =?utf-8?B?M2x0TkdRRXFRa2RCN3VFTlVMZndRYkIySWdkNjZkMm5sdWtoZ3JJTENkZ0ln?=
 =?utf-8?B?RDJxMkZhbFlSN252cGFUbWZKWFA5L3U3NEJ0V1lzUU9RR25CUjVlZ1A5Q2dt?=
 =?utf-8?B?RVU3ellQZHBVdG9IWlN6ZEx2dU9VT0dNWkI0YnZwWkJrWVFueWh5SnFrcjhz?=
 =?utf-8?B?SUtucTFJbithb1FWcVBEVkJyLzhPeUhtYjg2SWdNMVZNRlMyK1JjNk5WM0dt?=
 =?utf-8?B?UUZqYThzcERadlVWSVFKZFNFR3pvMTJmMHZ4emNKRno4THI5NWlwTHlyd1JQ?=
 =?utf-8?B?QTNGYjVpS3BzSjB0Y2lmR3l2OVdITThaL2ZUQmV2SW5PNE55QW45Nk5VbGVH?=
 =?utf-8?B?bmVyazE0V2VrMm1oSlhJTWpocVZ4a3YyODhqWVhjTWlsR1VBR09BdE9lbmwx?=
 =?utf-8?B?ejh1S2RIUm5ZNE1DVW1xWDBOYSsrekNUV21mcFowdnQ1VnlXd2xleVZ5SjA1?=
 =?utf-8?B?MjQwcmNEUFBUM0JuWktUNmV0ZXppd2VsVDVxNFczcm9kQ1Q1b1ZLQm5tVWcw?=
 =?utf-8?B?THFyVmFDSG0vaFpZV3hZeWF3RGo1WGJiTzNmNkZRYkxVK3Z5bVJQb0pPeEhB?=
 =?utf-8?B?UGJFemVvZEZiQVBoOUkzTS9sTU1jL3B5Z2tEMzVxU1d1TVlJSTdBTDQ4UlhJ?=
 =?utf-8?B?dUNBZWVOcVRLYVZDWUpGRzZuenl2cVpsa3FWSHJRZnhUd2NWWGZxRi9ickVa?=
 =?utf-8?B?VnIwVWJWWkZpQjJrcDk4a1JrUjRndERYOG1udnV3emN2VEczZVBkdGNvZlNB?=
 =?utf-8?B?SEpZWWlJNzlXL3hBMUk5M3dLdXJMVUVwTDdsRERKZ01jU2s4QUJsK2hUYU9I?=
 =?utf-8?B?SW4vbFgzNTFQQ3oyVXkvcVJkY201ZG5nK1BYU1VaVUwxd1dXZCtGL2lzQTRj?=
 =?utf-8?B?MHRrdnozZFlsNzBPYXo3dW5scWh0MnpzbHcyNG5hZHdYZVdXN0hueC9kU2t5?=
 =?utf-8?B?VTlFWjZacnZFbGp5OHpLd1cxMXp0M08rQm9DMXV4VHZEeG1TVXU1aWRORk5r?=
 =?utf-8?B?Yi9qOHJ3SExQS1FiME52dnJYQThQS0IvZmU2RjFHb1NKOFdRcktJc2drOWp3?=
 =?utf-8?B?c3JuaEorVXlvVVk5N2RnTmVrVTFMVENVTU5XZkpDcmFteHptOExFVDdTem9q?=
 =?utf-8?B?L0Z6dTZpOVJwOXVtK1F0ZTlHWUUzMXFSNnJaekJuUjVGdVJkWkRoZFZqZ1dU?=
 =?utf-8?B?bGRhMFJ0NUZMN1VhREtBdHUvdVFjaXZmUjhJVVFvNmpidmNLelRQWFdMNUgy?=
 =?utf-8?B?N3BhWlVhUHEvYlNONVRGOG5nNkpza3l0MGdYRHJJUkQwTVhzaEpwbUVMQzVZ?=
 =?utf-8?B?YzJEeG5QWitXLzRuUXZjVlhEclNOTXoraWp1Q2pSYzBpeEtlN0F3YjVsNkJ3?=
 =?utf-8?B?M1kzd3B1RTZKMloxbU5PeHgwOHdYU05LVi8xL1NqRjF0dnFiQ3MrdHQ0d0dK?=
 =?utf-8?B?enZvM1pkRzZhUEwxN1kzM3dDZjBtUHFEOFJTaHoxRWNGOXZFQ0RVTndQZ2g4?=
 =?utf-8?B?cmw3Vnp1dVI5MFpCRzd0VG9QT2NETDFXNmtZRTVFMVlsL1ZKMGpJeXExTUp6?=
 =?utf-8?B?WS9kVUEzRUVLR2JJd0M5cWZFUWJEYnUrWkZPcmRYWWx5ZitDdE1VK00vcjZQ?=
 =?utf-8?B?elpHZ2IxS3VsbjBwcG1UZ0RqaUZQOGdHQVdhdSs1UUwzU3FQWFJXdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a803c7b2-ac2b-46ef-621d-08de741bf29a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 03:14:11.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNAyNLoX4PvJjnycZrx8EEeqTUxGzAd+zKuzANTvzVVXO+s9Us1xpyiag7S4NTpB+Q71f2OPN4Hqi7bqOXG7rRGI+7k+Sxw1Z8Cb2DRZUeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7048
X-OriginatorOrg: intel.com

On 2/24/2026 5:36 PM, Mi, Dapeng wrote:
> 
> E.g., there is the generic x86 event enabling function
> x86_pmu_enable_event() 
Again that's in the header file, which looks okay to me.

Now looking at the file, core.c

    get_possible_counter_mask()
    reserve_pmc_hardware()
    release_pmc_hardware()
    set_ext_hw_attr()
    precise_br_compat()
    add_nr_metric_event()
    collect_event()
    ...

Then all of them violate that naming convention?

There is also another pattern assigning x86_pmu_xxx() to function 
pointers in struct pmu. Certainly this xsaving function itself isn't the 
case.




