Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892214F9FB;
	Mon, 20 Oct 2025 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942021; cv=fail; b=dJiov0jhA63qk6kP20ZdRMZKfYvgubL1E/2jK2+Y0QH6ynvYRmidaC+UWgiUXtmQZ1G6k7w5e2qIQpP5XBSlgnQbk2aFZ02oH/uXotqBTH2+k7sP0wf5fL0BRHgCjULbpxtsHvQDemrd9IWF2+zKLhuxNWvY/ZrGqgp3sU+hW6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942021; c=relaxed/simple;
	bh=ALCqH8lsVWGKPYkWvWF37fUVgAwsSrTqEUCJP0/kA+4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iLU9iAZHS6ljDc2kUXjilyGd63AZGL5QGeJTD5jroUVfUlPSLGjWnR6KrLII619V7/MJ9clbBOFgr8IdyaFjxtKyC6M0D7abITlhe7uTXCBNUjWI6eHpw5095UEzTn2ksgu+GhGQks0AZUdOQk+YRVsmZAiNyv/+fnyepIY1wlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcYdbZ1I; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcYdbZ1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760942020; x=1792478020;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ALCqH8lsVWGKPYkWvWF37fUVgAwsSrTqEUCJP0/kA+4=;
  b=BcYdbZ1IyuPwBc1eoSzXchzzSEF7WYe7zemM5NYHlg9TuM1obA4VWlHC
   j8+/KW8YPC/dNPjzJgY1Fr3/g50Oaeo+zNIQmw0jrFMlo4Agd0n4F/sMz
   1ua+VT9KqK2SomG5SEqrIhzbjILeiBP1+dclcv8X9XSu3R4sLCBkNd563
   77kyvfCt0oF/0Owo3A8VZNemCMZzL4KPZxXF42I7mp3TaNC78jS/Q/k/d
   ZD0NYuvt4qWz6SK24mhMgEWAJaoF3kbeYAFlQnNhz4lsPZ12FMy5DgdxQ
   oNKzPzscueRt7LO+wcM12bd9rC+1NVMjrJp4LwiP6w+KPsnS8CRkfbqDs
   g==;
X-CSE-ConnectionGUID: ZiDndWLRTHmIzyJoz+0mUA==
X-CSE-MsgGUID: ChT2OpDlS1mu4XnVitlBMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63152341"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="63152341"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 23:33:39 -0700
X-CSE-ConnectionGUID: vzbWc8o2TOWEqy30L6+Nug==
X-CSE-MsgGUID: b7j4MlflTCe9EKb5kyzkBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="187671105"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 23:33:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 23:33:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 19 Oct 2025 23:33:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 23:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5YMQQQITMxHjUvqqV23YVtvdEaH6TJTCYXtiDDjExUNmgoZreOqMcGx3qHI2utPVRa8l6nkx+KG/9oFWv1OEfSr+7Sy9vt2QEoRA6yJwMsXBhm7q9dyZuoY1pCmDTMDs+N+OGKhPEhxBWa7u2jsXPEKi07RstkC8//eJ4LmpnOgzDNT145bi6im1sJdfnbhVuTpGyNjwlFwkZ6CRoYilb0I1KPVjho+1xBcwgk/Yrx5BS2LZLdBInKNoZcNFlcvKId0lgJGFQyidDuRmiwvIa1pShaaCFtX/CuOYpLTdFb+mS4XPwW8NF9Gg5Q+3TwO47UL6VP3x5p5f4qBXrWz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wybQP3z2alXyzcn43UCgSWgvgqYQbAeRv665NgExjYk=;
 b=HDrxImrTagj7Hs9utmOXdcxL2GbHxZWGnlEGaX+xOPa0RrKcFBIKbEhE+KEdZRtAPNT3BCy8uReyMnNzAuLN84KPGjVDKLiRwXiV1Op5qjWHgr4JxpCAFEZhbCmxSXfTezHRmMdFPZX2NgzHSPLcmOmkwoAZNpusQH1eOuIbodNqBg9Po+N9JX4QrKEnkTpA7F0G+Slz2/3VtAMQ8LSSu0NlZTnuZmUkRCWTkKTEllzuhcb7ldSwEoR05Mj2qdOGQSkAyAer9UezG50gWwSMeRJpk54IcLPVbsefMkEgWqcmsWj3xTgUGUa4CjsYkzE0OePN2Nsk/PyzF+lPeeCmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 06:33:31 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 06:33:31 +0000
Message-ID: <03d24c35-f56a-466f-8af0-aa70ffc838f3@intel.com>
Date: Mon, 20 Oct 2025 14:33:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] perf tools annotate: Align the symbol_annotate
 return code
