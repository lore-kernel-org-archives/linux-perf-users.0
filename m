Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F176CDBA;
	Mon, 12 Aug 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482314; cv=none; b=FdeIygAnH27U7EtUwmo6G41X02qb1tzQ8mKFe9/OjZxfNjkLX71YicSDvRr8NThr7Zrsmrgbak0AHRdcvTB0qxPJdKg6NrPjalaEACuZiElsoRBR4NVbT9877pwja6Ch4qmPYsuut1yDCum+dpqVPpH9/WQRnYQDzP9U9xqPAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482314; c=relaxed/simple;
	bh=oGiZZle+aDNqk7uI8j4spOTEOnvPBzuW0c7JMidQMWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLTogYt8RBRUj3IUFf0I/ce7L0AVODHoLkKSYniZSNtbCcgFBZ6sfk5DddSZlUm0m1IhJ9+y7V0pFAOef5sigot/hXjZyc/OhpKDg9eJZjpbhiJbKajO6q3MURxU5Qp5e5LDqlhZF4c3jMsbqGeg9hccM7w8jsRkopFxixh02ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVS4JuTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVS4JuTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C1FC4AF0D;
	Mon, 12 Aug 2024 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723482313;
	bh=oGiZZle+aDNqk7uI8j4spOTEOnvPBzuW0c7JMidQMWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVS4JuTVRqASX2WctNuQe0N8/vf3lOHxaAX/KaLY0GnmFyv2R6Q2NkYF5jy9bBcJw
	 Mkmt30WujDZkq1yAdFUDPCw8Xf1jcu2AQk1+1rXC/SKroO4S1Faes8K5Aqdb3fvKOk
	 8CXN3vwbFVfk+3gEq5DbK6PMDc6tVxo+he6pmOOH5NJ/m1n9WZBl4/88zgkxH7Fkol
	 yuR7s/eIb47A/G82bVWTZDiWULUw8TJAbYVXpvmETOeKrTs063MmxxfyjskumbEQT+
	 HMhUZHspSmE64kZmTIPITAoGWRTV+QAUHj7Pit0myX6UPTrFv+U7otgg3OkkDdHBb2
	 huy3AcIu9DiGA==
Date: Mon, 12 Aug 2024 14:05:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] perf lock contention: Change stack_id type to s32
Message-ID: <ZrpAxUEnCUNBcwCS@x1>
References: <909abbc8-efca-40df-9876-8c36b6942a83@stanley.mountain>
 <20240810191704.1948365-1-namhyung@kernel.org>
 <ZrozwIQcB_viRsKt@x1>
 <Zro90YPyLCB9PsfL@x1>
 <CAM9d7ch1ESEhJW-1j0O-0xxr-w1we+opD1xWTs4Eq=u7Gg7unQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ch1ESEhJW-1j0O-0xxr-w1we+opD1xWTs4Eq=u7Gg7unQ@mail.gmail.com>

On Mon, Aug 12, 2024 at 09:57:27AM -0700, Namhyung Kim wrote:
> On Mon, Aug 12, 2024 at 9:52 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Aug 12, 2024 at 01:09:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Sat, Aug 10, 2024 at 12:17:04PM -0700, Namhyung Kim wrote:
> > > > The bpf_get_stackid() helper returns a signed type to check whether it
> > > > failed to get a stacktrace or not.  But it saved the result in u32 and
> > > > checked if the value is negative.
> > > >
> > > >       376         if (needs_callstack) {
> > > >       377                 pelem->stack_id = bpf_get_stackid(ctx, &stacks,
> > > >       378                                                   BPF_F_FAST_STACK_CMP | stack_skip);
> > > >   --> 379                 if (pelem->stack_id < 0)
> > > >
> > > >   ./tools/perf/util/bpf_skel/lock_contention.bpf.c:379 contention_begin()
> > > >   warn: unsigned 'pelem->stack_id' is never less than zero.
> > > >
> > > > Let's change the type to s32 instead.
> > > >
> > > > Fixes: 6d499a6b3d90 ("perf lock: Print the number of lost entries for BPF")
> > >
> > > Thanks, applied to perf-tools-next,
> >
> > I'll try to fix this later, but now it fails the first 'make -C
> > tools/perf build-test' target, that you can run directly as:
> >
> > ⬢[acme@toolbox perf-tools-next]$ tools/perf/tests/perf-targz-src-pkg tools/perf
> > <SNIP>
> >   CLANG   /tmp/tmp.FRZLVEwqdz/perf-6.11.0-rc2/tools/perf/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
> > In file included from util/bpf_skel/lock_contention.bpf.c:9:
> > util/bpf_skel/lock_data.h:10:2: error: unknown type name 's32'; did you mean 'u32'?
> >    10 |         s32 stack_id;
> >       |         ^~~
> >       |         u32
> > util/bpf_skel/vmlinux.h:17:15: note: 'u32' declared here
> >    17 | typedef __u32 u32;
> >       |               ^
> 
> Oops, sorry about this.  There was a kernel test robot report.

Cool, I didn't see it, but its good its doing this work.

> It seems we need 'typedef __s32 s32;' too.

Please send a v2 then,

Thanks,

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> > In file included from util/bpf_skel/lock_contention.bpf.c:9:
> > util/bpf_skel/lock_data.h:14:2: error: unknown type name 's32'; did you mean 'u32'?
> >    14 |         s32 stack_id;
> >       |         ^~~
> >       |         u32
> > util/bpf_skel/vmlinux.h:17:15: note: 'u32' declared here
> >    17 | typedef __u32 u32;
> >       |               ^
> > 2 errors generated.
> > make[2]: *** [Makefile.perf:1247: /tmp/tmp.FRZLVEwqdz/perf-6.11.0-rc2/tools/perf/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [Makefile.perf:292: sub-make] Error 2
> > make: *** [Makefile:76: all] Error 2
> > make: Leaving directory '/tmp/tmp.FRZLVEwqdz/perf-6.11.0-rc2/tools/perf'
> > ⬢[acme@toolbox perf-tools-next]$
