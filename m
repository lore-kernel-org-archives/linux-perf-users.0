Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022085.outbound.protection.outlook.com [52.101.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CA6175A85;
	Fri, 16 Oct 2026 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128694; cv=fail; b=oLeJC2VzqTCbQQDg0zv5vNw/0W29UXTHkLwwrjl/QCPOCt4H5wkJF5XIhjh6E2cgyLhJ/+abGJVzVOw0JHu0xJTtqHrEuGuH3N8J3RPO4wnDo8aWTAkZOwIGrsBZwN/H0b8BGM8CTNhvwuqu+bQ6diiKxgM0C/sX03O0IexXQ0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128694; c=relaxed/simple;
	bh=Av4jMjQAAYqyurxSalO8pMO1lSX6Q2ipRwTU8dDBTP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DDA7Uhdvzs3oAlsbvhWfh4YNx3EO7zMoFR8qX05QZkmeI6Vkj1gdTdgONLvT4jynv0uYHo3i9bPSQmo7etao7jrZQ10Pcm2WGmknThgn36rHbjiVBwYuRg9AaOQRRodYUeOOK6CffDgboduF6lDsBuTUdnW4J3qaJoszmeIpo7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APRtfXIwNFxLpJ7MIPdEEWhGU921KpPXVdAvX2Hgr3tJVle+ElXbTD+PPIkk8HZSFTqULSOEyoh8OOqIoWMqNBD+UrJPJe14NNZyZvCRUbWNAsDGgHrtl4yWKn3QPhZI4Bs6jB4l6M+V3B0qEFrvC+HkSyN1D/BUJeUUwa9oQAOZk6mFdLYMJAqiXTxJFYG6dEJ2XJhFo1HkYSvcH/A5YmDW8xmbXsgTvSIdvQGFr+DeGi67iYBVPzaDK1nSs2FXZ/rOG34hJRgCfQT2M+LXP/UHHE476HIn0CcjPa4AJnJYWM5ljdnPxLTJBCgYbb2UEYsvUAcZV45PT31d98RE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=DE8nbJ1F5xYJhQLp15HiYM1epb9kI9P94uD++uao91E=;
 b=ZCKsfQiGsLbO8/zvloFc2tZLpZFZbEhmvEQRfERayvMZnD7Z71QzJAsmpMbKjbo0OELWjMIp9LfWGEOBC6Pr6Ecl4qytBV82DuLSuAZrGQJF4qvxiMIbshYOmRKFQxIkd+nGirnEUsA4Lw2j+bx72NB3jnxydQzL8Wg8wsbsuAo/RDWTof4/+piikCmtWo8r17hox5I3C4MhTfz6fRZjRyZGcvAnWc6FP782wGolZLjgM/bIjO1J3Ni5fRFnb/K7yjttmHR+1H7gnH5GypLXi91EXXnX7Q2NYu0c5wC1dr+KK4yShVO7g98i4fg8WPySqgWKt0Y/uxJQUdGnX4A3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3149.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 05:31:28 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 05:31:28 +0000
Date: Fri, 16 Oct 2026 01:31:24 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf c2c: Fix memory leaks on output fields
Message-ID: <mvp32oxysbmvji6peauvhe73kqwh744on6ba2damsqahbobknf@63lxcn54rojb>
References: <20261015233237.542258-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015233237.542258-1-namhyung@kernel.org>
X-ClientProxiedBy: SA0PR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:806:d2::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3149:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ced2b3f-fc4b-4b19-27a8-08df2b46ba61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|261009223027099003|260925022911599003|260925021911599003|260925021311599003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	r/+NCcE9aw/dZxfKBKAlwlCAisK4XbufxMXT07AZkorwctjeM9ei+6av7KGUZdIUcja64i7xBqkHi7833X6w3m5mfjYkBUDEKZiNwFTxder8nP5oOFXFLHRJEu0kmfNLp4vRQKnP5rtBYHNDGqBZ0RDFfj+laBNRP2lCP44HBQvO8Hlted5qfdVXdlv/xBMV5rqsO0JaZaVvQ4TI7+9DecTCo3A0PAHM7XftaCIc1ZAt29kx/VZYrIrQ7WzqREgz+ZVSMkKjlq8HPB2Uv5u0buM1NLw7mS49Q3EDYQ+4oqoZTb96MSNZfVNvHaFTdCBXSbewRhVnfVRPumSS4EcyWYLV7d0Bkw1Bu8Uc8uSMDQNKzBPnmRJxiMZ7F6gSpT4fzZtTSqRoVAhtq9UYgH2CqWNEfw2EMJDTTydExPZo0Mu5pJPNkNNSt+YvAZdcnpfxc9EEaAyzaQWwod9yHqv13vHGN2YJKY0j8WFrDmxX8CUBz/avXPL7QLXFsk1ALnyn7RzaYj8pP4Tho5K595hNBoukER8P6KfxvfCaO93taT8MlK/4U64NbvBcyVeQNTSxPtnI+rYJldXYWFA+ezxwIEkAz6yKj3KEzT/DB9rbQ9SvKrPKnqS/et89eA7dW1uXiyYY6O3miEvQ48r0bfXtZB5rIKri8PaOO0NBVWRsIEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUNuSndBTTBqWWRmSVd2azA1Vk5yV3NkU2NJOVRmTG9LN1h5Mk1LelhXSVVO?=
 =?utf-8?B?RHdnVE0rNzhlZklJSHNlK1RjTnpRRUNneXhVbms1R25KbjJKczVFVkV5T1NZ?=
 =?utf-8?B?UkR2RHZZRXJNdnN1NGRCUitGclFZU2VPVEtYcFVGN1h2RWRBaW1zVjh1RGZY?=
 =?utf-8?B?SlpSZnAzQitVTjlRTzFLUU50L2x6bEkzTFQ5bDlyaTlKNHh4alJWNWVyck1W?=
 =?utf-8?B?QU5KRkg4cTFHWEcvNXZtd1UxTjN0M3Vzb2FSSzRqcmd1UVlJbzhXOEhRZ2dw?=
 =?utf-8?B?bEgvblVwaUdJNUszUTFVeW92WEZEZDBGVUp6bE90Q0FlU1NCOTh5eVpYWWlB?=
 =?utf-8?B?a3dGT21mZEVrQ1dqWE5iWllxTkt4RVNzSkpkU09xeTZTWTZuQnlxeFlMYXN2?=
 =?utf-8?B?WlE1TUZOVHd6S2pSUWNLZHlTMlA0emFSdmJyOHFOSTE5Y0xsenk0ZFFUZVZy?=
 =?utf-8?B?WmJwaWRvQ1kvak5VQ0NuY2tBRlJyUWhObnVDZS9FeW1DWDZmT292dEZJOWZB?=
 =?utf-8?B?UElPcTRWVE10SHA0UlhFVUJFR05rS01OOElTRnoxOG1DdWVaRVFoZlZhUGpU?=
 =?utf-8?B?Q0xWM0MvcE5OVngrMzdqd3JUZ1lUeVEzQkx0blRYbmF1T2tBalNjYjlCS3or?=
 =?utf-8?B?aXNEbGFlU1hxZ01ZZFhhNERtZTd5ejQ3eUZqN25CMVJVNXJGaDBlSFFkLzB0?=
 =?utf-8?B?L0QrVzBwdzJFUjN4SGx4ZFpHd3lVRjZKOUp0VEZGdlZYSW9heC9OMUlqcHdV?=
 =?utf-8?B?UXFkaCtIYjZrTVVwNTh3VjBpUWJldFpkdngzQU9rbmxZVkFjRGFsM3A5V0hS?=
 =?utf-8?B?QWgzK3BmZ1hIYXVDZnFLRVM2bkVOS2prek1WN0FpSWVPRXZLNldueFN1MTFU?=
 =?utf-8?B?NURsak5tOURyVEUxQ0RQN2J6TVB3RDltMFJOTkhCVjRwWG5CU0ZDNC9kamlm?=
 =?utf-8?B?L2VOTHRTejNTaTVQLzNPUXhvMTRsR0lXbmp2RTRnSGQ0eEJza3FubGNUYkd0?=
 =?utf-8?B?aVJSVklhSWlBMlphSzd4SW9md20vVEdueXJLZzFQUHVWa0lHaGJTWm5QRHNE?=
 =?utf-8?B?WjVaNGdLME9DaG9IUE8zZTV1Zmgxb0hFZVo3NXJUMkZVZ282OFFZU3Zxc3JG?=
 =?utf-8?B?T2Vnay9BMXlXRWhTR1hxaDJJRkN2dTFMbllLZHQ0RUNwSVpJeVk2VlV0VFdR?=
 =?utf-8?B?dEhiMVN6TzhLaXhSWUlVOFBPaWV2RkpqU0FrenN3REZoYmxmeVpQcXJoREZm?=
 =?utf-8?B?K3FRUnA0R2tTdE1ubnBCN0xIN1VpZTJhKzNRMWtnK3E3cHpmMG82MzliVktM?=
 =?utf-8?B?azdNWE9oSXBCWExJbkt4c0Rac0t5ako5dytrWVNVZ29RRFFQdUhZL0pYc3Yy?=
 =?utf-8?B?TWJMTFVweEVKUGFTZkJUWktDMy9LM3RZQ0t4ZTVRRjdJbEJRVUNad2t0dWpM?=
 =?utf-8?B?MVkrQnptYytCTThoWi9NTkFDNkx4b2l5UWZzeFZtelJOYnBsSXRDQlpjb0VH?=
 =?utf-8?B?MTBrcUFqQzljbXZSNjlSdHBndU5CU0gySEJBTkZQU1FZMkpIamswWWxiUXBq?=
 =?utf-8?B?WlVmdkJmUXVVeEROT3BNanJDUERrdXhPc2J2VkNOTkJzQUlLeXNMK3RWd2NB?=
 =?utf-8?B?Y2RRSGhHTnpTVW5nSVZQZEZISXJXeXkxSEI0R3NUUFBQbWFnSlM1Q2tMZG1j?=
 =?utf-8?B?WmZDaEdyVlVPcXkrcUYzMlVPUzc0ZGlKTlJoTGpBb1VWM1VFeGJzQ2JKTExm?=
 =?utf-8?B?cW90bHBZbXhBN3pDTUIxVExYb3lsYTV5WGVxeDh3VjZnRGNIbmt0b0JMTkNu?=
 =?utf-8?B?clZ4MTBKNjRTRjlWTWpCTjBVQ2lBV1AxNXRsQ2Juc0x2Ky9PWngvUExoSXVj?=
 =?utf-8?B?R2dOMTVNbndwNXJEeWlMTFNtR2FzbTEzajJKbEhLNjZpc0UyNGdGa3VJK2Jy?=
 =?utf-8?B?WlE0dWxpT1REYWVvSTRXNWhCazZCSGxBVENsbHdOY3VrV2tpeU5JMWNKczQ4?=
 =?utf-8?B?c1hySy9LMmIzcG1DRy92MWIwZEEzTThWQTlrV3JRTW1UTkVoV1liM0VtVEFz?=
 =?utf-8?B?bUVEM2V3cmVWS0R2M0ozcWozdzdlaVFoall6UUw4cGo5NFZ3Tk5SU2lXOUZi?=
 =?utf-8?B?S3pIa29oV1g4NXM5aXM1dUxNTWdNTm9zczgwdTc3NTJZOWx5OUtiZkxZb3lp?=
 =?utf-8?B?UmR0aW9FQjRTeERPUGFucUMrRFRqS0tvS3d0U2VieU05d3h2UzEwQ3FnVnhI?=
 =?utf-8?B?ZVdhcVlqRE1IU0grRXdDQUh3WWJmMy9vTS9lUjF4VElQaWd6dmJlUUlITEVp?=
 =?utf-8?B?cHRCY1czUFhqdkErbVI4bjRsdXVmSklhQTVuaDVlWk1KMy90ek81Zz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ced2b3f-fc4b-4b19-27a8-08df2b46ba61
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 05:31:28.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svqeFrIUB1gUSLYa0HnP85Z9zydiwAohXIJ/MQ4U84doI/sGKOPIdDKKYfmiK3tEeTuFkjnkIW8zql6uIZJang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3149

On Thu, Oct 15, 2026 at 04:32:37PM -0700, Namhyung Kim wrote:
> The perf_hpp_list was not freed after use.  Let's add it for the main
> c2c hists list in perf c2c report and a local list in print_pareto().
> 
> Previously it was detected by ASAN like below.
> 
>   =================================================================
>   ==42183==ERROR: LeakSanitizer: detected memory leaks
> 
>   Indirect leak of 1064 byte(s) in 7 object(s) allocated from:
>       #0 0x7f17334ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 61e8165ca90f7a4f06b73f064a938c76deaae079)
>       #1 0x0000005fa099 in zalloc  ../../lib/zalloc.c:8
>       #2 0x0000004faf6d in get_format  tools/perf/builtin-c2c.c:1978
>       #3 0x0000004fb45e in c2c_hists__init_output  tools/perf/builtin-c2c.c:2004
>       #4 0x0000004fb7de in __hpp_list__parse  tools/perf/builtin-c2c.c:2047
>       #5 0x0000004fbae9 in hpp_list__parse  tools/perf/builtin-c2c.c:2085
>       #6 0x0000004fee13 in print_pareto  tools/perf/builtin-c2c.c:2563
>       #7 0x0000004ffcd7 in perf_c2c__hists_fprintf  tools/perf/builtin-c2c.c:2708
>       #8 0x000000500ab5 in perf_c2c_display  tools/perf/builtin-c2c.c:2949
>       #9 0x0000005045c3 in perf_c2c__report  tools/perf/builtin-c2c.c:3522
>       #10 0x000000505caa in cmd_c2c  tools/perf/builtin-c2c.c:3676
>       #11 0x0000005df50e in run_builtin  tools/perf/perf.c:383
>       #12 0x0000005df9b1 in handle_internal_command  tools/perf/perf.c:436
>       #13 0x0000005dfd7f in run_argv  tools/perf/perf.c:480
>       #14 0x0000005e02d6 in main  tools/perf/perf.c:581
>       #15 0x7f1729450680 in __libc_start_call_main (/lib64/libc.so.6+0x3680) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
>       #16 0x7f1729450797 in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so.6+0x3797) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
>       #17 0x000000409c34 in _start (tools/perf/perf+0x409c34) (BuildId: 36a64600776d92e4ab7dfd5ca20c92280d72a645)
> 
>   SUMMARY: AddressSanitizer: 1064 byte(s) leaked in 7 allocation(s).
> 
> Fixes: c75540e3160f ("perf c2c report: Add dimension support")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-c2c.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 4222ac784fabef6b..f51fa23f3bf18b90 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2155,6 +2155,11 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
>  	return ret;
>  }
>  
> +static void c2c_hists__exit(struct c2c_hists *c2c_hists)
> +{
> +	perf_hpp__reset_output_field(&c2c_hists->list);
> +}
> +
>  #define DISPLAY_LINE_LIMIT  0.001
>  
>  static u8 filter_display(u32 val, u32 sum)
> @@ -2563,7 +2568,7 @@ static void print_pareto(FILE *out, struct perf_env *env)
>  	ret = hpp_list__parse(&hpp_list, cl_output, /*evlist=*/NULL, env);
>  
>  	if (WARN_ONCE(ret, "failed to setup sort entries\n"))
> -		return;
> +		goto out;
>  
>  	nd = rb_first_cached(&c2c.hists.hists.entries);
>  
> @@ -2577,6 +2582,9 @@ static void print_pareto(FILE *out, struct perf_env *env)
>  		c2c_he = container_of(he, struct c2c_hist_entry, he);
>  		print_cacheline(c2c_he->hists, he, &hpp_list, out);
>  	}
> +
> +out:
> +	perf_hpp__reset_output_field(&hpp_list);
>  }
>  
>  static void print_c2c_info(FILE *out, struct perf_session *session)
> @@ -3378,12 +3386,12 @@ static int perf_c2c__report(int argc, const char **argv)
>  	err = setup_nodes(session);
>  	if (err) {
>  		pr_err("Failed setup nodes\n");
> -		goto out_session;
> +		goto out_hists;
>  	}
>  
>  	err = mem2node__init(&c2c.mem2node, env);
>  	if (err)
> -		goto out_session;
> +		goto out_hists;
>  
>  	err = setup_callchain(session->evlist);
>  	if (err)
> @@ -3525,6 +3533,8 @@ static int perf_c2c__report(int argc, const char **argv)
>  	free(output_str);
>  out_mem2node:
>  	mem2node__exit(&c2c.mem2node);
> +out_hists:
> +	c2c_hists__exit(&c2c.hists);
>  out_session:
>  	perf_session__delete(session);
>  out:
> -- 
> 2.56.0.176.g3575e65682-goog

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
