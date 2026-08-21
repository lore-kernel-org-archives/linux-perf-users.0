Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021132.outbound.protection.outlook.com [52.101.95.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFF30C147
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272208; cv=fail; b=CdAOg98VGxA64m8HJ9ir9hieni09CB9J7NvdIg0ttCJOLezcriqdQN/uHpwQFeGWc3sN0pAbueoWHQ7hgu8472pAsk1G0frHFqL8O+FLV6KnkMDbQfbNYDyk1vDkt8Pyv2tQ8bomd+kHGPKSJXaA8jDAA5Avva6jDuYbtkd680Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272208; c=relaxed/simple;
	bh=56KHieiDeJL0/jGy03KCVh0HCqFowjth1XelrKr9YZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jiiHi1giyLIklE3bUk0pVl+XaIk5pO/pDZ+i8TYgUjpfUDSb7brHQLG78UedePLzCro724xvftPuZ9SWlIUey0Mpc2sEt1OvDjw081Jv3wDpnYbGFPKy4MgnIh+U/JNos2aDSpMxBdRYpxdqFcyH81FdkPkGcx88uO0zk1zefSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2KJaHyWvYoVexlwUUl/d4Td7qWVQuR5FTQJd8G2vO1fw3Oq/JMw+c7EQxzyh+UwCwiUOX5SYqLk5X4cbkyJYhTi+boN0xpVsFh3XnX4Uis/S7fpzSJZBc5I2cg443V52bEG5T86iykxHCoAJZ9ShO57bC4MqgLsaJLixT5rRyXrvDkv/Ro8+EfD52mhSOJJ4SVVnXsP+H+l4gs7cgUSnrjvbOD4h9HI7ElzEYIAPn62Rew6g4Wj9rX4nTmJgXGuECLiTV0UZT/XcE3HZwrugQXUmmeeqd4AD+eRecLLo46IlcWKOEJkvp8dKqYj899mMkJ2H9dSv2O3M+hSuofVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=xWtkGw/SAEv8GWwkoH6xUBMyBRJ4hnAnWv2ZdcoOndo=;
 b=BmTVKX4M1XStXx13mP1GO6vFVjGWFgYmU8N6GhCSApL5EzpVUe+i8iHdn1eYneN2q1XCtS/czuFiKCLCG4ekNwtZxpuXib/mbxQl+TlHYVmRhXMOafVMJNu1Wz04W/TT98CQZgJCwGvrGvi1igdtg71NY4+2GiMQfEvQu8Sdopn+ieNJ//LIXKQP3a7ba+xUGZHce99w07d/R4OEpOxXtFJlH515QPEcyBTrwE/V+Nh+YIGRK7/xGg+0WrytEfBeWd81hhL3nWwsuhnxIFSAcuBoinsX+0l0tRoHGJBU7zuBNdGl/q9OrE90IvHJuCkum1EhOKKrj9JUVZlXId4CMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6623.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 00:30:00 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 00:29:59 +0000
Date: Thu, 20 Aug 2026 20:29:55 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v3 2/4] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Message-ID: <up7advlp3fhchjucrtb7tys6bi7zozpyd6mos67en7lytv7qko@k45725jhyrvd>
References: <20260820211100.649142-1-atomlin@atomlin.com>
 <20260820211100.649142-3-atomlin@atomlin.com>
 <20260820212613.504001F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820212613.504001F000E9@smtp.kernel.org>
