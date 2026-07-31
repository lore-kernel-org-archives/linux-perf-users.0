Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020119.outbound.protection.outlook.com [52.101.196.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E92367D3;
	Fri, 31 Jul 2026 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535398; cv=fail; b=CP09qKD41+r0d32WzBJfxKKssGKOgVhsNNlw2gfxtgAxDF6ZAKLR8SaGPEtyan729Mf8MkwAH6DDmwmfxbN2as+8cTPPq6/k91iSdPMSR4KLxd7X+G0WnNBqL43WCFT2w9oC/tdJ0fdBizPdH9syTQXKZPRB2sDd7ws+Fp8jAls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535398; c=relaxed/simple;
	bh=ufSXLKcE/e1qn4D83do7uDcVE5S2d5luCDDxn8HMkP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bZUywA45XqJ8O9b5Wp4gBVWdTknHGgCGKMfco76WYkumbq4HbpxruTccDRuouETvdBnAaj7Lq/PnZnYocbaVaWlEGpT89i+0moFjw752GCxiAmDoFTohxc1zwSfzy5VfgiOxoRTNFb2k0+0Li9r/dQT8pzi5rTTg7EoHWhAi6lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTOKxm5K+LnUYZDmtUnexoPd33rcyRFThRA8ZbjxnFTlPisAsAopJ7r+GkOTxFiWusJW+xnOQD3aa2OwzBgktsJeTzcbHy9Rb4dOl/tsRPQk69yJD89kZu3qPeWMPHsnYkSUpU8lQWtICkjx7GKj5WLwwZ7pKFeZ8Z7EuzsFgPfzhlJkheWtj9Ip+bMoWtNHKxNhsWfAmKjARl24HWioZ0MM7MfGsNUx2yoDvo6Eu6Z55AnX2eopa7EDTrxFsWeD2YTttzEHYUFTkKj3hKVQe5luHyRbKCeWfOS9qdTQZfLBXOYgV7cl4+ns2JRFG0B+f238wW/W/McvdmCkPqsn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=6hn9MYzol3kNmOI6kHioindGf9hOhgpZWeAyfeanjsU=;
 b=nbWjKqZpEoAooqH2uLAEvhE4cQkLIJrTv2rbSPRDcB7xME/U5SFdzcGu6JLdwB89IbOogULy7n2W/J8WlMuj7wUF4LpwMb8ytUVH26qJUFfewFQt5Nm58j+aRbPNVQRtz1Dgo05f06MvgdeqSqKh6hcnCul5Yt2kWVM+rqVQ/YrLUS7rlh4wGnJjtaKYTkOB/hnjHQzoI3bpWEvgdsShjrzh76zwYdb8rYpTwvuxJLmSwkK6dKSOUOSL09UNFfSPAkk5J38UkEaYZG/G5yWe2CdWEby8DTH4Jv3+VE67owOOPQSheEA/+4DeMwaEgn49GmRROxEdLLzYuUHrMbDyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2954.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Fri, 31 Jul
 2026 22:03:14 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 22:03:14 +0000
Date: Fri, 31 Jul 2026 18:03:09 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] perf sched: Suppress latency table output when
 trace samples are missing
Message-ID: <oeakz5jwrbmv6jtdvuu7rzlvxqv4rxofkhddpk2zvtytsej6xl@evqek2jgr2u7>
References: <20260730185416.97166-1-atomlin@atomlin.com>
 <20260730185416.97166-2-atomlin@atomlin.com>
 <am0auzlYObfEmwCe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <am0auzlYObfEmwCe@google.com>
