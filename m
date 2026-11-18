Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985021;
	b=l0Gd8i6yGR7KPLaQARzxsyXNIfzREJdWNQwIQNfolrQ0LLfqKRVr6Utk8Dqu1c6vVNtR
	 otbOKfLlesLvF79GmR3W39xnNAt4ljZAc2iuLWc6+Nl3CDUgqJC5r4N0PRrZaEaqyGwuN
	 awbHilFif+ho7NpgXdmRzNta4wtnH1wVBngdyAzLmwLlbTP2dnF99wXcobmb4/7zgZRsH
	 TowmNvtAcuJ02phEANNzefRMUoGiuE1W07JLrPrqcuqCs1H8MKpb9e1EYqGU3jtc3lqab
	 iimeI87u82+w7hOFrTTVMyIsP+JYo29vdM22C5Rh7h3xQo4WKcdcjg26IoVnRgMmnKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985021;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zZ/+BJJJJZFPHSW8x/8iINh+pWk3XdVI+bUIZ2/ivYI=;
	b=azutUGQDw62VBEI2W7/v6ySklXI0q6ZuAIW8rzmVtJD62T/Q4WSU9d8rNDisn4dpuVqT
	 mQWLLopLthOGPP6kXpwsztOME/laMlBKnGiiIzv7mx+moEmoUJB85LvnnEvpl5ni6kdZ0
	 NmWhgOAjdSe+DrR//N7I5OMMk8pmaJLv8HqYxU+BDZJXT62dj+oICuDGc242SykEmXIH1
	 EaM3Emb1ownzMevJf1MrVUF48qbFkfYCGEd6PBr/+FhNZjpZq/JRq7rTh0idFjY16cqOR
	 GjtIR6v0SKH3zO+/e1+j/vlv9QVkk3+5H1KFHUSHbnTRP1RTGO6nJW1b/ud4LwdNTsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsrqAypM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73703606A325;
	Wed, 18 Nov 2026 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsrqAypM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B831F000C4;
	Wed, 18 Nov 2026 06:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794985021;
	bh=zZ/+BJJJJZFPHSW8x/8iINh+pWk3XdVI+bUIZ2/ivYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dsrqAypMcTAe9PJzkQ4lhw6HR030MEneoLKEUcYc7aETvBMVIGLEsLpiktLin70lC
	 ximjJ7Cd5TMroNWcrb5znEtkHPGLq/UVnrT2cVs/o6kSKchDui2KctL3VlzFAYnSmI
	 1vHL98aS9qMZjxH9VXslhZiv8RpFqcVFokQcKrgQN6fkgYasW7PJD5ksk+iRKYMO61
	 KIYLNY86nu4qMP9t6wW8KxF9/OsdDnzMiPF0JWEhrbcP2QCKtGFZwQsOlv1LGqBxGu
	 qzVFIF/193PRFTAssmVAp2xkkKRXT3Hf5TE4RXRn7Sn6/9UYtgf/U0XjJGk3fkMez7
	 PoLd+j37un6Pg==
Date: Tue, 17 Nov 2026 22:56:59 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 02/13] perf scripts: Add a coverage harness for perf
Message-ID: <av1MO74yqgr2OJt7@google.com>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-3-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117200433.45174-3-acme@kernel.org>

Hi Arnaldo,

On Tue, Nov 17, 2026 at 05:04:20PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Build perf with clang source based coverage, run the complete perf test
> suite, merge the raw profiles and report line and function coverage,
> optionally against a baseline.  This is pahole's coverage/coverage.sh +
> coverage-diff.sh merged into one script, wired as
> 'make -C tools/perf coverage' and listed in 'make help'.
> 
> Without -f the report lists the files with the most uncovered lines,
> which is where new tests should try to get more coverage; -t narrows
> the tests, -f focuses on specific files, --html writes a browsable
> report and --table/-T, also available as 'make -C tools/perf
> coverage-table', prints the last run as an ASCII table with the
> per-file line and function coverage, like pahole's coverage_table.py.

It'd be nice if you could list all options.

> 
> The build can be split from the test run: 'make -C tools/perf
> coverage-prep' builds the instrumented perf and records the build
> directory, and a later run as root, which needs no make, checks that

Ok, so IIUC it's optional and just running 'make coverage' would all
necessary jobs one stop, right?


> build, runs the tests and renders the report, or prints the table with
> --table.  This is for running the tests that need root on the bare
> metal host while the instrumented perf is built in the development
> container.

What is the table?

> 
> The report covers the whole tree, not only the paths the tests walk, so
> the per-file table is a map of what the suite does not reach in a given
> run.  The uncovered line list and the failures the runs exposed are what
> drove the rest of this series.
> 
>   $ make -C tools/perf coverage-prep O=~/coverage-build
>   ...

What is the actual command line here?  I guess it's..

    $ sudo ~/coverage-build/perf test


>   $ sudo scripts/coverage.sh
>   ...
>   Total: 104787 of 205810 lines covered (50.91%)
>     perf: 85674 of 173247 lines covered (49.45%)
> 
>     largest uncovered files (>= 100 lines)
>     file                                            lines     cover    missed  fn-cover
>     util/intel-pt.c                                  3237     0.00%      3237     0.00%
>     util/intel-pt-decoder/intel-pt-decoder.c         3208     0.00%      3208     0.00%
>     ui/browsers/hists.c                              2730     0.00%      2730     0.00%
>     builtin-sched.c                                  3737    41.26%      2195    43.97%
>     builtin-script.c                                 3212    33.50%      2136    37.90%
>     util/auxtrace.c                                  2013     4.47%      1923    11.11%
>     util/session.c                                   2686    41.14%      1581    48.80%
>     ...
>   Report:  /home/acme/coverage-build/cov/report.txt
> 
> The total also counts the tools/ libraries and headers linked into
> perf, the perf line is the tools/perf/ files alone.  The numbers above
> are from the split run: coverage-prep built the instrumented perf as the
> developer, the tests and the report ran as root.  This machine has no
> Intel PT, so the PT tests skip and leave intel-pt.c and
> intel-pt-decoder.c at 0.00%; the TUI browser is in the list because the
> suite does not drive it.
> 
> 'perf test' exits 0 even when tests fail or time out, so the script
> takes its status from the "Failed tests :" and "Timed out tests :" lines
> that perf test prints since commit 33f20342ba525ef7 ("perf test: Add
> summary reporting").
> 
> 168 tests passed, 28 skipped, one failure (20.2: Tracepoint event), in
> code this series does not change.

Looks useful, thanks!

Namhyung

> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
