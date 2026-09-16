Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3644E67E;
	Wed, 16 Sep 2026 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595359; cv=fail; b=O/OUkFbkY/wPGYwYwvPHGNDy0JPIwsxgtA3QO39eLxCFGpdU6XnQTtkQquDaPIiu3jNhlVhgftcLXeD1QP1xh8r/glVyKw9xgVVl+MQMd4EBCGtJShDFos/nm7VCoLvQ5jjvNM3SUGKAfm4WUq9ZnrTtidsai8tmFZsKWlXuI9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595359; c=relaxed/simple;
	bh=M9ApwxwzhmVNUIOm3iurEiHP3WW4WfMfp3Ul27rPu6U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dB+/Jaze36xJF8CIMg1yMVHj83KW1dH/yANgBZ32KBF+M9lisnqpoLMwnBOpvC+nI2/3Ga3QsQwP9KzaHPgTn3T5BLNPMlIcS0VHH1SONm0ZDogEW1SDIchU3PlpqR5sfYHPjhTClNnwCcssizg73pt7y5fLxUy++BODAGEqniI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2qMXiaA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2qMXiaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789595337; x=1821131337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M9ApwxwzhmVNUIOm3iurEiHP3WW4WfMfp3Ul27rPu6U=;
  b=F2qMXiaABpqW6RSkcbY7CHBxxDVNgP+Nk1klHd9WWX7L/zrDML6w/Zpu
   /SiFYyOd3fTy6cd0tpBA6EIaw301TH9POkGBGayyhw8KmAQ8JtM9+rV2R
   WOBqSTeVLaRKYbcAS8QQZGwNMFkJ/kk0zsNHO0Hv43nlsjJxk3IabCts0
   d21Xf9J6FS6LDK5NxP+MC4zB7AS/weNbKucTH8RFAVU2OKzBAOckJaNlc
   bQEW6TpdMyECl3/63cTcbc1DWWryydcumsxd1ntVLJ1YVsPEN+6yPXWGe
   e8J6MfW83DhQnuPQO/bBwOEwRKMAn5RJ2q04GJLmXEBwNM3/9lRsOr2Xf
   w==;
X-CSE-ConnectionGUID: kpX50fC2SyGoYipFZzcrKg==
X-CSE-MsgGUID: 4l41p6hXRLar9vLkWqzjCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107349827"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107349827"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:48:53 -0700
X-CSE-ConnectionGUID: XvO3t/B5Tey7Bj2cckYV+g==
X-CSE-MsgGUID: G8niXOF9QwitxTBCFrtPXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270828451"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:48:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 14:48:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 14:48:52 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 14:48:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qyo+ttBACHmqV1+EFkQt89Srl0eRikkbdDwFmZalfTC3SW+IZj/zeh6XlVcUIYRWtN020G87nlAMBRlgyazKTu0huNoFx3OkWlRaAfxwkOlWA58pR05R9HHvM/Qn5J3l4CPCfMfte6g/c7y9oUbTR3CsHRcp8S9uwoSjUmCr8DBu0oPJfcOvs+c+BP8bNTHlw0OMVVecNYl6uM8bO8h4m/eM5baBR5ySPnXMwPFfYID/GpRgWvvMlnD1UiYWpX/8UwZpG4mCkT2z7+UNjIxq+4ljNnC7LuGu/rXgyReGxrK1jvzHNMJL3opX0aOo69rZThpsLF7F18PyEj9l/nX56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC2IYbqkyZzz4F5ye8LOtLxCgdJIxU1GTLx7VpqTTJA=;
 b=skXYR4Wc9EygWozTYIjmfq0GXX2zH/UF99AnpR+/iJX979erAynO3u5DIh33gNKw4uuyNlhkn++Ji9hr2UifL5kU/YR0MCvElcnBAhfT4qnaYCUHrbX4Xwqsp6vBEqD1s+IFwQq8uc6Q18564qWBcykXHKE/op4lLDvhX1H2Pa61tOqpn/V8I9wQ6A9poJIcJg7UTBo9IL7zHtm4A95/WHbL9P6rGekr2bByGfU4RQfZOoWVF0o7SD3DyBP6AbZY4oJ/3ksaJCBT8FlY5ytL0FdtlqtLE1Shtz1TMUSkLRjFtIbjqHfHJATioJw6c826s+9NXxnvOVpyJdzoVtWR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22)
 by PH3PPFD114713BA.namprd11.prod.outlook.com (2603:10b6:518:1::d50) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 21:48:46 +0000
