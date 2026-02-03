Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546B2DB783
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159952; cv=pass; b=UoP6RYKQSrJcKZZ6MvTjsi6w77ulNPLtDuGyHm5W3heZ4z+pkOAXOAEvRsTq51htdbOG+G6IZEv0EQOkaSLcS12SimZQk2yncZf6x5/9EojjWPvSq/dpVOx+rhdPID6QOp40ntDg0q5j6dS13DA6Cd0UAmyOfTjZrj4mA5amMWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159952; c=relaxed/simple;
	bh=Ap4Ooes10w3JfMD4+ZgHjKxoy5FkRcecogLjA+8kRYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNmsm7zS9eXMsuFa/qeYyoyMgjh1Xw8j6kHfQOqfs6nMsCd2gfLG8ygztFKWLYBuAkRxzZRnj9HmvB81rGn/EYmMf0yErQ9W7fS20e3gkH+1il9LzWeVd4SdVOEeG1Cyxe6IQd9VVxGVMOJi22yNShS1tQTEXd6/Cb0XUi5rAmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYNvxmUa; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYNvxmUa"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so10965ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 15:05:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770159951; cv=none;
        d=google.com; s=arc-20240605;
        b=Jjls1btsHbDzBeCY0QjnxEcbUZQKUsrSr5stJsyuzfpF4IIFDqZxVI2gyplrLjeH0F
         V0PBCiuaeq0pbuABR6NcxEoTFGex6AVvH2AQ4HiJX63bzi0RnAUXaEbXcOIpPYO/NjhQ
         Ka02yK90UM8Fpxpp4W/UpaxVpMP/uaHBydszHxnunepT1hmp6ROA/etftfF/c1dJi1Xi
         8xw2HpvmI3wjFeMjxOCmxRS0U7Tq/iZiB+MwkttvYND46cL6ng5EcGBHGX3ZMGr7N/oC
         MJyPAQno2x2/HeXlBNEoUZJl80tq8Qh13s2eh4phUsDLJhw+knQG262XaQY1CqZUJLjL
         TT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=inblNn5c5dccowVcxAfMNLjmBQ3M/lFQVDC96f0AJrw=;
        fh=QVISx8uo+hE8RzHlbd/tM9j7lqiSPyDYa15gEdTMMCI=;
        b=O0E5BUXZiwIX+pSsEkBSz1MtJC+9n4o8zICLsYqVtySD7r/09WYuAfn5SFkukCew7O
         RdBfl+DGJBGqb07cl3YWt85LHO4iE/YVruFCnBw3F6CTlXYbbNcFjn/DgYYIAdsucCFf
         E8+SnTvFabbDShmHOeHvlQoxtO4rFinBdTkgSWR/IHK1FXjSLMMN3o2LUQ3XbnWN72Rf
         ThlqSUc/WbSV9vzsKEGWFCfW0NXdY2bG7yeJZMKlRAPBljrH9kQ6O1MNKT3oI3R6Gldq
         V/6TIegU2z0mJpvdouTECNiK2LU5WbWQuUzWqp05xkbGFoFZbg2+OymGb7cRBMhPBqcZ
         jyrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770159951; x=1770764751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inblNn5c5dccowVcxAfMNLjmBQ3M/lFQVDC96f0AJrw=;
        b=CYNvxmUaw7LPS/IattKyvccx/auLIrs9fX6Silx53N37H8s9Tjt/m/rGI3UUFV/to5
         PTxlZXKmCaMupSN/ZylIXWInwvpAa8fuaLIjprv5WGk2Et5GCrptX1H8MVgFYyJMk+u6
         Hecaou9CH4TKJuDmgsnRN3MQn+vXIH2S7cnr2x1pKEpXSda0VvIcEI3OP8aFefjJqnEZ
         ohHlIJN8/VeAC3IB/Llpdwq79nteh0/SVIq/KgCXYro7MMjR0ut9Gi8u3gozDW90KyKu
         dgYO2wmSOWovyqh2jmPOA6jfLlfTGd707vU0lkHwiFl5EHcVivDgdeuLF0PuGn72Cte9
         J9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770159951; x=1770764751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=inblNn5c5dccowVcxAfMNLjmBQ3M/lFQVDC96f0AJrw=;
        b=a636/CMeVLysdDNsHEE3B6yF+ieyeR1LuUPrgUpY6OKdT06maEN0o7yVoUKjevf3mO
         EaUnDSBCLEN9KlzEKVLTc7Tb+A4VjqezXn9MrbVGilDUUHWzpWmdV1aDyslh6qSY76kC
         7IfHJsWKZLN6zJA0zkpev3jFe8A5xdvX8RSLJRWuLb6BFLdgQF6TJyAIfXxSBg/ZdeLd
         Ru7npzsoCm4SorGvR3p2fCGeLbd55GkXiP+KEJ9TlAPwg/3rLHb1XDTIF3d4tPgQDJFb
         vg+taWw/gfaWKwNxCkGpzTrL0h+W+44t0g1iQiSxPjUb8ig3uXhhQTym3pkBVhRfyReq
         5Xkw==
