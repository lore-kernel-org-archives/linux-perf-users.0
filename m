Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020131.outbound.protection.outlook.com [52.101.196.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE5493635
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787429834; cv=fail; b=XJKOLQiJxQswpxKCz+OLJHOa2NC9QuleC58QzTbj1k3yUyLVuYio5HU2HFQslPjDVJwIMr+xej3bHKyINIwmyNQE18NvrSgMchcF4Y+ajTz9Seo4eCVMvs2ON4Yqu2A/BmGfNV/7PITelEH8qxX7dQvcK/Xy7YyEfUbaWhrHuks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787429834; c=relaxed/simple;
	bh=wlkuBX6ZV/TS1dc1sSC95HXFLIIrxcUvJgENL+HBq2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lxi2BQVoAPZo+yv7VvcjGam/obA5cLzWv3/ew+AkBNaHRxljFzicZhqZzx9DTUJIxIoJFBk5KSm9GG+MeWVELnBhZCMKVTVGiiIhCP5J64JG0QF9TvXxT9L5s6+eV7lSgm542gYZZyuq3nk4Q+ihH1Fi27AENCflBoUZFneRAd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPdCCjaUKNvJnbtuHnadhelOhzwAfuWk8WwZf4ClPrePiM4G9SRKF8dmgcoRjW9IcKhenfN8x7+f3UEcir4KmUwT7L+x7FJuAhR615X8b/cFC+6YQRvI+vgTFVutp6aitaId1fPDpRVipy6Rv3YSEfRw+61+GOF/vjd2/Ka2oUk0W9mNv1SBIYnkzXQBd6ub3z0r3QcJ4HH0lxgf5fDn6PYTD0OtpWyuYD/7x9i3xJVxj9vudmhyPNBpWt4MO2w6x8Gjmv3QpRqUwq+XyoItrdgKp+gm99UM72Kmhw0XsRlw4nlVq2kidW0YVyVVmzuSDEcZITahFKXy2joCjj/kEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=u1hRqDGbmKlL1mO/7Fl3YLCvrghbdX244DT6fHKdTuY=;
 b=BGn/dJTcpo2hbMISnkG6tEpXb1rsiUAN2gGMPXA+6ehiv2L8dEldyn61LdG7HvXz+E76JqJ1xk7VCnCoY0pga5V3w+3+DLutVYCGm7GolR03EFfbSYV4N8ntzC4id5G7lAFq2H9tlAlDMPubq8CaU8dq0HKUhLk5d9n9RRSYHCSCtNerJL1HiTJ7dFa6pMluVQynjptGmJzGgAWNA1sqo8UJEA3maIIthBqtBxh7E8v19449C+WDOH5PL603/7ZqXt1zFJvmSRJEypZVx+zP3lJRH4yjmxzLkBZI9q4tO3giYWHeGqX4Mo/7tbnUSFG7uCBFbUV8nBLGXLjW5SVKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 20:17:08 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 20:17:08 +0000
Date: Sat, 22 Aug 2026 16:17:06 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev, namhyung@kernel.org, 
	irogers@google.com, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v4 2/4] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Message-ID: <crqu46e3c2qjfnopwhbdw5fhn7uojnx7ejuj3aajjxfa7t2mmr@5fatg5toernm>
References: <20260821204930.679027-1-atomlin@atomlin.com>
 <20260821204930.679027-3-atomlin@atomlin.com>
 <20260821205814.60DD61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821205814.60DD61F000E9@smtp.kernel.org>
