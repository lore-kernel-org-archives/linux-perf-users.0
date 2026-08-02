Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021118.outbound.protection.outlook.com [52.101.100.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7425B0AE
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785701889; cv=fail; b=WKoki4hKAIpMTCKbgdDnIAYx0OsMx/Os9hvrhGs+c7WAmKkbBK221emSB5Bvp6vROoQCVW16n3Dr1gwRydEIXA6IgQhkaGc7aNfikhJSf6FlpiXvqlZQkPBgliK68TqoGXtif5A8tiV3ROy5rTGR+xnHXINPNfqdwuJSqPpZZVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785701889; c=relaxed/simple;
	bh=aTt2pym8qCVVRqRs6KdZjwaHPGbAc81JAeCZO38WNVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qGqiBmsQQfSEd1qXPVu7R+t8hK+DpZsF9eHOQl0RgOh8li6G+ZqT6wdjTyOteobtIbZ1l/or4ifR/i+cwoS1OKjm5wmyJtO3K3vA5Ftr73IzBMU0FpuUhJKmcwlj9t2dga09O9+PHXczTJ3lc99HfGSC4J3Z9kU+Jg4WnYMpJBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmxfgaMrmBNUoRotns+NzxgrUfI4meoLKf2MRbYODKm6m2CZ0CA8SQt+qxehStpOSy4fS/VbSV6XtKKvZ75mM5IxvbTw+xNKfXIzXwLbtgX7vYGaDfVC8tKa+liivktnhwZ188zkvyFna/bkiqv42Y0W/48Bt2z/XmMnn2MxOACUUiGzh6lYm1Aoi/ku8r+jLXYc3ffSqNwaWAjRMtvOTphR+yCpkkiyz50JzYyp2YJy7S2ythHcyfoJ1+1JuctEmOXy3DflG1JAJmA35lZpC70unMEMZpAHKU7BMSs5nkuK3jsBL1vnP+EjsiXnoSVAevibukmeTC3L2ysI2rRS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=3qOK34rBk8ol2sjcyTNDWR/yRu3edcAo/gqA6VrPWp4=;
 b=AWNhgHU3UcxHpGHqSRffuLSQ7aAeoiVlW0Z7y4FHJaafRACEK+cy47Wy6N4uuQxXpIBQ6TgvsAM03AjQKF45y6Vu/aVhMjjc0jqDCmAAOo1vn/j5K3bhTApCkPdDXTDz1yiP+lLz9EKnE0t4eeqigR+MBhtLdo1ebI9tKY+FJxRB5BwI1iV9qsx31MUiKP/IN+wnag02zsYioL7O6GY7EWmgqydU4Ap04ouIcDrWzEbPCd551lkXpHDH1vxzAFDEh/JvXCkcQzhzO8HMJCtKUvLKUzZ1gtnsXJb4yf8ZJl//F1XhPLlqV/wfP8PrePdMHa5U4ZIuFcAN332Jbp6XxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 20:18:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 20:18:03 +0000
Date: Sun, 2 Aug 2026 16:17:59 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: namhyung@kernel.org, acme@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 2/4] perf sched: Handle missing trace samples in pipe
 mode
Message-ID: <p6d7han43ahvb2f2qwzxqva3ubf4tcj463oirh6wdowbs4qpfq@vczv7tuuc7vg>
References: <20260801234008.176724-1-atomlin@atomlin.com>
 <20260801234008.176724-3-atomlin@atomlin.com>
 <20260802000140.90AE91F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260802000140.90AE91F00AC4@smtp.kernel.org>