X-Forwarded-Encrypted: i=1; AJvYcCWLszkMfuuFhwqdZRdePza20Ujlqsd8AJ/7u/IaSIeUpFlH45vKlPwAgrlqkViHfI5FRPxKvbpVsv+wQdiWuThL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lSWa/9nze63+PhndRl/feHvl5i/5EBh2ccQkUuJGlnYwJHWW
	6nRxUXZSDHZ6Ez0JAns6PINiuYjmIvTVDAZ8vZmJACEL2bYQOmZUnN741nzk69aukeNaOcNoVFp
	Bq91bo/7AGXhLz3MyNvkSpSAjWcpJfpQahS6HMH9H
X-Gm-Gg: AZuq6aJD7x6Bpb7t9dp5saBFp+4HZf9RVBI8tApN34r5Qp51KLFgu0piL2pg/YCkvpA
	Gw+qiS7P9i+dCFkhdRKCIGA0o4qQxChs7lb3yIFDi7pVYj8ti7R9IePJF+dZSF07nRNuMFwjJ4m
	nSZ//WfvvXYExuX73bHQWCVS7BEu9ze01i3gtfSo8gCpm5t4VeqjQQcmXV5GtNpA+L4xE53Qr9Z
	EeoG2mVcXjMb1yMLRQbthnC2iIJxBz4YlaIUhxbC0B86rlp7PCA/6HCRC5SKgtfA/5Nr0f+gYpM
	c5olPeFSgBwoZnlVdfCSKAOFWBClc5n2/1rG
X-Received: by 2002:a17:902:e543:b0:29f:f71:a3b9 with SMTP id
 d9443c01a7336-2a9357d109fmr444495ad.5.1770159950273; Tue, 03 Feb 2026
 15:05:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com> <20251113180517.44096-8-irogers@google.com>
 <cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6>
In-Reply-To: <cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Feb 2026 15:05:39 -0800
X-Gm-Features: AZwV_QgV2c2ssY1A9E1Ke3U5p9PSXotmW0ffQl_xNYwt4Tg6Y_xTxzW0TvGKlbo
Message-ID: <CAP-5=fVk+B815c3CX4BLSR++JQPX7AgVnO-3Ef+=rj2DLVRKQw@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] perf tool_pmu: More accurately set the cpus for
 tool events
