Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451827B34E;
	Wed, 24 Sep 2025 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699220; cv=fail; b=OyVY2TOCg+UK9yQnirYGpVJkyiZ81lxOcJ420Rk0ohPxRMiFKebpoK8CXr9A8c5rSGMJK3/Fxt45vNhwly1jb45mBoIOiSTIRyW8EsRE1sP0MEuaF0HM+CVA42c0W6sXJIZuowk7U5YpRIrimdqZxcIi6wca0RVAdhOzWPNlCNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699220; c=relaxed/simple;
	bh=XoOBzwwfS/s8QouUgElHfswpt4NDcljn51lurRuoAPk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OjId+u3MD0MYxpg1LYPSAu36jjh5IRGLZ7TB2hG9KH6VJ3sErmxiA8cmC9kwwwe9XSlgjCQhSp9cSLtbxFILvjP6pqUPvlZ46gYz9Bh334ALoRX5hS6k4CFN4NpqrriVxB+2ag/d/TiWqgGRUI5nji6I80ZGYS8nB4GCMQ7Nq3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDIiieCa; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDIiieCa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699217; x=1790235217;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XoOBzwwfS/s8QouUgElHfswpt4NDcljn51lurRuoAPk=;
  b=cDIiieCaP+DgLz1tFz9CKLw1advIgJAxDPin7O+ecFzMDFxRs0R2RsMq
   wwAA8l3rfLAJty3W5uXP+mM5n4ZJA6j8kE0e2IQrEponW1oep9cenWlux
   wzB3FPcx/gLqzEpgmPY9d4j9C7vi/GiTlJOkShU1IlXy1ekAx5BHTP0vg
   RohC2HmUvFgf7DsgcBdHu+FtehnW3KLC4kTkWKTwm2nzYtxnvnoZ3Mzvx
   HehDkCZ9hNhXiHsJo963Oic2YApda7eCmxN/rvK33C0QA3hoBxVCfIX4w
   uTgfnVSRCkyf9Kv8M7iFn7u9oo+7d/h7aUTsm+q/lFrZtywCWE1GS38m6
   Q==;
