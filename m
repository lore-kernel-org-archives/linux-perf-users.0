Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132781;
	b=CN+KYaHjxGuK9k0rJ400/BT6DRY7v5OLHgGzrlrCVMnF4JvZE4NWDxU2rXsaHusHooww
	 KG57h1hCIk2WSuH9OGsaQvXhTP/2iKC09BUKmalGeDUS6iKZY9gVkpkOgfh6odKKCRYkM
	 MYhz0Uu+aQUqXbi+krc0NMP1S2gBx4kcywXnQrYYoyvKUdwWq2zGaozN9cFpCuVxoAkRn
	 QvbR7vdM9aRKnz09t9uaimWy8kiSiRUyWPkaHdpPge8/EqXSjIxvqwZGD2Rd1KlkJK/jr
	 Ehk4QqVrpYW8rGQ1XgidL8fYiQBNrWl4I1deZScz9Fz+DhxZS4a9yQJqeu57cK9QiXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132781;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=p/kGq+QwfEMYNE6SzfHZXGafcdo2h5wlqVOSBdnFbVw=;
	b=VpNX5GPmoV65/+UYS15B1DqAiYlV2fCrM4s7lwhLIItYeq1rzB6th5QTlCLxqMjlLnms
	 ZsgkjIJzXW9O15eP+yCvHtl5VZPEB71O+HCxG7EnZo51nIQQrQ+TpuZE/bF5eOtvtz9gC
	 Fp2VSm8v91Ej9tRgfIQibL1VHoLA2XZHjnvO1RRRmRJfCfkiFMbi4mbSK4HzcBA+AkAH2
	 +sRULxK6fp+1hSXsx+9T33QR1HFj6ZAuKe5laJOAILHWc3l3nvjCCZf+ORH5iEgICZxYu
	 58M9r6oHunKjHPKhffRnNQlTwsZQJoehtM0LvEloYuArykRGif1FtyYxRoVPviSNj6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.76
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF1606A900;
	Tue, 27 Oct 2026 20:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ECF1606A900
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWmAndaYLB0uHBCrwaKNo6KAErEKIceubBFN7Xw5L6JCUfF65e5Pxx+Cbm4RnquWZGCZUKCcgbA9wKQPopiT7wCsDkpxXsCxU+qsKob4jk2+HSANxk/FfvWszqEZKwwDuCHXhyQZZIIIloTgyKaAfPz161YQXMpFTnV193D0IXMwrv12CvGv0VK+6PXjxWg/BuDD8CXSPdnxABDeKnAjnm6iVqIK+2JHYPvbV0LLgnUuoX2ribhgK5/6zYFDFG/B4Gg0oESlbhIrozLqCuNtLU6H5/qVgqHWtUKvWxNS5WQt2HXOqKRTsrQZ/PEh6Zda2QXUPIxOhu5vvIPFokljCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=p/kGq+QwfEMYNE6SzfHZXGafcdo2h5wlqVOSBdnFbVw=;
 b=J6o4USQi+QoEQzIdzwyfaIEtq8rFz3wj1QmCBL0hhBfXbC5ItDzuf2aKdwvRkfD4ACdXhfvzhVjlrPbdITA9tQhc3XbRZtfiGF1MVYe3gWIlDK8OA1PREuqUu80E8+vqn/kAOpPiy9/E5sStLBuqTz8prAi4kRBfy1Z+hUMRnvYhw0Pz2vMiQUHgoQHr6gJCGSKEGXMaGWELhFnlHey556aysSSxcZstgIZ4RRioBofomqqsK7dJO76ZIbm96op9d2lYJ9X7uIQz6TB92WFOnQHO9wuxTMt4khyBbqqlE/M5cTJFop4gT1WM8iNO6Nz+4Au4qDUqLsLcw5ULm1BD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB392182.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:282::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:26:16 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:26:16 +0000
Date: Tue, 27 Oct 2026 16:26:11 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zhan Xusheng <zhanxusheng1024@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/7] perf inject: Use perf_tool__init() for
 --vm-time-correlation
