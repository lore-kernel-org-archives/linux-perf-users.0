Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937973EBF2A;
	Wed, 25 Feb 2026 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981888; cv=fail; b=GNnxIzpYqNDfL1TnzB6+i33CCaDcKmaXc1syFQ2rPSDkozOyEawhloJi1CewFP/rvInHraSd5k30t5+R0ix0u2iKORXUKElE0DsWQELgBYilGVzJgIfJ4ZSLCFrSgOdOEtDKeSQlp8H7Dy+iUCDP+IcIgDQDG6V4RbnYv4cvTW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981888; c=relaxed/simple;
	bh=l0BTre/ycdiMYW2n6AXcC9R9fIhzLKwC/vmVpoZB+rQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y47gnlaZ02Re7ApsTwZXNL8DUFPbMawuGmNRc6TPbGUkwyRcJb96LJlfTCYbGSp7IlK8mmeMNItHoc5wEJl2CYNo3AL9fsx1tyVrNnv3d3T+MrDhaLSpuFhjkDEtpGintFhs8j2hsgOJAhTzKgHiKE+OGNJGtxDHewViyZBPtLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AK5rfxx8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AK5rfxx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771981887; x=1803517887;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l0BTre/ycdiMYW2n6AXcC9R9fIhzLKwC/vmVpoZB+rQ=;
  b=AK5rfxx8lgNBe8Q35f58kfV6TnH5prxQ0a03e0O3g4nBcPpy0ZrYdN93
   Wg8XVtrqlLTrzMBWPPigmSHoTwG+2pGgc3f9Tek8ODYeha6fopG5Y5fVH
   KT5Qmamwvoo4j5iYVC0V/y3DOvmuwu8mPoGaBZaHLoA0m+BzMidSKW7XS
   aUb3x+XzptS5wOPWKKt+Z6vuHkCqpvYGh3xpnfhSDIHcDrlu7KkuOUQHp
   0E9SwVHkXlBOVELNfDfcGHdLzuQHUuPJHYRCO2XSorYxV+HtlOgKYdfIa
   6GkrHP2W+eWLWm0ialBtnkd9YwaK4OV5pKgnQQv2ViJrR9PWagWmbSlVk
   w==;
X-CSE-ConnectionGUID: RS9rtVSVTeKEp4JXt/qt4A==
X-CSE-MsgGUID: QsTrfIRLQxy8UFv8B3qGRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="95626679"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="95626679"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 17:11:24 -0800
X-CSE-ConnectionGUID: KzIwDKVdSyKBoNcUyUsxoA==
X-CSE-MsgGUID: Z0N8r7yHSEWetTIKanTwXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="243935590"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 17:11:22 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 17:11:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 17:11:21 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 17:11:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJjUO49psFBA5c/XXT+CieUkzWmK+epq/uMc3c04P/yOYP1vTf7qBbdTloKrUkNMd9RjCCzX1Z4qp+49g+fMJhRs7NYF6HUnnSQN1S7I6ESoiPamEKaG5IT8cjBAEO4hIQ+fCXsU770az/05Y4PenH21YFAAz+axUBDvCMXJbq3hsSPWwO4c8RldlwN+OsEUBm2soVR1qC6jvevyegPWwQkJ2JaBRcCrwCogNKqE7OhP4jqZtT1dXscxJ07KvLs/aE4mLzSG9rCXtyetUwonWebRGbzfBoUM+7bN6Q9Exr2nkNnz7wP9CS8Vo1rZ3cSH6ThPmsl1ksqw1hsgWsKhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PGxNUCgeWVCZR6DdOwVjmobpbG2NZm99E+jp+LB+eo=;
 b=uCq85yHQSLUlKd35Bcnd0CjwGE+DehaCOaBC9a3k1xuODWW7dFbh2gT5Y5dWxeddeaiwr4OnJhkXNMQ7HmOJK/VTKi1H5bfFDIXKCp0OvFqW8Ww4j0sNt3IW932ind8JrsbVbu5T3GcTzgaaVusSBc2niFjEgBFqBVGpIMBP6M01zdrvMfRSUTGtHruYSV6Zh/IFN6oqC53GPHaN/Jvw6PKiowgd5CXgY6563n6Zt8+JrZXsG5EFOrjgKk9trcxHLzZnLYLE49hcyTGf37s+bdMmgzIn02XZcL9iOu1ZCzvhyZbgsPWmtrinVferGmaf0G//nSw4PDnM2rHCupx1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA1PR11MB5922.namprd11.prod.outlook.com (2603:10b6:806:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 01:11:17 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 01:11:17 +0000
