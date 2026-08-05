Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021077.outbound.protection.outlook.com [52.101.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EA223DFF;
	Wed,  5 Aug 2026 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961174; cv=fail; b=Ih0NNNxPC6HSyGub3kRvZ2H3H8ahPfjnSSwT6A7W9fWAQvFtW8zWgUM68Uvb6mQ5M5LJALm+qKMqHyNXFuepyxnJJdtcTphm67GwEHVnIeXwu7ie6Lk4TI6iGivLNmqYLqtJUuPRC57tqWMwbfkLhcerJ2RiPq7FWhBzvi67s2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961174; c=relaxed/simple;
	bh=Y6MIbk5fYqdj/BsJQub/VFd9d9Lrx4fOVQZLIfLCZko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U3bQAba84R07Gmgl7VOJFv3mKWOpovZiQKdeER1jP/OS5TKzimxo2roCt/ikwoLlArm4C2LmoxVmYiogin2zYQ7QzWpn8mmFboeuxXYDL8kbf9y8BcTPyA4F4YWcKDKkRgJ40/Wv8iGMr8sX4NK603JgIIXSAKe3bXMfB8Dc93Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdYQlNY2Wa1k9a6GAI7PmI3z6DyY9U2v47rA/ZL/jjV6x+wFlUVCjOWC1WTmTIRWNYvzHjMi5i0O0rkUdBlU7/p8vBGaKDns9V3fkoRCvqpfuBMjx/JNphWktCAI/iVAMiJIk31J67hLOSF/c0lXe9qUXOFGzMtSQacBwsK7POhL/wuZGvmY2IIOghWtL3wND1AnXwWruh/yN3RiAJMUnDDWj+IiNxsAhiGEdNP44k2VfyxXj2SD7hdjY5oXr8Gn3WudSyDoVfpXUGgXYvG6m/Xixg9Qz68iLtg7LmEPlhxZVBWPJ2YzF3Ri1Ak1QON5FXQ0fIgGIGV8DhR6h/oYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=zXtDde6BBMmO6QXnuuHHjlT/qKZRwmQ9v3IFWw8rOxo=;
 b=taKAkAxKolXgsKoFtdN1Gm865ifhslRBqfQsaeT28LpOvXV+qXdNcnOweGPLWhNFEN3OwdLVy2gVhcGn4cGqN08sTTM2bIF7vBPxJZh4AISJs3keocUDzcGWsK3TKQFIXj2KItA2tboUgBvqYn2UB60ghKeBwFuwjUosmGw8UTKLmbqtk/wDoLbPZIUOqhMwhvbqsP06ukPuH+ZLt1j9EUGXgCEOXJujaw6CNDlaCRdo67q8wlVdzkjeYKS8LN3WILwYSwUauM2PvVMQdDrv+UCsCo/N8RhBUqe9TwZlevih9qbDT/+Zb9f9wGbPZvI0lZytHG6HqBebooAZcDGQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 20:19:30 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 20:19:30 +0000
Date: Wed, 5 Aug 2026 16:19:27 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] perf sched latency: Refine outputs, unit scaling,
 and histogram support
Message-ID: <iz6rvkfqqcdydi7fuko7rgc7qdzhy62iolqyw6d2bvrk7t6xtd@rnyjymbgxflh>
References: <20260802210914.199941-1-atomlin@atomlin.com>
 <anIdO3ejoRWTF_0V@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anIdO3ejoRWTF_0V@google.com>
