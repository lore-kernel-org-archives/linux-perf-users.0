Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27028395ADD;
	Tue, 11 Aug 2026 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462301; cv=fail; b=RoYiD6DWeI8xCWpl6aquX0aNav0xRWu/cKQ2T1pZkgN3gOv/yARk6akOXdAJYN6pcqLJynhFiAQ+Inaa+0y8dtNmBIs9vnn9qhYQ/byJMwE16p6+Eb/zmAINxc+STKAxazGRKfcpOtF8/9zY6zWIyB3uhaLLqHmJABJ9ZMQpS1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462301; c=relaxed/simple;
	bh=u6C/cbmWQ/tg2V+tRao/i3Fsc7ezElvcZ06glk5LRJg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sghaCjG00s6MLQXGpRKnzuCR8hKmaeKAx9QL/KnAcjk7FgX8FHIt4n2oyectq9gVPf44G77nHatRsTrawyabzhcQciBcXXC7gm5qsaJwkI+jBxDdzRI15340i7gviVH3zKphEzKZpPRqrClu37O7npNKRAqaeLZdM9YOZB+gsrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDUjde1H; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDUjde1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786462300; x=1817998300;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u6C/cbmWQ/tg2V+tRao/i3Fsc7ezElvcZ06glk5LRJg=;
  b=mDUjde1HbHwhRhg5M7URGuKdd1yNORZW26dM3fGsiL4nMcaSbocaYXK8
   TgLpHRqVi9p5lKIrUsM0sdI8X/IoebtoZlI5Ibs0f+hiJMKNcbMWtSA+v
   lnCe+A70Ajfie90+urOQoLQB50Qw0kRiQG6FT0fQWC1yRmRgF5GNwRhz6
   js/Gc1glBK3kPalIvPrMFNxfS1iYKZofBSWDL6BhO5osRyIV0gf1Wkc2Z
   rLZJuzsO9MKCmXJHkh1DVvNySmDW8FpcBRqULDPAn4HXX0S9x8qJ8Olam
   nXZWAIK89RS94Rr6Q4J1k+akAu3hwte9uLItMrC4tbeFsAVp2zfChZIrN
   A==;
X-CSE-ConnectionGUID: FmUlm6YNQXqzyD+o/7BizQ==
X-CSE-MsgGUID: szF8LSeGRbOFupOO/NDYNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104527581"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="104527581"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 08:31:39 -0700
X-CSE-ConnectionGUID: 5rrr/U9aQ7ew8jE06mS5rQ==
X-CSE-MsgGUID: n5JNykLfSLOMQdblGhQqMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="263958991"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 08:31:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 08:31:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 08:31:38 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 08:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+HPh7g1v5lcTCMIfpWHSSEhk4wCUNmIi9KEPrGu5NtA6GO2o2Gls3f1R/1BX/DFmDjydlSvWLRSfE4ryWUggK/+xWF4oaU2A4DuunADYX4UNvgne2u3nM/T4L9g7pVgbQoILhr7UVF2fHqo/lfHEcYCTVGJh5OOBW79Vjm/KzJLUq54G/0zsQF4av3txr3Pz62gnL698iao6DC0O6Q+Hvba1+qAcZW1ZspogFNy1REv3lcS2ULGE7rxAjFO0QFY+JFltjAr+ZJ/fUQHmZZAOyQOZY8hgWtM2dkPDSpVIgHOl4w3a6YRRydTZHMZO3z390MB5qpYeRc21ffYvm11vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVvq2WIcimOVDgtE0xT2n+0UibaWpW4BNROJeLI+buQ=;
 b=cEmzO3GDCHsivEh++Qv4uBUl5oHGH1dsu07DDE8Wcz/0du2eC1POfe528WCSqDRGeib08THIOqHJdodMsVw2fqu9lwHgoTTZUKsfqdYTEDa6e4YHOPEE8ugv9rJwH93kij8PFmitNBTxQRFIupGK6mEw5aOXXicn1JWGBIKy1zux2Q2bRTg7xzwKU5fwigOVssGkNAd1+x2t/x6hf11tLaYxUWdFpfCX5V9Eo6C4/yqgJFTcWqNth0Sm3Jvu9d0KE1mH2Ab0JlfoyXNeGytuGMvhan1CSPryYDEHHKMLEpzozmNX1a1xRTamKpIXDXXwtF/2Jxiw/DqPFVROME7qZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 15:31:30 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 15:31:30 +0000
