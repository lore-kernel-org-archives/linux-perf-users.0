Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBBD3009C4
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314210; cv=none; b=riPG0E44KyTDP09VZQbCW3wYnkIagFjrubn4P/ZQseBkzhm3BhEP25gwOPVJP7iDZBeDrgKdU0cCz171ZoEn8Aa1hZeoRSWVa5gu12wBts7gfNRRCPvDfjN+kUL7aCk7WHuwfYephnNyRDQFfnc/IkimwZvjNkianRvgon822yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314210; c=relaxed/simple;
	bh=YSBCeJVIevYOnVm2sHlA5hnwW0Cr8h4nDaQoeB1j16E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMrCQ8lXgniNkhua+gu2wpez8du8//U89zZCE5ciR3UbiuWAr4OAxkmG2Cf2oTbPYSkIFnKfdT4qFt6xSPwbhKcBgftLmxYSIxmDAWvAq82a535DPtSpYfP3Pv200LBxmdnIVdzLjvrgvF8iEPprqCK1B1Qmv64nIRWDfygynIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PH9xb7pS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH9xb7pS"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2980343d9d1so12575ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765314207; x=1765919007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8UoB6Cn9IQie1S5cBnUE/EOYuHz4X7hNWpfMm5wvZg=;
        b=PH9xb7pSzZfmTIOmFpLJiiO/Rsz22l7frSusEU1T2X+xImal5XklGbuuNe366xnwY7
         psQ7QvZZC+4jLGyd4P78Q1/Q89b7/rFVIbm5I+OUAf3LhnbOz8yOHoPzO1BQ+LjkvDTC
         ULLpxN8OWHd/GXeLvwWd03vxNkzLN434mG31QokaxuQO6ewGp6mrlKyic8W4Qh3roJOO
         e/I5FKIZrAU+DKuzo8iXS3REWNGiUbMbE2gz1ozfKACcmBA33dOx1rfkF0JmMsrnEut0
         eljSFUnWbz+pPjdvkBtrccGUKoMSJowrFM/Xs8nmslWDVlFQm8XcFpGpoVvB0iX3I27z
         h5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765314207; x=1765919007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8UoB6Cn9IQie1S5cBnUE/EOYuHz4X7hNWpfMm5wvZg=;
        b=RLB6OXkTz9K+U2ztSlPjEJHAi36cccreaQ3VTitRAPjMwgPjfbFJoITAZpNEokvFHo
         co1hoYan/UsCQaxQ/5wCRUfUdDndihc+8Mlw2tJHZM8/HjGnRbC6nBTRmoCb02ub4/YT
         gJ3DUN4vLB0SGAGhWNwP23H4c+cOHZPGr06lzD/NGAhfQ8/zheJRDc5JhMghbVD0H7HA
         Cc3WvsksgOdb2ZRghvicDPV/Ob6NTxeuMPG/73Ndfoom10RHCRCmiyOpY0DqDVlQzo0n
         1Vc5NVeLarVwJeNAwGxFcSdvadnTwCkBCBpPw+3atTn/9Qlz2GoMf1bKSMvDibWqI+mu
         RxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEnFTyAqmvhYiUZsSqNiPXWvi9Br2rUxn+FgA2Av0eUEhWgk2FHvRg1OMmqoFNT+iZhgmZJnvGwyOSoOgEF4Am@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cpWtTS6cqJ0twYy4ztrjcuM+DHPjmKi7USu8BZCPODHgT6qr
	V97sB3yjOw2zFwvPPC+aeUplXPKladd2sT29jRqc3pv4EDlTA0BGRWnuTsfGCRyowWJ7tjjzWXz
	OlYYzrkomCWi1tnfa7GtdDgsTVpQc1ABeZetFB7Mv
X-Gm-Gg: AY/fxX5g2fn5dft+5BsvJxbkr56/Nek7+wxoAl14BNMCTIS70D3AU6xiSOWYwZ78PUe
	80q+q2+NPe6x4UPYlz5idwPuvhJlP4hFd6TOrnQS4dA2vskY92gzGJdmzOJEZWgoWZ59A2Nl7M5
	wOUNHGPL4GnKisDqMWc270jobevXlhN69+SA+ky2vBu71hj6nSNEwz8oLaGm3okafgXKhCQgKpJ
	Kj0HbbejtO/GSrwC/RXImgteWA62jV7ZTdAM1+7MIGKy64ksf5MgfkvM2PmMsLi3VeGGS6c/yPb
	xnXIDsz0Kk2/bm1XhAOWtlDC
