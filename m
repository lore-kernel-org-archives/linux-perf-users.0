Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A32333438;
	Tue,  3 Feb 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140253; cv=none; b=a/CrjAlzXo9bIHe06T/xYj29jrOtc2YUxwC6w5tmRhpYntqcLZZi1gi6FdY/exxU9SYpnl+5H9wY97APjb3MGoGWb3AoyfJebOiXMkmX4cVgjtAvWOMxeu6eYUZvn+4yg76i+QYPS5HcoUhWbPSqqirt7PPulrYYI6vmrJN7jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140253; c=relaxed/simple;
	bh=3RQPvqWn/UNLC65+JM3Y6F1cyPkbxuuxXPUnJrZWnyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Meym9DZtvLYOUcF2atqJgZiHMbEoggyCCfoZBKRMufRVcWchAo0T3YJplyVAtSOnV9GRv6efmTWvydsMVD5rs1Q3op2udsT7U6yRErsyLu+8olaLtpqH06fp4UUCuo7XjjcBsTsxEUA75teeZPWCQ3Ufzr/Dr15D/C48jcRXi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=CaN8LVIC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eyfgy4G1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="CaN8LVIC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eyfgy4G1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 112B41400086;
	Tue,  3 Feb 2026 12:37:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 12:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770140250; x=1770226650; bh=b5iwaC+1De
	7jkmuIHPK7iGjU7/QLH9B+i8rdP8lExaU=; b=CaN8LVIC7i7sqObIkXFRmeL5wP
	JWaXqhyQav+A2Rayvngml/BsVEC4ZUJIacIJZZy+49JelBSqz+bqdNSyxaLPfu5k
	Cp5aBzVv6z/6weJnJjhd2xf+BxDOu2bU2iQhwJ7LCiZ6i+6L6wgirruyAMXOfaIB
	LwsFRNn8XY1l2Hz4fhtGJv7oMjHKTePugtzEohNYnx2Vb5syndirjsyF2u8VzosG
	Rgkl0QplHftFPYsfcFWpIGKqfV28vsICRw2pXniV/wXJjhUUqvs5rM2oY+3WHw3x
	9w0rYTnE14FmjS01pORDofN1CE0xQXoJtFLOBk+f+Sp1T1cEZ+KjKy6L37Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770140250; x=1770226650; bh=b5iwaC+1De7jkmuIHPK7iGjU7/QLH9B+i8r
	dP8lExaU=; b=Eyfgy4G1E0t8Ca/C7bRKaPq/bg69vNduGwChJ0dQMKkefRn6bPO
	cDuYHsQJ+3FsSKSNvdMgeRq4Br5+vlZO/oj7Ly0tWVn3vZOnevBlm/56tUc9Ecpr
	WaAV9FK50sCi9rdcf9zQ6u2aU8X5S67FHojnZlPDJOdVHWiUh/EiOSUzj8xJ25OS
	Mopq/mkMI11ijmS4+WyEt0GLTrqBdxU0UHTJVG02VlZoyhaL4E7OZCko3L+F8A3d
	Ub5Sp1B+Dxd9FyGy74Jy8yN7AGNIGzUAMGUzfPHfadFfKbm3qqjQs28QBCW+6l1F
	VnizlkoSuXNK3844UgBF/g8EHfOCJ+tenNQ==
X-ME-Sender: <xms:WTKCaXRSHWNvpK_NGini-VQt_b7GVKlhX4D0JNX0yoSsrrtCXQeJEg>
    <xme:WTKCaRjvqMM_CUWunQFA6CkhG84Y44PgG7F_Y5MgUkMZTr4XNqQJ781DEUWfQMLaI
    uZqZArMMpYzX_qpKX5sY1HJleEOtjBYli7bzEIuU7GNJJUYxylIsQ>
X-ME-Received: <xmr:WTKCabh8fJpTKKUmhIvni0ve9aJhJeOxpKFncLgycEy0ZRJYAhNldGv5EZry-2oUyvmErQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepfeffgfelvdffgedtveelgfdtgefghfdvkefggeetieevjeekteduleevjefh
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnughrvghssegrnhgrrhgriigvlhdruggvpdhnsggprhgtphhtthhopedujedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepihhrohhgvghrshesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    rggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehthhhomh
    grshdrfhgrlhgtohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprggtmhgvsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnrghmhhihuhhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgv
    shdrtghlrghrkheslhhinhgrrhhordhorhhgpdhrtghpthhtohephigrnhhgrdhlvggvse
    hlihhnuhigrdgrlhhisggrsggrrdgtohhm
X-ME-Proxy: <xmx:WTKCaZYByYqOirhheTqBMYzANBYuMFMcmQlNqkMCeIxVB9swL2Bp2g>
    <xmx:WTKCaUUwAdXn_YY9nBve2yMaYoWSnzVdA5CM35auj5zI2S3IH6eCtA>
    <xmx:WTKCaQhCchyw69PHWLYH3Ykh275huLv-AslsO0R9hGaq8fuDr1Doeg>
    <xmx:WTKCaflW_6jHonapVNMPl9CZu7QDg_R1h56xJBmW8KLinfvs_mUV9A>
    <xmx:WjKCaZkfbpZhZ7wDfZoY0ZLqdBSzj7bVrHmiRcV8YdpO_UsHIwJGuXvR>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 12:37:28 -0500 (EST)