To: Andres Freund <andres@anarazel.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 9:37=E2=80=AFAM Andres Freund <andres@anarazel.de> w=
rote:
>
> Hi,
>
> On 2025-11-13 10:05:13 -0800, Ian Rogers wrote:
> > The user and system time events can record on different CPUs, but for
> > all other events a single CPU map of just CPU 0 makes sense. In
> > parse-events detect a tool PMU and then pass the perf_event_attr so
> > that the tool_pmu can return CPUs specific for the event. This avoids
> > a CPU map of all online CPUs being used for events like
> > duration_time. Avoiding this avoids the evlist CPUs containing CPUs
> > for which duration_time just gives 0. Minimizing the evlist CPUs can
> > remove unnecessary sched_setaffinity syscalls that delay metric
> > calculations.
>
> I was just testing v6.19-rc* and noticed that
>   perf stat -C $somecpu sleep 1
> segfaults.
>
> I bisected that down to this change (d8d8a0b3603a9a8fa207cf9e4f292e81dc5d=
1008).
>
> $ git describe
> v6.18-rc1-116-gd8d8a0b3603a9
>
> $ gdb --args perf stat -C11 sleep 1
> (gdb) r
> Starting program: /home/andres/bin/bin/perf stat -C11 sleep 1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/usr/lib/x86_64-linux-gnu/libthread_db.s=
o.1".
> [Detaching after fork from child process 843870]
>
>  Performance counter stats for 'CPU(s) 11':
>
>                 16      context-switches                 #     16.0 cs/se=
c  cs_per_second
>           1,001.66 msec cpu-clock
> Program received signal SIGSEGV, Segmentation fault.
> prepare_metric (config=3Dconfig@entry=3D0x55555603bd80 <stat_config>, mex=
p=3Dmexp@entry=3D0x5555560a40f0, evsel=3Devsel@entry=3D0x555556093e20,
>     pctx=3Dpctx@entry=3D0x5555560a7150, aggr_idx=3Daggr_idx@entry=3D0) at=
 util/stat-shadow.c:85
> 85                      aggr =3D &ps->aggr[is_tool_time ? tool_aggr_idx :=
 aggr_idx];
> (gdb) bt
> #0  prepare_metric (config=3Dconfig@entry=3D0x55555603bd80 <stat_config>,=
 mexp=3Dmexp@entry=3D0x5555560a40f0, evsel=3Devsel@entry=3D0x555556093e20,
>     pctx=3Dpctx@entry=3D0x5555560a7150, aggr_idx=3Daggr_idx@entry=3D0) at=
 util/stat-shadow.c:85
> #1  0x00005555557be0eb in generic_metric (config=3D<optimized out>, mexp=
=3D0x5555560a40f0, evsel=3D<optimized out>, aggr_idx=3D<optimized out>, out=
=3D0x7fffffff76c0)
>     at util/stat-shadow.c:146
> #2  perf_stat__print_shadow_stats_metricgroup (config=3Dconfig@entry=3D0x=
55555603bd80 <stat_config>, evsel=3D<optimized out>, aggr_idx=3D0,
>     num=3Dnum@entry=3D0x7fffffff7604, from=3Dfrom@entry=3D0x0, out=3D0x7f=
ffffff76c0) at util/stat-shadow.c:307
> #3  0x00005555557be4c7 in perf_stat__print_shadow_stats (config=3Dconfig@=
entry=3D0x55555603bd80 <stat_config>, evsel=3Devsel@entry=3D0x555556093e20,
>     aggr_idx=3Daggr_idx@entry=3D0, out=3Dout@entry=3D0x7fffffff76c0) at u=
til/stat-shadow.c:325
> #4  0x00005555557c03a3 in printout (config=3D<optimized out>, os=3D0x7fff=
ffff78b0, uval=3D<optimized out>, run=3D1001660763, ena=3D<optimized out>,
>     noise=3D<optimized out>, aggr_idx=3D0) at util/stat-display.c:874
> #5  0x00005555557c1424 in print_counter_aggrdata (config=3D0x55555603bd80=
 <stat_config>, counter=3D0x555556093e20, aggr_idx=3D0, os=3D<optimized out=
>)
>     at util/stat-display.c:1013
> #6  0x00005555557c3051 in print_counter (config=3D<optimized out>, counte=
r=3D<optimized out>, os=3D<optimized out>) at util/stat-display.c:1127
> #7  print_counter (config=3D<optimized out>, counter=3D<optimized out>, o=
s=3D<optimized out>) at util/stat-display.c:1117
> #8  evlist__print_counters (evlist=3D<optimized out>, config=3Dconfig@ent=
ry=3D0x55555603bd80 <stat_config>, _target=3D_target@entry=3D0x5555560412e0=
 <target>,
