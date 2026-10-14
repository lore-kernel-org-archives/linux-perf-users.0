Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022129.outbound.protection.outlook.com [52.101.101.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F994A68BF
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016705; cv=fail; b=OBO8c6XIzLI2y39wWq+1xYyF/j8vrUmyeN7RMQ+YOfQAAhjgRGcIAN3a44rtLmbuhYxSdUHS30Nirm42tobc7NHqxlz+zK3bzi1YSoovLIYXxuU91sFMWfFvloUHr7dd45fygKJc3IypGXtW1wlR3oj9ln4TougyyVoaj1qQxJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016705; c=relaxed/simple;
	bh=pdhG9KfvsCo+mNbtvqyA4+GTEVE084BX03hpETWkXII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klfn8HLBveZGu+5pyr3anal/va9tit5lu1nU0i0PeeixvP/GVdrFaUhnsaCGulFkVvEE90T0X1+VofbFbGEKrvboGrYAyZXSqsfZf1sEAlHPAyoJ5HFTVQrlUZlLz5f9Wo8ynXEGTE2RzGfZtv4/m3p1gTjvWfQZTCkji2JpHcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1ebBAKkLRT3ba6cs0HeFuC5u9yvJi3EMigtmH4noUdui7Y6ybzq0srZBugF/hVzx2RrdVIRX0bGH7Zqxj7Qunas3iY9Nj08hLPn6qPq4KMhfC5H7oJBRXTwGewhVnOONdXH7NXEu1nWwd9U7dAsIAWh0zTvBlCQaWg+dtvs5tsT+npzJYzDpG5zQ7EUaFRTrd0jWVANHZswzI9S8I6cBwBFD0pLh2kUsOkn90h9wcA5hn1BqGIwqOBhACiSpjWgVrO0U52yDJF1BvlTlz+eM1vggms25CRh9RUI6+Ky7H+F00PQCC+LG3IuOuzksdOo/Qrx56ZzAV6MycBB/KtuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=V6gqoJ8TtoaJZv+mq+DWQKHMyF9RiugvM6rxdiNDCD0=;
 b=Yd5sa/o4wO6MIJgtNH1koaBUwQ9trTZm4DLWlZV2eW1jWeWZWeMDgUZuKfMMArST56c49LYN5HD7b2Yqr+CaEUSeTNgzkIuMoaKcLhdWp1ElVPk5qNSecIOjztB/2yl6PleXhLjucHR/O5qx7GtTF/im+Gt5zgmxr18KxeTeKXvfQzF3DcvJjKd1K47KrCmqbJbbMJ2g7tQ7va8LDz5F2aCiII7FPco0MRLlCZsyLY+hwfSsZBBEp4yZuabNRDqOv2wSQzV8iXnDmoa9G5ToWjKiL6wEltDZhL/ig4MGLIqEOSLjLN2aBwe+1DTW5DzLlGfwlZBn+wglbjHCOccnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8920.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 22:25:00 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 22:25:00 +0000
Date: Wed, 14 Oct 2026 18:24:56 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v4 5/5] perf ftrace: Filter extraneous
 functions in function graph tracer
Message-ID: <hn7bbhege7vjj6huva2rceqgcxfqnlee5vacyx7ryn3cf67nt5@gxtlvtbpfazp>
References: <20261014161457.373253-1-atomlin@atomlin.com>
 <20261014161457.373253-6-atomlin@atomlin.com>
 <sashiko-outbox-171529@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-171529@kernel.org>
