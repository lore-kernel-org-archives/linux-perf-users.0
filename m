Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020118.outbound.protection.outlook.com [52.101.195.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84431372B2B
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565757; cv=fail; b=DENK0/cXfWoCrx7j242unGkvQzlaBRgmkxHBxSVMiK6jhN7FIk/WR6TuCBgPAtDdBkd6au2Jf0hnsAFwcjzT4BKcLr9yte8lWuO+3VusW+kwyE+Z5u0SlEddyAmQo2kC4siMjr34K30PQihkoRm7gK9eZc0c5cdy27MxIZbXLU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565757; c=relaxed/simple;
	bh=iAWFxd/ScaSSfgeec1RBD8VHJ42THJtgjr51qyzzxLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=galU9t5p/xl1hfzuYaDfY5flwRu+bT2dcwwh9CAw3+fIYyMEjj9Mej5gMjsXTCuZ03/RqMN8wy8QznXq2q24QSPclNVFf0q6B45JbgV8NyUgOJ3kp0Qa7nHLMOJEZIubfX4TlVdvbKSTgQeZ2YEQWrjKORjJCCLydkh9ZsfIzPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMGJTGL+rhjMQE+EiY3LVXTA+YkF37jc9/Q4vEu+trzZFUeOdowCyoZGB9xQeGFqGS/U7LgIXBuOKiDVNVFSeeNa7jabf3yhDfOAvEeFnQhBh89KbRZ6QD0c7sM5sKGO8V/pvuHZaKUemd9vLPmCcYNX76V3Qg95F0P9+haaf+tNVHH6Xsoa4NmTafnMnhKebM8JYFvdDycttPYUXd8411SOPgpZaS+s6VQqAcvzx2NgepJPRBjlzhFLjYV/SH/vUEJoHKsOMFvRSIWas8SjmZIqhBS2szEhHJnNFEVluz9u0HkRNYgFzwqE742y64lc5ssAj0xdwNE/GwwYP5jbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=une4qxUS0YCuJEgR0WEPph9IrWGAcVN2RhA527BP6xo=;
 b=aMXhnLel11qqh3s9LizZExVmMAwnHqSoodYzV7whP201HVXk28i2lraHAhxlpsaui8Wj5ITwICrGCzfbWQAbbh+6zeGd4BEAciSuhbmZ86mKrFneTw9otcKS0D9DzVPgPQjGk3B8i6bgrnqc+5suPBhM+eYJFjWQ7yj0JdYuS/S//sgFVqUVUA1KFm6YCU0bl0mxZDObVhmrydoZPJMOBDZZUN6NzV1CjEeKAPEg10H/WPuXs5g4+elwzWxVHQOM6c7sgA4AQwBboVKFSZYjl7nBDPV1r6fvshekUrkaz2boKHH5StKMbaH4VNZIlJ4AFJPm/qQOaEi7mA7CSW8Tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8927.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:494::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:02:31 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:02:31 +0000
Date: Mon, 24 Aug 2026 06:02:29 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev, namhyung@kernel.org, 
	irogers@google.com, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v5 3/4] perf trace: Enhance BTF type
 formatting to symbolise kernel function pointers
