Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E351C040;
	Wed, 30 Sep 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792454; cv=fail; b=cxcpvzrs2mOuBpbzcua3hb7CWYcGsIfFj21wDR5O9jAbcjVdMI+Ty9VGAqh0CrXyZ3parTKSdLeS/pFYk31gR17KDBfAP5ZExzG9LUbIzJOpIbvdv7efNUFyHGN1fyCcKz7TtsH1SMZjPxyjT3EWNEWOI09ECuymYe85HovYFgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792454; c=relaxed/simple;
	bh=GuLCXqNlPYJ/igsH64IVA1gCSVoavuZNublHJOZc2wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ma2PWtEwWX08NAznyZtpfGX2KCcaggqQdU2Tuw8noTlNtvRpxSX41rUq6lye9rz6NlddrhlXynbB8TH1hN+6FFxu9fDnCdRDRUTNmhEqLLpwqnxig7VTAFpq3cfDRjEitDmEjreZyLRYAs9T9jAbls3jU+DQPd3jOr8dwE/ZEMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTWBxRvJCg9gFr1W+s0Ir8Ln51DvDBuxCezpDj2U/NsksY2BnYAi2XkcDjt4k8IQIf4bcKMAICIbzsrR6k7FiVk7iwvmnClACM5vaLSHneZYepank9djC5ql1zF0kQkYFZmv/JmisgsYPocB5vVqWWt9udOftJcz1uuX8A42hoj0zA19JX5ShixeAPiaaHUP9PUfjh0DtCG5zcf5ZJvbtWuAUMYMBhtcrcZ2Rh5p+kFgKDXexzzDtxA+3N7+6IH0O3F9/qKnmSavT9BrQy1uh6gf6gQhxEkECwsScaxCNcTs8uVTqILrY2vebT4C7YNQ3FZP6k4/6JtmiU3ySChudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=xHa2zAqWsmd7YhuOvEz10yUDzSuCJPvWGlhjs79GQ80=;
 b=hwipn2WIrTPVeYXG/jL+4R8XfGzewToiediwbcCJRDPaD9t1s1zS019mxDPmCfcdcvACH4zqmFD+AjwuuO7e6CWuqOC4Ga9etj2IdC+tEesqGq+Xw9xVJQ7LOjw6XOJ1+l5ki9+OanG0/2zhd6x4ggkjG5YpNNhNv49Qf9qNMsvYWWgiI59FnTApgz1KOTq7vT5kM6Q4lsDSsSSkpFubrBLUSww6aSCwLm6RTPdEc2eUF/Cb8QTouGvovicRjpGhD+kKjnt1lKB93sLJeNAzsYGNjUkeRmasVQ7MMK2E9eHC1H3bOFC5I61F0Hk7Zox2XegCwhSnlftQSbmr3WbRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB6998.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:343::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Wed, 30 Sep
 2026 18:20:48 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 18:20:48 +0000
Date: Wed, 30 Sep 2026 14:20:43 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Jakub Brnak <jbrnak@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/26] perf trace: Bounds check augmented arguments
 before reading them
