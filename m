Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020082.outbound.protection.outlook.com [52.101.195.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A11EB1AA
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896026; cv=fail; b=mnr5beVSRhoHuzikhljgM8IMVlEn4FmjBWLteT8dvZ4EoDCJx614WA6S5+PY63XALc3EQ3LlQEoRqO/rD+CR5hZPs7bHu6Jgn82ntJqAoXoFL7E1t9wSZN8ji6akF3GBiT+7xqnDmWseAf3vkuxtWv6XquoEej42fHtk6T928Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896026; c=relaxed/simple;
	bh=0yGKJ+kPJKbPEsw+cUGIPXMwrlHsqc8SWXpGxmZViYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=odxykAQvEa+k+M0+SV8E61pZDh6xNcI0pT9LbvDdhBwU4y9Ac+swlXuQ2HjA7w9piM6yT25xsuC6LpEXQ3m34nvvmMPmb5olhpTTClYNGbJK8RKLBADJYXtYlevl/f5LMlAqPJ+6j5dD5VWVu6uplrURsfVdyTqFlPE7umtIDFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDctsT+puQmzpI4by+sQIQ9fW3kNNFmOAkBeZgx0fvrJ9p6tUyCto+Tkfxdb8ou8G4J7yupFjyp+4I7As0LhIeiduv2ZctiqbYn5lUYAsDFBoFUBJyA0wRsTbzum61L5gs9AEZye0TovoVUlEOTKdLHFP+a6RsFTpSM15Jzsbt0cC1OAdVofupEH/yVdPY1oL4k36+VBxgA3WfZHo+tf60e5kNpLZ5rYYGdo7tDoPD8Ftmj2hjPTgoq4kOf00oCAqtFO9yHjbjIgq9z4SDwWkdRuaWDW0unvL4/3XofXLTqW0nC0/uldOwtY+J/VKLK/HyHZFMAWojF0wpNydi4ZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=FfGtpLjpbF7yNTUBtkH1LDSoKVKwAAfSjJcDJdW36cs=;
 b=yD7hNQpJmt6woXg4TKefpSHmxlBf2FhFUmPb2bfpk5Hw37q+S03vCRb66jtJt5hL7wwJHcSW7QBoic6X/5oqBu7oWm4UyciOOvjf+MT3jToVWt7abVFm9nTP82tBM9L4T8BpMt8BxIa58F+FSqa+uK4c6UHvkz6M1sg9vjmjmurGU8d+AFbayfObcvfeYw8MJE0lpt1aK/7h5xp/9Efmo82NHTTownSNRjXAPnkV+pC+5mToLuQb9ghQhB3iRmRbNLcmN3Yrzeen6wxTugkcy1TV8RkiuReCKBzR+LY/ZT+1IkmKlWxx0K1KbxWC2i++kDbjbDBchmmOeRw7PaYsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB3808.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 16:00:20 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 16:00:19 +0000
Date: Sun, 16 Aug 2026 12:00:15 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: namhyung@kernel.org, acme@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next 2/3] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Message-ID: <ef5ursm2di54vzof2vcoystaxo6cmueztdazyrf7dffx3fi7xo@fl7iuid32fmk>
References: <20260815233651.527936-1-atomlin@atomlin.com>
 <20260815233651.527936-3-atomlin@atomlin.com>
 <20260815234738.393B21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260815234738.393B21F000E9@smtp.kernel.org>
