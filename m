Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793632965;
	b=QGbzwYJrjzsWuykWu8KSyt9T4pGmK8DSHTZu+Q5ceDO+2m7io25/oLm9/aaUoMc7GsSk
	 tM5zxV5HWxdQltr7qHf3Hoox2S+jJR2Vr1f/357JQBFJuxS3rhccqDjOTITKd/2q9TKzM
	 indBPKkuAOi2jAXzt+fOo5BQk1BwqczP+dkFUWaxJB4ff11bIL0sZTkUEE+pa037HZCJW
	 XMZF45zgUDyPgafF4bWO1x28Oo2y1+h6FY/6tvlEcmPunkcOXcpKDcgXZBIg4RFmEtF2Z
	 akjkgR2pwuS34LNt57+s8dzEbOv2eyux/f2G9E9N2w1p92DgfDEL/A0x4I+98BWCOfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632965;
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
	bh=CXM3ckLzCBSxzsIZET65Ko3Hnj+89xVuSnu6VOMlel0=;
	b=3zbaoIBEC0qUyucvqAfu04RNb1iSQdsUvhJc6ZkNS17uCC0NaZn1//jLN2EVW7axkZzn
	 jJx54hVkH78m30GDm2w31XJdpbFoKAP6uMi/WSc0LqLb0+ajrLWfGqjV2oBYHd9QPTCcf
	 5NQXpcI/vWYAZtumRwWJzd4t/drgdrd5nyraBzuOXAVFxw7OvCsCD9sFvP+mQywLBAPSo
	 +WZNLA9LjrZTnQP0Tb2gIUMLf3YW7EXgF77yHS2tDvSZvvojmdsD1pgMh5lpkndFZ8m5e
	 ZdvVcmPiuQNPTZ9WMbNvYcm2GPEjLKVR+HLFbtYSSDdwarOmlq3BJu/PYlDRdV1iTBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.108
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022108.outbound.protection.outlook.com [52.101.96.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC56082288;
	Mon,  2 Nov 2026 15:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94EC56082288
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arBBaDLr0uA2sNn+9uroxvNumHb6ldKaaraqdksd9cx4Zkk9m8L+YLyB7xv7CtdVSIEDspzCF/3NZA8xukKOBHMqBWQ4mjWbG0xcty0g4UU5vA8K+xgrLSy09KbHkH6SY0oSIQDtfcaLbGoa+oc+HvY3pSJPKbhguTHFZYRPwyqYWOr7Pvw5D/72B+RUTvRRKuNtiNZzdtszbiuXtINLqbl4FqhguVEuwvdl7EMQOoHwjgRn3vhHCn4fpS+Pe4RcY/IFQHcKdGFDQVD9Aliyy9SPzGhE44BOYEGoewbXrs9seTSBW0ed69s4tk+zslaFGseNAkNj4MZLERevuzpgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=CXM3ckLzCBSxzsIZET65Ko3Hnj+89xVuSnu6VOMlel0=;
 b=LYuLkgwO3gs/yz+xavuChAHuwUFsbir2Uof58IjZzYSIoXE83NAajE4o+NLYAhww+zandXcvUiNC0hAdJXnevSRDinTybABLhagFthDck1rElbitKgqMhSPkKetktF/jBoLeVvEMbtySvXNcdUTROIz0uSIvBE5WrYXzPEmh7BTDoZ/K3WYKIcZuyYRjx3P+Y2mLFiPNyJQkQJq9OJ8ohUhKuHu/1XaA17izB0ft7YwCjpi0Hmns0wPl6/5uM1Yglad0i9H3s71pQPx3JmLuPaHeu0EwyyqNMpqte7YrEC0qfcf7/CxVQlgNGclxmm9PMhd2+RItQD0AgaFqwRmVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO0P123MB6367.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 15:22:40 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:22:38 +0000
Date: Mon, 2 Nov 2026 10:22:33 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, chjohnst@mail.com, neelx@suse.com, 
	sean@ashe.io, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Message-ID: <znjf2nob4dw6ajhyzziz3zfxsxr4skomqhkdnp3qj6zubuaomx@6io32swlagmc>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-7-atomlin@atomlin.com>
 <auWUpl0toDFpwSYS@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <auWUpl0toDFpwSYS@z2>
X-ClientProxiedBy: SA0PR11CA0206.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::31) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO0P123MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd048a8-fe75-4f5b-24cc-08df38f52137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|5023799004|4143699003|261022075727099003|261021121427099003|261022105027099003|261022113327099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261021135927099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	wJiolTw2ad3T4zZnqvhO/9fE5R8OmYA9Ee67bQqAkaHkqQozoyUmi91vlbILgUQarxXMDwqiDh9EnNul0gbVLCnd8h+HQjpD6puY9CWxkIBlFLYN6mVUgnmCe2mnaUmK0/ze8wMgmACKxGi6Stns8P7CSGVHHQabFMPwfkDPVx3XHE9oZbWXLYFF1ySf0qXsm965v1sKcsDcY5U/N47fwJTQ5hzgVSi0aSCejzQLSx1e+HmMK9yRA601MmK9yRdSm65wnOgmiMwK3URkpngfNSJjvk3nJC9NE672yOPL/bhe0VdFllhFiYeNb0paytUuXsbSY4BMPWN5x87qSqodBCw8ExLvDevflSZV1xDOsFXyjvdhtrOUtPX21oPXtWbxVntSkqVAuagi9Ke8ZbLEa/hGUDrKHW9eBxlWm3YfhjWslW4wFtW4NUA984AuJwWCDI4syZKaEONQ1SNqMSIGfc7QfjE4fGnDnEAYZVNv0jOZIhJoXmDiVsYmUWbrXpZuKb2wVAJSdLypJXlUXBLeJbkTiKvNefE8NbClPT0QbWiCPJzU6tAYOrZ+UtZIuqCtiGM2UswQcEu4D3Wa/xMzVykFwNWTYfLRfErhn97Jloqdd3UyudVUM0HhllpJhdikmVhplY/PLWw+yODtS1KkrBBV4oc82d8I5eHV8sGNKmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(5023799004)(4143699003)(261022075727099003)(261021121427099003)(261022105027099003)(261022113327099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021135927099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0xRUjVpR0tWM1l0eHkxN0ZyUENQakZOL3JpYzB1a0hsSEx5WEdPVmF1T2Zu?=
 =?utf-8?B?WkVJTG8zalNDVVB2cHUrZEx5Y1pucWZQYmwrV29xVDl6b256UTFqdk9mZkpu?=
 =?utf-8?B?OCsyZ1hxbkp6UWptUE5sWCtLejB6V1VSWFJkSjYwb1Z6My9qTmpIbWh5OFFl?=
 =?utf-8?B?MXBueUJLT24ybFEvZ3hmUEttWmdxdFArdSs4VG8zTjNCamlkMEY0N2w3S1BW?=
 =?utf-8?B?ZVNhdWNXcTZOckcrYkZZSU5mWXJoTkVja3VqWUJZOFF1TXBtaTA2ZktNamRi?=
 =?utf-8?B?dUttSERZcnk0L3BNcUdLUjF4VlFaZjc2WDN5RTZmNGpHSVBoOVJwMW5wTWc1?=
 =?utf-8?B?WGxCc2g0LzQ3emg4VURMa1ZyMkhIR2lxTlBGZTZKR29iS3FZMDlIa0J6bTJI?=
 =?utf-8?B?eUtueXhpVVk2SllHZFFaMXM0Y3lNd0xwaytCRTQycHBzVlc5Y1p5SXo0cStK?=
 =?utf-8?B?eUpJMlB2TWRTYloyU1A1MXB3eSttaUtnTkl1ZzBxNDBnejM5ZEkvMW5VME9T?=
 =?utf-8?B?WWFCUlpUWjlsdEtmbE5YRkRYUW9NMk9aMmR4bVNpV09kYVJLc0diYUtmWHIw?=
 =?utf-8?B?N1Z6UGR6MkZLWndvRlJnQUU3NU9ZWEtVMVR3MExxT3doU0RGd1psVkNOSUhF?=
 =?utf-8?B?S2xzZG8vRzR5NlZNRy9JcHVZNHRtdjhDYXJlVHZsQ0tCbGdqejE1Q0RrSUJo?=
 =?utf-8?B?bzY5eU1MSVNXTTdxYjZQQVdVbXNXbDNlTjFpcGkxMlFaY29idmxjdzhtUloy?=
 =?utf-8?B?SHpITWFhaEJZMDlZOWVWSDEwbEQxeTk3SWlDR002QmdlTHEzTU5jZnJCSnNs?=
 =?utf-8?B?MTlha0p6QWxrczZJQWhkT2s5b1pqQlNQSzF4UGNqZy9LODhHM0tNM29BVEtk?=
 =?utf-8?B?ZEJHYXZoanUxbElBS1g1OG1jYlRkeTdTQWdzK0Mxd0RMVjhtYXB6bis5YTVr?=
 =?utf-8?B?UHNaUFduVVZqOXd4b0YxQ09HUzZ0TXZqdFBBYjVGcEhqZWowMk9aMzk5QWRs?=
 =?utf-8?B?bU9JSjFWYkFoTHlVY1BzOE1QZ0lZZjh3ZTk4dFdQTWl4UkRhK0s4bm5zTzhO?=
 =?utf-8?B?bEJ5YmIxNjhMRk0zWjdJMjN1cXFpOGRXQTNBK1drMGxlVklLeFcxMlR1d2J5?=
 =?utf-8?B?b1hucmFGTG5NaVU3Tzd0Z1U2dzFZWXNSQmNFeXdvM251M3lBODhkL1IxL3Vl?=
 =?utf-8?B?ZkVWcEdqKy9yS1hmbDBIL3JkOVFwYlUrcUpva2R0WGZBSnZqbjBoa2dUeGhn?=
 =?utf-8?B?SGF5a1gwZm9UV1d6WU0rR0xIdk1vZUlUbm9yTXVWUXE0YSs0NVZyNGtHc3oz?=
 =?utf-8?B?VlNCMU83bGZoM3hYaHlQMWdQZTNVR1BjSFdyWFlzNFpaK2pJWnJLVEJNVjBM?=
 =?utf-8?B?YlR5VkpnN3BwU1FGb25SclF0WEF5T1UzT09hck9PWWtuT1NLeXgwTnNwcmc1?=
 =?utf-8?B?SmtnTlFjcmx5Rnd1R3RYMXlJRVJ6eHNSblNCazQ0b09VWlpwcXMwK1p2dmly?=
 =?utf-8?B?TU40bzVqNGkyd2kvLzdzamNJYTZLQS9pa0tic0lLSWI0YU5uNU1zYVIzbkdy?=
 =?utf-8?B?WE8vdjZrODhXUUtibm5mWUpEVU9HYk5JZGljT0FoOGowWnpjbFhnR1JZejlF?=
 =?utf-8?B?Yms2UmpoaW52UFVMWEMzWUEvNXpvNDR1UlpHeGthZlcvc3hYTURFNGprUStv?=
 =?utf-8?B?a2xORDB3Y1BOblBOZEIzYmRIRzUxNCtTMW1VMlptWUMzeCs3TlhFcEl5VFls?=
 =?utf-8?B?cEMyR2VCV2tWa0lVT1docUxINjhRUHlJRndSeHlhd2tGT3NZV3B4OWxXanFE?=
 =?utf-8?B?bmN3QUVaQ0NjcTUxZXF2cUlqdWdQSDRnUzJHc203bjhOUXBzOEt6TExjRHV3?=
 =?utf-8?B?T0tGUi9EWHFUUENiRWhwcjFnTmY1NzlBY1V1bm9IU2R1TDl0cElNT1loNThP?=
 =?utf-8?B?L2dKWFJoVzR4N2JKYkwxNFRheElPQ2ROeVFoaCtQVGI4QlpBRWdNNEkrRHNr?=
 =?utf-8?B?alh1MSt6MTJsb3l6ZG9tN1Q4TGh6aWxuZXlsSHZKTVFaR3ZjVzNrQy9jQnY5?=
 =?utf-8?B?MjEyaEp2aWR0T013UVJFbnVNQnBpOStKYm96RXRSYVMzOWV4cEdkcmp2b1l3?=
 =?utf-8?B?dy95blpoN21ydGE4U3U0WERCZTJrU2R2ZnJ6QXkrR0g1QlIvVGVDQXUzdkhn?=
 =?utf-8?B?bTlRNWlPTlZoZSsvUVIrNHhuZ21LbVQ4dHFaL2h6NHR3YXhlVi9YR3B2MEZl?=
 =?utf-8?B?QXQwTTUwV1Z6bXA0ckFpbnRzOVlhdmNPYktHNWtYb1hnTjVic1c3cjd1d2pV?=
 =?utf-8?B?bEhwNlN5ZE9TQ2tLNE9QVUJ2dFhCQmZaSFVjbGdGK0U4M3loT2ZrZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd048a8-fe75-4f5b-24cc-08df38f52137
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:22:38.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0oSXDTwle/aCKnxs49fd8XjlKaahMHtnppJ/GCjj/dbmmmepTGkfFZUfHDDo2iR4P6ZcBCLYiw5R4KJQFWGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6367

On Sat, Oct 31, 2026 at 12:11:34AM -0700, Namhyung Kim wrote:
> > @@ -664,11 +834,16 @@ static void extract_exit_func_name(const char *str, char *buf, size_t size)
> >   * @cpu: Pointer to store the CPU number
> >   *
> >   * Locate the context columns that precede the function call column of a
> > - * function_graph trace record.
> > + * function_graph trace record. Depending on the funcgraph-* options set
> > + * up by perf, a record looks like:
> > + *
> > + *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
> > + *
> > + * The abstime and comm-pid columns are only present with --graph-opts
> > + * verbose.
> >   *
> >   * Return: A pointer to the last character of the context columns (the final
> > - * '|' delimiter, or the CPU ')' when no delimiter follows it). Returns NULL
> > - * if @line is not a trace record.
> > + * '|' delimiter). Returns NULL if @line is not a trace record.
> >   */
> 
> It'd be nice if you could move the comments to the original commit that
> introduced the function.