X-ClientProxiedBy: CH0PR03CA0411.namprd03.prod.outlook.com
 (2603:10b6:610:11b::27) To LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2b2::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abd3ac3-7679-4178-9a4c-08deef4f84bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|4143699003|56012099006|5023799004|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gF8vSlWq5+t75n80mg5UtHyDw833rQ2SHO9Z+iZaTqzzzpu+m+SK4lCZhdakM3s+04nzOMqqKQjXjZ0XJXIOMvJN6ohSv1FQ3dMRtYxnayZylVM/FtkonWt+7SszOqorwqH33qvVD+vBTcAIxCAQWZiWGYRn8ho4tYVtPCf/K94+IPbC/ghYXNgwQFofg4MnSi7vOalCHK8t2Ny9bC3sCR8CDvICAvTrI8SeYWHTfiaHD7AOTeAbgWU8dQcYeTxQhxqm2bo+Dr1h3nXqV8LyoYrc3VOJmm1xy//F3QYpGX6QhmhbhcbWgVvmJDD+mA4n+jT4AULAcFSDdU2LOBvC7gcN6SZFutaeKvlmmRNZ60JDaA1Ph5ohcEyfCkESTxCcLRgE2oFRkBy7DOhfh1bIFFs0acGuqC/A9uHs+UrxhJhtJfOCH5dAsSIKgO8Smkkf3H3exEtMeO79spTv9CqPtqAz77HndkOiK+hpJHHQFJToi+enEn5LMDsScyPogkHKkdY+2u714baZYYheZ8+XFICUutzaEEpHQswVbftpaN+jhs+SLGMG7aVb7ksBlNREJ6mmV97sl0Y0Dvl6K2Dh/IoDxZa+ZOP1SxxA3zj/iv7oqsgiExzabxMIiUn1C8Oo3aZk4HfPqkVhU/PGp+oLOuy4Y6la64OqJkzDOsYDtTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(5023799004)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTRjUFgrU1RSQlhxNlJqM1Q3SWdSNVFhNXBaL0E4d20vVFhxVG5NQWk1aVNa?=
 =?utf-8?B?Wk8xQUEwTGRrSDE0cElzUFUxZGNJL29oT3FDVzl2cmxGdjhJZ1RETkJncWdP?=
 =?utf-8?B?RHRWMUtqNGdzNldCOGpIOVNhMXBVRk9hQ05QRlBpeHBNWklsZVV1ekJZZlZ2?=
 =?utf-8?B?THAxbnNIYVpqbjVtMzQreUQ4bjFJMmd4a080SDBtekFPMk1kTkJqdm0rR1ZE?=
 =?utf-8?B?LzZZYmJyY2ZwaWREM05Qd3haMEhwODNvek5BcmhxUXlmMXE3NDhjN29lTGhJ?=
 =?utf-8?B?VVMzdTZsQ3RnMndNUXFkM0xkbldUZFlUQ0FXcmZaN01CeC9BOE1xKzBkYi9m?=
 =?utf-8?B?dm5GbURpWG9ML0xvWm5JUHV6ODNvazIybGRoMFQ0WHZ4S3Q5Vmt3Mi9VUnc5?=
 =?utf-8?B?WHVaY0kwdnpLUlNYMGlsVU9USmVzYmIwNDhPb1dlblVPMDkvcWlGVlNVSEE2?=
 =?utf-8?B?S1E4Y1UxazdCMkp4MVMzdTk4SndaaDVONDFjTTdTVTN1TElCSTBhdnBvZkpO?=
 =?utf-8?B?R2lNaG8vTzBienBzTkFzWGFNSjNlRktKNis4MDNDUUdpM0ZYTkZHRXBENnQz?=
 =?utf-8?B?c0cvZ3NvbkNndGo5SnFLbEdqamtkUXB5a0VnZzFTVlI5cjRuZ1FPNThITjdr?=
 =?utf-8?B?YWtNazhQRHhuMzVxVzlEWHAxL2QxYUVzVU1zejFVYTcyUW1wZ0x0c2cyUzlL?=
 =?utf-8?B?NytsRTBJOFhXUGYwa0NzRWdvdVBJcDNXOU1IcFc3NituNUJPb0YvRWtSa212?=
 =?utf-8?B?RlRnenoyNjdJMEZjYVVYU24zRGJzMyt4VmdzR1JJSlUvQW9CVXMzbGxoU3g5?=
 =?utf-8?B?WFcwcG1oY2ZiT3k0TXc0bVNRcFdIdG01c3RVamx3Mzc3VWFoMnFHUzFEMW9H?=
 =?utf-8?B?bU5xUkExRi9ZTFAxUEZpcUZncHZxb3dHL0VpRkt0cW16VjVabU4rcnUvMUFk?=
 =?utf-8?B?MnJ6eUlqUGwrSzNYWXEwSnlOL1NLQk9TZUgydTg2S0YvbjN5Ull4UnpyR1Fz?=
 =?utf-8?B?cVpwQWp0N0UwWGJGN1FHWE9LREdBZmEzVnduMDl0cEtkMUtXa1BzaVBTQk9p?=
 =?utf-8?B?OUxDYVBIdHM4TzZPNlEzajd6Y3ZId0p2dGM0S3lHQm9Nb20yRGdkN1VHRlFG?=
 =?utf-8?B?YUVvdytHdm9tdG9TWWpENUl4L2hFaENoSVNpNFB5K2Q0SW1na2U2ZVp0YUE1?=
 =?utf-8?B?MXdRaDdFOGMrTG0vZkxIV3BrOVhVZXBQSzdzQTNjMWE4TE0zbU9RcVY5cUNW?=
 =?utf-8?B?WUw2bmJYUVlldmYvT2Z0TzhCZTFyaEdRaGZ0Q0kzUTJlelpwY1FkUHZ5ZHQ3?=
 =?utf-8?B?OTJWRmdFS0UyZUJyaUFzcU1EeFVNMEpVbSszbXhFTmRWdC9seTBCdXVoSkN2?=
 =?utf-8?B?ODhSaFZIeWdneEZlWEMwMTBvaGNTOUZuTVBJdEV1cDhPVkpFd0NhckJJbGFB?=
 =?utf-8?B?WWtoVG8rdVVQaHJGektOdU4rYlZHekk0OHVUOUZDU1cxNUZyQlhIQ3hBNmpS?=
 =?utf-8?B?dWxIR2dHc0o4a2greGlaZHg4OXMwRTJKNWNVRlBQZFIwUkhQL28xZ1ZCM1lN?=
 =?utf-8?B?Ulp0bENWeDJyOHZrYmJGQ0VORjl6T3MvOHRubnJ6cnNRb1B4RTJFd2l2L3dO?=
 =?utf-8?B?cGtLOUxaTWp3TjloWVlNSW5oQ0tKelg3K2F3M0d1YnNYekpmdzZRT3l6dG1u?=
 =?utf-8?B?VEdpdDVkQ0NjclFCOS95Qkt6cGEwNklZczdOeThsY1djMFp4NHo3Y0RYdGs2?=
 =?utf-8?B?T0tkWnlGL1dtY3hZdlBqWE8wdGhDRlNTWUFTMU5POUZhSXJCUzYyd2tXZHMw?=
 =?utf-8?B?NEpxZkhMUUtuVWQ1bWxMMlFCT2d2Qmh5YncvSm4zYmhXTjgxL2tOeFVrY2hR?=
 =?utf-8?B?VHRta1lnY1FKdVhQRFlzYkVYR0RkWlBPNUFucXhybVluWTVEUExZWGRnRDcx?=
 =?utf-8?B?TnpvRFAvZEV4cTZRL1FmOEZUVjRrM0Z2OGxRNjRuRWozM2JibXRZMFpuMG9H?=
 =?utf-8?B?YWllU2tPc2ZMTEdSMlFOSGdIMjVrZ3AyL2lwajBwLzgrRVZSaFJ2Q2tMV2Zk?=
 =?utf-8?B?aHhya0FRZDNWYkFIeTJmUkVPRGJsdHVkNXBpQmk0bEhOMlhqYUNHenFNaUhq?=
 =?utf-8?B?aldCZHQxb2t4eGh4eFBBeDZQV05ydjdJUEpKS3JBOTA0M2ZoV0xzSnlLU0E5?=
 =?utf-8?B?UWpyeDJaanU4RHVxa3hmalFMNFNyOWNYcS9yR3dSWGRhSFMyNGd3Q213T2Yy?=
 =?utf-8?B?KzRmdkRMSWhpazIxY2gyRms0SVh5VGl6bGZuQkJCb1E2dnhIRVp2K1hsWDRY?=
 =?utf-8?B?QWJ0VElaQmtRU2E4bjhnVndydFNldTczUGNjenk3ZGdjZDh4TGxRdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abd3ac3-7679-4178-9a4c-08deef4f84bb