Message-ID: <tmdefnif2mxxe6ul2ljhofoma6dm6ljymkdzcws4o6p5ozxtro@ragt2whqbwap>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-5-irogers@google.com>
X-ClientProxiedBy: BN0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:408:142::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 36768ec2-5572-4ac6-e936-08df1f1f8ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|22082099003|18002099003|4143699003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	crPUxHkhrww8KXG/pUS3a3HUiVOjidGp0KqXwOzYw64vv0QlNww+amiyHTuZyGVOHmO+luZuEAwrmYoy1rNZJNZWwffKUW1AqxBIYqW+zQkXVgv9fqmidzCE206Q33e1Vv+dQQrkDis4N+x5NJCMO+MgsS7B6d1H3QUdOKnjEfXhnpHA74Pc0h7ZgkP6bj3rXsEEgor6rpgcwgsF8TSX2Wy7OxN3VcEAN4n6vTmReCuxfnlVSrwojWovvNWINasaIa67SwHW3ttI0hmpR/mAfwwKW2485dEM4LsxsxnZWmelT3WRKlJ9qI0ri416A/yam7Np6vjD0qGyRx9RxOAkiUzb1vYGtZlKRqgzbfaQxeM0ovAtXD+2fTBwK8jveR7ZZNrRqF1zwPbxnA3+v+kYeVvXs/zdWYYN90KvlUpko59lD+IPI6iJ+gkHcAPR/+B9FJ0852Fd61OO65y+wWrsIjR+buM06DWdHntjnHvvb4lQjM/kqUUxFpE9drPcfLuvgkMHiA76gydlPX00y5cYFO/AVmR5EskdH6GIZvfczLbd3H3+QHAs/ZJ2ty62LPrYO4TbhAK/3PwhMoyzizX+xl5aYyqNajabWFBomAKVDNNIiuNawj+nnWwvD/wifZ+qxh+wywFE/q8NUQ13EOOQZ21JAHr0Pxw5tl4zVJBbeyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(4143699003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmZpV2ZtNzN3ZWs1YXgrVkZwNVYyMEZQcEk5c2FnZWlVNk9peFduRy9WTllS?=
 =?utf-8?B?dTJaTDRYczI5YTBKSUI3dG5KTE5mR256b2dIQTlnV2xnY1NUd1BXTmxDRnF0?=
 =?utf-8?B?KzI3aXd5ZkdwSkJ3QzMzL0xiaHFIMFIwRVdud0F0UVNUb3VKbndlWkl0TExL?=
 =?utf-8?B?akpETkVQTzlUT1UzV1VlRUgzUVZxMmhhYm5YZmc0Ync2VHllSmU1L0pEM05W?=
 =?utf-8?B?S3ZHbjZlRjNEa1BrNEllRXQzYkFpdU9PT01NQWQ0MmN0ZmtDMGU4VENZeTBi?=
 =?utf-8?B?aENLMy9BZkdTVnVaY3JYQkdDcjRTSDVaZHlmZG11d2Z0cWR5cnJPZ0FqVUJo?=
 =?utf-8?B?eFY0NE53QWpjSEh2UlA1Y0dxWWtDLzlnR1BKdEs4OEVwU0VGWXZSOENZZGl1?=
 =?utf-8?B?eWZ1U0s0OVBFc3Z6MFNwMjV4cXhZR2plTGd0eVY5OEc2M1RFTGRaTml3eE83?=
 =?utf-8?B?dVVoYWJnVTk4Z1lNWElmUkt6ZitUT2tDK0VXeThrei9IZFhmcVJpVGEwaVNK?=
 =?utf-8?B?a3lVVXAwaGp0VlFFZ3RaTXJHWWpWWmp2c096TkIwRGlLbjd4YmR1ZFRJTWda?=
 =?utf-8?B?UmVoTUdmRzlxdEhFQldIWmpXVyt6UVEyNnpkV3dHT1drVFNyYThyQXR0T0RP?=
 =?utf-8?B?U0UwTnVWNWJWN1RVZVZWall5MStjclgwQVZVb2E5SGxEVE1tUStkR1VYb0hD?=
 =?utf-8?B?cmpBVEdBRzJkaVMybmlKSUpWWlhSVTQ0VWcraXZCcldtNmFMVmZEeWV4VEV0?=
 =?utf-8?B?QlNwbHJQWkhKS3NWVENvb3lqMEFwRjRyVXBWOWVUZVlGODVJek9Cb2VEMzRU?=
 =?utf-8?B?azlTdTlBZ0w3eVhHL3ZLN3FqTEY0QXc3YUZqdmI2Z0pnMndwVU5zSkx3TDY5?=
 =?utf-8?B?Vi9RVE9TeUFYZ1dvZ3VuTWMrZzBRZlRPcmpEWjJWdlFuOEo3STFkVW9CWlB6?=
 =?utf-8?B?S3VjaUt5dkF4K2VtZGhNL2FyVHdrenBHamtFblVEeXB4TVlJWmJZV0o2ckpy?=
 =?utf-8?B?Y3lhelNjbGppcGFWdHFONFQvRHA2SHltem9LcVlnMERndUFabTVKaDA4S252?=
 =?utf-8?B?bklxRG9YZ2RkQlFERVliVTg5bmdHRmxQWWIzUzFwWnZZV0xZTitTenZGMFB1?=
 =?utf-8?B?cWo2ZUx1TUZ6ZldWcGZjalA3cVRjTFlqNitZNGVLZjlkQ0hFOWpzNXFFaTJM?=
 =?utf-8?B?MURaWVZEanBmTkZDYWkvdHlIa0cyRW1ZL3JyZzJRdHUrekRsT0FMOTBvR1ZI?=
 =?utf-8?B?K0dIQytRZzdPVXZyVUNkVVhDN2Q1RTVqOW45SThBS1hZK3RyUmhFR0hzM1BO?=
 =?utf-8?B?cEpoWXdlU1hiMStJZitXcHlGTzRTVzBTdGZKQTUwVFZWWExHVGdlWEpqc05i?=
 =?utf-8?B?VmxXQTEwZGxDKy8wM2EvOG1QQXJZbVM5QzdVMGJTSldsb3JDZ0lCU2lKR1c5?=
 =?utf-8?B?RDk1Y0VDSThneElyVjFHSzI0R2FIQ0NycjAyUWZFRkU2Wjg0TkRDL1A0ZHhU?=
 =?utf-8?B?Ly9TQTJLcHE3Qi9Ua0JlVVVMSmxXa1lFV1A0Z1o2clZkRlIxMVNxVVhDaTc3?=
 =?utf-8?B?NGN2T21BZnMzSmxVcmI1dTYrcENQVVRwc29ySmlTUFp4dWF6RmxqRUJZYU9h?=
 =?utf-8?B?a1hvQ0lrSngyRlhZQXBWKytpQTRaajFrb1pqWDVGQVZqSGZya2IxeE1yeG9N?=
 =?utf-8?B?QUlzell3V2RXajRadFR2bkRpMEx6dXJnWnAyQ09TbFdoVFdhaERDR00wLzI2?=
 =?utf-8?B?YXFLbE5HSThyeUN5RWxvS2FHb3hJeTRmckxZK3lCZldOZnd1bklmT0dqOFcv?=
 =?utf-8?B?aDB6Y1hLRTR0cThjOWZFMGxkUXdRQ3NYZEhzL1IrWTE1Nk0rQmVXcTFoV2h6?=
 =?utf-8?B?SW9aZUoyU1NvZ0VYNzZpTUN1b0RKRENBa1FxYjRaTVNWenhOdkpBVnVaU0VF?=
 =?utf-8?B?NUh5Zi9xa3o1ODNIUkVrbU1MRnpuY3ZsYk9mdWFnMXNxLzRIK0xDTUZPdnZj?=
 =?utf-8?B?d1preTQyMWd0SHd0OFByVEZEN1A0WURUclpEVkhQMjEyb2cydm00TTl1RlJu?=
 =?utf-8?B?Rk12ZzFHUWFkdWFpQ0gvTmdydmNkdUM2VlU2QUZuZUhyeE5nTnRkdzh2aWJR?=
 =?utf-8?B?M0ZsUGxubWJ2N2pDRjRWQmFMSWtWMTRCTm5SRVprakVoc2lXNHVuRFBHQzYz?=
 =?utf-8?B?cFErd2JCcFUzRG12WGNqTEhjV0NaQTVoOURLdUhSWEVGSkZIWGxUa2ZoMWhq?=
 =?utf-8?B?dzVHZ3hyR1dTczd5VGs0YVp6ZndpV0tDTkEzWHZFN0VtdkFIUjJrVmlMajl4?=
 =?utf-8?B?V3dqVXdlZngwUnJmVXBPaDhtaStTVmdYMm9UVUdUNnVHL2NqRGNGUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36768ec2-5572-4ac6-e936-08df1f1f8ce1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 18:20:48.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl7xVZ3hMGHRv8mXWTD9v9RCal2PZ80q/o6M/DV2z0wh+kb3l2vZBTLxRZOQXguodb19KLdw1w5hjsA552jGvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6998

On Mon, Sep 28, 2026 at 11:25:43AM -0700, Ian Rogers wrote:
> syscall_arg__scnprintf_buf() and syscall_arg__scnprintf_augmented_string()
> trust the augmented arg's size, so a bad one reads out of bounds:
> 
>   #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
>   #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
>   #5 0x4c33ae in syscall__scnprintf_args builtin-trace.c:2722
>   #6 0x4c43d3 in trace__sys_enter builtin-trace.c:3094
>   #7 0x4c7865 in trace__handle_event builtin-trace.c:4013
> 
> Move the check in btf_struct_scnprintf() to a helper,
> syscall_arg__augmented_args_valid(), and use it in both. When the check
> fails, syscall_arg__scnprintf_filename() now falls back to vfs_getname or
> the pointer.
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c       | 23 ++++++++++++++---------
>  tools/perf/trace/beauty/beauty.h | 17 +++++++++++++++++
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c39de91140a0..85db74965280 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1139,14 +1139,11 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
>  	LIBBPF_OPTS(btf_dump_opts, dump_opts);
>  	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
>  
> -	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size < (int)sizeof(*augmented_arg) ||
> +	if (!syscall_arg__augmented_args_valid(arg, type->size) ||
>  	    arg->fmt == NULL || !arg->fmt->from_user)
>  		return 0;
>  
>  	augmented_arg = arg->augmented.args;
> -	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg) ||
> -	    (size_t)augmented_arg->size < type->size)
> -		return 0;
>  
>  	dump_data_opts.compact	  = true;
>  	dump_data_opts.skip_names = !arg->trace->show_arg_names;
> @@ -1904,12 +1901,18 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
>  static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, char *bf, size_t size)
>  {
>  	struct augmented_arg *augmented_arg = arg->augmented.args;
> -	size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
> +	size_t printed;
> +	int consumed;
> +
> +	if (!syscall_arg__augmented_args_valid(arg, 0))
> +		return 0;
> +
> +	printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
>  	/*
>  	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
>  	 * we would have two strings, each prefixed by its size.
>  	 */
> -	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
> +	consumed = sizeof(*augmented_arg) + augmented_arg->size;
>  
>  	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
>  	arg->augmented.size -= consumed;
> @@ -1922,7 +1925,7 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
>  {
>  	unsigned long ptr = arg->val;
>  
> -	if (arg->augmented.args)
> +	if (syscall_arg__augmented_args_valid(arg, 0))
>  		return syscall_arg__scnprintf_augmented_string(arg, bf, size);
>  
>  	if (!arg->trace->vfs_getname)
> @@ -1938,13 +1941,15 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
>  static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
>  {
>  	struct augmented_arg *augmented_arg = arg->augmented.args;
> -	unsigned char *orig = (unsigned char *)augmented_arg->value;
>  	size_t printed = 0;
> +	unsigned char *orig;
>  	int consumed;
>  
> -	if (augmented_arg == NULL)
> +	if (!syscall_arg__augmented_args_valid(arg, 0))
>  		return 0;
>  
> +	orig = (unsigned char *)augmented_arg->value;
> +
>  	for (int j = 0; j < augmented_arg->size; ++j) {
>  		bool control_char = orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII;
>  		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
> diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
> index 0f4801c61a5b..1cd307328bb2 100644
> --- a/tools/perf/trace/beauty/beauty.h
> +++ b/tools/perf/trace/beauty/beauty.h
> @@ -124,6 +124,23 @@ struct syscall_arg {
>  
>  unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
>  
> +/* Is there a whole augmented arg left with at least @need bytes of payload? */
> +static inline bool syscall_arg__augmented_args_valid(struct syscall_arg *arg, size_t need)
> +{
> +	const struct augmented_arg *augmented_arg;
> +
> +	if (arg == NULL || arg->augmented.args == NULL ||
> +	    arg->augmented.size < (int)sizeof(*augmented_arg))
> +		return false;
> +
> +	augmented_arg = arg->augmented.args;
> +	if (augmented_arg->size < 0 ||
> +	    augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
> +		return false;
> +
> +	return (size_t)augmented_arg->size >= need;
> +}
> +
>  size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg);
>  #define SCA_STRARRAY_FLAGS syscall_arg__scnprintf_strarray_flags
>  
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 

Thank you Ian.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
