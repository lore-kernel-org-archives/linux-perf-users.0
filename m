Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E930165F08
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569330; cv=none; b=HNFbPZjG7xVAKGvX/Y9qHSy48QJWxiWoSZhaCRxrbXuKLt/OvQbdKHOmLQ9E3lytZZ+mj0xhmysHjHh9r3uWwtHN+TJnsaVA0u4/T9wmFWgY2tsiIsDZrNf6qZyf49tUV9CgBwQ1Ess2nJLO+ZtD4QLARcBHV/Z9tX/WrUlPYjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569330; c=relaxed/simple;
	bh=OLLhui7Jzx1RAtm7SPJ/skbZFwqbpC+tssfd5yQyu4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pygy0+Wtmcy9A295pvBNpOKznOtRmCsa/J9D6rWQW41Bd0kLGbwnJdGKtRh2LgsMScl62iEmIGHxRDiqlOdoZLQwMZolby4td1OeMXwH+nXpRloX313VpS33f7bH8zlg3TFUjuDSbaU+2H48zuZ8V9v1dAmxlKL0E0VqpT0ZJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T8OXs0j8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8OXs0j8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so53524685e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726569327; x=1727174127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAMPodNnJ2ZsXz40AQFpJhiS0Su6b6Jl7GEjAbtsmnw=;
        b=T8OXs0j8mhT0ebYPwAGmaqJucLUO3XalxUL/WdhFZb0QFvc+fS57kObLKtCoQ94fEr
         sfWcIhLr2WWunNKi7eu0MN/szUgFKkgQ2hkPurUDRBM/Q5LkQD6vqYEspv4TutCdt6J2
         ilHz7ThyC5xFwJYCZammBy3xOz2dlycJ6X9Q/B2/fEdigDF7VxP4nbYQ6hXLwe9nZoA5
         NuNXhMqcfy7FxdRcJdWykQDNwFA88lnxbdwn0R3VQbq6+Wn7gn/Yw5wz0gXCGtpeYlII
         +Q9ZplXKpq1hcDqckZudPcePxLK2XGyAaHmEVAlXr81xY0a0yN6/mrurZAeGt2Vrkqrv
         4qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569327; x=1727174127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAMPodNnJ2ZsXz40AQFpJhiS0Su6b6Jl7GEjAbtsmnw=;
        b=MRPCwy9B7j1z+7JcIyDF/lWgEqWqfFo7nKn0cHCR/I5Mr53MRyD7/5nFniF9B4VZDQ
         H2XzTt5rxXlfOz/86qU1dqXtyp/MTASkLikFhb+G+0gonW1M0jtK5xaWKKVPe4xLiXug
         +r839OKIi7kQfv9VV0ScDGGBqzFy57GrKTYrw9+NvRATd8ZwFGKMXF1enFNrMhseUIak
         acrq1O/lg9YTqJEznH4qvl5ymzw3TBgmEWN3hI0Nck3PjSwIEUgG/gsqlGdiHtFKIpmS
         xXaGvphc6kDL8rFw7GZfVkVQl6GOqt6GlqUcFakAqnNaI11Pj/r2qcadpcVH9Cs58oep
         5WUg==
X-Forwarded-Encrypted: i=1; AJvYcCU8v6e9Kkq9UUGgpgtHlgNfgahO4Wl8hU6hdlABNyVCFfsPxFHpxVZmyiurQV/nfM+22mgirXeSp93p1NEyBSDo@vger.kernel.org
X-Gm-Message-State: AOJu0YycI3wqMVWblt+k9Yn0Oz8szURa0N99BjmEHYDF/LtkE8dlM+4O
	b9O9suL6TbE87N8i38INBbi1IlsmSVh6ZPsZSj/Vovmy0Y5YIyKgxdHFGTubEe4=
