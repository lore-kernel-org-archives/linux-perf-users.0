Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDE41C77;
	Mon, 23 Sep 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727132849; cv=none; b=fLyi7dI5KIzM5UXTaOksYZeF4eEbFdtRX8PEQGv7Q+I33E+evIzdsrVxW+0eCqyxMak3aE7KL1rPzoOsmtJ9ZPT5c0vsUnr2t94llwhlOFVXKzivxhJW6PLILINt1MgmFE7UuVl5WCYMQK2ZCFV9HNMeGzm0K5StSclwGa42DMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727132849; c=relaxed/simple;
	bh=nBarhH/viiSQU1Y++LAIm8P9tr2uxysK+I2FYZhS1Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doc3H/j3NnNYAGtI502Z4C/GGlb8dJcL+d0khtGo6h94vmBKhQb7evMEbT/XiMomCSBli+Vm7cgkEKUMxQV7MbybP+gVHtDXFEsRRVzv9aMlxBUfQfgWAnJExXD1kOxgb1p3rZulw3u7LjfPL3CHoMLTMwgqJkVloUnWXZPVTjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huRCui7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huRCui7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F201C4CEC4;
	Mon, 23 Sep 2024 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727132848;
	bh=nBarhH/viiSQU1Y++LAIm8P9tr2uxysK+I2FYZhS1Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huRCui7IGn2Xi19kHbwkDKWXC704zGFV/mQWzjr6LF3DlhMC96R2GNXU1q+ouCU6q
	 TOWLUOLIQ/sndw4NtPfK1QQRw+I9wvh16ljZz+jAvOHOf4A9aUgBSqJtYHL4yletny
	 BU/urJsYAmjA/buM04ZwkFQHDUbDvmEwyMav54AAGZul9VyPNDoE8PfZCzQGhrxH/z
	 juG7LbYiOUkp77q29HwCL0X1QMR6EZn0qVc6A9948p0abrQRlk0fSWIDZI0UXzUQv/
	 bRHiam17hIfFj87A8I4MKpE6p/snf3xd0CtlDhO+7nFoFMNHSkjIVAhxAWYfdtdbQy
	 PWZYX9r1LB+9g==
Date: Mon, 23 Sep 2024 16:07:26 -0700
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
Message-ID: <ZvH0rq-J3_ixe3wU@google.com>
References: <20240917222820.197594-1-namhyung@kernel.org>
 <CAP-5=fVV9wzp7L71VJxaqzuURFtr1LAg0Qmk5uqmzs3By1Exow@mail.gmail.com>
 <ZuqfmXairuIo_Px4@google.com>
 <CAP-5=fUT-60ff-hPS9Anizq9XxiqAOJXYyQqeVoHBYzMvd0L=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUT-60ff-hPS9Anizq9XxiqAOJXYyQqeVoHBYzMvd0L=g@mail.gmail.com>

Hi Ian,

On Wed, Sep 18, 2024 at 03:39:31PM +0200, Ian Rogers wrote:
> On Wed, Sep 18, 2024 at 11:38 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Sep 18, 2024 at 08:38:22AM +0200, Ian Rogers wrote:
> > > On Wed, Sep 18, 2024 at 12:28 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > This is a counterpart for Josh's kernel change v2 [1] to support deferred
> > > > user callchains.  The change is transparent and users should not notice
> > > > anything with the deferred callchains.
> > > >
> > > >   $ perf record -g sleep 1
> > > >
> > > > I added --[no-]merge-callchains option to control output of perf script.
> > > > You can verify it has the deferred callchains like this:
> > > >
> > > >   $ perf script --no-merge-callchains
> > > >   perf     801 [000]    18.031793:          1 cycles:P:
> > > >           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
> > > >           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
> > > >           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
> > > >           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
> > > >           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
> > > >           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
> > > >           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
> > > >           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
> > > >           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
> > > >           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
> > > >           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
> > > >           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
> > > >           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
> > > >
> > > >   perf     801 [000]    18.031814: DEFERRED CALLCHAIN
> > > >                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)
> > > >
> > > >   ...
> > > >
> > > > When the callchain is merged (it's the default) it'd look like below:
> > > >
> > > >   $ perf script
> > > >   perf     801 [000]    18.031793:          1 cycles:P:
> > > >           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
> > > >           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
> > > >           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
> > > >           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
> > > >           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
> > > >           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
> > > >           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
> > > >           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
> > > >           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
> > > >           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
> > > >           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
> > > >           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
> > > >           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
> > > >                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)
> > > >
> > > >   ...
> > > >
> > > > Notice that the last line and it has the __GI___ioctl in the same
> > > > callchain.  It should work with other tools like perf report.
> > >
> > > Hi Namhyung, I think this is interesting work!
> > >
> > > The issue feels similar to leader sampling and some of the unpicking
> > > of that we've been dealing with. With leader sampling it was added and
> > > then the dispatch of events modified so that tools wouldn't see leader
> > > samples, instead new events would be synthesized based on the leader
> > > sample data. However, the leader sample event wasn't changed and so
> > > now we have multiple repeated events and perf inject wouldn't just
> > > pass through a perf data file.
> > >
> > > What I'm expecting based on this description is that a deferred call
> > > chain will be merged with a regular one, however, perf inject isn't
> > > updated to drop the deferred callchain so now we have the deferred
> > > callchain event twice.
> > >
> > > My feeling is that making the dispatch of events to tools "smart" is a
> > > false economy. Tools can add handlers for these events easily enough.
> > > What's harder is undoing the smartness when it does things that lead
> > > to duplicated events and the like. I'm not a fan of how leader
> > > sampling was implemented and I still think it odd that with perf
> > > script we see invented events when trying to just dump the contents of
> > > a perf.data file.
> >
> > That's why I added perf_tool.merge_deferred_callchains flag to control
> > the behavior.  I haven't implemented it to perf inject because it covers
> > a couple of different use cases.  I believe the default behavior is to
> > not invoke the callback for deferred callchains during perf inject and
> > each sample will get the full callchains.  But you can add a new
> > callback and set perf_tool.merge_deferred_callchains to false.
> 
> I wonder if there is a different strategy for handling this. Normally
> with a visitor pattern you fail when you call an unimplemented
> visitor, this is then a signal the (in our case) tool needs to handle
> the new case. This avoids naively doing things like making perf inject
> duplicate events. The equivalent in the perf code would be to
> initialize the callbacks in the tool constructor to be to stubs that
> abort, then explicitly initialize and use things like callchain
> merging as appropriate. The whole booleans next to the callbacks feels
> like a kludge and likely to hide bugs. It is also marginally less
> efficient.

Well.. we might change it that way later, but I just wanted to test the
deferred callchains quickly in this series.

Thanks,
Namhyung

