From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCHES] Fix 'perf top' breakage on architectures not providing
 get_cpuid() Re: perf top for arm64?
Date: Wed, 11 Dec 2019 14:50:05 +0000
Message-ID: <dec45157-5358-62ee-c22c-ba11b13bc407@huawei.com>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
 <9a31536b-f266-e305-1107-2f745d0a33e3@huawei.com>
 <20191210195113.GD13965@kernel.org> <20191211133319.GA15181@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211133319.GA15181@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "will@kernel.org" <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linuxarm <linuxarm@huawei.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org


> 
>> Right, I need to make that just a pr_debug() message and then check in
>> the annotation code when that is needed to see if it is set, if not,
>> then show a popup error message and refuse to do whatever annotation
>> feature requires that.
> 
>> Anyway, your patch should make sense and provide info that the ARM64
>> annotation may use now or in the future.
> 
> So can you take a look at the two patches below and provide me Acked-by
> and/or Reviewed-by and/or Tested-by?
> 
> 

>>From 53c6cde6a71a1a9283763bd2e938b229b50c2cd5 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Wed, 11 Dec 2019 10:09:24 -0300
> Subject: [PATCH 1/2] perf arch: Make the default get_cpuid() return compatible
>   error
> 
> Some of the functions calling get_cpuid() propagate back the error it
> returns, and all are using errno (positive) values, make the weak
> default get_cpuid() function return ENOSYS to be consistent and to allow
> checking if this is an arch not providing this function or if a provided
> one is having trouble getting the cpuid, to decide if the warning should
> be provided to the user or just a debug message should be emitted.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Garry <john.garry@huawei.com>

For both patches:
Tested-by: John Garry <john.garry@huawei.com> #arm64

I'll still look to get the arm64 version of get_cpuid() patch sent.

> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/perf/util/header.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index becc2d109423..4d39a75551a0 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -850,7 +850,7 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
>    */
>   int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
>   {
> -	return -1;
> +	return ENOSYS; /* Not implemented */
>   }
>   
>   static int write_cpuid(struct feat_fd *ff,
> 