>     ts=3Dts@entry=3D0x0, argc=3Dargc@entry=3D2, argv=3Dargv@entry=3D0x7ff=
fffffdb20) at util/stat-display.c:1600
> #9  0x00005555555d0d27 in print_counters (ts=3D0x0, argc=3D2, argv=3D0x7f=
ffffffdb20) at builtin-stat.c:1070
> #10 print_counters (ts=3D0x0, argc=3D2, argv=3D0x7fffffffdb20) at builtin=
-stat.c:1062
> #11 cmd_stat (argc=3D2, argv=3D0x7fffffffdb20) at builtin-stat.c:2949
> #12 0x000055555562fee2 in run_builtin (p=3Dp@entry=3D0x55555602df48 <comm=
ands+360>, argc=3Dargc@entry=3D4, argv=3Dargv@entry=3D0x7fffffffdb20) at pe=
rf.c:349
> #13 0x00005555556301ce in handle_internal_command (argc=3Dargc@entry=3D4,=
 argv=3Dargv@entry=3D0x7fffffffdb20) at perf.c:401
> #14 0x00005555555a8d33 in run_argv (argcp=3D<synthetic pointer>, argv=3D<=
synthetic pointer>) at perf.c:445
> #15 main (argc=3D<optimized out>, argv=3D0x7fffffffdb20) at perf.c:553
>
>
> (gdb) bt full
> #0  prepare_metric (config=3Dconfig@entry=3D0x55555603bd80 <stat_config>,=
 mexp=3Dmexp@entry=3D0x5555560a40f0, evsel=3Devsel@entry=3D0x555556093e20, =
pctx=3Dpctx@entry=3D0x5555560a7150, aggr_idx=3Daggr_idx@entry=3D0) at util/=
stat-shadow.c:85
>         val =3D <optimized out>
>         source_count =3D 0
>         tool_aggr_idx =3D 0
>         is_tool_time =3D true
>         ps =3D 0x0
>         aggr =3D <optimized out>
>         n =3D <optimized out>
>         metric_events =3D <optimized out>
>         metric_refs =3D 0x0
>         i =3D 1
> #1  0x00005555557be0eb in generic_metric (config=3D<optimized out>, mexp=
=3D0x5555560a40f0, evsel=3D<optimized out>, aggr_idx=3D<optimized out>, out=
=3D0x7fffffff76c0) at util/stat-shadow.c:146
>         print_metric =3D 0x5555557c1b70 <print_metric_std>
>         metric_name =3D 0x5555560ae550 "CPUs_utilized"
>         metric_expr =3D 0x555555ea5bb5 "(software@cpu\\-clock\\,name\\=3D=
cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cl=
ock@) / (duration_time * 1e9)"
>         metric_threshold =3D 0x0
>         metric_unit =3D 0x555555ea5c4d "1CPUs"
>         metric_events =3D 0x5555560ae490
>         runtime =3D 0
>         pctx =3D 0x5555560a7150
>         ratio =3D 15.973479072960373
>         scale =3D 1
>         threshold =3D 4.9406564584124654e-324
>         i =3D <optimized out>
>         ctxp =3D 0x7fffffff78b0
>         thresh =3D METRIC_THRESHOLD_UNKNOWN
> #2  perf_stat__print_shadow_stats_metricgroup (config=3Dconfig@entry=3D0x=
55555603bd80 <stat_config>, evsel=3D<optimized out>, aggr_idx=3D0, num=3Dnu=
m@entry=3D0x7fffffff7604, from=3Dfrom@entry=3D0x0, out=3D0x7fffffff76c0) at=
 util/stat-shadow.c:307
>         me =3D 0x5555560877d0
>         mexp =3D 0x5555560a40f0
>         ctxp =3D 0x7fffffff78b0
>         header_printed =3D false
>         name =3D 0x555555879b28 ""
>         metric_events =3D <optimized out>
> #3  0x00005555557be4c7 in perf_stat__print_shadow_stats (config=3Dconfig@=
entry=3D0x55555603bd80 <stat_config>, evsel=3Devsel@entry=3D0x555556093e20,=
 aggr_idx=3Daggr_idx@entry=3D0, out=3Dout@entry=3D0x7fffffff76c0) at util/s=