Message-ID: <xrwroz6mycibzep7cqos6v5kvsbrztni4lbqobe2gbsz7kuwpa@o4bf76aka2ax>
References: <20261025220349.1244499-1-irogers@google.com>
 <20261025220349.1244499-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025220349.1244499-5-irogers@google.com>
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB392182:EE_
X-MS-Office365-Filtering-Correlation-Id: a10c01ff-e3eb-4bff-cc71-08df34688d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|261021121427099003|4143699003|261021123027099003|261022105027099003|261009223027099003|10067099003|18002099003|6133799003|22082099003|3023799007|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	DohuczveYwvbwagtjDgD6VFcdvHNhrH7SqbJ3rmVQ6dwLfC8tloYtqiyhUOzx5HQ+gTCVS7+o/6mnOXL7Qq3o4COFA+bgMqeEZ3C6EfpYz6VFhioGVFS/h+V/1CAWb20blIxJwUu/+NCVh1KmXuh7/fUPUYPf8F+0mrnL5TjWcI/gbiCPToQUzQoTm0TcnZpH40e15GjwdzjXEcrLYhT61S5UUW3+k0DGFhjdh5w1R45p5VMx5eDliNU2tKfFVmMTOY0Y9v3e/518wx1XYuiCxtnwZiRH4c+4lAXecXk6HFWUvgj8taR37Ovo0T+r3zT96vtUOHQ+2ZmHqa6VF+GLdRs0EczH3UVPhssZQIDO0iq7OwcqbjpKuVYtXQP5WNtjXiVQkd/dhm4RM5WsUM3ox8DRHZUZLw5hhvswCwamjPA/0Oqpku7ozjUCsD8kfzHpUuTvVl3SA9hOb3DVV0PPFpHXbc76fhW83aacCFJdYUyeO8r1AUrsT2NyEy3bAHmzWndu3+Do+JbMZ2SMbhkNYmGbnWgQBWbslYkqIhlM+TDDQ0+lnZhcfFwefVILp6VKNPvxT2Qq37uMR79jiHB1WA2kb0n/qWrmMis2r92/HaPHYl587D71lUH6rbMKDP7ww4EUg0WqU4dT+5axN5ryhZFfyjEUDXvwX6Jt9GH1Qw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(261021121427099003)(4143699003)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003)(3023799007)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b21OK0hiNC9LTytYcWJnZ1JLeSt6K2wreERLUExyRHRwT1hOZEhOb2I4ZGJ6?=
 =?utf-8?B?OERXTVIydXA3em83ZUVDU0NzKytZRUZtY0pxQU5ERERkb1llaWVXR293MnUy?=
 =?utf-8?B?aWRuUWQ3MTJGRE5DNGZKQThlMlRSNElScnpIaW9VVW8xY295Rm5NK3dhdUFa?=
 =?utf-8?B?V3VManpVc2FrcFpVUlBoRjBjWnRZTzJnWTc3TjhQZVJzU3YzMjVxK3lra1Vm?=
 =?utf-8?B?S09YZ0FpdHg1WHArZTJmMFZYcXF5NEtEdFMxZWE3dW1mMTNlZHBTeEhHdmxE?=
 =?utf-8?B?a1RvUW9ZWVErMkJqSXdBQjhIQjFRMGUwWUVGQmdvUUovak54eDZGWCsvVWdw?=
 =?utf-8?B?TnpjWmluY1VrbHR5MGYvYzBtelNzWEFRQ1JhL3RRZmE3QnlITDNQeTdWNDFG?=
 =?utf-8?B?WUcxTGQ2WXVvZEZvZFpGelVUbVlBSGt5Ly82QTE1R0pXNnQvVVI0REpsb21J?=
 =?utf-8?B?MFk4VmJmem9WVDNUYktqaS9jUmlHTXh0bjV5NnlaamJIdDdhY3Q2SG9aNm9V?=
 =?utf-8?B?RnZzcmdENjVXM1lURndxMGNZclp2QkhkS29tYXhic05lckFaSXpyRnVzcEZ1?=
 =?utf-8?B?UHoxMVRnTnFvYWZnQ3QwcjAxYlhtL0ZEZjZCVGtCY2Z0OXoraHIzZVBpdDRI?=
 =?utf-8?B?VWtBY1hZNWJZQmJIejhUWURraVI0dmJua3ZiUVJKQmFBZlFoRW9QcUJGOXpi?=
 =?utf-8?B?K0h1Z2pNUGZJVGg3My90YlRFYy85RFI1Ymk5c3pQNUdlZjZZTFFXdEU3NDZ3?=
 =?utf-8?B?VUNXUDAzcDVsYWFzNTBwSHl6M2RXR0ZnbDFPLyt1SkNwOC9qeXB4bWVlc09P?=
 =?utf-8?B?RE1NTjl4NGVvdDMwNFZtTks5dFl2aWM3UkdZZFk3Qk1NWE85RndqY2IwdjU4?=
 =?utf-8?B?ZWYzVVpTRk0wMitLallhN3BBYzF4YXZjb0gwWStoaDB2eVZ0UUlkTlN5THV5?=
 =?utf-8?B?NlRubW5nckFxQjBuK0Z4N3pIdE9WVE81OEMxWmZZdU9ZZHZ0MDJneXJLSEl1?=
 =?utf-8?B?bnZvVXdWUklRMlFyQURLa2NWL28rakhjOEdOS3NPMkc2azZ6NFJoMTlaSHRj?=
 =?utf-8?B?dUt0Uk5GcWNZN2gzYm9qaG1yeDlTN0hpb0JGVUw1a0UyaTRMTVQ0bG1WTloz?=
 =?utf-8?B?a3MwRTF5Uk5nZ3dneXdzNHlmT01JbEVaRFFLK1Y5MmtpaHp5Nkx0VWJSb1Ny?=
 =?utf-8?B?YWdsYWIzb2dwcjVERVBRWWpVQm41R3d2R0R4LzR6bzUwc3Y3Zy9qdkdlTlpN?=
 =?utf-8?B?NTliU3NMemhnWmcxZ1lvbmRobzBabVZ6dTlWeE9jK1hpUUMyMWxVUDRHeG5K?=
 =?utf-8?B?RXFnSjlHR3l6VEJhTnZaVDVoa0FhamRrSlB0elUrZ0VOY1VIc1dXMEluWkdR?=
 =?utf-8?B?cjJUSW9BNldRSHNXd0JYajAyNXlXYlB5T3YwaW0rMDBTeXFZNFY3MW1tckN1?=
 =?utf-8?B?R1RBM3FZVGlCZncvM0o2Q0NkNDg0VzBVam14Ujg3SDhMM0c4dTBGVFgvblBK?=
 =?utf-8?B?WE9Zd3JJckQ4bVhVT1dZVFhZajdrUHV0MU4vWUx4eCtpOFZhVEVQSGpVMFk3?=
 =?utf-8?B?bm5ZVzcyNWpqNnE1QUpqV2JGbnNxRkxUbUFMTjhSbjVwSStkOGZKcXpuTW5r?=
 =?utf-8?B?cnJJRGwzZWhYck96QVFqWDdmWk1lSGppRVNZSlVVWE1vazE1QjVNR21DNHEz?=
 =?utf-8?B?azJHaXFFNFR4VWRwWGJGVUZJWWVsSkRHUU5BSi81WWlDcE1tS3BwbEFIZnRi?=
 =?utf-8?B?bGZGWkxYL3p0VHMwRVFaZ3JYNmpOQUpBZXNoVTlJRUhGTVhrZm84SURSaFRN?=
 =?utf-8?B?T1MvNGtUQVYzajdQenlMUzgxRlliQVhIR2RvY1A0N3FVZTV1UktCQjBhNWo4?=
 =?utf-8?B?RXdWOHVnYTVFMU12c0Y5ekRyc2dVdlBienhIemxpa3B4ejBGQXZIME9PSUV4?=
 =?utf-8?B?SURFVkhITUZ3QWFlVVhiang0RUJGTG0ybDNhaTE2ay8zbEtuNzQzMVlEclhH?=
 =?utf-8?B?ZE9KdWQ5MjIyZmFBNFlDZW5pYUVGRlNsZzNZelBVYnFtZDJXY21mRWJiUHpk?=
 =?utf-8?B?L0pjQytLa21OU01wU3JYQndNUG5iUkh4L3I2QTd0YlBqWkZleXl0U1p0ejll?=
 =?utf-8?B?MHEyTHRLaE1JVFVjNUQvbDhXMkhlTy9wM29peWxoYlhvdTFQd3lTZTYyRi8r?=
 =?utf-8?B?WHZXbERtUCthd251NU8wc0lSb1hFckkxOGp2dFVwOHBZS0M3OFJwdXczWWJa?=
 =?utf-8?B?TlovazlMNXlGMU9BMDZZNDRodnEyQjdkV0dYbHh4TDJnOXprUXVXcGljblJN?=
 =?utf-8?B?S1d5dmNabUMveEZ5R2xwQ0xGREcwMW4xK0ttak9ZdjAvODA2VERDZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10c01ff-e3eb-4bff-cc71-08df34688d1b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:26:15.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t62oCQYK+YAqDpUgkYnXiFz0/1Aae2DXkLCmZVuawyRle0jpC58hSZE+Cp72GpyoWd58b1Z8oGKB9mmEqvnMdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB392182

