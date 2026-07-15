Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E536C9C5;
	Wed, 15 Jul 2026 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078556; cv=fail; b=bV0HDjA/+lacxMxi4ZxH9tf3lWAQq6vHn72DU9iSOUM6OcJE+bUSOTjGDTN3lkiq5CZM1R4qU29ZvSW5xWdx5sDFOqxIWcz5fU6JyVuoABBdBIXykvkCkY1ts+CLp6prGhEU8Pun4C52zbvn8aCALkdCyU/bCoKb4a0tPk53zWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078556; c=relaxed/simple;
	bh=xmaEYcYWn88ysx3Kvn/gu17mYIKQUKVkVdFX3eeO2qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lRMnLKpCSzq55h9PCDTsx1FGQZqLyFrNbFfv6ySTgSRJ3CyitKUiaPvCKuOLbuEy/pdfy6cR0IAxLp2u0u+E0uhntL/f8rKUKY3eNVjqGXZp/5HXetcnyXtYK+u2o194vML1xG8Q3p9pnyU+4pBdJSH+Ql6RDr6/JHwf7EvIcQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suETdMzksLZqjusgkJ3ASxP+ZmewpfniZVjQPYXQtDf+4rmCQFiZL7MC3NZ+P103dW/9U6AfnwSwT/sTglCCdFbOZcTHYSSzfqABqb0eeQ0ue28DsNzthQKHuxZ2N6OnLIJvULmPtQcQO0Y8CLS5tFaJ5zcOXlCZqJj9tSi6F5zvDKOmlm6oLGpcphCLNMUbzo1fBa/fhKFlEg9mwwDohQfZRpOM+xTWOwS7OtDLuQUphxELMuCiuVRir62hKCQnPPlCslX/uxXvgIxdPYgmQDmc2ZmYUELeC7NUNb2M/eEF37htGn5quGrQMlWVGIc+q7bw9YDCJBo5WeszuiuLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=BEm0GIXXxR6EQmxdOEfRAUIDaQUk7HhaO0Xxh2iBwkw=;
 b=UKrlazeMRHp3S3EHWsCJ43rW/xV+ex0h2pYW4T9+n9xJfqptphLMn+T2CfCh/BXpgqjY/OYooZ+85B8qKK/PJifOM7IYOXmtarGX8p0BiWdi/VLfOhSL9TsNP94Qf55tgkVQJj/e00w88VkDCT0kZU6xcdv2Q4kU70m0ofwbZs9rOpW4yRO6Dp6D4O6FA3K0/mtB5SZv2OKVl/DYPvxtpXESflXCDMjdcRQlVbbzOtjmqZiQ4epxfy/G7AlfIdQIYqri5vEfykBR+PSjJW/7vYmiz12c8fO39lwuJuQCTXY8fV/LwnSkZrDkmSOcMq+4B3UXnxey57QoJpjNEb+yCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB6182.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 01:22:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:22:29 +0000
Date: Tue, 14 Jul 2026 21:22:25 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, sean@ashe.io, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Add --bitmask-list option and correct
 cpumask formatting
