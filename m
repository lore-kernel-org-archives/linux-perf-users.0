Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793785816;
	b=c+ZGSvMBsmHUWHpt82uyvwCftEmzUt4h7viwGGgxdBbFGgBnNfB2HCL9x8K4BRXTEOF6
	 1pTnP0Z/0n7ZHlOEYuankH9DdmM22Yrf7R1B3kOfJbwWKZs2h0oy7972A6SVAwtdC4B5l
	 HEJFohxAI07xLydo7KsDjMNM/qYkVms8w+JMtCDYAwKXq4t8cVVyUowYdizK4T/5LZsME
	 BMKlqJVxSHx/PnstuyQ8XYR4PnKB8QptxdfZ3bRJmV75sA4ohFymKcJPIRTgoUXx/cxJR
	 U1d0F7NX8vaCcAfIhFjwjn0W7x64dsyKMsY4g4oMs1q8JiQknnwHuZ/1rzB0KMUdpkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785816;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=BimK1FTOmdsvusJ+jojvwogE8UEkvL7776xiG8m0MbE=;
	b=grponhZdNGoPjcvdtIg0/n43TAz+lBspSGbhYQrXMvlOvm0MT4Z1BAO9iVnsPlGugekl
	 KGJs3LXakMeKZPT8IspGrProNKEGaKbs6XDq6mx6hKMVBNRREoEnpy64xWLoqqKCKxIv0
	 UHtjNn2KgaO2RmhfTQrec35VePlF4K3e65me57WckOUnDc5s8rji1owwIGkSaPwZcs4vG
	 1kp8upKCvOLXj87bNPPa40JRUb1FCX+GnHd6knhm9Ftr66Q5c52+axjEbwTtaZgk8Hme7
	 mrNu5hGtU/NHUtZN5RprnvVpwEeSBXmfr2n+GHNnhOLxIFXH1lXjInfEN6cXTRydHeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="j6/BEk14";
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC2606A336;
	Wed,  4 Nov 2026 09:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5DC2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j6/BEk14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793785815; x=1825321815;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=67lCLtYAZMA6A/U/i/wMjB7EIazyAyv/UnRsWb0JFpQ=;
  b=j6/BEk14us7byqC9Tc2I39u8zKtCkwLT1RG+qwn3lUWBY8fQb4MEUjHr
   xdBHHW50Qct4eA/B8FrM6v0iEILPGnt6uR6BaRO2DRUxuDxDO8rZ0mFOr
   oJjB0h8hL87InPAWmGcLSyRg7mhSVvLqkDkNmP9jQH0IYHQCSNchJYdZg
   hhhr49gMTOSygY+k8tc/OLI+M3cdhkrrlpb0dCyzce1zeyhSrwFxY6MiW
   co5+lRYyZlx6lJ42W6wBiAixVTjU6I8zrVWwiH980TVj2UBl87K/zU53m
   Rqd2ZZAqrqoWvcUVVn/NueetA205wAB+nnBBRRDAv8n4TZw14owTVPbrp
   A==;