X-Google-Smtp-Source: AGHT+IHm2U6xGx8sJ45qJ+gaD5HpJzgUWnBj/vF3uyDj48BPvEIizm46jt2g7TAhkcwfXFaD/x2Spw==
X-Received: by 2002:a05:600c:45cf:b0:42c:a802:540a with SMTP id 5b1f17b1804b1-42cdb511f33mr152169365e9.7.1726569326660;
        Tue, 17 Sep 2024 03:35:26 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e6bc2c7c2sm9952775e9.0.2024.09.17.03.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:35:26 -0700 (PDT)
Message-ID: <f022afad-793d-4a3d-acad-13fd27dd5e62@linaro.org>
Date: Tue, 17 Sep 2024 11:35:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] perf sched: Introduce stats tool
To: Ravi Bangoria <ravi.bangoria@amd.com>, swapnil.sapkal@amd.com
Cc: yu.c.chen@intel.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org,
 vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com,
 james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com,
 kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com,
 void@manifault.com, tj@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
 ananth.narayan@amd.com, sandipan.das@amd.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240916164722.1838-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/09/2024 17:47, Ravi Bangoria wrote:
> MOTIVATION
> ----------
> 
> Existing `perf sched` is quite exhaustive and provides lot of insights
> into scheduler behavior but it quickly becomes impractical to use for
> long running or scheduler intensive workload. For ex, `perf sched record`
> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> generates huge 56G perf.data for which perf takes ~137 mins to prepare
> and write it to disk [1].
> 
> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
> and generates samples on a tracepoint hit, `perf sched stats record` takes
> snapshot of the /proc/schedstat file before and after the workload, i.e.
> there is almost zero interference on workload run. Also, it takes very
> minimal time to parse /proc/schedstat, convert it into perf samples and
> save those samples into perf.data file. Result perf.data file is much
> smaller. So, overall `perf sched stats record` is much more light weight
> compare to `perf sched record`.
> 
> We, internally at AMD, have been using this (a variant of this, known as
> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> of any scheduler code changes[3][4].
> 
> Please note that, this is not a replacement of perf sched record/report.
> The intended users of the new tool are scheduler developers, not regular
> users.
> 
> USAGE
> -----
> 
>    # perf sched stats record
>    # perf sched stats report
> 
> Note: Although `perf sched stats` tool supports workload profiling syntax
> (i.e. -- <workload> ), the recorded profile is still systemwide since the
> /proc/schedstat is a systemwide file.
> 
> HOW TO INTERPRET THE REPORT
> ---------------------------
> 
> The `perf sched stats report` starts with total time profiling was active
> in terms of jiffies:
> 
>    ----------------------------------------------------------------------------------------------------
>    Time elapsed (in jiffies)                                   :       24537
>    ----------------------------------------------------------------------------------------------------
> 
> Next is CPU scheduling statistics. These are simple diffs of
> /proc/schedstat CPU lines along with description. The report also
> prints % relative to base stat.
> 
> In the example below, schedule() left the CPU0 idle 98.19% of the time.
> 16.54% of total try_to_wake_up() was to wakeup local CPU. And, the total
> waittime by tasks on CPU0 is 0.49% of the total runtime by tasks on the
> same CPU.
> 
>    ----------------------------------------------------------------------------------------------------
>    CPU 0
>    ----------------------------------------------------------------------------------------------------
>    sched_yield() count                                         :           0
>    Legacy counter can be ignored                               :           0
>    schedule() called                                           :       17138
>    schedule() left the processor idle                          :       16827 ( 98.19% )
>    try_to_wake_up() was called                                 :         508
>    try_to_wake_up() was called to wake up the local cpu        :          84 ( 16.54% )
>    total runtime by tasks on this processor (in jiffies)       :  2408959243
>    total waittime by tasks on this processor (in jiffies)      :    11731825 ( 0.49% )
>    total timeslices run on this cpu                            :         311
>    ----------------------------------------------------------------------------------------------------
> 
> Next is load balancing statistics. For each of the sched domains
> (eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
> the following three categories:
> 
>    1) Idle Load Balance: Load balancing performed on behalf of a long
>                          idling CPU by some other CPU.
>    2) Busy Load Balance: Load balancing performed when the CPU was busy.
>    3) New Idle Balance : Load balancing performed when a CPU just became
>                          idle.
> 
> Under each of these three categories, sched stats report provides
> different load balancing statistics. Along with direct stats, the
> report also contains derived metrics prefixed with *. Example:
> 
>    ----------------------------------------------------------------------------------------------------
>    CPU 0 DOMAIN SMT CPUS <0, 64>
>    ----------------------------------------- <Category idle> ------------------------------------------
>    load_balance() count on cpu idle                                 :          50   $      490.74 $
>    load_balance() found balanced on cpu idle                        :          42   $      584.21 $
>    load_balance() move task failed on cpu idle                      :           8   $     3067.12 $
>    imbalance sum on cpu idle                                        :           8
>    pull_task() count on cpu idle                                    :           0
>    pull_task() when target task was cache-hot on cpu idle           :           0
>    load_balance() failed to find busier queue on cpu idle           :           0   $        0.00 $
>    load_balance() failed to find busier group on cpu idle           :          42   $      584.21 $
>    *load_balance() success count on cpu idle                        :           0
>    *avg task pulled per successful lb attempt (cpu idle)            :        0.00
>    ----------------------------------------- <Category busy> ------------------------------------------
>    load_balance() count on cpu busy                                 :           2   $    12268.50 $
>    load_balance() found balanced on cpu busy                        :           2   $    12268.50 $
>    load_balance() move task failed on cpu busy                      :           0   $        0.00 $
>    imbalance sum on cpu busy                                        :           0
>    pull_task() count on cpu busy                                    :           0
>    pull_task() when target task was cache-hot on cpu busy           :           0
>    load_balance() failed to find busier queue on cpu busy           :           0   $        0.00 $
>    load_balance() failed to find busier group on cpu busy           :           1   $    24537.00 $
>    *load_balance() success count on cpu busy                        :           0
>    *avg task pulled per successful lb attempt (cpu busy)            :        0.00
>    ---------------------------------------- <Category newidle> ----------------------------------------
>    load_balance() count on cpu newly idle                           :         427   $       57.46 $
>    load_balance() found balanced on cpu newly idle                  :         382   $       64.23 $
>    load_balance() move task failed on cpu newly idle                :          45   $      545.27 $
>    imbalance sum on cpu newly idle                                  :          48
>    pull_task() count on cpu newly idle                              :           0
>    pull_task() when target task was cache-hot on cpu newly idle     :           0
>    load_balance() failed to find busier queue on cpu newly idle     :           0   $        0.00 $
>    load_balance() failed to find busier group on cpu newly idle     :         382   $       64.23 $
>    *load_balance() success count on cpu newly idle                  :           0
>    *avg task pulled per successful lb attempt (cpu newly idle)      :        0.00
>    ----------------------------------------------------------------------------------------------------
> 
> Consider following line:
> 
>    load_balance() found balanced on cpu newly idle                  :         382    $      64.23 $
> 
> While profiling was active, the load-balancer found 382 times the load
> needs to be balanced on a newly idle CPU 0. Following value encapsulated
> inside $ is average jiffies between two events (24537 / 382 = 64.23).

This explanation of the $ fields is quite buried. Is there a way of 
making it clearer with a column header in the report? I think even if it 
was documented in the man pages it might not be that useful.

There are also other jiffies fields that don't use $. Maybe if it was 
like this it could be semi self documenting:

----------------------------------------------------------------------
     Time elapsed (in jiffies)               :        $  24537        $ 
  ----------------------------------------------------------------------

------------------<Category newidle> ---------------------------------
   load_balance() count on cpu newly idle    :   427  $     57.46 avg $
----------------------------------------------------------------------


Other than that:

Tested-by: James Clark <james.clark@linaro.org>
