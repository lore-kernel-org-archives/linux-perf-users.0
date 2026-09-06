Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022073.outbound.protection.outlook.com [52.101.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473617B425
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658355; cv=fail; b=Nx1OPfv1Dw6vzp4Naxwosd9zMKjEIAKUN8K6uV2n+OeZAXZ9L1h36noBT2dw4taV/BF255QOjcKAEZ1UfWLbiYD4ITbXSga1bjkg4TMxj6yTs+szug44qkVBZ/30mTzczgLPgy7VIYMvknmWh1WVbI4pRKLv5lEyTPlGtLASeTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658355; c=relaxed/simple;
	bh=On36y0nbCaExL6IOj/lNlmEhL8Ixde8hMeImH6VTON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LHtcvbQtrTeTDxaEfaHDp99mYnkCbqu0SRpB7Xz67nXD4l9v0FcQlJzSqYXi+Gp8PedzTmuzcg0kIQ48QMN+pcP8Fx5PRA7Y/t0VcFJGieBC6y8FDuF0JLmCP+DfLixYUNddT61hAd3tT1hY924Qpv0xIMPH2nx0cYZZz4Iq6T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+PI12QpU2WqZ2iIAHVgobK5Ogpn9mfySxJ9SaiiSpMmoS7SYnRm7HGfDBGdF6je3X4lODLeoIIxOnGXtDc/g8ilrx8pBUsCdCis6YFud7N6/JecO9vLfjKtDkEDQMeEDbL8a74gR/p+ks8bL7FHcGbZY5TsEKmA3pNbrO7bVNAzYYn6dVJW+S3wR+w9t+ZteoiqTSm7HoP1M2GqvtMrKwScZcTZJbJ74NTmXR+r2JY0pMcEEHHMoirD6UvmYZ/nCoFIrHag7bZQ1oGJuODs316V+TMLXk7/e47HHNHEvpcZU0EIvkJvMdXuheTlx4blvMnrOlVkdIJfjPKzX8jHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=XXOM2qG69VQiobCvwVd5IY1PkqLA+y9iPjOQefoSZ68=;
 b=YFYY6lJnaPkZokaWjye4qDB/SRqYqp8FHFe2ycFxhGrxTqbCr2gl2BnjBj9ukUR+lpJWcnTgaTsSP5i8Gm/UWxCj8F/P7Ju2XZ5G5mGp/hAxKl5pYy3qOCSdyOeuLBp+TbwQ+uUSeO4wiHaVSyh7ixmfbmW5dxkCtDlkgnhOw1sZN3OM086p9wjF4ZkSfsKFBlUwcjaBtO8Kb73MzQiBN7SPakeBEL/EnweutgJaVm5vmTVPMqRKYDtkNtIlYWIzJm8SKAqn0w3hlCS2VeU6wxj/ZUhDZTuY/d+bepFu0egx74eFCIR2MIozkGL6ufjFr1L9MIH4kCquO6Bf3riXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3036.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 01:32:30 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 01:32:30 +0000
Date: Sat, 5 Sep 2026 21:32:27 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next] perf trace: Add upper bound checks for
 augmented BTF struct printing
Message-ID: <qvftc7cs32spanwvoyh6mgn67tlsuoa76kkgvkt5uaabocw2ry@ohd4ctv5ulyx>
References: <20260906011132.279321-1-atomlin@atomlin.com>
 <20260906012359.19E5A1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260906012359.19E5A1F00A3A@smtp.kernel.org>
