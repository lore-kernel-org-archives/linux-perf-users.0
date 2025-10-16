Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D521DA55;
	Thu, 16 Oct 2025 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585811; cv=fail; b=eJ6RpIwrrUoXidiJp37ndUBBLJ9S6MdOCAi6UtJ1zVPVNklQ88Zz5Fq/KIrG2CGS/wSLYP9KNvZBdy62sKglNniPfn0uol9orxArLWJHhn6v1PhsKMI8Y6BXimpeZVRyVnA2oNIHLq+u9PvfTsnMP3voFQi+rpFOfx4K/O4yZnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585811; c=relaxed/simple;
	bh=LYuAwN0DW0vbOx0sLHi1UcJy2+TIaTsNZzozxLxwPOg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KvkA4oBNTUcQsD8zSNsVCHZKmXE6pLK2pEb57y0z60cahfZgcP39PCz49qTa3hB1z0FTVgA1ODJXaHSmS9fdBIKbT6ztv0hh2k7dxPEW5YL0eB2c3n4rxi+B4qloF6N+MO5jKlm1oJaMYViAEAkh6coF1kACCfaDM27v4JaK01w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tv2L0nTt; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tv2L0nTt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760585810; x=1792121810;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LYuAwN0DW0vbOx0sLHi1UcJy2+TIaTsNZzozxLxwPOg=;
  b=Tv2L0nTtdSt4gdVdfaQtu/SdrPJQAVTbbilJh3y6wdexyIXXA1ks4uLu
   eUvK9oS8KyjXED4KQ8RZ47R8/ndTT63ywcb5AjgjX3PR1Jnby35Ty+Krn
   9TZDQMjpkTo0pemMQmbwv0NcwOTnQR5CIv9Y+09qjOtwPl3qT5hc6QShi
   6FiuNJ12v8gVCGOzGDvPXuZNZy5ByqbOyjMZ3SdGV/PZukWG0nWVSG1Gq
   7dLQIKRyzwwJczHxRDs7RV8BJwBOWdIm6RfUfRR9qWjknDpuRbAWSyHy0
   in1QwwIvVSYZgBTkxiubqlnFXZmTeusNw1ekjvBZxlTBL9z9EqaXlZGFT
   A==;
X-CSE-ConnectionGUID: E+QthtyaRt6dhOZkStzFQg==
X-CSE-MsgGUID: rkuJa1CEQhuhv1xdcpTjGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80211664"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="80211664"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 20:36:49 -0700
X-CSE-ConnectionGUID: z3JoKYSDSlycioMLnucKIw==
X-CSE-MsgGUID: hkSeKw5/SrK6LLWipZstUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="187432706"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 20:36:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 20:36:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 20:36:48 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 20:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuRPH3zkp2Gy2FqVldoaz1UQdymn28cqbsG5J+dpWedLUatNUrPpE1DGhzSn3JNJZBGLikFHTGE0NC2227jegqJigHBCNpe8j7K4hVKE8p6PPsI1ujVae4/ht4L2911rMYwQtJzdvvGGkwjj2z8Y2Dz2S6wG9q6Ou3Z2SeNRTF+f6r7PYM9Cfh6ArRqy1KgAIJc2uXlN1BkfIPlNF7hWgSQ867IIp0LxDGsBbr2rQgWHFCa0xJNVmkawvszFXDlEYoLLBTv1H2NhoEE/eqzI1NaZFL7pwo9mxNMLjReVDkZKdPZaaEWWI9RX1VncKEdqAmZiTrFPZggeS6SCTw6fLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA3athCwcIoL3fwnR2VQNXBR3wiEW88o9q2L5aDNanY=;
 b=HrtktmtujEqIKjtAYmziJVrLauuUNPy2EEdAiLHfeoRd2+R77IvHGwlWDGOG+LeVBlpuwqgRMwOpQ1VkMWemnmb3ofOh3L6B6zAvz3aHBqnsFdfx5pyx7XEt99jwaH02nOCEeRkyoG1h+ghJDoyEf8z48F52PZneIDsoFDILubMPSS5QOO3J/j+LSYSd+B7TB9A6cuqg1YKI3/40ctQw6uqO5RvjMvOKZ6to4N5Kqd/5mSTJQjy4fBYzypYFMLxrEke3Nj76KoM7PxoQUW0gRS9I1ogj35j37iUBezZMPfXx+SSe0EFy7WMElWxJ4GkjEk0f8i9Xj9Je9skkNlrkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 03:36:43 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 03:36:42 +0000