X-Google-Smtp-Source: AGHT+IGb2fcjgDnoILoJjcJpgHW8ySYURemDvRn5iC5vee+jaZQeO2MwMp3ozxNjIjyiOILOIFtbtvCoyIZZZd/hVhI=
X-Received: by 2002:a17:903:2286:b0:290:dd42:eb5f with SMTP id
 d9443c01a7336-29ebf91175bmr851335ad.12.1765314206270; Tue, 09 Dec 2025
 13:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826051039.2626894-1-swapnil.sapkal@amd.com> <cc87d705-0409-4451-b95d-8a9af94f0c1c@amd.com>
In-Reply-To: <cc87d705-0409-4451-b95d-8a9af94f0c1c@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Dec 2025 13:03:14 -0800
X-Gm-Features: AQt7F2rnFMv9EujLk-INNCBV29ON8MlNCD5Ex6h-1cwL_pq1yPgvZW2DPDtyCZA
Message-ID: <CAP-5=fWSFgkWggNaYDRno=Lv+s980_9ckr3vKy+CX2TsCJH+vA@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] perf sched: Introduce stats tool
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, james.clark@arm.com, ravi.bangoria@amd.com, 
	yu.c.chen@intel.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, rostedt@goodmis.org, vincent.guittot@linaro.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com, 
	void@manifault.com, tj@kernel.org, sshegde@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	santosh.shukla@amd.com, sandipan.das@amd.com, 
	Cristian Prundeanu <cpru@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:43=E2=80=AFPM Sapkal, Swapnil <swapnil.sapkal@amd=
.com> wrote:
>
> Hello all,
>
> Missed to add perf folks to the list. Adding them here. Sorry about that.

Hi Swapnil,

I was wondering if this patch series was active? The kernel test robot
mentioned an issue.