X-ClientProxiedBy: BN0PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:408:141::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB3808:EE_
X-MS-Office365-Filtering-Correlation-Id: d020234c-2d66-457d-c5d2-08defbaf7879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|3023799007|6133799003|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fo4yKfiZK7cYbSSMZKyNHf9W4gy6bmm4CHQIns3TbkosN6CFgtx3HI++Y6PCgZ8pLIi19BHjnGfjuvThgHdWpAKfUWTXrWNxKmavkx9um36Ov7bIYa0CUTQXDiPNoPF95w5AZlCWyz5C+nXX0EqHrv9yNVKGVXVe2eGnKekj3vAvybH10xklGFxzs4hnZJ0t2qAyDIzREUo19n0FWAtUd4A5+WBYFXULNTcps39gVqivuYuudvM8l7kiwsoGnIqNHMHRQP5enOOlnpVdDhFIQiXhtoyzqUy6PCOV2yf9opdzYvngnSQiP/h/9hS1pnxK7tTmYzFPVXWFwtlBhUJcScYy2JXMqzzVSTeS0xxV8OOBOjoOCT7Z/0Y5icCTBIfxJephcNOx92F3J3L5ehxUjRWKn4/2IN6w9aRKLcZyV/v9ALlSxFMXvDBR9621djxyYjwXMFec1pcHcC9kj6O1cd/T9s1Kvxc8yvlFqbgdJuzCcGmIZ0ytXkCHEuauu38BdcaMzGWzqB0+TeWGxzvJ5V1glob/sm6+KEarxfHA4CGvUtgUQP3geb7IV0T5zBXQPsp5oRbSju3D92y0/3MEyzzvEzZf6U2B3bf9mA99+ps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(6133799003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUxEUWVFUXhoQlJnWjNQRGQzMFBKT1BXbjAraXBoU3QwM3BOQkRJbWJXeHRm?=
 =?utf-8?B?UUtqZGtLWXZWTTY0ZWhJOXBoL2NoclZaaHlwR3kzOVFnOW5xclJSTWphZjEw?=
 =?utf-8?B?TnQybE9lWGlFcDdMNE01TTk0dEhrV2JvYUNGWVpUMzAzOGRnYXNzRVZ3aW5O?=
 =?utf-8?B?eWlLNzRnMEFmT3dVQW0yVEk4QzJVYkxNbzNxVnFmVEgrcWl6TTc3T1pFdjBj?=
 =?utf-8?B?NHBBY3JyQVc0bHRHanZnRU02WlFMb0pYa0J1S0VVUU9GS3EzbENRbFY0ZjF3?=
 =?utf-8?B?VXppdWw1Zm9xU2FmcFIwVXJWNkpxanRJOWlSR2FxT2lUYUVKTXoxalJkMk4x?=
 =?utf-8?B?SkxFZjlkcU1rUExLMTQwVkEycnl4dkhWMEJpcEsxai9INFN4YUhWOFp6T2VH?=
 =?utf-8?B?UUtGL2sxL0pzNGYrQkpuSUl4dHhhUUlBb2dCMTYxVFp3TGNmUnVDOWg3Zy9M?=
 =?utf-8?B?QTY4K2ZBUzduZHRrZllHTDBmR1N2WUJrcXZKUmZLZVN5UyszVWxKWnR6YWl6?=
 =?utf-8?B?YUp4RW5zaG9CWEtRN0NWZ0xZWjVJQ3BJS3JlOFFaWUI4c3M5WHlxM1pCa0Qz?=
 =?utf-8?B?N1JxOGxDTGtwUm00VlZnc3lpSTFiaVhaQVRvRmR6ZHJmY25WaVFyUHkra0VJ?=
 =?utf-8?B?dHYyOGlVdU9Ea0FWZG52MGpnTlU4RThvcnA2Nzl4MTU4YVBSZUJ6Qm5jZFUv?=
 =?utf-8?B?ZUo0M2xzVnkraUp4aVJCczN3M01hekhaaTNxd0lQcWQ4dWEwb0RTUGZVenE5?=
 =?utf-8?B?OGxhcHVUUklYbFhOR1pEZVFWZDN0UVJ2Qi9rVXIvZXBaK1ZYS3dCV1dGMzlT?=
 =?utf-8?B?ZmcyWThPTXcvakJZajY2S1I4Nk5QSmFlUFRadFUvdnBYUm93NWptbUFJS0U1?=
 =?utf-8?B?QkJqbk0wNDA3RUZLYnVkTHE2ekxoUEpWazExQ2NPOFozQm1TN0lPTDkzYzB2?=
 =?utf-8?B?MlVhVXJZL2VMSzQ3YU1FQ0dmeVVtb2Z0TzRZMTE3KzlocDRvb1RPNjdHNW43?=
 =?utf-8?B?ZDZIdkpoTmRjMXVCZ0VYSHJDak90c3VUcHE5RXJnaTF1STczekVkdlpyV3Jn?=
 =?utf-8?B?MlNnbjNTVktrNEtaT3lnV0dHOGdyUitNcUtOM2lVTTQxRGxDRXB2Ty9RaFRl?=
 =?utf-8?B?VVAyMFBhSTBPbCtJeUg0MG9XYWNNNDRXN2RycTFQc3FLKzIxY0hlYjA4b0JL?=
 =?utf-8?B?USt0bXdVeUpDN2phbTVQTDJOS083dnMyQjhvK1NoaUhpbnFxVWVsVitHSWti?=
 =?utf-8?B?UC95TkhkK2ZFdWx2bkVaL3plaW9HTFBCSkE5dkVqVFB4aFphUGR5SGZLNWNn?=
 =?utf-8?B?amFFWDBabko4b2NMVkRhRHJrNkhGZFAxUWJPRFZvb2NsSjFLbGdPMUFPa0FX?=
 =?utf-8?B?VjA5M2tyeGlUS1pBS0x6dVlpTlczQ2JTSlZSUldpcnpFSFJQc2JCSERmM0FG?=
 =?utf-8?B?SzZ3SWllM3RvL1Z6bDFBVlhmWkxNWXhYRW5SVll0aGptay9aV2hVNmlpK0xK?=
 =?utf-8?B?UzZGS2wzSmdXVEZLVFM3eXVHNm1jckd4NTRDbUhKVmROeFhKR0IxT09pOCtE?=
 =?utf-8?B?V1hvSUFBRW1RUmMxTW9LMjA0ektyNDJOL0VjSy83QjFad1NGalc1K3UrblhE?=
 =?utf-8?B?QVVqU2RobEpiT2xCYzhjRy9XKzlyNWtJNWJPZmp0MTQ4clNtVTZ0cVM5YkdS?=
 =?utf-8?B?Q0FzRCtwQyszRGtWaTB3Q1JhZEh4Ri85M09wSElOTk55eGxUVVFyVmlISzFu?=
 =?utf-8?B?VEVwMjViRXZEN0w3QTluaUFhdE9uWDZPS0NkTWVoZktiTjJYc0VDQklsMi9I?=
 =?utf-8?B?bVh1WnF5R0hac0NpRVkyZW83dWlWN2hHamh0d05aMmJVTHFiaTVNTWtmeG85?=
 =?utf-8?B?UDJoOWVRZnZHTHZ3dW93Z2cxbjJsSG9CZ2dTRGRmSnBkeE9HdzAwaXlTdmhl?=
 =?utf-8?B?b0lJT1FzNld6SWE0QUhiQlFqUE9EV0VDVTZ5cXdoc0tROTdnckptbVlsMkQ0?=
 =?utf-8?B?Z0YxaFJvRXgreVI4UWtUVUdIZkwwTmdQbU1CT3o0UGV4K2ovd2NuMGZqdlJt?=
 =?utf-8?B?SzFrSnJxQ0M1ak9KZkJJd0sxVHFBUG5XWkQrYjRMYk5BNXpqNFdTTWZ2Z0lE?=
 =?utf-8?B?RjZiQmpvdGpNWFU1b1dsVDR0SlpBY0lHVVRPaDU1REFlNjh2NXNmVTlvR25H?=
 =?utf-8?B?REN5djlHbUpoUzdUYXBkOTdkWXorUXpHWlZ0elJaeGo4NUZsd25RZXRLT25U?=
 =?utf-8?B?d0RQT2NEaGkyazJpZjhyalQwSVVnWTFCVStRVURObUxvcSszdkMycXgrY0dp?=
 =?utf-8?B?TSsyanFoYUFLOW9GbXNxdmZaemo4VVFyT0M5UE1NSG1XRXltekFHdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d020234c-2d66-457d-c5d2-08defbaf7879
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 16:00:19.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/SNIMaE7413zXQVIGrzGSwwfaVsLx83RBY6+UpmxNgrguuYrz8QXjZ4cPMubfFtaujOYgrw7krpJZPHWSe/CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3808

On Sat, Aug 15, 2026 at 11:47:37PM +0000, sashiko-bot@kernel.org wrote:
> --- Patch [2]: [PATCH perf-tools-next 2/3] perf trace: Auto-assign kernel symbol beautifier to function pointer fields ---
> commit e41ca802a20df2b74611c38302bea036b4cc9f1f
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf trace: Auto-assign kernel symbol beautifier to function pointer fields
> 
> This patch enhances syscall_arg_fmt__init_array() to detect kernel function
> pointers and assign SCA_KSYM as their default beautifier. It also registers
> common function pointer field names in the syscall_arg_fmts__by_name lookup
> table to automatically symbolize them.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 102221b301a54..825b16581581b 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2091,8 +2091,13 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
> >  }
> >  
> >  static const struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
> > +	{ .name = "action",	.scnprintf = SCA_KSYM, },
> > +	{ .name = "callsite",	.scnprintf = SCA_KSYM, },
> > +	{ .name = "fn",		.scnprintf = SCA_KSYM, },
> > +	{ .name = "function",	.scnprintf = SCA_KSYM, },
> 
> [Severity: Low]
> Are these lookup table entries reachable? 
> 
> In syscall_arg_fmt__init_array(), there is an else-if block added by this
> patch that explicitly intercepts these exact field names. It appears these
> lookup table entries would never be evaluated for these strings.