Message-ID: <db33a977-c712-48b7-9be1-83721b23635f@intel.com>
Date: Thu, 16 Oct 2025 11:36:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tools annotate: fix a crash when annotate the
 same symbol with 's' and 'T'
To: James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<wangyang.guo@intel.com>, <pan.deng@intel.com>, <zhiguo.zhou@intel.com>,
	<jiebin.sun@intel.com>, <thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
 <20251015172017.2115213-1-tianyou.li@intel.com>
 <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:820:c::9) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|DS7PR11MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b60473-849f-4fd5-da2e-08de0c65392a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTJHcE0xNFdwSDk5WHFiYlNOMXpuN1hJMWJrRzlIU3F1YWQvWUg4ekRZS2xq?=
 =?utf-8?B?em1STVhKYlIybGthblFDTjJIS3R5Qi9BdklQM1dzajY4RzYxMXZoOVVTOGs1?=
 =?utf-8?B?UUxUc0pPclowSzFTZGtsNHgxT2tqSUJwKzN1c2Z4a1BCUFc1Z1lscUhCRElx?=
 =?utf-8?B?TWdPMEZXN1VmdFJrbkREeUpBRkZ2ZWJ6dGxnWkdwYVR6bTFMOElIbVl0djFn?=
 =?utf-8?B?NmM2bVZsS003NU13K2xMWXMrMmdSVXBUQjJQNCtKKzZjMndSQWtzVnp6NVBV?=
 =?utf-8?B?YndwYnVQdlpTdkhZeWNVWHo4M2VjSjVEVkJYdXpPT0x1bmtGcFVJZlljRGR5?=
 =?utf-8?B?WjdIczdWV0tYWVUvRXY5UzBuS0FiTjBwMlFDczZYd2d0ZXU5R3M0M2JuWitw?=
 =?utf-8?B?djR5MHBWaFkwc01TWUhDdW9JWWJzSkZ4YjBBaEQ0N0p6NFkrbVZZc1VYd2U4?=
 =?utf-8?B?Q0VRNE9PMWM1aU1NeVhpbjBVTU85Y2ZMaVp5TzNmdzc3WERqaXNEY0piY0Ny?=
 =?utf-8?B?cjJrZkY5WEJ6TDdLQXE0OXM4VXJCaDc0WEZORkpsSzhQcXhjQWRCTVFrVmxl?=
 =?utf-8?B?TzNnMHlSd2N2UEpLVTRiRG5WNWJDblltdFVYa0JtVEh1Zno2M1R0OElIS1BS?=
 =?utf-8?B?WXd3aWovNW93dVpTK1ZNZ3NGdEdZUFdjdE00aWY1dWVQYUtWSEtVWUJSRXZw?=
 =?utf-8?B?WTlab0VoaE9zU214RXN3aFdpbzFBWnpKYlJtMjI3MXBsOHZ2S1YwZmxUNmRv?=
 =?utf-8?B?RTdFZk5LcXVrRnlRcm0wYnRXbkd5RXYzeXNlZzh6OFVzVm95TGx4ZXZsNExm?=
 =?utf-8?B?SjhvbmVnVklLc1RvV3crZ3JQZHdyWGNQMW1scGppZFVJR0VKeWxxV01ib21B?=
 =?utf-8?B?amkranpyKzRoT0ZnbVczbTNuWGJ5ekg5UUdMTlF2bG5xeHpQRXdmMUFKbkJW?=
 =?utf-8?B?NDZTUW44WU9RbXM3dlpqeThaOUcwWnpXRU53L2xCcUxYTExFVmtGTGtRditL?=
 =?utf-8?B?Sm9pcUZEdkpuRFVVeWhXZVJBcFIzV0FiTTVLNkhZUmE2YWV2dXRKNmEvcTZV?=
 =?utf-8?B?aVp5QUJMN09IRDJGNkE1U1RnRDlEVU13WmFtZzVhMGFhUWRVeFBtK0tTN2NS?=
 =?utf-8?B?UzI2azBoNkJNaUZIVTNkaTd0eENPNEFkWlpOVy9PcGYxcEx4VzI1OFRnY3hN?=
 =?utf-8?B?Z1Fjd0d6aDVkeWhGWTdjY0JKOVh4cUQ4SXZNcnh0eW9vNDFHRjFQbDZVT1JR?=
 =?utf-8?B?Y3dKU1FsaTNwSzA3Y1F1WVhxU21uVkcrQjc0bXRGekt4dVVxeU05QlNveDZL?=
 =?utf-8?B?MXR0aTNrdmV1dDg4d0x2cDNEeWNQc0pWdWpNbkhFeXl0YkJDSCtldlBOZEQr?=
 =?utf-8?B?b2FrQnhrV0ZNclBmTlB5SjhhVisrZTFVTWFYYUJlRit6amNtWmVEZ3VrZ1J4?=
 =?utf-8?B?VGtQeW8rMVl1bG1DTzZ3V1F2Z2pLanZkOUtHNXFZMUVOazdNRkJiMCtvNzlU?=
 =?utf-8?B?a2k1TTFlNzZYUU1yS3JFa2ZjQ3VvaHMxeURPbitMai9KQkIvd2VYZVFEeHVI?=
 =?utf-8?B?MHFVeFhpaW5tM1VpNzVwemxhSk1JWUZIa0VEcUgzbEdLbUZDU0lwZDZ6VVow?=
 =?utf-8?B?UEJpRVYzTW9hQ0cyb1U2b3laUGVIOThqazYvN2FpTFdocEtwb2NRSEQvZHBH?=
 =?utf-8?B?emFNWm1TS3hTcXdHb09GVkoza0lzY1dUOHhzWnFySGVzTGxyRGRCZGE3Ti92?=
 =?utf-8?B?Q0dkZk04MDdiaXBzVXJpMklFUExkaFFNRWh6MWd5eFMxR2NTeDNKc0F2RVZ5?=
 =?utf-8?B?OGk5NE9UZThnZEl2UUs5a2Uxb0hjbWFPUDVFK0RIU3NEYUpiZzk1WXBYMFRM?=
 =?utf-8?B?dC9XZmVXVm1pc2E5ZTRvZFlwN09Za2lKeEhmT0hwZXFXMDFVSFhpY0haTzF4?=
 =?utf-8?Q?Pskif0aMCkqjldc7rR7l26xzeKGMwAdm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDBzdGQ5SDhYa2NsZGliMDMwYmhTT21KTlJycFNaMjlxb2tiNXBzT2U5NkdL?=
 =?utf-8?B?RFZJemwwbTNCeVFlekNOOTNNSFBVWGl1ZXNub3VTWWRobUNPWjh0WllWNStj?=
 =?utf-8?B?MTFMSStQd3hwS2Nvc05TSjNoQVRiemlHMzVLaEp6WkdVSkZPaTZrTlc2aDcv?=
 =?utf-8?B?QUo1c2p3aHJyYXVhUFJEUkhJd1ZKcGJTYWRpZ2lWTUloV21MVVNFM2Mva2xH?=
 =?utf-8?B?VG5DWWZhOTZkaDBreFM2dXp2Mjg4bERGSDNJUjZBUDdLUXN2dU9mSEJTS0VH?=
 =?utf-8?B?cjVyWjlzWXNYZitnZTNud2VPbVBsYXFQSCtUS2R3RE9ZVGpFL2t2OUJ2Rk9J?=
 =?utf-8?B?eTM4TG1iSHVkTTE5bnZlQzlJcXdsZk1vYWxsc0JQYWErVG4wWUhVRUtaMENK?=
 =?utf-8?B?YlVwNnIvdnFlUTJKczF3cEVXTGZZODJVdTVTTkd1VkhoWXlRampLNXY0VWVJ?=
 =?utf-8?B?OW5SRUNBbzhwMjIxSkNlMm5VTUJVcE1vcXEzMFhpRUtUN3Q1bytUY1ZyaHBm?=
 =?utf-8?B?YXc4ZXpWQUxZZmpKWVhSTnBxUUZoUDRVUWNOU2M2V3dibk9LVmI4NG56cjRu?=
 =?utf-8?B?Nzh2djFIUlVYK2l6SGZlWGduRGJ3VFhMbmtBSktqZC93QUtrRElhRENPbVZQ?=
 =?utf-8?B?ZWVNUzZDMngzSjdXWkZTU3BrV3I1OWkvMk82REhZSjZXYVhaMFg5QTc4WVVw?=
 =?utf-8?B?cGYwSDhGaUFRWDV2VFhRRXpscWV3eCtBZTNkSC94NnQzamZPTFBkTGVOOHBD?=
 =?utf-8?B?eFFuUWxHMHg3eHdrcHd4UDVrOW1wN1RZdVZrYUNWVytGcFNsa0p2VFA2enR3?=
 =?utf-8?B?aGxjcEJ5Ky9vSThKRjZVbi9QTmxPWDNmbENyeExLQkpzY2RCZTZBN0dSQnlh?=
 =?utf-8?B?K1lab0pRUCs4aXVZZkJSaVdMK3R4UkhDVVVmOWhBRHRVM3JCMVl6d293Q2U0?=
 =?utf-8?B?QTlrQWV2cktnU3lOZGEwY1J4QjdiVVJaNG1qeGw5ZzFlOHBRdlpJdXEzM2lx?=
 =?utf-8?B?aGNvU1RzUW1McG1ldW5VZUZhK3RmQjRTMXRUV1pmMytOQ1dWdGluMXJhdTVi?=
 =?utf-8?B?aU41UTVLek5QaU82Mjc0dmRQUnQ4aXBqMVZCU0FMa1FBTnNKOTIvSkVuRCs2?=
 =?utf-8?B?OGhRZXA1cTdjR21Qc3RFQkJzaVBnZFFxalFmRGVhN3JKc1dBL1pMN0xYSjFG?=
 =?utf-8?B?Nmxtd1B1VCsySGNtcG43M2g2ZnI2Ynp1OFZNN0lFU1lLMnI2YWpXTG41cFh4?=
 =?utf-8?B?UGxCcS9Fc2lRNlNRR1YzeFRJMG51L0hkMDdXUmJ4czE2dGdMZkh3NHF4cHow?=
 =?utf-8?B?TkJrQmNyZDVtd0FaMnpWK2w2K25ESjlsbzlob3NkMmRSeXg3aGJhR3hLUmZE?=
 =?utf-8?B?TWpob3UzWUc2SEdJcTFjcXdxVU9Jc29ZV3dSanZnT0FNdkIzbmpid1ZiTnRK?=
 =?utf-8?B?QnZONEhIbXpuWHNVNTQrNXRMOXpVaytMSHpCR01DYWVxRUpxOFBZSEEwUlM1?=
 =?utf-8?B?Qk5YcStkREwwZkhGUzVYUFhOWUpoaEd3bGRNU2lUVW9wQzZLYmozMEdYZ21V?=
 =?utf-8?B?NUF2ajN0L08xRzhYeTBQd1l3QW5adjU4c1hCdk1kSksvRXFLdWxZZktpOW1h?=
 =?utf-8?B?NEVuSXN4d3FiQlhmdmg0blFwRU54VWJNVCtOeVIxYjhCcEF1Rk9GakNpbWlF?=
 =?utf-8?B?UkJqbXVQc1ByQkR4ZGpVSnpzRHJ5aEwxMnF2WE1zcHVTaE8zOWRkSjdidS9M?=
 =?utf-8?B?ME00d2Q0clhSWEpKWTZzTCtYcDByd0sraWFKeHhuMmZPSHpzdkVCeDdFVTkr?=
 =?utf-8?B?WU5SNzVPSFNVbVFMZ2k4ZGhRZlNKenFML2xOazNLY29rUEZPU3ZsM0xJTjVB?=
 =?utf-8?B?NXNCcytYYTYvbTZtZjlINmoydnd3eHd0MHg3SnVmd3hETTcvS042aVEzQmxU?=
 =?utf-8?B?dGZvOE1Uei9OTXBoV1hsaVhGQWRvM1ZFU2Z5V2N1UEZiVmZvRG9FNmtqN3lC?=
 =?utf-8?B?a1piekl6RW1Wa0t3dmcxMHNKYnZEZVlBdmxxSC8zTU1aNE13UG1QbU02ZEE1?=
 =?utf-8?B?S1BXaHY0ZEQybkp4K0JqZU5wbUpyNjJYanB5MXRlM2htcEZDOVV6eUVRK2l0?=
 =?utf-8?Q?mYZVzRIcAeJ6uFMtxBcqexQqB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b60473-849f-4fd5-da2e-08de0c65392a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 03:36:42.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QpOgk7S2UbvW19VS1Sk3OHC8CViRCqIk1zb5p0RNcd/LW5Mak8JfxqeSxyYfVBM++9c3VL1TevcAM85xWnlxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com