X-ClientProxiedBy: BN0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:408:ea::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: dddfc7f4-501d-413e-8c60-08df2a41fc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|10067099003|18002099003|4143699003|261009223027099003|56012099006|27256017;
X-Microsoft-Antispam-Message-Info:
	X4fBf0+CyfffBkWYHIEdgpdAGDjtJPeGOQSBRoVJ7eEOdte8P2HykteYw9aSjTu74ngiLUCikIH78exJYZ6tdNF6gHqyIsAw2mrlcciHP6WuehWhUIFDFR1Vz6j5/E91l/m6S9FlVaKIeM0ppG8fdMTVarsRBsTo5EMTogNFyurhfRL049+RXwzFo+MWAklqUXxezFAUCL/CmyP1Nkwg/+dmZVldGHCSboJKtaQRr8+/ANFrxlCFE1zYaPVQa1Q+PsG9jU+IhdjdG7Vp4WhekgtQjNFJs2WCmQjFDlazmXe6y2LqeWUPlJsvGebMiUaHbcnlU4NjzaT4c30Sm+QZVFUweMmsQruNn6xubzzpN7oUoEatZrx3zJesEB25vgIKTLUczPjS+yjVz2c6+Jtl1N6ofh5BUeJliT9iAXXpSBy58ZRo9wsOQDXsXCwuQvJTutv7504UOJqaMQ0rf9eOrJ8pmc4a+NRniMchXbqiqh3jFXS1JXBcSVuqxN5ax64g6cK3l/fjTxMS/zqIg9MRtjzE0Mav/T3GhHbqX89nLbRN8QdNYgLLCVvM5+8Ez+XOu6QtY5rLotylz9l/JoKh0IYz//2lGd5AZG88mjZrJDmq5P1XBkzAwwr0I/MgLcvdGlJuYPreFF8ZUX6pGgkmN/v87NizQDyQ8gkQKK+2e9BG1dJfo8E4DXgI3D4lU/JRLk1xi0txrvhLqFYj5O0HpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(261009223027099003)(56012099006)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVocS8zM0twUGFLcUorM1NucmVINFJiS01EL2NTQmNBaTlEcEtBSXI3ck1D?=
 =?utf-8?B?dlNDSHg1eEl6M29wWTFCU29KbS9RQm1GTGdJZHFpNVJCd2ErZ0NLaXAydGN2?=
 =?utf-8?B?VnpZckNIcmdFQU56VGFYUW1QZU9CelE4ZWhoRFgyS2dNVnp5Qmo2UVpxdklx?=
 =?utf-8?B?UnEzSElpTDNZSytPRjFJZXd2dHdPT1NaOEkwb0tqVnJOZmlUWWM0T09BbTZp?=
 =?utf-8?B?L1VRTzBOQlJUWUpJUmlUWFBIZWE1VjVPdGlFZDB5Rkh1U0duVUgyY0s5TXZE?=
 =?utf-8?B?WjEwZ3MydUh5ZUVXc3pURGNOdlQwVmp2a0V5VU5qU01aSm9WM2g3NDg4WWxw?=
 =?utf-8?B?TWRsTzAwRHNFcE5BTlFaRWRSZ2x4dEtOdUdKQlQwMGFWbVRBM2FGNTR3elJt?=
 =?utf-8?B?aEtHNnFXc2pGSFM4WUxZckk3UXNCKytTQk44NWhSOHdqcERSUVJHZDZISGVC?=
 =?utf-8?B?OG9NQjZ6ek1kVmF2ZGcrS0Zsb0w2UWJta3AxTWRDaUk5L3ZaSG52NlJ6eUF5?=
 =?utf-8?B?M3JqVlEzbG1qS1kzNmhNMUxoM3BPeDZHbW1HdHdjQXFjM2k2MmNCU3ptV2ky?=
 =?utf-8?B?T0I4OEVGbFpZblhSTWpvL04zN0owY3ZHVUs4cG81WVpSeDdnOUZweW9Ca3hI?=
 =?utf-8?B?NWkyNkdydzE0bnl2eXRVR0ZvWkZMWWFwc28vUjVndnZPSHk2c3cxUnRKc0pa?=
 =?utf-8?B?eVJQdUdLWFp4SUtrRW9tQlRIWkxNbHJIS2dIMUx5TEY0clNlTGF4aUdjU2F1?=
 =?utf-8?B?Vm9OVFpUUG1FV0oyN2FxWlRISEJYbEZvcHhEVW1sSGErMjUyVEtyLyt5NHlQ?=
 =?utf-8?B?YW9lNUlIUkx4WTRWRXBwTFdTQ3ZqTzM5eUtYK0RjRFU3dGFqd1lhUE4zZVhW?=
 =?utf-8?B?bHZ5MEYxOHRsbGNXWDdlL2xOMWV5bnN2WUR0UkhJNWdaREE4OTRoMzZCRnBo?=
 =?utf-8?B?d0h0Y2QyM1UyYnRVcHdjVmdMSnBjTHl6SWJjaGd6RzhsaklQUVBvekM1eGQr?=
 =?utf-8?B?RXEwYjFPSXNKMVdVb01MejQybmw2MWJZUlFEV1pqWGZwWUtvQThURXlSc05y?=
 =?utf-8?B?aW9FcW1vZW5ldnV1SHNYUVNIaCtKcGxyL1RpZ3lQamRmakFnSytSMWxWZ3ZE?=
 =?utf-8?B?R2wyRXVBUzFjQ1UvMGlva2FGS20zcjMrWVpBYStnT1hUcHBETldON0NEMWt3?=
 =?utf-8?B?cHQ4eEJCTmtlRmVQSUZzZHV3MmlsWEF6VUdHMmlBRUQ4OGdoZmpzcTkvUDJN?=
 =?utf-8?B?b293QWRlem9xdE92N0dHMy8vQUdwZUcwd25aR3FZVjNRdGI0REVzRUZDL0VO?=
 =?utf-8?B?d1hkMk9VZHhpaTBwVGp4QURvZ1BrSEpZNkwyWmQ2a2ZGQ1FmWVJRM012M2NY?=
 =?utf-8?B?OGNhdmdqb1RsbHVqbzhKZmZNTTBqMlQ4ejVxNmpmcUp6cnVPT1ZSd1JrU05a?=
 =?utf-8?B?SVp5aTVBMk5FdEZyTDNxYTdFbklkaGJLSE8yTXlNQVpPN0NGOXRJbXRRc1Ux?=
 =?utf-8?B?K0IyWnViQ0RlUGg1emdia1U4OUIrdHNYaU9BNWZxLzJsb0wxLzNwMzZQQmxz?=
 =?utf-8?B?WmVXb05NUS9PcWU4ekFKckVrZmpKa1FvNm5wZ1BzUERYVk43eHg0RHBkNHMz?=
 =?utf-8?B?SHpXaXQvNTc0SG42TkJzZVhOWDJFY3FnVHlWZTJCZDdISmQrVVFEOWhZNkVN?=
 =?utf-8?B?UHdEdStnUWJvblZPTzcyRTkxYVVQeHVrNy9kTDUxdXVyaUdpL3ZlRTJTOFQ1?=
 =?utf-8?B?KzVndG82NWMzdzQvY25vR1NaS2d0L1hVdFB1WFAxTldOdjNEeUc2V3hjRTlS?=
 =?utf-8?B?aHdjY0djcmlaUmxHamVmSzFZOG1mY1MwQ2JaclVlbmw2UjRtb3I5QjB4ZXVB?=
 =?utf-8?B?OUdtci9BcW1LUWVHTnFRNHJwdks2OUlRVTdFNzFWQ05DRFpiMkRKZHlucmwz?=
 =?utf-8?B?RW1nUUpyNlNvQzFmN0dEbjFSUDJuYTNiV1lyYnh1OHlZOWhOVVR6ZW0yN2VP?=
 =?utf-8?B?ZWNGS2Z3SUliZEJ1cjhra2V1YWQvalUyQVR1RjB6MHQ1cGd3V09zV3ZKcUd6?=
 =?utf-8?B?cDFPSER2V0NXNlgyOUNVL3phNldDSEIzWmF6LytZMTdsOTA5MUcyVkN3ZW5o?=
 =?utf-8?B?Q2ZySXZxY0hraFJRWTNFMmlyM3BjT2VGNWdMTXo1ejRid08xSTBya3hIcW1m?=
 =?utf-8?B?dFA0TXZEcDN0Vm8vZGxQaHBRMWhjZEI1R0V5dldqeTUxR0FVUmlqcXI0S0FP?=
 =?utf-8?B?R3JwKzRnMDlXN2puM1ZJcVVQVXM1dDhESFN1YmdCM2Q0VTVkSllUYmQ5Tmsx?=
 =?utf-8?B?a1E1YVRySXZnL0NnS09HblVxZ1JBMnY1SEhqaDdDVVV4VXJVeGs1UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddfc7f4-501d-413e-8c60-08df2a41fc00
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 22:25:00.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRGpA8aM80q0VP4YRjLnlFoaPffh74mqjLECTQ8SMuFvdNMqwxPLtyFkZDcTwkCxC4j1RbD/CI8ViBXaL/X2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8920

