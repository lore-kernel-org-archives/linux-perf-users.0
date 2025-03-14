Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BC8635A
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Mar 2025 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953578; cv=none; b=iD0xCDVHePbgw00+Nu4RqZXCEw1Rmlfxdf9ktV79YSJWB5OSo7JZD4tFC9KPZgHsVfxpboJgRPJGYhl1pvu/XonqYs4j/mRDOEszZP7v7hZlqrQll/+Oot0qLtdu7TeICSMjWgAkwE+0SXgeb3npeQcVw+CbR7y4t/mkIf5uPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953578; c=relaxed/simple;
	bh=1VmZoAlORKq9EyDEpRjZm8YC8Fd82/BY4t03HWqNkZw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cUBeOZ2QB4WGLYWU8tA4/cnROe0z0ICxQEQrBGvYhHxqpHe7EEGbIb7HWkRlsquLkiv/lXIAyPjqQwirDeGIqySuD1f/0gEuQWxAOyEFYHe9dawaDGMLJTEzS7LG/pJWAH3IidcTCf2KUHnZB9qSwXKKf2vygjfuQ3Ye7oL3KK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PSxWxD17; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PSxWxD17"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so16304401fa.2
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Mar 2025 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1741953575; x=1742558375; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HPHaGOfEFBjfJE0GFruCSLlFREKIxMYa5WqO9lHro0I=;
        b=PSxWxD17JhlMwjMRxnRv0uR24x434de5u2ITIItxM1d44xiRe2fdFeR7CNxSmCsTWl
         MzDLdzMqa6/yMnl8V1Nr/5tDEIjmWYmqVDMl5nwHdn/eh5hn5YEPY4mAIJ58iFIU5715
         iGYaxgJDYddOs2GVzN0A5gxzZ1TLYe44C1KyUAXa/82eeEV8tJhKCsm9nhicS6Y0hqTn
         hWfieaCU3OZnYY6XExQIvdtFS3/eOucwWJDDA8EvlERNJPtZAoTqwFmXddr2XPQByJ9B
         /CpWNVO31zlGsVWSUo7yU3HHqrhyht8qc2J4CLhgYmkYe/6G3skN/VAngtKz7OcoBZ75
         7sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741953575; x=1742558375;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPHaGOfEFBjfJE0GFruCSLlFREKIxMYa5WqO9lHro0I=;
        b=gg5Wn5F4MkYmhyEjR8zC6ob1RqIvvx81k5WTPO1LtqfmGCudVCFRUTj2xXFRGNo+ro
         Ijp5S9JySIff/5WcjdK9qtQ8E0kbWKpYSggFLMuh1fwGql5ed/IF3uX709Iqt5uxdSr8
         QxwktVYbugwuwIteXtEsXrXXKFPzSZNcnf+NBMIUuxckW60jYZL6FrfRMOWpD3XYsjdX
         7w2vFeJFjImniBc2bqIioBMOO0W687IAU0xKmaXykGfnaqML6P+RaYpyQl4TUqFT6dp9
         I4lSy9/iS802QFW8G8kNLURFsDKpFDBOVeDUQyFsXbweY3e4737WBT6sZdoGbnIXpRqS
         O8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCW34KS/x5BSVRxuMoJGtjSl7HJzvMPHKQjzWsyTI7E+wiRAODu6KqWv14LfMS5PYDHVtMovM70vMw2z6HbrfW4B@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DjWAGK4bb/Z9D015qRzTvMLCYepUacLa3wUDY5vDXshTaJN+
	8jRr/YkkHdGkLmgB78OHafkQ8W+j2ZlQVWrPJOmh2b9+QqJhFt044Nks+hurLc18aTWzbatoMzU
	7Oo6TE/8x4fElpzQKPLaI1MB1SAjxZsdScmYzyA==
X-Gm-Gg: ASbGncuitrbxclFklcUQKxf84uIHm3/fTWMUj/o1QJGSAfGXi6nRu7IUVrb7dBXfMWT
	qhg/oaOV45EE+2Tbg6c1i/eZrLuNjr66oSyKmJVCndVK43hHI6PoFpg0JiMqlB5SraHLY/G0paS
	BEE0oGNwNS3snJC6/lPcBF92dvcfMk+JUWMZx79+pMkY79
X-Google-Smtp-Source: AGHT+IHdIoIC0ecPbk9i386el82YjNQ/BSQ5Xri86NxXXrHJS5D67rdJCQdqCmXn/i/hRU7FVD73NP3z9mMXpupAEHg=
X-Received: by 2002:a05:6512:138d:b0:549:4a13:3a82 with SMTP id
 2adb3069b0e04-549c38f5991mr599335e87.21.1741953574590; Fri, 14 Mar 2025
 04:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Dao <dqminh@cloudflare.com>
Date: Fri, 14 Mar 2025 11:59:23 +0000
X-Gm-Features: AQ5f1JqKfQEgU58cs3cg2agt6t-Yid0ku2XNu0Gfg_RonJbqocv8H6TY6lnBicw
Message-ID: <CA+wXwBRKB-1pAHby6FB_jiXspLTHv+mLyVzYj7TjkuT_Y9D4yQ@mail.gmail.com>
Subject: Scheduling latency outliers observed with perf sched record
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

 At Cloudflare with both kernel 6.6.82 and 6.12.17, we frequently
observe scheduling
 latency outliers with `perf sched record`. For example:

