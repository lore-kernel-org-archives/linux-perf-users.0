Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EA36B91B;
	Mon,  3 Aug 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798610; cv=fail; b=es+2Gj1xlK8x0oQm+xI21LBvGOS5Q6YTkk33HFm09wYmuqaU3RIbWIKmMNeoveibvUJRLbcnjFlnc4J+et+fnAxpOLxnFlSXRlo9Lekfu44COyvLoYxyf2nVQKw4rxqZfqe0lAIchTx0/KtLr66H1MY/JktHZrLVFzkDkcPl0aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798610; c=relaxed/simple;
	bh=g+VWBOEfuiV3gE7RiReU+K7H++uDSfieab7VAy/tB6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G2sOKAeLFmUnQqlHP4Bfoxfqx/GEvgeydqUkjAOqBS1YO6AqKQDuH+6hLUnPgIN3WUrwU6JJxT6WyRfe2+lZztGcHTMbba4nGZgSPACUJOTXRSh3PYCala14Rtwho5bo8xgGhNvJmgTS9W2gS+M311KqjAyGQa0Nh1IK8h1cBdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR6wzBo9SzGxzgAXg8EBwBi7L9BNaFb+ZsAukiG/6uX4GLrYY6odwVzbVT6alS01hLmFIm6TQTLHIMVgljdc1/XQdoCJpcAycd0HjVQDktV+QElL2Tw/9bDnhBYu0i9pzlAcaGl3vyPmn9vi7WUVV03U2zLNBoPKuhmGBzERzY98zBMElQ8/8qOw3E4k4RdifQyLiINBmEvMdg0RVtNjkNuYRaOZGpmvh1b/vmoU2kGyr/ZqTv6JVmI9Wq/gyMzGdN54vAHwwhlfsr4Ae98Sml60kUuiZJhKtAhxGn8wN/xOFAIAvuDkwAkPoxydvFf3rTk9qGOlox+MVxBejSBUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=rX2AIpjX51L3ax4eLy3kh5DtkMEN9gt57aTIM6/SacQ=;
 b=RTyzSr4sAJsjwh1TBvkoUduA2lc44y2kZorlQuQJ/Mg4AhUXlc9tYudBbevhlYeTTIzaGmNc1ab568yI4QV9ERx/AFdcdwuHpz9+6Tgh/cQZsBTKMasxf/xHAUF5YSfAuwrvIbYSVbmJQodm6G/m/YO7NwAalX/iJhSN035lYGmN2SQ9p891eVw6SrGZUPhbafNWKwcU+rN1o7qlpvZOcTWsctW8zmrSyR7SRWhbWwCt0vAIQEYuYRtiaIlXA6XIXkdZnjXBFyCN6t1arFGINxaV9gogRmockld620Un1UcRVHQGY02sGTowFJToZeudax1EAoaazx6VkOTSq9uYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB4092.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 23:10:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 23:10:03 +0000
Date: Mon, 3 Aug 2026 19:09:59 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, 
	sean@ashe.io, steve@abita.co, rishil1999@outlook.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf trace: Symbolise kernel virtual addresses and
 function pointers