> --
> Thanks and Regards,
> Swapnil
>
> On 8/26/2025 10:40 AM, Swapnil Sapkal wrote:
> > Apologies for long delay, I was side tracked on some other items. I was
> > not able to focus on this.
> >
> > MOTIVATION
> > ----------
> >
> > Existing `perf sched` is quite exhaustive and provides lot of insights
> > into scheduler behavior but it quickly becomes impractical to use for
> > long running or scheduler intensive workload. For ex, `perf sched recor=
d`
> > has ~7.77% overhead on hackbench (with 25 groups each running 700K loop=
s
> > on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> > generates huge 56G perf.data for which perf takes ~137 mins to prepare
> > and write it to disk [1].
> >
> > Unlike `perf sched record`, which hooks onto set of scheduler tracepoin=
ts
> > and generates samples on a tracepoint hit, `perf sched stats record` ta=
kes
> > snapshot of the /proc/schedstat file before and after the workload, i.e=
.
> > there is almost zero interference on workload run. Also, it takes very
> > minimal time to parse /proc/schedstat, convert it into perf samples and
> > save those samples into perf.data file. Result perf.data file is much
> > smaller. So, overall `perf sched stats record` is much more light weigh=
t
> > compare to `perf sched record`.
> >
> > We, internally at AMD, have been using this (a variant of this, known a=
s
> > "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> > of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
> > series to report the analysis[6][7].
> >
> > Please note that, this is not a replacement of perf sched record/report=
.
> > The intended users of the new tool are scheduler developers, not regula=
r
> > users.
> >
> > USAGE
> > -----
> >
> >    # perf sched stats record
> >    # perf sched stats report
> >    # perf sched stats diff
> >
> > Note: Although `perf sched stats` tool supports workload profiling synt=
ax
> > (i.e. -- <workload> ), the recorded profile is still systemwide since t=
he
> > /proc/schedstat is a systemwide file.
> >
> > HOW TO INTERPRET THE REPORT
> > ---------------------------
> >
> > The `perf sched stats report` starts with description of the columns
> > present in the report. These column names are given before cpu and
> > domain stats to improve the readability of the report.
> >
> >    --------------------------------------------------------------------=
--------------------------------
> >    DESC                    -> Description of the field
> >    COUNT                   -> Value of the field
> >    PCT_CHANGE              -> Percent change with corresponding base va=
lue
> >    AVG_JIFFIES             -> Avg time in jiffies between two consecuti=
ve occurrence of event
> >    --------------------------------------------------------------------=
--------------------------------
> >
> > Next is the total profiling time in terms of jiffies:
> >
> >    --------------------------------------------------------------------=
--------------------------------
> >    Time elapsed (in jiffies)                                   :       =
24537
> >    --------------------------------------------------------------------=
--------------------------------
> >
> > Next is CPU scheduling statistics. These are simple diffs of
> > /proc/schedstat CPU lines along with description. The report also
> > prints % relative to base stat.

I wonder if this is similar to user_time and system_time:
```
$ perf list
...
tool:
...
 system_time
      [System/kernel time in nanoseconds. Unit: tool]
...
 user_time
      [User (non-kernel) time in nanoseconds. Unit: tool]
...
```
These events are implemented by reading /proc/stat and /proc/pid/stat:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/tool_pmu.c?h=3Dperf-tools-next#n267

As they are events then they can appear in perf stat output and also
within metrics.

Thanks,
Ian

> >
> > In the example below, schedule() left the CPU0 idle 36.58% of the time.
> > 0.45% of total try_to_wake_up() was to wakeup local CPU. And, the total
> > waittime by tasks on CPU0 is 48.70% of the total runtime by tasks on th=
e
> > same CPU.
> >
> >    --------------------------------------------------------------------=
--------------------------------
> >    CPU 0
> >    --------------------------------------------------------------------=
--------------------------------
> >    DESC                                                                =
     COUNT   PCT_CHANGE
> >    --------------------------------------------------------------------=
--------------------------------
> >    yld_count                                                        :  =
         0
> >    array_exp                                                        :  =
         0
> >    sched_count                                                      :  =
    402267
> >    sched_goidle                                                     :  =
    147161  (    36.58% )
> >    ttwu_count                                                       :  =
    236309
> >    ttwu_local                                                       :  =
      1062  (     0.45% )
> >    rq_cpu_time                                                      :  =
7083791148
> >    run_delay                                                        :  =
3449973971  (    48.70% )
> >    pcount                                                           :  =
    255035
> >    --------------------------------------------------------------------=
--------------------------------
> >
> > Next is load balancing statistics. For each of the sched domains
> > (eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
> > the following three categories:
> >
> >    1) Idle Load Balance: Load balancing performed on behalf of a long
> >                          idling CPU by some other CPU.
> >    2) Busy Load Balance: Load balancing performed when the CPU was busy=
.
> >    3) New Idle Balance : Load balancing performed when a CPU just becam=
e
> >                          idle.
> >
> > Under each of these three categories, sched stats report provides
> > different load balancing statistics. Along with direct stats, the
> > report also contains derived metrics prefixed with *. Example:
> >
> >    --------------------------------------------------------------------=
--------------------------------
> >    CPU 0, DOMAIN SMT CPUS 0,64
> >    --------------------------------------------------------------------=
--------------------------------
> >    DESC                                                                =
     COUNT    AVG_JIFFIES
> >    ----------------------------------------- <Category busy> ----------=
--------------------------------
> >    busy_lb_count                                                    :  =
       136  $       17.08 $
> >    busy_lb_balanced                                                 :  =
       131  $       17.73 $
> >    busy_lb_failed                                                   :  =
         0  $        0.00 $
> >    busy_lb_imbalance_load                                           :  =
        58
> >    busy_lb_imbalance_util                                           :  =
         0
> >    busy_lb_imbalance_task                                           :  =
         0
> >    busy_lb_imbalance_misfit                                         :  =
         0
> >    busy_lb_gained                                                   :  =
         7
> >    busy_lb_hot_gained                                               :  =
         0
> >    busy_lb_nobusyq                                                  :  =
         2  $     1161.50 $
> >    busy_lb_nobusyg                                                  :  =
       129  $       18.01 $
> >    *busy_lb_success_count                                           :  =
         5
