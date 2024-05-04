Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EBA77F08;
	Sat,  4 May 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714847222; cv=none; b=Nhj3hNO0nkU0NLfHtwEbtl2YL7wYk6QA4dORd0q/L0IsNpM56Z7930xD+vt5S0W+TfPMSAp9GNLa36pU10FwCdUfFofvLBMooXm0C4KGkYIfuaSS0L7mSTzJZuSZlXxkc0vNA2HZWh2BwNNsyDXkxYvBDISMDp/X7fm7eXh7Ydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714847222; c=relaxed/simple;
	bh=T8RL3GJ2WYtqHOh0klj9cA7pEI84E1fR8OclwOfdXAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8YSy5xktHBSiTW6PA25zPkWQt6wjdEwl8gvbtC1GT+F/dvH1Psv3gf9sL99l+GBgTVyfbu2k8YbKrwikAWgtxKl7b2T+4wzbUoPjg0rzoVO60Aui9mqqJHNraflLineXzil3G7Pa0aJvgyxpHLD4iF1l1ZxwURHUcLuOkrIOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNlCvUbr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNlCvUbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF97C072AA;
	Sat,  4 May 2024 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714847222;
	bh=T8RL3GJ2WYtqHOh0klj9cA7pEI84E1fR8OclwOfdXAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNlCvUbrXvpZHxaA4dRj5dKMw3aulDKkFCI3qfiKbUZc21tH9gKQSivWi1Pb6O/Zb
	 slz6pe8aXO5u4BVB+Gws6jsgCWiTn0ls1EPGTn5yzBiC+lOfwXlaH6a+jaWYCX6eDg
	 681eQZVh4AajR/Ly6IGAW9feldHVpVdpcexgHnsVKWK4OfLXE+hyqOLQCwSPedVT2z
	 SrcqB2x0oj8rraScmtK/VkCR4oWmirR/6rvvQo3tkpCp1Ltfqr8xUf9VAbJc5+e+d6
	 qFsYO7d5F/7jAupWZkIR08ayKubZYYsy7OEEJTevZexojOS9T5/o69jYcuFGPt37h1
	 h+9HSNBU6DX/w==
Date: Sat, 4 May 2024 15:26:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/6] perf annotate-data: Check memory access with two
 registers
Message-ID: <ZjZ98gLSmr0qXih2@x1>
References: <20240502060011.1838090-1-namhyung@kernel.org>
 <20240502060011.1838090-5-namhyung@kernel.org>
 <ZjOdkHraWXZIuSy_@x1>
 <CAM9d7cg_YL1x8YfJ5+7+o+0dccFJJxUye8L_FLrgdGeAh81LBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cg_YL1x8YfJ5+7+o+0dccFJJxUye8L_FLrgdGeAh81LBA@mail.gmail.com>

On Thu, May 02, 2024 at 11:14:50AM -0700, Namhyung Kim wrote:
> On Thu, May 2, 2024 at 7:05 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Wed, May 01, 2024 at 11:00:09PM -0700, Namhyung Kim wrote:
> > > The following instruction pattern is used to access a global variable.
> > >
> > >   mov     $0x231c0, %rax
> > >   movsql  %edi, %rcx
> > >   mov     -0x7dc94ae0(,%rcx,8), %rcx
> > >   cmpl    $0x0, 0xa60(%rcx,%rax,1)     <<<--- here
> > >
> > > The first instruction set the address of the per-cpu variable (here, it
> > > is 'runqueus' of struct rq).  The second instruction seems like a cpu
> >
> > You mean 'runqueues', i.e. this one:
> >
> > kernel/sched/core.c
> > DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> >
> > ?
> 
> Right, sorry for the typo.
> 
> >
> > But that 0xa60 would be in an alignment hole, at least in:
> >
> > $ pahole --hex rq | egrep 0xa40 -A12
> >         struct mm_struct *         prev_mm;              /* 0xa40   0x8 */
> >         unsigned int               clock_update_flags;   /* 0xa48   0x4 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         u64                        clock;                /* 0xa50   0x8 */
> >
> >         /* XXX 40 bytes hole, try to pack */
> >
> >         /* --- cacheline 42 boundary (2688 bytes) --- */
> >         u64                        clock_task __attribute__((__aligned__(64))); /* 0xa80   0x8 */
> >         u64                        clock_pelt;           /* 0xa88   0x8 */
> >         long unsigned int          lost_idle_time;       /* 0xa90   0x8 */
> > $ uname -a
> > Linux toolbox 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27 16:50:39 UTC 2024 x86_64 GNU/Linux
> > $
> 
> This would be different on kernel version, config and
> other changes like backports or local modifications.
> 
> On my system, it was cpu_stop_work.arg.

Sure, so please include the pahole output for the data that lead you to
the conclusions in the explanation for the results obtained, so that we
can have a better mental map of all the pieces and thus get convinced of
the results and have a way to try to reproduce it in our systems.

In the future we will be grateful to this effort when looking back at
these patches :-)

Thanks for all your work in these features!

- Arnaldo
 
> $ pahole --hex rq | grep 0xa40 -C1
>     /* --- cacheline 41 boundary (2624 bytes) --- */
>     struct cpu_stop_work       active_balance_work;  /* 0xa40  0x30 */
>     int                        cpu;                  /* 0xa70   0x4 */
> 
> $ pahole --hex cpu_stop_work
> struct cpu_stop_work {
>     struct list_head           list;                 /*     0  0x10 */
>     cpu_stop_fn_t              fn;                   /*  0x10   0x8 */
>     long unsigned int          caller;               /*  0x18   0x8 */
>     void *                     arg;                  /*  0x20   0x8 */
>     struct cpu_stop_done *     done;                 /*  0x28   0x8 */
> 
>     /* size: 48, cachelines: 1, members: 5 */
>     /* last cacheline: 48 bytes */
> };
> 
> 
> >
> > The paragraph then reads:
> >
> > ----
> > The first instruction set the address of the per-cpu variable (here, it
> > is 'runqueues' of type 'struct rq').  The second instruction seems like
> > a cpu number of the per-cpu base.  The third instruction get the base
> > offset of per-cpu area for that cpu.  The last instruction compares the
> > value of the per-cpu variable at the offset of 0xa60.
> > ----
> >
> > Ok?
> 
> Yep, looks good.
> 
> Thanks,
> Namhyung
