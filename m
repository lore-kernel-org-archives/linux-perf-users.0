Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1912820CE;
	Tue,  6 May 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543443; cv=none; b=MTFj17qjNviMU71enFNYwTpRRFLp7zuEFFVgJ+5GNxn9NAmv6SnIh8N0YGIi55cwGo3XmwPus5wCTLzLUTN3t7TMkc66pyZxNFyEuKDpcNCY4WqrGIztsTpp7WOOhkva4wfwmns+6KA/CKZZHsbOszXinWf21CPD6uy3JOgVE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543443; c=relaxed/simple;
	bh=dfPqeOD8hsL2KXr9GghnXKG2bs2+BEr+5ekOPk1jLfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8CJfqU8WYlHAVaZowtd1y7cAeWBSqpRw+fQi1iSQkM1mYj5R07o6pK1NZNfVB06irqe7cCehT/jx+breHGod6K2T6DVSs0TN0JVdVqwvjRp71tLRqeH2rBCUvfd3EpvnnQBqnAWxXURHS6HBjd4r+UYaSQL/MPdcJFBnT8sDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgmeIJyV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgmeIJyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC46C4CEE4;
	Tue,  6 May 2025 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746543443;
	bh=dfPqeOD8hsL2KXr9GghnXKG2bs2+BEr+5ekOPk1jLfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgmeIJyV+3qV/4dUdOk4gE0owLiNXps7E8VqOMusUCa94Qow2Q8ZzLnH93omVyXOz
	 2uTG+d2053/Dgb0ZKIb/65xUyWwA46aqKfwswcqqAyLG+0NWhkdKXWqWb7NFLi91qW
	 q3DhcA1krqqIXWx9XzsYjamHEdcOqfCyfBvP5kbRhcgMf5mBdMA2AviVaYavvBNcfz
	 wywN5bUpNS2kgqNg814mUyXHH19gUGMCrM4EgXIx5xvzFazKlZSkl38zt5em06pF9K
	 UyH4qyMR6kl+7Igusqfu83NxO445vpUgATVV1ZsnXlgu0BktZvTQjZS20JTtZ0qeM/
	 A2q094tIySMiQ==
Date: Tue, 6 May 2025 11:57:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aBojTzsa5mSAGziP@x1>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <aBcjwoINtWRWKMIJ@gmail.com>
 <aBfFlT0l05yBbZBj@google.com>
 <CACT4Y+YvWYFBkZ9jQ2kuTOHb6pZQwWXc9sOJ5Km0Wr1fLi-94A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YvWYFBkZ9jQ2kuTOHb6pZQwWXc9sOJ5Km0Wr1fLi-94A@mail.gmail.com>

On Mon, May 05, 2025 at 10:03:05AM +0200, Dmitry Vyukov wrote:
> On Sun, 4 May 2025 at 21:52, Namhyung Kim <namhyung@kernel.org> wrote:
> > On Sun, May 04, 2025 at 10:22:26AM +0200, Ingo Molnar wrote:
> > > > Here's an example:

> > > >   # perf record -a -- perf bench sched messaging

> > > > This basically forks each sender and receiver tasks for the run.

> > > >   # perf report --latency -s comm --stdio
> > > >   ...
> > > >   #
> > > >   #  Latency  Overhead  Command
> > > >   # ........  ........  ...............
> > > >   #
> > > >       98.14%    95.97%  sched-messaging
> > > >        0.78%     0.93%  gnome-shell
> > > >        0.36%     0.34%  ptyxis
> > > >        0.23%     0.23%  kworker/u112:0-
> > > >        0.23%     0.44%  perf
> > > >        0.08%     0.10%  KMS thread
> > > >        0.05%     0.05%  rcu_preempt
> > > >        0.05%     0.05%  kworker/u113:2-
> > > >        ...

> > > Just a generic user-interface comment: I had to look up what 'latency'
> > > means in this context, and went about 3 hops deep into various pieces
> > > of description until I found Documentation/cpu-and-latency-overheads.txt,
> > > where after a bit of head-scratching I realized that 'latency' is a
> > > weird alias for 'wall-clock time'...

> > > This is *highly* confusing terminology IMHO.

> > Sorry for the confusion.  I know I'm terrible at naming things. :)

