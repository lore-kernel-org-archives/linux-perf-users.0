Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022087.outbound.protection.outlook.com [52.101.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFD20E023
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785094324; cv=fail; b=fj82sCTMQ0mXubJa7clgE8+SuYYiTYbyVbPiav7qgQjhUT6TqHsibreE9yQ6XDMYhU8p5DeVJi6yfNRcRKhmxq2rU/GJDPKZ3VzKuBUKnXdh671oCIwTS75j9BE0UB26TjaCsixi6xvlgBTpO98L+D2BhIJo9OLy/T5pdw7RqWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785094324; c=relaxed/simple;
	bh=ceD0VhTeqUjUodEuM1UWe1+aOKxNrRUsypP7wrO1MrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h8tpAmHUm7XP4biRxaEJl6mb/z4HMuzvK3b9w52hiV5xA7nt5kuy8CRUAZdt8mgZzkq7BkBnKRUitY268xG/Obf+sveJ7OegTGv2tiq3pTLjI6SnYRKFjB6Y8J7pRt0KiCqVeYQdUJBTjUShSVsmwXzYQciXpEPT3GOyzlSbGaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L05Uorhtm1MqM+Zr5PSKZIfVvstvcuceukitdAQBKQE9waAzJQFwxj5csjdHeBcPE2GY5s6WKq859Ucqv/q2KlHDLkUlJ0QBjI9A8f7e4smjBQvx8ltQycQz7wWgY+p+UlAWcB2mkK++bcLIOVCM/Pu10eRy4GHNEXoRz4a8Aws6GfoPyCG6AqDbD7T7ZpH2gFDyWpwrhLe4+dwijHOlwJ8BxqtyZ50cprSxHjVv60UyFWex/WGKGoqgfFt7MpQ4JKf1fk74rNAN69686H1vHrKf3m/NI4D5e6/1GGsT/KiZydOnkFKRSZvtzO+8j1pfrd8fNYpkauaknZ+lcFL1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ZXoKaXHYcw0/CGFdMxjiKkMld2KhRPQhHBb142uCFNw=;
 b=aqc+yZX2nHgVDqEWM7vxmG98ggHKme9RAPzCaYbx7BgGrZ1KDMF+EzsKqKLJNuYpjKhOf/QiC7yxel32zMPvd6R7+uyw6zWd/mts6BtO0+/JtpKLoIYSwTrHirHqrdhB1yHW/Lesmq9TrsKW0ZBlvBnzt/DtTqkrbDZBKkPrWqh7saaeagkQYWctPTBQJXhPDcvhB5yDv26aq8Vp4KwiIIVz3TVvcbQSQqWedqoojFEVwG+h20qhz/7hh3Y58X428hfIX5JREnAsl3bjMyJdGNkS434Y/sIhkqRDWglD0VUts5mok7JxE+AQK+xml71NjD3zU8D2ol/ipm+AZqrtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6976.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 19:32:00 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 19:32:00 +0000
Date: Sun, 26 Jul 2026 15:31:57 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: irogers@google.com, namhyung@kernel.org, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf sched: Suppress latency table output when
 trace samples are missing
Message-ID: <sgw62mtino7m4h3whr553dijcn5hiiz46hrbqdmj6qamudo26m@nri7gkvw2t7i>
References: <20260726032533.712462-1-atomlin@atomlin.com>
 <20260726032533.712462-2-atomlin@atomlin.com>
 <20260726033725.C765A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726033725.C765A1F000E9@smtp.kernel.org>
X-ClientProxiedBy: BN9PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:408:112::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: edc55a85-29fc-4182-dc66-08deeb4c9048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TMCCVySkAShMn8t+sNRmxw+oNHJGroKpc03ZkSdjecufc4XOCanjMnBDlbMTaJhRooWPisSxx0yd6aFIE7/HvtUL4k3mhHqUfXqU88uVhObF/M6vtKvjHW8h2eYUUhnxwyyAH3GydSqBaZ7OW/LX2pNfVfmdJbmcb3Oc0HoJytDz0F2Qm5ay9LuObDKuATiGrMxaePb0BlsU9hxj4BLPDIInst0duParenFvs0ELrHmZEx3BTJ/bAKW1OegoFgpqwyjU60a0TSowpTMSWZykgJlgFFK+9PQh5u/d2sm5V9v6mx2CBHdKgJ7Ao/yuVQukD8vnHZvQCl1Z53I/K4jb0HgNe+rIgZNgmwtL181Z78IdNvvOZS8EGgYF0RVGQ6MBLQ3Ml1ztgua8v6J7VIJFizST1n7iDgaJrw4xJBTh9kvx96cD/MlxYZJspz1dvk+5M12n/KooJSHwIgsG7QvgfI0tu80wKNCvxSf5CXqGQGqEDix8UbbbA6WbOetgVawCxEQGnvlrr8D5LrKne9stpS2DCYFrwulIamX2SRkiVs5FM/SWAUW6GSURvAl42S5nSpF9JP8Le5dvs+UvXCSC51WiUmFBxF8QKx7PE1l5ga6bG9crDnA4QlWiTAoScQ6Q3Y6hfaRU19PB2XDD3J8EVIRPlEIjdg3f8hwZX4JFKs4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlM1eDZKN3JmeXI2L0hjN0NxZ0xRUDhEOG84K3NmZWljc1MwVU5nVGE4WmRm?=
 =?utf-8?B?WXlSWWNTbzYxaHMvbXNURWp2THZiWmZwT0grNXE3QjVvWDhwNVU2NjZsNjJh?=
 =?utf-8?B?cUd6Q1hYNDF5S3FVQzB4SGU0akVMMnJ2S2d6TVVBL3JMVEkrL2ZMY0ZvVGJa?=
 =?utf-8?B?b1A0cFZBWEpMTDZjUDh0N2FTR0huSVJaOStVZk52YllkMGVxUVZaeWJQZkdl?=
 =?utf-8?B?ZzlmTFZ3OVQ5eTFmdkt1UUlDc3lHTTJzVzlDWTNidzN3cXlhYUdTUFNESEY1?=
 =?utf-8?B?aHRBVkw4MWpiSlBPdW02SFdRU2xrSmFzZGZPenp5RmxYMytJbVQ3WGYwempz?=
 =?utf-8?B?WXZ0Rk5FZ2NRNGJwVUo2QTNTYzY4WTBKUGlMamx6ekdtdFZLL1RKdFlIZGtQ?=
 =?utf-8?B?Nk5WTk9RWUs1Nk01eUFlSlZ1L3dQcTgrN2RsSDY4dEdpYlpxeGhTZTl6eHhY?=
 =?utf-8?B?SXl1ZVpmVy9HK2RrRkdUaGlWVUhobENObTgwb1ZFR2M4NkVzRmdjeFFSVWpC?=
 =?utf-8?B?eVdtcG42aFFQWkw3ZjZubDZmS1ZuK3VkMW5JQlVaZ0ExTmFHRnBsMWtZbktt?=
 =?utf-8?B?elBkdEhnWkhBemNYK1MrRFNwTUZYd09xZmhzUnF1MHYvZmxIRTI3ZWNqS1RE?=
 =?utf-8?B?QjNpUHRzeW4zTUlVSUZNSG9nUVhJVGxwUlhTV2Ewb0ZvbGJMTWQ4NXRBOFpl?=
 =?utf-8?B?NFZxQlJWVlFMUytkdWQ1cFQvNjZIT3dJNGozd1duM0tRdFhKVnJlVXhZRzRa?=
 =?utf-8?B?QXRYZ01BRUZUYk44R0lIZVBJTnBrVFBCcndZL3ZjcytUb3RDRWhkVmppY3FE?=
 =?utf-8?B?OWVOWnVENUhCMWtQZHEzQkVlbGJFMFNjYlR2V2tvbjJEeExDdTFiVytJLzhI?=
 =?utf-8?B?bGk3OEkrRU1oMGJrNUxhQ254YVltWWc2Qi9KcDhQUXZBOVhMaWpQdDZYa1lJ?=
 =?utf-8?B?NXpLTVEzaWhZVWVNdWxiaDlEQ29wK3pWZVV6QTdqQVE0aFo4WE9YRDRQRWJz?=
 =?utf-8?B?U3EvRzRLUU1RekYyWC9UM0trNzFzNVkrWm5vS292d0R2aGxWNmVqejZiSk1w?=
 =?utf-8?B?K3VPeUNYVXZFYzFFT0xLVjBldkdiT0tBQWxsOXh4Zi8vbmFkTWxrZHVRcTNJ?=
 =?utf-8?B?M2lXVnpjcDFBQ2tLaDgrMGcwSjN0SzVSTEJnRU1HUnFNbkt5ajZvbGJQRi9k?=
 =?utf-8?B?bko0QUxsRVNhVm82UkFDRm1hN3ZuSVpQSXppbkw3L0dWQzduUXhDYllvRzF0?=
 =?utf-8?B?Y2lnNW50Y1N0NVZxS2EzRHd0UFBUTytTc2FOOUxHZzdtRWw0blo0bmsyRzB1?=
 =?utf-8?B?VDZHUHlZQ3NKREgzOUsrZVorSzU0MzU5bFMrcWdsbTN6cmI2RDFreExJbytk?=
 =?utf-8?B?ejF5WFAvQ3NZeUNhbysyeGtnVmhuTjhkbVhUcTI5ZzB4NWcvYituKzNQakxq?=
 =?utf-8?B?NFFISkI5V1RjN1duVmdPdTVqU1BZRHVGQVdCUUpKeXFVNENaVXd6ZnU4eGdC?=
 =?utf-8?B?VHRyMGxFVW41cnRFcWgyYjVyWG9yMy9ZTyt0WkhneFJwbEtheVNLR2VSdllY?=
 =?utf-8?B?c1FjR1NBL08vY1Z5SE1SNGw4VE4wd3lqSGNhbGRhZDltcEthcGh5VmNvcXZ4?=
 =?utf-8?B?TmhobW5pNUZJci9CdDdqVSs1amR5VVVpZ0ZEbFhRUmJXUEFPd0pRU2tSNDZD?=
 =?utf-8?B?b253azBnNmhTakxDanJIejRWYzhMRG9BWXdJSExoYUpkK3JmdDlRK2IvVmZQ?=
 =?utf-8?B?dmc1cmVwVTV5Z1hoRzZqOFFuanExMnoxMEd0bkVBck1GK1RYY2QyVDl4aHpJ?=
 =?utf-8?B?L3MyNWVqdjA0VEFUSjRxVWptNXJEZUlHbFNlVUpzQjY1bGdrZjA1UkYyb1Zv?=
 =?utf-8?B?c1h4cXNqZzA5YVZBVHNWeGxoVjFMYlpuMGM2MVIwczJOalBWdkZTZEwyYUhj?=
 =?utf-8?B?dXczdDlNeFhDZkVraUx2ditpRy95UTV3Mkg2ZWE5YXdybThwTUw1Tm16R2g1?=
 =?utf-8?B?b29CaGRCYmh4aXhoTS9GSmFCQ3VheXJWYlNkRytXMzZNdmNIRnJrMlhJb1Ny?=
 =?utf-8?B?QnUwSkJldUw1RjFuZ1NJSlJ4MXBPUlJSL01TNFVPRERrQ0tmK1VSMVQ1Q1ZI?=
 =?utf-8?B?S1lKNEZkQzluNHMrMm9mRERYbS9ndDV1YzlqNFNPMGh1Tjd5MDlROEFiZTNk?=
 =?utf-8?B?SnQ2bE9HL3FURkxScGFBRFRHeDlSYnRabWptWXJ4V1h2MTBUVEFXNE9kOFNX?=
 =?utf-8?B?TkkzSklhZHBmaVk4dmhWVmhIdmFBVHROUUwxZHJubDdpd29qK0FFYUdWZ0Nm?=
 =?utf-8?B?eHVJTjFrY25TQ2FmT0F3bjZmVWYwU3JqV1BBa05nUVpaRGRpcDNoUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc55a85-29fc-4182-dc66-08deeb4c9048
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 19:32:00.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Pozb3imFe6LTc9lkMCUDVQrIRioExxM2Kkh8BNdQEljoZcTkENE2Hj5AXIEGoZMv4MWOVhEDaEm06aboFSi4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6976

On Sun, Jul 26, 2026 at 03:37:25AM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 7fd63a9db4574..b3cf678573e0a 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> [ ... ]
> > @@ -2018,18 +2018,19 @@ static int perf_sched__read_events(struct perf_sched *sched)
> >  	if (perf_session__set_tracepoints_handlers(session, handlers))
> >  		goto out_delete;
> >  
> > -	if (perf_session__has_traces(session, "record -R")) {
> > -		int err = perf_session__process_events(session);
> > -		if (err) {
> > -			pr_err("Failed to process events, error %d", err);
> > -			goto out_delete;
> > -		}
> > +	if (!perf_session__has_traces(session, "record -R"))
> > +		goto out_delete;
> 
> [Severity: Medium]
> This is a pre-existing issue, but does this patch now cause pipe mode to
> always fail and return an error code?
> 
> Because sched.tool is initialized in cmd_sched() without the mandatory
> .attr and .feature callbacks:
> 
> 	perf_tool__init(&sched.tool, /*ordered_events=*/true);
> 	sched.tool.sample	 = perf_sched__process_tracepoint_sample;
> 	sched.tool.comm		 = perf_sched__process_comm;
> 	sched.tool.namespaces	 = perf_event__process_namespaces;
> 	sched.tool.lost		 = perf_event__process_lost;
> 	sched.tool.fork		 = perf_sched__process_fork_event;
> 
> In pipe mode, PERF_RECORD_HEADER_ATTR events are silently dropped by the
> fallback stub handler, which prevents evlist population. As a result,
> perf_session__has_traces() always evaluates to false when reading from a
> pipe.
> 
> With this patch adding an early abort, does this mean commands like
> 'perf sched latency -i -' will now unconditionally fail instead of processing
> what they can?
> 
> [ ... ]
> 
> While reviewing the rest of the file, I noticed another pre-existing issue
> in map_switch_event() that might surface under memory pressure:
> 
> 	sched_out:
> 		if (sched->map.task_name) {
> 			tr = thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
> 			if (strcmp(tr->shortname, "") == 0)
> 				goto out;
> 
> [Severity: High]
> This is a pre-existing issue, but could this lead to a segmentation fault?
> 
> If memory allocation fails inside thread__init_runtime(), thread__get_runtime()
> returns NULL. Unlike other places in map_switch_event() that verify the
> returned pointer, the tr pointer is immediately dereferenced by strcmp() here
> without a NULL check.

Hi Ian, Namhyung, Arnaldo,

These are pre-existing issues. However, do you mind if I resolve these
valid concerns within this series?


Kind regards,
-- 
Aaron Tomlin
