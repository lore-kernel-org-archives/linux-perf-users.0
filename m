Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021104.outbound.protection.outlook.com [52.101.100.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27563EA960;
	Wed, 30 Sep 2026 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796788; cv=fail; b=PhslT3kYRX7Ah63oPp5in/auTE8em/iwJ0Xux7Yp3fJhBDqyKKzHV/b+pN64mbLZcFxK0vxK7DehJuuis0iMUoZo/FHuZQOqel1ipJg+7W+ZIxENgI6Wtk630iTFH5ATGiuDxAnU3c8dpQY0kWCI62YWX+HqPGyX81zgIogwrMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796788; c=relaxed/simple;
	bh=XBrWA7wRvi3fX7hn4/xOEE5RBuwjruEg3EqmJKxpiyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qURE/5mjfahgicLk2rm3ss+KxBpxM+nqd0lyxmBWv/9ZtM53fwL9/axoVDemI2pzB2baSnoFuBEn3YjOSYg7saeQm67oV5IxYdg4Q2J5sG8CFl+W/279TKtIegCEXa51zqVmLspkJRagzqeKr1SAovbZmSMxTiatz/0BGaRbLm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4Nxft3IYiRp9J5OFB/+XjsHRq8BJlPPviSXM0vbPWAtnlst1CBplsdfojlrGXT2bs9hhAKYIwaaIwuxk5HMrsxY35yOu/Ug0D4zPqL6oEk+ZPH54jOoSEDlKKF09aYSIqbfpvu71eRNb6/a+iwDfWNoPyJLswz0soIMYv3pIuEyljF6LFKyPE+ayQWdr9AbmOBo1b242GCj30Ksvb1kPaRwL0vqieErrM8yUOfTbTq2U6DdPBDnXhTmD26kEGU26QJiCFVigGu5uk5Rh7G7t2EyocFD5MvPsR3TxR8kT79+xGLxiW5yJrzEaWpiZ7yiNvPu17l60nGkEONL8vFs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=9ynZ6GCU/0cR5QpAI7ymqbO2rHpmrYmFAy0I6Ac3OzI=;
 b=Y+o38N4eq72SKnhl3zmPLn1Xmy8wyMiHaOcupgUYb696OJz0j5zwjbwDQhID1GR6+foQhnI39uWGYmihda6CZOVDHY/IcWEkmSQKV/f0qZk9Xan1FDnB1DQbWU9Xn8Yh1LfKgzbIqnwh4UqDUXzip+PVhFN8RkhFJ2/heBd+glr/9AXef/vOrgXUDUtXgty9hVNagW0avsrnHLVWv0yPZ2WOfYf5hfGCpK6CIxEpbg6YVGrVi6kKYdRtR19P83Be3wKF1lWdXL4fb/XztEA7Jc06sCMg3rpZPVmT4Pwrqn8nI+i+h6mi6zEWkWLWFKxRf9C2Sw4+qbYYU1O0ib/95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB8947.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 19:33:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 19:33:01 +0000
Date: Wed, 30 Sep 2026 15:32:56 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Jakub Brnak <jbrnak@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/26] perf trace: Start BPF summary before starting
 workload