X-ClientProxiedBy: BN9PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:408:fd::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9beefee4-a9c9-41d2-cedd-08df0bb6b78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|5023799004|4143699003|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Zoy7zfHguz94N5jAqKZ29tISS4Wh8ahsiTb4HOYN945P8JzvbDWFn/yu6JPEJ0Fwj+RXo3r5T2VrNgXObFDgbgEMT4Ca9L5y0ZvN9KPdyDi76CZSU/WtIYI9KB79z3JeDtVCmmUV/c3HWL6JlFfTXOkoHHJ+HMvPgsviAsqYv033pvO1pfEXyN25pbP/ATw9mQ+xhCjUYAiCONiNxLlgSYKEOciry0svW8ZowO9a88rEdM6PvU12Zo8K/Sj0YPQNzXi3UfmlOs5VlovinbXP9NS0O/y+xLDPHscW4WEqLt/gf8MSKIQyLyA+oH8EjMNZ8WzP2vCO3Ayp8b7SPcsyGsogQfZ607KKzujpmb1aRRGV6LLnUYu2K4i9c029fnVI0hBTqDOBMjqTisOHtvHo6heieIb/y0ZuX+Rs7WaqSiMU8NI9uN9Gd5JlYEoc8uHSVdG8nBrO/19TH6Szo1Xf9TnCsdNhVCSzJjheqwJ0qFz/mrdTSWYCDk9+3LETzmzc9wQCbfJqVHQvVLc5OigMIDhjIvXtUgR+18BcqpCSLBwGo8xvqAGZIXRcOr5T3nNCk6g+cFp35C//Y6bUJ+AC3dFZhbOUASOaHskfEhEwI4c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(5023799004)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHNrUUdZUUczU3NYMUNtajNOTkc5Z2c3SWhqU2hnaXZlL24wUjhOS3pSZHE0?=
 =?utf-8?B?WHJSSXlWbXZHQlpsdDlCREhHRUtnb1Vzd2Q0NWY0VFZ3VVpUQ1dBL3M5U21F?=
 =?utf-8?B?ZmZaQW9aTUtTZE55d2l2Qkx5d0tYT2U0b24zaW9mcmNYby9IU1BwejNnTDdO?=
 =?utf-8?B?QmFRQmxSQ2JiSWpES2VuR1ltTkRWS1RmZUFVZnZyRU9tNm1iczRaakV4V0Uy?=
 =?utf-8?B?bGgyczk2T1lzWWg5ek1WcmN5WjY3andKZVlEVWczbElsSU9CMXRySlZRdlNv?=
 =?utf-8?B?cDBaaGdJcmR6SFg1WDArVlp3L2VYaDA0TmlERVBoVUdkZ3ZUQU9MWlFsMkx4?=
 =?utf-8?B?QTUxRWYzMEx5L1h4MWYrTXlwVXFwNFFpZnlhVlIyT1FFSnI1SkNpKytsN29F?=
 =?utf-8?B?T3lGV0xkNEpDaTk1ZWFvVExlYmd2azFsZnZ2NFQzVkY2eFNTMGF0RG94LzNk?=
 =?utf-8?B?bzBCdWJrSzdRWXBHOWtxSEozTlBpTnpUakowdlRoaG1vZVR4czNQZ0llOXpF?=
 =?utf-8?B?WVBuc3l3Mi9NOTQ4WTJmb2QwK1pQYk82eXc0a1REQlZHVkVGS3FZZVc4RDFi?=
 =?utf-8?B?Vnd1eEhYVEFpRGlQOVFGRnVvNkRxMkJlN1U0cjFQVmpqQzMyWCtrTE0zc2Zh?=
 =?utf-8?B?Vy8yeUlNSWwvdzN6ekdpTDFYb3JudnprNWRGWXZRdWJJc2ZLVVhUUjhtbncz?=
 =?utf-8?B?VW1EOFR3S1RZSUFyc1ZBRGhWUGZKQUVUVVlHa0orZ29XSS9VR1FOWmtKQXFU?=
 =?utf-8?B?U2NTaFJwaWZoYjhTZGt2Ulk3aVlnUUtMQkl3L1Z6Q3l6bVZEMEJ2dlc3MzU2?=
 =?utf-8?B?b3FFdVFjNzI3UmdiMm1BRkdaUElHZ2YrdG1TS1B0Z1FqSFBGdG5yNzRyb0tr?=
 =?utf-8?B?SDBSQjc0a3hDWXNxSFdldDdlWFBrcDIxUmhnbnVKbGdySVE2ZXJMYTNRL3h2?=
 =?utf-8?B?Q0ovNm9kaFozaXlHYVF1UmdEV3BkOUg1VmRpczlQOU9IZy8ydHhNVXdzTkFx?=
 =?utf-8?B?S3ppR1IzV3F1TU9rcnBzejZkdUVHRWNsYm9GMG9VYWlSdmtVdkt6R1RCcTNu?=
 =?utf-8?B?d3JBalF3SVRnWlpJMlV4dlJ5d3dBYkJ2cm9hR25NZ2pYOERZVUVOeE4wY1Js?=
 =?utf-8?B?UkMwNnNPNUNYM0hEL210bm1lMk9vTmx4K1l2OUpoVitZVXdKUy95VFVtYUVR?=
 =?utf-8?B?Q0ZPWnkzM2NCWm55ejdsOFIxNWJ5SXhMUkRTSksvRHByTnU0b0xoUUhTMEd4?=
 =?utf-8?B?NVhZamQydUJqd0J5M0I1dnF2VXZ5YzNzRWY4NURuMmJiTmpoR2tlYTZ3Q0RM?=
 =?utf-8?B?OUg2YzlWT2g5aTMvWnZMVjJhcTNFanBXVlZ3bTRSZUMvZitwL1JESEZZRmg5?=
 =?utf-8?B?ZHZVNmhtYVBHWGVZMlVmeUdJajdlQnFia3NONUNocnhjblllMGtsVmMzTUdx?=
 =?utf-8?B?UmR2QXIyNjhGME92UCtwSzJvdDVyL3hxWFJSdjV6c0ZjNTc0N2xxZlBpUmlN?=
 =?utf-8?B?UldacW5uZmVhSkZxa2lKN2NEelByZXNncHB4aU1iQTdMZzFEekVRZjM2MDRl?=
 =?utf-8?B?T2tVaTUxWTk0QURpbE1XRHBLR2F6VCtaSFhIMGtkVm9rRXRQb252ZGFMbnRr?=
 =?utf-8?B?T0JaQnBDbmhMVVFkQVhoU0RqZTVMRWdCdVRoSkxLYS94czBDK3BhelFzeWRl?=
 =?utf-8?B?TkExdk9oblgvWEV2QzNxdFBKRkwxUGhKWFl3N3IvWkZCbDZNa1c0OVB5SEhz?=
 =?utf-8?B?d0F2YXloNkdVTEd0MXZRZ2NuTDB5eEdXeGprZlYzdEllTTZzRm5zZ1lKc1g5?=
 =?utf-8?B?Ums1SWdjOXBFdWZwODBYYnJ4ZlEyT2lKc002YzM0ai9iODFQYTR5Z3ltRUkz?=
 =?utf-8?B?VGhXQ010Mk9BR1FYTHlEdlZ6WG1ZbDJ3TXRCVk02NVZyMzY4SFlwdDhydVlQ?=
 =?utf-8?B?UHg5RlNPNUNvSkJ4V0Q2SVVwZG9CblBZcE5WNVVBSXJIUmV5S040aFNOME51?=
 =?utf-8?B?RHZWNFYzeXZXcStJSm9PUmIxa0pwRUxPUmpEV0xIbUc4QnNlQ1ZmVk1OcFBL?=
 =?utf-8?B?cVRpVTAwM2pmVWxrQkdsZEIwTndaZUpoRWs4bDF4aWt3WlVlWWhmZkpjaFAy?=
 =?utf-8?B?eFZtMVFmZHA0VDdOeXRHbno5MXBXeWNUOU1ra0czTk9CbndqQS9FOTJXcERs?=
 =?utf-8?B?Yjk2bUxuUmdzYlIzQ0tOWlFjSXhEL0l2a3B6TGt1NHI1MUFkT09rK1F4SmVr?=
 =?utf-8?B?SVo4czVjVklydUpLQWNSeTZ0MzFKRU9oMnJYZ2l6bEdrcEdvcisrOS85ZDA2?=
 =?utf-8?B?MjIxRkhkK3dHWmE3Mk1MbEMwNDMvN1UwUlFHdzZ1Q3p4dXR1TFkvQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9beefee4-a9c9-41d2-cedd-08df0bb6b78f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 01:32:30.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDXfoQouDCOx09KMySeUobXJ6ODjid7ZfRiIHl73UR7mwF+WXuiHqe6J/2F73mHnDjjr/AbDQl0wwegONP4ing==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3036

