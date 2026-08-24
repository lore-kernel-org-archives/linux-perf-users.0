Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC323AFB19;
	Mon, 24 Aug 2026 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565774; cv=fail; b=ZWbw85lKDPbylGRISdvfIa6jvoDLpMYE/5Dn9jgR5aGKbzba92au1FY00wN8BAVwGitZBlWOes5U110oQG3grAciptQoAW5YjibsHGbO1r86h7A7PXgNOd8gcTfOLU4oEI1K05Ccfo0OUrx68K6h+vkgmM/7kwUb4zQ/dvTEwKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565774; c=relaxed/simple;
	bh=VVKU1N2ZxiLGEWZ02StzfUWerurhSN02W4wzJfatS6k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T8D3tCIHyCSs1GpYHJaGz26y62QyD3bU9Zs42thtaKlvMKY3FQZ8QRP6jwHT7MpBywWD9cWSSyVFJp5JEXk4zFWdwIch7JT7qlYeCLMhDdEnS0eiCW5vaTgXO5jPdr8BUvQxiaiNFmgF+3XK6Z1bxDRKQ6JLmtkQNpFWWn7/HXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbC0Xa42; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbC0Xa42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787565772; x=1819101772;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VVKU1N2ZxiLGEWZ02StzfUWerurhSN02W4wzJfatS6k=;
  b=PbC0Xa42rIbfD4qdo46JDly5lm//J1LFnd2AWm0OjiK4w3Tk/tyLmuIo
   BsZbXMVla6ElVOnO3ZQBuXk6TtAX8nTLfwWa7zFmqJu6ST2csswkfJy9C
   rK48nskSBePIol6esBkaKPRU1IyY9KiA+UK0rQ76mfUvk1925HcuTxHhq
   vJJ3GopAhX0sbTy/dGWUNwW876muVob46OBziObDR0MHxVUFNIyfYWC24
   dPzIOqeKI6cMQiu2jzIJumvpKBuzXxOIphYSt4wO1xnJY8T+b66Lt3Pz7
   9wVjCEa3FUtfJFnfsPPlNbpC+MrNfP1BqChnvPkyQn+JKE8QJJPsmG51t
   Q==;
X-CSE-ConnectionGUID: c9dekYmsT06wH1pmuBwFiw==
X-CSE-MsgGUID: Xc8mFU0DSa+Jzw+nLR4GeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87778409"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87778409"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 03:02:52 -0700
X-CSE-ConnectionGUID: 1mzwLxpIR2ira1drCldvRQ==
X-CSE-MsgGUID: hnfxSTvLSi6ahNdFe02d4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="267005286"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 03:02:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 03:02:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 03:02:50 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 03:02:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDQn8XLQK38W+SjlGH3wows/Ftz2Ls9+r+G+Ys/JNk6+h2PhXjwCbPUAgVRHDETvBoc+eVGUr7rDw8SoRzeF7O6MPD9tDA9Aw2PqIGENz5muj8v+EQ9etDBhzSvvExaw+78NpaVRSZLdw5iCZsZ8MRZf3EOmJjGCfsb1lDSC8TraUUqFeFiEBriirOJ/ZC0XP97jpETRbbbe4iQ32CLLkXCUcGgwtFsDNLjZqFfliEMgiQZ+xDG8y3KbpEd8woLAr4C1XOKipJyfzynBBizQYBWEI9cCr59aKgrHrlyQIcbgdolQf/Ds4ML6SO2h1scKCOYOjy2++BRFbOUnpXEtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpq0xPjefQMrzLD3yw5kLszuFfSe0eJ7PSPXZPcYbnY=;
 b=qIgfgeU26XahPRWuwuUoFdWkbWql6ZOUgFkFeyxnKdbqUy4PY6xARd9Lf/5fAR+Z7eom6OqDZVU3fl+kTYCR1Ko1F93a4qC6y6JG5PSIvzjBzwu37EQTSs2huSt1fndl0KX2OJZtTCgFv88EbvclGMARRL+e41ClgpTiDLJesEZCQO0/jeOudasvDBCRAJT+3Ii7K2Voahv44eS36t5unDVoQzSXVUdeo0+me0ikygdbMCsVB0RicG76sE5Fi8m2eGAnGN48HShDI/paD84i73US4UgGVzkAJ0+nsA48ry5r/TVrHY/zqV1a773ZXwnI3gGPHoMsDA/cgFFGBnxXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:02:46 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:02:46 +0000
