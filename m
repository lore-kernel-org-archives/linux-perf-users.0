Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C60241665;
	Tue, 24 Mar 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350058; cv=none; b=lw6Yx4YSIdBFUbPLckR8Jj85QC3wsEvzmGtJVtsW1B7FLMbSo03fzqCffwHwps6vB/aBc+7GMET0oTDrDun5IiLqv8M4rNBo44ws8wVwvxXBWs1hFh13kpEkEkviP9HV7L74xnxU1N5TeHllBqwM2kNl7V2SY3ESAX4TYG3LhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350058; c=relaxed/simple;
	bh=Oe3Vg3S8mxT/p5JmSF1aIUNvorHkMrnMplNiCvjDkH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i32AZnnJxLe/vw15k74jTkc5QfqXF/QkuCdNEDchwW9bBqnst3PfnwGkaDBnLF7BuSDRT90jKrC44U4DaalNRp2ojPHiDh1Jk5n8ZD6XtjQdFqV4WZ+DgzYBSZwvsgFLz816JeK9YP9zTr5qPC4euoisyEMDScfTWVYdEPre75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=as9Vd4Km; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="as9Vd4Km"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=qbZ8j6xqh7ypw+ZPOVxuDTv3AEc31FwYpRu4/UHR7dM=; b=as9Vd4KmuiiFNY6u4zt9Wcqy2Z
	eDX/mlwY4qvo4guQ0tx8/OyXDQI0Tpo6/BARh0odFFMxMPZV7GUUqf2KaptTDF4UXWVSToAq+nJjz
	4hLQ7C+APM+jrpAF17JQcfGN6M7fUzv2EGwdpshGtSPTggxLZnonbtXjjUVCkcqixFrkJSQvZViWV
	1H8nVgIXDSP/kta2mIbzfdua2QThcs2yEX4FWRLCeN4T9sl6sEdfM2vYc42wW/GN2GLcrPMhb/S0d
	PFK0jReHCdKLhcbLI9gbEq3g6iNa5kJLviUAPLjiWBfL4BXcqCumMC7frHxmY5pL0OwIbgKZ7R1pe
	tg/Y46lA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w4zUy-008FwT-09; Tue, 24 Mar 2026 11:00:34 +0000
Date: Tue, 24 Mar 2026 04:00:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, acme@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Denis Yaroshevskiy <dyaroshev@meta.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
Message-ID: <acJufmWMuzD9Jzcr@gmail.com>
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
 <20260205173918.GB3529712@e132581.arm.com>
 <20260205175250.GC3529712@e132581.arm.com>
 <CAP-5=fUY8dYzwKu-g3-HER4ji9ZeGmPQo9DeORW0w9ocW1qnMw@mail.gmail.com>
 <abFBoVrlGl9cIg1h@gmail.com>
 <20260311115011.GJ4153946@e132581.arm.com>
 <CAP-5=fWRgDo7UnJAD4C--d=mVPRhOEWZVyU7nVM1YEp3jncAgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWRgDo7UnJAD4C--d=mVPRhOEWZVyU7nVM1YEp3jncAgg@mail.gmail.com>
X-Debian-User: leitao

On Mon, Mar 23, 2026 at 10:06:37AM -0700, Ian Rogers wrote:
> On Wed, Mar 11, 2026 at 4:50 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Hi Breno,
> >
> > On Wed, Mar 11, 2026 at 03:21:00AM -0700, Breno Leitao wrote:
> > > On Thu, Feb 05, 2026 at 10:22:27AM -0800, Ian Rogers wrote:
> > > > I think it is a different issue, they have metrics while you don't.
> > > > Your report does highlight we're missing a NO_JEVENTS=1 build-test,
> > > > but the build is working for me. I'll send out two patches for these
> > > > issues.
> > >
> > > Hi Ian, Leo, Acme
> > >
> > > I wanted to follow up on this. Are there any next steps I should take?
> >
> > Sorry for not tracking this issue.
> >
> > I can reproduce the issue on my Orion6 with setting a _dummy_ CPUID:
> >
> >  $ export PERF_CPUID=0x00000000410fd490
> >  $ perf stat -C 5 -vvv
> >  ...
> >  Aborted
> >  perf: util/evsel.c:2156: get_group_fd: Assertion `!(!leader->core.fd)' failed
> >
> > Because we are working on different hardwares, I am a bit suspect I
> > reproduced the issue with difference sequence as yours.  Anyway, I do
> > see that an event can be opened prior to its leader event, see the log
> > below.
> >
> > Thus, your patch seems make sense to me as we need to ensure the leader
> > event to be opened first.  Ian, how about you think?
> 
> Because so many things depend on the event ordering, the patch makes
> me very nervous, particularly how it will change architectural
> requirement handling. Ordering the Intel slots and metric events is a
> challenge. There is also how handling uncore events, which are
> deliberately parsed out-of-order, will change. I've got a feeling the
> test coverage for this isn't adequate, and finding the bugs requires
> running on particular machines. It will also require examining the
> default perf stat output to ensure this isn't broken; hopefully the
> code is somewhat robust.

Sure thing. please let me know if there is any action on my side, and
I am happy to help.

> Ideally, the impact of the change on all these issues would be in the
> commit message, but it's more realistic to cover each issue with
> testing. I'll try to ask an AI buddy to help with this. Could you
> rebase and send a v2? I'm curious to see what sashiko will throw up.

Ack. I will resping it, so, we can check what sashiko thinks about it.

Thanks,
--breno