On Wed, Oct 14, 2026 at 04:26:31PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Shortly after this in ftrace_process_fgraph_line(), make_blank_prefix() is
> called and provided with the 128-byte blank_prefix array from the stack:
> 
>     if (start_delim && start_delim < pipe_char) {
>         for (c = buf + (start_delim - line) + 1; c < buf + (pipe_char - line); c++)
>             *c = ' ';
>     }
> 
> Can this loop in make_blank_prefix() write out of bounds?
> 
> The loop blindly writes space characters up to buf + (pipe_char - line). If
> the trace line prefix before pipe_char exceeds 128 characters, it appears
> this will write past the end of the blank_prefix stack buffer without
> clamping to the size of the destination.


Well make_blank_prefix() was already updated with explicit destination
bounds clamping. Specifically, len is clamped to (size - 1), start_delim is
checked against (line + len), and the end pointer for blanking is capped:

        char *end = buf + (pipe_char - line);

        if (end > buf + len)
            end = buf + len;
        for (c = buf + (start_delim - line) + 1; c < end; c++)
            *c = ' ';

This ensures writes cannot exceed the destination array boundary even if
prefix context columns exceed 128 bytes.

> [Severity: Medium]
> Because cs->depth is inflated by the inline frames for a leaf target function,
> the filter state check later on fails and leaves cs->in_target set to true.
> 
> When that happens, does this block cause subsequent sibling functions to
> incorrectly return early, entirely skipping the logic that would normally
> close the stale inline frames?
> [ ... ]
> [Severity: Medium]
> Does this reset condition fail for leaf functions when ftrace->use_inline is
> true?
> 
> If a targeted leaf function resolves to inline frames,
> ftrace_process_fgraph_line() pushes the inline frames onto cs->stack and
> increments cs->depth. Because cs->depth is inflated by num_inlines, the
> check against cs->target_root_depth will be false, leaving in_target
> permanently true for leaf calls with inlines.
> 
> Could this leak the filter state, causing subsequent sibling functions to be
> incorrectly evaluated as being inside the target graph, leading to malformed
> or missing trace lines?

Yes. When a targeted function is a leaf call (semicolon with no open brace)
and has synthesised caller inlines, cs->depth is inflated by num_inlines,
causing the check cs->depth <= cs->target_root_depth to evaluate to
false. in_target remained true, and subsequent non-targeted sibling
functions outside the target hierarchy were treated as detached orphan
calls and dropped early, bypassing inline frame unwinding and leaving
unclosed frames on cs->stack.

This will be resolved in the next iteration.

-- 
Aaron Tomlin
