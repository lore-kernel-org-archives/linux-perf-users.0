Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.114
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792982577;
	b=SFz5mRb5Br7vtJMjX0UrbV/cw64fRU8zASJyor95fOOHh0rmk0exwUJHHBBEmNfugxQx
	 BgN4dmeKh6+c6jYOPZ89hqfflsCJQwNM0WTmvZ8IE+k/VBiMu/oKJ4/tajiVo8OYAYG7f
	 hQxwH84n1sO1biJ63WF1JD5ksl8pGDOmiyjyKzX+aVbA8IvwXahc3w6pRoJnLYkcrrT+K
	 tPDRX+rNjwv3Jd2655uLf+qjy9ygDMY29Bz00EVHsQddLTHpAUK8pTvlqJKwYe3jlDdf7
	 Nv9zcXS9imO0xujgOX0d2EVnXsioe18n/Cd5vRodruE6ALuP1JP9NXW6Q8SsN8B+oLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982577;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=pt9jkWYfSuAUa9/8+aEBatxm99wliKDptIs9cZXx3Lk=;
	b=O7tKABIkpTeo5/I2DnWr1DVayUIQf6Ek8cUd0UTfWwkZOm0D5Qo2dWN4GmPYnqT83M4I
	 kpuYJf5oUx2Ec3G/TBnPzvqNJB7i+onx8fvJHHPaHFGeHSqttw4oJUe2Y1KznN6QJwLca
	 eSO1K0kZUUf+2Alj6uoqqtSJ9acS6EwWcEETB0bNrKJ7eaBfleYDNB3ukJBD1tWuY94CF
	 DFoEfgdh+WcXn/D4KGR9sOLfTYzhr0mnsa/qMkFwuW/kx0AzjTSs0uG9g20wkT8+VYfCv
	 MQbwK+8PX7JDfcEq747WUt3QNvnKImWXwkCKBZ5CH1giocS6ZIfYNc1EkCC8zNLW+BA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.114
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021114.outbound.protection.outlook.com [52.101.100.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B2606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 02:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A35B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGS66ovb0dtk5tc58mGgsQdRNq1LgKEeL6XLYtfzQTgcmHzedW7/Qo2Gl6V0/4pXpsgLtO/gecHK8e5ts2E1jYOQgo6aRUpgteonl5x6ffDiJJoLDe/yzxidl/FpotCq9y9IRWzi6w2EEaGEsGRIpdPNMhpFoypYZmIE2ODTbJoXbnx8OXf014eQatcW1Y6NkC+jqUTfCcZ/B0iCTsLrjjOKucjyi/5lzlSWtbXW5YvBW+/t+4cB+SqDz1JJQsHtzrQmQ8roSWVxDyNEveTydjJBREk6oNOwMXMOqmpwvTAZkpo1yb3q/R2lF6FVuG9xA7gF3BWAi/fJzTlHw3biTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=pt9jkWYfSuAUa9/8+aEBatxm99wliKDptIs9cZXx3Lk=;
 b=p52fQWIAFbIBYlyk07edXP/fo5/vWKTI5QVrjxRtoKFtLdp879xlZHUke0X/bccNLWKjKMO2+qDGxW6f6xWIrn8jxAIpUmmd97zXvrTUURapzlGujE1DFFUCjjFmowObTUsFPPEi1jRGB1/oZGYsIMBk01iW4vfmS5FKXuUDRSldWx+kqWziSo/kLx7zFFeUUGTALSaYY9AUkfwvh5E2Y+6crrUaa05fOCt1lb9ZQvL6DYmKqE3rCgbUDhIQhvWXLS3Tl/BChnCpl+5aT2cSYAnBj37yb5lbOckj32StjxQ/dGHCQPbwZm8wr21CMcywHL109KylWzEfZHFIWqJkpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB5942.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:42:52 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:42:52 +0000
Date: Sun, 25 Oct 2026 22:42:47 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v11 05/10] perf ftrace: Support context
 switch tracking in function graph tracer
