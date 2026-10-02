Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021080.outbound.protection.outlook.com [52.101.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000BA1D4606;
	Fri,  2 Oct 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971502; cv=fail; b=apZj5cFk5YvCRM+AMQuBD+UZODcXVPmlSBvxMdrjnwpIJWEcq9tE6uUjfxLf2AXdX/Vul8a85oLn9Vux2csZfpL9Ut3R6owr2kH9c3CLVUVxTzphQZuQkBa/X5aoXUgUC7qsImlyQbSqPJn2NYwlIUCuuiaqVVhRS4SNBBoRD24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971502; c=relaxed/simple;
	bh=cXZX8oT8zMQUe2E7PVRSUUywktCjTLwf4Il/q3gQyg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kcgf2T+Tu7/zp4uZF05ukkNNcl6zRiill6bfz9qdkjo/xbuidPPB1RqRcxTCZ6O+QAdT7E5PsPyfIhqeVZ2qgEAimnUQKBFx8XRx/yJk3xFgLtDaXTGeZyv0ICt05JhniWodiyjA3kzs/7DI7w4Lj4fHletmAey5FkXO+brjvYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3Wd96xLyvZjldek1NtcVngnBQb78+D2gUoJ6l79iNX7/NARPJv5jp+S0S+R62J4uGTUVzi1tb1cy00d+/HwvhvrR8jLfjStvopPeJhCigYb7qJ0xDRyuNx9wysH7rlsyNTYC2uC4xtiabsu8E//Fzjd4gfU+6UxmLSya3BVeak0+eGbFCXU645UfsQ7s8caeJ69dfVNFEben6800sltCVTL4NnPM52A5vcYBpwfdwW/E385ZYQz6qJH2Y0fgGPUaN9KqlRpMJhn2X7vMvQnV5+XLzn/vwuJYLyG8c1Nb5XICeUQRAnlxfi8lNtFOWYb+RKmjNqB4WzN3EzmmRmFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Cul6XfLpJrIgbeiN4aix4ufzxPlN5O1o0Ol6lWFtB3M=;
 b=jj1kas9TLnt8xFff3WtEB7YJfIAGuQGwFW+idrNJ3epKxtUxzaMY1d55kEf728PoWHs6JtoDlD5bq1cr/9jS3mWeGbaSJREtsgoy/Pyncxu78eiotEX42ArmfUsojmOYNvJrMbewnz+PF01FwcQWmN+2783epsnBpeh4Y3oh6R1YsoL0sxIuoXij5QZrQV7AOxx0SFAJ7+9K2u/KJg91bnSZsddjyxC8sVH9LfO1XwNB8V6+CExTiy5e6/V4mgXGpVa08WM1AMAP/fAil4J3YL7KakVddE+7WMOGhquAHOT+9hu6ZOCoPp4hAU4XONf/evsUcPXXcpinoiTOQHY6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LODP123MB039761.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 20:04:58 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 20:04:58 +0000
Date: Fri, 2 Oct 2026 16:04:55 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jbrnak@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 2/2] perf trace: Increase TRACE_AUG_MAX_BUF to 128 and
 document beauty_map encoding
Message-ID: <awkujkle2sr4kxqr3jrc3vihoioiwbigrr5g2rppyvvdntonxl@3gtotu7ih732>
References: <ar6nzTSj17IxCy0j@x2>
 <20261002065440.2781176-1-irogers@google.com>
 <20261002065440.2781176-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002065440.2781176-2-irogers@google.com>