Message-ID: <v3p5sunmqj32p6hx5uhe6aqjknovume72uzsp2fxoqv7l44go4@4bj4ubzhcohl>
References: <20260803210842.245789-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803210842.245789-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:408:f8::28) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: b220d41d-e3c9-4b55-21a3-08def1b45981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Kn+MvVgJQ1M5KB8CNGYzBMPR52FCUCUSV/ol95yPxI8+/vlz7dw/KKflrk8ZAUX88jAYLSjdwP6kePnJ8DMZ0Ng1CPyU0OI9KTU8/ONbFv5AjFmDkCkgBILmRvtqM+KBpJw/ua1qHJbrcWPC7zR9iXNzPfl+ke2xhkqucUFw48CSfEe0MiB7Fis/HkeINYp87BMxY71HowQocX5Tx7zWya012e1Vw1IbQIVXhsjsOrOeKfyjWcYZJBPtr8sUmYoy9A52C9mzWCzrryJ68+owwYKTsctcv1uKzeVQSk7JcOjP+rBTWhxzmY9WuWn/bUIGQWnX2hysr0klGVZOWjN4kwcA+hoJsZ7NeYOVY4lU3qwSioV7bbPSqVDBqmuB7UiB255D3OtjchF/fwQ7hXcRz5hFxwJNT4Ilz8Xqa3H7bstljclZGuN5pMPWFVzCQRfdPhWb8QqZRn7s6W9bt5Uocq7u23GBQT+y0zQfZgJCeUY5Xnz9H4othzed/DwEN+SQ0wKKNZ+Pq3wzyX/tGZ+jjaKdgnQ9dcOBtKaEBqb0S5ru6StaUi3GoeBWaAi0vVLEYf9s49XenM7QyyFJWWeZwB5oKPNlOCm27ZPLYixPhGkA7IoPoYR/YzcHepvf1Ue5x5p2Ih/nAqSNJ1hbxLPV+8a+6Hq+WE969ktYEjf8yYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjRTcWNpNStpN3ExUlV5ZExzdnBwbjFxTFdMSVk2anBJc2loMzNOcEFEbzY4?=
 =?utf-8?B?QTU4anJDZ2xHc1dvV1pxdjRtNEFVUTBzNWZBUXlYSFJ4K01CUXlKc0RsczBM?=
 =?utf-8?B?eXJhZGJ2dDV2Tlo0bndodGtDc20wU3QrdlZsU0hSayt6ZzEyUmsrbXFUNGJR?=
 =?utf-8?B?MUVLR1VMUWlkV2FtblQ4dEpXaGVrQWxsRTFEUFQyVlBSRTVNS1Fxem8yVGFT?=
 =?utf-8?B?bnlEWnR5SXlMRXJCTkZzU0dyeGtaM1I5eE4wNng4M3A5NjdHZktpUDlvTDg3?=
 =?utf-8?B?YU9VV1QySXJIT0JCRmR6ckN0L0MzL1BXQlVNQjJveVZYOXA3VWdQZWpiMzdw?=
 =?utf-8?B?K0FCN01XZGppb2V6VTlwZldSTmJ2NkVmaWNwUDk2OFZWZXdzZzFDNGU0Uk1n?=
 =?utf-8?B?dFZGeXFGejBLSmNybmlvNndTZ2oxMTNoSWRySG8rSGExd1lzN3JSSE05SFll?=
 =?utf-8?B?a1NROElYUllrZkxJRGl5aXF2NGtXWloxbXJiTlp2WEI2aE9LUXN2MDVrd1R1?=
 =?utf-8?B?emtMZXd4RUNPU3dmUDRHa3hReDZQNDQ0c2REQkM4U3F3MzZnNmZLNkRQcUFl?=
 =?utf-8?B?OWlYL3RPcGJDeTJtZkZYTVdYZWRqVGJSb1dJYjZCRkJVdWh1MTM4a3BCTTdw?=
 =?utf-8?B?Tit3NGhTT3lHYTltaVhBakgzRnh2NVIzSTdWV29BREdWUHZxWFRRa1NyQnhK?=
 =?utf-8?B?ajhEOUZXdVhpQXhBL3JyR1pPUDltMGNQeCtvMngzVTk2aHFSTFA2SlIwOFZO?=
 =?utf-8?B?cmpqMjNrRG02cHpscE9WNW04WW9xNTVaZjJURDBKR2w1OWJ5MkI2eXhzbTZL?=
 =?utf-8?B?cHBsNVg2WVFkdkVaejVQZUZ5bTdnUU9GeFlRZW9VS09GY1E0d3V4QWtXenIy?=
 =?utf-8?B?WllyelJuT0pSVjNrNHBXcmJXNjM2SzlVS2VKVGtnZ1dTQUJweFFlR0xXVmQ4?=
 =?utf-8?B?dWNCOEUyQk9QbUo1TldzRUhLeHBkb2hqZXVyRlVtUUhvRnltTkVFSVFlVzJy?=
 =?utf-8?B?akRNb2gzNmkrbjRSUHdySWtJZWNhVlo2TGQrQ1RGb0JxbWlGdWhrYncrdk5w?=
 =?utf-8?B?cUZCTWdiZGtTNzNCdFdmQWZEdUpBcjhYeURndkNBUlNMSkx6dUdwM0c1S2ZB?=
 =?utf-8?B?ektiMnprYnFsVzJoWTZ3Q3o5NWJHN1pqdUNPL1IwWWFYT1pRdHJkTlRDTks4?=
 =?utf-8?B?M2hKdmdvc2haWVBXOGZ0bHgvenNKRFplQStSbVdRMGRCSlN4VzBVY3cwV1FJ?=
 =?utf-8?B?WUNQZVA3WUowdmQ1V0sycG9iU2FxbVp1VCtjbzlPUldiSGlmWDJxZENoSkcr?=
 =?utf-8?B?c2VrU0FJanZLMXdWSmx3REVScGZxRzNkR1N4MjNuSlVuZkFoeVgrSzRveDBH?=
 =?utf-8?B?blpFN2ZxWXBBbWF4MXFRL25yRERnQXJwMWVRaXpXd1NrajFudE1iMEZHbE1h?=
 =?utf-8?B?WGxTbzZreS9LRWJDcnVkQ0ZzMkxvODdFSWNLRjdobE05TWl4NVBvSmVjWTFM?=
 =?utf-8?B?WW9EWWdjcDUyMEV1REVVdTUvc1M0N2F6aE8wNDJVOUl1U0dUYy9qU2VoM0xT?=
 =?utf-8?B?eXY4YnRYT1hoNmhjVVFEeXJjV1Z1SWxRMTJ0MVduRFFkZThFWU9jWm93eHph?=
 =?utf-8?B?ZXN1aUJnUnJnMHdtWXY5VFc1cmxvdTZBMzNLNXJlQ2U2NXBlbXFKVUZzc1lY?=
 =?utf-8?B?UWZYTTdRZzF3cWdhbXVjSk9LQ0s0Skd1Mzhvd292Z1lPQkNGTnVvdkd2OVNM?=
 =?utf-8?B?SDdXQ20xTEc1SFFuUHpIL2dPei9Gb085dTN1UFBRRlZtZCtDNk5vWnhrSGJP?=
 =?utf-8?B?N0VkcnV2RmIxOGlUdGtkRHh1SWFiSmhWcW9heXB1TnZReUViWVgwc0xUNjZs?=
 =?utf-8?B?TW1XWTBCMkRmSnd1cTljYlFnRWdmb3VQN0V6WE1JMTdTQ040MHNJNDg5VXlj?=
 =?utf-8?B?enMra3dKVnRoKzdwU3FxQzdweEEwbm1wNjJucFlmL3Urakx6eDQ3SUVzOGxo?=
 =?utf-8?B?ZjNVUE1oNC95S0kxQy83RDZQRWJPYmVudFBLSUpOUE95a3p1R2ZMZTVZaGcx?=
 =?utf-8?B?aC9wVytCTEx6SENVWUd3SDVBc2NSRDVNRDF0YW5ZQ2IwOE0wZkVkTnR0MVd1?=
 =?utf-8?B?TmIyR2h2dGtaT3VzNXRsRWU4NzRWdFo2QkFyMUtOaWdKTlMwaEVPNnNGT3lq?=
 =?utf-8?B?a3FyMUdWL2s3Q2U5cFVpcWtBV2RxZkxyaG1mRENZUUtYZXY3ZVA4MjdnRS9S?=
 =?utf-8?B?bU5qcjFNOVZpSDNhOEYvVkhWdFJzczU3czdYZWM3bm5FU043RHpNcFBreSta?=
 =?utf-8?B?VTc5ZmwyamQ5WWk2cElNazdwcE1DeWtZajExWlBBallhZEtxcWlQdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b220d41d-e3c9-4b55-21a3-08def1b45981
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 23:10:03.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yi2b2jCbL0he6ZeHUZTtJQsRfjZG2bwwLfQaHoZ+kCJx6Snfo4039JWnej3i3XPp1gwGXljiaL+OTijtFN0iXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4092

