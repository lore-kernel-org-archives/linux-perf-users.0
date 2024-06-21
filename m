Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49915FA96;
	Fri, 21 Jun 2024 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000709; cv=none; b=rtY+c265HuIaKmlJ4XZUIj2y99Wc1ypo/pcy8V1wDw2SKj2eyQDrgw5JS2aycjB+ARGwaVCJOdY8Mr5A46zMdEJZV631JKHLd67IZY2ma+gm0fyn6C0qoQkVvQoEHZCQoIxpLM02Y+A6LejuVDOwQh8LudEmpIWkaixCssL6i1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000709; c=relaxed/simple;
	bh=pCEU19nWiLGEThyMAl4Y7guiba2ywnvjD28mzCNRvSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7P77kHhboilrdGP+shzh7MeXE2h5CO/lTE5YaailBJqJUjXJHqny176VaOzGiYLwAmVmDDfUo0Bvx3Wqcc6PJuyqfOJyfXIFuEUiUkX4S26VbQECHfQ0wTYM2JD4TAs31QSKWKVfdkQmy/XXrbLwBVlYW4OlU8pvooZExibvWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fls5evho; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fls5evho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719000707; x=1750536707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pCEU19nWiLGEThyMAl4Y7guiba2ywnvjD28mzCNRvSg=;
  b=fls5evho7uje0HGWlO2Rnjxs5wchujeshKsxsIxz6deqGkq0MmrThhZr
   cegSYDCZtzydJrQFUJkNnNndjq1Y2oJazo6AI9cqtE8eyTopz6ZlYNRfe
   pr5ASIybk/5CbzF/JGvqLh4VuUzP8xDfRfnaQRKRuYWZYhNjMvB4m6G2i
   AF3MjcU2l1yHJ5tT60PS4mcizGFiTYigAEjacSCFVXb6LsCCWLZAblKLh
   nvTar+vi9CCzxwBs8MYVstvo7MK46FbVDSX2jmMfcHs/x/mtWZ0p9Mbmn
   +RGMEGiM0zgMaJ2Jesx/kzybiFHsWBS4fT87fcvfv8qhlG50RDBHR4HlJ
   A==;
X-CSE-ConnectionGUID: 4P31pL9VROeObGZLkkx8TQ==
X-CSE-MsgGUID: ECfUMjsaR1ylq3Xk6peTNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="15744827"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="15744827"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 13:11:46 -0700
X-CSE-ConnectionGUID: p1uIZORLSQOLXie1AJhiew==
X-CSE-MsgGUID: 8lNXs7SWRbCxlCy8ikS3Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="73434161"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 13:11:47 -0700
Received: from [10.212.73.237] (kliang2-mobl1.ccr.corp.intel.com [10.212.73.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 89A5520B5703;
	Fri, 21 Jun 2024 13:11:44 -0700 (PDT)
Message-ID: <d4c5086a-908e-4246-a6ed-6a2223fe7813@linux.intel.com>
Date: Fri, 21 Jun 2024 16:11:43 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] perf mem: Fix a segfault with NULL event->name
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Guilherme Amadio <amadio@cern.ch>
References: <20240621170528.608772-1-namhyung@kernel.org>
 <20240621170528.608772-5-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240621170528.608772-5-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-21 1:05 p.m., Namhyung Kim wrote:
> Guilherme reported a crash in perf mem record.  It's because the
> perf_mem_event->name was NULL on his machine.  It should just return
> a NULL string when it has no format string in the name.
> 
> But I'm not sure why it returns TRUE if it doesn't have event_name in
> perf_pmu__mem_events_supported().

AMD doesn't have the event_name.

struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
	E(NULL,		NULL,		NULL,	false,	0),
	E(NULL,		NULL,		NULL,	false,	0),
	E("mem-ldst",	"%s//",		NULL,	false,	0),
};

It looks like as long as it's a "ibs_op" PMU, the mem event is always
available. The "ibs_op" check has been moved into perf_pmu__arch_init().
So the event_name is empty.

The "e->tag" in the perf_pmu__mem_events_init() can help to skip the
case  E(NULL,		NULL,		NULL,	false,	0).
So the perf_pmu__mem_events_supported() returns TRUE for the !event_name.

Thanks,
Kan
> 
> The backtrace at the crash is below:
> 
>   Program received signal SIGSEGV, Segmentation fault.
>   __strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
>   67              vmovdqu (%rdi), %ymm2
>   (gdb) bt
>   #0  __strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
>   #1  0x00007ffff6c982de in __find_specmb (format=0x0) at printf-parse.h:82
>   #2  __printf_buffer (buf=buf@entry=0x7fffffffc760, format=format@entry=0x0, ap=ap@entry=0x7fffffffc880,
>       mode_flags=mode_flags@entry=0) at vfprintf-internal.c:649
>   #3  0x00007ffff6cb7840 in __vsnprintf_internal (string=<optimized out>, maxlen=<optimized out>, format=0x0,
>       args=0x7fffffffc880, mode_flags=mode_flags@entry=0) at vsnprintf.c:96
>   #4  0x00007ffff6cb787f in ___vsnprintf (string=<optimized out>, maxlen=<optimized out>, format=<optimized out>,
>       args=<optimized out>) at vsnprintf.c:103
>   #5  0x00005555557b9391 in scnprintf (buf=0x555555fe9320 <mem_loads_name> "", size=100, fmt=0x0)
>       at ../lib/vsprintf.c:21
>   #6  0x00005555557b74c3 in perf_pmu__mem_events_name (i=0, pmu=0x555556832180) at util/mem-events.c:106
>   #7  0x00005555557b7ab9 in perf_mem_events__record_args (rec_argv=0x55555684c000, argv_nr=0x7fffffffca20)
>       at util/mem-events.c:252
>   #8  0x00005555555e370d in __cmd_record (argc=3, argv=0x7fffffffd760, mem=0x7fffffffcd80) at builtin-mem.c:156
>   #9  0x00005555555e49c4 in cmd_mem (argc=4, argv=0x7fffffffd760) at builtin-mem.c:514
>   #10 0x000055555569716c in run_builtin (p=0x555555fcde80 <commands+672>, argc=8, argv=0x7fffffffd760) at perf.c:349
>   #11 0x0000555555697402 in handle_internal_command (argc=8, argv=0x7fffffffd760) at perf.c:402
>   #12 0x0000555555697560 in run_argv (argcp=0x7fffffffd59c, argv=0x7fffffffd590) at perf.c:446
>   #13 0x00005555556978a6 in main (argc=8, argv=0x7fffffffd760) at perf.c:562
> 
> Reported-by: Guilherme Amadio <amadio@cern.ch>
> Closes: https://lore.kernel.org/linux-perf-users/Zlns_o_IE5L28168@cern.ch
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/mem-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 6dda47bb774f..429079329e48 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -86,7 +86,7 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
>  		return NULL;
>  
>  	e = &pmu->mem_events[i];
> -	if (!e)
> +	if (!e || !e->name)
>  		return NULL;
>  
>  	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE) {
