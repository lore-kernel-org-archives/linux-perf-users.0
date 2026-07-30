Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022128.outbound.protection.outlook.com [52.101.96.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF3025A645
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382348; cv=fail; b=TMDFEbBG9raY8SJwXCxczMlVBOw04NTBFryAhqM+Ci+cPalNfMF/9sndU/yv4LuC6g3AZb0XEYNFC/Wv7MYnLMDVK+xIJHshxEtsOmsxC0FtkQtZpkLctYrTuyXJN0SVHlhv7RzSk7e9Xw4baPfatoNxtslxxWzdckHFybwHluQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382348; c=relaxed/simple;
	bh=yKe21iZxpug2dW66rOvitXZCR7stGsVUJRAEuWuUKdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MAvTbCXIxf39ddkh7sFiECWws4+nBrdptM0y6AH6FNt/YudBOVyPDvOesjh+R5dGTkgRUJZGSefo+DOriA17sWcwqQqAuCBrmCOLXAmSf26ayliXCS3RL+CToYbv9m4GjV2pgR02SYtQhuYIHIQFlxNy5EvEaZ1s7bozrR/4uuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXGxLpR5EH3ZZr11vbigxJBCw9H4ZsgYUjApLHkLreD1NDoo/iIE1/0riMWYBA6Axq86upyPxqQZpaW4iwaGcZdAgDyUmk1pftkcbOIJsjoTdZ0zy/Om2+/ZD6AIRMiBpMggFUJPclCKPGlXMZGhe6NSeZ/pIju6FmIyysSeox8bZI+wVSc4GpmxwQb0xpmLPQZFQVQ6RmE4HZ9KREKrR/C55U+/84YATG6S3GVq6j7St9wgRnNTtr5o56g/KNbIy2mWz9JVHWt1lQbno16nZBKh4CmysFPPUFU/00n1oFKrTqflxOR7psriPFIoOYl5s+RCqA7DZPQLEI/hdQv5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=GBhQrtFawBQYAWk4yzgTQF88aiZJGl4q5pijlui6lA8=;
 b=FOvAEXtMJGq7ux3wmcA/dnHqGCTVb7VHQUFyo5u91WMPCmBzAvJZjzcBxa2nNwHXSpFsjPXA+ZkuYWtjSFs8uRW07zA3LwbCPKwVKmzM60fPqBZpC3g86cqyDoTxJGn28vXk64dcU6w8zTxBpDr+bWZ4Nz1s7k8mBBos88SDD7QY9mMk1GFZtY2es4I/9k0IxnKb/zLlns5S9PlXJbchR8be4tQswS6bMm7pVlmXE4jaAc490kkfP9NHJCOGyQRmfmGmQGkc89IvOZV/8bPLPaxgpppTPU4MkjhHiD8htSpQCjNLTcGHFsaONZXtxOehbCQ79WaoMc4VUzZpbgFhiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b2::11)
 by CWLP123MB3122.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 03:32:22 +0000
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383]) by LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 03:32:21 +0000
Date: Wed, 29 Jul 2026 23:32:13 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 1/3] perf sched: Suppress latency table output when
 trace samples are missing
Message-ID: <ekl6ozvbjfhocpqhmxghvtcv5piyqg6sstfvy73s4fn5logxxx@7yikyncrucq3>
References: <20260729144451.38286-1-atomlin@atomlin.com>
 <20260729144451.38286-2-atomlin@atomlin.com>
 <20260729150039.4C1941F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729150039.4C1941F000E9@smtp.kernel.org>