On Mon, Aug 03, 2026 at 05:08:39PM -0400, Aaron Tomlin wrote:
> When inspecting kernel execution flows using 'perf trace' (e.g., when
> monitoring workqueues delayed work items, timer callbacks, etc.),
> tracepoint payload arguments containing raw kernel virtual addresses are
> currently rendered as hexadecimal values (e.g., 0xffffffff81234567).
> 
> This requires manual symbol lookups against /proc/kallsyms or vmlinux to
> identify the underlying kernel function being executed.
> 
> This patch series enhances 'perf trace' by introducing kernel virtual
> address and function pointer symbolisation using perf's native symbol
> engine (i.e., machine__find_kernel_symbol()).
> 
>   Before:
>     workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: 0xffffffffa8046b50)
> 
>   After:
>     workqueue:workqueue_execute_end(work: 0xffff8ac2c420f270, function: wb_update_bandwidth_workfn)
> 
> Patch 1 adds the 'syscall_arg__scnprintf_ksym' ('SCA_KSYM') beautifier
> which resolves virtual addresses via machine__find_kernel_symbol(),
> formatting them as 'symbol_name+offset' (or "NULL" with a hex fallback).
> 
> Patch 2 updates event format initialisation in
> syscall_arg_fmt__init_array() to automatically assign SCA_KSYM to
> tracepoint fields named 'function', 'fn', 'work', 'action', or 'callsite',
> as well as fields typed as function pointers.
> 
> Patch 3 extends BTF pretty-printing in trace__btf_scnprintf() with
> btf_is_func_ptr() to automatically detect BTF function prototypes and
> symbolise kernel function pointers without requiring manual field table
> configuration.
> 
> Aaron Tomlin (3):
>   perf trace: Introduce kernel symbol beautifier for virtual addresses
>   perf trace: Auto-assign kernel symbol beautifier to function pointer
>     fields
>   perf trace: Enhance BTF type formatting to symbolise kernel function
>     pointers
> 
>  tools/perf/builtin-trace.c       | 76 ++++++++++++++++++++++++++++----
>  tools/perf/trace/beauty/beauty.h |  3 ++
>  2 files changed, 71 insertions(+), 8 deletions(-)
> 
> -- 
> 2.55.0

Hi Ian, Arnaldo, Namhyung,

Kindly ignore this series for now.

I would prefer to wait for series [1] and patch [2] to be merged. Thanks.

[1]: https://lore.kernel.org/lkml/20260802210914.199941-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260803124845.213165-1-atomlin@atomlin.com/

Kind regards,
-- 
Aaron Tomlin