Message-ID: <yqxazca2etvvyh54xf3xhuqxhtortjvjc2cuoqogvf57b6jfww@qmqu27slkdxv>
References: <20260822213558.704018-1-atomlin@atomlin.com>
 <20260822213558.704018-4-atomlin@atomlin.com>
 <20260822215124.353251F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260822215124.353251F000E9@smtp.kernel.org>
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 75267987-d74d-4542-225b-08df01c6cfdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	URvsaTCMf7IBjlAcFwxL4tSgkOwTZYeIrvMN6JlpxpgZMU3HD8L33QKwX86gNCOrISK467+/xCUEn+ed9pWI4WPrBmxarOR8laGeF3ayAEXR0jOYLaEe1HCFcRr5o5XhzdgiSMSkMLr4z2EbXJLjmNdeW8LOhZqE/gfPyJ7ned1TGlwW5DYQ4jtYN7YHfdiIyCySkAym9kdx7UxwcS3keZr7JRDzTQmHl9EkaVUB27Jv3oHsvqjshsuU36CyCTZpZfnGi98p2KCX10n2zWDF6EFOb5ILcM3OYudMGOgO2XleqDW/lQUIWH09to+21Cr2W4d9eYRM4ZMpPviuKOu2IlOsJhufGIU9egUzAEESKWuDrR/1qKTPZjZhjVh/8vokvIHWJ/jdOSRn68zBdF47Ukyssq1sRqnu+dbCMYTZp39Qwb2DwvVafJs936W/4iihVgoRx5dUfrN1KLbVwDWSSz2R6dvwLvMSYFRacyN8gUu78tONVaHhwWk1qxBhNoauDvSjds1r3zPMx8GwzqZX8MozafFZbVoqtOdhKZV4fuTcLFp/qI8JwdzlOisyMjsK+2kiWeCozOTYn69T+VoXDNxmO465g4fekVRHvIwr9F60azN6RcQT8eOTtVHwbG3P988AsHeV6eXTSB0fnhYA6eqnlWm0/jE9bdtXXSIHlBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW5FaFJnditmeEZ2OUZJdXNZR3ZiOHM4bVpCOG9BRzIwaUtBVWt4UUJQaVE1?=
 =?utf-8?B?cUxPQ0UzRDlDMEprbnBIMitFU0ZNOTl5QlNXSkEyK2tra1h4OFEySW95UzdS?=
 =?utf-8?B?TEx0c05Fa0h4NDBzTURFV2YwV3ZSUTdnUjFORWdtM1I5MC8wd3JxZTBHSHNj?=
 =?utf-8?B?UHJOZ3EzaHRVdjlNQVFLaldRa3hreW8zMDFDNFBiQml2WWRXeVJ5R0t0dWw1?=
 =?utf-8?B?OWFYeEtsYkZ2K01CcUo2cHV2SU5HaHY3K1J2L0IvcGFzOXJ6eTV5ZEhTalc2?=
 =?utf-8?B?aGlGcnpQazlHUjc4NUJEZjhLRE4zVWk3ZW1wTWZEWTA3Vkl0R1ErTkl4ZHI4?=
 =?utf-8?B?aFN3RXBzQWVBakEya08zNlN4R0poRmU0TlRvVXlZbmZHYnc2cHRweUFHTWdq?=
 =?utf-8?B?Qjk3bE5peVY2NkNnNGkvdDRLYTY1Mm1wMWoxdkZhY3p5Uy9WNjVxUzUzVWNL?=
 =?utf-8?B?NDhZVXZFVHczY0xiZDZ0bU9aeWhqNkVyVzhjenZCZXhwcUpMN3BQb3JFclZT?=
 =?utf-8?B?UXErc3l2UWZTdWZrcUtNcUl3N2xsTWtqVEJiT2dEZjllTE90dFg0YUpxaEtN?=
 =?utf-8?B?UUZzNnBGb0NKUWRJMi9Ld0lLMHVSQjAvWHA3ZlNJMVZ5VGpaN3pQdGVhSlcr?=
 =?utf-8?B?K09jcmJTQUlZcE0yelJqY0VEQzB3bTA2OE1teE50a3RxUEYyZXlUT1BLcDBj?=
 =?utf-8?B?SjN3VTJjUTdjdnZIeCtGY3lkMmVtd2I4VWhOZURNSkpFSDdOTExqeHQ5S25S?=
 =?utf-8?B?WFNzbHllaURZRS9BZXVmeE9TL1NIOWEyZEN2R0M4Zzg5ZlRBbWJtcGtSNGUv?=
 =?utf-8?B?K0RKeG1HR0x2K2FIWGtDUlRoa2Zjek94ci8zMjQ5RkV0SS9PbkRmTlZoZUMw?=
 =?utf-8?B?MDZILzBscmNqWnNUbnlqYnN4M0pzbWxkSDZpeE4ySmt1VlUwczZVbnluZnlH?=
 =?utf-8?B?M3UvNkhMdmM0aDVVTVFqdWhMTUdVa3M3eGl4TWhTcDFzOUxzS3dnZ2lNL3lE?=
 =?utf-8?B?aUUralNyNjJTVFZ5QkxFeW43ZG02bnpUUCtwTVV1ejg2bDlIVW8zZEthZnYx?=
 =?utf-8?B?VzlYWVlZSzdCaWc1Qkk0aG80Zzl6dkowU2JKWDhKYmZFSmdwZUdPQkdla3Nr?=
 =?utf-8?B?empQd1Q5eUZWYWVKVUpsMkNCVW91YThRRFVQdWZURVYxZXh3MFpUcWxuMjAw?=
 =?utf-8?B?dGtLQ004MlphNFpZODlvc0J2NFJ2NmtaY3FjWmdkRmRMQXpMQ0lGbjVlL0Fa?=
 =?utf-8?B?NitFTWJtMXVnblJBQWRFRGt6WGcxdWZGclUvZ0N3cmVIcWRTVWxYVE9GbGtJ?=
 =?utf-8?B?L2crWnNpN1NsQnFsV2pQTkFEN3JrVEFvM2ZSQUtBejA4K2Q5YmFxcU1rZ082?=
 =?utf-8?B?UEdlaHMyTXhzUzUvVWdDd0xkU2dHM3RpaGFEbzBFSHBZTkpoUi9UV2cyRmQ4?=
 =?utf-8?B?TldCdjdkUVlzb2M2Mk5OK3lXT25XZ243YjlsNFlCc1JUUGJaOWl2bUc4ekR3?=
 =?utf-8?B?MlJ4YW8yRVFnRTZRT2RLZzA5cDliNWhXUWpMWFlVT1FXeU9zZTdXNzVIRzFj?=
 =?utf-8?B?TlRBOW9Iak1DTG9FaEVNSGZZMXhNVExtZU9vWExxS1hZTWJoWFZtT21kUkxu?=
 =?utf-8?B?SjV3RFFUcnZHV2dnOStrOUNyV2IrQUVYWElqMlhLTk5mWGxDT0U5Vk1HaE51?=
 =?utf-8?B?OGVzbzlxRlR4TlpZRVB3ZUp2MFIyQXZ4VXN0bytwUmNtang0Y0xtTmJGWFRw?=
 =?utf-8?B?TklqTjQzeU1uMXA5L1l2VkJYSjVhVjVQdWc1SmVxUUsxa0IrcVpKbjdVTkp5?=
 =?utf-8?B?NmNsY3hXMjFqUHBFRlBHL1U4dWNFcXZKTDVaVFEvTjJtdEVFd0tPanJ4Uytn?=
 =?utf-8?B?NnEvZHM1WmtxbGRYVDFQeVFCMmZ0RkRSMG9iclh1eUQrakRpT1YweFoxVHdw?=
 =?utf-8?B?amZyWll5UHlWOC80VGtXMkhtOWhwV3FtTXE2WXp2ZkZRQnZDT0NORWZRK21i?=
 =?utf-8?B?L3kvVzRMRzFvUTdweWsxSGFlcUhDNE93ZHZpRC8vcW5TbkI1TkNQQ2xHcFRJ?=
 =?utf-8?B?KzJTM0dDV2JlVGNoZngzNWIyQlJycExDTG5XWU5Gb0tyWWZJZnVndXd0c1Jz?=
 =?utf-8?B?SjZJd0phcGtpZnBQUnh0S0xwT2s0UitOdTMrUDJKUXhuaWRRRnpBaXRsOHlR?=
 =?utf-8?B?UnM2QmdhS1ZYY2UzdllzdlJ4Qlo0Nkd1MDRyS2htZzk5cXNxVWZDclRyZXc0?=
 =?utf-8?B?KytXQnZMb3ZwTXNtMHgrRmpMVXovTHRNTGphUTZvWityczlGVk95YjZ5eXhq?=
 =?utf-8?Q?cZlaZUtEr6wg7ZIOKK?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75267987-d74d-4542-225b-08df01c6cfdd
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:02:31.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5V6KLyFJXw8jmetKY7sltl4ksnYVsOIsJB9mZLs55QHVDD+MsYM7vBD6U2k8sSkks6zO7EyVv5kweEUU8VXh0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8927