Date: Tue, 3 Feb 2026 12:37:28 -0500
From: Andres Freund <andres@anarazel.de>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 07/10] perf tool_pmu: More accurately set the cpus for
 tool events
Message-ID: <cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6>
References: <20251113180517.44096-1-irogers@google.com>
 <20251113180517.44096-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113180517.44096-8-irogers@google.com>

Hi,

On 2025-11-13 10:05:13 -0800, Ian Rogers wrote:
> The user and system time events can record on different CPUs, but for
> all other events a single CPU map of just CPU 0 makes sense. In
> parse-events detect a tool PMU and then pass the perf_event_attr so
> that the tool_pmu can return CPUs specific for the event. This avoids
> a CPU map of all online CPUs being used for events like
> duration_time. Avoiding this avoids the evlist CPUs containing CPUs
> for which duration_time just gives 0. Minimizing the evlist CPUs can
> remove unnecessary sched_setaffinity syscalls that delay metric
> calculations.

I was just testing v6.19-rc* and noticed that
  perf stat -C $somecpu sleep 1
segfaults.

I bisected that down to this change (d8d8a0b3603a9a8fa207cf9e4f292e81dc5d1008).

$ git describe
v6.18-rc1-116-gd8d8a0b3603a9

$ gdb --args perf stat -C11 sleep 1
(gdb) r
Starting program: /home/andres/bin/bin/perf stat -C11 sleep 1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/x86_64-linux-gnu/libthread_db.so.1".
[Detaching after fork from child process 843870]

 Performance counter stats for 'CPU(s) 11':

                16      context-switches                 #     16.0 cs/sec  cs_per_second
          1,001.66 msec cpu-clock
Program received signal SIGSEGV, Segmentation fault.
prepare_metric (config=config@entry=0x55555603bd80 <stat_config>, mexp=mexp@entry=0x5555560a40f0, evsel=evsel@entry=0x555556093e20,
    pctx=pctx@entry=0x5555560a7150, aggr_idx=aggr_idx@entry=0) at util/stat-shadow.c:85
85			aggr = &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
(gdb) bt
#0  prepare_metric (config=config@entry=0x55555603bd80 <stat_config>, mexp=mexp@entry=0x5555560a40f0, evsel=evsel@entry=0x555556093e20,
    pctx=pctx@entry=0x5555560a7150, aggr_idx=aggr_idx@entry=0) at util/stat-shadow.c:85
#1  0x00005555557be0eb in generic_metric (config=<optimized out>, mexp=0x5555560a40f0, evsel=<optimized out>, aggr_idx=<optimized out>, out=0x7fffffff76c0)
    at util/stat-shadow.c:146
#2  perf_stat__print_shadow_stats_metricgroup (config=config@entry=0x55555603bd80 <stat_config>, evsel=<optimized out>, aggr_idx=0,
    num=num@entry=0x7fffffff7604, from=from@entry=0x0, out=0x7fffffff76c0) at util/stat-shadow.c:307
#3  0x00005555557be4c7 in perf_stat__print_shadow_stats (config=config@entry=0x55555603bd80 <stat_config>, evsel=evsel@entry=0x555556093e20,
    aggr_idx=aggr_idx@entry=0, out=out@entry=0x7fffffff76c0) at util/stat-shadow.c:325
#4  0x00005555557c03a3 in printout (config=<optimized out>, os=0x7fffffff78b0, uval=<optimized out>, run=1001660763, ena=<optimized out>,
    noise=<optimized out>, aggr_idx=0) at util/stat-display.c:874
#5  0x00005555557c1424 in print_counter_aggrdata (config=0x55555603bd80 <stat_config>, counter=0x555556093e20, aggr_idx=0, os=<optimized out>)
    at util/stat-display.c:1013
#6  0x00005555557c3051 in print_counter (config=<optimized out>, counter=<optimized out>, os=<optimized out>) at util/stat-display.c:1127
#7  print_counter (config=<optimized out>, counter=<optimized out>, os=<optimized out>) at util/stat-display.c:1117
#8  evlist__print_counters (evlist=<optimized out>, config=config@entry=0x55555603bd80 <stat_config>, _target=_target@entry=0x5555560412e0 <target>,
    ts=ts@entry=0x0, argc=argc@entry=2, argv=argv@entry=0x7fffffffdb20) at util/stat-display.c:1600
#9  0x00005555555d0d27 in print_counters (ts=0x0, argc=2, argv=0x7fffffffdb20) at builtin-stat.c:1070
#10 print_counters (ts=0x0, argc=2, argv=0x7fffffffdb20) at builtin-stat.c:1062
#11 cmd_stat (argc=2, argv=0x7fffffffdb20) at builtin-stat.c:2949
#12 0x000055555562fee2 in run_builtin (p=p@entry=0x55555602df48 <commands+360>, argc=argc@entry=4, argv=argv@entry=0x7fffffffdb20) at perf.c:349
#13 0x00005555556301ce in handle_internal_command (argc=argc@entry=4, argv=argv@entry=0x7fffffffdb20) at perf.c:401
#14 0x00005555555a8d33 in run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:445
#15 main (argc=<optimized out>, argv=0x7fffffffdb20) at perf.c:553