Message-ID: <5tfnnamct47trutdcpsa53vb3pirms76fliyzfzcbhntbzfnjk@bwwazrwwbo5f>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-8-irogers@google.com>
X-ClientProxiedBy: CH5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::6) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 5298493b-06ba-4099-26ff-08df1f29a3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IfQju06hGfd8AP4U8c0dWH5n8t7p8BD7hF1QS9nKKql/vrGsl1nyr3CeIATuhtBB/PeAO6lXTij/Ceo8cLOgSKQD7wH7QybBgMSYP2aa0ojT9xoRrm2KFopGZ6r4iz5G9N97bgEvVPaXnu+w+wGTLyZstk3BYeHUUH3bMA5XQmyXICmJ4+LQcQj+kFmO1b6/k9aIF/lBhikHoQiaruDAIp0X4pks2pFqWuCH7AuhAz6muWI9228Rt6tpN4MzCtbqORHemEppTrng4zhDjcg6ABSwZttccTajt+Hx7rkc8UTJxZ+th5dRTFaElA6XsnInAonWZlcuFuu9qYX2+eSyfxcBB7FhrCbHchNgPjfn32I8a90zjz/d7Ip8iIGlYfIkOcDRwWl2WGzCv9B/WJGTFlCmpqupATJcb7IJ+D/MdScdlfvGyHSdpd2CWUVRRBIkJhF46XE0shbQzdW6Le8bbNWBrBMGyIvzdncBCD1+vdxQxRM/jhO91H8gppAXaMHM680Tl4ZECaBu8hXUM09RRKZvjUCw1J7ll4Fl5QxiDNkm7VqAptjCExxo25T2Z4yankZhQKKjsr1KJJ2WBHQEA4UFuMj2OQr+7pldMgXknkVIUGq/JT0rDVB+PsysYaqrqJDCLT2E9fgoNAAJ2wy2CdDEfOYYynQefmjFL1ItPtQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TENod2VYcnFnREQzOFl4MTB1RWFDSDByYTY5T1lmbWJUaFBRWWlwR01FdTY4?=
 =?utf-8?B?QWZQYWF1SFFGaTJtQldtemR6Z0FQYkhSaUNsMDBGTVZPN1ZFT0kweVRHcDBp?=
 =?utf-8?B?VFJKQlRYL0NxWlY0K3FRdWtSVGhEbzNZdUVSaHpSWExyUm45UzZuQXF5eDNp?=
 =?utf-8?B?VkhzZlRXUmpQTk5YL24xcXBjWVAzOGxsZnU2ekdEZW9MVTI4Rk1ST1I0Mm1v?=
 =?utf-8?B?Sk9Jb0ZYTzU3UXVSeHhtRS9RamJuaFkyVkFJM1NZSlU2N000WFN0cGVGdnR2?=
 =?utf-8?B?RjZGdUVWZU1KWHRQMldXSmllWmJOY1hEc082RFZYUkdTSGVuTThKK2lvVlIy?=
 =?utf-8?B?cC9oYWIrZnVqMFFwcWx1ZHlDZkEvcUtTNm1zV0dLOGl0OG5PSlluYTBzYnll?=
 =?utf-8?B?SXQ2SHIyQkJxbjlabmg4ZWt6WDBhYWNzNVpQS0x0Ykp6VWkrTmpnb09RQUlS?=
 =?utf-8?B?eFpuWVV0RWQ4MEtzdkMyOUxUdVBwaEJrR0c2UW1DelZZbThNRThnSUNFOWNO?=
 =?utf-8?B?VU8wQlNsN3dUTkoxcHJucHgvL3RYYldWaHZxZGNOc2RyRldyZGkvVHBWWldE?=
 =?utf-8?B?QWI2S2JnSEUyWTRJRXVhMTM1NkJpbHkyRm9qNmpIbUxDdk9Sa0VLck56elM0?=
 =?utf-8?B?UVBMMHN1dHM4RWUrTFNzQ3JOSTNxUTY4MGdKZ3pwNnQrQ0FET3psY3ArVjhR?=
 =?utf-8?B?OGc4dVJVUXNrcFVwdTNvZU5RSjVuOS9kSEd2RjlhaGhhNSsvZWV6a1dBbzRC?=
 =?utf-8?B?b2gzWHVrSUxrdmZIeDhBZVpqNS9PblpTR1l3cHBRMERzdGwwSUZyb1ZvSHJQ?=
 =?utf-8?B?R1l6OWM4R3cyYUpHRjl1QlgrYTZXaXl3MUcrMXBaODVvdkdCR01KS3FrTndi?=
 =?utf-8?B?ZkxBTmRGV2psVmowUGJWem5wdGhmSkh3OVRaMWVnQmh6clltSDB0K1dFZHlz?=
 =?utf-8?B?aGpneFk3OWU1cHNybmZwOTJjbWdxRFg5YVZCYVVGejh6UVlFbGxBRVFicnBl?=
 =?utf-8?B?dHBaTVBuVW92M0tkT3Z3bFhxdk1UdjhRTEl5Vk1hUzlBUFlNZTVYKzNpTE1z?=
 =?utf-8?B?QmRZRHgrUHlZRE51eXBKNXYxOCtLclFvY0tIMGFHbEpjSmtIaTY4Y1RnY1pQ?=
 =?utf-8?B?NURhYThobmdWMk4rUVl6ckloSDJRU3ZkWFI5RkErSWFwZ0NPWnY0KzJCVGFQ?=
 =?utf-8?B?VEg5N3V1Tnk3d1RyQlRaQlhaUy9CbXJDSHNuL1hIbFFKd0pFeFBFTy9tNkw2?=
 =?utf-8?B?R1huVjlDOGRnS29VaFlTN1lqL2RXU0hSMW1iTUhyNzJXRG95UkZFS3MzY05I?=
 =?utf-8?B?bjRrY0EvaTVDSkVieEpDUUZWT05CZXplK29sYURPRW5sUDE0TzY1d2RIbjBJ?=
 =?utf-8?B?QlRCLzdIdUI3SDFYK2s5WkRzYnEyYnljWXZmb3dheDlMRXF3SklYTkxIczFo?=
 =?utf-8?B?bDFrdGhmQ1k2elVyRllNQWNaVi9od0psbkxpOVVETFdVVmxqNVdlZnhzRm1C?=
 =?utf-8?B?RnA3STNhc3BVMnl3RCtPKzYzZ3VvVGhsSnF5UzQ1Y1JHNkY5M3lpU0NOUE8z?=
 =?utf-8?B?azlDYzZQNWlDMEd6ZENLY1MrMjFKcjloN0lBYnJ1RjNCbFBIZFZ1clY2NW9y?=
 =?utf-8?B?b2ZtenRIZXZETGViTit1UitaR0hvTkNoNGE1REVIT2VFL1U2dFE0MDZISFQy?=
 =?utf-8?B?cGZqdE1RdmpldUJTd1Yra2k4bWpVRHFqR3Z0c2ttdWdPTWs2ZGNkd0FYYjVh?=
 =?utf-8?B?Z1VvdmlQdGQvSVJUbnlRckdmWkw5N3lmWEFyekppOHpZTUlIQ0x4clFRT0JP?=
 =?utf-8?B?OE1HSk01d0hWVTVVWTN1Zm5kTDFQK2tuY3l1TEpCV3hHcGYvbUZzY2NSS215?=
 =?utf-8?B?dTYwRWI5VkhNMk4rbHQ5S2FFT0owYmZkN1BBQzhmOW45YXhLelRLdUZzaTdo?=
 =?utf-8?B?dFZFSnpYMnV3aTIrTEtWR0lHUTJLeWlNeTRzbU05NGtvcEZ3WnM3OUtsY1lS?=
 =?utf-8?B?WmVIT2ZGZVNiTWdwelZlWkRaaVNZTGZSRDU5c29kVmpQUTd1SHBmMjEzRklz?=
 =?utf-8?B?bFdmYVFBMnYzeWJ5WWdvdGVxTzlEZGlqS2dtd1JkWlE0ajZIMTd2M2kyUGNF?=
 =?utf-8?B?MHpWekcrMzBzbm42TnhnWGdYQnJCVEoycDB0NHNFZitsVjc3WmZaT2pnWEJi?=
 =?utf-8?B?UXdEVytIZG5kK0dWeGNhZ3NqMUVBMFVObCtCQ0RQMldyYmhwcGRJckVWWHFM?=
 =?utf-8?B?TXUyK2d6Ti95emVCQm9xak9VeXNiRUdpYWhmbC9ZZ1VmZHRMb1FjQngwQ3ZE?=
 =?utf-8?B?ckxsYXRPNzQzVHUvWlU5VkhQZGdXaW4yTHZVZkF6SUtWNHhqSzVCUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5298493b-06ba-4099-26ff-08df1f29a3aa
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:33:01.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMhyfS+i89zMP2BsHl5LpbTZ5jI9QhbrGiVnXF26k3+dmBRscVJlvE6ZhWnk/84phiwI+FczdLP/CGI45nO2Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB8947

