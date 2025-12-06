Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB926561D;
	Sat,  6 Dec 2025 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765020038; cv=none; b=lenwun4OcjwDdJfA8+LYamYBykR2HLhr6/ZJIhRQ00UkFb+szY79IJPY6oTBQ807ZBDRqxLlnnyomjG2Ras7YTTWUSEaJzJ58L5OmGStJ3B2nYR6P3oq+oXnJYbI/uyEj0QhABhyhZBieEkui366zry81GgMIK2l13jorV0pwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765020038; c=relaxed/simple;
	bh=q10HpmBObrIw2b9ITCEazlwxdaGi7wPiYsaAxJYOHho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYGtpVs0iUy+Md/oa9OeyzJk/TreQN06Y+SVOdNdtozAr5d8Fz1scv8Uy3I9ZlGjlU2G94FE6TOPv9+QCpoIghzLnHdwItqnkLtZMflB2CSTFUOEyGa5EOBI8HBosEN+hAV5KjQaZOxV/JacDvHDhjQrPT61sYkGk/5JeZ4sDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQHuuE5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQHuuE5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1262C4CEF5;
	Sat,  6 Dec 2025 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765020037;
	bh=q10HpmBObrIw2b9ITCEazlwxdaGi7wPiYsaAxJYOHho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQHuuE5uBqxr/c7TJ2pi7O3HA1A1auW99zx4ayPM2owf+vfTa4CDTurm05TlhUfmO
	 /vZeg0vmxt6tuswBdxrE7XCElTSgW6580uMhnOc/MLsN8U1MCVl+8fYO6H/guQ7KaN
	 anRyeh44XI/aJKq9jNb/KULCEJrNQfNQw1Oyc6olYOE/sGJDnQyvUAJmo0w9gXdwUa
	 dlgkZbCANAqUU6nd+Q+79mhNMI8kaEGD6ySCXFiOAvhyAKxV/VYrnwyDgmr9xrMlxT
	 HpW+T9zBBH1wvdDwPtqQpBnhS9jWksispRSQW8wNTRl3DQPqiAD8cUn+Y9sPOLFW5I
	 PmYn4ZYdCi9cA==
Date: Sat, 6 Dec 2025 12:20:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Perf stat --null/offline CPU segv related
 fixes/tests
Message-ID: <aTQRgAOpKyI53TEq@gmail.com>
References: <20251203214706.112174-1-irogers@google.com>
 <aTP4zSy87wEZlbsO@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTP4zSy87wEZlbsO@gmail.com>

* Ingo Molnar <mingo@kernel.org> wrote:

> * Ian Rogers <irogers@google.com> wrote:
>
> > Ingo reported [1] that `perf stat --null` was segfaulting. Fix the
> > underlying issue and add a test to the "perf stat tests". Do some
> > related fixing/cleanup in the perf util cpumap code.
> >
> > Thomas reported an issue fixed by the same patches [2] but caused by
> > giving perf stat an offline CPU. Add test coverage for that and
> > improve the "error" message that reports "success".
> >
> > Ingo further pointed at broken signal handling in repeat mode [3]. I
> > observed we weren't giving the best exit code, 0 rather than the
> > expected 128+<signal number>. Add a patch fixing this.
> >
> > [1] https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.com/
> > [2] https://lore.kernel.org/linux-perf-users/94313b82-888b-4f42-9fb0-4585f9e90080@linux.ibm.com/
> > [3] https://lore.kernel.org/lkml/aS5wjmbAM9ka3M2g@gmail.com/
> >
> > Ian Rogers (7):
> >   perf stat: Allow no events to open if this is a "--null" run
> >   libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map
> >   perf cpumap: Add "any" CPU handling to cpu_map__snprint_mask
> >   perf tests stat: Add "--null" coverage
> >   perf stat: When no events, don't report an error if there is none
> >   perf tests stat: Add test for error for an offline CPU
> >   perf stat: Improve handling of termination by signal
> >
> >  tools/lib/perf/cpumap.c        | 10 +++++----
> >  tools/perf/builtin-stat.c      | 29 ++++++++++++++++++-------
> >  tools/perf/tests/shell/stat.sh | 39 ++++++++++++++++++++++++++++++++++
> >  tools/perf/util/cpumap.c       |  9 ++++++--
> >  4 files changed, 73 insertions(+), 14 deletions(-)
>
> A belated:
>
>   Tested-by: Ingo Molnar <mingo@kernel.org>
>
> And thank you a lot for doing these QoL fixes!