Message-ID: <q6gjme4swbkgxilln3mjvkixq4vzxq3otjvstzx725rvqy552r@hlo2kojco5rg>
References: <20260714162947.214270-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714162947.214270-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN1PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:408:e1::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: c931bf08-2408-4e61-6540-08dee20f895e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6fFvXx5bD3TpWngOjEhfEoybpyiL92GR9434GHjfoj7qUguzgRuFzWYnvB8hSXeKeXNPs8f6z/hS5OsxYyg+35c1LvDDEJpw0ydfg8DKFLN7kGKskzfA5spAmfz2tMoLf8eCPzswHCib3kGzCF705VeGww15XbHmGD88uWAQ3UcQ4ymlUUEiInWnr9822ceiGzwcVvdVgox27hiKDBwEdxlrV66VWgI6k/vDln0kUkOFJmxYWK5tkdglbDDbhK0FJaSazZtqqduIJE5++3KzYYaqjOZbZfyMptcIdR5lEn8WH2grlxVVVD19N72iqr/En7/JU5noiJbzAUnArM8LJTYDQ90iNWYW7p+PSdFsj2OdOc7gsZs++jksS5mM2G/2rLZGUAWlfPHy8F0mMGJOZKekY45lxLT+q69C8gKhsXecvTVmpqzadUr2RFc5ejn9LNLP3Y2+BERrweJft2aYWyynS/W+1HnFNKzo5Ls+896t7Jd/tIT9jjxxZa9IWmP4uA9W64oyR2G2aqkotLqmAHYqksh7BnusQbvTLOyclO/YtflQ5rbglrLgp1Rpn+GoTqi5/i1tyFcu+epdrnNMG8zHkrNJNLwYjVzjywnW23NQl2sGTC9rOQkonlBrPweDvtkfIg15KZ61b5oEF50nAHO24tILbsk6So0GTKCbL44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djVGLzBWbDNRK0paUzBpeVR6Vnpkc1MrN3NBUGlwSTBTaGhZRzBDYVFyOFNY?=
 =?utf-8?B?MHY3aXNRdEpENXRVRitwVzRneUQzQ3BDSTZxcWFZR2k0eElHTVl4Q0pwYjF6?=
 =?utf-8?B?TCtFbHk0ZlBUNFptT3o2cktJNGU0WHFiSWZjS1I3ZUM3TUlMMU1lWE52MG9Q?=
 =?utf-8?B?SFo0TjY0TU41NllxUllwRmQvb0pYYnpUcEhrUjRCUnZaQkhjczBMbUc3akRW?=
 =?utf-8?B?bVZWRUZtSnF0aUd0VFd3Z2ZVdlNlbmQva0J6M0owRHU3Snl5VE9WYzZSSHBq?=
 =?utf-8?B?cGozWFU2N0tySjBla3ZTT3MzdHorQXJnOG9sSE9RelQrVld0NXloVnBHVldj?=
 =?utf-8?B?clpLelVjclJCaUJrSkV5cHJtMU5UdGZvMklWcFk1V2pDV2ZxWDd1YnRjVkt0?=
 =?utf-8?B?TEFaSHV6ODlsdDRndHJyenkwSHJUNy9WU1JXN1JueE90YWltb1lSczlkWHRy?=
 =?utf-8?B?bHRpK2NrR3cybWt2VHVuUmIzSHAxSTRhNnJaSXUrVGxPNlAxNW01MXl2OEo4?=
 =?utf-8?B?blNkYkRoNzdWbitWL09jME1EVm1pR2hvbjRreXRxR2hhTCtiMjZKMXlXMURD?=
 =?utf-8?B?TVhuN2Zya3NuVkYrZXRPdlVhbTN3WHVUbU9GSVhlKzhHRnBERjNMLzlaZGpW?=
 =?utf-8?B?QkpLWTQvQ0FQd2kwZ1NJajVXQmlDdVpqWERwdUJxRWd0cktSa0xZd1BBanYx?=
 =?utf-8?B?d013M3BSRW9hTmZQSTNsU3FYL20wMHljVVdwT3ZnLzc4S2hYRW5zaGExektj?=
 =?utf-8?B?eFBwcHNwVXB5dTNSS0VSclZEZStPR0k2Nm5ucW5lcFhGUmlYMGtBRXVOZUlP?=
 =?utf-8?B?M08xL0ZNOW9IdVJCandUcmo3dkgwSVk0UjlKV0ppRGIrdC90QVhsa0JWUG9N?=
 =?utf-8?B?cFlXMjJvUitjS0RRUHROWFJUd0pKbUZsUEN6ZjBQUko2TC95aDZPeitrZ21j?=
 =?utf-8?B?UXJzVTRYRzhVQmVEamVLelFkVXdEQkFCbDVrOEN3czN3TGU0cFZJR3RtMDFt?=
 =?utf-8?B?UnlZdDBSY0p2QjNNTTRVQlg4SmlYOThSSTg5RUszaFZNNFJmamszNGNvVCs5?=
 =?utf-8?B?Y3o3TE5BN1I1YURVaEpLaFRHSlJ6MTh0RElBTjJJY1NtOFVTK2xPWWVtV3NF?=
 =?utf-8?B?blQ5V3ZFY1RQUlpNaUNVa3ZJQUduNjhMNXNsa1JGNlpOQ3ZQeEJaSUpMMEd3?=
 =?utf-8?B?RllJTVEzY3JjWk0zN003Z2d4emQvUjh3VmQ4d0ZuNzN5Q2dyV3pYZUU5OG1x?=
 =?utf-8?B?M1oxMUZXQmZRYXgyTUx5bTdKbC94cjRTYXBBR3FEZHIwVWt6YkpiK3FoZ2Y2?=
 =?utf-8?B?S1huZ0dNdWNjUDhxWjByalBJekVpSlYvdkpvYk1wVllkWlZyRUdIazhKUVJS?=
 =?utf-8?B?eE0yQUtVY3k2d1pPZ25yNnJMY0dJWStkRTAwSG9ZNkJuQ2crdXRCUlRmbUJr?=
 =?utf-8?B?b1NwWVZoU05ZWGdxa0JhU3gvTklKNFRSeFRTNGl3ZVN1eGt1Q0RCM0RpQWcy?=
 =?utf-8?B?N21KU1RYbFdTeDNmZmRLc0lkbThENTk5VkdmUFlOOS9pL3l4M3NLR085OU5N?=
 =?utf-8?B?WFpOR3JXTldpOWpKWUQxVkRSL0ZoNEF6eHRxQWR0ZW9kaUlmWXNHcU1KSVY2?=
 =?utf-8?B?Ym1YWlhlZXlVMjBvSjN4aVBZczI3UDVQZ2Vpd0NrMHpxRDJ2UUdQeFE4NVZt?=
 =?utf-8?B?L0IvU3B5Ty9EbmorTm9FS21ES1p1QzlyWEgzcW5NeDZ2MEtiVkhYZjB1bXlx?=
 =?utf-8?B?YXQvclg4RUhtdGJZbE9MWkFybTNwMlFLdlVrREVGRUNqakxDd3BjVjdFQm9W?=
 =?utf-8?B?T0JtK3lRYTAvYnB5OXBxd0ZIV2RaZ25TSlRVZU0vazFiSDcrUC9IYU1FUWlH?=
 =?utf-8?B?Vi9wMithWko0c1dQaUY0RzZhTC9BUVFIeVB0Zm1xYXAzNExUMVhTWERXam04?=
 =?utf-8?B?NExSOHVpT1djT2VoMDdrSG14NUpqdHZGalVjQTM1eFFaVHlieEx6NWRBMVN2?=
 =?utf-8?B?WGhzWkdRbS9FdmhvSGJydDVkYWVrYUQvb1VOYTM3aWpRWWRmbVdlb1EwNzd1?=
 =?utf-8?B?ZlErVlJqRDI4WkpPRkNLaisxWGp4QlFtZFB3LzZBZXZJUEJ1TURuVmdDWjV5?=
 =?utf-8?B?SUhBUTZFVUVwd0hOQldmMXlwT0lvWlAva3cvL1Y5b2RPYXVzbGRrUERaWWly?=
 =?utf-8?B?cXVWL1ptSUlFSGhvQXV1d2lXNG9GenRQeXlyNGNtYW9rMzMrdGJCQVpWSzZt?=
 =?utf-8?B?N2FyT3FjYnVUYWdXOUVRdDZCM2FZcGRZNFcyNUNsVGRkNFZJRHNpckFPVnh1?=
 =?utf-8?B?YWp2OHYzVVRBT2UzTnlTeCtHQXBrdks4cEg0ZnhkTll5L2JyaXczQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c931bf08-2408-4e61-6540-08dee20f895e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:22:29.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVyw476vvlDtZJQOlyQwZOBWZdMu5stflgIHMmu/PgLuwybnYthWz8KCcHKWQQNQ+Xzup4lU/FnlQmEwGA+Hbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6182