Message-ID: <00f023a5-37da-4884-a92a-f4b35b4be1cb@intel.com>
Date: Mon, 24 Aug 2026 13:02:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] perf cs-etm: Add branch history to existing
 samples
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
References: <cover.1787005265.git.aaupov@fb.com>
 <454bc49f51eeef9f758fc2d2c7af75889d8aff46.1787005265.git.aaupov@fb.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <454bc49f51eeef9f758fc2d2c7af75889d8aff46.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0332.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 048c8d2f-8a70-433c-d7a0-08df01c6d888
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006|3023799007|6133799003|4143699003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: R1T/7Aa5LUy9ZqlAdT3NIc0gj/gFX7wk5nYV5vg0cOm3EuM+RlheBGNrS6IjUE8X8FUfEShaHej74nQfb2DD402wrxGuzz3yV2cOQBm3PdOpAxUMtvPfJiKG9Xffdl0JAsQfN67Jp48a53SQtQq5c4zZjyrHUDq5fhUS1YTSLE5uX/wjLwOYXwSIn9x5HUoxTd+Tdw+5Z6xszCRlJ85Eq5xbHaM+eCKjU6MIYQ/aRL8i+gbex2O9nQVtNR0sT/QiOm7/0tT+fdiyyJHj87X11ddWG1LeYoWSjGrR9qaj4WuYbcqikQ9gk44HfVOnISAchnSbnQmNxiCh6Zb1NUUvfVEqrllm5fnCUUIwSz2Uvo6+kRenJ1fa7emVBsu0XINcuC86ACF3k+Nq+h9Q6p9BgLqf4GUVmkvx6X4J+LWw/RYoWK1VUnF2Tv1p1MsUJo2/jTSY1+RdSFHIJrjM8ECyT1eVFEpFtxu7mcYdw6dM6lMusJ4nj+nmpub8VBfNy4o8WiSKDD+I5V5sq1oPwKSDNE8HblksvlpEk/X8XeTpg75bHXbf4EmAHTlRes7qOh+YH6S7c9bc3IeV0YdfIU2qqvAQHtV6Z4LYKs1hwxg+DrYwW3DufUVEtjUzfPt+K2DUKqAfz4mvqCQvuj8gBZaZ/h/kZ9A3YD4r3QTtbCMihS9N9B64N4ZKHM2w2LkUVDKLUs/NkYtpNOfN1vu5GLrshQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(3023799007)(6133799003)(4143699003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y202cHhKcmk0MUpwcnUvaW1jUlFKZ1VnUVFGS1Jzbmpud3NpRFJzb05WUU40?=
 =?utf-8?B?N0RzQnRXUVlKbDBhV280Z3ZJK2VMa1J0dmFBUThaMVo0MG5uWXpFeTM2ekg2?=
 =?utf-8?B?d1RvTTE5ODFid04rb3dTeHRaYUFiWlZWS09ZL25rNFBGc25vTFVQNGRIN1or?=
 =?utf-8?B?U0N0dXZlLzlmZVFUb3J1QzhtaFc1VWtTTDhUM3NnNDBoaDU3SjhpOFFkQmR5?=
 =?utf-8?B?aHcrY3Brc0FMcHc5clpNaDl6OVlGS1Rma2lYRnhXa3hqSTR3M0FXZmZNTllR?=
 =?utf-8?B?YS95VG9sUG1uWlNtUFZUNEZBbEVKVFpyRm41enA1Uys3SVpWYzRYM3I2SUdP?=
 =?utf-8?B?OGZOWFRWdGJUR3BhcHk3RjJmUjQ5MWVxZkxyU2NvYTFVRlBIeE1NcFY0Q1N3?=
 =?utf-8?B?K1Zya2x2VGlBbDBKYkpqM3BsS29aQUlBQjNYUVN2ZFdDWGQ1MzVwVklVS2l0?=
 =?utf-8?B?UlZNUWdrdjNnQ2JKTzRWSk1IeXJHMjErUkpCcXRVSFp1dnZtT3hQb25iaVRY?=
 =?utf-8?B?QW9uam5kY1NJK3daVWJ4Q3d6bWExcGFnSWRJb3ZTc2c0TUlZZ3hxZmxuVEpD?=
 =?utf-8?B?UlA3bWxSbU0rVFEybDlTWEJ4amhpdGNlS0ZHNGxSWlZzSjZOVHBWbmtaOWpF?=
 =?utf-8?B?ajczWWx2ZWkwR2Q1ZWpVU0xxZU50NHJHOWRzeGgwRWpKd0RsdG5tUWx0d2tG?=
 =?utf-8?B?WHN3cnBCQ3pLSEVqNlFlbWxjOGNhMCsySUhpbWY1NGp6QW04NHNBRVZ4b2NP?=
 =?utf-8?B?dlZKdU9adUwvYWJsNzN6VlVZdDY2UXdPOVQ2RHlnWXIrVTdXY3ZBbnIrcWEz?=
 =?utf-8?B?QTk2bHlYMjljSGJZN3c0eFRQVHNXeXEvZlZYWmgvY0hZSlJoa2NKL1dFQUVx?=
 =?utf-8?B?M0NNU1VnaHZyY2NrQzJQamNKVkptMTlxZFNzYzlmSnBCL1c3SXNLa3BYUU51?=
 =?utf-8?B?SVBsTXpxS0pDZjAxOUk3N254M0QyRG5aYk9DdU9nZXlqd1lQeEZSNU1ZY3pT?=
 =?utf-8?B?bGhTSU04aHZIWUNBVm1HVmpPeXJtY1R4M0s0RklRZkhuSlRBdFlwN2FwT1RQ?=
 =?utf-8?B?L0hTU1kzTUt6L3VTdUdmS21lUVBpVFNxSFllQ2JBUzZPcHRXZHlDRE1rMzdi?=
 =?utf-8?B?aEZQQWFKbk9oL1dUQktsT3JGQ1IzZHhSbDFnQzltZDZVZERXNFJacFBFWFVi?=
 =?utf-8?B?dlptWGhVWk01Ly9KMUFVSXBIb0JjM0dGRXVBWExsamVKamg0eDRKOVpaeUJs?=
 =?utf-8?B?TGI4Q1IvK3RRazl4ck9yOFRpa2pralpNbld1MkpjZCs0L1hqbFJVckp1eVha?=
 =?utf-8?B?TjNjaHIrN0s1Ykg1MTlZSi9PRkp3SDR0a0w3UE9CSEZkRnU0Y2F4cWp4am10?=
 =?utf-8?B?Q3libFlqOVJaY2t3ZFViL0FXVW8xZkFKTEcwbzdtSEg3bjRXTVNPUE45ZFRX?=
 =?utf-8?B?bVNJYWJZcmdLRlo2STNVMjJIS1JUenFUTjMxbG93ZnBVYWlVS3N6ZlRjaVVY?=
 =?utf-8?B?K1BySWROem51SGdoUWlhZy9lSWxWNmV2dk5RSjRWdytXeGRIQ1BzeEFxOW0y?=
 =?utf-8?B?NVlPUGx4bEFqNGl3VW1HTXZnRXQxOS9oNTFYOWh3MUE3aThaVjdPVnYxb1Jr?=
 =?utf-8?B?clNIbklYNWtIZnJUNks5K3VYcjZZTEtVZkNhWGorRzQ4eG1XMGtGNXBIZTFS?=
 =?utf-8?B?cUErNTdXYzQrVStZY1Rqd3NQZFl1STA5ZFNKOXBIb1E1K29qSXNJZ25OQzZO?=
 =?utf-8?B?WjhTZnZmMlRDZ3lGNko5ZlJOQ0FMUDVXMnJkZjhITmtrVnFrOGhqTmVvNlR6?=
 =?utf-8?B?SEE4S2t5TkxjT3JwZDZ4aFF6NDN3WFFFN292N0NkcXN2eUtwclhEUmxtWjJJ?=
 =?utf-8?B?ZUlZMHhDakVkN3VZVTZNbFlSTVFaUFJOL0I5OGIrMmJwaWYrZ1kzKzQwNGla?=
 =?utf-8?B?SzA1SjdoVTdRNW9iZ3dQc1U1WEFINlRuTGdhd0pOQUNBQlEvVWF1ZHBkWE1M?=
 =?utf-8?B?dHQrTFg0NU1XcmJsTXl5NjRoNnJDZW1LUmRJQ3ZWU3JYbnd3MHMwdkZoSGdo?=
 =?utf-8?B?ZVNHTkxVQ0QyOEQvd0dWei9TYkEya0VmZGJJY2lzQ1JtYmo2eEQ3Tmx3cFI2?=
 =?utf-8?B?YlZ2SFE0dUJEcndTY0NWNHZpemZJczRYZWY2NC9RWVg3WXhaU3dxc3FRNzZI?=
 =?utf-8?B?UlZDZFdQelk1bTU3c2xBVVJmRzBKOWl5cXAwSmdIK21KTndlMzJxODZRZjdG?=
 =?utf-8?B?N1NtbmNEUmM5NG1ja01hTk5Ea1BSOGhucXJWeG9acEJtQUIyMW4yWURsd3Zi?=
 =?utf-8?B?ZUZUUWR1WUJlcHV4VDd0N3NpS0g2djllc2M2RHRBTkNNdHRLOEZzNVJjVktL?=
 =?utf-8?Q?26nIAcuCmiWMEp5s=3D?=
X-Exchange-RoutingPolicyChecked: LefbKPkq5sDLISCvaH1jSqWXSrDabX1cbKpAKDRlQgwRZ4y3NDHuS1G5TJbns88YazYH1urmilPwrvPuYQDoqY9AuGA2MEa8NYej8if53E4xgXSLLJrvEr8iWD/sqYIb5L4vGWE0E4dE3WZgWiQDkPoYWJArL3p6BLLFG13EGqJRp6CLnb+kX/cxh2dVFNH1r2pRc26HSJNs1YhSW8VpI1YsVQQuADw2jBPfrWMu8UxvQfVRPsjTVA8GplOkAP4VZDb82QrDsCv/9QvGfsljE41tcGx28uEbi6RCCm4a0u/Cs5XMgk3zHvnGrTH0QHJQIxIMpuVVE86+WitBv9ZqfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 048c8d2f-8a70-433c-d7a0-08df01c6d888
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:02:46.0254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBYZToREnMX45d1KzMqGX/AfGrh0VBm3ojicXZLEvU5bPGo88JYcvOA8KQqHt6hVixEKa6ty2WWgEr2e1j6aHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com

On 18/08/2026 01:22, Amir Ayupov wrote:
> Implement --itrace=L for CoreSight ETM: decode timestamped trace up to
> each existing PMU sample and attach the branch history that led to it.
> The sample keeps its own ip, callchain and event identity, and a sample
> that already carries a branch stack is left alone.
> 
> Samples are correlated with the trace by time, so this requires virtual
> ETM timestamps that are correlated to perf time; timeless decoding is
> rejected. The decode loop, which the previous patch left on its own in
> cs_etm__process_timestamped_queues(), grows a timestamp argument and
> stops once the decode frontier reaches it, so on return the
> thread stack holds the branches that executed before the sample and none
> that executed after. Attaching then reduces to the same
> thread_stack__br_sample_late() call intel-pt uses.
> 
> No explicit sample-to-queue matching is needed:
> thread_stack__br_sample_late() keys on the thread, and the thread stack
> is already emptied whenever the decoder reports a discontinuity. The one
> case that was not covered is a queue whose trace runs out: flush the
> thread stack there too, otherwise samples recorded after the last trace
> would pick up stale history.
> 
> Take the branch history when attaching it rather than leaving it in the
> thread stack. With AUX pause and resume, a pause sample ends a completed
> trace window and that window belongs to the sample. Execution while AUX
> is paused is not traced, so retaining the window would let a later sample
> reuse branches from before the untraced gap. Consuming it ensures that a
> sample with no newly decoded trace gets an empty branch stack instead.
> 
> As with intel-pt, the internal reconstruction ring is kept deeper than
> the requested output depth to cover branches decoded between the sampled
> ip and the point at which the sample time was recorded, so --itrace=L<n>
> can actually return n entries. Kernel-inclusive trace gets the same
> conservative 1024-entry headroom that intel-pt uses.
> 
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>  tools/perf/util/cs-etm.c       | 185 +++++++++++++++++++++++++++++++--
>  tools/perf/util/thread-stack.c |  17 +++
>  tools/perf/util/thread-stack.h |   1 +
>  3 files changed, 195 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4d895f11deb7f..00407a80933e1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -72,6 +72,11 @@ struct cs_etm_auxtrace {
>  	bool use_callchain;
>  
>  	int num_cpu;
> +	/* Output depth requested with --itrace=L<n> */
> +	unsigned int br_stack_sz;
> +	/* Internal reconstruction depth, see cs_etm__br_stack_init() */
> +	unsigned int br_stack_sz_plus;
> +	struct branch_stack *br_stack;
>  	u64 latest_kernel_timestamp;
>  	u32 auxtrace_type;
>  	u32 branches_filter;
> @@ -91,6 +96,7 @@ struct cs_etm_traceid_queue {
>  	u64 kernel_start;
>  	union perf_event *event_buf;
>  	unsigned int br_stack_sz;
> +	unsigned int br_stack_sz_plus;
>  	struct branch_stack *last_branch;
>  	struct ip_callchain *callchain;
>  	struct cs_etm_packet *prev_packet;
> @@ -141,7 +147,8 @@ struct cs_etm_queue {
>  };
>  
>  static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
> -static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
> +static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm,
> +					      u64 timestamp);
>  static int cs_etm__flush_timestamped_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>  					   pid_t tid);
> @@ -165,6 +172,7 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
>  #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
>  #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
>  #define SINK_UNSET ((u32) -1)
> +#define MAX_TIMESTAMP (~0ULL)
>  
>  static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
>  {
> @@ -674,7 +682,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>  		if (!tidq->last_branch)
>  			goto out_free;
>  
> -		tidq->br_stack_sz = etm->synth_opts.last_branch_sz;
> +		tidq->br_stack_sz = etm->br_stack_sz;
> +		tidq->br_stack_sz_plus = etm->br_stack_sz_plus;
>  	}
>  
>  	if (etm->synth_opts.callchain) {
> @@ -794,7 +803,7 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>  	struct cs_etm_packet *tmp;
>  
>  	if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
> -	    etm->synth_opts.instructions) {
> +	    etm->synth_opts.add_last_branch || etm->synth_opts.instructions) {
>  		/*
>  		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
>  		 * the next incoming packet.
> @@ -963,7 +972,7 @@ static int cs_etm__flush_events(struct perf_session *session,
>  	if (ret)
>  		return ret;
>  
> -	ret = cs_etm__process_timestamped_queues(etm);
> +	ret = cs_etm__process_timestamped_queues(etm, MAX_TIMESTAMP);
>  	if (ret)
>  		return ret;
>  
> @@ -1060,6 +1069,7 @@ static void cs_etm__free(struct perf_session *session)
>  		zfree(&aux->metadata[i]);
>  
>  	zfree(&aux->metadata);
> +	zfree(&aux->br_stack);
>  	zfree(&aux);
>  }
>  
> @@ -1597,7 +1607,8 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
>  	u64 from, to;
>  	int size;
>  
> -	if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
> +	if (!etm->synth_opts.branches && !etm->synth_opts.instructions &&
> +	    !etm->synth_opts.add_last_branch)
>  		return;
>  
>  	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
> @@ -1614,7 +1625,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
>  				    tidq->prev_packet->flags, from, to, size,
>  				    etmq->buffer->buffer_nr + 1,
>  				    etmq->etm->use_callchain,
> -				    tidq->br_stack_sz, 0);
> +				    tidq->br_stack_sz_plus, 0);
>  	} else {
>  		thread_stack__set_trace_nr(tidq->frontend_thread,
>  					   tidq->prev_packet->cpu,
> @@ -2817,7 +2828,8 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
>  	return ret;
>  }
>  
> -static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
> +static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm,
> +					      u64 timestamp)
>  {
>  	int ret = 0;
>  	unsigned int cs_queue_nr, queue_nr;
> @@ -2831,6 +2843,9 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
>  		if (!etm->heap.heap_cnt)
>  			break;
>  
> +		if (etm->heap.heap_array[0].ordinal >= timestamp)
> +			break;
> +
>  		/* Take the entry at the top of the min heap */
>  		cs_queue_nr = etm->heap.heap_array[0].queue_nr;
>  		queue_nr = TO_QUEUE_NR(cs_queue_nr);
> @@ -2878,8 +2893,25 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
>  		 * No more auxtrace_buffers to process in this etmq, simply
>  		 * move on to another entry in the auxtrace_heap.
>  		 */
> -		if (!ret)
> +		if (!ret) {
> +			/*
> +			 * The trace for this physical queue is exhausted. Drop
> +			 * branch history for every trace ID it carried so that
> +			 * samples arriving later cannot pick up entries decoded
> +			 * before the gap.
> +			 */
> +			if (etm->synth_opts.add_last_branch) {
> +				struct int_node *inode;
> +
> +				intlist__for_each_entry(inode, etmq->traceid_queues_list) {
> +					int idx = (int)(intptr_t)inode->priv;
> +
> +					tidq = etmq->traceid_queues[idx];
> +					thread_stack__flush(tidq->frontend_thread);
> +				}
> +			}
>  			continue;
> +		}
>  
>  		ret = cs_etm__decode_data_block(etmq);
>  		if (ret)
> @@ -3011,6 +3043,116 @@ static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
>  	return 0;
>  }
>  
> +static bool cs_etm__tracing_kernel(struct cs_etm_auxtrace *etm,
> +				   struct perf_session *session)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(session->evlist, evsel) {
> +		if (evsel->core.attr.type == etm->pmu_type &&
> +		    !evsel->core.attr.exclude_kernel)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int cs_etm__br_stack_init(struct cs_etm_auxtrace *etm,
> +				 struct perf_session *session)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(session->evlist, evsel) {
> +		/*
> +		 * Only timestamped events can be matched against the decoded
> +		 * trace, so do not advertise a branch stack on any other.
> +		 */
> +		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
> +			continue;
> +		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK))
> +			evsel->synth_sample_type |= PERF_SAMPLE_BRANCH_STACK;
> +	}
> +
> +	/*
> +	 * Additional branch stack depth to cater for the branches decoded
> +	 * between the sampled ip and the point at which the sample time was
> +	 * recorded. Those are trimmed by thread_stack__br_sample_late(), so
> +	 * the extra depth keeps the requested output depth achievable. If
> +	 * kernel space is not traced, only the branch into the kernel needs
> +	 * to be accounted for.
> +	 */
> +	if (cs_etm__tracing_kernel(etm, session))
> +		etm->br_stack_sz_plus += 1024;
> +	else
> +		etm->br_stack_sz_plus += 1;
> +
> +	etm->br_stack = zalloc(sizeof(struct branch_stack) +
> +			       etm->br_stack_sz * sizeof(struct branch_entry));
> +	if (!etm->br_stack)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/*
> + * Add decoded branch history to an existing sample. The sample keeps its own
> + * ip, callchain and event identity; only an absent branch stack is filled in.
> + */
> +static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
> +				  struct perf_session *session,
> +				  struct perf_sample *sample)
> +{
> +	struct machine *machine = &session->machines.host;
> +	struct thread *thread;
> +	int err;
> +
> +	if (!etm->synth_opts.add_last_branch || sample->branch_stack ||
> +	    !sample->ip || !sample->time || sample->time == (u64)-1)
> +		return 0;
> +
> +	/* Adding branch history to existing samples supports the host only */
> +	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
> +	    sample->cpumode == PERF_RECORD_MISC_GUEST_USER)
> +		return 0;
> +
> +	err = cs_etm__update_queues(etm);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Decode every queue up to this sample's time. Afterwards the thread
> +	 * stack holds the branches that executed before the sample, and
> +	 * nothing that executed after it.
> +	 */
> +	err = cs_etm__process_timestamped_queues(etm, sample->time);
> +	if (err)
> +		return err;
> +
> +	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
> +	if (!thread)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Take the branch history rather than copying it. The trace window
> +	 * belongs to the sample that ends it, so once it has been attached a
> +	 * later sample with nothing newly decoded finds an empty stack rather
> +	 * than being given an earlier window's branches. That is the common
> +	 * case whenever the trace is duty cycled, by AUX pause/resume or by
> +	 * ETM strobing.
> +	 */
> +	thread_stack__br_sample_late(thread, sample->cpu, etm->br_stack,
> +				     etm->br_stack_sz, sample->ip,
> +				     machine__kernel_start(machine));
> +	thread_stack__br_stack_consume(thread, sample->cpu);