X-ClientProxiedBy: LO4P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::6) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac96da8-767c-4efa-6e89-08df008a573e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|4143699003|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	tni4xO15Gwd1KREEepbp5EP5TpjWlsu7Ai9cDxkvjUEcUkpcu1MjHIRUw++WSn+63tgKPYw5LAY60kNGC39ll9Q8x4T2ORZ2y2j7m/IFpDAfv6Uw9l7W7OrD1ptCZPWJNOFnn85359v70EOuv0Ad4ZVgzmSAcFGySN80RFZ/DR/ZFJ66Okngwq91R+XkDA7Cg98icWwc2B96W/t6D7qECJxpoy4+V3U1eUm04bFZ4Fg3wyk9VrohIBDEWr9dLy6UoZF11BD5PNLpXLiqQ7gXc4qS/BK1O4tURsh1h0z8MK7RXNqvhc+eLYKufnAxZDcJ7hBQEFuxKHWlft3vrv5kl+v6KhvYU6jb3orqwLerY4fhPSNj/s6k4HklPrgIaccMYlKOHcU+YWR5EZ4Bzfi5iWWrX/AV961ZYQikLDIlRIDgoEcJe2SHvtWEtwFfa5/pWfYaRDV3Y9dlnrwMYlXMG5Bhp+idRToUk07VrHgK6kFaXIH3pjsTLicDKhS718sH6rgEEPT3gp5Qg+8bC3z88vkGVsFd6zmMRMSkHEarCfS5b4QeKn6z5yRMMvb2WuZg6e+WwnuXclsnku4UIWEjJyGbMFI8u7GR0fKBdI4uUAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG9tVWo3Q1NxcWJldjhnb3o4NWxjeXg0YWd5YTlaWWZWQ25xVE1iV1Awd25x?=
 =?utf-8?B?UzVEbkg2QmtoZkhPYWxiR1hIZFczT0pRRXl5MldQdjlLK2U3cGFpSDlSUU83?=
 =?utf-8?B?L3VGTUJBcjVjRUNpNnlFNWIrNFNYV3hZKzZWMHBXK21XdVluSWVBWXdhdDg4?=
 =?utf-8?B?SVZCN28wdUYvYVNjMVlobWJTVDJ5R3pVMjZwVnpKU2ZDZnBZNnIrRDlRU3pG?=
 =?utf-8?B?Y01xMTBQdDBsSmJmZmRqMVpjQ3FKQ00xbURsbG02WU5mTzJqYUNRUXJ6d3pQ?=
 =?utf-8?B?TUJMbCtSTTQxdXNpM2gvV3NKWmpRdjJnK2MyWnhOa0hMN0pKNkR3ZXN0T2Fk?=
 =?utf-8?B?ZEgrTFdqdEtkbjBPNGNWZWtHalhTR3p6RURhM3JTSkl4eWMwanl6YTVKTjlx?=
 =?utf-8?B?UzdueVJDNEdTUHowRUFvdE9QK3hobkcvVW94NzdLdGdQekMwcXkxMUtIM0hX?=
 =?utf-8?B?ZXRwQkFHUjRpMG5LWmdrSnN3MFhMYldLUXozQjN4d2FseUZhZWUzYkFzRk43?=
 =?utf-8?B?MC85T3BEVUVYbXFkWkdnNmlvZEFlTXU0Kyt6dC9iNEZZcVl0ajQ0QkRQRDBW?=
 =?utf-8?B?TEgvbmtPZ05yMTdPejF1Y1FvcDhJcFlFbGhLVWtVaUhXOHQ2cEFWUy90Qk5O?=
 =?utf-8?B?cURnQ2M1MmhzMnFFOGF4cHZlUXIwc1BUUUg1dkNDQUJhd1NZRXUxQXVINm12?=
 =?utf-8?B?S1pvMXRGOWdxSENDdFBGSTQ2VVowbU9FVmNwVUtyTHZyYVdNY1BRTzlwOGFV?=
 =?utf-8?B?UmpEcTBjYnQyU1ZFK2pZemc2cUM2bGQ3alJZdGZEblg1RXpaQjlIZFArV3dG?=
 =?utf-8?B?RWpweGRqK2JYbldXSU9meHkzWTNHQTJCNjZYTDVrWHpMQ0J0VzRIMHlKNVJm?=
 =?utf-8?B?VC9rNTJWdDNKQlZxZFRCU2xVUUNDQnpZdkgxSmZNU1pxckxNZjlVMElLdFdi?=
 =?utf-8?B?clBFTFcxVjNwcElxaHExZmVkOW9KU0k5cHgwenRxVitaYWVvdjRCZEJVU0F0?=
 =?utf-8?B?akJKTzJJWW1LVk5seXlrYml1YmRUT1pEaklvTEQxcUszWEdnV1ZhK1c5ajAv?=
 =?utf-8?B?WkwrdkJiTHJBbXN6bU1KS2g2OHZZelZBTENrWU95M1NqZVg0TFFDMlZER3Ry?=
 =?utf-8?B?bis0Sjc3c1h1WEJ4OXVnQXMrRmZMVjZXUFd6d043SHNwYlZ0Z0xWUGQ0T0RP?=
 =?utf-8?B?R1ZNZmVYNGd6bkNUOVNOS2I2Q0dNZlhkKzFnSDRZSFZwLzNtWUxnSVVrOU5B?=
 =?utf-8?B?Um5vTVByNGY5dEg1NmNYQzFhOVJnaTVLV3ZOb1RyUHp1bzlCQy9TbVNDQzRm?=
 =?utf-8?B?cXN5dVNiajdQSyt6eWlMRDJCZUJuYlFGVEhUcFMwVmZKWGRrT3N4emM4S0dQ?=
 =?utf-8?B?VTFKTTdhRVNJVlM1Sm56ZG9iaWlIWEVuVmo0OXNROFpWY1RNc245VVVRZzBZ?=
 =?utf-8?B?aHhRK2pvblMwUU9OQnlFekxtRTFWV0xWakhaenRycEtkcTU5TVBET0NNQlZJ?=
 =?utf-8?B?eTBJSVovTmROYkZ0bWV2MERNS3pVNlV1Q0xhbzlkckh5YzFoZjhOVXc5a050?=
 =?utf-8?B?VW1yTWw2SnhJMnhlM1oxVXJtQXlxVUZLTDhCZ0d2OS9CUEplTjh5SVVxNEFW?=
 =?utf-8?B?NGcwSkh3Y2xnSFlqVHdYRFQyZTN1dEtsTWtNMTFSbU5MeEVlNDVzb0g3UlE5?=
 =?utf-8?B?T2FqL3pkWVNlRElEV25JdTR2V2I2QVJtTHNHT0p1TDhrWis2N1AxNXNCaHJK?=
 =?utf-8?B?V0JiTVlGejA3ZkJkRW5jMS8xa0w3VWh1L29IdVVscnpiRFpSb2d2YjU1T3lv?=
 =?utf-8?B?MDN4ZTNLZGVzT2xJRHViZ2hVSCtOL0FSQ3NRbUFsUXRqY2doM3RuZ0RCak9D?=
 =?utf-8?B?R0lzNU13UzJOU2VMVEZDS3BnVndWWnV4NGlvMHFuTjV2RnJLNlUrV3dhL21s?=
 =?utf-8?B?bEJSbGl0M091Zm14NnQ1b09Cd3V1RlFkZUFqbk52OUkycHRkTnRDRWtXdGlG?=
 =?utf-8?B?bHE0QzdkREZsenlNeGNKZzJNYzMydXlTUlhtbTNFb1RkRjJxVS94cW8wZjZR?=
 =?utf-8?B?YzF1SlRLMjVkdE5tSDR2T0JSR2hGR2dPeEtBVitPRTIwdnhoWGYrMGlJQlFN?=
 =?utf-8?B?Nlp3VE1sVXlxRTRmcnMxTzVwTkZ5MHNpU1orYTl0WnAwWXlZWXN4N1ljdUZC?=
 =?utf-8?B?WElMR3YvWnViTVc5alMveXBjNFd6TFQ0Wm1Pc0RpWFM0VVprV3lxODFJaFlM?=
 =?utf-8?B?L1VwQ0ZSK1NWUUlLOUc5TlB1bjlVVC9wcWhFNTlmRE5Tall5RngxUFJ0cWhB?=
 =?utf-8?Q?w0VuzVmJ+pnuf6LqR/?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac96da8-767c-4efa-6e89-08df008a573e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 20:17:08.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAmyf7BcYh74PDWwTXHiGNt8OnWQbpa+jciWYdM9h4JhEshhTlDPJlbkxKAwu4PFerKrPLgcAWfJv18jYUzszg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3040

