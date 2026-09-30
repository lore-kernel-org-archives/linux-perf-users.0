Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020095.outbound.protection.outlook.com [52.101.195.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013864078C1;
	Wed, 30 Sep 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796848; cv=fail; b=KllSlROQt7OD1i9rb1Fg/OI5IVuthiquufAIOsqzeuzAmBCe4r/JHJJL9dmGJ7n3S1VRSZqXaHf/TjWQ/W08Hsr/Q2YiLPIz1ndBf8Tzir9OweF4MN1uaCE8NVVJD9+IVzTfkBMd6y72FHplNSfZhzULCAkAjPAYhagN8yTO1L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796848; c=relaxed/simple;
	bh=sOp7UREycp1WJZHZbB3EjhwcTEhMnd8guExoc/p2B2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l2psZ8fMf+lq5Rkobfq/Y3GbWcCgI57WT/oulICu+kkD9GzCX9K2HcoklLtY9k4z2xoAK+ARqmjNSxb3NuBJaGcdhmAiDHFGf5Kbqey79DD7AEsAbZnS9sFkG75nPn4o94lCJ7gmir9+Tx2U6rHAVv7nuRRBvL7RYcgMrptLVXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzycTSRsgqyEagk1lAOaQNQbuphC5N9yWPDvlsSEZ4GK8IK2rwYyLrs6WpPoT9dhZjXslgdECvoSmqdn43AzPV7rVUruB1soOK/Ew2nIa9mBCIqkU6tJEObdO03CWHHWMiWfPn2VYySx7lfsuEYUfJUIzXge0vxk67RKy6hF97sdAgKNjRqBsn02ZjsRZrXXQkDUnBaWI/H/DShfqoI7uzAdQQfE8wgqJk3+KoBw+Hqg6+gIZ3riZnjha5LtnJG0yvOcU+e3Vq9OnmNnos4urqD3bcUBcUXYCtn4B4M648P1DUFR75LPo6L7B9gojE9bH+Q42WZJxavUK5odH2gX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=p512fZUnlNmJZ/03/I1xb5d2bOiEpGTTXHq+fNQ/wYM=;
 b=Pp9GOSuvWjAVzvJjpC7nL9khBatKNOhZ8mcWj8HK5I4e4ac/LDa/qtiG2rRqxPsO70EOaJNJkE/x/7ff/clR3Bh8iIcxJ8VIsWvDRp+27P2FD4sRXbgjUfXRGs1mR+NH/51Ic35T3TsAGCoaS88kNOGL6aAxnmIk4YHyVnKEanJ/P6CoE7cWwqmZpPrxEUMM/rzoQQ7SAnbfz7WIxthKeCvQ9wwrK6hNUik8kbxzcBVnk8jqVmUzIScfXScMe17VCmq3jDRXc+KydKdhAFJGpKrOIViHOOcb1ru2NTWjoIrYKJZOseBj+mvXwDbbWuizEv9oTSOjvODMOdSchTqYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB8947.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 19:34:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 19:34:04 +0000
Date: Wed, 30 Sep 2026 15:34:01 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Jakub Brnak <jbrnak@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/26] perf trace: Remove unused code
Message-ID: <dok7zgziorchpfhn7tbf3mj4wsua3ipagsxjggrjstfy6wfmwv@xja7arnqzswt>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-19-irogers@google.com>
X-ClientProxiedBy: BL1PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: be5918ee-dc1a-40b5-4012-08df1f29c954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|6133799003|3023799007|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RsHciZtmz0wIz7sFRgvIdNf3NmI7cJLJw+hu3uYq9p/sghpU7FAFHHL40cIJ92i+Q08y2K3PyGJSOGsMOL2wB1i7fbbzCmAkOdACvktVsz2QY7n6WJjrk/hJ8miOdEeApE1vYl2+ZIDpAA1JcDnxdN59pY21mJZZYiKj8FwqTTXdYVQib69nDlPPwdXgLQy7QI6E06J2RdTeqtYvkLSzQO1GA3zQpQxOJ25R1x3Zu0oEhzVV5snBKUpTq3TFSqP+Ivdv8irB6u4TgBThIb5W1BRsMccWHtsI6Pbu3A9zcmqkTVTu3GEyjJaXpkWb/1YzqawF9BPAZnKnKYWMNgwBydyavEQ53uAJgZ+C+IZ9/Gjf0Qk/6c6tPNknTzWMzJszJuQicvtuof+LfqNqXLrfo9JEDCyBUJdohql+G+M8PSnEKqQmTBnHPsvob4/EjATGOVVAYooyusw8YKkbjVq2X8faQhBlMGzyk+Y7TtJSKUJnCw3yHupO0nTsVYdKQzy0FCExp1n/pDsh+WlT1jMiRDg5HMq5EGGKKnd0mHG2dFg3fzZJUSi7jhYYVkss9kpmxfvRqHq65/RIFZ8Dd60agkdCX7ixzZvq9FOJKegMMgzZeyIGn3QKWWdF2x+Qjk8vcbhbcgbILiAf3NCTt8dRmhUQVkQY6w07fERequq29qA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(6133799003)(3023799007)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGI2UTdlSmhncS9DTDJiMGw3bHFpVkN4d1NUQkMzMzVMZjNycUxZQUdWVy9w?=
 =?utf-8?B?SGdxQzNKQ2F3MTJZM3VIWEVMcStwaGRDU2JZd2VkTU5PbmJNWlUwWU9LUEwr?=
 =?utf-8?B?bXk4Sm82aGNpR0xwMVVpMnpYQzhHT0RhY25KaWQ4ck9RbDI5c1REMTFMajdS?=
 =?utf-8?B?WWRHYjNGenJKMEpXN3NqcXUyZFhhYk45dGFhNnFoTCtMUGhQVFdCc2J2aVk0?=
 =?utf-8?B?azF6dFJWaHFQLzg4Z1ArWnVhRXg1cEthaTR0QndocW9nWE1jdVVZRk5STVcw?=
 =?utf-8?B?N3ZZYnYvRUdWVnZkTUJXUkV4MHhxUC9wWk5QVnBJVUJSUDNtWUNPcGhHU3Ni?=
 =?utf-8?B?V0RnYnFZeW1Fdyt2SGJBMmhFaXV5MUpkUE54K1FQMHZINFVTYXdiYlhsN1lT?=
 =?utf-8?B?ZTR4eFFlTi91UGUzUlEwVmhYRW9SNzg3ZE9RM1ExQmx1WGxBYXlGL09YMVIx?=
 =?utf-8?B?VHMyRTBTQUQyUUIwUUdINjhXWTdVS0RUdG8rUHdoRzYrbGMwMFlKSmdlck9o?=
 =?utf-8?B?ODRnUHFUNDhuZnBtOGNhNkhFbHExMHRnZXhUc240cVVqeG5ZanJjS3crQm1G?=
 =?utf-8?B?Y2c0Y1VuU3F3QzRXUmtyU1p2aU1GQ0VndGlmanRJVmI0QUo5TlF4dTNCK2lr?=
 =?utf-8?B?dFNuRUYyUE5GNzZ6SXlBNklaZFR5VjJmL1dJeG1vR0E0Um5tcWY1WHZLaEdF?=
 =?utf-8?B?ZEVUZ0pVdzhNY21tRS9VbExiMkMxYWpJQWVWMnNjOEowUENyeTlkekdSU0Vw?=
 =?utf-8?B?MWVkbWtlaGhaZ1lFVzVaSzA2OXlValBnU3ZBL0tCdm01QzRhNUo5RzB0ZnJB?=
 =?utf-8?B?TlNKZEh1TDIrRnkrZXJtTkZadXdaai9lOG52bFpjSWJIREljb084T011dWdl?=
 =?utf-8?B?QTNURFVOcU84WVlOY1JmM3JTNTRTMFVkNnQwY05mck05NElyb3NreGpPUnl2?=
 =?utf-8?B?S1VPT3JmdW4yWFBxUHNIejNHUkhPMnNGU3ltWU1CTjV1c0RmMVRDR0w4NnhG?=
 =?utf-8?B?d1M5bFdQVElPZFU2cE5paEl0OXJLOXJRSTJCaS9JUHo0MjhBdXdRMG83akFz?=
 =?utf-8?B?N2ZyeFRzYjAyOWpNMEVjQzBFUEFnMFlBcDh0YkErU0tvTlZwdGl4VEp4ckhC?=
 =?utf-8?B?VDAveVlqbVZuQStINk92ZllSaWtJT2FxckRHWi9yTUk3eXJRVVBOQVpiNEUv?=
 =?utf-8?B?V1VnUlF2ZURnZUh6YlZMaGdPeGROTWJ4VERCaXVPbXYycTJWbEJPeWRoVGpU?=
 =?utf-8?B?ei9qaVIybkVDdWxLUCtEdnpOQno2RjFwYVVKYWZPWjNlNnFBTlJLbmVuVEhv?=
 =?utf-8?B?WE0rSWI0SnBRWnlndzhHa1F4MkN4enRrWVMxNnhtTCtMWkdxcVQ5UVBGTmdj?=
 =?utf-8?B?L1ZKTnVKOGNtYnJMR2tzOUxobWQ1NE9HZndoMFVxY1FsZHJHMmY4MTNXZHV4?=
 =?utf-8?B?QTFUSmJORjg5dCtGZmhuY1o0YU5Fbk5tamlWcGpYSnFKWE90bXI4TmpvZUFt?=
 =?utf-8?B?ZlliOFRrWXNudHdVejBlZWUzbHlVL2g4aTh0K3pUT0NuMWJqRDBQRG5TMHV2?=
 =?utf-8?B?Q0lVVm1vdXJjRU0zbCtXM2hKNEtFdmppN1RCU0tFSGF0MGQ4V2RObmJxOHBM?=
 =?utf-8?B?bkVmeGNtdU1mZWdhY2c4OHFHN0tOR21IWnhWbHhsakVySTNvbUllcUJKYnVP?=
 =?utf-8?B?b3YrNWUzREozL3RXT21VcWRCM2hHLzQ5RUxvU2hVZENMU25hN2dCd25OTG5n?=
 =?utf-8?B?WFlXUExXNDV6S1F6N2g4V3NvRVBWNUdRV0NCbFZjaUlOTkxKL1ZaRzVaWURU?=
 =?utf-8?B?VGtpckZJdFhJMFhtRDhobDh3K1JONWEwVmpEa1hxREJ1RUNNOE1MenUwQnJx?=
 =?utf-8?B?Y0Y2OGJxWmpDZWRxK3orejdzS1hZaWNZSWRzYWQyVmZGVVhXYXZvc0JiM256?=
 =?utf-8?B?L2hDRkxmUG5vbXgyWjhHMTQ1WW01NldXRnVoN2M1OWkxUHFjUG1sR3JzczVu?=
 =?utf-8?B?dEtaZlJySDdUV0I5YlU4bml6SGxJWmdiQ2YvbWZqNlBzNmFDTlpUTnZPMU5N?=
 =?utf-8?B?Mkh2UXh4ankrZWdVVk9DVzFnQVpMWUJGblFReDhKcU9hY05mRVlGeEFUM3RQ?=
 =?utf-8?B?bTFPT1B0SWRpbVFLMkxObEpTRi80ak1OWUZkSlhLcFdTRm9vWTRWOTR4SXhO?=
 =?utf-8?B?bEFYaHhuWkt6UXdQWnJkS0V0bkpYa3pXRTh2WHYrVVpvQnZMMkJNRG95ZzlT?=
 =?utf-8?B?cGZObWVJcnluUHNUTkI1SFJodlNsK1lvL3I2M3RSTDZEQUtVblh1OThIODNj?=
 =?utf-8?B?bmJpb0thT0t4YUVMa0h6VUxQSGtzRlR5RTJGNUx0NXpBNGNuWFFJZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5918ee-dc1a-40b5-4012-08df1f29c954
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:34:04.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQvVX5+w825ualOy2cKsyqrtuVIwEE+nhQAp4HILmkRDtup4I5Rw8lDoNWhlNvJ15Dch72NQBxsOPvVYk1wcPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB8947