> >    *busy_lb_avg_pulled                                              :  =
      1.40
> >    ----------------------------------------- <Category idle> ----------=
--------------------------------
> >    idle_lb_count                                                    :  =
       449  $        5.17 $
> >    idle_lb_balanced                                                 :  =
       382  $        6.08 $
> >    idle_lb_failed                                                   :  =
         3  $      774.33 $
> >    idle_lb_imbalance_load                                           :  =
         0
> >    idle_lb_imbalance_util                                           :  =
         0
> >    idle_lb_imbalance_task                                           :  =
        71
> >    idle_lb_imbalance_misfit                                         :  =
         0
> >    idle_lb_gained                                                   :  =
        67
> >    idle_lb_hot_gained                                               :  =
         0
> >    idle_lb_nobusyq                                                  :  =
         0  $        0.00 $
> >    idle_lb_nobusyg                                                  :  =
       382  $        6.08 $
> >    *idle_lb_success_count                                           :  =
        64
> >    *idle_lb_avg_pulled                                              :  =
      1.05
> >    ---------------------------------------- <Category newidle> --------=
--------------------------------
> >    newidle_lb_count                                                 :  =
     30471  $        0.08 $
> >    newidle_lb_balanced                                              :  =
     28490  $        0.08 $
> >    newidle_lb_failed                                                :  =
       633  $        3.67 $
> >    newidle_lb_imbalance_load                                        :  =
         0
> >    newidle_lb_imbalance_util                                        :  =
         0
> >    newidle_lb_imbalance_task                                        :  =
      2040
> >    newidle_lb_imbalance_misfit                                      :  =
         0
> >    newidle_lb_gained                                                :  =
      1348
> >    newidle_lb_hot_gained                                            :  =
         0
> >    newidle_lb_nobusyq                                               :  =
         6  $      387.17 $
> >    newidle_lb_nobusyg                                               :  =
     26634  $        0.09 $
> >    *newidle_lb_success_count                                        :  =
      1348
> >    *newidle_lb_avg_pulled                                           :  =
      1.00
> >    --------------------------------------------------------------------=
--------------------------------
> >
> > Consider following line:
> >
> > newidle_lb_balanced                                              :     =
  28490  $        0.08 $
> >
> > While profiling was active, the load-balancer found 28490 times the loa=
d
> > needs to be balanced on a newly idle CPU 0. Following value encapsulate=
d
> > inside $ is average jiffies between two events (28490 / 24537 =3D 0.08)=
.
> >
> > Next are active_load_balance() stats. alb did not trigger while the
> > profiling was active, hence it's all 0s.
> >
> >
> >    --------------------------------- <Category active_load_balance()> -=
--------------------------------
> >    alb_count                                                        :  =
         0
> >    alb_failed                                                       :  =
         0
> >    alb_pushed                                                       :  =
         0
> >    --------------------------------------------------------------------=
--------------------------------
> >
> > Next are sched_balance_exec() and sched_balance_fork() stats. They are
> > not used but we kept it in RFC just for legacy purpose. Unless opposed,
> > we plan to remove them in next revision.
> >
> > Next are wakeup statistics. For every domain, the report also shows
> > task-wakeup statistics. Example:
> >
> >    ------------------------------------------ <Wakeup Info> -----------=
--------------------------------
> >    ttwu_wake_remote                                                 :  =
      1590
> >    ttwu_move_affine                                                 :  =
        84
> >    ttwu_move_balance                                                :  =
         0
> >    --------------------------------------------------------------------=
--------------------------------
> >
> > Same set of stats are reported for each CPU and each domain level.
> >
> > HOW TO INTERPRET THE DIFF
> > -------------------------
> >
> > The `perf sched stats diff` will also start with explaining the columns
> > present in the diff. Then it will show the diff in time in terms of
> > jiffies. The order of the values depends on the order of input data
> > files. Example:
> >
> >    --------------------------------------------------------------------=
--------------------------------
> >    Time elapsed (in jiffies)                                        :  =
      2763,       2763
> >    --------------------------------------------------------------------=
--------------------------------
> >
> > Below is the sample representing the difference in cpu and domain stats=
 of