To: Namhyung Kim <namhyung@kernel.org>
CC: James Clark <james.clark@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<wangyang.guo@intel.com>, <pan.deng@intel.com>, <zhiguo.zhou@intel.com>,
	<jiebin.sun@intel.com>, <thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aPRbfdU92XRLR-2N@google.com>
 <20251020021434.29082-2-tianyou.li@intel.com> <aPW2iiNeheOxDGw8@google.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <aPW2iiNeheOxDGw8@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0028.apcprd04.prod.outlook.com
 (2603:1096:820:e::15) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|PH0PR11MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 959084c0-803a-4a28-29fa-08de0fa2964b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFRyVXdnRTJmZkNmZGc0WmN6VGg1ZWF5Z0VkZFpVeXNZRG5qbE9FVmQ3WVA5?=
 =?utf-8?B?L1VmZDhyVVJ0MmFQYTA5d01WT0xzUmp0WkRpaDJ3bHNWbktrdmJ5Ry9NbUVG?=
 =?utf-8?B?b3crbEh6elFFc29BUEpXQ3hBTisvc3JzRDkvT0Z6c0VFekFBNDBzb29LcTBr?=
 =?utf-8?B?bS9ZNW9uQnVTcFh2cXZDZ0JyLzhUaHhZc1hNazdOb3J2Wm16TTUvUVBGK1kv?=
 =?utf-8?B?VGJ3YWI5Ym1EOWZGbG84UVltb1pLOUtZVTVqS2FIeDIzKzBaMUFSSk5wbyth?=
 =?utf-8?B?Nk1WSTN5Yy84RHlSVUdPSkFyMVMzOVA5VFFUK1EySDU4c1Vyc2lNblZUVG1M?=
 =?utf-8?B?NnJlbzZCV1lDcEtVRVRmK2hYTlB6aDRNdlluVkFWc0hzeDB6dmwyWkp3aXdL?=
 =?utf-8?B?bzZSVWNtVE1OMlJGZ2ZnU2FPQnJxZUN4d0kzVHVyOE1BeWRiNlZ3MXVidVZ4?=
 =?utf-8?B?S0RvT1Y3UkVLZnpRellibWRneUpTSi9kREhpZFZCVjBreURtYjM5SVBkcU12?=
 =?utf-8?B?WjkxOHcyUFdXVDlrTVZyTDdNQ250RXVRaTlkMDRmdXZ2ZnM1ditGTCtCU1RV?=
 =?utf-8?B?SDRWdTdGUUdyOTRUSjVSdTZneXdOeXQ4eHhHMCsyd1QzbldzQVBlT0xrTmJI?=
 =?utf-8?B?Q0JTZFZ4NGhyM1NhRmFJRUlRZ1JPbU0vaG9EOENuWDlSSDMwaU9xUkoyd1Rh?=
 =?utf-8?B?UldqcDkyLzU2aDNmZHpHVHY5V2FFSzhFOGpLWkJJZDNVNDhrZWRZVGlHQmNN?=
 =?utf-8?B?ekNUZzFxSkJseXdBTVhLMnR3ZDhWeHBPMjRraWpaY2RRVW1lVXFYeWgvMTVV?=
 =?utf-8?B?aUtBUGRHaFNTM2NYZ21KTVgxZVY3OE5mK3ZuYlc3d1JVdWJsNWp2VW9sazUw?=
 =?utf-8?B?VU93Ym9VU084dko4b3JXTi9QYkYxMTMzSG9CQWdKTkRCZHNYZC8rQ2pOUUt2?=
 =?utf-8?B?MG04Uk4vQkZWTm5CenFMWC9aVFdVL1pyc05Pd1BHRllvbG1KdkJzMHJadTM5?=
 =?utf-8?B?RzdwQnJ1cC9WQmFsUy8vR2lBb2tJTWRzakRWVUtpVnV5clhQZFFaOWxTbnVw?=
 =?utf-8?B?ZU9YWlR5N01jbHBjd21IU3VRZzdibGVKWUNiL1REK0k2QUdiRnhCbmhFakNM?=
 =?utf-8?B?YWphK1MxRm9tVlRyaGVlamwwN0RTZFN6YzNKRGpsQTd5aHp6bTVHZmJsMGJy?=
 =?utf-8?B?SStIZlZUaVFPbmtGcHJ1WWtEMjI1b0R1bjFKQWVJYlk3cEVkKzAwVUdpek8y?=
 =?utf-8?B?OTdRc0lNWVEveTQ2UUl4Um16c1BLNjJUVkdrbXZsd3RSdkJJSEh5ZWlwNC9r?=
 =?utf-8?B?amhvYURjbHVYb0lFam5menBteU5sdm4wdXVYUTUvUEcxNXNkMHg3c0t4dTNy?=
 =?utf-8?B?cmhvSy9pSHk3SXN3aWswa3NvYjNrWGN2dEJWVkRwODJLR1N1aThTVlpqVXFn?=
 =?utf-8?B?VjdmY0VKeHd4Z1BmVmIvRWt5Y0FrNVhjdUxRYkhuNjlhVkVYUEtqZWtrVmdp?=
 =?utf-8?B?SjJFRnlsWUFKV0lZWmUzT002SVZ1eFJQNGI0SXR3QzNKWnYvdWJoeEVjM3RP?=
 =?utf-8?B?QzdVZTdZWjhsMW1zeURIbStUYU5LM3YzUkVycmNQSDJVVzc3NHBMVlp6KzA4?=
 =?utf-8?B?eDVVUTRWbFRVeXVHdG82TDdPN3FOaXJWWGZRZlpKcTJmdmtqZGx0RmViblcr?=
 =?utf-8?B?K1FFZWd4dHdXVDBtblR5Unc2Vk5ZMVY0VzAwaHZLSDRaU3F5ckZPV2pPTlZx?=
 =?utf-8?B?cEdwVDNxZTlHNEpFeG1qNnhQb3lLSTVndHZEQWxzRWg0dFNWai9FQ3pURStN?=
 =?utf-8?B?VnVQWWNYS0grVnBPdHQwL0ZQWXU5TkxUeVY1Y3lDNUNiUzZROW5BaDhRWjB3?=
 =?utf-8?B?Uk5NWEFwL21RMWZrYTc3OHU2NjBwTDM2Mmd0MHBiUTJUZzVCR29tNnpyTWtl?=
 =?utf-8?Q?lXMWI/K15LV0LqWm94hj1bNzgUhf/Czb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNjakVDWnlZaFRZZitKU2NNc1A0WkxnTE5PcmduaVM3ZFR1aGJEcE5SN2NK?=
 =?utf-8?B?ajN4TUQ1MzRLZFlCOThzRUpZZG90djFVU0pxMnVLcE1zaGZ5dUdDNGlYWE9x?=
 =?utf-8?B?YVA4OHpMcmtoNUdPN0dlUmYwSnk5ZlZiUXI0QXFtSFd3YnZlR1RNajJjaWoz?=
 =?utf-8?B?aUxvQ3Y5YXlBa2tWZFNlKzludUUvejhnZU1xT1VSRVdnODZuVFBJN05wWUlN?=
 =?utf-8?B?U3IydzVhMURacUZ1M2M4S0VqYnk3bG9ybkNrdGdCZURSdHZkYUdrb0M3MnJm?=
 =?utf-8?B?YWY2ZGNvTWZZUnFJVnVaZk5WdFhwejdyVW82K2QycUF0Qy9PRVZrenAyaERR?=
 =?utf-8?B?dk11ZzZQQ3d4dFBmemVMNEpQa1h0cVF1QmRpbXNORmFrWHFIZW5BZDlEL0Ft?=
 =?utf-8?B?dG9ZY2pwc3I2RGtZaGF3dFRGbWlGbndUUTdYaEw1b1MycHBJTDhqZTBlVDE4?=
 =?utf-8?B?NDBOQVo1NkFBQ0U0bXcycVhxVk9OcnhGdUtmM3lOZjZVZDNSeWxSMmdjWFBp?=
 =?utf-8?B?TjZRN21kckY0MDAwRHVUalgvc1hhcjVRbTNhVGpkN0Y3eko0enRyZHlwbUlt?=
 =?utf-8?B?SnF2QThSV3k0OHZ4NGJaamFXM25mSkJzWEZ6Tys5VFgrejhpOVg3dGpLZkpF?=
 =?utf-8?B?MXBKRjR4ZlhDQkZCUE03Y0xtbzJpQUdrRG93bUlrejdvRjRWaGI3QS92SU45?=
 =?utf-8?B?eFRBcFQ0ZzlndHZ4UWJiaTBOeHFEa3lhQ0k2MDU2bzkwNzZwa2kvbWVhMXpL?=
 =?utf-8?B?RmdvOFhkVmtJOElHdnd4a1FiVitPUHNmNEFxUWw5RDlsNW5HdUxNMU93Rlh1?=
 =?utf-8?B?T1hBNjU5NWpWNEZ2YkxjaEU4K0JFOGV0UTFmSVRKZUdIeDlIaC8wRjdZRXFq?=
 =?utf-8?B?MmEzY3lLTkVaRFdDVDZrOU5OR3g2S3M1KytHYnZzNGhqbUNrSWtEVmgzZTVG?=
 =?utf-8?B?QzQ1S053cERwVnlFZ3B5eUxnMXZsZ2Q1alJJU3JzZ0VHOEd4ZnB3Tm5QbElr?=
 =?utf-8?B?cm10a25PMFV0Z0U5SXBEdDNyR2hYWFg3RGRsOE42NmE0azJBNEhGcmxsNHdz?=
 =?utf-8?B?RU9RODRVQWw1V2FOQlpBUUt2QmxhS0ZiNWpvbUg3TFpjVDQ0bWRKQllKNUgw?=
 =?utf-8?B?SzJGSSszcXhLQ1NJbmE0T0huYUpzZDVxS2FKeCtjdW9idkpqb1ZOZjJpOUlJ?=
 =?utf-8?B?c3VzT04zREdxaW5vMy90N0laM21IYkloTmpUQU4yS0N6L1dCd1dSNU5ZZWtB?=
 =?utf-8?B?bnMzbFZ5cFBCZFVrcU43NUVMNi9BV3ZlVEtNRnV2QXREVmtUaUJQNUp4OHl0?=
 =?utf-8?B?b1h4T2NQYW80d21jcGxTOWphT0hTeXk3STBCRkphcjQxd201RjVPenQ0d2dO?=
 =?utf-8?B?SjJyaERkaklEbnJkNnQxVSt6Y3k0M25wd2paTzZTelpSNEM2SnlQdmUyWW42?=
 =?utf-8?B?U1BOTXZ6UCt2Vlh6aXJjUG4vRi9CT1NJNzBYQ3FqVmVUZDlxWGU0OE91M0lV?=
 =?utf-8?B?cWJQZ00wYWNaKzZhSDRWY0IyNis3Rmg4L3VuNFFHU2M2ajZRS1Z6Z1ZMdVVs?=
 =?utf-8?B?dWdiWE55R0VlSDVnek1RenN3Y0dqNVFYTEpQamdPbnRpQ0FKOE0wTitsZlJs?=
 =?utf-8?B?NWdqVDQxbEs0VHlmUEVOcHQxL2pNRi94bkpsclk1bnZkZElGMjZ1WXQ0Z3R2?=
 =?utf-8?B?azhuRFFUUVRyYXNydDZWN0pJdGk0eTY2Uks2bjVWMzVhK3JtaHF6TWxST25t?=
 =?utf-8?B?N0lnMDdPbVZGL0xaNW1ZeDVEU2FNMjlRVVV5alFQcmR0cHdrNmRMTkU4dFVG?=
 =?utf-8?B?aklwZkxGdVFJRzBuMjRjU0NlSkxseGdPSmE1ajFGWTlYS1EvYjdrUDdaQzNT?=
 =?utf-8?B?NjZSU0F6SWRRYTc0dm5yVmR5SmxUYm4xM282Rjdlc1UybXpLRW5hTUpJdCs1?=
 =?utf-8?B?aGVrRmtvQ0l0bG11SFZvQ3huSk4zVzI2VDk2SlBoeUJKUEIxZkJnZUpYNTBt?=
 =?utf-8?B?Rzl5dzlGR1RSQ3NXck9YamdEbnhTWHJjTzB3Mm01Tk9zcWt6akRkeDJ6dlZB?=
 =?utf-8?B?bW9tNjd0Q0RCdUFYUS9HYVV6UXNCZmlFaXMvdnJWelJqcTdiU0JYbG5xUThn?=
 =?utf-8?Q?1VJ3uzDHt0vUfMj3E+vKXXj1W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 959084c0-803a-4a28-29fa-08de0fa2964b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 06:33:31.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1xe1zl+cE77E9GbWoHrS8mhm4Y8BKePyu8xynotdHnrW2avYOHtkiC2XLxN/fC1nP4/rWOPXRSVODMt8ObF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
X-OriginatorOrg: intel.com

Hi Namhyung,


On 10/20/2025 12:11 PM, Namhyung Kim wrote:
> On Mon, Oct 20, 2025 at 10:14:34AM +0800, Tianyou Li wrote:
>> Return error code from the symbol_annotate previously checks the
>> evsel__get_arch from '<0', now to '!=0'.
>>
>> Suggested-by: James Clark <james.clark@linaro.org>
>> Tested-by: Namhyung Kim <namhyung@kernel.org>
> This 'Tested-by' tag belongs to the patch 1 instead of this.  And you
> can add my ack here.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>

Thanks Namhyung, will send the patch v4 soon. Thanks.


>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>> ---
>>   tools/perf/util/annotate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 39d6594850f1..859e802a1e5e 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -1021,7 +1021,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>>   	int err, nr;
>>   
>>   	err = evsel__get_arch(evsel, &arch);
>> -	if (err < 0)
>> +	if (err)
>>   		return err;
>>   
>>   	if (parch)
>> -- 
>> 2.47.1
>>
