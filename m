Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132862;
	b=LuJ4blLZZxBowSXn8WGcBgcSb7CEP+5MPJS9yaVVO9C37H9zfXqQ0gBSr2N0w+A7sMpK
	 EvWMuJKQFkyObkmlOQNtoxJyUcnUIA1LqbMxaEt4TaAXA1srPMu57Tm5aLcCHqGeGGc6t
	 YcoSvmNvbIs3v8xPGr6dt0g456iOaFi3FsGk87OG2eWKLP8cz80R6J8H/qkzfjlyPQB8L
	 v5TaEE0kEk/Iqf2DmeF8aLdRY/Y4Y0rBGOcEsu4whlH5R3yKd3M/7SlDIS4/v+QwiwWim
	 SNlW2ytiJnb5TCj85q3Wdp4IQ1qXnpn8tU2OsqGlzj5k5XbBSj1rsKG50dYX/q8WFpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132862;
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
	bh=xlljtLpVa3TC22agk4PtilGIM17Uc5+2eANTfGm4074=;
	b=2NFE9fE/4SfwNv16FLM3gExE2Xigor9goElSBF8aZexSOpcOlDBguPmpVT4cXzUGYuhC
	 7Lc9ctp8gt/pEYXhbIURsx48vCCwNQhPNx5rivfGLFyF46KTIXOqyEA8ETr0qU6jF1KPr
	 VJlF7lDQoaz9uVb4cEsqgBF5IPyc/xKtZEJbWd+F4k1WpA2NoX6QVmu7nQpeZqVl2ZBpi
	 6YI+lC1/ubHUNn/qX4yRwMvHeU7atKDr4kmDCVy4jZrdum+RaTC5+f0kXmW3PETv3LiC7
	 dyXc87hB65rif3bWMBfHqGxqvfPVrkiGMF6yfixVxGqeNJTO6wwguG5hCK8anUZt/yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.120
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020120.outbound.protection.outlook.com [52.101.195.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC5606A31E;
	Tue, 27 Oct 2026 20:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCBC5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mb9fcaWWt89Tk2ayhbL2k2MlYuDl/EHFOM2kgF6K4Sa/dzzaKh1miSmlPFNQdPS6PElXhrGj2WDA4Rba4IDhBclA3EfIOLePXNZoa4pTlrgXYQBEUqQtOKUNXPl65BWVsUZ2+X1QRT2hW+auVIKrkXjX59t99A3Mfn0hU5DqQK6o5gu5KeuJHcdJydL4iHGeJV76r9+L5Sw9NHLCx17PPpBe0eO8Fkvurbhk0BJbt7Ip38MQqld7sVrSVmvKJYJHmIjNXFZXnJWsFaYhlULqjVN/kO8cqswk+ctq0KEvtmH/Vq82SwcvLajRmYOF1A9ebEq150d2HBX61cUEgrq86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=xlljtLpVa3TC22agk4PtilGIM17Uc5+2eANTfGm4074=;
 b=COpcrEyBBUo3SsNdy3x4QFTk4vuUvTl7jQgrCrqhfB0ZfCihSFjPrqJQve2ldjrvyxLlGZ6sSERGrCdY7VuKMbdqozLs0f92GLNvcOKDxYgeweB5GxqxgvuSbjld9xvy4NdNJwyEkyAzU3wcbZEpYa5up5Oo0ChHoHx31zEnuol/tesNJAUGJwoYY3wl385CTZg/txHCyt5KdhrtZMGnkTrBT40ovjsP5IQk/frjFk+5yPa+YSo3FFQ1qK7vsNSN/X8SXYlc2Hm/VhdtHZcCnba5p1x5etALy2S3xwsRKp9ppBdsAzJrSC5I5v9j9OTs1KlagzCvg2zcJEp7+Hyklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB392182.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:282::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:27:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:27:39 +0000
Date: Tue, 27 Oct 2026 16:27:34 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zhan Xusheng <zhanxusheng1024@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/7] perf inject: Set ordering_requires_timestamps
 before creating session
