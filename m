Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F621D514B;
	Wed, 19 Mar 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423952; cv=none; b=elmZc1aS+wTWYgcxiS3Ga3H1eaCzyB+fSdd40rfAGi1eUiawe3saeU9G+UkCNdMu9ZzoI2mX3+2yocGTPzIrExw8cw+ulmowaLdOcVu98kOP7ciq+yGRcaDPe8ibs/VIEErtg7HsxOJjkTu09IduJYU5hLoG4GR4bwH5xo3RwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423952; c=relaxed/simple;
	bh=dImZNh0bG9VM/YhN/vSRAx8A+54tLqxUraUVX8X/htY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPuib3SFL59LGX3GeBpS54IVD2jKCf6e9x70/2nAdnAbvEB78QtvL39GUsDmwpe9d97uFQiJt9ZS0uxQHdNNwI75G1IpouMplCPudjXhy9MYUV8INqwoCERVwykDATnrmj9hO8pG+y1Y4CGsJNb5kgL0G4QxOgtWGQPb36qbPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL1eKEof; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL1eKEof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E05C4CEE4;
	Wed, 19 Mar 2025 22:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742423951;
	bh=dImZNh0bG9VM/YhN/vSRAx8A+54tLqxUraUVX8X/htY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iL1eKEofaZl6Ab+o5jUkqyVfMTBiNqciwKnDQWfp/dHkBVSLbfG9O62XKjD/BV3YO
	 Y6RbZLGhw9EkXKy9Uv8mmFo4RkH4TsFidnY+J/uNK+opzz+i/NsWz+tmVudq2C78ib
	 0AwMxUODNYmJh/NLYGlEYuoXm0KRt9fj7BWHAa7syDlPJe0FEMUBDzMSzdNXf7wXIl
	 5tJVpofLKszLbDWP4SaAdtR2gwMSFMJxOhkvdlAVcGj5RwxQExPxvQI+3GzD+I1P1g
	 TUzI1u5VGmUCupFM6mTxYNBAdVVJtrOjAndWd3d+J9V+RRsWxZJ/LoFBoL7UhPfz/z
	 BcrIO4WHH4e5g==
Date: Wed, 19 Mar 2025 15:39:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Daniel Dao <dqminh@cloudflare.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	kernel-team <kernel-team@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduling latency outliers observed with perf sched record
Message-ID: <Z9tHjRYnVfbQCPui@google.com>
References: <CA+wXwBRKB-1pAHby6FB_jiXspLTHv+mLyVzYj7TjkuT_Y9D4yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+wXwBRKB-1pAHby6FB_jiXspLTHv+mLyVzYj7TjkuT_Y9D4yQ@mail.gmail.com>

Hello,

