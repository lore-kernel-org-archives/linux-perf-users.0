Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DCC1DA612;
	Thu, 20 Mar 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487403; cv=none; b=W9l6IINCn9KC9Uvn4fbmG4C1TFVL8XF0eYLKeo/+o06kdd87yHUPLsuq46CePHk6tm2zQxteY/aUChY6SvHt5GzNUZYt7AoWSPCsep10PlOy14Fmg2MIW9+ZJ4ZpTIDY3O4TdHTiZXCEXiVhmq1K4lWaLKhBZc8bNCiW56N8vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487403; c=relaxed/simple;
	bh=QuSV0ezqDMuBA7My6kyh7ypDBxaO5u9B+e93O6me3d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN3Otydw5WcxG9ywYzmcfJXjrdC0t6fwn0M34b2K0G7YRqBtswqiIC+pyrXI3wLzTGsaETqrFLuBUhS13IwxlAd4Q5BXu/pglqInaqnFutxjPFoEqIZGmP3AWwtaEq5AS5YJADHr2aEXK+DDJ6f5pxB2L5KSEyVyssK7mOM7RH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uow37P9O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uow37P9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0976CC4CEDD;
	Thu, 20 Mar 2025 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742487402;
	bh=QuSV0ezqDMuBA7My6kyh7ypDBxaO5u9B+e93O6me3d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uow37P9OJm56rmkd9GwQmFzJKbex31heipV4+ype8FB0c5N+hj/QLinZBsayaDFjf
	 4ZfurOQ5zXO375a4LTSmwQVafUIbhVtqx0NHlj4hS3Qu5VFEOn4np30Qwh0sp+qBpR
	 WRFd/sE0gBzTXKGkGVROc2u3Mw/51tRBg+5LXz9uYbCoIYdCeo2Gsc1DKyjNtMaPmF
	 1JORdYkrAy4wv7I27ZYlLDwTLge3GqwNYuMj8vxfgnrRmM8SeTR6/0yr0qhc6+mXH6
	 8bCP5Tk2x/ReaXbd5cWKQ8ufr115o9hncrULxhy0p1TqCxEbapuc0OH5gtdWgJvdq2
	 BLoJiysmt/RgA==
Date: Thu, 20 Mar 2025 09:16:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/3] perf sort: Keep output fields in the same level
Message-ID: <Z9w_aFlzOkoCTSqK@google.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9vgt1pjiNbDBDbM@gmail.com>

Hi Ingo,

On Thu, Mar 20, 2025 at 10:32:39AM +0100, Ingo Molnar wrote:
> 
> * Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > On Fri, Mar 07, 2025 at 12:08:27AM -0800, Namhyung Kim wrote:
> > > This is useful for hierarchy output mode where the first level is
> > > considered as output fields.  We want them in the same level so that it
> > > can show only the remaining groups in the hierarchy.
> > > 
> > > Before:
> > >   $ perf report -s overhead,sample,period,comm,dso -H --stdio
> > >   ...
> > >   #          Overhead  Samples / Period / Command / Shared Object
> > >   # .................  ..........................................
> > >   #
> > >      100.00%           4035
> > >         100.00%           3835883066
> > >            100.00%           perf
> > >                99.37%           perf
> > >                 0.50%           ld-linux-x86-64.so.2
> > >                 0.06%           [unknown]
> > >                 0.04%           libc.so.6
> > >                 0.02%           libLLVM-16.so.1
> > > 
> > > After:
> > >   $ perf report -s overhead,sample,period,comm,dso -H --stdio
> > >   ...
> > >   #    Overhead       Samples        Period  Command / Shared Object
> > >   # .......................................  .......................
> > >   #
> > >      100.00%          4035    3835883066     perf
> > >          99.37%          4005    3811826223     perf
> > >           0.50%            19      19210014     ld-linux-x86-64.so.2
> > >           0.06%             8       2367089     [unknown]
> > >           0.04%             2       1720336     libc.so.6
> > >           0.02%             1        759404     libLLVM-16.so.1
> > > 
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Ping!  Anybody interested in this change? :)
> 
> Oh yes, all such pieces of intelligent organization of textual output 
> of profiling data are worth their weight in gold in my book. :-)
> 
>   Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks a lot!