> > Actually Dmitry used the term 'wall-clock' profiling at first when he
> > implemented this feature but I thought it was not clear how it meant
> > for non-cycle events.  As 'overhead' is also a generic term, we ended
> > up with 'latency'.
 
> Exactly :)

So, the 'cycles' event is the most commonly used, its the default if one
does 'perf record' and don't ask for a specific event.

When we notice that 'cycles' and 'instructions' are counted, we provide
an IPC, as that is a well known metric for that combo:

  root@number:~# perf stat -e cycles,instructions sleep 1
  
   Performance counter stats for 'sleep 1':
  
           1,149,493      cycles                                                                
           1,197,279      instructions                     #    1.04  insn per cycle            
  
         1.000645408 seconds time elapsed
  
         0.000599000 seconds user
         0.000000000 seconds sys
  
  
  root@number:~#

So maybe when we notice that cycles was used 'perf report/top' should
use the term 'wall-clock' for the column name?

So instead of having a --latency we could have a hint that would tell
the user that if this knob was set:

  $ perf config report.wall-clock=true

Then if 'cycles' is present we would have:

  # perf report -s comm --stdio
  ...
  #
  # Wall-clock  Overhead  Command
  # ..........  ........  ...............
  #
        98.14%    95.97%  sched-messaging
         0.78%     0.93%  gnome-shell
         0.36%     0.34%  ptyxis
         0.23%     0.23%  kworker/u112:0-
         0.23%     0.44%  perf
         0.08%     0.10%  KMS thread
         0.05%     0.05%  rcu_preempt
         0.05%     0.05%  kworker/u113:2-
         ...

And that would become the "default", i.e. show the "Wall-clock" column
when appropriate, which is something I think Dmitry partially (he used
it for all events, IIRC, this would be just if 'cycles' is present)
tried when submitting the first version of his patchset?

What term to use with other events remains as an exercise, but to a lot
of people wanting just the 'cycles' event, like was used in the above
patch log message:

  # perf record -a -- perf bench sched messaging

That would be enough, no?

- Arnaldo
 
> I've also talked with a bunch of people about this, and everybody
> proposes their own term and is confused by all other proposals.
 
> The problem is that we did not just lack this fundamental profiling
> capability in all profilers out there, but we, as a community, also
> still don't know how to even talk about these things...
 
> There is no terminology that would be clear for everybody. E.g. when
> some people hear wall-clock, they imply that it samples every thread
> (runnable and non-runnnable) every time unit (but that's a vastly
> different profile from this one).
 
> > > 'Latency' is a highly overloaded concept that almost never corresponds
> > > to 'wall clock time'. It usually means a relative delay value, which is
> > > why I initially thought this somehow means instruction-latency or
> > > memory-latency profiling ...

> > > Ie. 'latency' in its naive meaning, is on the exact opposite side of
> > > the terminology spectrum of where it should be: it suggests relative
> > > time, while in reality it's connected to wall-clock/absolute time ...

> > > *Please* use something else. Wall-clock is fine, as
> > > cpu-and-latency-overheads.txt uses initially, but so would be other
> > > combinations:

> > >    #1: 'CPU time' vs. 'real time'

> > >         This is short, although a disadvantage is the possible
> > >         'real-time kernel' source of confusion here.

> > >    #2: 'CPU time' vs. 'wall-clock time'

> > >         This is longer but OK and unambiguous.

> > >    #3: 'relative time' vs. 'absolute time'

> > >         This is short and straightforward, and might be my favorite
> > >         personally, because relative/absolute is such an unambiguous
> > >         and well-known terminology and often paired in a similar
> > >         fashion.

> > >    #4: 'CPU time' vs. 'absolute time'

> > >         This is a combination of #1 and #3 that keeps the 'CPU time'
> > >         terminology for relative time. The CPU/absolute pairing is not
> > >         that intuitive though.

> > >    #5: 'CPU time' vs. 'latency'

> > >         This is really, really bad and unintuitive. Sorry to be so
> > >         harsh and negative about this choice, but this is such a nice
> > >         feature, which suffers from confusing naming. :-)

> > Thanks for your seggestions.  My main concern is that it's not just
> > about cpu-time and wallclock-time.  perf tools can measure any events
> > that have different meanings.  So I think we need generic terms to cover
> > them.
 
> I did not see a conflict there. It's possible to sample, say, cache
> misses per unit of CPU time or per unit of wall-clock time.
