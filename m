Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F83597E;
	Sun,  4 May 2025 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746346952; cv=none; b=fYLBe/96U4JcxXAPkaeHf50ROUgHiMdYEV6g9GlMCIgGMIVMyy/Yp01rkS5gZsQx5GLGPrUJ8oCFl6oQT4CDpobG8N0WBXrbE89ZCsHWIbub4flz03uVqPuWX85R9Zt9gTFnNMWTsB6N7+eiHZ1Q15kFypVIJ05QDruAsade9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746346952; c=relaxed/simple;
	bh=wqBfIaD1DCzuS063sqcRt5sffO2+02CDSokPTPFOh0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqfepRIz0FaZNKPLGz5nxVFXpQAfIRaUtHz83d1fZFGU3M4mcVKVt8oDxWpwh/E3qWhZg88o6Hc8eLnJ4+D/zvhId1fm5WjWPk2j2qwplkEwmeOU/JGIrSrl06/PhG3hbi8lee9zRxn3VUZg9ddZETcnevYoyGhCtr8uz2CNBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvbk6x57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvbk6x57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DCDC4CEE7;
	Sun,  4 May 2025 08:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746346951;
	bh=wqBfIaD1DCzuS063sqcRt5sffO2+02CDSokPTPFOh0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvbk6x57E9od9ceyaY5rvLZtLMp/Z/lx8P1sOYx23gbJngMi7Q97uG+zdM82rsB+8
	 yVvAUSAZLGygjoRhDo2aCBCIgdMPyX2O8WcTgB5wJBekqGpjBrVZRkHC64m1lGXKTf
	 smvHPX/CvH4PvTR6NgDZOgDXvZLeDAioCpmUuhIjGfaI00wG0o7QppFhMBPpMlu5BO
	 sKcXMftRTxJjFXU8DzjSRixwI7yhyqKi0QnBctEnwcXzRIS03Wqf9l7QaZLt8IDEbK
	 ezvlh65ZI/1432B8jX6gYXI8fJXG/4tcw+Af/XrvXK1+UwA0E6XdB5343USnI3gjwB
	 JlnRKiOkZi+Gg==
Date: Sun, 4 May 2025 10:22:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
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
Message-ID: <aBcjwoINtWRWKMIJ@gmail.com>
References: <20250503003620.45072-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503003620.45072-1-namhyung@kernel.org>


* Namhyung Kim <namhyung@kernel.org> wrote:

> When it profile a target process (and its children), it's
> straight-forward to track parallelism using sched-switch info.  The
> parallelism is kept in machine-level in this case.
> 
> But when it profile multiple processes like in the system-wide mode,
> it might not be clear how to apply the (machine-level) parallelism to
> different tasks.  That's why it disabled the latency profiling for
> system-wide mode.
> 
> But it should be able to track parallelism in each process and it'd
> useful to profile latency issues in multi-threaded programs.  So this
> patch tries to enable it.
> 
> However using sched-switch info can be a problem since it may emit a lot
> more data and more chances for losing data when perf cannot keep up with
> it.
> 
> Instead, it can maintain the current process for each CPU when it sees
> samples.  And the process updates parallelism so that it can calculate
> the latency based on the value.  One more point to improve is to remove
> the idle task from latency calculation.
> 
> Here's an example:
> 
>   # perf record -a -- perf bench sched messaging
> 
> This basically forks each sender and receiver tasks for the run.
> 
>   # perf report --latency -s comm --stdio
>   ...
>   #
>   #  Latency  Overhead  Command
>   # ........  ........  ...............
>   #
>       98.14%    95.97%  sched-messaging
>        0.78%     0.93%  gnome-shell
>        0.36%     0.34%  ptyxis
>        0.23%     0.23%  kworker/u112:0-
>        0.23%     0.44%  perf
>        0.08%     0.10%  KMS thread
>        0.05%     0.05%  rcu_preempt
>        0.05%     0.05%  kworker/u113:2-
>        ...

Just a generic user-interface comment: I had to look up what 'latency' 
means in this context, and went about 3 hops deep into various pieces 
of description until I found Documentation/cpu-and-latency-overheads.txt,
where after a bit of head-scratching I realized that 'latency' is a
weird alias for 'wall-clock time'...

This is *highly* confusing terminology IMHO.

'Latency' is a highly overloaded concept that almost never corresponds 
to 'wall clock time'. It usually means a relative delay value, which is 
why I initially thought this somehow means instruction-latency or 
memory-latency profiling ...

Ie. 'latency' in its naive meaning, is on the exact opposite side of 
the terminology spectrum of where it should be: it suggests relative 
time, while in reality it's connected to wall-clock/absolute time ...

*Please* use something else. Wall-clock is fine, as 
cpu-and-latency-overheads.txt uses initially, but so would be other 
combinations:

   #1: 'CPU time' vs. 'real time'

        This is short, although a disadvantage is the possible 
        'real-time kernel' source of confusion here.

   #2: 'CPU time' vs. 'wall-clock time'

        This is longer but OK and unambiguous.

   #3: 'relative time' vs. 'absolute time'

        This is short and straightforward, and might be my favorite 
        personally, because relative/absolute is such an unambiguous 
        and well-known terminology and often paired in a similar 
        fashion.

   #4: 'CPU time' vs. 'absolute time'

        This is a combination of #1 and #3 that keeps the 'CPU time' 
        terminology for relative time. The CPU/absolute pairing is not 
        that intuitive though.

   #5: 'CPU time' vs. 'latency'

        This is really, really bad and unintuitive. Sorry to be so 
        harsh and negative about this choice, but this is such a nice 
        feature, which suffers from confusing naming. :-)

Thanks,

	Ingo