There's one more perf stat QoL bug I'd like to report - I frequently
do repeated runs of perf stat --repeat and grep the output, to get
a feel for the run-to-run stability of a particular benchmark:

  starship:~/tip> while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed; done 
         0.1017997 +- 0.0000771 seconds time elapsed  ( +-  0.08% )
         0.1017627 +- 0.0000795 seconds time elapsed  ( +-  0.08% )
         0.1018106 +- 0.0000650 seconds time elapsed  ( +-  0.06% )
         0.1017844 +- 0.0000601 seconds time elapsed  ( +-  0.06% )
          0.101883 +- 0.000169 seconds time elapsed  ( +-  0.17% ) <====
         0.1017757 +- 0.0000532 seconds time elapsed  ( +-  0.05% )
         0.1017991 +- 0.0000720 seconds time elapsed  ( +-  0.07% )
         0.1018024 +- 0.0000704 seconds time elapsed  ( +-  0.07% )
         0.1018074 +- 0.0000946 seconds time elapsed  ( +-  0.09% )
         0.1019797 +- 0.0000524 seconds time elapsed  ( +-  0.05% )
         0.1018407 +- 0.0000658 seconds time elapsed  ( +-  0.06% )
         0.1017907 +- 0.0000605 seconds time elapsed  ( +-  0.06% )
         0.1018328 +- 0.0000868 seconds time elapsed  ( +-  0.09% )
         0.1017469 +- 0.0000285 seconds time elapsed  ( +-  0.03% )
         0.1019589 +- 0.0000549 seconds time elapsed  ( +-  0.05% )
         0.1018465 +- 0.0000891 seconds time elapsed  ( +-  0.09% )
          0.101868 +- 0.000117 seconds time elapsed  ( +-  0.12% ) <====
         0.1017705 +- 0.0000590 seconds time elapsed  ( +-  0.06% )
         0.1017728 +- 0.0000718 seconds time elapsed  ( +-  0.07% )
         0.1017821 +- 0.0000419 seconds time elapsed  ( +-  0.04% )
         0.1018328 +- 0.0000581 seconds time elapsed  ( +-  0.06% )
         0.1017836 +- 0.0000853 seconds time elapsed  ( +-  0.08% )
         0.1018124 +- 0.0000765 seconds time elapsed  ( +-  0.08% )
         0.1018706 +- 0.0000639 seconds time elapsed  ( +-  0.06% )

Note the two outliers, which happen due to some misguided
output optimization feature in perf shortening zero-ended
numbers unnecessarily, and adding noise to the grepped
output's vertical alignment.

Those two lines should be:

         0.1017844 +- 0.0000601 seconds time elapsed  ( +-  0.06% )
         0.1018830 +- 0.0001690 seconds time elapsed  ( +-  0.17% ) <====
         0.1017757 +- 0.0000532 seconds time elapsed  ( +-  0.05% )

         0.1018465 +- 0.0000891 seconds time elapsed  ( +-  0.09% )
         0.1018680 +- 0.0001170 seconds time elapsed  ( +-  0.12% ) <====
         0.1017705 +- 0.0000590 seconds time elapsed  ( +-  0.06% )

(The zeroes are printed fully, to full precision.)

Basically random chance causing an apparent lack of significant
numbers doesn't mean the tool should strip them from the output.

Thanks,

	Ingo