X-ClientProxiedBy: BN0PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:408:e9::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6616:EE_|CWLP123MB3122:EE_
X-MS-Office365-Filtering-Correlation-Id: a903b75f-f6ea-425c-a2cd-08deedeb27d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	EixY3kDSL6LEZfp10iWZDvK2mIprfRllGUWSOQ7sUwh58d7e8944s0oRFauRll5pDqI4v435Nz2aQHNgv05lvgtg8aNhrar5Pxz3qUr6jA3zgd+yCM0GRO34wBnDNjigAGfc/ETLIpNvPHZs5rQFkf0hwsIVLJIVQC3OVwHqav/Zjui8knYjPVd9QtWwCb/8DNEd5NUKG17GmIcjDmvKpnvzpIfzbiyZtlwEV7219dB5zo8ewwzSxph9eYHbTd1NYPnbpAu/1fLuqBY27BW9eMU5huGBMLLHGOxfWS1D1L5QaZoZKIyfMaWdRhJ9hPHOOUUXSXvvwamArqEFWPkqt77j6SPWaB8QU96tUOJUIgW4tRnl4od+LWxRV1mrr41cwbFvnFO4mrU2KJH2fM7LRgm8RlHRG6vxax+tEN0P5Zqc4Di8eH8ks9WfU77Rk+qJQwaJX2FMGW3xWR21327RY8sF+IDPP0YZIRu0b7YbtT03jboE82bo4fUgum7MUDAymjx41CNA3jc9jqZpD5uwA2RrjbtFKLfCUOVuAbTTeqKIylDh4w+r0LrkJpJ9jURw/nlHFDZnSj9ETL9RwYfeBORPMkvEwWyCXl1nXn39vAtz1R41Wn63IuyRN4OCMFn2SYhjc/F2L0KhSpoBuxUP4tV424JcOwm4nh/cpdF1y5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGtyN3UvY3IrK3N4eFJDTExHSGc1ZE9DcitUVDVKL1VNcDlxY3d0WU9DdXhr?=
 =?utf-8?B?em9aQ05QLzVuNzBReHF3R2VzcmJBU0R6M25VNkg5S1lRSndtRE1ZdzNTYzhs?=
 =?utf-8?B?SHppN2poOVU1MFUvcGNKZU5lUWFyOUdvbmh4dmJaWElyYlR6ZEl0NFVOTzNI?=
 =?utf-8?B?VmdFeGtJTWFEZEUwaTBRLzJzLzRHUlFyYU9Oc3R3TjBpUXBiS2hUdHFPK2xS?=
 =?utf-8?B?eWIzdGs3dUs4eU12cEplUU1Ob3AxZHkwS20vaG5RSTM5UGxoWEdnZU1keG9Y?=
 =?utf-8?B?V3ZydWxYZHdrbnpOOWM0T2dRdU9Ld0E5ZmZZdVhBaDBvL1djVnluMGlibGtV?=
 =?utf-8?B?bEdrb1U0U0RBVDgzaE83d29rVXhQL0VaUkIxUy9wSE9vK3pUSllhcjR5Titw?=
 =?utf-8?B?SEVwUkczdU5YYUV5MGtHbjZQUEdzTldYMFJ0WSt0Y3VxNHloRTY3UmRXVmZC?=
 =?utf-8?B?VDV5RDhadDY5RjVUTlo3Uk5IamtUZGZqRUdzYWpKOVlEMUFVQ1pQMTA3SHlm?=
 =?utf-8?B?eFNVazViVXA4RElzZVNjc3RLMzJHR0JQbWQ1ZDFuYzhEZHdDUFpoOEZJaW55?=
 =?utf-8?B?TXVhWkpSVG5jbWxyODhmK3o0MnZtdGNjNzZ6RGtMZEJkTEN5MDZLeVBIU1ps?=
 =?utf-8?B?VEsvWWpIMmNCY2I2MTAxV254UHVlVDUrN1dIcVZlUHdSYWJDR0xBbnBMVmRL?=
 =?utf-8?B?SnpibFJvTG45em9HNWxTdzM1MmhoaGliVmpFcGJaS1BwQ1BmZHFtNWFwL2RK?=
 =?utf-8?B?NGg3ODFnZkNoK0lXYzRjNHl6aVFsMHRpbkJQbXZ2eW4vd2xycTNnWEtpeTV5?=
 =?utf-8?B?b1dVS0toSWRQNE9yYlV4MkZ3ODJQVWNGdENHdnFuL3ZkMXhrallzSFVCNzZU?=
 =?utf-8?B?dGx2enJjMDFkbE9VWHE3cERuT0JnaFdGZWo5S2tGcnhWUWZlL0h5WXlsS25Z?=
 =?utf-8?B?MEM0OTg2bXlGeFJvbnl3UENCdWFPYVJBN2NsTjA5S2lGWmRtZ1ZoU3p5WUgx?=
 =?utf-8?B?SjQySjRSM2lGVkxzZEFVdGw1QUhna3NTSlkrdGt1KzdlbmF2SlJuYzhidG9G?=
 =?utf-8?B?MDlicU5TYXF3dHBnZlhXTGhLRWV5UGVzZlArQXVYYmEvQjlFZzVIallVK3ds?=
 =?utf-8?B?K1o1UmtBZWMvM2NYMUxUOW1ORUtGWTdPVDFMK1hSaUYvNE5RNDZZQzRnOEx0?=
 =?utf-8?B?dDR4YW1PdFFpa2xBWlRCME5KVUsyc2tFT1RpblVJQ3AyRWNmNjczN0RwdUpJ?=
 =?utf-8?B?cWVDRTBKWEZMUnFyM0VmRXNKMjN4SnlETzFhRVFiMUpKTUM0ckY5MTZ6Zkwx?=
 =?utf-8?B?ZXd3aHcydGdxYnR5RVVNL29YWlhISWNhRWZjZm80VjVMT205a1R1UUk3TDVI?=
 =?utf-8?B?dXA4dXBxUThMYzROdHJFVXZsSlFZYjYwQ1JNN2tHaFV4c0YrT0R2Y21wWFB2?=
 =?utf-8?B?NU0vbzBoTEtOOTVPZ3d1OVIveXVwRFVjdW5kZzN1SitpNEkyR1pGL1NmTHNx?=
 =?utf-8?B?OFBxbHB5ZE5QR2hkU3NaMG9BSkZtV090bytnWTcxcVlBdXI2U05CWm9yRy91?=
 =?utf-8?B?QlhPUFlESTI3K0ZJNTVKY3RTRDF4Q09ZZE0zdXpLWDF0eVNYUklBWC8yK1Vh?=
 =?utf-8?B?WDcycnZRenFjTTY0UVdwM3BIRTViclpTdEEzTEM2OXFqL2tuUUc0UE9sSTQy?=
 =?utf-8?B?SjBpT2JSTHo4SlRiNFBWRjFrUGIzYTBkM1ZkYnFsdFJ2UmhxWXEzYjcwUFpL?=
 =?utf-8?B?VG1UMWJwZmc5a3R2NXE5ZzZUQzg4aDZReGhGbW9naHJCNUNMUWdFYm93ZzJU?=
 =?utf-8?B?WS9FN2V1d3RzNURPOFZnaVptdVhnbUExbGdXcTFPMUI5cUZZQjNpQ1o4ZTJy?=
 =?utf-8?B?dkZJOVl2eUViUUxPcVZtRUtvTXdvV1AwdCszNWF2aU9Ka0hvSmNhTXVpeE9O?=
 =?utf-8?B?OWVjOU9rR0lKdXpxTHVlbXo0clkrZzVFK1VLYjhWbnZKaHRTU2x3VnE4cnRz?=
 =?utf-8?B?NTNMN3MyQ2xBc09NM3lFWk9iQ2E3VmwwTWlhbGVnbmlGKzJiK0pJYUl1eGhC?=
 =?utf-8?B?amwzcDVDTkIvejI0ZUZnY3hzb0dVcmtkNXF5dU0xeVBFalJGRUtDb0xNenox?=
 =?utf-8?B?a29GSXV3RkJMZloxblgrMkZuN1RISWJ5NG5EZURMdFVWSmIwVXlrSE9XbHBJ?=
 =?utf-8?B?V1hteWQ0d0ZSTzQ4WCtmNDVoc3VsYUZNV2lpdER5bi9KU0xISS93cEFhZEN1?=
 =?utf-8?B?dEttdXBWMUlWR3I3Z250MHVaR01sUEhhRmQyOHI2eWlXTTl4T3ZuR0RUSlli?=
 =?utf-8?B?VU1VRytjdWprczd5TnZ5cHNFdmQwc0VNVUt1UDh2NTNQdndpNTlGZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a903b75f-f6ea-425c-a2cd-08deedeb27d4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 03:32:21.4347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKh9XxoCXGDi+m9jOW5k5dFJwzP2SjXvhjZA6tHOKWpYsr9wGZzIQZKt+0IRgp/cyCaDdVZclYdUJ3u/LvDk9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3122