Did you consider using the existing thread_stack__set_trace_nr()?

> +
> +	if (etm->br_stack->nr)
> +		sample->branch_stack = etm->br_stack;
> +
> +	thread__put(thread);
> +
> +	return 0;
> +}
> +
>  static int cs_etm__process_event(struct perf_session *session,
>  				 union perf_event *event,
>  				 struct perf_sample *sample,
> @@ -3049,6 +3191,9 @@ static int cs_etm__process_event(struct perf_session *session,
>  	case PERF_RECORD_SWITCH_CPU_WIDE:
>  		return cs_etm__process_switch_cpu_wide(etm, event);
>  
> +	case PERF_RECORD_SAMPLE:
> +		return cs_etm__process_sample(etm, session, sample);
> +
>  	case PERF_RECORD_AUX:
>  		/*
>  		 * Record the latest kernel timestamp available in the header
> @@ -3752,11 +3897,34 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  
>  	etm->use_thread_stack = etm->synth_opts.thread_stack ||
>  				etm->synth_opts.last_branch ||
> +				etm->synth_opts.add_last_branch ||
>  				etm->synth_opts.callchain;
>  
>  	etm->use_callchain = etm->synth_opts.thread_stack ||
>  			     etm->synth_opts.callchain;
>  
> +	if (etm->synth_opts.last_branch || etm->synth_opts.add_last_branch) {
> +		etm->br_stack_sz = etm->synth_opts.last_branch_sz;
> +		etm->br_stack_sz_plus = etm->br_stack_sz;
> +	}
> +
> +	if (etm->synth_opts.add_last_branch) {
> +		/*
> +		 * Existing samples are matched to decoded trace by time, so
> +		 * the trace must carry timestamps that are correlated to perf
> +		 * time and the queues must be decoded in time order.
> +		 */
> +		if (etm->timeless_decoding || !etm->has_virtual_ts) {
> +			pr_err("CS ETM Trace: --itrace=L requires virtual timestamped trace\n");
> +			err = -EINVAL;
> +			goto err_free_queues;
> +		}
> +
> +		err = cs_etm__br_stack_init(etm, session);
> +		if (err)
> +			goto err_free_queues;
> +	}
> +
>  	err = cs_etm__synth_events(etm, session);
>  	if (err)
>  		goto err_free_queues;
> @@ -3812,6 +3980,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  	auxtrace_queues__free(&etm->queues);
>  	session->auxtrace = NULL;
>  err_free_etm:
> +	zfree(&etm->br_stack);
>  	zfree(&etm);
>  err_free_metadata:
>  	/* No need to check @metadata[j], free(NULL) is supported */
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 1360f44421ef8..2713a2ad70b69 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -614,6 +614,23 @@ void thread_stack__sample_late(struct thread *thread, int cpu,
>  	}
>  }
>  
> +/*
> + * Branch history belongs to the sample that ends the trace window, so a
> + * decoder that attaches it to an existing sample should take it rather than
> + * copy it. A later sample with no newly decoded trace then finds an empty
> + * branch stack instead of the previous window's branches.
> + */
> +void thread_stack__br_stack_consume(struct thread *thread, int cpu)
> +{
> +	struct thread_stack *ts = thread__stack(thread, cpu);
> +
> +	if (!ts || !ts->br_stack_rb)
> +		return;
> +
> +	ts->br_stack_pos = 0;
> +	ts->br_stack_rb->nr = 0;
> +}
> +
>  void thread_stack__br_sample(struct thread *thread, int cpu,
>  			     struct branch_stack *dst, unsigned int sz)
>  {
> diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
> index b3cd09beb62f0..2aec292bd1bcb 100644
> --- a/tools/perf/util/thread-stack.h
> +++ b/tools/perf/util/thread-stack.h
> @@ -88,6 +88,7 @@ void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *c
>  void thread_stack__sample_late(struct thread *thread, int cpu,
>  			       struct ip_callchain *chain, size_t sz, u64 ip,
>  			       u64 kernel_start);
> +void thread_stack__br_stack_consume(struct thread *thread, int cpu);
>  void thread_stack__br_sample(struct thread *thread, int cpu,
>  			     struct branch_stack *dst, unsigned int sz);
>  void thread_stack__br_sample_late(struct thread *thread, int cpu,