On Mon, Sep 28, 2026 at 11:25:46AM -0700, Ian Rogers wrote:
> trace_start_bpf_summary() is called after evlist__start_workload(), so a
> short lived workload can make its syscalls, or even exit, before the BPF
> summary is enabled. It also ignores --delay. Enable it along with the
> evlist, before the workload starts or after the initial delay.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f94745a60f4a..1ffe824ba670 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4855,17 +4855,19 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	if (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay)
>  		evlist__enable(evlist);
>  
> +	if (trace->summary_bpf && !trace->opts.target.initial_delay)
> +		trace_start_bpf_summary();
> +
>  	if (forks)
>  		evlist__start_workload(evlist);
>  
>  	if (trace->opts.target.initial_delay) {
>  		usleep(trace->opts.target.initial_delay * 1000);
>  		evlist__enable(evlist);
> +		if (trace->summary_bpf)
> +			trace_start_bpf_summary();
>  	}
>  
> -	if (trace->summary_bpf)
> -		trace_start_bpf_summary();
> -
>  	trace->multiple_threads = perf_thread_map__pid(evlist__core(evlist)->threads, 0) == -1 ||
>  		perf_thread_map__nr(evlist__core(evlist)->threads) > 1 ||
>  		evlist__first(evlist)->core.attr.inherit;
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