Message-ID: <rmjfzveoeekolkvnsnaqxilxzyw7u6w5uzu5j52xm4mv27eqhr@weipa2yaaoev>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-6-atomlin@atomlin.com>
 <sashiko-outbox-184338@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-184338@kernel.org>
X-ClientProxiedBy: BN9PR03CA0848.namprd03.prod.outlook.com
 (2603:10b6:408:13d::13) To LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2b2::11)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f8761d-b32b-4f98-dd48-08df330ad459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261021135927099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mGZ93ZjlS5PulWqg7oMPi4QWcgWRy7BAByZjuzkn3zI2XjD7XqkkGOx7x0iKnSHNz1uKhcksYf1WOgfuQMHVkxoRzqz1AaojmRY4HrPBLWn/eA80sUWoVzYDmOuGK3/J8pbtS0vpnwcemIoGnz4oSPDDMvGACU+pXG1pB/qCvwK5fqU1x68Y3Px1PKMCyqc8C5DWE/mhGN6IdUYWvXU0Zoioq9glXtgeMmG0V8TeB2BdEnzA34RjfkCnWsQ7JMcdsK0ywPZrM/MaQCtV4rB9nIfek+8rCKxC2+h0euZNaqM970VIu0ZvX1hp7DG7+Y/epi9HHD2pXL4KEdzlz+KeNcqvS+GlX8dhNSCQAE9gvYO778nmk6DVSHAU7jKDHdnBK0scxaDG+fl3K6BcPWNBc2qYaUY4aDIiw8xWZPT/WEjLdfY2Li72JDy2wOrbq4I7ApAm3me9uGggOqETBoVpt/iXBW1j1gJH8xjEMbSzdq3YBkSnCRZRRIXmcJWn2abe2exGv3ho2QvfnWk2YcA1LOLNS5IaW0pxS8E4xxmz0o2+3piCiSvNeSMo/GOTeD2qXoJ1ma+mUZ9E3nTV6NFYc/u6hZsZeM2Dp17nb3xkWi4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021135927099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFcyQ3UzdERTbG5wekxNL2s3dWpTck8yOVZ2aGZ6L3FiU3MrUTNzWWVyaWV5?=
 =?utf-8?B?NEVHWGprWlBVSG54d2QrdFJ6S3R3cStjYldna3BVV3FMZmYwNnJwZVRlNEZH?=
 =?utf-8?B?enVqb0JhZWNPTFlTRWljdkNHTjBxQjZwUEtOaHl0Qll3WENLMTNvNllpOXBE?=
 =?utf-8?B?dzNRZVF3QzJqZDBPdXN1WkY4THlNSXdwODhMNDNyNitMeEV3WTFrNGppWXg5?=
 =?utf-8?B?dVZUNGJZcGxYb2M4TFRQVlkzUDN2VTJvRiszd0wwTy96S2V2Ny9sZFg3VjRm?=
 =?utf-8?B?K3hUR0F5Zkc0WExpVjZQUnZLOFVWc09STWNUTXBsK0JYNVFEME9Fbm16T3Qw?=
 =?utf-8?B?TTE4djBSK0srWEdjNVBCbGtmOEdLVEQ4OWRZVllvWG53bEVXb3ZIWlpZZ3ZY?=
 =?utf-8?B?ZjdXaml3OXhMdUgzWURVemdnUksyVDFBYlh6WkQ4SisvZjU2b3FCZ0h6MVd3?=
 =?utf-8?B?cFJlQ1JKRTBuSDZGOTZNWGEzRVBSak50dTU3SHduQjE1Zjh3VWl1U2hQa3Zj?=
 =?utf-8?B?Q3dBMGM1RnB3RjhrUXZzMzBNU3U1b2g2RmwvOXA3bVc4andTM0ZySHFUYlpG?=
 =?utf-8?B?elZHQldqQ0RnbTgzRnBVck1pSE5jbGhyS0dyTE16Zk1vMnNHUGhXLzVJMTFG?=
 =?utf-8?B?Z1B3eTBGNHpSRmZZYnFJMnF4V3l0TDFwd2ZJd0liY2ZQSUZzckZFSE12WHZi?=
 =?utf-8?B?bmZ1ZDdNREpjTk9uUkN5dzVtTXFUOE9NUWJFcTVzNFMrZXlLR25aOTNNeGxM?=
 =?utf-8?B?QU5YWnJOV2JXMzQ1dU5oQjRjYjd5UkdRY29SaVMvNERkbmNxMmNvZG1Zbnh5?=
 =?utf-8?B?QTUzQ2tKMHhuOG45TmZJUmYxTmpsSy9OUDZramR6NTVYTWRvV21WODlXL25T?=
 =?utf-8?B?MjcxZkU3dmZwek44dE1jZnBxOFN4M1VyYWJ5NnQzZ1ZydUpmN1hQcHZUSkYr?=
 =?utf-8?B?b29YcHYxbVh1T3pkZGFvT0VIRkZwaHB6RDZTaXBaOGJGcnBVL2V3bEN3Y2ps?=
 =?utf-8?B?dTRxNkw2NjJQdkdsS0FDUkJhWGxIWHNyV21KeXJpc0N4bEhLVGphV09rMzQ4?=
 =?utf-8?B?U1NheXNJa0pJbWxPS3BPVXQ5OFQxbC8xRzhGTWRxcUdzclE3WjJBMm9lWmxl?=
 =?utf-8?B?RXh4dk56bTcrRGttd3A2UlBuWFBJNU14akRSWG5WYytVWGpZT2VJQ1llcFZr?=
 =?utf-8?B?TjdKcFhrZ0VWUmRlOWx2RXRoTTZHMTdsZmxMOVlNSVJBZHZBaDlPeXg3SUZu?=
 =?utf-8?B?VFdFZmx2R0RjcnBORm1YMkpZV0ZadGpJdFFaR2FvNlpScHljMkJQWE5DenRZ?=
 =?utf-8?B?bVA3Wko4SE90Ty9aaGtMVmhZQVFOT0ZFcmpSaU4rWUoySmNPTk4vSzZtWFUv?=
 =?utf-8?B?RzJ5WnRiSG4ya0FGdjlRNkVwa0EzL0FaZXVZMlhJU2p3a1hiSXZtMnNEVFhB?=
 =?utf-8?B?NTFLSzUxcVBtUVRPYWxiYjVsaTVyVHQ5VDFIWEx6M2s2VHhDQWYwWFl0VHlT?=
 =?utf-8?B?bGEyUDBSVUV5dFVzU0sxaU9pOVJ1ZForMnp5VDRzeTNPQ0tXOUtvQmQ4YzVJ?=
 =?utf-8?B?YTNuSndrVHEyQlNKOXVyVDVEME5zZ1RLdTFSRlRibjNOMStPWnNmNVdPVGtj?=
 =?utf-8?B?MThTbXU1RjNEVTI3UWNFd200R2hsVHAyM0Y3dFk3clRHdUZ6TXM2VUc4OWRD?=
 =?utf-8?B?K21YNTJPTUNRcDNvaUJWRDEwRlVaZ1AwZkJ1UEROVXlNU2xwZERlUHMzcHV3?=
 =?utf-8?B?d1ptditjczBGZEZkdXVjM0VnMDYwRXd1L3k2MlJzSXhvWUZVeEpLTWpKNnZa?=
 =?utf-8?B?MTNtSXBSZWZtbW5mMzFvWldOTnAxVG5DL2xyWnVvWEpuTTBlMm5lb090V2x4?=
 =?utf-8?B?WC84V0hDM0RHekRsemlNR21qWm43RTUvbzg4M0NUVkJRMWlDYStCdlJiSE9J?=
 =?utf-8?B?cXp4Y1htNVB0SlpLcUdFZTVYOVhTM3hPWmdvLythSUFHeTVZTVNuOFkrN09U?=
 =?utf-8?B?Ui9kT21HOHFqTmJRNy92aXdESk5yeHo4RjR1VjVKK1FGZzlwVTZKOWR2Ylhz?=
 =?utf-8?B?ckV3MG9qTU5qRERWZU02OVQ0b2FTbWZpWkR1SVQ0Z3FqSjBwV2x6SlVjSnFX?=
 =?utf-8?B?RmJBcVlPT0hSU08vYXB0blU3Zk5rNFR4MGZpOEZGVzNpc1V3RVB2MU01K1dn?=
 =?utf-8?B?YlFrMG42WUd3MGhqemp3WG53cHkrcFpNbHFzQXFoTzVuMnhRVktuSXlQMWZy?=
 =?utf-8?B?SHRQN1MvM3h4WGdVOUlSTmVlYjdwQXRYbi9ZTWhLWER1YmNZTm5UbGJCYWxK?=
 =?utf-8?B?Tnl5WmxsVTI4QTBRM3BlZXB6M0pnVzB0L2pRbWtrbnBGbjJvWFJBUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f8761d-b32b-4f98-dd48-08df330ad459