On Fri, Aug 21, 2026 at 08:58:14PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> perf trace: Auto-assign kernel symbol beautifier to function pointer fields
> 
> This commit enhances perf trace to automatically assign the SCA_KSYM
> beautifier to tracepoint fields conveying function pointers. It uses
> heuristics based on both type signatures and field names to detect these
> pointers.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 0030489465032..0a12d7b37d8d4 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> [ ... ]
> > @@ -2198,38 +2210,47 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> >  		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
> >  		     strstr(field->name, "path") != NULL)) {
> >  			arg->scnprintf = SCA_FILENAME;
> [ ... ]
> > +		} else if (field->type && (strstr(field->type, "(*)") != NULL ||
> > +					   strstr(field->type, "_func_t") != NULL ||
> > +					   strstr(field->type, "_fn") != NULL)) {
> > +			arg->scnprintf = SCA_KSYM;
> 
> [Severity: Medium]
> Will this unconditionally assign SCA_KSYM for matching types without checking
> if the field is an array?
> 
> If this encounters a tracepoint with an array field whose type matches
> the heuristic (like an array of function pointer typedefs),
> trace__fprintf_tp_fields() will assign a pointer to the tool's raw heap buffer
> to the value.
> 
> Since SCA_KSYM is applied without an array guard, it might attempt to resolve
> this user-space heap pointer as a kernel symbol, leaking the tool's memory
> address in hex instead of printing the trace data.
> 
> Could we add a check for !(field->flags & TEP_FIELD_IS_ARRAY) here as well?

At the time of writing, a search across all tracepoint definitions in
include/trace/events/ shows that existing tracepoints only use __array()
for byte buffers, UUIDs, filesystem block arrays (e.g., nid_t nid[3]), or
CPU masks. However, this could change.

The type-based heuristic in the 'else if' branch needs this check.
For SCA_KSYM, syscall_arg__scnprintf_ksym() expects arg->val to be an
actual kernel virtual address and passes it to
machine__find_kernel_symbol().

> 
> >  		} else {
> >  			const struct syscall_arg_fmt *fmt =
> >  				syscall_arg_fmt__find_by_name(field->name);
> >  
> >  			if (fmt) {
> > -				arg->scnprintf = fmt->scnprintf;
> > -				arg->strtoul   = fmt->strtoul;
> > +				if (fmt->scnprintf == SCA_KSYM) {
> > +					if ((field->flags & TEP_FIELD_IS_POINTER) ||
> > +					    (field->size == sizeof(void *) && !(field->flags & TEP_FIELD_IS_ARRAY))) {
> 
> [Severity: Medium]
> Does using sizeof(void *) here break cross-architecture analysis?
> 
> When using perf trace on a 64-bit host to process a 32-bit perf.data file for
> events that use unsigned long for instruction pointer fields (like caller_ip in
> XFS tracepoints), field->size in the trace will be 4.
> 
> This fails the sizeof(void *) check, which evaluates to 8 on the 64-bit host,
> preventing the expected symbol resolution. 
> 
> Can we rely on the trace data's pointer size instead of the host's, or use a
> different heuristic?
> 
> > +						arg->scnprintf = fmt->scnprintf;
> > +						arg->strtoul   = fmt->strtoul;
> > +					}
> > +				} else {
> > +					arg->scnprintf = fmt->scnprintf;
> > +					arg->strtoul   = fmt->strtoul;
> > +				}
> > +			}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260821204930.679027-1-atomlin@atomlin.com?part=2

Indeed. Perhaps we could use tep_get_long_size(), which retrieves the
target's recorded long size; which matches field->size. Therefore,
caller_ip is correctly recognised as an instruction pointer scalar and
symbolised with SCA_KSYM.

Kind regards,
-- 
Aaron Tomlin