X-CSE-ConnectionGUID: 7ViNpu7BRA2i4iVJTFf/pQ==
X-CSE-MsgGUID: BbH6lJEVRhaRva15wq5kog==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71611143"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="71611143"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:33:36 -0700
X-CSE-ConnectionGUID: 5I3kT/CzQI20lvhZLFVxbw==
X-CSE-MsgGUID: Uhnu4l46RkOSrJ2S/pW+2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176549306"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:33:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 00:33:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 00:33:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 00:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTC6ortD1MlpwZi0UXl3HdtM/nuM/9naqMxhYV2MlP+/DzSlUiobXJPvJahfrz4BFfSqBrjOHcDpa8PhIWhCoQciwItEFoIelOpm31nm6jETNsD+NSF3KFQDLZPTiOOO8WAUpzEhYpW7QaoU0Di3QAsR9E3vXMJYPQ4LXrTG+RjfaaEloMgQiXUI9oL8AbnEV+MTo51+MfWFTlfTCQ8T3Y22By0/CCxyQUojnBwpqvrVnhWeP8ZwEaSVzM85udWWLKLsroCX/F1QLWq8oYepnWGcM/p/bEtke9Rg9q3NddWekIVvfQ2U1wYVoZDJpPYwqio0NfP7HedCUmjIMFM+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08UvGywl65Sve+IIftMv2uqXLWun2D7S9vvLiujNKfw=;
 b=zBargqViRl1+KiIk4teiY0e0QEjPHObR/EYJ0XLxehxGg3lOQUQcufaSNoicjVZQhVBJ6ZDUHW2CJMb4HsvfavSDPfhE/9wfRG7R/RzkyddtEzqOly8swemTTOAR7KyTjjZvlGmuMCuOxVSDROOfHNeK1X1mMKdYewmoVObpNW9L/t1nf+O6KCVZYVXD0YycBFAgVPVYsWML6WI5DGZcLw9ZvOAf5w3OK3d+J9qLNSdVHm21IScE1c78JhEDwf+3lZkWG6AP2qdhf/jNHnnHvJAPPU0k6lWHbunb714CNxRIepFkfh/wIg9hTjaZLEyNGflpokSh8+/Pz94rQEwsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by CY5PR11MB6365.namprd11.prod.outlook.com (2603:10b6:930:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.21; Wed, 24 Sep
 2025 07:33:31 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 07:33:31 +0000
Message-ID: <cad3d1bf-5931-4e6a-b3d5-7ee79c63f3a2@intel.com>
Date: Wed, 24 Sep 2025 15:33:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf tools c2c: Add annotation support to perf c2c
 report
To: Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aLhHvWTnxGA-_6Ew@x1>
 <20250907152510.957952-1-tianyou.li@intel.com> <aMNBn0rWjfj7TkUQ@google.com>
 <b470609e-6392-4c15-8123-ac5126df8b5e@intel.com> <aMpWcdjoCBsRVo72@z2>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <aMpWcdjoCBsRVo72@z2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0006.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::16) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|CY5PR11MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ecf90a-fce8-4e06-dca8-08ddfb3ca902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTkrV3FSM3FoS2NtWWFVS1R4dVhoU3JnVDhVdlJuN3lkZ2pXQUJFNUFXR05o?=
 =?utf-8?B?UmZJd3dtL0FtQW1ZWFdHWXJnQ3BZNmJja2FXM2QzdlJOandWRFJhZ2tmN1lu?=
 =?utf-8?B?ZTlmR0haN21rTWNZMjk3SUpLRXVXNnBMaHMwdWZyOXVwaVhTRVRWc2lXYkQr?=
 =?utf-8?B?TnJmUXAzTDdmaEZUYnpSRCtIL2ZiZ1lBRGVYaVlEaXBMUkhOUUhQYlQwNkZr?=
 =?utf-8?B?S2k3ZE9ycXZTcm9pZWhqV1B0VUJoK3NyMzl3eVVEcnQ5NVkxM29CVGpXb2J6?=
 =?utf-8?B?eVZ5UEJVVTA0THoxdEFlWjdnQWxQcTlDRzUySXdMVzZjTEROZ0ZwQXdJTmRz?=
 =?utf-8?B?bEE5ZGtEQzNDbFA4Y2p4R1p2b2o3UFY4NmZIZEMyTzk4UjdPdDBCUzU5ampZ?=
 =?utf-8?B?QXUwT21nUzRDL0FIaEZMcHRRbHFOaGNRVUhDZVQ2bTJJWnZkTFZEVVhOSTRL?=
 =?utf-8?B?enlIQzVIWWdzbVdrRTBOdHdYNEwwajUwRWE1REh1UUk5RTRUcjJSeGt4dlhQ?=
 =?utf-8?B?dVBDKzgyWTdxbGtIT2RmVWN0Ylp1QUdaSzc2bFFkcVJwODMxQmNNRWZ2S2w1?=
 =?utf-8?B?NXJSVThMaENlc3JLY3M3eXIzc09rWldxSERGVjZMRGRTWWpWemhGQ1ZOZ2Iw?=
 =?utf-8?B?eDBZS1RFNlpkQTRObFI5M2F6Mm5iSjZucHRPYzJsV3NDSkFPZDRvTm9mNUV2?=
 =?utf-8?B?UWV4ZkVPYnF3dXNmR2N3TDFnZ2QybjF2UFJTQUhXdWw3blc3MUh3WGVEbHRu?=
 =?utf-8?B?MVRHK3FMakMrVm51RTJBaGo4ZDlGRkg5VkkwMnJMN09QSHhzZ0hzUW9VRjd0?=
 =?utf-8?B?Y08yL0lMVDB2LzFFcm1CRmcyN3RxSzRlbHJacXdNM2tleHpPVkN6OXdsM3Vi?=
 =?utf-8?B?akp2WFJYNzZnZVN4RjhWdEhiM3FjMUg5VWZQYVVzZFlrdHlwZEN4M0I3dXg4?=
 =?utf-8?B?bU4yUHhyRWZib1VUbTZMQ25jemJmNVJPSTY0d2crc21UV0JtZFE2WUs4cGtD?=
 =?utf-8?B?WUdGdkFOY0dVWDd3d3JzNm45NEQrZ29Sc2xERmVwYUxQSlFKSUJQZnhVQi9s?=
 =?utf-8?B?ak1Nd2haalRmWWtHbFhzenEzUEFIZTNlMy9FZHVJNFEyUnBsWDAyZ09FdkNB?=
 =?utf-8?B?bU5mdmQxM0hwbWZJcWxHVDk0NkZmc2ZVQlRDUjlkYkVJSityZUxGejgyOGR4?=
 =?utf-8?B?QWU5dGhOWjJOQktoTVl6cStZRG9wb2NYdzVyUjN0bTE0TzcvMnUyK1hkYjJn?=
 =?utf-8?B?Y3FMSmVnakpOc200Tzl0dnl0UXpSVTc1Mm5iUFBSYU1SRHhTSzlhUGNPVlVK?=
 =?utf-8?B?QXlPWUtOeSsrbHhHVlRaLzFSVzB0N0Q0Tkw3bHJadmRmQVNJaTljU0Y5WWpW?=
 =?utf-8?B?Nnpob2dMOE4yMkRGWUp5SG55bUtpM3JNS2lYSk1JOXFnamlLVjR4dWhOZVlN?=
 =?utf-8?B?bS9VOU02QTBDcS8vMy9MZ0RnWVF5R0xOdURnSnRYR21TSGc2YTdmdUhDY0VN?=
 =?utf-8?B?MDI0bFExU0RjK1BSNlJRQ0hVZUtQTEJOWjI2SmlDK2JMbXJVM2tIbjRHcFp4?=
 =?utf-8?B?TUxRR3daUEtxOXlFSEt0Vmtmbmx0eE43S0VXOGJHd3kvekFGWXJ1WC91S3dH?=
 =?utf-8?B?L2wrOGlyWGNaeGNEWE90alpaQnJBNTZQeEc1eVczMkdTck4rZzR6M2pPZkNk?=
 =?utf-8?B?UUNETVFFRERndlN0eHQ5TDZrQ0hUNkJKS09vU28rNmNSODd5MEFOL1VuYkY3?=
 =?utf-8?B?bjg5MlBTRWc2cXk2UkZpNEpLcXZTTmVVYjMzV0NuRlRxNWVhYVJIY0lPNEZG?=
 =?utf-8?B?ZmJmZzd2cVI2aXJTTFhoVmxpQXFIYnloYklaRHZNMWJMWnptVUxjbC90clgv?=
 =?utf-8?B?elFrU3RYRXZwZXdZbUQxNDhtQnZVNWc4ZG0rUU5lRHZGTnpxZ1ZoSktRQ1Nm?=
 =?utf-8?Q?fdMBUDcOkuM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1JpbDVVdEdXSGV3WnR6eXJpMkNPZ3hmREcyd0JRbGk1bk00L2NjQm55MHk1?=
 =?utf-8?B?eThscXFtUXc5TGUvaW5wckNlMEZmMW5XRGo2YmdzZTJxK015U0M5QWlJbFhj?=
 =?utf-8?B?YldHNE02U3pSOVpTRDFDV3hST0hVa0pwSTdLRzUrb2ZzN0E5WVpmTlJ0L1B1?=
 =?utf-8?B?cXBxQ2llUHVybGZmL2tlSFJ2ZjBhamRQQ3NQMU1nNm1UOXl6OUlMS25SRFFV?=
 =?utf-8?B?Q1pFUGpUNFF3TTI5TENneVFSMFRNa24wVzR6WGZpYmdGdWRQTklnR2x6WDZm?=
 =?utf-8?B?SmxLcTJ5M0dOQ1REQzRLWFp4SkVYK0p5bFM5S0I2OUt4VHQwZ05LaHlXZy8x?=
 =?utf-8?B?ZGtNNmN6eTRMc1RHZVNNUnNxNmI1SWRxbXhwRXRwODA2N1RWKzVYMFFxUURa?=
 =?utf-8?B?bzY1T2hNc2hMc0VEakRvcXJHUlJVRVlSOHRSdUk5MHIyQTU4UGIzaitYVXFn?=
 =?utf-8?B?QllWd1hXaGlGQkVkUys5bW5oL3dscFUyMTdSclJjMnpIeitEK1k5T0FZczVW?=
 =?utf-8?B?SmJRRFhxTEM0aFdPbjlGUStraytzS21LeVhuQUd1cTRGRUs1R1VvVENLYTVJ?=
 =?utf-8?B?VFlwdlpYREV1YWRFQ0VLYVF5OXN1ZzQ3eGkrcXFOYjhWWHloSmRWaVJZM3dn?=
 =?utf-8?B?N2s0YWxaRmFGOXVxcGtnRG5PNHg0c0FsdGlGQVFjK09DSEJ2MldwcTVxT3Rp?=
 =?utf-8?B?bFlldTI1eWxLTWV0cm44eWY0ZUM3YThnU2tBSXU1dlhpWjhZcFZMUFVsSi8x?=
 =?utf-8?B?NmZ2dFdXdkszL2IrT2pGUm5uY2JvcnlwL2JGajl0V0pGcUdnM3YzN3dFaUxr?=
 =?utf-8?B?Zk5HZXVaNEJJcjNyOE5nN2tLSTZUbk41cnAweUtoNWI2SDJBODBpUU5NSG5C?=
 =?utf-8?B?cEY2cm5TODlhNENBU0ovcUhjMFBXNVBQVG10WEVoYitiRzZLTjl1bFNCaW1m?=
 =?utf-8?B?K1k1RW1hZ0pQcWUzZWxDZEk0eXZ6MmE2ZlFQSGluanYzWFVOdWJ6TTdnUnVk?=
 =?utf-8?B?NmtMMy9YL2NCaTFIOWRkcklsaHdIRng3dVZBQmgxMGZjNUc5b0hFNFNpaSs0?=
 =?utf-8?B?aGg0VG00Zi9OMmZibDhvWEVyeHFiWVI3SDAyemhmc25qQVJ2U0IwUDJkMml0?=
 =?utf-8?B?eHJaRjJVbjBRUG1nZlVFMS9XRkowOG9jaW91UzBxcG5BUUxvcE5wNUVwbE1Y?=
 =?utf-8?B?cTBBRDduemJpdGtlc1hxZ2xHM0RHS0ViZWhocFRuSk10V2tHY1Z0SWxxOUhl?=
 =?utf-8?B?UE51VVJEN1J1cEppeDB1VVM1MHRRV2hHQWR4RG9mMExUZE9QS3lLWkJDZWx2?=
 =?utf-8?B?SmdtZTVmK2NDa3oxakpNWUhJNzg5eEdYNjYvYUh5cllRdUxjN2xHb25OT2Iw?=
 =?utf-8?B?a3RhZTJ4MlpwdzhzWm5VMzZNNHQyN1NTdk5CRWxFRlk0bDczNnFXblpoZHJG?=
 =?utf-8?B?SE8xejZFTEhpTXhSZ2RwQ0R5bVQvWjVEZmpDSVVrTEtKYkJnc1BXNXFHeHg4?=
 =?utf-8?B?TkZ4TjlROFVpZXNBNytnYnVHbEplT2hkSzd0VGUreENQQWc3blVSZUdpdmcx?=
 =?utf-8?B?WEJzUzh4ekdoMnRteGRqVTUvSjVCYW5PNlowd1VDSDRNSUxmOXJoWks4WU1j?=
 =?utf-8?B?aHJRY250UDNiR25hNlBzSzVMYjdhcXJZYWtZSHN0UzgwQklMQ1F2Y2RyQlRk?=
 =?utf-8?B?eHFMR2M5VG9UeU9UR0czendOYjZVbURJdWJTaWRWdGN2UWpiQWhBK1hiTUhs?=
 =?utf-8?B?L2dIZVk4UTdXR1ZDVnRLR2NaMGlPUjNnZWtNdzB4ZVFkS0ZDdUFNOElnYkFG?=
 =?utf-8?B?VFdUb0FvVHh4S1RSbkc1bXpRL0doWFkwSzh3R0xHcjE1TFZwYWxSRGNuQUtL?=
 =?utf-8?B?Mmphc3owSkhHUlRlMEFQNmQvK2hNU1dFanlhcmlnZ29CVElTVXV4R05Ldi9o?=
 =?utf-8?B?ZXFnZUZmc2s3MTZhYXgzN3VTcXFTeWc0WlBxc3JQRy96d1pUNm1Hc1NVditu?=
 =?utf-8?B?MnhOeUw2V1ZycGs0WTNYWWRGbXA0Z1dLZ0JZUTB4N3RxQklwWW0yRUxIVmFX?=
 =?utf-8?B?SXFkVGVWNmxMRW1rNXd1OFVZUCtRY3c5RE1ZZ1MzMmNTNDZRS25Ia0syY2RH?=
 =?utf-8?Q?xwWLUlhM74x01P+JJN9N5nl+P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ecf90a-fce8-4e06-dca8-08ddfb3ca902
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:33:31.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYY0SV4/OwgG0Kk1IjzGBUTJ++67gX7mA/B1NoLh8dswQ1xB+ZIB9JdbyXUGH3m/l1GfiVtvY8EDl7C4M4kxew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6365
X-OriginatorOrg: intel.com