X-MS-Exchange-CrossTenant-AuthSource: LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:42:51.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvkP+jqd0f+XDOgY3h6mefj29CtQEByt+PLj7XOgQkPnvvzfjOiPdO6+x9hfyjARgROdSxeLHS2LZ7NK7xf5YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5942

On Sun, Oct 25, 2026 at 06:29:04PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf ftrace: broken min_raw_indent tracking in ftrace_task_state__rekey()
> - [Medium] perf ftrace: non-contiguous unknown-PID splice in ftrace_task_state__rekey()
> --
> 
> commit 242f56625a11f73350f70f6bfa60c779b6624a22
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf ftrace: Support context switch tracking in function graph tracer
> 
> This commit adds context switch banner parsing and per-task call stack state
> tracking to the function graph tracer in perf ftrace, including task state
> rekeying and stack splicing across CPU migrations.
> 
> > diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> > index 95db57e70d11b..055b5eb6b8327 100644
> > --- a/tools/perf/util/ftrace.c
> > +++ b/tools/perf/util/ftrace.c
> [ ... ]
> > @@ -124,6 +129,208 @@ static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * ftrace_task_state__rekey - Reassign a task state to a new PID
> > + * @ts: The task state to re-key
> > + * @new_pid: The new process ID to associate with the state
> > + *
> > + * Rehash @ts under @new_pid. If a task state for @new_pid already exists,
> > + * merge or replace it and update active CPU references accordingly.
> > + *
> > + * Return: A pointer to the active task state associated with @new_pid.
> > + */
> > +static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_state *ts,
> > +							  pid_t new_pid)
> > +{
> > +	struct ftrace_task_state *existing;
> > +	u32 key;
> > +	int j, c;
> > +	int to_copy;
> > +
> > +	if (ts->pid == new_pid)
> > +		return ts;
> > +
> > +	hlist_del_init(&ts->node);
> > +
> > +	existing = find_task_state(new_pid);
> > +	if (existing) {
> > +		int split_idx = existing->depth;
> > +		int old_split_idx, post_count;
> > +		int base_raw_indent, post_raw_indent;
> > +
> > +		for (c = 0; c < FTRACE_MAX_CPUS; c++) {
> > +			if (ftrace_cpu_tasks[c] == ts)
> > +				ftrace_cpu_tasks[c] = existing;
> > +		}
> > +
> > +		/*
> > +		 * Find the split point in existing where frames postdate ts.
> > +		 * Frames 0 .. split_idx - 1 were pushed prior to ts.
> > +		 * Frames split_idx .. existing->depth - 1 were pushed after ts.
> > +		 */
> > +		for (j = 0; j < existing->depth; j++) {
> > +			if (existing->stack[j].seq > ts->seq) {
> > +				split_idx = j;
> > +				break;
> > +			}
> > +		}
> > +		old_split_idx = split_idx;
> > +		post_count = existing->depth - old_split_idx;
> > +
> > +		/*
> > +		 * Prune pre-ts frames on existing that exited before or during ts
> > +		 * (i.e. whose raw_indent >= base_raw_indent, along with any
> > +		 * synthesized inlined frames).
> > +		 */
> > +		base_raw_indent = -1;
> > +		if (ts->depth > 0)
> > +			base_raw_indent = ts->stack[0].raw_indent;
> > +		if (ts->min_raw_indent >= 0 &&
> > +		    (base_raw_indent < 0 || ts->min_raw_indent < base_raw_indent))
> > +			base_raw_indent = ts->min_raw_indent;
> > +
> > +		if (base_raw_indent >= 0) {
> > +			while (split_idx > 0) {
> > +				struct ftrace_stack_frame *top =
> > +					&existing->stack[split_idx - 1];
> > +
> > +				if (top->inlined) {
> > +					free(top->name);
> > +					top->name = NULL;
> > +					if (existing->inlined_depth > 0)
> > +						existing->inlined_depth--;
> > +					split_idx--;
> > +					existing->depth--;
> > +				} else if (top->raw_indent >= base_raw_indent) {
> > +					free(top->name);
> > +					top->name = NULL;
> > +					split_idx--;
> > +					existing->depth--;
> > +				} else {
> > +					break;
> > +				}
> > +			}
> > +		}
> 
> [Severity: Medium]
> Can this split_idx search and pre-ts pruning loop in
> ftrace_task_state__rekey() drop active intermediate frames from
> existing->stack when an initial unknown-PID state accumulates events both
> before and after events on existing?
> 
> In the kernel's function_graph tracer, verif_pid() only emits a per-CPU
> context switch banner when the traced PID on that CPU changes from its
> previous traced PID. Consider when task P starts on CPU 0 (tracked under
> ts = FTRACE_UNKNOWN_PID(0)), migrates to CPU 1, and then migrates back to
> CPU 0 before any other task produces a trace event on CPU 0:
> 
> 1. On CPU 0, task P pushes outer frames f1 (raw_indent = 2, seq = 1) and
>    f2 (raw_indent = 4, seq = 2) onto ts (FTRACE_UNKNOWN_PID(0)).
> 
> 2. Task P migrates to CPU 1, where a banner "other => P" binds CPU 1 to
>    existing (PID P), and pushes intermediate frames f3 (raw_indent = 6,
>    seq = 3) and f4 (raw_indent = 8, seq = 4) onto existing->stack.
> 
> 3. Task P migrates back to CPU 0. Since no other task emitted a trace
>    record on CPU 0 in the meantime, no banner is emitted on CPU 0 and
>    CPU 0 remains bound to ts. Task P executes another traced event on
>    CPU 0 at seq = 5 (for example, a leaf call or inner frame f5 at
>    raw_indent = 10), updating ts->seq to 5.
> 
> 4. Later, another task runs on CPU 0 and emits "0) P => next", triggering
>    ftrace_process_fgraph_line() -> parse_context_switch() ->
>    ftrace_task_state__rekey(ts, P).
> 
> Because ts->seq is now 5 while existing->stack frames f3 and f4 have
> seq = 3 and 4, the loop checking existing->stack[j].seq > ts->seq finds no
> match and leaves split_idx = existing->depth. That classifies f3 and f4 as
> pre-ts frames, and the pruning loop then compares them against
> base_raw_indent = ts->stack[0].raw_indent (2 from f1), freeing and dropping
> the active intermediate frames f3 and f4.

Acknowledged. Assuming a single contiguous split point (split_idx) based on
ts->seq breaks down when a task migrates away from and back to a CPU before
another task emits a trace record on that CPU, as frames on ts and existing
can interleave arbitrarily in sequence order.

In the next iteration, the single-split splicing logic in
ftrace_task_state__rekey() has been replaced with symmetric per-frame
pruning via ftrace_task_state__prune_stack() followed by a general two-way
merge ordered by frame->seq. Each frame is evaluated against only those
indentation watermarks recorded on the other state with seq > frame->seq,
and surviving frames from both stacks are merged in ascending sequence
order so interleaved intermediate frames are preserved.


> 
> > +
> > +		/*
> > +		 * If newer frames or exits exist on existing, prune any frames
> > +		 * on ts that exited before them.
> > +		 */
> > +		post_raw_indent = -1;
> > +		if (existing->seq > ts->seq) {
> > +			if (post_count > 0)
> > +				post_raw_indent = existing->stack[old_split_idx].raw_indent;
> > +			if (existing->min_raw_indent >= 0 &&
> > +			    (post_raw_indent < 0 || existing->min_raw_indent < post_raw_indent))
> > +				post_raw_indent = existing->min_raw_indent;
> > +		}
> [ ... ]
> > @@ -402,6 +725,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
> >  	if (is_exit) {
> >  		char exit_name[128];
> >  
> > +		if (cs->min_raw_indent < 0 || leading_spaces < cs->min_raw_indent)
> > +			cs->min_raw_indent = leading_spaces;
> > +
> >  		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> >  
> >  		top_raw_indent = -1;
> > @@ -479,7 +805,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
> >  			cs->stack[cs->depth].inlined = false;
> >  			cs->stack[cs->depth].indent = leading_spaces;
> >  			cs->stack[cs->depth].raw_indent = leading_spaces;
> > +			cs->stack[cs->depth].seq = cs->seq;
> >  			cs->depth++;
> > +			cs->min_raw_indent = -1;
> >  		}
> >  	}
> 
> [Severity: Medium]
> Does tracking min_raw_indent as a single unsequenced value that is reset to
> -1 on function entry cause ftrace_task_state__rekey() to miscompute
> post_raw_indent and base_raw_indent across CPU migrations?
> 
> There appear to be two ways this can corrupt the tracked call stack when
> ftrace_process_fgraph_line() -> parse_context_switch() ->
> ftrace_task_state__rekey() merges ts into existing:
> 
> 1. In ftrace_task_state__rekey(), existing->min_raw_indent is folded into
>    post_raw_indent whenever existing->seq > ts->seq, without checking
>    whether that minimum exit indentation was actually recorded after
>    ts->seq:
> 
>    - Suppose task P on CPU 0 (existing) exits a function at
>      leading_spaces = 2 (seq = 1), setting existing->min_raw_indent = 2.
>    - Task P migrates to CPU 1 (ts = FTRACE_UNKNOWN_PID(1)) and enters
>      functions at indentations 2, 4, and 6 (seq = 2..4, so ts->seq = 4).
>    - Task P migrates back to CPU 0 (existing) at seq = 5 and executes a
>      leaf call at indent 8 or exits only the deepest frame at indent 6.
>      Now existing->seq is 5 (> ts->seq), while existing->min_raw_indent is
>      still 2 from seq = 1.
>    - When CPU 1 later emits its context switch banner and calls
>      ftrace_task_state__rekey(ts, P), existing->seq > ts->seq is true and
>      post_raw_indent becomes existing->min_raw_indent (2), causing the
>      post-ts pruning loop to pop and free the still-active frames on ts at
>      indentations 2 and 4.
> 
> 2. In ftrace_process_fgraph_line(), pushing a new frame onto cs->stack
>    unconditionally sets cs->min_raw_indent = -1. If a task on ts (or
>    existing after ts) first exits a pre-migration frame at a shallow
>    indentation (such as leading_spaces = 2, setting cs->min_raw_indent = 2)
>    and then enters a new function at a deeper indentation (such as
>    leading_spaces = 4), resetting cs->min_raw_indent = -1 erases the
>    shallow exit watermark. When ftrace_task_state__rekey() subsequently
>    computes base_raw_indent or post_raw_indent, it only sees indentation 4
>    and fails to prune the already-exited frame at indentation 2.

Agreed. Tracking a single unsequenced min_raw_indent scalar cannot
distinguish whether a shallow exit occurred before or after a given stack
frame was pushed, and resetting it on function entry loses earlier shallow
watermarks.

In the next iteration, min_raw_indent has been replaced with a monotonic
suffix-minima array of sequenced watermarks (struct
ftrace_indent_watermark), maintained by ftrace_task_state__record_indent()
and queried via ftrace_task_state__min_indent_after(other, frame->seq).
During ftrace_task_state__rekey(), the watermark arrays from both states
are also merged in sequence order so full indentation history is retained
across multiple migrations.


> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261025181125.514372-1-atomlin@atomlin.com?part=5

-- 
Aaron Tomlin