Message-ID: <b1547fe7-255d-43e4-8b0d-34318c331118@intel.com>
Date: Tue, 11 Aug 2026 18:31:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] perf thread-stack: Bound wrapped branch stack copy
To: Amir Ayupov <aaupov@fb.com>, <linux-perf-users@vger.kernel.org>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, John Garry
	<john.g.garry@oracle.com>, "Will Deacon" <will@kernel.org>
CC: <linux-doc@vger.kernel.org>, Mike Leach <mike.leach@arm.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-3-aaupov@fb.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260803090640.2412336-3-aaupov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0295.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::30) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CO1PR11MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 2288d028-3964-4e3d-d108-08def7bd9dd2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|6133799003|56012099006|10067099003|11063799006|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TgPzGb4boIYbt/D4A5SxvO8yPQK5kHEdYtRnffSeHxOhQltNuLggMcokGWrzoL9Y/QEGrOD8Fnm4N0r1aVYP0VO5EVe18NwqwdfBwRmAJJSAJFnk3ntg4wl/I5wMTSpgTf7SQCYUrfPIvFtRpwxx4yv7eUS6tl/SqzG+f2h+bKjF9uJ269bUnEVn2hT+Sosd5D369ez6ywcOEiNmluGi0cpuStB9a32tvuNUdEaIMOHO2xVeLIAgvpaG6fFfGQio/M8kFG8jvnBQbTwXf6xEGcrFV9vBGLeKeH7Cf/RWVddX4ktBCZw2Ag1ziK7/v9ZExPc2SPH0JIm9oOKYOkve0evjNudOWuYn6TtNJ7zAc8suygnH1nxq+sqomfdnBUBZ2CQOjSlPel0u8HCvqqfZiQOGLa9k7/SALF/BnTgN586yS56Qg4utnWB7D39cohmwzG45E0piCK4demFTuo3R39CW7HxtSl6oO74qEcHI40xVYoVk0MuOQ7U1CPbXOQFPvuLKBw7q4Akp27HOPuBr6GRcIwRdpkfcOs9UtgYZQcJ6RjsENIocW+ftiULwtoMAztZtGvoJgSQWAI3jOXdH/QpW6SuwRnTlozfkFd7jk3k60HF5FHFEoRK93jcqOmiXSdQ8N0xE/tPXThYC80Jm5TP3I7xFDut46aWl1fXzN5sXSj8xzj6jNkutM8YrQ1u8gDhJObxMT6UC2NTwDLDBJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJmb1YxR1Q5cUp5OHVxZmEzaTduTTZiVFVibkdlc3Fna1dOUWUrUTkxcStn?=
 =?utf-8?B?S3ZrdkgrOUZ4enMwWEZHR2xzQXNFNWtjb25tQ1ZHa0E2L1Y5M3U2TUptR2I0?=
 =?utf-8?B?czUxY25SUEk1WlpqaUlFTkpZVVpKNHhvYmlRMnp3bUlBbHNLYWl2YTBZbUsv?=
 =?utf-8?B?Yi9YRmVmMjlmMm5QR3dRN21YT0xZYWs3cERPUjZMeTdIai91RXM2THJad2dT?=
 =?utf-8?B?d1FZdUNxNmwzVDVsMjJ2NnpNbnFjWC9ac1Y5Sk9WSmlRbDJveExIbC9naG5H?=
 =?utf-8?B?RE1DWUU0QXRwQlpodk5GTzdlTTVJYnJGd1ZEOXlqc1NCU2NjanRDUnd5dlVR?=
 =?utf-8?B?NytCdEVoTENMSThzVkY3M21haUVXeDNRYlkyNFg3U2FvK2FmaC9UWW4yRWEw?=
 =?utf-8?B?WkNjOGt5M2RKRDZ0Y2ZRU0lUQm1Tbm5nQjFQMXAvWGdpc0Y2YStNMHlueXN2?=
 =?utf-8?B?UUtEWFJqRUJXaHpuNXpUTE9laHo0L3E0QnVKMUtaQWdPNnBDN3o5RDdVTXNY?=
 =?utf-8?B?eXViK3NQU0xrSnhPcU92K1NhZHNiVTlQS0ZHVHRyMGZiZFVrYjFMMjB2MWhh?=
 =?utf-8?B?OW8zNFRWaEdZVXdsNFhJcFFLZ0JKRW5DbWFJdmllSllyREluSGhEcVNBcW9q?=
 =?utf-8?B?QWVmdFZrRHppU1RNYmRzbkdVK3N3NkE2ZHlsWkpvMkVaNlNkMnViY0ZBZFhG?=
 =?utf-8?B?OXdBMkZaekUxTEhyZDUvTzFoandMd2pmNWNyZ3Qvdjc2enVBUDBTcENiUjFM?=
 =?utf-8?B?bW82L2VDRmI3NnV4VE1kQ3VCT1pFZ3RYVHZHWGNnWkdGVnQ2akJaa3VJd1Q3?=
 =?utf-8?B?Smk5YXl2T3IvNTNkYWh6blMvL0hSWmo2SVZOVzdWNHJCUUtvRkxLSFdVMTlU?=
 =?utf-8?B?Q0NkMlFickY5QjdlZ05wUzhaUmx4MUl5QlhlV3kxK2N4eEVtUVVtVVY3OXhD?=
 =?utf-8?B?WG9IMkF6bkloTnhGTG9VTHRvRmtPcS9mL0FLRWZsSkpFRURacEs5ZWdoM05Q?=
 =?utf-8?B?TVBhVm1TZmtHNStjeTJKNStDNnVMMjAzT3dHZ0Y5K1NyRFpJa2xqQU1hVXN5?=
 =?utf-8?B?YlVkeW91RVRpVDJTeEozSkMwWTZxYm8rVkQvOFhSNWlwRUIxNURqWFNHSzlt?=
 =?utf-8?B?bk1sU1ZBekt4Zlo0R0o1NDVVR25JN2wzYUpTRDBwYjl6WVBpU0puNWhwVSs4?=
 =?utf-8?B?UnQwNjBWQlh4dUdsWTlwTDdqZ2ZJdlNpM21HZVovQUIwY09idjFqZk9uVG9w?=
 =?utf-8?B?dlBHeFRSTkkwWkVLZllhZzBvU3g3VCtiR2hoT0FUcEp2eXBPU0lTcXh3TmpD?=
 =?utf-8?B?dUVBMWFLQ1VSNVYyRndIemcxbTRqVHhEZ3lIY1VaekZ6eHhEL0dldFBoMjUv?=
 =?utf-8?B?UDdaTHM1OG8vVjV5NzhDaXV4bjdsZytBVTFiV0MwMDJjYUkwb2NWaURrNkw3?=
 =?utf-8?B?Zm1xMU1SRm91TjY5KzU5cUpPa2NwV2p3QWJGWVN2K212UE00cnp3SWszY0w2?=
 =?utf-8?B?T1MzVzgrZ1hxUjF4Y3JSZ2JNV3hjTExTV2pWOTg0NXNQRXNoNU5ReWx3TlRw?=
 =?utf-8?B?MVA4YTdDeHRLSnNDYjFzYTBua2xQTnhCU05Bb0dGUHJwdzNKZlI0M1BwWFpp?=
 =?utf-8?B?RGs2c0RMTmxUbjZQK043WXVXTUswQktCd2VoUVp6a1AwaWtUTEtadzI0OThz?=
 =?utf-8?B?WVZRNEhOUVVqd0Q2RGtWVTNIMmtTR0hpZzlnYlZWaWNVdHZRSTFzT3ZMTjM3?=
 =?utf-8?B?LzB4YzREa1RWc2R0MmhySVQ1WnluZWxGK1V1V05BVlRpa2NrWUlTaDQ2ejlL?=
 =?utf-8?B?NmpDeXJtaGYrcFpRaEM2ZlhhTlU1VWxqdWJoRUlXN1ZuRDk2TGErdWxLWWlr?=
 =?utf-8?B?Vmd0ZmZoWldKa2J0bWV5N1ZKQ3ZOSWh5Wk8zTDFMVmNYZUlqRFd5cDZNR2lM?=
 =?utf-8?B?Q0lTWUoyUGhUMFJPNTFVM3QzUjdXVFF1UlFuM1lsS2tza0ZNMGpJWFY3Qisr?=
 =?utf-8?B?UWFHcHVLS3JlaStmb0N0RjExVmlxNkFXS1JSejBtdUtmc1V4WWZxREdLVTRy?=
 =?utf-8?B?WFBuNGp2Znk1emo1bFRRUUREbmlIdSs0endRbWlYd2lyWkpnY0VvQjI0M0Iy?=
 =?utf-8?B?ekk1NWQ5Q3c0RXlkSW9RZWhzK0Y5SnNSbUtEYUZnaVhOOWtRQXFsbWJWaG14?=
 =?utf-8?B?TmpJakMrcVJ1d2t5Ry9DeUtxblJ1c2hkNHRtSk1ob1RCUE9VZTRwd2tzdDVV?=
 =?utf-8?B?VThrbXpiTGRGZWJ2a3AwOFZMNG1QQ2dWa2Y2TUtJSjNWQlVCSHUybm4wdlBs?=
 =?utf-8?B?cVhXaFJrSzFrZThCeHNMUFdicU4xaGU3cDVLVGdaWHdDNWlUaDJzTGZsZ1ZW?=
 =?utf-8?Q?Jq10FvdMJkVaNZDM=3D?=
