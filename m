Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD81D6AA;
	Sun, 15 Feb 2026 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199947; cv=fail; b=iyu9XwmSzXvBNlBJNME6hfQ1pxM2lIJIaheJzTvbWt0d2kz1K5Vh0+GdyyDbtn1n4DZsrLFh77o9vzwnA8OKf5bPvS8tpuKeV6q2OIYJ4OjNz1uwgHYApmmANLlI4uXaPP+LY0wEGZVi4xwomcxss6KaU7tGg5kcQficMMl73MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199947; c=relaxed/simple;
	bh=O21wsvxqGNirRi27eh8uU1fDMg398VmC7ssLB2ycubI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TyNU47MTVu2tHi/OjXTNOseubS7dCZpfmXMWV9f1VGiq0G0x5xepnp2Av07cS1uoL7C0c68FJ94CplAHBtHoPw9wWm8T9hiT4H1pMI5vm/uAX3M7nuB/d1c3QoAmeZWoe5nDd8snanBwQo9pDmMcJ3nM9uLQ6YWQrMYM2K8ac20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gy/Zy9MS; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gy/Zy9MS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771199946; x=1802735946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O21wsvxqGNirRi27eh8uU1fDMg398VmC7ssLB2ycubI=;
  b=Gy/Zy9MSpDAxB7H7eG3MRstMpgKgrOvINvI1G/zV0YeIn0Ami+y7gbGt
   w+fT/NtrTvLqm+lw/KNezkUbjIgYJywUVwCJunmSYzPXWa/LniR3WSdAS
   Mlod/Oo9JcrEhlfclHUj6KXcgihLcdl+75IJdgkvIvHSvdaOmPjNb/GD2
   bDNxM59aGIayQlsP+0I0Hy4sKHk8ndDYqK8deeSkLK94DacugXIyJ10zp
   uXKM5ses89nSDfUjrs8GyOYFEYDgWGZSHE4fnwU1a4fui2+xk8GDEakM1
   RF+hYCH4z0m/5QT7HMrAg0UwmtIcIKWPX4WgqCvpzwz6DHptpoACI7ULr
   g==;
