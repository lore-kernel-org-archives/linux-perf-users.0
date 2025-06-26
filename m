Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825D2ED14D;
	Thu, 26 Jun 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750960112; cv=none; b=D9VScjTGL/L5uQPVQk/yh2SckrKt6BvPDLES43tILZghbLplcCeTjPWZsxa0G2setigk9PQfConCLB6ad4Qqkn5MURCT6v1z7bboYuQez89Wy33n52FvQu2TXjZpRl3e7oE1iEyue/q6gmpIpR55vvfK+Q/2nZYsAxq/ky+z3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750960112; c=relaxed/simple;
	bh=YZ5cD0XYLp6jAG9cUymbGe/Ueae78yYfbyTuSWozd6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl+F4+8ff9xUs/VTAtvttbkWMn63cQca1xCIxNdfGjIzX++QEFH2FKyDv5UXgqZkTP7ErR3N/6eydc+zOJisJP2LvcFQ+KVB3JZiWET6ulxqFAByZ7Z3a27k5/e4sGcwKQeI0BMnQi8WkVLJ7fMkEYQ6iHBB4kE3afLMBovJWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnuwWcL1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnuwWcL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95362C4CEF2;
	Thu, 26 Jun 2025 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750960112;
	bh=YZ5cD0XYLp6jAG9cUymbGe/Ueae78yYfbyTuSWozd6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnuwWcL11oU8M+h60jeJAVlw+k43t9Ao13H99Oq82z2SHURPM1N6avtUgQlJ/V0Oi
	 UboqX5+GJG/I6NmLiAj5PsLUpzsJpM5aq0CUya8vvS4m3cfn1MlzrxBwpjOr6npEUu
	 bVEq+cNPIV5EjPHm4hwpaPOqfZtBccfBuU8Ecn+Q5syifZG8IIvjWGibjho+gpm5qO
	 5OjqQTffaJGMYypYAqBKN6NgLn6IrgQGLg5P9WEnVRCY/iL/ogoEaOD3bPRtzImSuA
	 m/9Bebj5SnauamRTS857J8dePvHgikENZiJ2TEporsBwLlxhCaVnizxtPfsuSJpj7d
	 nxYRJcT5rIcrQ==
Date: Thu, 26 Jun 2025 10:48:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"acme@kernel.org" <acme@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"irogers@google.com" <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] perf top: populate PMU capabilities data in
 perf_env
Message-ID: <aF2H7vICRvqqx8kQ@google.com>
References: <20250612163659.1357950-1-thomas.falcon@intel.com>
 <20250612163659.1357950-2-thomas.falcon@intel.com>
 <6680ed82adc3a2528c7587138d90dcca0d3558f3.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6680ed82adc3a2528c7587138d90dcca0d3558f3.camel@intel.com>

Hello,

On Thu, Jun 26, 2025 at 04:47:18PM +0000, Falcon, Thomas wrote:
> Hi, is there anything still needed from me before this can be accepted?
 
Sorry I just missed it.  I'll add it to the tmp branch for testing.

Thanks,
Namhyung

> 
> On Thu, 2025-06-12 at 11:36 -0500, Thomas Falcon wrote:
> > Calling perf top with branch filters enabled on Intel CPU's
> > with branch counters logging (A.K.A LBR event logging [1]) support
> > results in a segfault.
> > 
> > $ perf top  -e '{cpu_core/cpu-cycles/,cpu_core/event=0xc6,umask=0x3,frontend=0x11,name=frontend_retired_dsb_miss/}' -j any,counter
> > ...
> > Thread 27 "perf" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7fffafff76c0 (LWP 949003)]
> > perf_env__find_br_cntr_info (env=0xf66dc0 <perf_env>, nr=0x0, width=0x7fffafff62c0) at util/env.c:653
> > 653			*width = env->cpu_pmu_caps ? env->br_cntr_width :
> > (gdb) bt
> >  #0  perf_env__find_br_cntr_info (env=0xf66dc0 <perf_env>, nr=0x0, width=0x7fffafff62c0) at util/env.c:653
> >  #1  0x00000000005b1599 in symbol__account_br_cntr (branch=0x7fffcc3db580, evsel=0xfea2d0, offset=12, br_cntr=8) at util/annotate.c:345
> >  #2  0x00000000005b17fb in symbol__account_cycles (addr=5658172, start=5658160, sym=0x7fffcc0ee420, cycles=539, evsel=0xfea2d0, br_cntr=8) at util/annotate.c:389
> >  #3  0x00000000005b1976 in addr_map_symbol__account_cycles (ams=0x7fffcd7b01d0, start=0x7fffcd7b02b0, cycles=539, evsel=0xfea2d0, br_cntr=8) at util/annotate.c:422
> >  #4  0x000000000068d57f in hist__account_cycles (bs=0x110d288, al=0x7fffafff6540, sample=0x7fffafff6760, nonany_branch_mode=false, total_cycles=0x0, evsel=0xfea2d0) at util/hist.c:2850
> >  #5  0x0000000000446216 in hist_iter__top_callback (iter=0x7fffafff6590, al=0x7fffafff6540, single=true, arg=0x7fffffff9e00) at builtin-top.c:737
> >  #6  0x0000000000689787 in hist_entry_iter__add (iter=0x7fffafff6590, al=0x7fffafff6540, max_stack_depth=127, arg=0x7fffffff9e00) at util/hist.c:1359
> >  #7  0x0000000000446710 in perf_event__process_sample (tool=0x7fffffff9e00, event=0x110d250, evsel=0xfea2d0, sample=0x7fffafff6760, machine=0x108c968) at builtin-top.c:845
> >  #8  0x0000000000447735 in deliver_event (qe=0x7fffffffa120, qevent=0x10fc200) at builtin-top.c:1211
> >  #9  0x000000000064ccae in do_flush (oe=0x7fffffffa120, show_progress=false) at util/ordered-events.c:245
> >  #10 0x000000000064d005 in __ordered_events__flush (oe=0x7fffffffa120, how=OE_FLUSH__TOP, timestamp=0) at util/ordered-events.c:324
> >  #11 0x000000000064d0ef in ordered_events__flush (oe=0x7fffffffa120, how=OE_FLUSH__TOP) at util/ordered-events.c:342
> >  #12 0x00000000004472a9 in process_thread (arg=0x7fffffff9e00) at builtin-top.c:1120
> >  #13 0x00007ffff6e7dba8 in start_thread (arg=<optimized out>) at pthread_create.c:448
> >  #14 0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
> > 
> > The cause is that perf_env__find_br_cntr_info tries to access a
> > null pointer pmu_caps in the perf_env struct. A similar issue exists
> > for homogeneous core systems which use the cpu_pmu_caps structure.
> > 
> > Fix this by populating cpu_pmu_caps and pmu_caps structures with
> > values from sysfs when calling perf top with branch stack sampling
> > enabled.
> > 
> > [1], LBR event logging introduced here:
> > https://lore.kernel.org/all/20231025201626.3000228-5-kan.liang@linux.intel.com/
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > ---
> > v4: prefer calloc and zfree operations in addition to other
> >     cleanups suggested by Namhyung and Arnaldo
> > 
> > v3: constify struct perf_pmu *pmu in __perf_env__read_core_pmu_caps()
> >     use perf_pmus__find_core_pmu() instead of perf_pmus__scan_core(NULL)
> > 
> > v2: update commit message with more meaningful stack trace from
> >     gdb and indicate that affected systems are limited to CPU's
> >     with LBR event logging support and that both hybrid and
> >     non-hybrid core systems are affected.