> > two runs. Here third column or the values enclosed in `|...|` shows the
> > percent change between the two. Second and fourth columns shows the
> > side-by-side representions of the corresponding fields from `perf sched
> > stats report`.
> >
> >    --------------------------------------------------------------------=
--------------------------------
> >    CPU <ALL CPUS SUMMARY>
> >    --------------------------------------------------------------------=
--------------------------------
> >    DESC                                                                =
    COUNT1      COUNT2   PCT_CHANG>
> >    --------------------------------------------------------------------=
--------------------------------
> >    yld_count                                                        :  =
         0,          0  |     0.00>
> >    array_exp                                                        :  =
         0,          0  |     0.00>
> >    sched_count                                                      :  =
    528533,     412573  |   -21.94>
> >    sched_goidle                                                     :  =
    193426,     146082  |   -24.48>
> >    ttwu_count                                                       :  =
    313134,     385975  |    23.26>
> >    ttwu_local                                                       :  =
      1126,       1282  |    13.85>
> >    rq_cpu_time                                                      :  =
8257200244, 8301250047  |     0.53>
> >    run_delay                                                        :  =
4728347053, 3997100703  |   -15.47>
> >    pcount                                                           :  =
    335031,     266396  |   -20.49>
> >    --------------------------------------------------------------------=
--------------------------------
> >
> > Below is the sample of domain stats diff:
> >
> >    --------------------------------------------------------------------=
--------------------------------
> >    CPU <ALL CPUS SUMMARY>, DOMAIN SMT
> >    --------------------------------------------------------------------=
--------------------------------
> >    DESC                                                                =
    COUNT1      COUNT2   PCT_CHANG>
> >    ----------------------------------------- <Category busy> ----------=
--------------------------------
> >    busy_lb_count                                                    :  =
       122,         80  |   -34.43>
> >    busy_lb_balanced                                                 :  =
       115,         76  |   -33.91>
> >    busy_lb_failed                                                   :  =
         1,          3  |   200.00>
> >    busy_lb_imbalance_load                                           :  =
        35,         49  |    40.00>
> >    busy_lb_imbalance_util                                           :  =
         0,          0  |     0.00>
> >    busy_lb_imbalance_task                                           :  =
         0,          0  |     0.00>
> >    busy_lb_imbalance_misfit                                         :  =
         0,          0  |     0.00>
> >    busy_lb_gained                                                   :  =
         7,          2  |   -71.43>
> >    busy_lb_hot_gained                                               :  =
         0,          0  |     0.00>
> >    busy_lb_nobusyq                                                  :  =
         0,          0  |     0.00>
> >    busy_lb_nobusyg                                                  :  =
       115,         76  |   -33.91>
> >    *busy_lb_success_count                                           :  =
         6,          1  |   -83.33>
> >    *busy_lb_avg_pulled                                              :  =
      1.17,       2.00  |    71.43>
> >    ----------------------------------------- <Category idle> ----------=
--------------------------------
> >    idle_lb_count                                                    :  =
       568,        620  |     9.15>
> >    idle_lb_balanced                                                 :  =
       462,        449  |    -2.81>
> >    idle_lb_failed                                                   :  =
        11,         21  |    90.91>
> >    idle_lb_imbalance_load                                           :  =
         0,          0  |     0.00>
> >    idle_lb_imbalance_util                                           :  =
         0,          0  |     0.00>
> >    idle_lb_imbalance_task                                           :  =
       115,        189  |    64.35>
> >    idle_lb_imbalance_misfit                                         :  =
         0,          0  |     0.00>
> >    idle_lb_gained                                                   :  =
       103,        169  |    64.08>
> >    idle_lb_hot_gained                                               :  =
         0,          0  |     0.00>
> >    idle_lb_nobusyq                                                  :  =
         0,          0  |     0.00>
> >    idle_lb_nobusyg                                                  :  =
       462,        449  |    -2.81>
> >    *idle_lb_success_count                                           :  =
        95,        150  |    57.89>
> >    *idle_lb_avg_pulled                                              :  =
      1.08,       1.13  |     3.92>
> >    ---------------------------------------- <Category newidle> --------=
--------------------------------
> >    newidle_lb_count                                                 :  =
     16961,       3155  |   -81.40>
> >    newidle_lb_balanced                                              :  =
     15646,       2556  |   -83.66>
