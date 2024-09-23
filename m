Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482A15E86;
	Mon, 23 Sep 2024 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727132925; cv=none; b=VPUqkjEo1vz+N9GgfWxkVPmBai4rHyhFZ2qaIuQNIVwrDB2dAqGC8MbsxNzpjLaEVszpMsg4xVeRG+PuVParQhzmh/rCkiR1cAhNh0+rHm6g0b2NQ/puX7Pw33V9eL37u88P55MTRoZ4D3+dyg7yBcjFlKgRp3UD4AOaJq0Obv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727132925; c=relaxed/simple;
	bh=OWpMCRGmAqZvzyaBut++OyHffTtRikgWjkKKa9z9WqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKJDI3sLkjz97spUKgxFt3IIxFEeDYQMoMUyCYIq2fO7pIh2PM0lBcbTTrqi/p2ZZolJuq+ShKK3Hksg3Cajlcp1GuFG9qKaQ6UpLqZroZFEAGUH1cQw3oUvyClMRYa2DSRy1LeD8zbtkZIZ0jd6iFm/cUxzTgENqBwqOWl0Do8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8rHmNRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8rHmNRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D83C4CEC4;
	Mon, 23 Sep 2024 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727132925;
	bh=OWpMCRGmAqZvzyaBut++OyHffTtRikgWjkKKa9z9WqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8rHmNRdY0JedAeTG2+9Mz9SdlTI9C+WYtyKAtbScHctsM/oVRt+/ebazyPX+y4xo
	 qylTWCE19uEcQ43eQ4Iq9iXBGQFSwoxchyWP11ESieyyK5i0Q8V8pdD3rRyfxVOx3E
	 KMq0P2PFpZqvfRzja9i71nnCII687E01PSVZ/xl5C0vi50D9ZOB+CUrDPqBL7EwUBF
	 2mWcErk3h7Ix9CXJ+bcR4LUmEyDycsE/xz9kQseSCrhOtezM6hIb1849NvbErkf/JZ
	 iXX2EpbCxqy43q2XCfI8clWh8LoSHQWCOpZiYQiun/nBSgFcyKpHeujgaNmL4o51b9
	 luSOXrL1MRKwg==
Date: Mon, 23 Sep 2024 16:08:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	linux-toolchains@vger.kernel.org
Subject: Re: [RFC/PATCHSET 0/5] perf tools: Support deferred user callchains
 (v2)
Message-ID: <ZvH0-ny9gUzh_Jc7@google.com>
References: <20240917222820.197594-1-namhyung@kernel.org>
 <f554bf58-a1df-4ef8-9045-2d1396f30ef3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f554bf58-a1df-4ef8-9045-2d1396f30ef3@linux.intel.com>

Hi Kan,

On Wed, Sep 18, 2024 at 04:26:56PM -0400, Liang, Kan wrote:
> 
> 
> On 2024-09-17 6:28 p.m., Namhyung Kim wrote:
> > Hello,
> > 
> > This is a counterpart for Josh's kernel change v2 [1] to support deferred
> > user callchains.  The change is transparent and users should not notice
> > anything with the deferred callchains.
> > 
> >   $ perf record -g sleep 1
> > 
> > I added --[no-]merge-callchains option to control output of perf script.
> > You can verify it has the deferred callchains like this:
> > 
> >   $ perf script --no-merge-callchains
> >   perf     801 [000]    18.031793:          1 cycles:P:
> >           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
> >           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
> >           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
> >           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
> >           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
> >           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
> >           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
> >           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
> >           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
> >           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
> >           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
> >           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
> >           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
> > 
> >   perf     801 [000]    18.031814: DEFERRED CALLCHAIN
> >                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)
> > 
> >   ...
> > 
> > When the callchain is merged (it's the default) it'd look like below:
> > 
> >   $ perf script
> >   perf     801 [000]    18.031793:          1 cycles:P:
> >           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
> >           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
> >           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
> >           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
> >           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
> >           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
> >           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
> >           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
> >           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
> >           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
> >           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
> >           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
> >           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
> >                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)
> > 
> >   ...
> > 
> > Notice that the last line and it has the __GI___ioctl in the same
> > callchain.  It should work with other tools like perf report.
> 
> 
> It seems it only works with perf report -D, when I test it on a
> non-hybrid machine.
> $perf record -e branches -g -c 3000000 ~/tchain_edit
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.397 MB perf.data ]
> $ perf report -D | tail -n 17
> 
> Aggregated stats:
>                TOTAL events:       8235
>                 MMAP events:         78  ( 0.9%)
>                 COMM events:          2  ( 0.0%)
>                 EXIT events:          1  ( 0.0%)
>               SAMPLE events:       4060  (49.3%)
>                MMAP2 events:          2  ( 0.0%)
>              KSYMBOL events:         12  ( 0.1%)
>            BPF_EVENT events:         12  ( 0.1%)
>   CALLCHAIN_DEFERRED events:       4060  (49.3%)
>       FINISHED_ROUND events:          3  ( 0.0%)
>             ID_INDEX events:          1  ( 0.0%)
>           THREAD_MAP events:          1  ( 0.0%)
>              CPU_MAP events:          1  ( 0.0%)
>            TIME_CONV events:          1  ( 0.0%)
>        FINISHED_INIT events:          1  ( 0.0%)
> $ perf report
> Error:
> The perf.data data has no samples!
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> 
> 
> On a hybrid machine, perf record errors out.
> 
> $perf record -g true
> [ perf record: Woken up 1 times to write data ]
> 0x58a8 [0x38]: failed to process type: 22 [Bad address]
> [ perf record: Captured and wrote 0.022 MB perf.data ]

Thanks for the test, I'll take a look what I missed.

Thanks,
Namhyung