On Sun, Oct 25, 2026 at 03:03:47PM -0700, Ian Rogers wrote:
> When cmd_inject() was converted to use perf_tool__init() in commit
> a37c0436f379 ("perf inject: Use perf_tool__init()"), the
> --vm-time-correlation branch in __cmd_inject() still called
> memset(&inject->tool, 0, sizeof(inject->tool)) to clear the default
> repipe callbacks. Zeroing out the struct overwrites all default stub
> handlers set by perf_tool__init() with NULL, causing a NULL function
> pointer dereference if any other event type is encountered.
> 
> Use perf_tool__init(&inject->tool, /*ordered_events=*/true) instead of
> memset() so that un-overridden callbacks retain their default stub
> handlers.
> 
> Fixes: a37c0436f379 ("perf inject: Use perf_tool__init()")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index ce7562fc788c..c30f5aaabf4c 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2464,12 +2464,11 @@ static int __cmd_inject(struct perf_inject *inject)
>  		}
>  	} else if (inject->itrace_synth_opts.vm_time_correlation) {
>  		session->itrace_synth_opts = &inject->itrace_synth_opts;
> -		memset(&inject->tool, 0, sizeof(inject->tool));
> +		perf_tool__init(&inject->tool, /*ordered_events=*/true);
>  		inject->tool.id_index	    = perf_event__process_id_index;
>  		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
>  		inject->tool.auxtrace	    = perf_event__process_auxtrace;
>  		inject->tool.auxtrace_error = perf_event__process_auxtrace_error;
> -		inject->tool.ordered_events = true;
>  		inject->tool.ordering_requires_timestamps = true;
>  	} else if (inject->itrace_synth_opts.set) {
>  		session->itrace_synth_opts = &inject->itrace_synth_opts;
> -- 
> 2.56.0.307.g5fe7bd680c-goog
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