> >    newidle_lb_failed                                                :  =
       397,        142  |   -64.23>
> >    newidle_lb_imbalance_load                                        :  =
         0,          0  |     0.00>
> >    newidle_lb_imbalance_util                                        :  =
         0,          0  |     0.00>
> >    newidle_lb_imbalance_task                                        :  =
      1376,        655  |   -52.40>
> >    newidle_lb_imbalance_misfit                                      :  =
         0,          0  |     0.00>
> >    newidle_lb_gained                                                :  =
       917,        457  |   -50.16>
> >    newidle_lb_hot_gained                                            :  =
         0,          0  |     0.00>
> >    newidle_lb_nobusyq                                               :  =
         3,          1  |   -66.67>
> >    newidle_lb_nobusyg                                               :  =
     14480,       2103  |   -85.48>
> >    *newidle_lb_success_count                                        :  =
       918,        457  |   -50.22>
> >    *newidle_lb_avg_pulled                                           :  =
      1.00,       1.00  |     0.11>
> >    --------------------------------- <Category active_load_balance()> -=
--------------------------------
> >    alb_count                                                        :  =
         0,          1  |     0.00>
> >    alb_failed                                                       :  =
         0,          0  |     0.00>
> >    alb_pushed                                                       :  =
         0,          1  |     0.00>
> >    --------------------------------- <Category sched_balance_exec()> --=
--------------------------------
> >    sbe_count                                                        :  =
         0,          0  |     0.00>
> >    sbe_balanced                                                     :  =
         0,          0  |     0.00>
> >    sbe_pushed                                                       :  =
         0,          0  |     0.00>
> >    --------------------------------- <Category sched_balance_fork()> --=
--------------------------------
> >    sbf_count                                                        :  =
         0,          0  |     0.00>
> >    sbf_balanced                                                     :  =
         0,          0  |     0.00>
> >    sbf_pushed                                                       :  =
         0,          0  |     0.00>
> >    ------------------------------------------ <Wakeup Info> -----------=
--------------------------------
> >    ttwu_wake_remote                                                 :  =
      2031,       2914  |    43.48>
> >    ttwu_move_affine                                                 :  =
        73,        124  |    69.86>
> >    ttwu_move_balance                                                :  =
         0,          0  |     0.00>