X-CSE-ConnectionGUID: 6CaodE8XTlae3sA0y93UBg==
X-CSE-MsgGUID: llbYsWxYRhyHEcw/BtcOKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72383584"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="72383584"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 15:59:06 -0800
X-CSE-ConnectionGUID: 7sUGD5THT0u4IdZ8aDbbhw==
X-CSE-MsgGUID: W9ha+zSOSWqyqJpEVaPMCw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 15:59:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 15 Feb 2026 15:59:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 15 Feb 2026 15:59:05 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 15 Feb 2026 15:59:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laxmh2c+ygHaEEWLP7HQUhOxqs58saqx2zKc9yu6lngZcypBapNbAJ0ATM86sMn9nmguipzP/hb8vgpoOODLpeVBIEOUMSdiRBClvHOyWZ2eVs+2G/y4zZhpZAHhHwl3lYTMU/Cmusjb8BEODCtEDPk77lgsTaqbKyumkbp7ncj5xbuxRqpjMRow1/syUPCjB+qmY+ob6DJeE/1W3OV8zyOaPTD1rrUZvlj0/4iobW8UNfUF+u4I2kRhHwMle1uQpHuVVIe40TSIm/wFukzxvlj4XFamvCr0yxKWiiUv/dXHYqFyfhccAVyYjn0BSacrPoxtAfMVqn+t3SAOjFpHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzsvErnFirZsmZqp4iUE4Wb6syhbFzttqrLqpVwU3Ls=;
 b=jY++o+hbN4/M9qaU302h3p6xSZ9S6+0x3T6/Na/knScE0IY6qf9IRBZJad8Q3GZZ9LqM/UYy9gIuR+pOroZUu9N+dzeaXBumchrS4JNjbrTj1vioYH4QCl/IH6KVJKKo/+vXEArM12sefLDS+awDIXKiFJMXkrkYCS19xtXPPUGZ8WN4ksgJxIAMF/Q842BkJEcgkJTjyi28gSxdgU6tvvgi1pcrX9LRQoEF0VAx/DVNidaz6mrFeq482PV185ldRhBfU7NuIFfHcToT6Y6Bsj4iQM3Z1xTYkefKlE9FqVpQBlcOtEAfprEIOOis3WvQhzhNNN529xXVr+Xi+fFogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM4PR11MB6213.namprd11.prod.outlook.com (2603:10b6:8:ae::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Sun, 15 Feb 2026 23:59:02 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9587.017; Sun, 15 Feb 2026
 23:59:02 +0000
Message-ID: <c287e7fb-d504-46fe-b6dc-af28c3532be6@intel.com>
Date: Sun, 15 Feb 2026 15:58:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 10/22] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
To: Dapeng Mi <dapeng1.mi@linux.intel.com>, Peter Zijlstra
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
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260209072047.2180332-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:a03:338::23) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM4PR11MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 816a0ded-1400-4679-25de-08de6cee31aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUtGaUpudzEwWXZtZVB3ZzgyR05udjNWYnp0S2JLSXRKaWhxbnJiZ3AxK3By?=
 =?utf-8?B?QXhrSE9LZitaVEFxdmRVdUxVYm5iam5SUDRPZmJpSThiR3AxaG8wL2tYcTlC?=
 =?utf-8?B?T1o1UGhRNFpweXZHZUJyUlJBVzBNZGF0U1FXa3RyWm1IU005Ni9iYTczSWxB?=
 =?utf-8?B?WGpoVlRSN3NNc2JxZStkN0lzUmFLZlplNXU3bE1EUHFiSDFPM1RUVTBOZ0lU?=
 =?utf-8?B?TGcwdzEyb3FkaWplZG1xVW5FamVzT0RKcGlYc2MrZE45blNXU1J1ZVpVaVE2?=
 =?utf-8?B?K3M4RGU3ZGxPK1hqeXkwWUFibkd5VG9pN21sZDFaWXNzc0UwMXdWUFlKd3ZU?=
 =?utf-8?B?cXQvQm9qYVZraXJEZ3NLYld0QTZESmxNaXJWblFuanRKRjF2TDFTbHZWVERk?=
 =?utf-8?B?MGozU0FEa1I0QWtkMTdkYjZUd0xiM3IybGkyV0xKRVFKdGo0K0N2NjdleGRQ?=
 =?utf-8?B?NVpjT0g2Wjl4VHh4OVh5WWx3bFFaVUxkK3VoQm9lTTRRMlBzRnFVK2dWTE9o?=
 =?utf-8?B?RCt3SHZNajRKdUthdmI2V0NNL3RIMXZnMlV0OG9YODVRL2cwTkNXU3hZOS9Z?=
 =?utf-8?B?YnlRdEJrT09ZM0MwdThId0EvUzJ4d3JwelYwNFFXQTNwbmZHeDBjdExQZE5z?=
 =?utf-8?B?TGVUekFETTM0dEJDNGsyZXhpem1CODlwSWRETGFxc292TUxSQ0pwMzJUZjRj?=
 =?utf-8?B?V05tb2RsZXVGSzRlU05lYzFTb1h3ZVcvakV3ckM0aFhSbXVjMDkrTlRZYm82?=
 =?utf-8?B?aCtxaG1XK29BZU4ySVhNVUNhZVNuazdLS2g1KzlEZG9xOUh6dUgzRjZha2o3?=
 =?utf-8?B?SDdkSUZTdnczYzh3Unk5UkN4RmlERkFZYkpBbXN2MERYZkFIbWZYMytKSzdm?=
 =?utf-8?B?eXFEQ1c0a3FTRnl4NVA2c01DZ2htYUxjMU9nZXNJN2hDcHQvMlpwclEzV0dC?=
 =?utf-8?B?SXpuS3dhaXVjMFBiaHpKWGk2aUFMSlA1Y3A5YzRLWjRENmdtTVdGQzc1aU1Y?=
 =?utf-8?B?RkNzY2IyK1I3N3pIcWFka0JaeTNWaXVnUm0wTTA0cTl5ODQxVlFyYmVwcEsr?=
 =?utf-8?B?bmFwWkJtM1FMakVBL1B5dFYzRlk5NkdpRlR5eTV4U1drbWFZSFVEVUNyZUx3?=
 =?utf-8?B?V3dFQU55WTdiMTNlK2RVVDg3ME5pZXV5VWNqaWxxRXRuRU9JcjNZRzZSYzZ5?=
 =?utf-8?B?MkZ3NXpkQU4rSmJEb2RjWEpmZDI5RzBxR3Q3bDVkZXVJdjNEcisvMVlsS0FW?=
 =?utf-8?B?ZlNUdTkyNzJoZS9zdTlremxEbklnZ0NCc3Z1YUdMR1VFdGx3Zmp2WC9yMGRW?=
 =?utf-8?B?SUNFckhiYU1sazloMGx5cFZoWnlSWVRUdlZpTjUrZnpNMTZqVXl4Nk9PN01r?=
 =?utf-8?B?QUVxVVNib0NLL0U5dlQ5eHVYcWlVZXM3NjJRYkJZRHMzNTlqa29YcWVyMXRS?=
 =?utf-8?B?a0o3QVRHc0VxRFNTY0NjdkMwMFFDZGNOWWthd2dSRjl3UEx0QkgwcmZJNXgw?=
 =?utf-8?B?bEY0NnkrSCtkbGpQN2VFcDNFVTlOSFpvTXg1QTNPNWV1RllTbDFGNENONE1V?=
 =?utf-8?B?aUxyUFA4d3FHSFBVWUd3ZG0vWUd0ZFFXZ3hqbFNlMFBzZHQyVk8yQnNUZHlh?=
 =?utf-8?B?OEtNbDRSTDZLY0dnUTcraWkrcE9EWXUyTG9VWXFxeGZjNzhhRDNvSlh1Mk5N?=
 =?utf-8?B?VHJCK2JmRXF0TXc0cHg4cjdydnMrNW5MQzhra0R5N0tjRmQ0aWE5U0V1UCs3?=
 =?utf-8?B?VVlvamdFaFUveHBTZ2F1NDgxYnVjRzRNYlVZa3lLTmhvcTNhTE4zOVozWHFo?=
 =?utf-8?B?QytCV0FSU2Y5TzNibktKQnBYRWd3ZnBhWVp1bGI4NFVkZ0kzYkFVMkZmanV4?=
 =?utf-8?B?ZVhqdVZ6MHBzbWpZN1Q4MnhIMys2Sm5KV3l0OGdtSzJNQTJJZC9oUEw4T29s?=
 =?utf-8?B?aG5neEhTTjBQaExYVkQ0ZUQyMjErS3paa2V2cld6bUFYUzEwYVNaak5xM2tM?=
 =?utf-8?B?ejRCNjBZZFlVYXN1REtBM1c0dHN0Zkg4elZwZDlkRm1DSXk3Z3hsOFJwZU9C?=
 =?utf-8?B?Y2J3UGxpSkl3Q0lqTkZkczFjUzZhSDZZVWRpbkd4WmJteW1pUWF5UFZlRlpE?=
 =?utf-8?B?RXpxbCs0YmRKeVpGNjhkNS9iQnVQMWxLLys0dHdTL3JYKys3RDFtQ3ptNHcx?=
 =?utf-8?B?Smc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTkzSmlxVVYyWVFXbFJIUE4wcjh0YjRWN1pPbGZwaFRnamI2YVh0Y2RFanRH?=
 =?utf-8?B?L0IzRi95TUc0WDdGdzNXYUIyQkkwKzRadWwySkJ3VVU2eFRUdGRyQXltbWRP?=
 =?utf-8?B?T2VNQjlpdU5nWFZ1TmpWU09JT2Ywdi93ZmluaDZBbzRPcUdzTGdCem8rYitz?=
 =?utf-8?B?ZVVTQWNEb2kxb1lRSjl4SXh6UzdCMlh0bXc1b05VSFZVSVZicVFESlQ5dWNx?=
 =?utf-8?B?OWJwTGhLTzQ5RUQ2MEZpc1EyY01ScERWaE1KS1ZxcWQ0aVg0bUx2YW9wY1BY?=
 =?utf-8?B?Vzc1Q1J5MDAwM3FMK0RCNzJHaFVuOGR1TGZXS29YUUI0RHBqaUJsdHdJNEs1?=
 =?utf-8?B?UllXRzV2TUhhUzB4Y2tKbDZQY0JhK0JLUmQ5ODJUd25PNXpQTnRpZ052Mkgv?=
 =?utf-8?B?TXNHem45N2lMVitaeDFGdXlDYTZVa3g1UHZqU1hwMCtkdk1SaUljemcrSFh0?=
 =?utf-8?B?SFQ4N01YS29EM0FPTzRXem83NHdYeG1kTzJRWVROQkR2WFJ6WHMxb3h5VTQ4?=
 =?utf-8?B?U3RQNGRUK1ZBTEVSMjFheWZKTklBV2F6STNsV1U0RHlobGhkL1BJSENlVUE2?=
 =?utf-8?B?dGE0NG1hUUlYNDhEYkxzb2grcy85RnZpN0xIM05lZ0pGQWZ4WTEzb0NrRXlF?=
 =?utf-8?B?OGJWUkRwamM0SDZLcjRaVGFnY0I5L2M1eVROQm91TnJhT1BLU0RIQ3hWeVBW?=
 =?utf-8?B?ZmpaNy9HbE9rcTkwczZoYjF6M1NwY0syNHB5SWRaM2lOTUJ6dXJFcXJIa2dR?=
 =?utf-8?B?cGtLRDk5Y2hqalk3MXlnMDB0WmFwV01lL1dSTkEwejY2eVEvYVo3OU9qaGZQ?=
 =?utf-8?B?NmtIVHYydVRQb2tlTlJYcDhQc1ZuREZrODhsam5mMm5lbUoxRTRDZDl4TVgy?=
 =?utf-8?B?aEZsc0NNM05lZnVPd1QxY2RVQ1NhM3RPbVBDcUxYMnJDemZxYktsTEdjRnU0?=
 =?utf-8?B?cFRVbkZtd0l5dndCT3R5dHNNeXcvbER1MmJkbUFQMmFTRXg1MjQyU2tRaXox?=
 =?utf-8?B?N1VmTGdsY0UvdUlrbmJqTkVBS0tURnVIemhxOTRmTjY2dUhINXFVWkYzOXYv?=
 =?utf-8?B?Z3BESWNLcExHaXJWdTMxcjd4RGJnZndGdHhOeURuRFZsMHBRZVBvUmRDSm9x?=
 =?utf-8?B?N29MZUV2eldnWEwwQmdnZVFnWGNXdExrWitEbnpPZzBSWEdUVjdvU0lQdmFy?=
 =?utf-8?B?MGQxQUVwL2FDQUxzTXducDVodlZRbW5sb3ZxUFlwajA1c01vK2xuQ2NHcGhZ?=
 =?utf-8?B?MndiaUpDUmZ5UzdXOWdJc1BhREVyeUwvNEFmK2NDeHA1YlJ4SFh1YTBJMkVB?=
 =?utf-8?B?NjVCV0VSYkc0K0RNVXJjcTJIVTBQVDFBTkh5NzB3TkhsMTBMbFNYaFQra1Nn?=
 =?utf-8?B?SW9obngwZkhXR2swbDU1SHN3b2IzUjh0cmtmTlBSaUZmdGo1WGhlbzZaaTRr?=
 =?utf-8?B?ejhsTTZ5MjgvRXFTdUpwOUZRWlN1VVo2QWZrcG9XempqUEhYMWs2RnNoY0xr?=
 =?utf-8?B?ZnVRTHI3YU5rRHZsQ1lRWWQxTTlzQXhyU3VhQ2lxUFU1YjRrU2dCb0tsc0RV?=
 =?utf-8?B?UWZOa2xaTExvbEdyWE40Y1hTZmwvbS83Wi9ldUtXeFJMN3hydjZSTVdVSTVE?=
 =?utf-8?B?K05QQS90aXRLdGRyckp2ZTJpQ2ZmcmQzTDNhQ1JkdE1KS1hZNTNaQjh5N3hm?=
 =?utf-8?B?Z1lnSksvQ0hMbXAxWGRKQXQ2R2NxaGRaQTVSTUV4UjIwZ0ZSaGZ4QU1PWVE5?=
 =?utf-8?B?NCtOcENTc005TkV4Wjd0OFNXbFhhOWFBdlovaGU3N3dpQmJiM09uTEg5dzNh?=
 =?utf-8?B?SloxTzhFa1NOL2NKVUdneUNVZFJIdVRoVUs2b0tEUXZlSlFWN3oxTnJYdldS?=
 =?utf-8?B?WGJWN2JkYmpXNHdFMTdQS3ZiRUpnQ0Z0bWdTRmxDNHA4UnIzRXl3eU1ycWZi?=
 =?utf-8?B?OEdreGJKNnFMLzZrQlVBUFNERDA5Y2RpMFNXQTF2UmRXVkY5d3VjbGtERWFF?=
 =?utf-8?B?R0V6OElOaWMrN1preHpYZ2t4TWRwNTI4YXV2Z3dJait3OU54YXRtZ3RXMXhJ?=
 =?utf-8?B?bnE3d1VUVGpBTWViREpIeTdKcWh2L0xqWDkzcHBWdWlBQkxoRlZFOU1uVGpX?=
 =?utf-8?B?K3d4RmlNaWJxbkxWRnBBWnN2NTNuSzhrMEJCdmpXZkZuc2tmdTJKVmxPRzJi?=
 =?utf-8?B?ZHBSekZtTHBsd05CUHhqa3dtRDZrQXExd08wMkJsWDRJWi80NjBaZVF0Vyt1?=
 =?utf-8?B?QlZkcGZrNEd2NEdCWXh6Q004a01SMXZ2OXhZNnRRcnlzZGxZV1NjSXFLeVIz?=
 =?utf-8?B?cE5BSlYvSUtTOXg2dHU3SHF2cFlCdG12QkZPbFhvMkVSSW8xSEoxdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 816a0ded-1400-4679-25de-08de6cee31aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 23:59:02.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybM8kV9E9prd7kavQ50QDn7b+DRSSqWdqWOf/RktlQOuQk94+l/52SeOiQEboCkJ0bBTHpgVsRpcM2KfWddfg8rYNtKekelh/3kC/0qePw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6213