X-Exchange-RoutingPolicyChecked: Bj2In+ASe5NM9t7IIYxd4HkMFnCcTd5vXjot/3t4jrQaPDI9+YgRs/zCp3R/EQH90dDb9UOAGkshzD5jaZfejw991eq/LIN78IQ4m5Msg1F1NEwDqmAJKGi4ibjvzhZvGIxvuhmZmlMbStvqagEh1WPMPFIWplnXrGcQ88KMCpf3He+qBePYIm1t92ugStGy+O9oDifFZpi0hHQw+hoY2dQ6ssCx+nIZQogtQnj+CYpLp8Df0pBgw/gFOkC4Es34B8l7kqsnPWgw2HzwP6xeSt2b78G/vZUU8fT3j+AtEwT3ZzZ5XDtc0tyhmIqhvV7066sezKLpsePt8sSRvk06lA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2288d028-3964-4e3d-d108-08def7bd9dd2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:31:30.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5zOmipCuDOGfCgTlYQAYM7bxxpY7k//w6Nr1XGNP5zSdbtdrBHCjdP1CLyaTNQCUzoT8BVUzR2DXO1w9xXu4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com

On 03/08/2026 12:06, Amir Ayupov wrote:
> When the internal branch ring has wrapped, thread_stack__br_sample()
> computes the number of entries that still fit in the destination:
> 
> 	nr = min(ts->br_stack_pos, sz);
> 
> but then copies ts->br_stack_pos entries regardless, overrunning the
> destination whenever sz is smaller than ts->br_stack_pos.
> 
> No caller can trigger this today: both intel-pt and cs-etm size the
> thread stack ring and the output buffer from the same
> synth_opts.last_branch_sz, so sz is never less than ts->br_stack_sz and
> the two values always agree. It becomes reachable as soon as a caller
> keeps a larger reconstruction ring than the requested output depth,
> which is what --itrace=L does for late branch sampling.
> 
> Copy nr entries instead, so the destination bound is honoured whatever
> the caller asks for.
> 
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>  tools/perf/util/thread-stack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 1a3dffa83bde2..51eaedb47bb1d 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -643,7 +643,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
>  		sz -= nr;
>  		be = &dst->entries[nr];
>  		nr = min(ts->br_stack_pos, sz);
> -		memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
> +		memcpy(be, &src->entries[0], bsz * nr);
>  	}
>  }
>  

Has since been done:

commit ab9c84d1cd59e6b3b73de34982a35a76e3a9b032
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jul 27 13:17:01 2026 -0300

    perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
    
    thread_stack__br_sample() copies the wrap-around portion of the branch
    stack ring buffer with:
    
      nr = min(ts->br_stack_pos, sz);
      memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
    
    'nr' is correctly bounded to min(br_stack_pos, sz) but the memcpy uses
    the unbounded ts->br_stack_pos directly.  When br_stack_pos exceeds
    the remaining destination space 'sz', this writes past the destination
    buffer.
    
    Use 'nr' (the bounded value) in the memcpy size, matching the pattern
    of the first memcpy in the same function.
    
    Fixes: 86d67180b920 ("perf thread-stack: Add branch stack support")
    Reported-by: sashiko-bot <sashiko-bot@kernel.org>
    Assisted-by: Claude:claude-opus-4.6
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Reviewed-by: James Clark <james.clark@linaro.org>
    Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c5ce741b0744..1360f44421ef 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -642,7 +642,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
                sz -= nr;
                be = &dst->entries[nr];
                nr = min(ts->br_stack_pos, sz);
-               memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
+               memcpy(be, &src->entries[0], bsz * nr);
        }
 }