Agreed. This was an unintended artifact from an earlier rebase. I will move
the comment to patch 04/10 where find_func_column() is introduced.

> > diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> > index 45f5090d0115..7b9e0919ae8d 100644
> > --- a/tools/perf/util/ftrace.h
> > +++ b/tools/perf/util/ftrace.h
> > @@ -42,6 +42,8 @@ struct perf_ftrace {
> >  	int			graph_verbose;
> >  	int			graph_thresh;
> >  	int			graph_tail;
> > +	bool			use_inline;
> > +	struct machine		*machine;
> >  };
> >  
> >  struct filter_entry {
> > @@ -96,44 +98,18 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
> >  
> >  #endif  /* HAVE_BPF_SKEL */
> >  
> > -#define FTRACE_MAX_CPUS 4096
> > -#define FTRACE_MAX_STACK 256
> > -#define FTRACE_PID_HASH_BITS 10
> > -#define FTRACE_PID_HASH_SIZE (1 << FTRACE_PID_HASH_BITS)
> > +struct machine;
> >  
> > -#define FTRACE_IDLE_PID(cpu)       ((pid_t)(-1 - (cpu)))
> > -#define FTRACE_UNKNOWN_PID(cpu)    ((pid_t)(-1 - FTRACE_MAX_CPUS - (cpu)))
> > -
> > -struct ftrace_stack_frame {
> > -	char *name;
> > -	bool inlined;
> > -	int indent;
> > -	int raw_indent;
> > -	u64 seq;
> > -};
> > -
> > -struct ftrace_indent_watermark {
> > -	u64 seq;
> > -	int raw_indent;
> > -};
> > -
> > -struct ftrace_task_state {
> > -	struct hlist_node	node;
> > -	pid_t			pid;
> > -	struct ftrace_stack_frame *stack;
> > -	int			max_stack;
> > -	int			depth;
> > -	int			inlined_depth;
> > -	int			overflow_depth;
> > -	u64			seq;
> > -	struct ftrace_indent_watermark *watermarks;
> > -	int			max_watermarks;
> > -	int			nr_watermarks;
> > -};
> 
> Hmm.. probably better to define the structs in the .c file in the first
> place?
> 
> Thanks,
> Namhyung

Agreed. Since these structures and macros are internal to
tools/perf/util/ftrace.c, I will define them directly in ftrace.c in patch
04/10 from the start.


Kind regards,
-- 
Aaron Tomlin
