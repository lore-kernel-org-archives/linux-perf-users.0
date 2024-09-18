Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C31304BA;
	Wed, 18 Sep 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652323; cv=none; b=shtke4WiPi8MOqYzfWItwOq1KjpvxRGz0oifm7C/MU4FFleV6uR4NGBh3jQeU/Qmceou6DutPTXpSq1UhT0XsJFu5A56cEhSlzSN7SsYNzL66Xz+Xim0AVhJvSxh9ltTGa2sixNAl81IHbZgLsmWk/o9llfm53PeEISynu0AZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652323; c=relaxed/simple;
	bh=C3/KtoOjXS3syinX0b/v/9//WNzoLzmE4OE8VTLsAu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaNJuGeKAHRkaMns3lkBx/6CobGcXDp1sxz8JG9/QF0Ra/TFWJijZ+3mFMtNG4GcDRT/ybEsijl/la64iDzTbMKGaaJAqZnVmYGXSVUub2ddjOi6XuEJE5LIU99yc7wrWDEbwjKe/pnOIHCJXUorWuzuqAHb1MwKovnmVqh0MaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWheZ4Hu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWheZ4Hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3797DC4CEC3;
	Wed, 18 Sep 2024 09:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726652322;
	bh=C3/KtoOjXS3syinX0b/v/9//WNzoLzmE4OE8VTLsAu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWheZ4Hue3Uq+r+vaofGUkHffufuRf00EpqkatanUMUYIOxcDDwdP2z0kFFCM3xZH
	 Z40oNJGXdG5gir/iWdtiSFANT4dZRZ8qOJ40YgMGNHSAHB1BnHfgbHh1JtK8ghn3YA
	 6YcNmLTMPYkwU3aHvazPJbB5zASOM7+1NEN+TNc4ruMIWGv70qHhLuzQ6If8ahL+IP
	 Re6gHHUlLI8/7bhfvISUu4tTFr4FeHbY7zCBsLhL+MJEWiblABEnnQ00fBMFMcnOzF
	 o4OHIbVpJuZTj0rEDykMb3mysqUbh4UzzcIapaq67OGGp1Atqc+e0N3+TIgMEX7iqN
	 1BIVal3oe2cZw==
Date: Wed, 18 Sep 2024 02:38:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <ZuqfmXairuIo_Px4@google.com>
References: <20240917222820.197594-1-namhyung@kernel.org>
 <CAP-5=fVV9wzp7L71VJxaqzuURFtr1LAg0Qmk5uqmzs3By1Exow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVV9wzp7L71VJxaqzuURFtr1LAg0Qmk5uqmzs3By1Exow@mail.gmail.com>

Hi Ian,

On Wed, Sep 18, 2024 at 08:38:22AM +0200, Ian Rogers wrote:
> On Wed, Sep 18, 2024 at 12:28 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
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
> Hi Namhyung, I think this is interesting work!
> 
> The issue feels similar to leader sampling and some of the unpicking
> of that we've been dealing with. With leader sampling it was added and
> then the dispatch of events modified so that tools wouldn't see leader
> samples, instead new events would be synthesized based on the leader
> sample data. However, the leader sample event wasn't changed and so
> now we have multiple repeated events and perf inject wouldn't just
> pass through a perf data file.
> 
> What I'm expecting based on this description is that a deferred call
> chain will be merged with a regular one, however, perf inject isn't
> updated to drop the deferred callchain so now we have the deferred
> callchain event twice.
> 
> My feeling is that making the dispatch of events to tools "smart" is a
> false economy. Tools can add handlers for these events easily enough.
> What's harder is undoing the smartness when it does things that lead
> to duplicated events and the like. I'm not a fan of how leader
> sampling was implemented and I still think it odd that with perf
> script we see invented events when trying to just dump the contents of
> a perf.data file.

That's why I added perf_tool.merge_deferred_callchains flag to control
the behavior.  I haven't implemented it to perf inject because it covers
a couple of different use cases.  I believe the default behavior is to
not invoke the callback for deferred callchains during perf inject and
each sample will get the full callchains.  But you can add a new
callback and set perf_tool.merge_deferred_callchains to false.

Thanks,
Namhyung