Message-ID: <e1e05b38-6a7e-4e09-8044-b71e4f6ffb86@intel.com>
Date: Tue, 24 Feb 2026 17:11:13 -0800
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
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <a8a35490-994c-498a-acab-478795c868b0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA1PR11MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a71459-88fb-471a-e41d-08de740ac746
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlFnOEIyRnd2QzBjaG0rYTAxYVlJNHppVC9NRGRPUkZTL2VNWXJnODBvdGEr?=
 =?utf-8?B?WFgzU20xK2s0YU9FZmxVeHBuZzI5TWJ1em15eWVSYXBEZlJWczYvcENTRXJw?=
 =?utf-8?B?ZHpBelNORUxEbmRldDM4WWhlQWIxZElVN1J2Q0s2Unp3c0N4dkwyZzlraEFO?=
 =?utf-8?B?RU00SkJvcHhqK2wrYjJyaXlEWHQwQ09ZeGVONHp5NGxKMTlwOXg2KzR2U01w?=
 =?utf-8?B?K3RBM20xVHJtdE1JS3Z1NHRwdlAwTTQyaEZSVW4ySWdPeGN4VkRFWWJTZHF4?=
 =?utf-8?B?eW9MbEZvN0RmemRHVkdCdk8xd001WjJvYStFendBTG95RURITmhhNW9ZRkEz?=
 =?utf-8?B?b0E4cEp0M3dYQ3hkajdLL0lYS1Zzb1RMS1RkN0dQMU8wRWpHUnNraWxMbSsx?=
 =?utf-8?B?ODdVU0VGUmU0RFVHUWFCcDdOa1JhNkMxRXlNMUZ0SnlncUNvaDFRQWhxQTJk?=
 =?utf-8?B?N1YvTkpjRWx1cDhjYjcwcDJXbTNFYmRzWFF6REJ0ZkU4eUQ3MVVWa2ora2Fp?=
 =?utf-8?B?MzNFOXFYM2FROHhMRTYvSVY5dmYxWXVJdE9oYlhhRiswQjFzOWhieDZJTEZP?=
 =?utf-8?B?Mm1wYmhqQzZlM1VtNjZ2V3BxVVJycmxMUUpHMkR6eEIyMHAzUUZtNCtYcVRZ?=
 =?utf-8?B?di9BSU1NOHRETW1oazEwMEFWVHlIRXBjNWNFVzYwcXdMaG1oaWdZTlF0eDI2?=
 =?utf-8?B?Z3ZxUUpDblFaV1ZQcnY3SHArUWxrTTFDUGE5S2t5eW1NTHQ1enFQWXR3b3NK?=
 =?utf-8?B?a2RwQitZTUxiYkFzK0t2S05QOUNZY3prb2xqelRVZXY0MDdTTG93ZERLNXhk?=
 =?utf-8?B?emZOK3JDRi84ckhsUjNzcGtZNWRRUGZObnZnVGNIMzVBUENaOFNVWGtDYWg1?=
 =?utf-8?B?ZG1SU1ZRUmZRVXBHYTJoZmcvRnV4dTk1Yi91SVlzdjdScmZRMmx3VENDT3gz?=
 =?utf-8?B?ZkRFYjQ3WjVEZXlEYkZuRFVrMXhsNzBKdmF2UG5uZmhqRFEwUUEzanZGa0Zh?=
 =?utf-8?B?dGxSb2F0dk9STEN2b29iWlNRRDVSc1UwdUxack9tOHV4ZzdiT1BldHBrTXZF?=
 =?utf-8?B?cFZOODlQV2ZpemZkWUZGSWRpVSs1UTU1WXZWL2RUNjk5dWQxb2NUS2htYzBs?=
 =?utf-8?B?aHhXNC9sR2xtNTBKdjdRK1BxSS9qZnlsRnBzdUc2KzR1ZXZtZzlNMTU4SWJO?=
 =?utf-8?B?ajAvOC96cHpmelZFNHQ4ZnBHRzVIU3ZFYXMxVkwzdlU1RWpUdUNkZ0t0TVFS?=
 =?utf-8?B?emVhcSt3TkhGNEo5NFhCaGdvY0lER2Ftby9zM0syWWFGTDlHdCt1Qm41T0xj?=
 =?utf-8?B?bkl6cDJ5SVN0RThhemJER1dKalg3SlBDUVZ2TUVRaUI4SDdPbUhzcDJIT3RY?=
 =?utf-8?B?dmZWcU5jbkZ0MUdSa0NUZEhSenFZTG5YTS9Zb01aeHpCeCtVSDQrUlI2blZ2?=
 =?utf-8?B?R3BNNTJEVUlDQUpFK3VCNkZJNnN0WE0yR1BYSFphN25ZS3ZrWEZYek1ZYVBy?=
 =?utf-8?B?c1pXSlluQmhGNHBvZkZySW1lUjdjdkJJNWNJNjNoNHB6Vk1iWDNuK1lnVWNK?=
 =?utf-8?B?UkMwNUJQVzFDemN0UzU3WitobVNqeHdobHZISkNQcHRVYXVzc1pvSjhPREg2?=
 =?utf-8?B?U3pkZGVmME5tQ1ZOWWlEV1RqRVFzOHBONlM2UktOamNrazhGMEZETEtJajYx?=
 =?utf-8?B?WjVvV3h5SW92YnFUVlBlMHhXdnpvQlA1cFJUcDZHV0RwZlRCc0xpOEY1N1lR?=
 =?utf-8?B?TFV0bFIxM1FDdkN3OGozU2E2UllqS2Z1dmxyc0dFUG4rMjVRUUlja2lrcjlH?=
 =?utf-8?B?dVlPN0xKU0ZzNjFnaTVHWmVMRVBtb2JuNEJMNENnVk9HUTRDcmFYWlhhL2V5?=
 =?utf-8?B?T0t5Qi9TYlV0eUM5RDlKUTl1eWc2YTcwbFhHU3FvS0ZVYU93MmMxWHNaY3J5?=
 =?utf-8?B?M2VkaVdjQkl2d1ZYM2tVbUllWFRsYUVWMEExeEpnMVRaM01pNjdsQjhpRHU3?=
 =?utf-8?B?TXN3R1J3V2Q5R0xSZmN3TUdkclJORStDWld6b0cybVJ5NWIxTnQvME1iTjky?=
 =?utf-8?B?U1RwT3NPOEJicWFMay80eDdFWTgvZjgzT2EzN3BHSlZSeHIyOHUwcW4xamxz?=
 =?utf-8?B?bWFJN1liZHdZTTJITU1vUGdSODA3RnNhSW95bGtDanBabVBySDgxT29qcnBx?=
 =?utf-8?B?MXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFFWjI2TWtGUTRBTCt5SkYwS0RSem9VYU9jRDdnSGtzRnpzS0pHcDVva3VM?=
 =?utf-8?B?VFFtN3J4T2p2YU1ROU5QaEUrZGUxRTNNSENGb3pkNm1EdEFnM1h5bHB1V2M5?=
 =?utf-8?B?Y0NqTGk4Qmk0VDVQdmNtUTl1V3lsd2RqOFZTWllsbSs2Y1RtTjFoaC81L3Z3?=
 =?utf-8?B?ZGptRnlDVFZiUW5LWDN2ZmR3dTY1QmhaSnFWZWw1WldISXV4aFRxLy85ZmNP?=
 =?utf-8?B?dHZGSm5tZWJNbUhMN2YyMWoveGxaZnlQNGJRMWtvUUNXT1ZzbzFBTUtqdkdL?=
 =?utf-8?B?clhDWlpwR1c3Q1d0UlhuR3pCUmRraS9tZmZhbjZVS0ZCOTYrRVp3aUVTZ1BB?=
 =?utf-8?B?SkJTdkpxYU92czhuQUs2dkt5VkphSktJUkVmd01TbzFLQkhSUFZpam4zNS9O?=
 =?utf-8?B?cnZoR1hXOC9OSTBzQkhkN0dRemZNeUE3Yng0M0lsN0ZBcVp5MkQxdkpkM28z?=
 =?utf-8?B?UWpUQ3doenNzVHdta0ZJSTRMbklOTGVxRDFUVzBaOHFMbVVDelY4RDA2dmNh?=
 =?utf-8?B?QkJsNmFJU28zcktsL1R1YmpZVVlQUGl2ZTQ5cGplWnJ1S3UwS3FsKzF6d0dI?=
 =?utf-8?B?Nlo2N1cvWnJEb200UHEwVmhXeUxHcG02Y3MxMzVTTUtFbWhlRjZHbzJwcHhy?=
 =?utf-8?B?SUR3ZmdwMHl0UFdQSU1UVlBjZWNpYUdaQmpNcVhtWTFNM3pmRzVUR3o3ODN2?=
 =?utf-8?B?RW13M1NrMFQrV1hKZUw5TytCcFZFTGpWVGRlYTZXdVBzYXpCU3prVlArVE5J?=
 =?utf-8?B?RjlwVURjb0xEVGZENmxGem92NGIzYlFHalpUbFhkaHlKbEFSU3dxZzhibm9C?=
 =?utf-8?B?eUVmb2RDRzBqbEFDTi9Tc2RZd2xmdXhXUXpUSk9YVENyamVZQS9sSk5sbHpE?=
 =?utf-8?B?c2tOeW1zZS8rY2ZuVmRaYnFxZittWG1FczN6M3JpTVNWZ2RyVmc5YTVJMXlm?=
 =?utf-8?B?d0dzREViQmU2ZTVGcnNzTW5DT2FkTjdlNSt3SExEcWU4VVdKYlBTa3ZodlhV?=
 =?utf-8?B?eTRackkwai90VWhuMjQzSDJEL3U1VVFldkNuM081Tm9abDBUZUZIRm93cXJE?=
 =?utf-8?B?ZGtibzFWSnU2U2FZWDVzdXU2M3hOdmhzczdDa2xtWFVRaUJ3alp0Q0ZabnB0?=
 =?utf-8?B?bVZsMkUvaGlLOWRGVk1sWmRjcGZtQU5qRWxnazRacGI1a2RWNXBBT0hNMjZI?=
 =?utf-8?B?VHhCS0Fuc00vd1B4eUJ2aGg3bnVLM2pkekdqeGRFRXZqVFExYi9ER3c2SWRI?=
 =?utf-8?B?UjRReWtET2VaMENvYktOR2E3THBMdVJHYitta2lTenVWTWNTdlE3L1gyRlhu?=
 =?utf-8?B?QlZBbXUzbUJ6U1JQbzE5ekxvaWxXR1pEcjkwcHBHVm5JSGZGaUFGU01seVNX?=
 =?utf-8?B?NkF0bS9nZHpZaHI2WlZFcVd5aDNiZ2x1NldjZksyYnkrd3owUmFVcDZWRTZr?=
 =?utf-8?B?and1VlByZHM1RFVJek5QYkFzUU41eGVXZWlaWnU5TG1yWmhzWkhSaHVTZXg4?=
 =?utf-8?B?eXR4WXYwYVZieWVZL0ZjY1pxbVZUcDBXTC9wQTJBYzlkZDJSR3lkR3dmTU1S?=
 =?utf-8?B?QTNxM1EyRHJLUlVqZStMa1ZNU1FRSTlRS3I2bUd5Mmk0WFRLODh2RURDbXlt?=
 =?utf-8?B?d2V3MEI5THVNekk1WXhKSlRuWGVwTmVvbFNFejU1UjBlMTZaVVQ1SWlhaGI0?=
 =?utf-8?B?NE9JdTJVVE9EM21xTFdEb0plZmVWa1VIOE8zWXNLUkF1d0IrVnJ3NDV5SXNK?=
 =?utf-8?B?c2M1YjhUeGZsMFlZUkpuRW5Gd05jMHZSRm1rZXFWUmpYU2NLQS9NNkFnN3Iz?=
 =?utf-8?B?OHk4NmRzRUtnNXp6cEVBWHlaY0xOL1ZVSTBMZ0lXRyszMzk2cGd1WFRGc2tE?=
 =?utf-8?B?WlVWQkNNQkRuTFhtTFlzT0hXZkhXemJQNVJ6MmJNOHk1ZktqcVo4L2lyTzBa?=
 =?utf-8?B?UEM5endNSGU3STJJazVlZ3pvRXc3cWl6b0Z0Y2cwQ2tEK3B4S0pkcHI5dFRu?=
 =?utf-8?B?R0dGRk9YdktPUk45eDQvTGxLMFNjSFNxNlhaelZZYmxlY1d1YUQzZkc3UEFp?=
 =?utf-8?B?ZlN4TUc3SjNxaHlwak9wOG52VDZNOW5RSWVMZlBPa3ZlL1poc2cvZFVGUC9J?=
 =?utf-8?B?a3N0RCtDNmdDUEtkS0F0MUwrNWhXdUo1ZWRQQ09kWkhmc2puRTkveDBQQjlM?=
 =?utf-8?B?dW1OZDduNS94RFBWM0dCYXJ4NW9KNkZtMDZOc0FMT1dtZURURVVtTWJCTlhI?=
 =?utf-8?B?emZ5SjVaanRZWEJnLzZjM2VQTzUrOE1YSkdXRnpjNU5HV1p2d3BxMTlUZWhi?=
 =?utf-8?B?Qi8zSzRSQmJDQVkzYTduaThJenVFdG90YVFMSDZCQjg0SWlxcmQ3QT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a71459-88fb-471a-e41d-08de740ac746
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 01:11:17.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bGt+PyZurQTRO3IBPLvV3HqwbULabrB100ehcnPkdm6bCbCARoR4U2nzrm7JY0KB+FHtbfM21357Eny+aJA0tW8b1kIHeiWyED3SxX2zj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5922
X-OriginatorOrg: intel.com

On 2/24/2026 4:55 PM, Mi, Dapeng wrote:
> 
> Thanks, 'xregs' is a good word. But considering current naming convention
> in arch/x86/events/core.c, I would add the "x86_pmu" prefix

Do you know or can explain the purpose of that prefix on every function 
there? Is it for 'git grep x86_pmu'? But that's probably useful for 
those in a header file. Looks like just make it longer without good reason.