X-OriginatorOrg: intel.com

On 2/8/2026 11:20 PM, Dapeng Mi wrote:
> 
> This patch supports XMM sampling for non-PEBS events in the `REGS_INTR`

Please avoid "This patch".

...

> +static inline void __x86_pmu_sample_ext_regs(u64 mask)
> +{
> +	struct xregs_state *xsave = per_cpu(ext_regs_buf, smp_processor_id());
> +
> +	if (WARN_ON_ONCE(!xsave))
> +		return;
> +
> +	xsaves_nmi(xsave, mask);
> +}
> +
> +static inline void x86_pmu_update_ext_regs(struct x86_perf_regs *perf_regs,
> +					   struct xregs_state *xsave, u64 bitmap)
> +{
> +	u64 mask;
> +
> +	if (!xsave)
> +		return;
> +
> +	/* Filtered by what XSAVE really gives */
> +	mask = bitmap & xsave->header.xfeatures;
> +
> +	if (mask & XFEATURE_MASK_SSE)
> +		perf_regs->xmm_space = xsave->i387.xmm_space;
> +}
> +
> +static void x86_pmu_sample_extended_regs(struct perf_event *event,
> +					 struct perf_sample_data *data,
> +					 struct pt_regs *regs,
> +					 u64 ignore_mask)
> +{

...

> +
> +	if (intr_mask) {
> +		__x86_pmu_sample_ext_regs(intr_mask);
> +		xsave = per_cpu(ext_regs_buf, smp_processor_id());
> +		x86_pmu_update_ext_regs(perf_regs, xsave, intr_mask);

These three lines appear to just update xcomponent's _pointers_ to an 
xsave storage:

   * Retrieve a per-cpu XSAVE buffer if valid
   * Ensure the component's presence against XSTATE_BV
   * Then, update pointers in pref_regs.

which could be done in a function with more descriptive name. Given 
that, I don't think__x86_pmu_sample_ext_regs() has any point. I don't 
understand x86_pmu_sample_extended_regs() naming, either.