On Mon, Sep 28, 2026 at 11:25:57AM -0700, Ian Rogers wrote:
> From: Namhyung Kim <namhyung@kernel.org>
> 
> Now syscall init for augmented arguments is simplified.  Let's get rid
> of dead code.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/20250814071754.193265-5-namhyung@kernel.org
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c | 110 -------------------------------------
>  1 file changed, 110 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 3dd40f3c3cbb..1be355a3ae22 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -490,38 +490,6 @@ static int evsel__init_syscall_tp(struct evsel *evsel)
>  	return -ENOMEM;
>  }
>  
> -static int evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evsel *tp)
> -{
> -	struct syscall_tp *sc = evsel__syscall_tp(evsel);
> -
> -	if (sc != NULL) {
> -		struct tep_format_field *syscall_id = evsel__field(tp, "id");
> -		if (syscall_id == NULL)
> -			syscall_id = evsel__field(tp, "__syscall_nr");
> -		if (syscall_id == NULL ||
> -		    __tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
> -			return -EINVAL;
> -
> -		return 0;
> -	}
> -
> -	return -ENOMEM;
> -}
> -
> -static int evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
> -{
> -	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
> -
> -	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
> -}
> -
> -static int evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
> -{
> -	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
> -
> -	return __tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap);
> -}
> -
>  static int evsel__init_raw_syscall_tp(struct evsel *evsel, void *handler)
>  {
>  	if (evsel__syscall_tp(evsel) != NULL) {
> @@ -5914,7 +5882,6 @@ int cmd_trace(int argc, const char **argv)
>  	};
>  	bool __maybe_unused max_stack_user_set = true;
>  	bool mmap_pages_user_set = true;
> -	struct evsel *evsel;
>  	const char * const trace_subcommands[] = { "record", NULL };
>  	int err = -1;
>  	char bf[BUFSIZ];
> @@ -6080,83 +6047,6 @@ int cmd_trace(int argc, const char **argv)
>  		}
>  	}
>  
> -	/*
> -	 * If we are augmenting syscalls, then combine what we put in the
> -	 * __augmented_syscalls__ BPF map with what is in the
> -	 * syscalls:sys_exit_FOO tracepoints, i.e. just like we do without BPF,
> -	 * combining raw_syscalls:sys_enter with raw_syscalls:sys_exit.
> -	 *
> -	 * We'll switch to look at two BPF maps, one for sys_enter and the
> -	 * other for sys_exit when we start augmenting the sys_exit paths with
> -	 * buffers that are being copied from kernel to userspace, think 'read'
> -	 * syscall.
> -	 */
> -	if (trace.syscalls.events.bpf_output) {
> -		evlist__for_each_entry(trace.evlist, evsel) {
> -			bool raw_syscalls_sys_exit = evsel__name_is(evsel, "raw_syscalls:sys_exit");
> -
> -			if (raw_syscalls_sys_exit) {
> -				trace.raw_augmented_syscalls = true;
> -				goto init_augmented_syscall_tp;
> -			}
> -
> -			if (trace.syscalls.events.bpf_output->priv == NULL &&
> -			    strstr(evsel__name(evsel), "syscalls:sys_enter")) {
> -				struct evsel *augmented = trace.syscalls.events.bpf_output;
> -				if (evsel__init_augmented_syscall_tp(augmented, evsel) ||
> -				    evsel__init_augmented_syscall_tp_args(augmented))
> -					goto out;
> -				/*
> -				 * Augmented is __augmented_syscalls__ BPF_OUTPUT event
> -				 * Above we made sure we can get from the payload the tp fields
> -				 * that we get from syscalls:sys_enter tracefs format file.
> -				 */
> -				augmented->handler = trace__sys_enter;
> -				/*
> -				 * Now we do the same for the *syscalls:sys_enter event so that
> -				 * if we handle it directly, i.e. if the BPF prog returns 0 so
> -				 * as not to filter it, then we'll handle it just like we would
> -				 * for the BPF_OUTPUT one:
> -				 */
> -				if (evsel__init_augmented_syscall_tp(evsel, evsel) ||
> -				    evsel__init_augmented_syscall_tp_args(evsel))
> -					goto out;
> -				evsel->handler = trace__sys_enter;
> -			}
> -
> -			if (strstarts(evsel__name(evsel), "syscalls:sys_exit_")) {
> -				struct syscall_tp *sc;
> -init_augmented_syscall_tp:
> -				if (evsel__init_augmented_syscall_tp(evsel, evsel))
> -					goto out;
> -				sc = __evsel__syscall_tp(evsel);
> -				/*
> -				 * For now with BPF raw_augmented we hook into
> -				 * raw_syscalls:sys_enter and there we get all
> -				 * 6 syscall args plus the tracepoint common
> -				 * fields and the syscall_nr (another long).
> -				 * So we check if that is the case and if so
> -				 * don't look after the sc->args_size but
> -				 * always after the full raw_syscalls:sys_enter
> -				 * payload, which is fixed.
> -				 *
> -				 * We'll revisit this later to pass
> -				 * s->args_size to the BPF augmenter (now
> -				 * tools/perf/examples/bpf/augmented_raw_syscalls.c,
> -				 * so that it copies only what we need for each
> -				 * syscall, like what happens when we use
> -				 * syscalls:sys_enter_NAME, so that we reduce
> -				 * the kernel/userspace traffic to just what is
> -				 * needed for each syscall.
> -				 */
> -				if (trace.raw_augmented_syscalls)
> -					trace.raw_augmented_syscalls_args_size = (6 + 1) * sizeof(long) + sc->id.offset;
> -				evsel__init_augmented_syscall_tp_ret(evsel);
> -				evsel->handler = trace__sys_exit;
> -			}
> -		}
> -	}
> -
>  	if ((argc >= 1) && (strcmp(argv[0], "record") == 0)) {
>  		err = trace__record(&trace, argc-1, &argv[1]);
>  		goto out;
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