On Sun, Sep 06, 2026 at 01:23:58AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch adds bounds checking to `btf_struct_scnprintf` to prevent buffer over-reads and integer overflows from untrusted `perf.data` files, but identical vulnerabilities remain unfixed in several other augmented argument formatters.
> --
> 
> commit 292e31352e85e8bac1a8cec2bc218077f4783d42
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf trace: Add upper bound checks for augmented BTF struct printing
> 
> This commit adds bounds checking to btf_struct_scnprintf() when
> pretty-printing augmented struct payloads. It prevents buffer over-reads and
> integer overflow when parsing untrusted perf.data files.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index be19d70eba092..20fffc24507b5 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1133,12 +1133,13 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
> >  	LIBBPF_OPTS(btf_dump_opts, dump_opts);
> >  	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
> >  
> > -	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size <= 0 ||
> > +	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size < (int)sizeof(*augmented_arg) ||
> >  	    arg->fmt == NULL || !arg->fmt->from_user)
> >  		return 0;
> >  
> >  	augmented_arg = arg->augmented.args;
> > -	if (augmented_arg->size <= 0)
> > +	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg) ||
> > +	    (size_t)augmented_arg->size < type->size)
> >  		return 0;
> 
> [Severity: High]
> This is a pre-existing issue, but while this change correctly adds bounds
> checking to prevent buffer over-reads and integer overflows in
> btf_struct_scnprintf(), identical vulnerabilities remain unfixed in several
> other augmented argument formatters.
> 
> When a crafted perf.data file provides an artificially large
> augmented_arg->size or a truncated payload buffer, could the following
> formatters still be vulnerable to out-of-bounds reads or state corruption?
> 
> In tools/perf/builtin-trace.c:
> syscall_arg__scnprintf_augmented_string():
>     size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size,
>                                augmented_arg->value);
>     int consumed = sizeof(*augmented_arg) + augmented_arg->size;
> 
> This lacks validation that arg->augmented.size is >= sizeof(*augmented_arg),
> fails to bound augmented_arg->size against the remaining payload buffer, and
> performs a pointer advance calculation that can overflow and corrupt parsing
> state.
> 
> In tools/perf/builtin-trace.c:
> syscall_arg__scnprintf_buf():
>     for (int j = 0; j < augmented_arg->size; ++j) {
> 
> This unconditionally iterates up to augmented_arg->size without bounds
> checking against the remaining payload buffer arg->augmented.size, leading to
> buffer over-reads.
> 
> In tools/perf/trace/beauty/perf_event_open.c:
> syscall_arg__scnprintf_augmented_perf_event_attr():
>     struct perf_event_attr *attr = (void *)arg->augmented.args->value;
> 
> This fails to ensure arg->augmented.size is large enough to contain the
> perf_event_attr struct before casting and reading from it.
> 
> In tools/perf/trace/beauty/sockaddr.c:
> syscall_arg__scnprintf_augmented_sockaddr():
>     struct sockaddr *sa = (struct sockaddr *)&arg->augmented.args->value;
> 
> This reads fields like sa->sa_family without any payload size validation,
> leading to potential out-of-bounds reads.
> 
> In tools/perf/trace/beauty/timespec.c:
> syscall_arg__scnprintf_augmented_timespec():
>     struct timespec *ts = (struct timespec *)arg->augmented.args->value;
> 
> This dereferences struct fields without verifying that the payload contains at
> least sizeof(struct timespec) bytes.
> 
> Would it make sense to update these other formatters to include the same
> bounds checking being added here?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260906011132.279321-1-atomlin@atomlin.com?part=1

Acknowledged.

Kind regards,
-- 
Aaron Tomlin