Message-ID: <3n2avzhpvlafgmzgcrnpila4gxxomeav3bedihrhuq5uu6yzfm@it3qjkjx5bsq>
References: <20261025220349.1244499-1-irogers@google.com>
 <20261025220349.1244499-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025220349.1244499-6-irogers@google.com>
X-ClientProxiedBy: DS7PR06CA0037.namprd06.prod.outlook.com
 (2603:10b6:8:54::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 5615283c-408d-47ca-ff6a-08df3468bef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|261026121527099003|56012099006|261021121427099003|4143699003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|10067099003|18002099003|6133799003|22082099003|3023799007|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	PhAMtWMZVYWmWMKO7FzWcC7u6Y5SJqdPgab2fzKYWGCTnMRzYHku+CUJc/3o7O+t49GMRB72/oQhXEglfzFB6gUmtg75NejeCHMYqJ7FTx/7TbaN5h+gGe2sdR8b5TFJNjfp3MafGkHavj2sSq3V2J9GDdLAd2fog6V4V8dicK7e4Pc/b21U16SuUsEH4KcYJgbdFfo//ekIrg57up+/5mdArIeq1/rxLt+39JLK1VyauPf1XQLEIdYOQPZi86c6Y+A/Xh5r4LpJ7vPylnvUCxjFvaniRzblzToHvUblhTunpT9Qmp3HX0ZACJkoye5z40WK+1VQ04f05PXZWpkKjo8ioPeg5Frteot2qMOfcBQNY+RHfO0CbGSTVvASQsH8tw1nXahC15NmgobCKnvRAT/13y75J79z72sDjv7pnL32G9MXYT7meYMB2nEJp0s9RZzbHX+TIHjBCi4QnptNq2TporPxW7a/MGb+xneFR6cXEid0wBE27j5EuLmb0ys3VPqXmBL0PNHNqs6J4LhmJwiJ3i8OByUqmT5NRIUNMLyNkcSp9stJM7gZqQvFNahS/dlOvlIDPstDVxG+FRsGUDWQ9GUbvOaLJGsZXGzBUrRuuis7bAwAqmI0RFf+fEMSAjn+eXBLVyXlEMxW6+uLU9JpvTzIBO1FJ7SaeYRqqrc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(261026121527099003)(56012099006)(261021121427099003)(4143699003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003)(3023799007)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGJSeUxtRTRvQ1JrV3BYeGJKL2hpbk9yQ1N2QUNDWDBseEE0RkE1bWZoQTJz?=
 =?utf-8?B?TW9vZjEwSVhXaVRMaExyRGpyRzZYQTZZdmpoNHFIV0JEalYzdlI3bFd5UERJ?=
 =?utf-8?B?OUpGbU9DUmxzc09xWDNKREU2Q3hVSk1JeE9HMm9BZzh1aS9xR0MrUFRTVlF5?=
 =?utf-8?B?d25Hb0lHL3JDOGRSMmg5K1dwZDBZdlgrdTErTUMwUVhESmpiMW5FeHRHM1dv?=
 =?utf-8?B?bDQ4RkxWYmlIYlFNVUlDajNuaHJwb1JTVE00SXFzWDYwK3hVQ1VxclNzWlFs?=
 =?utf-8?B?WWJlVEFzRW8veUxwVFRpbVZIc3Q3YmoyT2tjckJ1b3UxOThCU3JMWU05aUFz?=
 =?utf-8?B?TU1ERGFwWHFhNkhxMXpydDh2Rk9hcVN4enBHRFpZTlZKUFJTNXNGTWtpa3J6?=
 =?utf-8?B?NlExYkVYNmMvS1NteHdZY2NxRlIrVGNmSzBWQnJpalltUUJkN2J6RGNGbkR3?=
 =?utf-8?B?WmtlcGkyQjU5ZUM2ZjFyd3U1Z0hnUStwVGQ3MkFnMG13YTcwN3VSOTlFMmpM?=
 =?utf-8?B?NnlNRzdTL1FKTGNTRkp6ZThsb1hoZ0xST3JZK21hMU9JblhiY2trYzVmR0xv?=
 =?utf-8?B?ZHFvWjFCOFVYQWhZS2c5TmZINzZoSUgrRTEwdzhaNXlmYVA2SUZJVDJTNW8x?=
 =?utf-8?B?aHRyQXZsR1ZTYUl1bkJrWmkyKzI2OGYzd1hvSXkxUnEveXJwRFhqQjFSUjFw?=
 =?utf-8?B?bngzTGdWajkwamhTMVFLb0sxUFhrOE40Nm5NV01DMEtQQi9heE5qVitlNnpZ?=
 =?utf-8?B?Z3plcjNyd3BkdHFha3orK2R2ODhaOVhXV3EyK0NYRXBoMEh3dy8zZlBteXpr?=
 =?utf-8?B?dTBVaEpjZEFvSlA0TS80UTNUVEZ0MkVhWEY0TWFYdW1Ob21OZWZ6MXBjK2dF?=
 =?utf-8?B?V0R4cFI5cHB1K1lxU0pqTzhIdlpxL1MvblFWakk0S3gyUVd3bUhyMTMvQ3BH?=
 =?utf-8?B?N0lVN3VGYlBSMUM2VDdRVXFRUHZ2Tk51ZkswZmRBUktQUUxmbFJBTXMzbFR5?=
 =?utf-8?B?alovYllQQkNZN2lGRFp3S3Y4dG5VSTVOdDFyRzYxVjhIWmp3eG5pRnJaN3ZH?=
 =?utf-8?B?Rm1vdTByczFkdHB0akIzcGFoM2lLNW1MT2w1dFJTWU9yTFBnWFk5R2ZnbWZJ?=
 =?utf-8?B?NFc3VkhRcHQ5VTJlNlRCeHdTaUhRdDYyZVdDRU1ZTXdGQXFGNXNWNGlFWFBR?=
 =?utf-8?B?dTBnTzZQMFVqV0xheVlvT1lhZkoyYVZvQ0N6bW42QUVPYkxXRFVmOUVYSnhu?=
 =?utf-8?B?aDFVYjg0WVVPZXBCYlgvYUtxVUFDdzNQeVhuYnVzNWxlTzZNa045VXh0K1pU?=
 =?utf-8?B?Y3RBU1M3cUt1cmxNMTNZZk42Z3RPQ2MzTGFsKzNoeCtzTnJvTTBLc1RKazFv?=
 =?utf-8?B?MGtPQjdYUUFhcGVMeGx6eU16QWttdDZ1cmtpMExxOS9zQ21VN0pYM0pKa3Vj?=
 =?utf-8?B?U0xjanpqaEJpb1h4OTVJLzkxNlRvZTYzZ3ZuNnRtdlJLTVNSQ3dXU1o5Z21O?=
 =?utf-8?B?NFAyUVZiZmZHcHI2MVduNytLczlsMWlxcVUrd0d2MEpqcXlwZFJkaElRYXdp?=
 =?utf-8?B?MjZkZTFWbEdmZW1CL3BzaS9sWDZVcXVHazlzVGhMbjVhUXlIVkIxUE9lZlZV?=
 =?utf-8?B?cmNkUGc3TmQwUmdhNzc0TitFeklxaUNDTkRUZkVrc2NaWkhMQXZrclZHNDJh?=
 =?utf-8?B?RHQ3SkZHMlhHajZERlJBRnNVNWZibmdlQXZpa0FLZlJZcFZ5dndEU2Nsd3Rm?=
 =?utf-8?B?SVZjZXpsNytMc1poZGlGSkZUVXdtWE8vVTBpRWRjdGlDUkpGRGJoaUxiNXg1?=
 =?utf-8?B?TFNVQ09pNU05ZG1HTmFjTHFNN0U5NXFYSElJaVEwTTZpdkVjUjhpTCtIRFE4?=
 =?utf-8?B?YTBvaC9CNEg3WnFpMFRaYm1MZzhQV09Oc3ZWaUhibEkzUlc5all6d1Q2M25L?=
 =?utf-8?B?N2dDRUFZamZkWG5TNkRMSStKUE1FblAvRXpMcWw3MkJLNW8rbWpIdUNsMzlu?=
 =?utf-8?B?K3R2YVpEQjFjRUJTbWNIWFB5VWFWKzlmeUlqb3R1VkhhOVJ5ZExYTmJCZ3RV?=
 =?utf-8?B?UE00K3dUd1hTb3Q0U09DSnR0RkMyb3gvMzJLWU1maHlTVnplT2p1ODJLQTZP?=
 =?utf-8?B?N3JzZE1wZ3NOWXQzM3FWRHA2ODlFWTNVeUxuekxCRVE1NzRiNU52OVltYWtq?=
 =?utf-8?B?TDlHdkdIdlhzMXRQWVFiY2ptd2E1cUNXK0Q0SW0ySmVVWjl3bTNPRjdmZlkr?=
 =?utf-8?B?NWY3OVUwV0hWaUxxRDNpUDBhUmRDVHgxbFYrQjZONzBhYzNGQVFtWnowbDVp?=
 =?utf-8?B?Njlzc3BIL0tqMmZzTWx1SUxTajk2RjBDN29rZ0N6dWkzZld0bE1iQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5615283c-408d-47ca-ff6a-08df3468bef8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:27:39.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lnj/LUCAOuxMYl2613N48wNtU+1B7CSg64MZRN73EnOywiwp0dvlja6758PlHk8MfhJYUiScStXIHob85AYYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB392182

On Sun, Oct 25, 2026 at 03:03:48PM -0700, Ian Rogers wrote:
> In cmd_inject(), inject.tool.ordering_requires_timestamps was initialized
> after delegating tools (such as aslr_tool__new()) and __perf_session__new()
> had already been called, leaving delegate tools with the uninitialized
> value. Set ordering_requires_timestamps on inject.tool before creating
> delegate tools and the session.
> 
> Fixes: febea9ec382f ("perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c | 49 ++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index c30f5aaabf4c..3f3108fd3981 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2463,13 +2463,18 @@ static int __cmd_inject(struct perf_inject *inject)
>  #endif
>  		}
>  	} else if (inject->itrace_synth_opts.vm_time_correlation) {
> +		bool ordered_events = inject->tool.ordered_events;
> +		bool ordering_requires_timestamps =
> +			inject->tool.ordering_requires_timestamps;
> +
>  		session->itrace_synth_opts = &inject->itrace_synth_opts;
> -		perf_tool__init(&inject->tool, /*ordered_events=*/true);
> +		perf_tool__init(&inject->tool, ordered_events);
>  		inject->tool.id_index	    = perf_event__process_id_index;
>  		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
>  		inject->tool.auxtrace	    = perf_event__process_auxtrace;
>  		inject->tool.auxtrace_error = perf_event__process_auxtrace_error;
> -		inject->tool.ordering_requires_timestamps = true;
> +		inject->tool.ordering_requires_timestamps =
> +			ordering_requires_timestamps;
>  	} else if (inject->itrace_synth_opts.set) {
>  		session->itrace_synth_opts = &inject->itrace_synth_opts;
>  		inject->itrace_synth_opts.inject = true;
> @@ -2482,8 +2487,6 @@ static int __cmd_inject(struct perf_inject *inject)
>  		inject->tool.aux	    = perf_event__drop_aux;
>  		inject->tool.itrace_start   = perf_event__drop_aux;
>  		inject->tool.aux_output_hw_id = perf_event__drop_aux;
> -		inject->tool.ordered_events = true;
> -		inject->tool.ordering_requires_timestamps = true;
>  		/* Allow space in the header for new attributes */
>  		output_data_offset = roundup(8192 + session->header.data_offset, 4096);
>  		if (inject->strip)
> @@ -2514,12 +2517,6 @@ static int __cmd_inject(struct perf_inject *inject)
>  		inject->tool.finished_round	= host__finished_round;
>  		/* Keep track of which CPU a VCPU is runnng on */
>  		inject->tool.context_switch	= host__context_switch;
> -		/*
> -		 * Must order events to be able to obey finished round
> -		 * ordering.
> -		 */
> -		inject->tool.ordered_events	= true;
> -		inject->tool.ordering_requires_timestamps = true;
>  		/* Set up a separate session to process guest perf.data file */
>  		ret = guest_session__start(gs, name, session->data->force);
>  		if (ret) {
> @@ -2536,8 +2533,6 @@ static int __cmd_inject(struct perf_inject *inject)
>  		inject->tool.exit	= perf_event__repipe_exit;
>  		inject->tool.mmap	= perf_event__repipe_mmap;
>  		inject->tool.mmap2	= perf_event__repipe_mmap2;
> -		inject->tool.ordered_events = true;
> -		inject->tool.ordering_requires_timestamps = true;
>  	}
>  
>  	if (!inject->itrace_synth_opts.set)
> @@ -2816,6 +2811,10 @@ int cmd_inject(int argc, const char **argv)
>  	data.path = inject.input_name;
>  
>  	ordered_events = inject.jit_mode || inject.sched_stat ||
> +		inject.itrace_synth_opts.vm_time_correlation ||
> +		inject.itrace_synth_opts.set ||
> +		inject.guest_session.perf_data_file ||
> +		inject.convert_callchain ||
>  		inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
>  		inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY;
>  	perf_tool__init(&inject.tool, ordered_events);
> @@ -2862,6 +2861,21 @@ int cmd_inject(int argc, const char **argv)
>  	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
>  	inject.tool.dont_split_sample_group = true;
>  	inject.tool.merge_deferred_callchains = false;
> +	if (inject.jit_mode ||
> +	    inject.itrace_synth_opts.vm_time_correlation ||
> +	    inject.itrace_synth_opts.set ||
> +	    inject.guest_session.perf_data_file ||
> +	    inject.convert_callchain ||
> +	    inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
> +	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
> +		/*
> +		 * to make sure the mmap records are ordered correctly
> +		 * and so that the correct especially due to jitted code
> +		 * mmaps. We cannot generate the buildid hit list and
> +		 * inject the jit mmaps at the same time for now.
> +		 */
> +		inject.tool.ordering_requires_timestamps = true;
> +	}
>  	if (inject.aslr) {
>  		tool = aslr_tool__new(&inject.tool);
>  		if (!tool) {
> @@ -2932,16 +2946,6 @@ int cmd_inject(int argc, const char **argv)
>  		}
>  	}
>  
> -	if (inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
> -	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
> -		/*
> -		 * to make sure the mmap records are ordered correctly
> -		 * and so that the correct especially due to jitted code
> -		 * mmaps. We cannot generate the buildid hit list and
> -		 * inject the jit mmaps at the same time for now.
> -		 */
> -		inject.tool.ordering_requires_timestamps = true;
> -	}
>  	if (inject.build_id_style != BID_RWS__NONE && known_build_ids != NULL) {
>  		inject.known_build_ids =
>  			perf_inject__parse_known_build_ids(known_build_ids);
> @@ -2978,7 +2982,6 @@ int cmd_inject(int argc, const char **argv)
>  	if (inject.jit_mode) {
>  		inject.tool.mmap2	   = perf_event__repipe_mmap2;
>  		inject.tool.mmap	   = perf_event__repipe_mmap;
> -		inject.tool.ordering_requires_timestamps = true;
>  		/*
>  		 * JIT MMAP injection injects all MMAP events in one go, so it
>  		 * does not obey finished_round semantics.
> -- 
> 2.56.0.307.g5fe7bd680c-goog
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