On 9/17/2025 2:34 PM, Namhyung Kim wrote:
> On Fri, Sep 12, 2025 at 11:20:29PM +0800, Li, Tianyou wrote:
>> On 9/12/2025 5:39 AM, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Sun, Sep 07, 2025 at 11:25:10PM +0800, Tianyou Li wrote:
>>>> Perf c2c report currently specified the code address and source:line
>>>> information in the cacheline browser, while it is lack of annotation
>>>> support like perf report to directly show the disassembly code for
>>>> the particular symbol shared that same cacheline. This patches add
>>>> a key 'a' binding to the cacheline browser which reuse the annotation
>>>> browser to show the disassembly view for easier analysis of cacheline
>>>> contentions. By default, the 'TAB' key navigate to the code address
>>>> where the contentions detected.
>>>>
>>>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>>>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>>>> Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
>>>> Reviewed-by: Pan Deng <pan.deng@intel.com>
>>>> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
>>>> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
>>>> ---
>>>>    tools/perf/builtin-annotate.c     |   2 +-
>>>>    tools/perf/builtin-c2c.c          | 124 ++++++++++++++++++++++++++++--
>>>>    tools/perf/ui/browsers/annotate.c |  40 +++++++++-
>>>>    tools/perf/ui/browsers/hists.c    |   2 +-
>>>>    tools/perf/util/annotate.c        |   2 +-
>>>>    tools/perf/util/annotate.h        |   2 +
>>>>    tools/perf/util/hist.h            |   6 +-
>>>>    7 files changed, 164 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>>>> index 646f43b0f7c4..f977e97a9c96 100644
>>>> --- a/tools/perf/builtin-annotate.c
>>>> +++ b/tools/perf/builtin-annotate.c
>>>> @@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
>>>>    			/* skip missing symbols */
>>>>    			nd = rb_next(nd);
>>>>    		} else if (use_browser == 1) {
>>>> -			key = hist_entry__tui_annotate(he, evsel, NULL);
>>>> +			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_IP);
>>>>    			switch (key) {
>>>>    			case -1:
>>>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>>>> index 9e9ff471ddd1..f5702d218490 100644
>>>> --- a/tools/perf/builtin-c2c.c
>>>> +++ b/tools/perf/builtin-c2c.c
>>>> @@ -45,6 +45,8 @@
>>>>    #include "pmus.h"
>>>>    #include "string2.h"
>>>>    #include "util/util.h"
>>>> +#include "util/symbol.h"
>>>> +#include "util/annotate.h"
>>>>    struct c2c_hists {
>>>>    	struct hists		hists;
>>>> @@ -62,6 +64,7 @@ struct compute_stats {
>>>>    struct c2c_hist_entry {
>>>>    	struct c2c_hists	*hists;
>>>> +	struct evsel		*evsel;
>>>>    	struct c2c_stats	 stats;
>>>>    	unsigned long		*cpuset;
>>>>    	unsigned long		*nodeset;
>>>> @@ -225,6 +228,12 @@ he__get_c2c_hists(struct hist_entry *he,
>>>>    	return hists;
>>>>    }
>>>> +static void c2c_he__set_evsel(struct c2c_hist_entry *c2c_he,
>>>> +				struct evsel *evsel)
>>>> +{
>>>> +	c2c_he->evsel = evsel;
>>>> +}
>>>> +
>>>>    static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
>>>>    			    struct perf_sample *sample)
>>>>    {
>>>> @@ -334,6 +343,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>>>    	c2c_he__set_cpu(c2c_he, sample);
>>>>    	c2c_he__set_node(c2c_he, sample);
>>>> +	c2c_he__set_evsel(c2c_he, evsel);
>>>>    	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>>>    	ret = hist_entry__append_callchain(he, sample);
>>>> @@ -371,6 +381,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>>>    		c2c_he__set_cpu(c2c_he, sample);
>>>>    		c2c_he__set_node(c2c_he, sample);
>>>> +		c2c_he__set_evsel(c2c_he, evsel);
>>>>    		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>>>    		ret = hist_entry__append_callchain(he, sample);
>>>> @@ -2550,6 +2561,29 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
>>>>    }
>>>>    #ifdef HAVE_SLANG_SUPPORT
>>>> +
>>>> +static int perf_c2c__toggle_annotation(struct hist_browser *browser)
>>>> +{
>>>> +	struct hist_entry *he = browser->he_selection;
>>>> +	struct symbol *sym = NULL;
>>>> +	struct c2c_hist_entry *c2c_he = NULL;
>>>> +
>>>> +	if (!he) {
>>>> +		ui_browser__help_window(&browser->b, "No entry selected for annotation");
>>>> +		return 0;
>>>> +	}
>>>> +	sym = (&he->ms)->sym;
>>>> +
>>>> +	if (sym == NULL) {
>>>> +		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	symbol__hists(sym, 0);
>>>> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
>>>> +	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, he->ip);
>>>> +}
>>>> +
>>>>    static void c2c_browser__update_nr_entries(struct hist_browser *hb)
>>>>    {
>>>>    	u64 nr_entries = 0;
>>>> @@ -2617,6 +2651,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>>>    	" ENTER         Toggle callchains (if present) \n"
>>>>    	" n             Toggle Node details info \n"
>>>>    	" s             Toggle full length of symbol and source line columns \n"
>>>> +	" a             Toggle annotation view \n"
>>>>    	" q             Return back to cacheline list \n";
>>>>    	if (!he)
>>>> @@ -2651,6 +2686,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>>>    			c2c.node_info = (c2c.node_info + 1) % 3;
>>>>    			setup_nodes_header();
>>>>    			break;
>>>> +		case 'a':
>>>> +			perf_c2c__toggle_annotation(browser);
>>>> +			break;
>>>>    		case 'q':
>>>>    			goto out;
>>>>    		case '?':
>>>> @@ -2989,6 +3027,11 @@ static int setup_coalesce(const char *coalesce, bool no_source)
>>>>    	return 0;
>>>>    }
>>>> +static bool perf_c2c__has_annotation(void)
>>>> +{
>>>> +	return use_browser == 1;
>>>> +}
>>> Can you just use ui__has_annotation()?  It should make sure if
>>> he->ms.sym is valid which means you have 'sym' sort key.
>>>
>>> Thanks,
>>> Namhyung
>> Thanks Namhyung for your time to review the patch. ui__has_annotation() use
>> global perf_hpp_list while we use c2c.hists.list in builtin-c2c.c.
> I see.  Thanks for the explanation.  Ideally it'd check if
> c2c.hists.list.sym is set but I'm not sure the sort key setup code
> correctly updates it or not.
>
>> Per my understanding, the he->ms.sym was initialized through the call chain
>> of hists__add_entry_ops ->  __hists__add_entry -> hists__findnew_entry ->
>> hist_entry__init.
>>
>> Could you please kindly let me know in which case we have an invalid
>> he->ms.sym where I should code a fix? Thanks.
> It may have some value, but it'd be consistent only if all hist entries
> merged to it (according to the sort keys) has the same symbol info.  And
> it's guaranteed only if you have 'symbol' in the sort key.
>
> Otherwise an entry can have a random symbol (at the time of the first
> sample) which won't represent the whole overhead for the entry.  And I'm
> afraid that the result can be misleading.
>
> I haven't looked at the c2c code deeply if it's always guaranteed to
> have the 'symbol' sort key though.
>
> Thanks,
> Namhyung

Very appreciated for your response and explanation, sorry for the 
delayed response. When cacheline browser created, it will setup the 
dimensions which include the dim_symbol where sort_entry set to 
sort_sym. The hist_entry of c2c_cacheline_browser contains the symbol 
information that need to be displayed in the TUI. The ip addr also 
displayed as the code address.  In the annotation browser, we did not 
need to show the overhead of particular event type, or switch among 
events. The only selection was set to the ip addr where the hist entry 
indicated in the cacheline browser. The hist_entry was correctly 
initialized with .ms field by addr_location when the mem_info can be 
successfully resolved through addr_location.

I did not find the 'symbol' sort key has already guaranteed but in the 
c2c scenario it might not be necessary since we just need to highlight 
the only code line that where the code address indicated by the 
cacheline browser's hist entry, no overhead percentage calculation is 
needed. Please kindly allow me to know your thoughts. Looking forward to 
hearing from you. Thanks.

Regards,

Tianyou

>>>> +
>>>>    static int perf_c2c__report(int argc, const char **argv)
>>>>    {
>>>>    	struct itrace_synth_opts itrace_synth_opts = {
>>>> @@ -3006,6 +3049,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	const char *display = NULL;
>>>>    	const char *coalesce = NULL;
>>>>    	bool no_source = false;
>>>> +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
>>>>    	const struct option options[] = {
>>>>    	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>>>>    		   "file", "vmlinux pathname"),
>>>> @@ -3033,6 +3077,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
>>>>    		    "Enable LBR callgraph stitching approach"),
>>>>    	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
>>>> +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
>>>> +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
>>>> +	OPT_STRING(0, "objdump", &objdump_path, "path",
>>>> +		   "objdump binary to use for disassembly and annotations"),
>>>> +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
>>>> +		   "addr2line binary to use for line numbers"),
>>>>    	OPT_PARENT(c2c_options),
>>>>    	OPT_END()
>>>>    	};
>>>> @@ -3040,6 +3090,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	const char *output_str, *sort_str = NULL;
>>>>    	struct perf_env *env;
>>>> +	annotation_options__init();
>>>> +
>>>> +	err = hists__init();
>>>> +	if (err < 0)
>>>> +		goto out;
>>>> +
>>>>    	argc = parse_options(argc, argv, options, report_c2c_usage,
>>>>    			     PARSE_OPT_STOP_AT_NON_OPTION);
>>>>    	if (argc)
>>>> @@ -3052,6 +3108,36 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	if (c2c.stats_only)
>>>>    		c2c.use_stdio = true;
>>>> +	/**
>>>> +	 * Annotation related options
>>>> +	 * disassembler_style, objdump_path, addr2line_path
>>>> +	 * are set in the c2c_options, so we can use them here.
>>>> +	 */
>>>> +	if (disassembler_style) {
>>>> +		annotate_opts.disassembler_style = strdup(disassembler_style);
>>>> +		if (!annotate_opts.disassembler_style) {
>>>> +			err = -ENOMEM;
>>>> +			pr_err("Failed to allocate memory for annotation options\n");
>>>> +			goto out;
>>>> +		}
>>>> +	}
>>>> +	if (objdump_path) {
>>>> +		annotate_opts.objdump_path = strdup(objdump_path);
>>>> +		if (!annotate_opts.objdump_path) {
>>>> +			err = -ENOMEM;
>>>> +			pr_err("Failed to allocate memory for annotation options\n");
>>>> +			goto out;
>>>> +		}
>>>> +	}
>>>> +	if (addr2line_path) {
>>>> +		symbol_conf.addr2line_path = strdup(addr2line_path);
>>>> +		if (!symbol_conf.addr2line_path) {
>>>> +			err = -ENOMEM;
>>>> +			pr_err("Failed to allocate memory for annotation options\n");
>>>> +			goto out;
>>>> +		}
>>>> +	}
>>>> +
>>>>    	err = symbol__validate_sym_arguments();
>>>>    	if (err)
>>>>    		goto out;
>>>> @@ -3126,6 +3212,38 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	if (err)
>>>>    		goto out_mem2node;
>>>> +	if (c2c.use_stdio)
>>>> +		use_browser = 0;
>>>> +	else
>>>> +		use_browser = 1;
>>>> +
>>>> +	/*
>>>> +	 * Only in the TUI browser we are doing integrated annotation,
>>>> +	 * so don't allocate extra space that won't be used in the stdio
>>>> +	 * implementation.
>>>> +	 */
>>>> +	if (perf_c2c__has_annotation()) {
>>>> +		int ret = symbol__annotation_init();
>>>> +
>>>> +		if (ret < 0)
>>>> +			goto out_mem2node;
>>>> +		/*
>>>> +		 * For searching by name on the "Browse map details".
>>>> +		 * providing it only in verbose mode not to bloat too
>>>> +		 * much struct symbol.
>>>> +		 */
>>>> +		if (verbose > 0) {
>>>> +			/*
>>>> +			 * XXX: Need to provide a less kludgy way to ask for
>>>> +			 * more space per symbol, the u32 is for the index on
>>>> +			 * the ui browser.
>>>> +			 * See symbol__browser_index.
>>>> +			 */
>>>> +			symbol_conf.priv_size += sizeof(u32);
>>>> +		}
>>>> +		annotation_config__init();
>>>> +	}
>>>> +
>>>>    	if (symbol__init(env) < 0)
>>>>    		goto out_mem2node;
>>>> @@ -3135,11 +3253,6 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    		goto out_mem2node;
>>>>    	}
>>>> -	if (c2c.use_stdio)
>>>> -		use_browser = 0;
>>>> -	else
>>>> -		use_browser = 1;
>>>> -
>>>>    	setup_browser(false);
>>>>    	err = perf_session__process_events(session);
>>>> @@ -3210,6 +3323,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    out_session:
>>>>    	perf_session__delete(session);
>>>>    out:
>>>> +	annotation_options__exit();
>>>>    	return err;
>>>>    }
>>>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>>>> index b770a8d4623e..c2afa3624917 100644
>>>> --- a/tools/perf/ui/browsers/annotate.c
>>>> +++ b/tools/perf/ui/browsers/annotate.c
>>>> @@ -592,7 +592,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
>>>>    	target_ms.map = ms->map;
>>>>    	target_ms.sym = dl->ops.target.sym;
>>>>    	annotation__unlock(notes);
>>>> -	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
>>>> +	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_IP);
>>>>    	sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
>>>>    	ui_browser__show_title(&browser->b, title);
>>>>    	return true;
>>>> @@ -854,6 +854,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>>    	const char *help = "Press 'h' for help on key bindings";
>>>>    	int delay_secs = hbt ? hbt->refresh : 0;
>>>>    	char *br_cntr_text = NULL;
>>>> +	u64 init_ip = 0;
>>>>    	char title[256];
>>>>    	int key;
>>>> @@ -863,6 +864,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>>    	annotate_browser__calc_percent(browser, evsel);
>>>> +	/* the selection are intentionally even not from the sample percentage */
>>>> +	if (browser->entries.rb_node == NULL && browser->selection) {
>>>> +		init_ip = sym->start + browser->selection->offset;
>>>> +		disasm_rb_tree__insert(browser, browser->selection);
>>>> +		browser->curr_hot = rb_last(&browser->entries);
>>>> +	}
>>>> +
>>>>    	if (browser->curr_hot) {
>>>>    		annotate_browser__set_rb_top(browser, browser->curr_hot);
>>>>    		browser->b.navkeypressed = false;
>>>> @@ -963,6 +971,17 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>>    				ui_helpline__puts(help);
>>>>    			annotate__scnprintf_title(hists, title, sizeof(title));
>>>>    			annotate_browser__show(&browser->b, title, help);
>>>> +			/* Previous RB tree may not valid, need refresh according to new entries*/
>>>> +			if (init_ip != 0) {
>>>> +				struct disasm_line *dl = find_disasm_line(sym, init_ip, true);
>>>> +				browser->curr_hot = NULL;
>>>> +				if (dl != NULL) {
>>>> +					browser->entries.rb_node = NULL;
>>>> +					disasm_rb_tree__insert(browser, &dl->al);
>>>> +					browser->curr_hot = rb_last(&browser->entries);
>>>> +				}
>>>> +				nd = browser->curr_hot;
>>>> +			}
>>>>    			continue;
>>>>    		case 'o':
>>>>    			annotate_opts.use_offset = !annotate_opts.use_offset;
>>>> @@ -1096,22 +1115,23 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>>    }
>>>>    int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>>>> -			     struct hist_browser_timer *hbt)
>>>> +			     struct hist_browser_timer *hbt, u64 init_ip)
>>>>    {
>>>>    	/* reset abort key so that it can get Ctrl-C as a key */
>>>>    	SLang_reset_tty();
>>>>    	SLang_init_tty(0, 0, 0);
>>>>    	SLtty_set_suspend_state(true);
>>>> -	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
>>>> +	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt, init_ip);
>>>>    }
>>>>    int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>>>    			       struct evsel *evsel,
>>>> -			       struct hist_browser_timer *hbt)
>>>> +			       struct hist_browser_timer *hbt, u64 init_ip)
>>>>    {
>>>>    	struct symbol *sym = ms->sym;
>>>>    	struct annotation *notes = symbol__annotation(sym);
>>>> +	struct disasm_line *dl = NULL;
>>>>    	struct annotate_browser browser = {
>>>>    		.b = {
>>>>    			.refresh = annotate_browser__refresh,
>>>> @@ -1163,6 +1183,18 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>>>    		browser.he = &annotate_he;
>>>>    	}
>>>> +	/*
>>>> +	 * If init_ip is set, it means that there should be a line
>>>> +	 * intentionally selected, not based on the percentages
>>>> +	 * which caculated by the event sampling. In this case, we
>>>> +	 * convey this information into the browser selection, where
>>>> +	 * the selection in other cases should be empty.
>>>> +	 */
>>>> +	if (init_ip != NO_INITIAL_IP) {
>>>> +		dl = find_disasm_line(sym, init_ip, false);
>>>> +		browser.selection = &dl->al;
>>>> +	}
>>>> +
>>>>    	ui_helpline__push("Press ESC to exit");
>>>>    	if (annotate_opts.code_with_type) {
>>>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>>>> index 487c0b08c003..3675a703de11 100644
>>>> --- a/tools/perf/ui/browsers/hists.c
>>>> +++ b/tools/perf/ui/browsers/hists.c
>>>> @@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>>>>    		evsel = hists_to_evsel(browser->hists);
>>>>    	he = hist_browser__selected_entry(browser);
>>>> -	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
>>>> +	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_INITIAL_IP);
>>>>    	/*
>>>>    	 * offer option to annotate the other branch source or target
>>>>    	 * (if they exists) when returning from annotate
>>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>>> index c9b220d9f924..937effbeda69 100644
>>>> --- a/tools/perf/util/annotate.c
>>>> +++ b/tools/perf/util/annotate.c
>>>> @@ -2622,7 +2622,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
>>>>    	return 0;
>>>>    }
>>>> -static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>>>> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>>>>    					    bool allow_update)
>>>>    {
>>>>    	struct disasm_line *dl;
>>>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>>>> index eaf6c8aa7f47..bbe67588bbdd 100644
>>>> --- a/tools/perf/util/annotate.h
>>>> +++ b/tools/perf/util/annotate.h
>>>> @@ -170,6 +170,8 @@ static inline struct disasm_line *disasm_line(struct annotation_line *al)
>>>>    	return al ? container_of(al, struct disasm_line, al) : NULL;
>>>>    }
>>>> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip, bool allow_update);
>>>> +
>>>>    /*
>>>>     * Is this offset in the same function as the line it is used?
>>>>     * asm functions jump to other functions, for instance.
>>>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>>>> index c64005278687..e544e1795f19 100644
>>>> --- a/tools/perf/util/hist.h
>>>> +++ b/tools/perf/util/hist.h
>>>> @@ -713,12 +713,14 @@ struct block_hist {
>>>>    #include "../ui/keysyms.h"
>>>>    void attr_to_script(char *buf, struct perf_event_attr *attr);
>>>> +#define NO_INITIAL_IP 0
>>>> +
>>>>    int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>>>    			       struct evsel *evsel,
>>>> -			       struct hist_browser_timer *hbt);
>>>> +			       struct hist_browser_timer *hbt, u64 init_ip);
>>>>    int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>>>> -			     struct hist_browser_timer *hbt);
>>>> +			     struct hist_browser_timer *hbt, u64 init_ip);
>>>>    int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
>>>>    			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
>>>> -- 
>>>> 2.47.1
>>>>
