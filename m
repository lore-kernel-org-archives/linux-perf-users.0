Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F817B425;
	Sun,  4 May 2025 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746388377; cv=none; b=R9NEeW+5FWglccKBVwjQYjzf83wY8roFx4L7RyOg8Y7lVTjmZLhvggOIss0N7aB5iML4HLq5FngLYo2VEqZSz5SAANcvWtgB1kG5ffmO90u1KgCuniLYUQzcJQ1q/EsHkprLIadXTyhT6smObUG3zTGcpq5xtYMro+ety8MM16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746388377; c=relaxed/simple;
	bh=VIi6/FtY9wWPmSXSWd6TuhJF71Tuwr0IpvS/uzZanyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpcE503EhxqdAtPB++DbyQevxM9xF7zKcumbnq6OplP+fH6TrGmiQaKFHsMFvsCpRLx2kXMjh8qMF207Pme68nliOh3AS07TS8H16pTDOWUjUnKsa7UQt9+CtTIhvKllP579PHNoB+wZ21UF1wE4bf0ANZFseAex6V03miMyNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1+rXmwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1+rXmwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F036C4CEE7;
	Sun,  4 May 2025 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746388377;
	bh=VIi6/FtY9wWPmSXSWd6TuhJF71Tuwr0IpvS/uzZanyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1+rXmwJB7Gg3i1/HllTnaXlLW1kha8TwRyCntnkpilYn48wuF8ZdpvKhS+IvAJVt
	 oaJmY5/qQ6AuW0Mt84AzQOy3pFwOoeBbVXBuVjn/VcqT0EgxQjI87UUq210lrav3Tl
	 CtyLspkvtYLIbpUGZol43AlrN/v+RoEN0w3EJkpl/U6VKVnOR7pG14qvvlxXMHUZrH
	 8x2YRxZW1d1w0CT1gAaZfbWFvWncUkOZx212FL2lBDtpNIFGCi33SPka58JU4RbWGR
	 RLuT8dOvbLB98nMOByK7uPeEjd7VRK7OdAMmqit65KWo+39ChGNJLsIis4SzCGN7JD
	 Dxh/vxpapKqmQ==
Date: Sun, 4 May 2025 12:52:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aBfFlT0l05yBbZBj@google.com>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <aBcjwoINtWRWKMIJ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBcjwoINtWRWKMIJ@gmail.com>

Hi Ingo,

Thanks for sharing your opinion.

On Sun, May 04, 2025 at 10:22:26AM +0200, Ingo Molnar wrote:
> 
> * Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > When it profile a target process (and its children), it's
> > straight-forward to track parallelism using sched-switch info.  The
> > parallelism is kept in machine-level in this case.
> > 
> > But when it profile multiple processes like in the system-wide mode,
> > it might not be clear how to apply the (machine-level) parallelism to
> > different tasks.  That's why it disabled the latency profiling for
> > system-wide mode.
> > 
> > But it should be able to track parallelism in each process and it'd
> > useful to profile latency issues in multi-threaded programs.  So this
> > patch tries to enable it.
> > 
> > However using sched-switch info can be a problem since it may emit a lot
> > more data and more chances for losing data when perf cannot keep up with
> > it.
> > 
> > Instead, it can maintain the current process for each CPU when it sees
> > samples.  And the process updates parallelism so that it can calculate
> > the latency based on the value.  One more point to improve is to remove
> > the idle task from latency calculation.
> > 
> > Here's an example:
> > 
> >   # perf record -a -- perf bench sched messaging
> > 
> > This basically forks each sender and receiver tasks for the run.
> > 
> >   # perf report --latency -s comm --stdio
> >   ...
> >   #
> >   #  Latency  Overhead  Command
> >   # ........  ........  ...............
> >   #
> >       98.14%    95.97%  sched-messaging
> >        0.78%     0.93%  gnome-shell
> >        0.36%     0.34%  ptyxis
> >        0.23%     0.23%  kworker/u112:0-
> >        0.23%     0.44%  perf
> >        0.08%     0.10%  KMS thread
> >        0.05%     0.05%  rcu_preempt
> >        0.05%     0.05%  kworker/u113:2-
> >        ...
> 
> Just a generic user-interface comment: I had to look up what 'latency' 
> means in this context, and went about 3 hops deep into various pieces 
> of description until I found Documentation/cpu-and-latency-overheads.txt,
> where after a bit of head-scratching I realized that 'latency' is a
> weird alias for 'wall-clock time'...
> 
> This is *highly* confusing terminology IMHO.

Sorry for the confusion.  I know I'm terrible at naming things. :)

Actually Dmitry used the term 'wall-clock' profiling at first when he
implemented this feature but I thought it was not clear how it meant
for non-cycle events.  As 'overhead' is also a generic term, we ended
up with 'latency'.

> 
> 'Latency' is a highly overloaded concept that almost never corresponds 
> to 'wall clock time'. It usually means a relative delay value, which is 
> why I initially thought this somehow means instruction-latency or 
> memory-latency profiling ...
> 
> Ie. 'latency' in its naive meaning, is on the exact opposite side of 
> the terminology spectrum of where it should be: it suggests relative 
> time, while in reality it's connected to wall-clock/absolute time ...
> 
> *Please* use something else. Wall-clock is fine, as 
> cpu-and-latency-overheads.txt uses initially, but so would be other 
> combinations:
> 
>    #1: 'CPU time' vs. 'real time'
> 
>         This is short, although a disadvantage is the possible 
>         'real-time kernel' source of confusion here.
> 
>    #2: 'CPU time' vs. 'wall-clock time'
> 
>         This is longer but OK and unambiguous.
> 
>    #3: 'relative time' vs. 'absolute time'
> 
>         This is short and straightforward, and might be my favorite 
>         personally, because relative/absolute is such an unambiguous 
>         and well-known terminology and often paired in a similar 
>         fashion.
> 
>    #4: 'CPU time' vs. 'absolute time'
> 
>         This is a combination of #1 and #3 that keeps the 'CPU time' 
>         terminology for relative time. The CPU/absolute pairing is not 
>         that intuitive though.
> 
>    #5: 'CPU time' vs. 'latency'
> 
>         This is really, really bad and unintuitive. Sorry to be so 
>         harsh and negative about this choice, but this is such a nice 
>         feature, which suffers from confusing naming. :-)

Thanks for your seggestions.  My main concern is that it's not just
about cpu-time and wallclock-time.  perf tools can measure any events
that have different meanings.  So I think we need generic terms to cover
them.

Thanks,
Namhyung

