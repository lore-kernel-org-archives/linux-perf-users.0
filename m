Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602B1386DA;
	Thu, 29 May 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748551604; cv=none; b=lh66lg4XY8JZvKOG1llBIbhGkg2/3zKMq3qR+qR10YjQzOqXk50kN89Uz1J5IBdPOsDkS02qhZ11xk75L4CV7Evw4n4y6KAutumt19xpUzSFe5FTKrQ1oriR/KLJKoeei53losTPcbw9eca8nvtA4xw8dMcAxhEb7T0/Op6riw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748551604; c=relaxed/simple;
	bh=nqhtusXOAD2ESeOvweDuRBGoLYSqb/NiBJlRY1flv78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL0IaHxlfCeMHCAMQm3X69L7WzNKNZ+tl3ppnW77POXS2q/7RYxTNHLKGtONHRaysUSGp4Qy2jLaMeiQPFukjvKtZsMCJW9pHCEmRDFdm74J18ML9x7UUtnRuyuhlbkKi5UzZEXlzuU7xEyYD6wQVDHDvHKjkgICnA/sF1YVte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lxke7jHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lxke7jHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AF8C4CEE7;
	Thu, 29 May 2025 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748551603;
	bh=nqhtusXOAD2ESeOvweDuRBGoLYSqb/NiBJlRY1flv78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lxke7jHGpm4yTEelzwyCqQaIX27UmhKUUJef3W6qBcN65mL2Jc9phGQDQzp8DLHN1
	 a4yIgsBwpwiY8E5JQPtS9L0n2zCob4Ht/PjdITRmWShTBFZjqirJo1hXoQKHqwnXJt
	 1OCo49FwINd0k8OhfiCSn49iSn8TGMb5O7T0982p65eA4xVx2Giec9nbI/Ghq6aYtf
	 MH+9uPKWZnlyJKsh5Vs/c/ANXInc81QkFZhacqPV2BAujJl0qfYLBgma+CWJqPABtx
	 TZAeghZlz2PL8jJOZFVTKgynBuzW/4UzU0Zdt7INeKP4vg3lrAE5tnNxKZEAon/7TB
	 vE3Ay4oUY2txA==
Date: Thu, 29 May 2025 17:46:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Add cgroup summary test case for perf trace
Message-ID: <aDjHsJqV7L24qjvT@x1>
References: <20250522142551.1062417-1-namhyung@kernel.org>
 <CAH0uvoiZ2difXdPsjkdLikHTRwYROYUeuCdZ+gQ5uRfQ2rzwGQ@mail.gmail.com>
 <aC9VoTL_Cv4R7J-j@x1>
 <aC-hHTgArwlF_zu9@x1>
 <aDDy4FQe7sBwECL8@google.com>
 <CAH0uvog_5MToOmfcsEn3+hypPrftSvtQAe+Axe94TLNwgq4HbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvog_5MToOmfcsEn3+hypPrftSvtQAe+Axe94TLNwgq4HbA@mail.gmail.com>

On Wed, May 28, 2025 at 11:59:44PM -0700, Howard Chu wrote:
> On Fri, May 23, 2025 at 3:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Thu, May 22, 2025 at 07:11:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From 8c868979d886e2e88aa89f4e3d884e1b6450a7b2 Mon Sep 17 00:00:00 2001
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date: Thu, 22 May 2025 19:01:47 -0300
> > > Subject: [PATCH 1/1] perf tests trace_summary.sh: Run in exclusive mode

> > > And it is being successfull only when running alone, probably because
> > > there are some tests that add the vfs_getname probe that gets used by
> > > 'perf trace' and alter how it does syscall arg pathname resolution.

> > > This should be removed or made a fallback to the preferred BPF mode of
> > > getting syscall parameters, but till then, run this in exclusive mode.

> > > For reference, here are some of the tests that run close to this one:

> > >   127: perf record offcpu profiling tests                              : Ok
> > >   128: perf all PMU test                                               : Ok
> > >   129: perf stat --bpf-counters test                                   : Ok
> > >   130: Check Arm CoreSight trace data recording and synthesized samples: Skip
> > >   131: Check Arm CoreSight disassembly script completes without errors : Skip
> > >   132: Check Arm SPE trace data recording and synthesized samples      : Skip
> > >   133: Test data symbol                                                : Ok
> > >   134: Miscellaneous Intel PT testing                                  : Skip
> > >   135: test Intel TPEBS counting mode                                  : Skip
> > >   136: perf script task-analyzer tests                                 : Ok
> > >   137: Check open filename arg using perf trace + vfs_getname          : Ok
> > >   138: perf trace summary                                              : Ok

> > Looks good to me.

> > Acked-by: Namhyung Kim <namhyung@kernel.org>
 
> Nacked (sorry). I think running them tests in parallel is great
> because it points out a problem that perf trace has. Please check out
> this approach: https://lore.kernel.org/linux-perf-users/20250529065537.529937-1-howardchu95@gmail.com/T/#u

I'm not saying that perf trace shouldn't be used in parallel, but the
vfs_getname code, IIRC, checks for the existence of that probe to do
pathname collection (this predates the BPF method by a long time) and
then counts on it to do.

There are tests that put it in place and then at the end remove it,
multiple tests.

So there are possible races with that and out of being conservative I
made it exclusive for the time being.

The plan is to remove that vfs_getname code in builtin-trace.c and then
the tests, as we have the BPF method that is way better and should allow
for parallel use.

Probably in the meantime it would be better to mark the vfs_getname ones
as exclusive tho now that I that I wrote the above explanation... :-\

- Arnaldo
