Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB22DB785
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768709; cv=none; b=SiHS9ugCS4dCfhJD/l037QhfZMOYoDHSnMZpFz8Sbn1AFae7613zUqBiMwTh09TcLGpezKezbocap1sbEDrWt5oONbBBexwLjOY97lVE/2HzfZNNKAmUtAwLiYyq08pmx28XgMaofft0nez9f34xSbuhg12HPMAiOMl2YMkIAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768709; c=relaxed/simple;
	bh=M6QBx1XSEdVBGBrlYMFqtZsI14YlI15FTNOYpEH57tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7gSBWfMSpKqRgGiI+2hd/YPhwKixuL4TRacV8DaR7oaZkr0c4qwkbrPZLNeeQRYGdtbhH0JHhzmUXNiw/g7sZaGzz8qF+PRIJoqGOaxPJEnVGi7sYcy9B2cFw3yANhb8jQY+KS6AOI9bkXCeVKJ9wuu6pSHoAwcKUsW13KZO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wctv0G7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wctv0G7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497541F000FF;
	Fri, 18 Sep 2026 21:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789768707;
	bh=prXTZCtX9ucf/fG+VwMWDv0pLsk9zjZc3XDCMDf7mb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wctv0G7RPEp06A3PiNa6aXKQzydMQ9ecPk4ID+6JiCRFeoZzglb+sjq3wnDcGH/oy
	 Bh50cYL0GU2VqOklFlkOW1bxJiYMhQ3dhQ0oC+/AFxfMxa+Q9K7ne9OkEv3dkjb3/o
	 SR0DCeTDYvOSIZYio+/jgbu8VM3yZq9uDW1QceDEfojWKdwAzB3fJNc7LA20eJpX0o
	 JUAAF091aCF9y3hKHtZOrc7Dsegdnb6WLEomMHaKjre8GG1wxkKABDYityvKttULT9
	 27zZws4b859W84fOhalFuE0Kt0/6RqOo1qg4Sk8usposqt4jy5vnLPU40/l12ITaks
	 BB71WceLxjMkA==
Date: Fri, 18 Sep 2026 18:58:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, ak@kernel.org, ak@linux.intel.com,
	andi@firstfloor.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 0/9] perf report/top: Add opt-in --hybrid-merge
Message-ID: <aq20APrOz60O4n8B@x2>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <aq2hq_Fw6fn0rGkm@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aq2hq_Fw6fn0rGkm@x2>

On Fri, Sep 18, 2026 at 05:40:15PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 16, 2026 at 10:06:59PM -0700, Ian Rogers wrote:
> > On a hybrid machine a wildcard event expands to one event per core
> > PMU, so "perf record -e cycles" records cpu_core/cycles/ and
> > cpu_atom/cycles/. perf report and perf top then show one histogram per
> > PMU, and a symbol that ran on both kinds of core is split across them,
> > with each percentage relative to its own PMU's total. There is no way
> > to ask for the single combined profile.
> > 
> > Add --hybrid-merge to perf report and perf top, which merges the
> > histograms of the events that came from the same wildcard into one,
> > with percentages taken against the summed period.
> > 
> > Merging is opt-in because it isn't always the right thing to do. The
> > cores differ in performance, so a merged cycles count mixes work done
> > at different rates and a merged IPC is not the IPC of either core
> > type. perf-tips notes this. When merging is possible but wasn't asked
> > for, the TUI says so, rather than merging silently.
> > 
> > core.hybrid-merge in .perfconfig turns it on by default. As a default
> > rather than an explicit request it yields to the command line: with
> > --hierarchy it is ignored with a warning, whereas asking for both
> > --hierarchy and --hybrid-merge on the command line is an error. For
> > the same reason it is silent when there is nothing to merge, so it
> > doesn't warn on every invocation on a machine with a single core PMU.
> > 
> > perf stat is deliberately untouched. Counting already has its own
> > merging options, and this is aimed at sampling.
> > 
> > The events to merge are found with first_wildcard_match, which parsing
> > fills in. perf report reads events from a file rather than parsing
> > them, so there the wildcard grouping is recovered by matching event
> > names, and core PMUs are identified from the perf.data header topology
> > so that a file recorded on another machine is read correctly.
> 
> Thanks, applied to perf-tools-next, for v7.4.

I tried 'perf top --hybrid-merge" on this machine:

acme@x2:~/git/perf-tools-next$ grep -m1 "model name" /proc/cpuinfo
model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
acme@x2:~/git/perf-tools-next$

That is hybrid and it didn't merge anything, just told me that:

                       ┌─Warning:──────────────────────────────────────────┐
                       │--hybrid-merge: no events to merge across core PMUs│
                       │                                                   │
                       │                                                   │
                       │Press any key...                                   │
                       └───────────────────────────────────────────────────┘

What am I missing?

I merged this, so we can continue from there,

- Arnaldo