Indeed syscall_arg_fmt__init_array() intercepts these field names in an
earlier else-if branch, these entries in syscall_arg_fmts__by_name[] were
dead code and never evaluated. I'll remove the redundant entries
(i.e., "action", "callsite", "fn", "function") from
syscall_arg_fmts__by_name[] for v2.


> >  	{ .name = "msr",	.scnprintf = SCA_X86_MSR,	  .strtoul = STUL_X86_MSR,	   },
> >  	{ .name = "vector",	.scnprintf = SCA_X86_IRQ_VECTORS, .strtoul = STUL_X86_IRQ_VECTORS, },
> > +	{ .name = "work",	.scnprintf = SCA_KSYM, },
> 
> [Severity: Medium]
> Does this correctly symbolize work pointers, and could it inadvertently
> corrupt unrelated non-pointer integer fields?
> 
> For workqueue tracepoints where the work field is a pointer, it appears it
> will be intercepted earlier in syscall_arg_fmt__init_array() by the
> (field->flags & TEP_FIELD_IS_POINTER) check. That check assigns SCA_PTR 
> instead of allowing the field to reach this lookup table.
> 
> Conversely, for tracepoints like napi_poll that have a non-pointer integer
> field named "work", the pointer check is skipped, allowing it to hit this
> lookup table. Wouldn't this assign SCA_KSYM to the integer, causing it to
> erroneously print as a hex pointer or NULL instead of a decimal number?