-------------------------------------------------------------------------------------------------------------------------------------------
Task                  |   Runtime ms  |  Count   | Avg delay ms    |
Max delay ms    | Max delay start           | Max delay end          |
-------------------------------------------------------------------------------------------------------------------------------------------
Pingora HTTP Pr:3133982 |      0.080 ms |        1 | avg: 881.614 ms |
max: 881.614 ms | max start: 312881.567210 s | max end: 312882.448824
s

The scheduling timeline of the outlier is as follow

          time    cpu  task name                       wait time  sch
delay   run time  state
                        [tid/pid]                          (msec)
(msec)     (msec)
--------------- ------  ------------------------------  ---------
---------  ---------  -----
  312881.567210 [0058]  Pingora HTTP Pr[3045283/3045241
                   awakened: Pingora HTTP Pr[3133982/3045241
  312882.448807 [0015]  Pingora HTTP Pr[3045278/3045241
                   awakened: Pingora HTTP Pr[3133982/3045241
  312882.448861 [0118]  Pingora HTTP Pr[3133982/3045241
                   awakened: Pingora HTTP Pr[3045278/3045241
  312882.448911 [0118]  Pingora HTTP Pr[3133982/3045241      0.000
881.614      0.087      S

According to `perf sched record`, the task received several wakeups
before it finally executed on CPU 118. The timeline
on CPU 118 is as follow:

  312882.448824 [0118]  <idle>                               0.024
 0.024      0.416      I
  312882.448861 [0118]  Pingora HTTP Pr[3133982/3045241
                   awakened: Pingora HTTP Pr[3045278/3045241
  312882.448911 [0118]  Pingora HTTP Pr[3133982/3045241      0.000
881.614      0.087      S

This is very strange and seems impossible because the task was woken
up before but not able to run yet while the CPU has idle time.

In production, we usually do not use `perf sched record`, but using a
ebpf program that is similar to
https://github.com/bpftrace/bpftrace/blob/master/tools/runqlat.but

tracepoint:sched:sched_wakeup, tracepoint:sched:sched_wakeup_new {
  @qtime[args.pid] = nsecs;
}

tracepoint:sched:sched_switch {
  if (args.prev_state == TASK_RUNNING) {
    @qtime[args.prev_pid] = nsecs;
  }

  $ns = @qtime[args.next_pid];
  if ($ns) {
    @usecs = hist((nsecs - $ns) / 1000);
  }
  delete(@qtime, args.next_pid);
}

We do not observe any outliers with this program. We figured that the
difference with perf record is in the case of
supposedly repeated wakeups. The ebpf script took the last wakeup,
while `perf sched latency` took the first wakeup. Once we
adjusted our bpftrace script to take the first wakeup, we observed the
same outliers.

Looking into this further, we adjusted the same bpftrace script to
also print out `sum_exec_runtime` to make sure that
the process didn't actually run i.e. we do not miss any sched_switch
events. The adjusted script is as follow:

#define TASK_RUNNING 0
#define THRESHOLD 100

rt:sched_wakeup, rt:sched_wakeup_new
{
  $task = (struct task_struct *)arg0;
  $ns = @qtime[$task->pid];
  $sum_exec_runtime = @sum_exec_runtime[$task->pid];
  if ($ns > 0 ) {
    $ms = ((nsecs - $ns) / 1000000);
    if ($ms > 100) {
      printf("pid=%d t=%ld delay_ms=%d sum_exec_runtime=%ld
prev_sum_exec_runtime=%ld cached_sum_exec_runtime=%ld\n", $task->pid,
nsecs, $ms,
          $task->se.sum_exec_runtime, $task->se.prev_sum_exec_runtime,
$sum_exec_runtime);
    }
    if ($task->se.sum_exec_runtime == $sum_exec_runtime) {
      // repeated wakeup, and task hasn't been run before, and we have
not missed any sched_switch events, do not count
      return;
    }
  }
  @qtime[$task->pid] = nsecs;
  @sum_exec_runtime[$task->pid] = $task->se.sum_exec_runtime;
}

rt:sched_switch
{
  $prev = (struct task_struct *)arg1;
  $next = (struct task_struct *)arg2;
  $prev_state = arg3;
  if ($prev_state == TASK_RUNNING) {
    @qtime[$prev->pid] = nsecs;
    @sum_exec_runtime[$prev->pid] = $prev->se.sum_exec_runtime;
  }

  $ns = @qtime[$next->pid];
  if ($ns) {
    @usecs = hist((nsecs - $ns) / 1000);
  }
  delete(@qtime[$next->pid]);
  delete(@sum_exec_runtime[$next->pid]);
}

The script gives us the following data:

  pid=2197474 t=298353700427405 delay_ms=1157
sum_exec_runtime=1663205188 prev_sum_exec_runtime=1663167058
cached_sum_exec_runtime=1663167058
  pid=2196692 t=298354187452899 delay_ms=1644
sum_exec_runtime=1630867065 prev_sum_exec_runtime=1630824755
cached_sum_exec_runtime=1630824755
  pid=3290499 t=298354606215376 delay_ms=1482
sum_exec_runtime=26316767196 prev_sum_exec_runtime=26316654306
cached_sum_exec_runtime=26316654306

We can see that the script detected repeated wakeup (i.e. the program
did not observe a sched_switch), but the task exec_runtime has
changed.

Am I understanding correctly that this means that we must have missed
a sched_switch tracepoint event ? We didn't see any
miss counters for our bpf program reported by bpftool. The `perf sched
record` command also didn't report any missing events,
and I think it must have also missed some of these sched_switch events.

Is there anything else that we are missing here ?

Daniel.