X-ClientProxiedBy: BL0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:91::40) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LODP123MB039761:EE_
X-MS-Office365-Filtering-Correlation-Id: 0213d3bd-6f75-477a-3fd3-08df20c06f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|260925021911599003|260925021311599003|260925022911599003|56012099006|4143699003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3yPHE8WLUuyyisfIzGqBLTMCIEHn0O4S1b5FzbksT526vsQTXL5or77rBa/pRaQ6+yFVnNpQE/buuXaX7i/cpBbphaHoDQqeBWnwzIguLDRGui/4icQxPFIeixOjhnGJd4VlUx7oL8LYgJQH/s/CPgzdxF/3OAlZYMdWjrG0nGWMG+KvYwERsXzBzM9xugE9oKSNoyZt8wakIbK15XvornWBLW3hmD5oq+YQBTQkJRvg8LrVTcbkiFz0ftbbWjhyaeu0WXI7lGd0+LjyWNORNmYt4KMGMV522rNr+VEjCsK9YLvArs3YzM14OPuINt286zfLBlesfdPouXfZxLNBgG7uhckjBFrqD1lkv85GrQ/Bz5rh0mc221/Fu4Q3n0LIw+QRIWs0/yOYxHAqrP40ZNj1574Y8uLPaYTovQe79/CHl5tZhFF0nZzXb8VaD1yXcoOigbI1A/XVP5WNFYfkrX6iBtnBdnbFIBDnoNIU7HN0L8iVowqE6pf70gSd4SJ1WjlOQHpYedANcV6p/8S59WQwN1jvnsG/4OM9Uk0nuE5ix2bhczcDHNE0VfMSFAiwz0CQTNXkUMU4VMInbcaQDfKe5wW5eHhufpoXQugr5AQrFcS7XaibrIgn3ptQK3p72tAW0RVYAxLeXvyyKulks7T6sJoXpvctOloLldTEctg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjd3UnZkVEwwbEl1cnZ4QlNjQk5rQVNJQlNnSC9Ya282aDlKa3ZhcXZhUkNw?=
 =?utf-8?B?SVJyNUJHMFdwNzQ3Q29ERWZPS3IyZHdpVStXUFBEb3dpT0IycE4xcTQ4a0I3?=
 =?utf-8?B?aUhBRDdGem4rU3J2VjRuakc3TUVnOGE5SUNyMlhHdmFEbVVnMEVaQTZyaGlI?=
 =?utf-8?B?cG9laytIanY1R3Z0aGJNYzkvUzhlZURPTC9qaU1mQlBmaFFBeEh2NGwrNXFi?=
 =?utf-8?B?cVNIUCtHTVdDcWR2cjNmK1dmTmVqVE1EY0ExRXVwQU5aVVhjZS9LM3EvNnFN?=
 =?utf-8?B?SDk2Umg5c05ESWVzSmRSZ1RxMEkvSVZYSDNjZEM5Rzc0bGNRMmVDSnQ0SDk4?=
 =?utf-8?B?ay91NkxvQjRqTFFjZTlkU29idHFtWE5sTGsxNEFMNEhLTzJrSUQ2V1lDNDBt?=
 =?utf-8?B?MTY2MzIvUytqQjk5LzJFZXVCMkx0Smh3K1VjelNuTmJhMmJHeEpkS1A2cE0x?=
 =?utf-8?B?MmhvakhyekQwbXpKcUNicG1KWHNZdkZ3SFh3UEdqdUYyWEFLeVRlMWJRdjZW?=
 =?utf-8?B?d0NuQzhZYmlpc0RQSFFaY0J4V25YZ1g0TEpERTFZU053REF3WmRBd0ZnbStK?=
 =?utf-8?B?alY3a0p3NWR4RVNTNnpOUEZPcWlLY2g4eHJzSDdvKzc5czlkdDNMV0xFT3Qx?=
 =?utf-8?B?dzlqOEFZYzJxbDVCVjExZ2VBTllseTRJU3M4RVA3SThFa0pTRVQ0dVRkbmtL?=
 =?utf-8?B?UnVXbVp6L0VoQjMvbnlwRVR0NHdqMFltQzlHNHlCbitXWkJpdkErOXByQkZm?=
 =?utf-8?B?T0s5VUkrWVh4bEgzTWVMWVVKandNb0NsQklyb0t6czdsdnh0Yll3ZlhQOTNW?=
 =?utf-8?B?RkhHZjlJTVNRSzdPeEN4dSs0RmtjK29obzc5RzNiR0FJcWNMVkF6WXBIZnVp?=
 =?utf-8?B?dlFiY0FJbDJkTVorWUd3NjRTV0kxV05FL2xBZFlIb1dieHM2UG5ydmFrRVVK?=
 =?utf-8?B?aVpWVWo5K0lWdy9LVXN3aHpyUVFrNmJFeE5mcHpIOVZscDliOWN6OUdhSW53?=
 =?utf-8?B?emo3V1lWNGxJY0dCVE9YdHJOUkhDREdIdUpZZHpPUVFzNzd3V3htY0dJUDh6?=
 =?utf-8?B?NVZDNzI0YjdvSGI0dFlCc0JFZDdSRVMwdE1mOWxkV2RhcjFWU2pFSWJBUG5U?=
 =?utf-8?B?ejBQT3hOdzBIVzZ5cGNhdzIzRkdpL25CRjJVeGZHWTlhbTJDOU1KeDdmU1pJ?=
 =?utf-8?B?dS96eW4wL1YvUzB6OGJPVWFRLytZKzYzcjZ1allzQkd5aHJndVY4UXN0VDI0?=
 =?utf-8?B?cTJnd2NrVVhTTzJ5c2VqZzh3SmcycDJHNnhMOXZoQ1JtdjdEZ2lZNitYcXU0?=
 =?utf-8?B?YlpxUjZLdFBFSVVqem1VSWxJZ1NkQXBqOTZld090ZzNNdExneHdtcVJQT2xx?=
 =?utf-8?B?Yko2Y0JrKy9CdGNPTkhWenFMUGNlUm5PMHR5anVyQXpGQVZtakszYTFVLzIr?=
 =?utf-8?B?Y1p3WExrQ1loU1FtVW9OWnlzdjY2b1h4amgzTDZaeWZuN2h1ZGZJVWt0RDVo?=
 =?utf-8?B?Y1MyNHhyZUZYdlEwM2dCc3BQMWVFRnB4ZUhsWTk4M2pZblYzVVM3cFFaK3Q1?=
 =?utf-8?B?UHZqeTcrRGdhenNPdkd2Um1jWlFPd0NNSC9ZY1YycUJkMDVHRW9MblpkY2lK?=
 =?utf-8?B?N3lHM1FubTdzTTZYSmpuTzFjbUVnQ3E2UkEzZTU2TG1Pbnd1RDk1eDJ2V3Mw?=
 =?utf-8?B?M280empLUjNEVVhaWXIwNjA2SkppWXo0bFBjTktvc3MxeHJ4cEdHYVpibXFr?=
 =?utf-8?B?a1FjVzN2bkJwb0tRVlVsZDFZdXJTK1JsMFlZMEp2S2tROXZPa3Q4MkgrUE1L?=
 =?utf-8?B?NENuNjRsYWxFVExFMHRkV3lyaXdXWnU1dG5ucDMyYkptZkRrZHdMQUNHTkMx?=
 =?utf-8?B?b3VWdCsyMmNwUWxtREFtQ3ZqMGJYWDZneVFYeS9LM2dkRVl6eU11YXRMSmlu?=
 =?utf-8?B?NGhEUkVSUWswWno4QUJDSjF4U21wMFF0YVdsKzdHNnhPRC9MeGdLZ0FERGpM?=
 =?utf-8?B?bWY3Q014OFIvSDlId1lFblk4N1R0cldMMHNxUHZkaTFFdjlPcXp4cXFnL2V2?=
 =?utf-8?B?aVh2MlEzcjdKY2NsNkJCaTBhQ3hUTWZ4UVU0ZGV3VWgvY0pHMmZ3WGVFTkl3?=
 =?utf-8?B?cEFPZVNHZW02Qm0zRXZyTTRmdTNObWZYVlIxQm5TaEZSUEUrZUhycEx6OGtn?=
 =?utf-8?B?eGtMZkFTVENRWDVHSml1NWtPWUsxd09kYS9XV0psY1lCVHNOVFh0cUVidEZP?=
 =?utf-8?B?dzRWKzV2N3JZbzVnM2VVdXJ1ZkpHTUVYd2ZKVGxwYmRzb213aHF0K1prTkhz?=
 =?utf-8?B?SW5TVWRNWVZTeEhtcG5hNVFDbmNVbTlaekh0ZkRDMERKUkk1STNxZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0213d3bd-6f75-477a-3fd3-08df20c06f44
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 20:04:58.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/m3NmlNEoBcngXN70IcsyopXmbI1vaQWkkLzmg0TzLb1kxukGDb+aqJ4+kCQ7+NqzNKiZ9KBUVlJSK1jSlUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP123MB039761