X-ClientProxiedBy: BN9PR03CA0401.namprd03.prod.outlook.com
 (2603:10b6:408:111::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c173b6-8dcf-4f71-5b81-08deff1b550a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	icGQXSJCQ7ufXo2BdCsoTNjJOeW60sMOO2de6E09bVLhZqlnS4BWOu4tDaTLrZ2A9L6sc9ZgxXziTa4HSUg6lwszib2PNgm961+g/0OOgMDUUBFMzfWyMxACpPeKAJEjKHjQWx9utDT4F7chw0FWcDKWSbXwrBgvC3S0JhQp/RbCXmo90kqrWQS82SVXuI8tXedcvBd3VHhtW7oYI/pESZBDnWDGWE5xJ53cBwB2N7UXOybDvfjz+71bbHo1GrVDctLI3+OUElRLNqIPID079r+s4UEFs14RJgD2SaO5a6mQ2e/pJw+VatDcXBeWIfNUZ2U5wmJt6Q1BOTxHIZh1sR7mCfRC1A7uu2sVC8MZ3Q1/vkUvGU8xpFmVpP+yGeleJFyAAGnM6fiLJGPAdS8X6OJHYpYhXL5oELkbTBpGbNHY6fSX2X0iR7eu166Ib+qWyC3K+1Ef/Q9wDcnTssK35MPHoilnceWjqMgwDT4Zfpxe5vTGT9PBedeOGRc+aQvaw/EfR0j2j8e/a/ZSDa+pDaLiVllGldivcku3sN3+O+Rrr2qxyV3o2bDzFKOFr81ruugQYTcyQDfj+rg7PuxvFPx2Wbl+is93kIDQt0dp8hhSr2y6y0LRP4ZSqD+d/iI3GYYPTXvS3X/2p5cSJ858Bv1zgIHnhD8wxZ/avaqzmdU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1Q4QVVKYmJ0V1k0aW5QSTV3K1g3OUpxdGl1TjQyeTdMaGR0NnZFYXNQVXdv?=
 =?utf-8?B?MlE0LzBPZlRGb0NuVFpSZnlJRjQyTjRGREZmZXpWa0k5UVFIWmwzdisvWExw?=
 =?utf-8?B?UW9HMkNqa1RNUWRJLzkxRElWQlBNb2FGTkZ1elJCK2xxUFNjKzJFRndRdmVL?=
 =?utf-8?B?c1JpZzhSU0hoWTB6Z01OM0lQUHVmbDduZ2dhMURrSU1ZM3ZoRHBGVGwwNU5C?=
 =?utf-8?B?bm4vVzMzZ3oyeFZ5akRJQjlnZldUaEEyN2grY1B4cHBvUGdNQlB1ZVNpaGpl?=
 =?utf-8?B?WTA5TTNLdjU0NlNCSk5Lcm9odGhFcjF0bGRBV050UFFGczNUUWlLbVprak1X?=
 =?utf-8?B?V09Lck1tWVJpR2xydW45QU1DMDBNMGFHYzMxK3NubTVvMjRDL3hjL0ZYL1p6?=
 =?utf-8?B?Z3pIU2pBWThRRk9jbHI3UVJvei9OOE1ZSkM4Wmt1WmtWQS81K0lYYVdKUHZu?=
 =?utf-8?B?VFdJUW1Zbi9UTGw4S1dranNPY1FZdlI2Y3B0WFdBS0l0eGJwTEZBS1BMaDJV?=
 =?utf-8?B?M2s2NEpJejluelR1WGNYdm9BYUMrbExtK2lJdTJIRVhhWGRSck9FWkQxSmZ1?=
 =?utf-8?B?V0dTT016VnNNaVpQd3Y2aDRRMTNNeTE1RWpHZ24vc1BsRHNrNVlIaXIrTVZ5?=
 =?utf-8?B?em1LcGV4QmRzbDVRY2d3aUNZTU9JU2crUTZHM05JbFRYTjNpeEgrMjJIVVZy?=
 =?utf-8?B?N2RsbEY0RUtNVlJsMDRXdzYyd0Fla1E4cnJVdDl6Q2tBN2NMMytKTmFKN3Va?=
 =?utf-8?B?YS9YOC9ySUl0T3d4SWRUaUJtWThmZVNDSXdPZ2FYOW1qWlB6TnJOQ2N6YnJy?=
 =?utf-8?B?NGVQUlR3dlVxd0tsVjhHYzNWbERVcHBOMWkxcHY0NmU4TEQ5MDJJaGRxQWp3?=
 =?utf-8?B?emNUcWpFelFQand3cER5MmpnMDAzYU5nTGdBNzIzbjIveHJmZGhJT2V5Rm5C?=
 =?utf-8?B?dU82VDBUckw3MEo5NEZnNExodEp4V2hZdzlOZFVoZDM4UzZkMHRJdTgxT3lv?=
 =?utf-8?B?UjJEVVVhQ09nTW03RFlIMEM0THJkZS8yZG55SzVXeUh3ZFVYaFNLQjdoS0Z1?=
 =?utf-8?B?T3ZOdGFSWFpNMGU3QTZFTUw4d0t0YzFtL0c0SEVEeXpBMXYzL1FRekNwU2pX?=
 =?utf-8?B?WjhxSFUzeFZVVjZHanZQQmc5dStzNDFhdU11SDhSb2NLeVBKcTZJQ05HVGFJ?=
 =?utf-8?B?MmtsL1BMKzZITFB3MW5WTUlSVnRLbXhnbnhXRDB2OWp3SnRPSDkyNHhmcFds?=
 =?utf-8?B?aXIwRmduUlhITWVvWTR1ZEdoUEY4MW56QStwcGVkVlhGUCt6K3JYYkRGZ3Zq?=
 =?utf-8?B?YmY4TTcvV2Q0RmdHZk1iZG1PMXZsMC9mdVZ6a3huL2ptZDRod2NzWWR4Z3ky?=
 =?utf-8?B?RnpoVzJtK3ZGc2FpS0dFL2hYMFBUWXdEaURVU2g3SlNDT0s1ODk4MGRGYzAz?=
 =?utf-8?B?aGFXSVRKQ3hJVW95dXUwbEF6WEc3VHRkd3JwMDIvRXEwRHJqbisvUG5SZ3JJ?=
 =?utf-8?B?VFJEaDZsUjFjVlJ4bWVGM08wdmNOZ1dacmE0SGtTWnlEL21MTG9QNWxkNXk0?=
 =?utf-8?B?eGNGRGtqeG9XTEp4MG1FVHBTZmEyaW91TnBtbGZZQnB5UGZ4b3dvQlVEWSt1?=
 =?utf-8?B?K3Z0Y0VsMnRqZVNJNHNyQXQwZnkzRjhKZ2xRdzZDZkRnTUNmTEFOcitiVS82?=
 =?utf-8?B?VUZ5SVd5Uk16Z3locjkyeFFOcTA2MTl6bSt0eXRoVGhUUFFjNERNbWtFMUhw?=
 =?utf-8?B?dzJlQjhsMld1WDRxc1hsTnZ6cGlXOXdWNUtxQWl3VXVHdVlSVS8vOFlNTW15?=
 =?utf-8?B?K2ZOVE9ta3dlMURaWlNGNnQrR2x3VHVDcWxEN3Bac0F5UHRCKzJ5RTNIYzdG?=
 =?utf-8?B?RmZBY0RncE1PbXo1Skd4OXdkMlo1b0NHZjJmWlRXbVhUU2RpWUptOU1MbjB0?=
 =?utf-8?B?Qno0eGNuU2Z4NUptSnU2cGs2WTVZSlhaaFhPT0VoSyt1ejRUQWpjd2d0S3R2?=
 =?utf-8?B?bXg4U3N5cWZ1eDVwNE0xMXBjNmRpNTcwUTFSekdtbGhqTG9nSGJIOXRFbzB3?=
 =?utf-8?B?SzdPMjdFOTNQY0tuMVIrUUtmSXVJUGo4R2hzQkdYRW5GTTJzMHB5eEtSdTRz?=
 =?utf-8?B?WmxOeDllbTZ2b0N6UkFTTnFVTUIrNHFKM3I1REQyQ05RTldpY3pONlh6UnY3?=
 =?utf-8?B?UDA1bDU4anBNSGZmblFPZEUxWDRVdU9zVlduUTV5UGszdDFIZE51cFpkb3Ru?=
 =?utf-8?B?MjBzREhtZ2FzdExUbnMyVG1lRWxxK1RKMEdqaHdsa0htUGtZY2tXbERyWUtm?=
 =?utf-8?B?NURwMCtxTU5xT2pmcnpaMm1rUCtQREVVa0FYUTh5M3psek8rTlFTQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c173b6-8dcf-4f71-5b81-08deff1b550a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 00:29:59.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH0o84BkCXZG3o+TBS3SOOwwpiN6xs+gl24eEfBZQMWM4PkLhke7gnf18Fh6bUWgekXt2+quvds77y8gOz93XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6623

On Thu, Aug 20, 2026 at 09:26:12PM +0000, sashiko-bot@kernel.org wrote:
> commit d3017d506b83550526e2692582e2544d0b006d0f
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf trace: Auto-assign kernel symbol beautifier to function pointer fields
> 
> This patch enhances perf trace to automatically format kernel function
> pointer fields using the SCA_KSYM beautifier. It detects these fields
> by type signature or by matching common function pointer and callback
> field names in a lookup table.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 0030489465032..bb8f4fd9ba244 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2096,6 +2096,17 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
> >  }
> >  
> >  static const struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
> > +	{ .name = "action",	.scnprintf = SCA_KSYM, },
> > +	{ .name = "call_site",	.scnprintf = SCA_KSYM, },
> > +	{ .name = "callback",	.scnprintf = SCA_KSYM, },
> > +	{ .name = "caller",	.scnprintf = SCA_KSYM, },
> > +	{ .name = "callsite",	.scnprintf = SCA_KSYM, },
> > +	{ .name = "cb",		.scnprintf = SCA_KSYM, },
> 
> [ ... ]
> 
> > @@ -2230,6 +2220,24 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> >  			if (fmt) {
> >  				arg->scnprintf = fmt->scnprintf;
> >  				arg->strtoul   = fmt->strtoul;
> > +			} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr") ||
> > +				   field_has_hex_fmt(field, len)) {
> > +				arg->scnprintf = SCA_PTR;
> > +			} else if (strcmp(field->type, "pid_t") == 0) {
> > +				arg->scnprintf = SCA_PID;
> > +			} else if (strcmp(field->type, "umode_t") == 0) {
> > +				arg->scnprintf = SCA_MODE_T;
> > +			} else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstr(field->type, "char")) {
> > +				arg->scnprintf = SCA_CHAR_ARRAY;
> > +				arg->nr_entries = field->arraylen;
> 
> [Severity: High]
> Does checking syscall_arg_fmt__find_by_name() earlier in this branch,
> before the type-based checks like string arrays or BTF enums, short-circuit
> those checks for generic field names?
> 
> If a field is named "caller", "action", or "cb" but is actually a dynamic
> string or integer, it seems this early name match will blindly assign
> SCA_KSYM.
> 
> Would this cause strings to be printed as raw kernel addresses by passing a
> userspace perf pointer to SCA_KSYM, permanently obfuscating the trace data?

I agree. This is a valid concern.

To resolve, I will guard the SCA_KSYM assignment in
syscall_arg_fmt__init_array(). Moving forward, a name-based lookup now
assigns SCA_KSYM only if the field is an actual pointer
(TEP_FIELD_IS_POINTER) or a pointer-sized non-array scalar (field->size ==
sizeof(void *) && !(field->flags & TEP_FIELD_IS_ARRAY)). If a field fails
this guard, it falls through to subsequent type checks (i.e.,
SCA_CHAR_ARRAY, BTF enum inspection, SCA_FD, etc.). Non-SCA_KSYM entries in
the lookup table (e.g., "msr" and "vector") continue to pass through
unhindered. This should work.


> [ ... ]
> 
> > @@ -3297,12 +3305,6 @@ static unsigned char bitmap_byte(const unsigned long *mask, int byte_idx)
> >  	return b_val;
> >  }
> >  
> > -static bool trace__field_is_ip(const char *name)
> > -{
> > -	return !strcmp(name, "__probe_ip") ||
> > -	       !strcmp(name, "caller_ip") ||
> > -	       !strcmp(name, "call_site");
> > -}
> 
> [Severity: Medium]
> Since trace__field_is_ip() is removed here, should "caller_ip" have been
> added to the new syscall_arg_fmts__by_name lookup table?
> 
> Because "caller_ip" is typed as unsigned long (not a pointer), lacks "addr"
> in its name, and its TP_printk format strings do not match the strict
> =0x/=%p checks in field_has_hex_fmt(), it evades all heuristics.
> 
> Will this cause kernel instruction pointers like "caller_ip" (used heavily
> in XFS and OCFS2 tracepoints) to be formatted as unreadable base-10 decimal
> integers?

Apologies, "caller_ip" was accidently omitted!

In the next iteration, I have added "caller_ip" to
syscall_arg_fmts__by_name[] in strict alphabetical order to ensure
bsearch() integrity. Furthermore, I have relaxed field_has_hex_fmt() to
tolerate delimiters preceding %p/%# format specifiers, ensuring tracepoint
formats utilising %pS/%ps are properly recognised too.


Kind regards,
-- 
Aaron Tomlin