(gdb) bt full
#0  prepare_metric (config=config@entry=0x55555603bd80 <stat_config>, mexp=mexp@entry=0x5555560a40f0, evsel=evsel@entry=0x555556093e20, pctx=pctx@entry=0x5555560a7150, aggr_idx=aggr_idx@entry=0) at util/stat-shadow.c:85
        val = <optimized out>
        source_count = 0
        tool_aggr_idx = 0
        is_tool_time = true
        ps = 0x0
        aggr = <optimized out>
        n = <optimized out>
        metric_events = <optimized out>
        metric_refs = 0x0
        i = 1
#1  0x00005555557be0eb in generic_metric (config=<optimized out>, mexp=0x5555560a40f0, evsel=<optimized out>, aggr_idx=<optimized out>, out=0x7fffffff76c0) at util/stat-shadow.c:146
        print_metric = 0x5555557c1b70 <print_metric_std>
        metric_name = 0x5555560ae550 "CPUs_utilized"
        metric_expr = 0x555555ea5bb5 "(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)"
        metric_threshold = 0x0
        metric_unit = 0x555555ea5c4d "1CPUs"
        metric_events = 0x5555560ae490
        runtime = 0
        pctx = 0x5555560a7150
        ratio = 15.973479072960373
        scale = 1
        threshold = 4.9406564584124654e-324
        i = <optimized out>
        ctxp = 0x7fffffff78b0
        thresh = METRIC_THRESHOLD_UNKNOWN
#2  perf_stat__print_shadow_stats_metricgroup (config=config@entry=0x55555603bd80 <stat_config>, evsel=<optimized out>, aggr_idx=0, num=num@entry=0x7fffffff7604, from=from@entry=0x0, out=0x7fffffff76c0) at util/stat-shadow.c:307
        me = 0x5555560877d0
        mexp = 0x5555560a40f0
        ctxp = 0x7fffffff78b0
        header_printed = false
        name = 0x555555879b28 ""
        metric_events = <optimized out>
#3  0x00005555557be4c7 in perf_stat__print_shadow_stats (config=config@entry=0x55555603bd80 <stat_config>, evsel=evsel@entry=0x555556093e20, aggr_idx=aggr_idx@entry=0, out=out@entry=0x7fffffff76c0) at util/stat-shadow.c:325
        print_metric = 0x5555557c1b70 <print_metric_std>
        ctxp = 0x7fffffff78b0
        num = 1
#4  0x00005555557c03a3 in printout (config=<optimized out>, os=0x7fffffff78b0, uval=<optimized out>, run=1001660763, ena=<optimized out>, noise=<optimized out>, aggr_idx=0) at util/stat-display.c:874
        out = {ctx = 0x7fffffff78b0, print_metric = 0x5555557c1b70 <print_metric_std>, new_line = 0x5555557be5a0 <new_line_std>, print_metricgroup_header = 0x5555557bea60 <print_metricgroup_header_std>, force_header = false}
        pm = <optimized out>
        nl = <optimized out>
        pmh = <optimized out>
        ok = <optimized out>
        counter = 0x555556093e20
#5  0x00005555557c1424 in print_counter_aggrdata (config=0x55555603bd80 <stat_config>, counter=0x555556093e20, aggr_idx=0, os=<optimized out>) at util/stat-display.c:1013
        output = 0x7ffff69f24e0 <_IO_2_1_stderr_>
        ena = 1001660763
        run = <optimized out>
        val = <optimized out>
        uval = <optimized out>
        ps = <optimized out>
        aggr = <optimized out>
        id = {thread_idx = -1, node = -1, socket = -1, die = -1, cluster = -1, cache_lvl = -1, cache = -1, core = -1, cpu = {cpu = 0}}
        avg = <optimized out>
        metric_only = false
...

whereas on

$ git describe
v6.18-rc1-115-gd702c0f4af6e0

$ perf stat -C11 sleep 1

 Performance counter stats for 'CPU(s) 11':

                 8      context-switches                 #      8.0 cs/sec  cs_per_second
          1,001.48 msec cpu-clock                        #      1.0 CPUs  CPUs_utilized
                 0      cpu-migrations                   #      0.0 migrations/sec  migrations_per_second
                 3      page-faults                      #      3.0 faults/sec  page_faults_per_second
           277,825      branch-misses                    #      0.3 %  branch_miss_rate         (33.11%)
       102,546,153      branches                         #    102.4 M/sec  branch_frequency     (33.51%)
     2,501,242,351      cpu-cycles                       #      2.5 GHz  cycles_frequency       (33.55%)
       317,348,809      instructions                     #      0.1 instructions  insn_per_cycle  (33.55%)

       1.001449562 seconds time elapsed

it works without a problem.

Greetings,

Andres Freund