On Wed, Jul 29, 2026 at 03:00:38PM +0000, sashiko-bot@kernel.org wrote:
> --- Patch [1]: [PATCH v4 1/3] perf sched: Suppress latency table output when trace samples are missing ---
> commit e9be5c25be0368a795779cd7fdb10479f3b3c099
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf sched: Suppress latency table output when trace samples are missing
> 
> This commit updates perf_sched__read_events() to abort early and return an
> error when trace samples are missing. It also adds callbacks in cmd_sched()
> to support pipe mode streams and adds a null check in map_switch_event().
> 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 7fd63a9db4574..fabd99a18aad4 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> 
> [ ... ]
> 
> > @@ -2001,7 +2001,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
> >  		.mode  = PERF_DATA_MODE_READ,
> >  		.force = sched->force,
> >  	};
> > -	int rc = -1;
> > +	int rc = -1, err;
> >  
> >  	session = perf_session__new(&data, &sched->tool);
> >  	if (IS_ERR(session)) {
> > @@ -2018,18 +2018,25 @@ static int perf_sched__read_events(struct perf_sched *sched)
> >  	if (perf_session__set_tracepoints_handlers(session, handlers))
> >  		goto out_delete;
> 
> [Severity: Medium]
> Does setting the tracepoint handlers before processing events work for
> pipe mode?
> 
> Since the evlist is empty in pipe mode until events are processed, it appears
> perf_session__set_tracepoints_handlers() won't set up the handlers.
> 
> When samples later arrive in perf_sched__process_tracepoint_sample():
> 
>     if (evsel->handler != NULL) {
>         tracepoint_handler f = evsel->handler;
>         err = f(tool, sample, machine);
>     }
> 
> Will they be silently dropped because evsel->handler is NULL?
> 
> > -	if (perf_session__has_traces(session, "record -R")) {
> > -		int err = perf_session__process_events(session);
> > -		if (err) {
> > -			pr_err("Failed to process events, error %d", err);
> > -			goto out_delete;
> > -		}
> > +	if (!perf_data__is_pipe(session->data) &&
> > +	    !perf_session__has_traces(session, "record -R"))
> > +		goto out_delete;
> >  
> > -		sched->nr_events      = session->evlist->stats.nr_events[0];
> > -		sched->nr_lost_events = session->evlist->stats.total_lost;
> > -		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
> > +	err = perf_session__process_events(session);
> 
> [ ... ]
> 
> > @@ -5167,6 +5174,9 @@ int cmd_sched(int argc, const char **argv)
> >  	sched.tool.namespaces	 = perf_event__process_namespaces;
> >  	sched.tool.lost		 = perf_event__process_lost;
> >  	sched.tool.fork		 = perf_sched__process_fork_event;
> > +	sched.tool.attr		 = perf_event__process_attr;
> > +	sched.tool.tracing_data	 = perf_event__process_tracing_data;
> > +	sched.tool.build_id	 = perf_event__process_build_id;
> 
> [Severity: Medium]
> Does this code omit the feature callback required for pipe mode?
> 
> Without registering perf_event__process_feature to tool.feature, it seems
> feature events from the pipe stream will be silently dropped, leaving
> struct perf_env unpopulated.
> 
> >  
> >  	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
> >  					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);

Hi Namhyung, Arnaldo, Ian,

This feedback is valid.

In pipe mode, header attributes arrive dynamically during event processing,
meaning session->evlist starts empty prior to perf_session__process_events().
Calling perf_session__set_tracepoints_handlers() upfront resulted in zero
handlers being attached, causing incoming tracepoint samples to be silently
dropped (i.e., evsel->handler == NULL).

I will resolve this in the next iteration.

Kind regards,
-- 
Aaron Tomlin