> >    --------------------------------------------------------------------=
--------------------------------
> >
> > v3: https://lore.kernel.org/all/20250311120230.61774-1-swapnil.sapkal@a=
md.com/
> > v3->v4:
> >   - All the review comments from v3 are addressed [Namhyung Kim].
> >   - Print short names instead of field descripion in the report [Peter =
Zijlstra]
> >   - Fix the double free issue [Cristian Prundeanu]
> >   - Documentation update related to `perf sched stats diff` [Chen yu]
> >   - Bail out `perf sched stats diff` if perf.data files have different =
schedstat
> >     versions [Peter Zijlstra]
> >
> > v2: https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal=
@amd.com/
> > v2->v3:
> >   - Add perf unit test for basic sched stats functionalities
> >   - Describe new tool, it's usage and interpretation of report data in =
the
> >     perf-sched man page.
> >   - Add /proc/schedstat version 17 support.
> >
> > v1: https://lore.kernel.org/lkml/20240916164722.1838-1-ravi.bangoria@am=
d.com
> > v1->v2
> >   - Add the support for `perf sched stats diff`
> >   - Add column header in report for better readability. Use
> >     procfs__mountpoint for consistency. Add hint for enabling
> >     CONFIG_SCHEDSTAT if disabled. [James Clark]
> >   - Use a single header file for both cpu and domain fileds. Change
> >     the layout of structs to minimise the padding. I tried changing
> >     `v15` to `15` in the header files but it was not giving any
> >     benefits so drop the idea. [Namhyung Kim]
> >   - Add tested-by.
> >
> > RFC: https://lore.kernel.org/r/20240508060427.417-1-ravi.bangoria@amd.c=
om
> > RFC->v1:
> >   - [Kernel] Print domain name along with domain number in /proc/scheds=
tat
> >     file.
> >   - s/schedstat/stats/ for the subcommand.
> >   - Record domain name and cpumask details, also show them in report.
> >   - Add CPU filtering capability at record and report time.
> >   - Add /proc/schedstat v16 support.
> >   - Live mode support. Similar to perf stat command, live mode prints t=
he
> >     sched stats on the stdout.
> >   - Add pager support in `perf sched stats report` for better scrolling=
.
> >   - Some minor cosmetic changes in report output to improve readability=
.
> >   - Rebase to latest perf-tools-next/perf-tools-next (1de5b5dcb835).
> >
> > TODO:
> >   - perf sched stats records /proc/schedstat which is a CPU and domain
> >     level scheduler statistic. We are planning to add taskstat tool whi=
ch
> >     reads task stats from procfs and generate scheduler statistic repor=
t
> >     at task granularity. this will probably a standalone tool, somethin=
g
> >     like `perf sched taskstat record/report`.
> >   - Except pre-processor related checkpatch warnings, we have addressed
> >     most of the other possible warnings.
> >   - This version supports diff for two perf.data files captured for sam=
e
> >     schedstats version but the target is to show diff for multiple
> >     perf.data files. Plan is to support diff if perf.data files provide=
d
> >     has different schedstat versions.
> >
> > Patches are prepared on v6.17-rc3 (1b237f190eb3).
> >
> > [1] https://youtu.be/lg-9aG2ajA0?t=3D283
> > [2] https://github.com/AMDESE/sched-scoreboard
> > [3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@a=
md.com/
> > [4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@a=
md.com/
> > [5] https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal=
@amd.com/
> > [6] https://lore.kernel.org/lkml/3170d16e-eb67-4db8-a327-eb8188397fdb@a=
md.com/
> > [7] https://lore.kernel.org/lkml/feb31b6e-6457-454c-a4f3-ce8ad96bf8de@a=
md.com/
> >
> > Swapnil Sapkal (11):
> >    perf: Add print_separator to util
> >    tools/lib: Add list_is_first()
> >    perf header: Support CPU DOMAIN relation info
> >    perf sched stats: Add record and rawdump support
> >    perf sched stats: Add schedstat v16 support
> >    perf sched stats: Add schedstat v17 support
> >    perf sched stats: Add support for report subcommand
> >    perf sched stats: Add support for live mode
> >    perf sched stats: Add support for diff subcommand
> >    perf sched stats: Add basic perf sched stats test
> >    perf sched stats: Add details in man page
> >
> >   tools/include/linux/list.h                    |   10 +
> >   tools/lib/perf/Documentation/libperf.txt      |    2 +
> >   tools/lib/perf/Makefile                       |    1 +
> >   tools/lib/perf/include/perf/event.h           |   69 ++
> >   tools/lib/perf/include/perf/schedstat-v15.h   |  146 +++
> >   tools/lib/perf/include/perf/schedstat-v16.h   |  146 +++
> >   tools/lib/perf/include/perf/schedstat-v17.h   |  164 +++
> >   tools/perf/Documentation/perf-sched.txt       |  261 ++++-
> >   .../Documentation/perf.data-file-format.txt   |   17 +
> >   tools/perf/builtin-inject.c                   |    3 +
> >   tools/perf/builtin-kwork.c                    |   13 +-
> >   tools/perf/builtin-sched.c                    | 1027 ++++++++++++++++=
-
> >   tools/perf/tests/shell/perf_sched_stats.sh    |   64 +
> >   tools/perf/util/env.h                         |   16 +
> >   tools/perf/util/event.c                       |   52 +
> >   tools/perf/util/event.h                       |    2 +
> >   tools/perf/util/header.c                      |  304 +++++
> >   tools/perf/util/header.h                      |    6 +
> >   tools/perf/util/session.c                     |   22 +
> >   tools/perf/util/synthetic-events.c            |  196 ++++
> >   tools/perf/util/synthetic-events.h            |    3 +
> >   tools/perf/util/tool.c                        |   18 +
> >   tools/perf/util/tool.h                        |    4 +-
> >   tools/perf/util/util.c                        |   48 +
> >   tools/perf/util/util.h                        |    5 +
> >   25 files changed, 2587 insertions(+), 12 deletions(-)
> >   create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
> >   create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h
> >   create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h
> >   create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh
> >
>