On Fri, Mar 14, 2025 at 11:59:23AM +0000, Daniel Dao wrote:
> Hi,
> 
>  At Cloudflare with both kernel 6.6.82 and 6.12.17, we frequently
> observe scheduling
>  latency outliers with `perf sched record`. For example:
> 
> -------------------------------------------------------------------------------------------------------------------------------------------
> Task                  |   Runtime ms  |  Count   | Avg delay ms    |
> Max delay ms    | Max delay start           | Max delay end          |
> -------------------------------------------------------------------------------------------------------------------------------------------
> Pingora HTTP Pr:3133982 |      0.080 ms |        1 | avg: 881.614 ms |
> max: 881.614 ms | max start: 312881.567210 s | max end: 312882.448824
> s
> 
> The scheduling timeline of the outlier is as follow
> 
>           time    cpu  task name                       wait time  sch
> delay   run time  state
>                         [tid/pid]                          (msec)
> (msec)     (msec)
> --------------- ------  ------------------------------  ---------
> ---------  ---------  -----
>   312881.567210 [0058]  Pingora HTTP Pr[3045283/3045241
>                    awakened: Pingora HTTP Pr[3133982/3045241
>   312882.448807 [0015]  Pingora HTTP Pr[3045278/3045241
>                    awakened: Pingora HTTP Pr[3133982/3045241
>   312882.448861 [0118]  Pingora HTTP Pr[3133982/3045241
>                    awakened: Pingora HTTP Pr[3045278/3045241
>   312882.448911 [0118]  Pingora HTTP Pr[3133982/3045241      0.000
> 881.614      0.087      S
> 
> According to `perf sched record`, the task received several wakeups
> before it finally executed on CPU 118. The timeline
> on CPU 118 is as follow:
> 
>   312882.448824 [0118]  <idle>                               0.024
>  0.024      0.416      I
>   312882.448861 [0118]  Pingora HTTP Pr[3133982/3045241
>                    awakened: Pingora HTTP Pr[3045278/3045241
>   312882.448911 [0118]  Pingora HTTP Pr[3133982/3045241      0.000
> 881.614      0.087      S
> 
> This is very strange and seems impossible because the task was woken
> up before but not able to run yet while the CPU has idle time.
> 
> In production, we usually do not use `perf sched record`, but using a
> ebpf program that is similar to
> https://github.com/bpftrace/bpftrace/blob/master/tools/runqlat.but
> 
> tracepoint:sched:sched_wakeup, tracepoint:sched:sched_wakeup_new {
>   @qtime[args.pid] = nsecs;
> }
> 
> tracepoint:sched:sched_switch {
>   if (args.prev_state == TASK_RUNNING) {
>     @qtime[args.prev_pid] = nsecs;
>   }
> 
>   $ns = @qtime[args.next_pid];
>   if ($ns) {
>     @usecs = hist((nsecs - $ns) / 1000);
>   }
>   delete(@qtime, args.next_pid);
> }
> 
> We do not observe any outliers with this program. We figured that the
> difference with perf record is in the case of
> supposedly repeated wakeups. The ebpf script took the last wakeup,
> while `perf sched latency` took the first wakeup. Once we
> adjusted our bpftrace script to take the first wakeup, we observed the
> same outliers.
> 
> Looking into this further, we adjusted the same bpftrace script to
> also print out `sum_exec_runtime` to make sure that
> the process didn't actually run i.e. we do not miss any sched_switch
> events. The adjusted script is as follow:
> 
> #define TASK_RUNNING 0
> #define THRESHOLD 100
> 
> rt:sched_wakeup, rt:sched_wakeup_new
> {
>   $task = (struct task_struct *)arg0;
>   $ns = @qtime[$task->pid];
>   $sum_exec_runtime = @sum_exec_runtime[$task->pid];
>   if ($ns > 0 ) {
>     $ms = ((nsecs - $ns) / 1000000);
>     if ($ms > 100) {
>       printf("pid=%d t=%ld delay_ms=%d sum_exec_runtime=%ld
> prev_sum_exec_runtime=%ld cached_sum_exec_runtime=%ld\n", $task->pid,
> nsecs, $ms,
>           $task->se.sum_exec_runtime, $task->se.prev_sum_exec_runtime,
> $sum_exec_runtime);
>     }
>     if ($task->se.sum_exec_runtime == $sum_exec_runtime) {
>       // repeated wakeup, and task hasn't been run before, and we have
> not missed any sched_switch events, do not count
>       return;
>     }
>   }
>   @qtime[$task->pid] = nsecs;
>   @sum_exec_runtime[$task->pid] = $task->se.sum_exec_runtime;
> }
> 
> rt:sched_switch
> {
>   $prev = (struct task_struct *)arg1;
>   $next = (struct task_struct *)arg2;
>   $prev_state = arg3;
>   if ($prev_state == TASK_RUNNING) {
>     @qtime[$prev->pid] = nsecs;
>     @sum_exec_runtime[$prev->pid] = $prev->se.sum_exec_runtime;
>   }
> 
>   $ns = @qtime[$next->pid];
>   if ($ns) {
>     @usecs = hist((nsecs - $ns) / 1000);
>   }
>   delete(@qtime[$next->pid]);
>   delete(@sum_exec_runtime[$next->pid]);
> }
> 
> The script gives us the following data:
> 
>   pid=2197474 t=298353700427405 delay_ms=1157
> sum_exec_runtime=1663205188 prev_sum_exec_runtime=1663167058
> cached_sum_exec_runtime=1663167058
>   pid=2196692 t=298354187452899 delay_ms=1644
> sum_exec_runtime=1630867065 prev_sum_exec_runtime=1630824755
> cached_sum_exec_runtime=1630824755
>   pid=3290499 t=298354606215376 delay_ms=1482
> sum_exec_runtime=26316767196 prev_sum_exec_runtime=26316654306
> cached_sum_exec_runtime=26316654306
> 
> We can see that the script detected repeated wakeup (i.e. the program
> did not observe a sched_switch), but the task exec_runtime has
> changed.
> 
> Am I understanding correctly that this means that we must have missed
> a sched_switch tracepoint event ? We didn't see any
> miss counters for our bpf program reported by bpftool. The `perf sched
> record` command also didn't report any missing events,
> and I think it must have also missed some of these sched_switch events.
> 
> Is there anything else that we are missing here ?

perf can miss some events when the ring buffer is full.  There should be
a warning about that.  Also you can check whether the data has LOST
records by running this command.

  $ perf report --stats | grep LOST

Thanks,
Namhyung