Hi James,

Thanks for your time to review. Please see my comments inlined.

Regards,

Tianyou

On 10/16/2025 1:30 AM, James Clark wrote:
>
>
> On 15/10/2025 6:20 pm, Tianyou Li wrote:
>> When perf report with annotation for a symbol, press 's' and 'T', 
>> then exit
>> the annotate browser. Once annotate the same symbol, the annotate 
>> browser
>> will crash.
>>
>> The browser.arch was required to be correctly updated when data type
>> feature was enabled by 'T'. Usually it was initialized by 
>> symbol__annotate2
>> function. If a symbol has already been correctly annotated at the first
>> time, it should not call the symbol__annotate2 function again, thus the
>> browser.arch will not get initialized. Then at the second time to 
>> show the
>> annotate browser, the data type needs to be displayed but the 
>> browser.arch
>> is empty.
>>
>> Stack trace as below:
>>
>> Perf: Segmentation fault
>> -------- backtrace --------
>>      #0 0x55d365 in ui__signal_backtrace setup.c:0
>>      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>>      #2 0x570f08 in arch__is perf[570f08]
>>      #3 0x562186 in annotate_get_insn_location perf[562186]
>>      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>>      #5 0x56476d in annotation_line__write perf[56476d]
>>      #6 0x54e2db in annotate_browser__write annotate.c:0
>>      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>>      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>>      #9 0x54c03d in __ui_browser__refresh browser.c:0
>>      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>>      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>>      #12 0x552293 in do_annotate hists.c:0
>>      #13 0x55941c in evsel__hists_browse hists.c:0
>>      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>>      #15 0x42ff02 in cmd_report perf[42ff02]
>>      #16 0x494008 in run_builtin perf.c:0
>>      #17 0x494305 in handle_internal_command perf.c:0
>>      #18 0x410547 in main perf[410547]
>>      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>>      #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 
>> libc.so.6[29680]
>>      #21 0x410b75 in _start perf[410b75]
>>
>> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle data 
>> type display")
>> Reviewed-by: James Clark <james.clark@linaro.org>
>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>> ---
>>   tools/perf/ui/browsers/annotate.c | 3 +++
>>   tools/perf/util/annotate.c        | 2 +-
>>   tools/perf/util/annotate.h        | 2 ++
>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/ui/browsers/annotate.c 
>> b/tools/perf/ui/browsers/annotate.c
>> index 8fe699f98542..3b27ef1e8490 100644
>> --- a/tools/perf/ui/browsers/annotate.c
>> +++ b/tools/perf/ui/browsers/annotate.c
>> @@ -1161,6 +1161,9 @@ int __hist_entry__tui_annotate(struct 
>> hist_entry *he, struct map_symbol *ms,
>>               if (!annotation__has_source(notes))
>>                   ui__warning("Annotation has no source code.");
>>           }
>> +    } else if (evsel__get_arch(evsel, &browser.arch)) {
>> +        ui__error("Couldn't get architecture for event '%s'", 
>> evsel->name);
>> +        return -1;
>>       }
>
> symbol_annotate() only fails for negative return values of 
> evsel__get_arch(), but evsel__get_arch() has at least two positive 
> error return values.
>
> If symbol_annotate() is wrong and it should be != 0 like you have, 
> then maybe symbol_annotate() should be fixed in another commit in the 
> same patchset as this one. Otherwise you have two calls to the same 
> thing right next to each other that handle errors differently.


Thanks James. I will give a try on handling the error message with 
symbol__strerror_disassemble. I am conservative to change the code in 
symbol_annotate, agreed it should be considered in another patch. Would 
like to focus this particular issue and get it fixed properly. Thanks.


>
>>         /* Copy necessary information when it's called from perf top */
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index a2e34f149a07..39d6594850f1 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, 
>> struct evsel *evsel)
>>       annotation__calc_percent(notes, evsel, symbol__size(sym));
>>   }
>>   -static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>>   {
>>       struct perf_env *env = evsel__env(evsel);
>>       const char *arch_name = perf_env__arch(env);
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index eaf6c8aa7f47..d4990bff29a7 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>>   int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
>>                    int num_aggr, struct evsel *evsel);
>>   int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, 
>> bool header);
>> +
>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>>   #endif    /* __PERF_ANNOTATE_H */
>
>