Received: from DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::f3ff:11d0:7a52:db0c]) by DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::f3ff:11d0:7a52:db0c%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 21:48:46 +0000
Message-ID: <1d6c8cd5-76e9-421c-9e36-3de7c2816d27@intel.com>
Date: Wed, 16 Sep 2026 14:48:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf: Add checks to prevent null ptr access
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Andi Kleen
	<ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
 <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
 <f2b62bcb-b5a1-48e9-93c8-644ab3ac4439@linux.intel.com>
Content-Language: en-US
From: "Belgaumkar, Vinay" <vinay.belgaumkar@intel.com>
In-Reply-To: <f2b62bcb-b5a1-48e9-93c8-644ab3ac4439@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To DM4PR11MB7757.namprd11.prod.outlook.com
 (2603:10b6:8:103::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7757:EE_|PH3PPFD114713BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 814670ee-fc12-4a3f-b351-08df143c48b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|921020|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 1AfARR9emk7KfTuYiWxE+1utc0G8bxyQ9+bbGHutqxn0XqUH8TdfiM+DeA0IeehShsqPoIoU5VtzAUTFiDbwq4eUyU0BDQpIGC1DtwRswyG9fuEezjXPtmEn5xVor2r3nrPIJEOyllRvHHuhRGi6A0GBKI9LZEPti3PbtppxGr06evFO3su87r+0ujZwneHhogYYusSzj+4JlnQhCl+ue/wWEkG2HJUayjhLir0wcu6r7aTVux1bov4cMyvWr33UCzPGpXL7gFgFGe9tqWVF4SSQ3145kuZhWapN92ovel+0n67lKYqccVeBN+grKkM3UAZ+rbNE13/WVtXXurSdbo0ygZjNlLy5pzbgDGrP7v+KbOPYiZyuBnTKE3AbCvu8+fz6dxFfhKo981WYLSMl0Fx0F0Jo6vF8f6VJub9DjdlyGK1HlWb2wF/iKpb2pofjjgkSMgibPRhJz89OEQ1nF98djkItZsxjQIa8XV6ZXwIpvauRgeY4kbR7wWS8sA9LBOr2+fAgpwmEaLwxJnBZg7ELkRZZuIsra/3kLW6J40ec5Ke1MB6Fsit05xJlQff66RG0A7ntaIG3cW65AhRWvoVphUzk/Ftb/9Nw3valMKf65tRVmgfGop3PeetgGBelY4BpLCUJMDACeI/8TlUchDVUXVDl7dwTbBMTNqmF2qUGqODJuj2ESrTLs2/fMuNC3gKfNx7iR+sWmWq72Wdz9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB7757.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(921020)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEsxZnhrSDIzYlh5NWowb1RHUWVRZE5iY3hYdURtMzRmbk9DSDZVWDJid0Jo?=
 =?utf-8?B?b2kxVFNWVjM5OHU5QVh6YXNISzE1WmdTMTNJZ0hoRGVhNmJaYnpvNm9mR01n?=
 =?utf-8?B?cVMwNkVZSnoyTm0yQkZrZlk1NFhZb0g0MFluN3FsNXVDTzIxZmd0ZDhrRTJ2?=
 =?utf-8?B?a2NnR0ExbXYyZGFqeE91aW5OWGJjTG5UQkpGeEw1bXlrZmtMdGhaeG9zd0g0?=
 =?utf-8?B?aFlwbVVsU3l0SmlnTnVmNXhFZVVyRlV1bWMzRVRuSW41N0Z5cjM3UGZ2ZUh4?=
 =?utf-8?B?bldMU0tZMlRRbzVYUUNtQU1sWGpUK3lPczVZdlVzUGFTN0w3bi9uQWJLWWts?=
 =?utf-8?B?WlZzZHRlMlZMV0FkN2Y1d2RhdUE0bGZLbjRySFRWTmpYTXoybGJXcnAraVQx?=
 =?utf-8?B?N0ZFbEk2b3g3T3ZhL0xWOGJQNm9xUjZIZXhDWWZFdVdLQVFPVEtyUjdyUW1v?=
 =?utf-8?B?RFBnT0tYTXdLUFpRaG1sT01oUUhuQkxxZS9ZK2FpNk92cmlVTUNSc2JwR2JY?=
 =?utf-8?B?cVdYeXJHZ3E1TlpUamt3MHNOK1phUmgvYXQ1MUZqK05EV2U2TEViaHN3eWJt?=
 =?utf-8?B?TFJWdStCenE1b1VCTHhnWEFYRjIvNXlDRy8xNzhWcmVJK0dPVmw3b0MrZ09w?=
 =?utf-8?B?eHg1ZllMaG9MUWVLbm1lM2wyT0liN3ZzSkE2M2RIMDgzZkpiYlJrWHhSck8v?=
 =?utf-8?B?QzYxQUJPb2lJT0IrdjByTVhHMGp2L2V2Vjc4cnhDeXlOSldoRHJyblJycS9I?=
 =?utf-8?B?QkZUcE1FQTRuRU9PMS9uY0lMaHBRZDVOQVQvczlzclE5dnRjY2V5dEtxOTJT?=
 =?utf-8?B?S3V0ZmJNSmF4QnhqMHgwejlveGRmVXdtMW5nQ1BJanV0RVlET0JSZzQwa1cz?=
 =?utf-8?B?RjVvZ1VYOW5FeVdUUGlhV0ViUFJwbkFDd3BET3JwVHRBQ3lRMVd5K0llSVFa?=
 =?utf-8?B?a1hPc2EyK0tkQ2oyenZrOWg0dEJWak9UUTNKODJrdjVSa3hqR2Rqb0wveExY?=
 =?utf-8?B?NUNtUTMwa1NFMEg5MjAyenpZcWIxMlEyYVdIM3JrNXczbG9hWW5GR1hNbTIr?=
 =?utf-8?B?VmJmT0E0bzZqT1d1ckJBS2FYUkZCSncrWDBaZk42ZGl4d041OVZzUVpkdWdj?=
 =?utf-8?B?eEVHNnVNc3duOE94NHV6TTNCbUdGZHBHMEZiazk4NWQ1RHFldnROVUFHMUUz?=
 =?utf-8?B?K2NIemF0cG9vd1JPR1ZMUGhSNWFzRXdQbWxqNWRVcFpIZ2lrZVZVMVAwN0xW?=
 =?utf-8?B?bmJkNXU0cVkwWmFUMUt6MWxSaWVRYk83MmtKNUFvOFVLaElZbkpVVndkQlJn?=
 =?utf-8?B?Y3J4eTBFa05FK0dMb3EzREtsR05ZOVlDTFA2S0hQbVI2a3ZydEpQN1U2YVFm?=
 =?utf-8?B?RjRRbXc0ZGdHY2Zvb0hpS0xtNng1NTZCakc1TVhHUWNraUUyNnE0THQvbWwx?=
 =?utf-8?B?TWRnVnM4Uk9GbDVKbTk1ZGhjc1k0alFtTTlxc1UwZjQzTFlqeEdjNjlmSXJS?=
 =?utf-8?B?cXIxQWxJMVJSOStsNENsUFlWSjREQ2E5VEdaSFZrV1ltVEp5UzhPTXgzK1hV?=
 =?utf-8?B?WG1BUWlqV1ozV2FLQmtUdEZUQ2drLzk3MytXbmdKc21sK04wMWRkcHNNMmha?=
 =?utf-8?B?Q0RXOXdVUEVxQ3VCOHdVYXVzWGhmNTJYcEhEak5WbHdQanRCZ0NVUm1JdTdV?=
 =?utf-8?B?bzhLdjMyZjZQSzQ5eSs3Q29YUzZ6NWl0RlBOUVk0Y245THlCcHVrV0V2MGQ0?=
 =?utf-8?B?akhtNUVBUVIwTG9BL1FLOXdpZEkwNEMyWHVTNHhxcW5aVlN5NzZNbzZpQmRl?=
 =?utf-8?B?Z1BnVHNySThZWnRPanpmMmhYT3A5d0xtc3dmRjl2Ung1U3NXeU9lS3RsNXBh?=
 =?utf-8?B?alNFb2dQNzJDZzZUdTNiZy80UzlwUW5GK2hjOUxmZHpYb0N1NHJRWDNlQ1Jo?=
 =?utf-8?B?MGl2L0JqbVNtZlROTE15ejBzWjlDaFU1UjJuRTMvVzJ5WWZQczgyUVhaZkor?=
 =?utf-8?B?K0FOTEhvRzU3c0VhQXFRaGw3R1NQQTE0ODZNOS9VMkFsZjRpQ3cxT0IySTdx?=
 =?utf-8?B?Rkxla1FDR284cUtKaHcwZktPUkJKaExXWXZJaTQ5Zmc3S2YyZFBiOURFNzEv?=
 =?utf-8?B?aW1rdzJmcHIvd2EyZ29UQVJIeDBQc1pQViszVWNvNXdtOVV5U1c4UUljazM4?=
 =?utf-8?B?aEdPTml5Y0tyOEs3VVF3bXRFR0hYTnlvenVPYW9DenNPa2ozT3NDLzJ0NmQ5?=
 =?utf-8?B?MDJOQjlZVWlrdlhPaUl0aUJ0TktEeTl1dk1xa0tTWkxFOCtXek11aXprdzdk?=
 =?utf-8?B?b01BL3YwWUdtMzRNbzJFVHM2Lzl3NURoajR5K1crL3MxVENqN3VndXROKzFy?=
 =?utf-8?Q?0tm6mFwUrypXYBaY=3D?=
X-Exchange-RoutingPolicyChecked: wDkr3plHaoI8aKuxE9gzJoNkiT1HX2Mcs74z8Sr1yahYkB2QrGiwKAt616LVS0bHZK9l3rBJoa01S7QZ8U1bWxEdN6kkQSC5yCDGUUAmm/d4kZmqd4q9W+g/42aU1nR/diq5ZbopUjtBXtZ2hPUG/LVih6bVGd6LtYObqu0KQm15sF/jhEBdeM39OHiMtBUDRNAjf7mpUWgMilRAdwRXml4OuhVT/SCBAzTMHls6J9FhCJQPbb4GZfLhX2XblSjvZOpInCfhuQ1/xsOC5ahjInaq9NjTy4Pm3ffFkHuIoam6FolYuJcV4uKeANZBrAMkKVi/dols4dX5MryOPVfVzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 814670ee-fc12-4a3f-b351-08df143c48b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7757.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 21:48:46.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYISnQQzYsY9aOmcxI0EQPNRONRqd7TsSfcx0UueraGjOrkzP9txXw/sx29kcILt7QtesrHNy/xp3/LhSqAl2g7KtOEUCmnranLwLi4NRI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD114713BA
X-OriginatorOrg: intel.com


On 9/15/2026 6:40 PM, Mi, Dapeng wrote:
> On 9/5/2026 2:16 AM, Vinay Belgaumkar wrote:
>> Sashiko recommended some additional checks to prevent null pointer
>> access. Check for revoked states inside perf_event_read_local(), as
>> the pmu event may have already been freed at this point. Add a null
> Could you please show where perf_event_read_local() could be called after
> the event is revoked?

perf_event_read_local() is only available to be called in the kernel 
context. So, BPF helpers can call it. This was the scenario outlined by 
Sashiko:

If CPU A calls perf_event_read_local(), disables interrupts, and locklessly
checks event->state, it can pass if the event state is
PERF_EVENT_STATE_INACTIVE.

Concurrently, if CPU B calls perf_pmu_unregister() which leads to
__pmu_detach_event(), it will not send an IPI to synchronize with CPU A
since the event is inactive. CPU B then sets event->state to
PERF_EVENT_STATE_REVOKED and clears event->pmu to NULL.

When CPU A continues and calls __perf_event_read_cpu(event, event->cpu),
if the event has PERF_EV_CAP_READ_SCOPE, it will dereference
event->pmu->scope, which was just set to NULL by CPU B, causing a panic.

So, I think the scenario is- we have a regular perf session ongoing and 
a parallel session (through BPF) that tries to access the same counter.

>
> BTW, the prefix should be "perf/core:" instead of "perf:" by following
> current naming convention.

Sure.

Thanks,

Vinay.

>
> Thanks.
>
>
>> check inside __perf_event_read_cpu() as well before accessing the pmu
>> ptr.
>>
>> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>> ---
>>   kernel/events/core.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7777e82aad5e..059f82f0cadd 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int
>>   
>>   static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>>   {
>> +	struct pmu *pmu = READ_ONCE(event->pmu);
>>   	int local_cpu = smp_processor_id();
>>   	u16 local_pkg, event_pkg;
>>   
>>   	if ((unsigned)event_cpu >= nr_cpu_ids)
>>   		return event_cpu;
>>   
>> +	if (!pmu)
>> +		return -ENODEV;
>> +
>>   	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
>> -		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
>> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope,
>> +										event_cpu);
>>   
>>   		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
>>   			return local_cpu;
>> @@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>>   		goto out;
>>   	}
>>   
>> +	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>>   	/*
>>   	 * Get the event CPU numbers, and adjust them to local if the event is
>>   	 * a per-package event that can be read locally