On Sat, Aug 22, 2026 at 09:51:23PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Pointers to function pointers (and deeper pointer indirections) will be incorrectly symbolized as kernel functions due to greedy unwrapping in `btf_is_func_ptr()` and missing pointer checks in `trace__btf_scnprintf()`.
> 
> Pre-existing issues:
> - [Medium] Incorrect error handling in `btf_struct_scnprintf` causes `arg->augmented.args` to be inappropriately advanced on failure, leading to an out-of-bounds read in fallback formatters.
> --
> 
> --- Patch [3]: [PATCH perf-tools-next v5 3/4] perf trace: Enhance BTF type formatting to symbolise kernel function pointers ---
> commit 544922c709767641e98cb8ac1eabf4bff305afea
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf trace: Enhance BTF type formatting to symbolise kernel function pointers
> 
> When BTF (BPF Type Format) metadata is loaded from vmlinux, 'perf trace'
> can inspect the precise C types of tracepoint and system call parameters.
> This patch introduces btf_is_func_ptr() to inspect BTF type hierarchies
> to determine whether a parameter resolves to a function prototype.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 10fbea7ed4dbf..4f8b4f2cf677e 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> 
> [ ... ]
> 
> > @@ -979,21 +980,61 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
> >  #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
> >  
> >  #ifdef HAVE_LIBBPF_SUPPORT
> > -static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
> > +static bool btf_is_func_ptr(const struct btf *btf, const struct btf_type *type)
> >  {
> > +	while (type) {
> > +		if (btf_is_ptr(type) || btf_is_typedef(type) || btf_is_mod(type))
> > +			type = btf__type_by_id(btf, type->type);
> > +		else
> > +			break;
> > +	}
> > +	return type && btf_is_func_proto(type);
> > +}
> 
> [Severity: Medium]
> Will this loop eagerly unwrap all pointer modifiers, failing to enforce a
> strict single-pointer limit for function pointers?
> 
> If perf trace encounters a tracepoint or syscall argument whose type
> string contains an asterisk but resolves to a function pointer typedef
> (e.g. bpf_callback_t *), wouldn't this greedily unwrap all pointer
> indirections, causing pointers to function pointers to be incorrectly
> symbolized as kernel functions?