For workqueue events, work is a struct work_struct * data structure pointer
(formatted via SCA_PTR), whereas function (work_func_t) is the actual
function pointer.

Adding "work" to syscall_arg_fmts__by_name[] had no effect on workqueue
pointers (which hit TEP_FIELD_IS_POINTER first), but it incorrectly forced
non-pointer integer fields named "work" (such as napi_poll.work) to be
formatted via SCA_KSYM.

I'll remove "work" from the lookup table for v2 so integer fields continue
to be formatted as decimal numbers.


> > @@ -2193,6 +2198,14 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> >  		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
> >  		     strstr(field->name, "path") != NULL)) {
> >  			arg->scnprintf = SCA_FILENAME;
> > +		} else if (strcmp(field->name, "fn") == 0 ||
> > +			   strcmp(field->name, "function") == 0 ||
> > +			   strcmp(field->name, "callsite") == 0 ||
> > +			   strcmp(field->name, "action") == 0 ||
> > +			   (field->type && (strstr(field->type, "(*)") != NULL ||
> > +					    strstr(field->type, "_func_t") != NULL ||
> > +					    strstr(field->type, "_fn") != NULL))) {
> > +			arg->scnprintf = SCA_KSYM;
> 
> [Severity: Medium]
> Does this unconditional name matching affect non-pointer integer fields
> that happen to share these generic names? 
> 
> If a tracepoint has an integer field named "action" or "function" (which
> can occur in subsystems like btrfs, power, or xfs), wouldn't this assign
> SCA_KSYM to it regardless of its actual type? 
> 
> This might cause perf trace to treat simple integers as kernel addresses,
> failing to resolve a symbol and formatting them incorrectly.

Agreed. Matching field names unconditionally without checking field flags
or size caused non-pointer integer/enum fields like int action or u32
function to be misassigned SCA_KSYM.

In v2, I'll update syscall_arg_fmt__init_array() to restrict name-based
SCA_KSYM assignment so that it only applies if the field is actually a
pointer (TEP_FIELD_IS_POINTER) or a 64-bit address (field->size ==
sizeof(u64)), alongside type signature matching.


> 
> >  		} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr") ||
> >  			   field_has_hex_fmt(field, len))
> >  			arg->scnprintf = SCA_PTR;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260815233651.527936-1-atomlin@atomlin.com?part=2


Kind regards,
-- 
Aaron Tomlin