X-CSE-ConnectionGUID: +nN+G5AhTU+vGvsgAOvzwA==
X-CSE-MsgGUID: shEoIS1IQMaiNUoCXXs9TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2551769"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2551769"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 01:50:14 -0800
X-CSE-ConnectionGUID: /aByqER+TEaUbcpv3gg4Tw==
X-CSE-MsgGUID: WVuYA756S7CZeiWn0kgDqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6992111"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 01:50:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 01:50:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 01:50:12 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 01:50:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ph9PawmWb1+FTIm3Qcxke7iLLz7hOU95LYT34nu9ttLxMQSXcHVdiD5zCIuUxFyf6YPxf7kcDHGiQFJK7OQhLiQeZ4qEXr7MthhEZ3qU5GZ1ZSJ+hcszn81mI6R0vbJ6slwxqLsxZBwrl1X4fS9umkV65f4Oi0WIaLJrbXtBDc709moLdlJ5WeN+p0OL42jl0QYwHS2bHl24pOSwET8heJ2jHORy9QWn/Q5iysnObEMRLRiskLG6N9hu2MT7MSBB8JzVZnHjYQ0Y8xVX8ebaKe5b5aWHFqqaYhIgdKij1X7NIc56fcqs5bf4c66W3MJfVp9vZB2BFvQKN7v0+djWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BimK1FTOmdsvusJ+jojvwogE8UEkvL7776xiG8m0MbE=;
 b=sd7l1kNTFT3kUCllfDFoL2oP1Jk7m8wZD+PL7NZWeLfFSolVjs/K+NEwa+ahEcmT4L+WELxgkRwXbbeNKnyxaEyzkWIA6wan9z+8eYPgIkJ+QeHovULX6TPhetJ0e9Q5u5z8wxaRWvc7TsCMpNrRYrEzrnX2Zn6sAhB0Ysgr46XbZmkFkUQThDK9UMq5Vy2vwkCZzG2iz6HiTkiKYHodLFMjlbIOQltx8k6KdMbsZUBzF0YgqyXffjO6RO7NM+k1Y3wrFb24ZfeIJxDd5Egv56bsT9NS0TXPJl0ClglBoZVs7ScFXVWCbOAz7wISnNkK3QvLC4rCXG0BF6aSyBLHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ0PR11MB6766.namprd11.prod.outlook.com (2603:10b6:a03:47c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:50:09 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 09:50:08 +0000
Message-ID: <cf0d3547-e4ba-474c-9a25-ef8f59225dac@intel.com>
Date: Wed, 4 Nov 2026 11:50:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf intel-pt: Free the old snapshot reference array
 after growing it
To: lirongqing <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, James Clark
	<james.clark@linaro.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261104021951.1779-1-lirongqing@baidu.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261104021951.1779-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0061.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::14) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ0PR11MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9abab6-e297-402d-61cd-08df3a5902eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|261021135927099003|261022105027099003|261021123027099003|11063799006|261021121427099003|56012099006|261022113327099003|261022115727099003|261009223027099003|261026135527099003|261028144727099003|261021133027099003|261102123227099003|261022075727099003|261021130227099003|261026121527099003|261026130827099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: iXG+3IElJOnWz1l0Pfy34cN+Y5lyj1k635RhCmYC2RRq9Mhc9U+AM5Wkx4AXdKWd4TozgymGjcr0fXnuWcHUaVv2RuU6H86G7m2eya5UNobUwC4f3WfA/CF6gWFnXziJMkfM74pSlMHq5USLbFEFWGW3d1Tp3s1pZubEzUWfpyVGf89WiXAzm1E04qo4XZxvDFr0905GS0tj0rc/cawWiP1O3DNi6A49Qv5waE1ePgEzum7Hymo7HQD8exqlhthkHPC5lxk9f3aO/banokBe0ewexQKVsyMHb/KG5qVyzfE4Lmo555qYjGchJyZDrePMkMLATCgFPYruiL5+KzQIe8mQj9phvJu1OrPONXrkFnBqyMNJ+CjFbA6td5xpGbvIfLA448eSQ78B9kQHzJRFI/KtsJsfPnZlmxr+mGgcl+YbG/f9C1zRNp8D69SwQzu+BmQEuSCrUfRFG/JbVLMzORY3SrwjH6W7HEzOJkkvAKuJCsawKQtG2v4z4AMPGiarA+lElqSvp1kDegYDoetVLFfLYRt7v8v3bf3LS9Cy0HPfY3dEnB9RgDmbtzVLVwB34WcgzxKBVf/LL/RK91r+McnKENFGcrJ9MuVrO3uYCH8MC88k4J68npimrW620zzI+4ak4/56A/Ss2pcTIJwx891kCBuU3zQRzI67gdgQJs3HuLCwty7EHNAJWU2DCfFJIYeCCGSoofSiQCcBh/j6Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(261021135927099003)(261022105027099003)(261021123027099003)(11063799006)(261021121427099003)(56012099006)(261022113327099003)(261022115727099003)(261009223027099003)(261026135527099003)(261028144727099003)(261021133027099003)(261102123227099003)(261022075727099003)(261021130227099003)(261026121527099003)(261026130827099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZZWlExbVF5UTFCZktBdGQvdDZQVVpzUGViQjVaV1R3VWRIR3d6ZXRPZUty?=
 =?utf-8?B?R2hIaXJSQy94MG8vMXNhVS9kelQ3TEZTUjBBWCtlU3lHWGszMXBMVEE1L2tE?=
 =?utf-8?B?bVpoZXRuVlpVNExaM0lXbDMrVWJxbUVRTkIwdzJIWnUvclhWSlh3RkpqREpQ?=
 =?utf-8?B?a2JzS25EYkx0c0dCSGMvdElGVG9pVVlvQ2NUYUlZY052YXJOWlNLL1ZvRnpI?=
 =?utf-8?B?K1lmVitSUi9uSlRWb0xFWVdMSDZ4K2pHUndJc1h2THdqYlU0N3VIU0pGOTNS?=
 =?utf-8?B?NkNPUlVBNWtMQkhzMGFrbGExMG01MzhhSDhDVVBUQmExRVNtNVVjeVZVWjdL?=
 =?utf-8?B?bUxGMG56aHhDancyT1pCbXRFb1d0WjdtZm5QQ2lUbmJ3alU3QmtXb1Y2SWZz?=
 =?utf-8?B?eE1rMWVrNFdvRUhSTTFveTcySDdJQW4rbHVmdTZpN1JvcmM2b28vVE5SWG40?=
 =?utf-8?B?UnJ2R2JBUGxWak5OM0JlT0xYdFE3RUoxR3ZvQXVZd3hBbG04UkZHd0JaVm1r?=
 =?utf-8?B?U3NjS1JvczhXRFZGNkNMV1NzWFpiUjlWOVVMU2JieHhOeUlNUDJSVHRjT2pI?=
 =?utf-8?B?aGNDSXV1Rjk1S3dKTU9HNXlQWnFOcUswRHE2MXRFMFZ1U3lqU2U0dkRGc205?=
 =?utf-8?B?Ykk3OUZnU1llRUdtaXRHajMrRXJ5VExuUGV5Wjd0K3poR3ZDWVNuOWhPL0dZ?=
 =?utf-8?B?RHl3MExvZ2Z0TEcyYjNTU1NWWG8xZm9aOFB5VmNWTWNZdSt2UTlDUGJzYS9H?=
 =?utf-8?B?MlZ3YUpLR05uOWx5dzFMSjVKczFoMDQxTGxjKzNqdUN4Z3pJRlJRTStjbE9Q?=
 =?utf-8?B?TytWUlBXWkxNazhKdGZPZDIyVTV6Rk1lOWNKdUVsbFk2cVJYV3RUSVpTeWxw?=
 =?utf-8?B?bVNzSlh1YlVPSENjQmRHcmZ3bGpJYjI4NklvWFVBanRrUm1GWXlVYkVoRjIw?=
 =?utf-8?B?OFpQNmxpc1ZFTGpHaXR6a0NaRDJZZWdrQml1cjVxYWw5eTV4dUUwaFNncGg2?=
 =?utf-8?B?UmVXUFJnSFNBVkxmUjdjSU83THVGYkdranRLV2hGMXNtaWVGNUFLZHg0MGU1?=
 =?utf-8?B?UVJSV29vZVJBTm55WkpCbDdQUld5alYxQTNwb2k4ckkrNjlQcW5FN3NiMTly?=
 =?utf-8?B?VGtNY21rN3FTcVJWS0V3Q3ZoTnhOUXR3SEIrTjdLYit4MlJtT29TRER1MjJF?=
 =?utf-8?B?Vy9HcXB6NEZWQW1BcHQ4WDNFaFJDeHBVVS9jbFhINUV1bnhhdEd3aExpTDJi?=
 =?utf-8?B?MlJUQXRZaDdmOHA4RGJZYi9GRVBKVFY5UEdpeG40TnZDMHdLd0g1WndBZitB?=
 =?utf-8?B?bGpWTWNxanpRT2NrU1lBRTRaS0hNNGxXRmVMcXNXRzNkM1FJdXNCWFZsTk1i?=
 =?utf-8?B?Ykh6LzlTYmJyOS93YWRKV0FzYThzYVJ6dFNZRktMVFJVTHI1UVFna1o4QWI4?=
 =?utf-8?B?R0ZqVEFma1FwNVJwYWNBdTB1NGNvTmpjUnZmRFNnMnNpMW5qdHhFL0Vad0Nk?=
 =?utf-8?B?SG9Nc2RPTXJtcG5lTzZpdHNKSjdJL0pyQkljOW9uZFNod0FxOGEwR2JvckI5?=
 =?utf-8?B?NGlIbTV6b29EcEFsNVR4YkJLNDM2UDhJbHo3dXNkalFFZ2h1cnpWbE9paExH?=
 =?utf-8?B?UzFuZlNpMjhtR25Fengrd29NRHdHYzhmTHovend4TUxoRXZPcS9jWEx1MlRN?=
 =?utf-8?B?NC9JNFdyeTZTWVM2R1BHUjAzbkd2YjR0QkMrNUJFNzR3SzZGZW12L2VHdk5s?=
 =?utf-8?B?SFVhMGpBZFB6b0d2ZTc4TkFMSS9QaVg0dURNR1VzVU9VUUVMYTIyeldGNUJ0?=
 =?utf-8?B?S0tMRUF6VSs2am9iZjRCaG5xd2wwenFDZ2ZvUWJtcTNBMFlUV1dZSW9wcDVO?=
 =?utf-8?B?dmhESEpxamZndjVwUUtGZkdSWjZPbXRwSitCUHJVNHVsL2NwN2h0dUtJckdo?=
 =?utf-8?B?SC83QXUwVHZwRFdmZjE5UmRCUk5qRzlieGxMSnVIbDFsekVxYWtlVlVJYXdJ?=
 =?utf-8?B?QkNHTnVBeHM2Tjc3NCt0dzNiS2FGbi91L2NUcmNFblZJeU5rVWxOazNrQU9Z?=
 =?utf-8?B?U3MxRVpqb0ZsTGRCcWY0d29tbFhibHRwWHJoMW1YZXBMTHZkL1BSbkNHS2Z6?=
 =?utf-8?B?Nk51R0VXemcrQmV4M0lMSGwvSWdsMng4bTA2YURwcHVYK05GWnpmY2pmNjEz?=
 =?utf-8?B?UVZvL3gwYUczUGFSRzc0cHVIZXh1dGxpSXJua2J3MHIwdTFpbllOanVjLzlO?=
 =?utf-8?B?WnBOeE5oalYwbERnclFDQzFPeGl3cG5XME03b0d3aDJzRjBpNFVuK25KQVlI?=
 =?utf-8?B?UVgzQ1JjR2ZKVzZSN1YzalR6aVdnN0l2d3FBTFZaNTlXT0VvK2orckQ3N3Zi?=
 =?utf-8?Q?eG75nD76xlfbm76w=3D?=
X-Exchange-RoutingPolicyChecked: NtTqAON0/hcypxyTzoXZf2mp27l68VWzOyfHD4NY5Bb9Wi09P1GI9Ko1/ZUW9bMSyUEni6kfojL+CbvuEwlEbA01LNl7MHd//2kcOboMYwAyxonSYDsvSN63n5WLgl+VGiaUv/yVK5utgLDcNM+GwNWJTpIzI1mS+hXMJDL/PsJBvi8R3NPr/wEh18Qd1Uky1CoDTeQiF1KhB3YSIfJO6Z8eNVJhdYCuhOO+mLQ5YG242bxKtCGdQIuZxgPN7BGOzIiGuoNLbqJbnNPFU0YCG1GrgcI58kN0KtWQO3oBJo9MQ84bTvtbK32rg5/jpAMymRezEF0nAI5ajJ9pp/mlnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9abab6-e297-402d-61cd-08df3a5902eb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:50:08.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qewgEW1bUhZPqXsWKVF8vegyS22dg2Lp90FAl5LBA1p4jBIo9+G9THrtAbaaiUgdqCNhU3RtSNwmvyknCm3New==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6766
X-OriginatorOrg: intel.com

On 04/11/2026 04:19, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Growing snapshot_refs allocates a new array and copies the old entries,
> then overwrites the only pointer to the old array. Snapshot recording
> with more than sixteen AUX mappings leaks that allocation on expansion.
> 
> Free the old array after copying its entries. The reference buffers are
> still owned by the entries copied into the replacement array.
> 
> Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/util/intel-pt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 5e38b9c..f034e3d 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -941,6 +941,7 @@ static int intel_pt_alloc_snapshot_refs(struct intel_pt_recording *ptr, int idx)
>  
>  	memcpy(refs, ptr->snapshot_refs, cnt * sz);
>  
> +	free(ptr->snapshot_refs);
>  	ptr->snapshot_refs = refs;
>  	ptr->snapshot_ref_cnt = new_cnt;
>  