X-ClientProxiedBy: BN8PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:408:d4::28) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3040:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fa0435-d3fb-4cdd-b523-08def32edb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info:
	PAiA7T5yZVC1uXECfqYwIQrmU3VWeYmm1ZOnZJMkvJxvHmeel39OyxPL2R8QAKgHG9/SdKHmuS7vq/mIYTjRzVZNbzgcEjPjcblX98Q5anaIJucSziThR/EBk4j4dA5n8ZXkpjV5X3iCZLBO0uQ9c6XSvhVc4gy/KWvlqead4onnVW2wupcsmM/n4y828VRSmEJNZ2QLVySFdwTs05UB7oym77JZEPxVzASuA7QFJucxOU6VUBFnBw3f+FNU+QojxzOGVkE+wrS1fGdUDUCH1FPLynjwo4ltoXeAdo4y4o3srknIynV33iJ0yWvRBQtYQMUIej3LvsKYWps7WyejW+nwoc7LkmdCVV3mAzyxn8TdZeZSFtGA3ldP7cDMZ4CtsxP+AhWDimFYl2+G9Cc1y3gouInYRIGXJm2okEQ4M2ohVN94LG31r1Zg++8nCgNYiJW+ep1t+7logNpQpzlnm63ovWlbXQ7sK2ByTVmMyYaq5bF8FZGeQjGK7XV4jt74k2Z/OUglBB2/enwnOMLkXykLHjbnB7FLgFsCzpFpVCqHmAEo4wfieqKyHIU4PptzP3X88QuY8e1m1pKdo2b9Vk9+qMR85xhjpDaJ6brw4mydJWeuFvFLKwyr9qU5lncIy8rF1YPUSKG1UaZEqgdEnZdCHkdvLDP/Y3TOSutDI1rClBlok06K53wi2hAplFgj8Q5X/cYZS4blNRJ0ksqmEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0x3SHlhQWlsVFIrMVcxbkhRVmttZTVUSmtyaS9qby93U2lJdVh1c0NrNm14?=
 =?utf-8?B?VHpIVHpRR01oMHYyTGIzOEg0MWNOM3BMQThtYVNSYXpBeGQ4OVM3d3BVM1pY?=
 =?utf-8?B?SkplVFNyZTBKZWNmMUljRHh1aUN2Mk96OGZMSnc4VFRzOW9MUUdQUDhrM2Zk?=
 =?utf-8?B?OURRWTdRVGwyU0JGZ0JoR3Zhci9XdUs5ZGwralFmU040ZHlYUnBmN0pjZE1M?=
 =?utf-8?B?RmIrdlFMVlpTdHhVTmVOajZMRDVOWk01NkVZT0cvakI4QW1Pb3pvN2xZYmVv?=
 =?utf-8?B?QzNPeW5QNmNlNXJiaGRJL01wYXpvcXM4WktGZ2dmTnI1ZzZnMWtLRG5BVjUw?=
 =?utf-8?B?bkJsU29MRDl3ck4rYndUcjcwVnRCYUI1QjNtTC9RelpacmdiRm42bkZzUDV0?=
 =?utf-8?B?VFd3WDYvV2x4MGhINm8xaFA5clhiOUdnN09mTUQ0TGdieS9YcVllVGJudGlX?=
 =?utf-8?B?dDg1OVNsY2RnUjJLN0tqNEFNRitNR3gyaWVVZ3YzaWk0dytpVEdMbFgzSkdD?=
 =?utf-8?B?dUM3MWhjS0hlQUJjZU9kcEdHQm8vUFU5MlFxajlGWUY3ZDUzazhFREFrbzJL?=
 =?utf-8?B?dWorRUIyZWNmUFFwWTM0UVFBR1pFOW5UMzJkbXlKaXNuSk5DRjhaLzU5aWls?=
 =?utf-8?B?V1V6cmtVRkt6aUZZKzdsS2JTYUJrR3BVNFRGc2tXYS9JUlJYM1hCRkxJSmpu?=
 =?utf-8?B?ZEd4d0ZkZnVPa01DaXJaeXJTVk1CWVlMem5iNytLVzZrN3l6c2RLWUVhTjRC?=
 =?utf-8?B?aFhQNzhoWTRVYm5HSTJWVnM2Tk1WVnQxeW5rYzVUbzRNbkVSanJRN1BBZ3Ay?=
 =?utf-8?B?V3JtdHQ0dDJ5eFlpbjVrTGEvUGlkdWpkck04R1JnZkhlUVgxMG93QVFqcmZw?=
 =?utf-8?B?TmttVk14MkN2ODFzQ1pjOXZ2MVByM3pXTnpqMm1PVjVCZDJraXVyaWRBTzd5?=
 =?utf-8?B?Wm40ck1xSG4xQjdoKzJVeGJvdXM2bWZaR3YrWk1PL3F1RVdvNzJ0ZzFLZmVF?=
 =?utf-8?B?UWZxM3BlVVBFaGRTbzRwOTFnekx4SXJPNUduMkE0cFRmdmU2SWpxT1BmV2xn?=
 =?utf-8?B?L0szUnpwL05lUXFwazVlZTBwdnNkWFBRVDlDZjR1a1FsZXJlMnA3RHdvSy9I?=
 =?utf-8?B?THJTSkJIU1lTblF3TmZGT0VCQmtKcjZZcEZ3U1Iwb0o0Y1hhZ1ZNOExvL3c0?=
 =?utf-8?B?eHlzL0lXU3c1QSsvT3JMUDZ2eVdaUG1xQTNoRC9nd0FzSGFCeDBvU0pNQ0dV?=
 =?utf-8?B?dWJ4V1hCMnAxOFRaREJUbkZjaWFzTlZDTWpnQkNTeGVpL2tXUmhhcTFmbTA3?=
 =?utf-8?B?bFFSa1EwaUtLK3pzU3I4TzhkVldrbnZ5M1lTSXh5Vk1ZUDl3WVpjaTBUbEIx?=
 =?utf-8?B?eTFXMndYODNvN0J2TE9uaWViL3lkVHZVR1V2cTY1UFlESE9COHJ1cFBlaDN5?=
 =?utf-8?B?dXBjSUpMempna0J2Si92Z095ODlVK1ZiNDBrSHVGaDNVMytnVTJoaVo1a3N1?=
 =?utf-8?B?MmFJbHlnbmM3blhkMEZyUjVCT1kwNDdnU2tKWXY0MnlSR1JlR1BJVmZ6SnJ3?=
 =?utf-8?B?R2ZLVG9vY0ZaMTRyNXltNmk5MmRSSitOakFyTC9xL1hGUWlhczRpUDBVNWFs?=
 =?utf-8?B?K0l6Unpqb1JJUW9JeWlrMXRZZCtaL0ZEMjh3WDRvRjNUNlpkZmJ4RTEvcG1t?=
 =?utf-8?B?eUVjWVpsMCsrbnF1MkY5WGtGaGkwalVqc01xRGFqUkxrclcwNGptUGNZeCtV?=
 =?utf-8?B?NnhPM0lyWk4vZ0hiTU1Sd1h1MERxOEhyMGFlNzBMYXFFcE5wNXVHd0NuSXht?=
 =?utf-8?B?QkZJNUs1c2s2TXhxTDZZMjl3WUtmeWx4RWw4aC93WUkrNzFwZTBRcit3UmFY?=
 =?utf-8?B?NnU4empibHdvSGpmQzg5c082QUs1MGkzVVZOekxIbGdnREQ5TE9YZU1xUEJX?=
 =?utf-8?B?MXJpZ3pNdHMrczdTWDRmbGtRMnJGR2xqQ2RXaWpVUCtsVzhKVENBTzkyMnJS?=
 =?utf-8?B?WkpydFAyOFZhdlZldHJxR0cvUXBxc29jdVUxWWVDRmp6cGFDdG1pQ052eWxU?=
 =?utf-8?B?QmI1T3EzT1REbTZ6OWw1SHV3cUpRVTVUSjFobVJabkhkaTFiSFowcElqem02?=
 =?utf-8?B?dk91aEhIWXRoeEltN1NzVlFrWS8wdFJheDdTenRMbkVKY0VqQ3orbmdZQTYy?=
 =?utf-8?B?SWo1UWYzODgyUmx5bVRwZS9oRGV2UmlkNGdYY09LclFsZWMrZ004Y3NyYlhR?=
 =?utf-8?B?NEF3VkpFbHd5ajRubnNESUxERHErZk80YWVBWVh4OUYvMzlnUW5vTkZldGJV?=
 =?utf-8?B?Q2xZbWp5MFdPajhyYzF3aWxjd1lKL3grL095TldDVkV1WVpnV0ppdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fa0435-d3fb-4cdd-b523-08def32edb34
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 20:19:30.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdRSi6w11S8x7SOkMcKBGutdzMoyt0a40VcUOg7AX4mdvxVmsXj3j2jAQwABqV8Zi515q/W2yG1iHEXlSi4SoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3040

On Tue, Aug 04, 2026 at 10:11:23AM -0700, Namhyung Kim wrote:
> > Patch 4 adds three new command-line options to 'perf sched latency':
> >     --histogram (-H):
> >             Displays an ASCII bar chart of CPU wait latencies between
> >             snapshots
> >     --hist-mode:
> >             Configures the bucketing scheme to either logarithmic (log) or
> >             100 us equal-width linear (linear) mode
> >     --time:
> >             Filters trace event processing to a specified [start,stop] time
> >             span
> 
> Can you please also add a test case to check the basic functionality?
> 
Hi Namhyung,

Absolutely!


Kind regards,
-- 
Aaron Tomlin