X-ClientProxiedBy: BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3008:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a9cc2d-e9bb-40fb-7c63-08def0d327dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|6133799003|5023799004|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	aAtgf9WkaSzOcqeH06k5EgqNJwImvS3yjv7UUiNC5YC+u3rRNsI+SPwIp0nBPBdg+H7+ZXclD46zRMi17B/KJVVRdVGmA7KHTS+UmRWlfR4frbI9dL3J5ENaWSgxnV24/vbTPcRNxcS/l7r/V8GUtlzw/5jiaRExurXqtafhWe5t4r8do97To6HN5PbEcpfDAHuQhkXgICoQ/dnR0qGbKjDqBCt/DNi8iPckGc04k+ZTAVfeiRK0Hqgc5THow6Msgez3fNGYWTgENy+lII78DWo+BCtPmqvyB9JMQbituWcvqoyCHtMKqv475/ngzgoFaVKfC81tv0/g8gtN/lI+PsXTonCHsAyd3ndFFsCWAJ5PwaOjOinIEbOE5UJo/LoTuhHqjfhNutjP7azUC5/bRPAU6HARJF3wnkwUqtGeKH82cvcyHYN21Yn1J5VEYtRGDuRpAEKFdYm3fUBqUvPd352ix4FGFMMXHjN8CGENFgn7BrTPnAsYFWjBnHqTytM9QpnmT1ISvkTO00U+Qtu/TdFYvBrdVUauIEwbFw+Cs+XnxD4q6HhBPgkE82Hx9FFSSvrHKycrZZGdYZeBitrjppR0aUhphovBCRQaY/Ckskk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(5023799004)(10067099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3ZkUzBDTFl3WFhzY2hLcEFhbkxQV3ZlUmxIN0VQeGUzUkoxNUZSOGdRdFdH?=
 =?utf-8?B?Qk4xR0ZJZmJJelNMd283S2h2a2FjeThZZWRHdlVtY2cwcE1aQzRXcCtYaEtH?=
 =?utf-8?B?M0hNOEhvV3RYSzl4T2d4WHBqWG05aXp2dlpUZnpJNlVXSmtlZnFpRmI5a1Fz?=
 =?utf-8?B?OVZJNjhSSEpGN294ck1QQk1CQU1CMG1kSVhIdnd4d2ZoY1NzT2dHVTI1cU0r?=
 =?utf-8?B?VEdQY0MvWmhlbUhDYklsNUQvS1NpUEYrUmFXb28xN25wWGNNaEtsUVQ1aFo5?=
 =?utf-8?B?QWJUT3QyQ1dHNzB3RGRYZGhLa1hQSlRJMWVldi82TWJ1SGdXSzhzN24rUFRD?=
 =?utf-8?B?YVorWlhscDM4MkZOdmdnOXozTVhmd1BhL0RNR2JOUHFhMUd4WHRDSmpYM0xO?=
 =?utf-8?B?eGRnSWQrWWx4bmxudkZ2SlRacUhNcUFTaCtqUFFSSk9wcnRWOWl1RHNxaWhl?=
 =?utf-8?B?RGpGa1BqTVpvYnpLdzFiU0Mzb2Y3cWxrQ09XaVRLbnc0Qk0zOFMxVzhSOWdo?=
 =?utf-8?B?WFMzanFodXcweFMvbW1NdHhWdnFDMFFnRFdSa3VvVkJ0ay9HdXJCSXBGbXMr?=
 =?utf-8?B?QUFENWxic0cxSUZVbEhRSW5tT1B6QWd4eFM5K0xvZHFRNG5ZWnZFNWVRUUVn?=
 =?utf-8?B?a0dvQ2RmUitybk1uOFdDS1FpTFBlM2xoQ2tXMk9QRk1JMk1wQUl2KzFWN2d0?=
 =?utf-8?B?NVIrdU1yYXRXWkRTWDRlMk5PNkN0N1Zrei9ic0FzNk5tMFhtanpTamRFa3Vr?=
 =?utf-8?B?WXh0Q29iclBJOUlva1dTMVRYR2lGckhPWHlmNDQvaVROVks2RU4xek9ETTV5?=
 =?utf-8?B?cGZ2TmF5Y05hWXV6MlpKaHlGWjdNREl2Z0FPUmZRazV2R1d6YXNYdHNKcUZN?=
 =?utf-8?B?dXc5YkpQK3haM3NscHNCMzJlSDNhVTVyWFFGRDNObjdrclZZRmNJRi9PTjNi?=
 =?utf-8?B?SXVaVjMzS3lDWXpTaVZhbm95a1pLYWZwam5ycEFNRFFrdWlwUXJybUNLTEJh?=
 =?utf-8?B?ajZ6RStieWg1QzFKaTB3WnRUWlJhUzdIY0kyTGlNYitYa2xJZnJuVWx2R3Bs?=
 =?utf-8?B?NEJlTGM4QnNpVklXd2U2U3Uxam5QOGpBL0t3S3YrUFhUSHFyVXpuUDI5Qjdr?=
 =?utf-8?B?eWJYWCtKdWdjQno4MWFhNGZOQmkxV2w2dEZIS2taL093N3FzclIrQTRJZ1Zp?=
 =?utf-8?B?NlE1TEtXY1d6NkFleURaYnBDYVdiWjUzdG4xWXdNdENid2tkaU1uekV6c1BP?=
 =?utf-8?B?SW5zdEw4cVFka1YrV3BmbzlhMUFGV3NIZGJZRWVuRyt0dlFPQSt6V2ZiaURS?=
 =?utf-8?B?WmUzMnJKc1RRUVNzTHRwUzRHUmZZTERmSzRjMWNJVHlOdkg1aTgzSkxlM09s?=
 =?utf-8?B?d093V3MvNUZYR2g5MGd2YmhPdDJVeXBSK2R0VERsZEJ2TExldHV4QUp5dnhk?=
 =?utf-8?B?OVUxVjdwdXh4c2tMb3VVdno0NTNEdVVZVUxyMDVHNlVGNysvTzY4MFE2Y1BQ?=
 =?utf-8?B?L0I3WXJwVDlOOXExQXU4M1J2VytzQzVWVjhpN0dESXMrZTVFazRHTDd0MGx0?=
 =?utf-8?B?d2ZtMjFNMzFBUi83VFNRaWc2RmYvZ2U0U1RLMVo2cXc3NzNLNVJ4UGNIdytW?=
 =?utf-8?B?dDRlOXBVT2JFazVCVERKWFF0T1E0Qlh3LzlwY3pOSjhSQ1V0ZDhSNGsxUDk1?=
 =?utf-8?B?RGJnczVHRHR4ckR6VEQvYUhRZkNXQ3BQemFlQ2hHVDZ1QlBzME9WOGNqMHFL?=
 =?utf-8?B?OEF3TTZpK0hORDRab1hjbkxFOFJHcHVJaTUwTkJyek5uRUZqTUFnSkVPOW5C?=
 =?utf-8?B?TFp5WVA2UWZPM1pQN1RneFYxY2pSdDBLMjRGeFFYQnB0SlBqSGVpRkZmdzVD?=
 =?utf-8?B?S1B2TGltdDdQM2JBdE01NkpYcXVwTW5ObFE3OXZQbytqZjhRbUJtVHlYWGhB?=
 =?utf-8?B?b2c3RSs0NjZkaUhYdzBqbnVvRVlxZE5zRUdoM25pYkRIRW1VcG9DOXdOcCt5?=
 =?utf-8?B?MmpOVDJyckFTSUMrQ2hLc1VxVm1IczhEMTFTdkdxSEVGWjFUZzVvMkNlTEpF?=
 =?utf-8?B?S1U3MmlKTEppQkE1dU9TbDBVTncvT3Fja1BEZWJ5V3FteDZuY3FjSGJ6LzRI?=
 =?utf-8?B?ekY5Y3BEM1IxVTRyUVdiOEh3ZDdVaUR5NUdkMkczU3BzNDNxa3pseDBjQzJP?=
 =?utf-8?B?S1JnOGR5V3RZN3llQitSYUVEUVhyc2d4VkZMQmRBL3VNKytvK2F0T3JHYk5O?=
 =?utf-8?B?Rkc2RUZZdkVFc1lZZkZjdzB6ZWdvRW9iekE1NEtCQWVVRlZFSnI3MG90cktn?=
 =?utf-8?B?VjV1dXA5TjBJcGZpREhhYXZLQU85UTQ1WnMrVlZKYldPNGxSL3piUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a9cc2d-e9bb-40fb-7c63-08def0d327dd
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 20:18:03.4649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYXMHOJrUzzGEINYpUilYN5D16o5UZUcedLG9yQ3iTz7Dwa8GbGtIDMRMyh9BeXpf9KzYysCXt+6S+gnNEi4CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3008

On Sun, Aug 02, 2026 at 12:01:40AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Using `evsel->handler == NULL` to conditionally initialize handlers inside the sample processing hot path causes repeated O(N) evlist iterations for unhandled events and drops late-arriving tracepoints.
> 
> Pre-existing issues:
> - [High] `symbol__init` accesses the `perf_env` before it is populated by pipe feature events, leading to incorrect host-fallback initialization for cross-platform traces.
> - [High] `perf sched timehist` remains completely broken for pipe mode streams.
> --
> 
> --- Patch [2]: [PATCH v6 2/4] perf sched: Handle missing trace samples in pipe mode ---
> commit bdcbf92a5b81c957ee21cce440488c2da3569c14
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf sched: Handle missing trace samples in pipe mode
> 
> For pipe mode streams, event attributes are received dynamically during
> event processing, meaning session->evlist is not populated prior to
> perf_session__process_events(). To handle pipe input correctly:
>   - Register the missing .attr, .tracing_data, .build_id, and .feature
>     callbacks in cmd_sched()
>   - Promote the handlers array to file-scope (latency_handlers[]) and
>     invoke evlist__set_tracepoints_handlers() dynamically inside
>     perf_sched__process_tracepoint_sample() when evsel->handler is NULL
>   - Perform the trace check post-processing when handling pipe data
> 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 94a323da0799a..0abf9f1f3c2e2 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> [ ... ]
> > @@ -1946,6 +1955,14 @@ static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __
> >  	struct evsel *evsel = sample->evsel;
> >  	int err = 0;
> >  
> > +	if (evsel->handler == NULL && sample->evsel->evlist) {
> > +		/* prefer sched_waking if it is captured */
> > +		if (evlist__find_tracepoint_by_name(sample->evsel->evlist, "sched:sched_waking"))
> > +			latency_handlers[2].handler = process_sched_wakeup_ignore;
> > +
> > +		evlist__set_tracepoints_handlers(sample->evsel->evlist, latency_handlers);
> > +	}
> > +
> 
> [Severity: High]
> Does this cause an O(N) traversal on every sample for unhandled events?
> 
> If a tracepoint is explicitly recorded but not in latency_handlers (such as
> sched:sched_process_fork), evsel->handler will remain NULL. For every sample
> of these unhandled events, this condition evaluates to true.
> 
> This repeatedly triggers evlist__find_tracepoint_by_name() and a call to
> evlist__set_tracepoints_handlers(), which immediately aborts with -EEXIST.
> 
> Could this drop late-arriving tracepoints and cause a significant performance
> regression on the event processing hot path?
> 
> >  	if (evsel->handler != NULL) {
> >  		tracepoint_handler f = evsel->handler;
> >  		err = f(tool, sample, machine);
> [ ... ]
> > @@ -2011,14 +2020,17 @@ static int perf_sched__read_events(struct perf_sched *sched)
> >  
> >  	symbol__init(perf_session__env(session));
> 

Hi Namhyung, Arnaldo, Ian,

This is a valid identified problem.

Because unhandled tracepoints (e.g. sched:sched_process_fork) are not in
latency_handlers[], evsel->handler remained NULL. This caused every
subsequent sample of an unhandled event to re-trigger the O(N) evlist
search and evlist__set_tracepoints_handlers() call on the sample processing
hot path.

Furthermore, __evlist__set_tracepoints_handlers() aborts immediately with
-EEXIST as soon as it encounters a non-NULL handler (e.g.,
sched:sched_switch), which prevented handlers for late-arriving tracepoints
in pipe mode from being registered and caused their samples to be dropped.

To fix this, I have updated perf_sched__process_tracepoint_sample() to
perform a single-pass, per-evsel lazy handler lookup and assign a dummy
sentinel handler (process_sched_ignore) for unhandled events.

This guarantees that evsel->handler is non-NULL after its first sample,
eliminating the hot-path O(N) traversal, bypassing -EEXIST aborts, and
ensuring late-arriving tracepoints in pipe mode are correctly bound.

> [Severity: High]
> This is a pre-existing issue, but does this early symbol__init() call break
> cross-platform pipe mode?
> 
> In pipe mode, perf_env is populated during event processing. Calling
> symbol__init() here accesses an uninitialized env->arch.
> 
> This causes perf_env__os_release() to fall back to the host's uname(),
> permanently poisoning env->os_release and vmlinux_path__init() with host
> paths.
> 
> > -	/* prefer sched_waking if it is captured */
> > -	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
> > -		handlers[2].handler = process_sched_wakeup_ignore;
> [ ... ]
> 
> I also noticed a related pre-existing issue in perf_sched__timehist()
> where timehist remains broken for pipe mode streams:
> 
> tools/perf/builtin-sched.c:perf_sched__timehist() {
> [ ... ]
> 	/* setup per-evsel handlers */
> 	if (perf_session__set_tracepoints_handlers(session, handlers))
> 		goto out;
> 
> 	/* sched_switch event at a minimum needs to exist */
> 	if (!evlist__find_tracepoint_by_name(session->evlist, "sched:sched_switch")) {
> 		pr_err("No sched_switch events found. Have you run 'perf sched record'?\n");
> 		goto out;
> 	}
> [ ... ]
> }
> 
> [Severity: High]
> This is a pre-existing issue, but does this strict check break the
> perf sched timehist subcommand for pipe streams?
> 
> Since the evlist is unpopulated before processing pipe events,
> evlist__find_tracepoint_by_name() fails immediately, causing the timehist
> command to abort.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260801234008.176724-1-atomlin@atomlin.com?part=2

The above are valid too.

However, I will address all of the above in a separate series.


Kind regards,
-- 
Aaron Tomlin