tat-shadow.c:325
>         print_metric =3D 0x5555557c1b70 <print_metric_std>
>         ctxp =3D 0x7fffffff78b0
>         num =3D 1
> #4  0x00005555557c03a3 in printout (config=3D<optimized out>, os=3D0x7fff=
ffff78b0, uval=3D<optimized out>, run=3D1001660763, ena=3D<optimized out>, =
noise=3D<optimized out>, aggr_idx=3D0) at util/stat-display.c:874
>         out =3D {ctx =3D 0x7fffffff78b0, print_metric =3D 0x5555557c1b70 =
<print_metric_std>, new_line =3D 0x5555557be5a0 <new_line_std>, print_metri=
cgroup_header =3D 0x5555557bea60 <print_metricgroup_header_std>, force_head=
er =3D false}
>         pm =3D <optimized out>
>         nl =3D <optimized out>
>         pmh =3D <optimized out>
>         ok =3D <optimized out>
>         counter =3D 0x555556093e20
> #5  0x00005555557c1424 in print_counter_aggrdata (config=3D0x55555603bd80=
 <stat_config>, counter=3D0x555556093e20, aggr_idx=3D0, os=3D<optimized out=
>) at util/stat-display.c:1013
>         output =3D 0x7ffff69f24e0 <_IO_2_1_stderr_>
>         ena =3D 1001660763
>         run =3D <optimized out>
>         val =3D <optimized out>
>         uval =3D <optimized out>
>         ps =3D <optimized out>
>         aggr =3D <optimized out>
>         id =3D {thread_idx =3D -1, node =3D -1, socket =3D -1, die =3D -1=
, cluster =3D -1, cache_lvl =3D -1, cache =3D -1, core =3D -1, cpu =3D {cpu=
 =3D 0}}
>         avg =3D <optimized out>
>         metric_only =3D false
> ...
>
> whereas on
>
> $ git describe
> v6.18-rc1-115-gd702c0f4af6e0
>
> $ perf stat -C11 sleep 1
>
>  Performance counter stats for 'CPU(s) 11':
>
>                  8      context-switches                 #      8.0 cs/se=
c  cs_per_second
>           1,001.48 msec cpu-clock                        #      1.0 CPUs =
 CPUs_utilized
>                  0      cpu-migrations                   #      0.0 migra=
tions/sec  migrations_per_second
>                  3      page-faults                      #      3.0 fault=
s/sec  page_faults_per_second
>            277,825      branch-misses                    #      0.3 %  br=
anch_miss_rate         (33.11%)
>        102,546,153      branches                         #    102.4 M/sec=
  branch_frequency     (33.51%)
>      2,501,242,351      cpu-cycles                       #      2.5 GHz  =
cycles_frequency       (33.55%)
>        317,348,809      instructions                     #      0.1 instr=
uctions  insn_per_cycle  (33.55%)
>
>        1.001449562 seconds time elapsed
>
> it works without a problem.

Thanks for the bug report! There were changes in v6.19 to change how
metrics were computed hence the fault in the metric computation. The
bisected patch is at fault, it aims to compute the CPU maps for tool
events in a way to avoid unnecessary sched setaffinity calls. By
having a smaller CPU map it set up a situation with user CPUs where
the tool events could have no CPUs, removed from the list of events
and the later seg fault occurred. I sent out a new patch series:
https://lore.kernel.org/linux-perf-users/20260203225129.4077140-1-irogers@g=
oogle.com/
that has a revert of this patch, a fix to correctly avoid the segfault
in the prepare_metric function, and a new patch to properly reduce the
CPU maps of the tool events. The remaining affinity reduction patches
are still part of the series and I believe ready to land.

Thanks,
Ian

> Greetings,
>
> Andres Freund