> 
> 1)
> 
> On a related note, does anyone know why perf stat output alignment 
> sucks so much these days:
> 
>   starship:~/tip> perf stat --null --repeat 20 perf stat --null --repeat 3 perf bench sched messaging 2>&1 | grep elapsed
>            0.11620 +- 0.00327 seconds time elapsed  ( +-  2.81% )
>           0.120813 +- 0.000570 seconds time elapsed  ( +-  0.47% )
>           0.122280 +- 0.000443 seconds time elapsed  ( +-  0.36% )
>           0.119813 +- 0.000752 seconds time elapsed  ( +-  0.63% )
>            0.12190 +- 0.00134 seconds time elapsed  ( +-  1.10% )
>           0.119862 +- 0.000542 seconds time elapsed  ( +-  0.45% )
>           0.120075 +- 0.000608 seconds time elapsed  ( +-  0.51% )
>           0.120350 +- 0.000273 seconds time elapsed  ( +-  0.23% )
>            0.12203 +- 0.00114 seconds time elapsed  ( +-  0.93% )
>            0.12229 +- 0.00114 seconds time elapsed  ( +-  0.93% )
>            0.12032 +- 0.00115 seconds time elapsed  ( +-  0.95% )
>           0.121241 +- 0.000463 seconds time elapsed  ( +-  0.38% )
>           0.119404 +- 0.000333 seconds time elapsed  ( +-  0.28% )
>           0.119945 +- 0.000766 seconds time elapsed  ( +-  0.64% )
>           0.121215 +- 0.000879 seconds time elapsed  ( +-  0.72% )
>            0.12001 +- 0.00109 seconds time elapsed  ( +-  0.91% )
>            0.12193 +- 0.00182 seconds time elapsed  ( +-  1.49% )
>           0.119184 +- 0.000794 seconds time elapsed  ( +-  0.67% )
>           0.120062 +- 0.000439 seconds time elapsed  ( +-  0.37% )
>           0.120834 +- 0.000760 seconds time elapsed  ( +-  0.63% )
>           0.369473 +- 0.000992 seconds time elapsed  ( +-  0.27% )
> 
> ... see how the vertical alignment of the output goes randomly wacko - 
> I presume because there's a trailing zero in the output number and the 
> code for some inexplicable reason decides to shorten it to make the 
> life of developers harder? ;-)

It seems it calcuates the precision when printing the result and doesn't
care much about the repeatations.

> 
> 2)
> 
> It's also incredibly hard to Ctrl-C a 'perf stat --repeat' instance:
> 
>  starship:~/tip> perf stat --null --repeat 20 perf stat --null --repeat 3 perf bench sched messaging
>  # Running 'sched/messaging' benchmark:
>  # 20 sender and receiver processes per group
>  # 10 groups == 400 processes run
> 
>  ...
>  Ctrl-C
> 
>  # Running 'sched/messaging' benchmark:
>  perf: pollperf: perf: pollperf: pollpollperf: pollperf: pollperf: : Interrupted system call
>  : Interrupted system call
>  poll: Interrupted system call
>  perf: pollperf: : Interrupted system call
>  perf: pollperf: pollpollperf: : Interrupted system call
>  pollperf: pollperf: perf: perf: pollpollpollperf: : Interrupted system call
>  pollperf: poll: Interrupted system call
>  : Interrupted system call
>  : Interrupted system call
>  : Interrupted system call
>  perf: poll: Interrupted system call
>  perf: perf: pollpoll: Interrupted system call
>  : Interrupted system call
>  perf: perf: perf: perf: perf: perf: : Interrupted system call
>  pollpollpollpollpollpoll: Interrupted system call
>  : Interrupted system call
>  : Interrupted system call
>  perf: perf: pollperf: perf: perf: perf: perf: perf: pollperf: : Interrupted system call
>  pollpollpoll: Interrupted system call
> 
> Note how the perf stat instance actually *hangs*. I have to Ctrl-Z it, 
> and kill -9 %1 it the hard way to clean up:
> 
>  pollpollpoll: Interrupted system call
>  �
>  [1]+  Stopped                 perf stat --null --repeat 20 perf stat --null --repeat 3 perf bench sched messaging
>  starship:~/tip> kill -9 %1
> 
>  [1]+  Stopped                 perf stat --null --repeat 20 perf stat --null --repeat 3 perf bench sched messaging
>  starship:~/tip> kill -9 %1
> 
> Does anyone use this thing for actual benchmarking work? ;-)

Oh, ok.  I'll take a look.

> 
> 3)
> 
> It would also be nice to be able to Ctrl-C out of a 'perf top' instance 
> that freezes the output or so. Or prints a snapshot in ASCII. Anything 
> but what it does currently: it just exits and clears the xterm screen 
> of all useful information...
> 
> I have to use 'f' (how many people know about that feature?) and copy & 
> paste anything interesting from the screen the hard way.

Actually I was not aware of 'f' key. :)  I think you can use 'P' to save
the current screen to a file.

> 
> 4)
> 
> It would also be nice to have an export function to save current 'perf 
> top' profiling data and have it available for 'perf report' et al 
> analysis. Ie. frequently I just see an interesting snapshot and decide 
> that it's good for further analysis, freeze the screen and are left 
> with very few options to keep it for further look and reference.

Hmm.. interesting.  I'll think about it but it seems doable.

> 
> 5)
> 
> Would anyone be interested in an OpenGL-ish version of perf top, with 
> its own low level shader for font-atlas based text output and vertex 
> based polygon graphics, double buffering, full screen support with very 
> little Xorg interaction for the GX pathway, etc? It should be *far* 
> faster and lower overhead than the current ncurses->xterm->Wayland 
> levels of indirection... and it could open up a new world of on-screen 
> profiling information as well. Basically a very simple self-sustained 
> OpenGL game engine for the key low level graphics primitives of modern 
> GFX hardware. I could whip up a prototype if there's interest.

I'm not familiar with the fancy GFX things but it'd be interesting to
see.  Not sure how well we can manage it in the future though, as we
have unloved GTK2 UI as well.

Thanks,
Namhyung