At the time of writing, no tracepoint or syscall argument in the Linux
kernel source tree that uses bpf_callback_t * (or any other function
pointer typedef with an extra asterisk like work_func_t *).

However, in the next iteration, function btf_is_func_ptr(), will track the
pointer count and immediately exit if more than one pointer is encountered,
avoiding any further BTF type lookups.

> 
> [ ... ]
> 
> > @@ -1095,8 +1142,10 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
> >  		return 0;
> >  
> >  	/* pretty print the struct data here */
> > -	if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
> > +	if (btf_dump__dump_type_data(btf_dump, type_id, augmented_arg->value, type->size, &dump_data_opts) == 0) {
> > +		btf_dump__free(btf_dump);
> >  		return 0;
> > +	}
> >  
> >  	consumed = sizeof(*augmented_arg) + augmented_arg->size;
> >  	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
> 
> [Severity: Medium]
> This is a pre-existing issue, but does this error handling correctly check
> for negative error codes from btf_dump__dump_type_data()?
> 
> If btf_dump__dump_type_data() returns a negative error code (e.g., -EINVAL),
> the equality check against 0 evaluates to false. The function incorrectly
> proceeds to advance the arg->augmented.args pointer by the consumed struct
> size and returns 0.
> 
> Then, in syscall__scnprintf_args():
> 
> tools/perf/builtin-trace.c:syscall__scnprintf_args() {
>     ...
> 			if (trace->force_btf || default_scnprintf == NULL ||
> 			    default_scnprintf == SCA_PTR || default_scnprintf == SCA_KSYM) {
> 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
> 								   size - printed, val, field->type);
> 				if (btf_printed) {
> 					printed += btf_printed;
> 					continue;
> 				}
> 			}
> 
> 			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
> 								  bf + printed, size - printed, &arg, val);
>     ...
> }
> 
> Because btf_printed is 0, it falls back to the default formatter
> (syscall_arg_fmt__scnprintf_val). Does this fallback formatter then read from
> the erroneously advanced arg->augmented.args pointer (now pointing to the
> next argument or past the buffer end), leading to an out-of-bounds memory
> access?
> 


Okay, then:

    if (btf_dump__dump_type_data(btf_dump, type_id, augmented_arg->value,
        type->size, &dump_data_opts) <= 0) {
        btf_dump__free(btf_dump);
        return 0;
    }



--
Aaron Tomlin