On Thu, Oct 01, 2026 at 11:54:40PM -0700, Ian Rogers wrote:
> With sockaddr arguments copied as buffers via beauty_map_enter, the
> 32-byte TRACE_AUG_MAX_BUF limit only held 2 bytes of sa_family plus 30
> bytes of AF_LOCAL sun_path, truncating longer socket paths such as
> "/var/run/.heim_org.h5l.kcm-socket".
> 
> Since struct augmented_arg already reserves PATH_MAX (4096) bytes,
> increase TRACE_AUG_MAX_BUF to 128 (SS_MAXSIZE, the size of struct
> sockaddr_storage), which covers all 110 bytes of struct sockaddr_un
> without changing map sizes. Also document the 1-based negative
> -(arg_idx + 1) encoding used in beauty_array for paired length
> arguments.
> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c                            | 8 +++++++-
>  tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 8 ++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c34c9f129836..4094141461f9 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4174,7 +4174,12 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  				continue;
>  
>  			bt = sc->arg_fmt[i].type;
> -			/* Copy a sockaddr as a buffer sized by the next argument, e.g. addrlen. */
> +			/*
> +			 * Copy a sockaddr as a buffer sized by the next
> +			 * argument (i + 1), e.g. addrlen. A negative entry
> +			 * -(j + 1) encodes the 0-based length argument index j
> +			 * as 1-based so arg 0 is -1 rather than 0.
> +			 */
>  			if (strcmp(name, "sockaddr") == 0 && field->next &&
>  			    strstr(field->next->name, "len"))
>  				beauty_array[i] = -((i + 1) + 1);
> @@ -4210,6 +4215,7 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  				     strstr(field_tmp->name, "siz") ||  /* size, bufsiz */
>  				     (strstr(field_tmp->name, "len") && strcmp(field_tmp->name, "filename")))) {
>  					 /* filename's got 'len' in it, we don't want that */
> +					/* 1-based negative index of length arg j. */
>  					beauty_array[i] = -(j + 1);
>  					can_augment = true;
>  					break;
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 0b2ef9541f84..28ebb9a72776 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -28,7 +28,7 @@
>  
>  #define MAX_CPUS  4096
>  
> -#define TRACE_AUG_MAX_BUF 32 /* for buffer augmentation in perf trace */
> +#define TRACE_AUG_MAX_BUF 128 /* for buffer augmentation in perf trace */
>  
>  /* bpf-output associated map */
>  struct __augmented_syscalls__ {
> @@ -514,9 +514,9 @@ u64 ZERO = 0;
>   * value in the beauty_map. This is the relation of parameter type and its corresponding
>   * value in the beauty map, and how many bytes we read eventually:
>   *
> - * string: 1			      -> size of string
> - * struct: size of struct	      -> size of struct
> - * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
> + * string: 1			          -> size of string
> + * struct: size of struct	          -> size of struct
> + * buffer: -(0-based index of paired len + 1) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>   */
>  static inline int augment_arg(struct syscall_enter_args *args, int i,
>  			      unsigned int *beauty_map,
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
