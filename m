Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125F1B422A;
	Wed,  7 May 2025 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746661882; cv=none; b=lH+XFkNi/EtO9YFBMvRDFLjR8FU2O7Bw/QRT9BcPrz41TI79n87C2VJ0eS7SKij8T05TRJwjWTWxbRMHMLaSyTWn9K2uHVrB53fVoM8J02d19qDShxNd8YskdWZwbmU/D4M/pFEqyURvCh8Q0L5QG22wgVOAr5buU2Dhc1kN/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746661882; c=relaxed/simple;
	bh=sF8Abmh/+6fn/FzOe0l/7dwwjCJ6ZpSgaatciwZCwM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFaUIYUE9g/cjT2ryAG0gS8UXojcvR3Zq+mzq40TRTsp3LELQ1XxnJdcE32w4kifE5tk7bkWYYdqIclkWcwb/MmiCVDJHb1xRvt67U2BZ7mreKTbUdaEd9DXUl05XPmdFIZa746CbQ4MElcqlrcJN0ogK0WsjoCnqmTbmPpIpbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8XWq6E6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8XWq6E6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E64C4CEE2;
	Wed,  7 May 2025 23:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746661881;
	bh=sF8Abmh/+6fn/FzOe0l/7dwwjCJ6ZpSgaatciwZCwM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8XWq6E6Fhd0ULmPTVFTj4GAo4U7W1WSw+Tgr2FixGFlU2im2Tr8PQ5lr2LXCajn+
	 dfbC+dx91Xnu9Mv57Vsi1aCm898OAJodB4WDbP3uQG1QbRibxQ0JOhYH9HivAHZf72
	 gR6NfI1vfPVyTKDWnDprCQ+ceSWgAsrxZYP7bUmyzcUfcN/fasrh8YUy9jZagwMRnp
	 j5/qUc8LtMOayJgzsCnOVlpdHw4HNqCs1BdZkWfgAHgl69Kx6uVOCrGTC36iCoXAYc
	 VidQzDdLOpqPvhq/JXGjrUOqi/s2pPHUuvFf4j9cnaO+BcBr00+Vh/0c7wFjnvwRxi
	 emvTDFOIFdcTA==
Date: Wed, 7 May 2025 16:51:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aBvx-J-ISifmw0NS@google.com>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <aBcjwoINtWRWKMIJ@gmail.com>
 <aBfFlT0l05yBbZBj@google.com>
 <CACT4Y+YvWYFBkZ9jQ2kuTOHb6pZQwWXc9sOJ5Km0Wr1fLi-94A@mail.gmail.com>
 <aBojTzsa5mSAGziP@x1>
 <aBo_z8Q87gflYyuX@x1>
 <CACT4Y+YG61CUPG1WRSGWgv00eP9aPYLELvDVmjK9ULJwNiiMgw@mail.gmail.com>
 <aBuAjt5PyBsN65R9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBuAjt5PyBsN65R9@x1>

On Wed, May 07, 2025 at 12:47:26PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 07, 2025 at 11:58:10AM +0200, Dmitry Vyukov wrote:
> > On Tue, 6 May 2025 at 18:58, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > So maybe when we notice that cycles was used 'perf report/top' should
> > > > use the term 'wall-clock' for the column name?
> 
> > > > So instead of having a --latency we could have a hint that would tell
> > > > the user that if this knob was set:
> 
> > > >   $ perf config report.wall-clock=true
>  
> > I am not sure it can be as simple as a single global knob.
> 
> > First, record needs to collect additional info and that may be
> > somewhat expensive.
>  
> > Second, report now has several modes:
> >  - it can show latency, but order by the current overhead
> >  - it can also show latency, and order by latency
> > A user wants one or another depending on what they are optimizing
> > (possibly looking at both).
>  
> > I also feel that global config switches are even less discoverable by
> > median users (read -- ~nobody will know about that). If these things
> > are normal flags with a help description, then some users may
> > eventually discover them.
> 
> So, the addition of:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9cbc854d8b148e3491291fb615e94261970fb54
> 
>   perf config: Add a function to set one variable in .perfconfig
> 
>   To allow for setting a variable from some other tool, like with the
>   "wallclock" patchset needs to allow the user to opt-in to having
>   that key in the sort order for 'perf report'.
> 
>   Cc: Dmitriy Vyukov <dvyukov@google.com>
> 
> 
> Was to tell the user about the new possibilities of profiling, once,
> with something like:
> 
> root@number:~# perf report
>              ┌─────────────────────────────────────────────────────┐
>              │Do you want to use latency mode?                     │
>              │That will add a 'Latency' column that would mean     │
>              │'wall-clock' time when used with cycles, for instance│
>              │                                                     │
>              │                                                     │
>              │Enter: Yes, ESC: No                                  │
>              └─────────────────────────────────────────────────────┘
>  
> The working should inform if the current perf.data has what is needed
> and thus this would take immediate effect, and if not, inform that as
> well and what is needed to be able to use that, things like you
> described above:

Looks useful!  Maybe we want to add it to interactive TUI only..

> 
> > First, record needs to collect additional info and that may be
> > somewhat expensive.
> 
> If the user says that the feature is desired by pressing Enter, follow
> up questions can be asked as well, like you described:

I'm afraid it can have a long chain of questions when a new user starts
to use the perf tool with any config.  Maybe we need to limit it somehow.

> 
> > Second, report now has several modes:
> 
> >  - it can show latency, but order by the current overhead
> >  - it can also show latency, and order by latency
> 
> > A user wants one or another depending on what they are optimizing
> > (possibly looking at both).
> 
> Once these are answered, the questions goes away, as they are now
> recorded in the user's ~/.perfconfig file and will be used when what is
> needed is present in perf.data file.

Sounds good.

> 
> The user should also be informed that to change that knob, 'perf config'
> is your friend.
> 
> Additionally some hotkey could be made available to change that
> behaviour, on the fly, with the option of turning the new mode the new
> default, again writing to ~/.perfconfig.
> 
> Sometimes this "on the fly" needs reprocessing of the whole perf.data
> file, sometimes it may be a matter of just showing extra available
> fields, like the 'V' key now, that goes on bumping the verbosity in the
> 'perf report' and 'perf top' browsers (they share the hists browser), or
> 'j' that toogles showing the lines from jump sources to jump targets in
> the annotate browser, 'J' to show how many jumps target a particular
> jump target, also in the annotate browser, etc.
> 
> This could help experimenting with the various modes of doing profiling,
> interactively, to see the problem from different angles, without having
> to restart the whole process by exiting the 'perf report' to add new
> command line options, then restart, etc, reusing computation sometimes
> when switching views, etc.
> 
> To get default behaviour its just a matter of renaming ~/.perfconfig to
> ~/.perfconfig.some_suitabe_name_for_later_use.
> 
> This way interesting new features like this don't get buried behind
> either command line options nor man pages, giving the user at least an
> opportunity to be informed about it.
> 
> That is what the patch below barely starts sketching, not doing all I
> just described.

Sounds like a good idea.

Thanks,
Namhyung

