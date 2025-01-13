Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB91C5D4F;
	Mon, 13 Jan 2025 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782636; cv=none; b=FAcEks8z5Ix3SvKQG2TOAGTcG3znhPBD6QQ5iAxMggbfdWIiLMTgBJ6Uz4fDPhrMbwzEEdMRG6QeLuQc1bm9Hz2eFyN7jSL5CtGQy7A4HhnQEGrkj41q+X4fTrWKIZZIcWEMnINMbVCdEKLbCoUTdkoTfmzQwuTlr8mW5UrWhT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782636; c=relaxed/simple;
	bh=ZXAsfbawoRDnAXm/V6CDLQmyBPBoz1oMrkVfhGmcm6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbizBZqDHmrabNmzZYbY8SzGqw0B7g5kDF2a05X1JjjZEls5N4Y2NAPrdIl6zHmVW7PQ6EQOr3EPE68g87D/oj1KbNLsabHo/ohmde0SDGLOWe1M1dlIHYIXyhOlNAoySoCRIb/Oe3yVgDVlq8DtCYMMtiC1i2EhLx8kcm7hLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDPPL1oT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDPPL1oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD72C4CEE2;
	Mon, 13 Jan 2025 15:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782635;
	bh=ZXAsfbawoRDnAXm/V6CDLQmyBPBoz1oMrkVfhGmcm6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDPPL1oTugQIh6qIuAN3ICU4XQWwcisIijMGeNYoKGfQYgbgpHBZ54QMyjA4U5Pzj
	 2htC6vG6vpzn72q266X+b6Nh5yQVjFRcC5cqy0c6PRVO5yNR0mwrX0O2UozGxpSHH+
	 IG7J59usYPhXH0lEfNJikQB3LSN3bajXBvuZVWRrhvURpE39BUWD3dr43xqo/2sfJ+
	 xr0qq8zfL64yn7IcJRhVtXnHF1XSkYKhFwu3G8CTNO9Af3ruy+fV9ywKoZegcpAeTN
	 DZDJ2BCkp2X9uxZN07L9Cs/OIxC+EW8pUHKRGFmt+Wye/z98EphuRRJ2ch9c3Mvdet
	 Ap7Erap92O0tA==
Date: Mon, 13 Jan 2025 12:37:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test stat: Avoid hybrid assumption when
 virtualized
Message-ID: <Z4UzKQTLpgyuQYZg@x1>
References: <20241212173354.9860-1-irogers@google.com>
 <Z1uQWmq3KAQx1tA3@google.com>
 <CAP-5=fU+PSGyrB9HUYS3XECRdZHqU57xAOgKvyUyE90DpiUDVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU+PSGyrB9HUYS3XECRdZHqU57xAOgKvyUyE90DpiUDVA@mail.gmail.com>

On Thu, Dec 12, 2024 at 07:31:04PM -0800, Ian Rogers wrote:
> On Thu, Dec 12, 2024 at 5:39 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Thu, Dec 12, 2024 at 09:33:54AM -0800, Ian Rogers wrote:
> > > The cycles event will fallback to task-clock in the hybrid test when
> > > running virtualized. Change the test to not fail for this.

> > > Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")

> > I cannot find this commit.
 
> Sorry, should have been:
> Fixes: 65d11821910b ("perf test: Add a test for default perf stat command")

Thanks, applied to perf-tools-next, there was a minimal fuzz but I fixed
it up:

⬢ [acme@toolbox perf-tools-next]$ patch -p1 < ./v2_20241212_irogers_perf_test_stat_avoid_hybrid_assumption_when_virtualized.mbx
patching file tools/perf/tests/shell/stat.sh
Hunk #1 succeeded at 187 with fuzz 2 (offset 24 lines).

- Arnaldo
 
> Thanks,
> Ian
> 
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Other than that,
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
> >
> > > ---
> > >  tools/perf/tests/shell/stat.sh | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> > > index 5a2ca2bcf94d..da42427bb077 100755
> > > --- a/tools/perf/tests/shell/stat.sh
> > > +++ b/tools/perf/tests/shell/stat.sh
> > > @@ -163,7 +163,11 @@ test_hybrid() {
> > >    # Run default Perf stat
> > >    cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles  " | wc -l)
> > >
> > > -  if [ "$pmus" -ne "$cycles_events" ]
> > > +  # The expectation is that default output will have a cycles events on each
> > > +  # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
> > > +  # can fall back to task-clock and so the end count may be 0. Fail if neither
> > > +  # condition holds.
> > > +  if [ "$pmus" -ne "$cycles_events" ] && [ "0" -ne "$cycles_events" ]
> > >    then
> > >      echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
> > >      err=1
> > > --
> > > 2.47.1.613.gc27f4b7a9f-goog
> > >