On Tue, Jul 14, 2026 at 12:29:47PM -0400, Aaron Tomlin wrote:
> Currently, dynamic non-array fields such as 'cpumask_t' are mishandled
> in 'perf trace', causing the raw length and offset descriptors to be
> interpreted and displayed as a literal integer (e.g., 'cpumask: 524320'
> instead of the actual mask data).
> 
> This patch corrects the parsing of dynamic fields that do not have the
> TEP_FIELD_IS_ARRAY flag set. By doing so, it ensures the pointer to the
> raw bits is properly resolved within the payload.
> 
> Furthermore, it improves the display formatting for 'cpumask' types:
>     - By default, the cpumask is now correctly output as a zero-suppressed
>       hexadecimal string, resolving the aforementioned integer display
>       anomaly
> 
>     - A new '--bitmask-list' command-line option has been introduced.
>       When specified, this delegates formatting to 'bitmap_scnprintf()',
>       enabling the cpumask to be rendered as a condensed, human-readable
>       list (e.g., '0,2-5,7')
> 
> Fixes: c5e006cdbd27 ("perf trace: Support tracepoint dynamic char arrays")
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-trace.c | 70 ++++++++++++++++++++++++++++++++------
>  tools/perf/util/evsel.c    | 29 ++++++++++++++++
>  tools/perf/util/evsel.h    |  3 ++
>  3 files changed, 92 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ba0f8749fc7d..cd75ac4e5169 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -226,6 +226,7 @@ struct trace {
>  	bool			force;
>  	bool			vfs_getname;
>  	bool			force_btf;
> +	bool			bitmask_list;
>  	bool			summary_bpf;
>  	int			trace_pgfaults;
>  	char			*perfconfig_events;
> @@ -3216,7 +3217,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
>  	const struct tep_event *tp_format = evsel__tp_format(evsel);
>  	struct tep_format_field *field = tp_format ? tp_format->format.fields : NULL;
>  	struct syscall_arg_fmt *arg = __evsel__syscall_arg_fmt(evsel);
> -	size_t printed = 0, btf_printed;
> +	size_t printed = 0, btf_printed, saved_printed;
>  	unsigned long val;
>  	u8 bit = 1;
>  	struct syscall_arg syscall_arg = {
> @@ -3238,17 +3239,65 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
>  		syscall_arg.len = 0;
>  		syscall_arg.fmt = arg;
>  		if (field->flags & TEP_FIELD_IS_ARRAY) {
> -			int offset = field->offset;
> -
> -			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> -				offset = format_field__intval(field, sample, evsel->needs_swap);
> -				syscall_arg.len = offset >> 16;
> -				offset &= 0xffff;
> -				if (tep_field_is_relative(field->flags))
> -					offset += field->offset + field->size;
> +			void *ptr = format_field__get_raw_data(field, sample,
> +							       evsel->needs_swap,
> +							       &syscall_arg.len);
> +
> +			if (!ptr) {
> +				pr_err("Problem processing %s field, skipping...\n", field->name);
> +				continue;
> +			}
> +			val = (uintptr_t)ptr;
> +		} else if ((field->flags & TEP_FIELD_IS_DYNAMIC) &&
> +			   strstr(field->type, "cpumask")) {
> +			void *ptr = format_field__get_raw_data(field, sample,
> +							       evsel->needs_swap,
> +							       &syscall_arg.len);
> +
> +			if (!ptr) {
> +				pr_err("Problem processing %s field, skipping...\n", field->name);
> +				continue;
>  			}
> +			val = (uintptr_t)ptr;
>  
> -			val = (uintptr_t)(sample->raw_data + offset);
> +			saved_printed = printed;
> +
> +			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
> +			if (trace->show_arg_names)
> +				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
> +
> +			if (trace->bitmask_list) {
> +				if (syscall_arg.len > 0) {
> +					unsigned long *mask = zalloc(BITS_TO_LONGS(syscall_arg.len * 8) * sizeof(unsigned long));
> +					if (!mask) {
> +						pr_err("Problem processing %s field, skipping...\n", field->name);
> +						printed = saved_printed;
> +						continue;
> +					}
> +					memcpy(mask, (void *)val, syscall_arg.len);
> +					printed += bitmap_scnprintf(mask, syscall_arg.len * 8,
> +								    bf + printed, size - printed);
> +					free(mask);
> +				}
> +			} else {
> +				unsigned char *b = (unsigned char *)val;
> +				int i;
> +				bool skip_zero = true;
> +
> +				printed += scnprintf(bf + printed, size - printed, "0x");
> +				/* Print in little-endian order */
> +				for (i = syscall_arg.len - 1; i >= 0; i--) {
> +					if (skip_zero && b[i] == 0 && i > 0)
> +						continue;
> +					if (skip_zero) {
> +						printed += scnprintf(bf + printed, size - printed, "%x", b[i]);
> +						skip_zero = false;
> +					} else {
> +						printed += scnprintf(bf + printed, size - printed, "%02x", b[i]);
> +					}
> +				}

Hi Arnaldo, Namhyung, Peter, Mark,

Please disregard this change.

I overlooked 'evsel->needs_swap' and neglected to account for big-endian
support.

I shall correct this and submit a v2.


Kind regards,
-- 
Aaron Tomlin