X-MS-Exchange-CrossTenant-AuthSource: LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 22:03:14.5318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/2CwwVmPMn3DG9a7N8LyKb5aa8TvKf1IRIiZ2hXQ33r+jV/FU/tFLx9oZ6seYZIkcIQnD8e45BFzhx8sWNMFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2954

On Fri, Jul 31, 2026 at 02:59:23PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Jul 30, 2026 at 02:54:14PM -0400, Aaron Tomlin wrote:
> > When 'perf sched latency' is executed on a perf.data file that lacks
> > tracepoint samples (i.e., a file recorded without the -R flag or
> > containing only non-tracepoint events), perf_session__has_traces()
> > correctly outputs an error message. However, perf_sched__read_events()
> > subsequently falls through and returns 0 (success).
> > 
> > Consequently, caller functions such as perf_sched__lat() assume event
> > processing succeeded and proceed to render empty latency header tables
> > and total summary statistics.
> > 
> > Fix this behaviour by ensuring perf_sched__read_events() aborts early and
> > returns a suitable error code when perf_session__has_traces() evaluates
> > to false.
> > 
> > For pipe mode streams, event attributes are received dynamically during
> > event processing, meaning session->evlist is not populated prior to
> > perf_session__process_events(). To handle pipe input correctly:
> >   - Register the missing .attr, .tracing_data, .build_id, and .feature
> >     callbacks in cmd_sched()
> > 
> >   - Promote the handlers array to file-scope (latency_handlers[]) and
> >     invoke evlist__set_tracepoints_handlers() dynamically inside
> >     perf_sched__process_tracepoint_sample() when evsel->handler is NULL
> > 
> >   - Perform the trace check post-processing when handling pipe data
> 
> Can you please split the pipe mode changes into a separate commit?
> 
> > 
> > Additionally, validate thread__get_runtime() against NULL in
> > map_switch_event() to prevent potential null-pointer dereferences.
> 
> This is small enough to be squashed.

Hi Namhyung,

Absolutely, will do.

Kind regards,
-- 
Aaron Tomlin
