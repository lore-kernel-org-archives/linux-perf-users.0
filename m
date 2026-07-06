Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4E1F8AC5;
	Mon,  6 Jul 2026 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381802; cv=none; b=Qu9bv+BfXZnn12ex9NAjFhYFme8+Pw3J7vsbynFsapBuK7kJjRV/8jvUJd7nmqknnbV6QXJl0JY60xZoXLw1Ilj8DLvgLS9twF8O9J6xrW07C2k2WOp5olYhoDuqimEbQg1VPmtxQw8b8uLm6WoU3roxhh+C6YlRCt/gioFAaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381802; c=relaxed/simple;
	bh=UIbb3PMvTnweiSXCB4gIohmA0wZj8xCTXpdRwJQ9RD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw8LVWHjTwCyu7er3f4CERNL5orTgMVj/tayRk6yCTuNRiRyqOm7riM5homsqSAnMXB2pQwqu7vvu1ssCqXWRFm+VW2ujMebx8rxgre8noy3WiQ4xWFry+o3Btcl6kLkeYEakBTQ3A6IO0+ANjJjg17hM+vHbDPrhTYj9feB3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neQa41pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neQa41pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD5C1F000E9;
	Mon,  6 Jul 2026 23:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381800;
	bh=CSkS9FUin1XV9xdRFFYHEuBCIBDmYkDvMbMOuUUjsV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=neQa41peGfKbwAfOCSotZykvA7uzSCIX/Mtz0xyQ/ubBeieSbs4HbxZSW3j7f8lMi
	 B7jh0Q2vOT2uHg+LOZtJpfU6MGAxvwcMPJ5cuWLX16MOJvPiZEgO77HuUuR9Zw7q5Z
	 eDkcdf60bBf5j0To5vc5Or38sBtb5udbk8vl7AnKmGgZ4ytKLpnEXBUhrnLIYA7njK
	 /eVgqk53Nv1NcPYAmkUFNpn9RolaqVHWuzgibnLDK09Ixh4WeL/a2ncjt1AsezIpjE
	 Ypg1yYCHkzTcYkg2KpQdFcoHCDUjPDzH94SoASAwmhE0YaQTiRxFuKtsUPQFQag3vF
	 aLC4BuKtI3WXQ==
Date: Mon, 6 Jul 2026 16:49:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v2 00/16] perf python: Fix python extension bugs from v19
 review
Message-ID: <akw_Jh9j1IKMA7rL@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <akk6yvqJuXWOrGUr@google.com>
 <CAP-5=fU4Q2zUQF1xKTdW_f6Z5eSpwQvRQCDtcVh6Z5BHXks4hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU4Q2zUQF1xKTdW_f6Z5eSpwQvRQCDtcVh6Z5BHXks4hQ@mail.gmail.com>

On Sat, Jul 04, 2026 at 04:03:18PM -0700, Ian Rogers wrote:
> On Sat, Jul 4, 2026 at 9:54 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, Jun 23, 2026 at 10:15:17PM -0700, Ian Rogers wrote:
> > > Phase 1 of splitting the v19 review patches into smaller fixes.
> > > These patches address issues identified in the python extension during
> > > the review of the v19 script porting series, as well as fixing several
> > > pre-existing bugs and leaks.
> > >
> > > v2:
> > > - Addressed sashiko review feedback:
> > >   - Fixed 64-bit casting for counts_values by using T_ULONGLONG and PyLong_FromUnsignedLongLong.
> > >   - Replaced strict Py_TYPE checks with PyObject_TypeCheck for thread/cpu maps.
> > >   - Fixed a missing CHECK_INITIALIZED for pyrf_thread__get_cpu, pyrf_pmu__name, pyrf_pmu__events.
> > >   - Included <string.h> where memset was used.
> > > - Fixed line splitting formatting on PyObject_New in pyrf_evsel__read.
> > > - Added fixes for memory leaks and issues discovered during review:
> > >   - Fix memory leak of key and value in pyrf__metrics_cb
> > >   - Fix count_values memory leak in pyrf_evsel__read
> > >   - Fix sb_evlist leaks in both top and record paths.
> > >   - Fix potential divide by zero in perf_event__synthesize_threads
> > >
> > > v1:
> > > - Decomposed the single large "Fix python extension bugs" patch into 13 individual fixes.
> > > - Added Fixes: tags for issues that date back to earlier commits.
> > > - Addressed checkpatch warnings (line lengths, Signed-off-by, etc).
> > >
> > >
> > > Ian Rogers (16):
> > >   perf script: Fix metric_evlist leak in script_find_metrics
> > >   perf stat: Fix evsel_list leak in cmd_stat
> > >   perf tools: Fix sb_evlist leaks in top and record
> > >   perf python: Fix memory leak in pyrf_evlist__get_pollfd
> > >   perf synthetic-events: Fix uninitialized pthread_join
> > >   perf data: Fix directory file descriptor leak in perf_data__switch
> > >   perf test: Fix skiplist leak in cmd_test
> > >   perf python: Check counts_values size in set_values
> > >   perf python: Validate CPU and thread maps in pyrf_evsel__open
> > >   perf python: Validate attribute setters in pyrf_evsel
> > >   perf python: Zero initialize perf_data in pyrf_data__init
> > >   perf python: Add thread and PMU uninitialized checks
> > >   perf python: Fix MetricGroup return type in perf.pyi
> > >   perf python: Fix count_values memory leak in pyrf_evsel__read
> > >   perf python: Fix memory leak in pyrf__metrics_cb
> > >   perf synthetic-events: Fix divide by zero in
> > >     perf_event__synthesize_threads
> >
> > Will you send v3?  You don't need to fix all pre-existing issues but we
> > should not introduce new bugs or regressions.  I think some of Sashiko
> > comments found them like data switch and pmu init checks.
> 
> Thanks Namhyung, I have a v3 coming. I'm working with Sashiko locally
> and trying to address as many issues as possible, including minor
> pre-existing ones—it's easier than remembering to clean them up later.

Sounds good.  Looking forward to v3.

Thanks,
Namhyung

