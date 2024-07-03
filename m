Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D813191F8E
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046001; cv=none; b=K155DerbOwN07pIighYbT2EXWLBFkjnihFV2dj1F7uoPeNUagJu/D2HBTYD3cdodqcyp8mTMv7symwHnFZ6KZa5TxW0eH2eda55fBBgnlcj2e4AzO6F0AXcTNMjMxYNdqZNjVWljWD0VylI4JUljqh8iNWRsoq4z9u/GvbMcJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046001; c=relaxed/simple;
	bh=gL+TcxP2yNE6+jrIdjk8pe9PCAT7FJALKGSgQfJyT00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spkIs1HisLwmjvbbAiu4IBqQgN4xfllgjyBVeqd8KXBlQm8SVcQQmNvoo92leWl6ceBM1eDNAtzIF3i6RYOtQkPAFKK7sHSpJPn0MU0dbEpzD4Ej9gDh18vipHuM0hmQlaz+I2XigLSVN0JvO+YAzVRw6c2C+1kcCqxq4BOtXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVAaqXE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVAaqXE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A44C2BD10;
	Wed,  3 Jul 2024 22:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720046001;
	bh=gL+TcxP2yNE6+jrIdjk8pe9PCAT7FJALKGSgQfJyT00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVAaqXE24cNnWYUlPt1nbdHU9akZdqozeVYBpA9+34/NjRtXdI1Az4bZmOD7Zo/TN
	 KIWmC3xAZ1h9Rdj+IwsthG5GK5r3omcZkIGTqzrhdi8e4e86XhhAyjnsxb7LN0hj5b
	 NBDyY1QntqG0CrqI47AeSRkT5VZpbCpeEdnMW2UVFHT+j0Mx1w5k2vQ5n34Cr+gHP1
	 pfL4OSuVoulnuOay10eKzVVgiZeLtJb7v48U7YtVlWntxMJjeonpUzFhJbv6lvzXpu
	 veuFUbGBFpaHISRl48LzG1s/XgLZiPQOggnL+hRSaUX+jIJYQ28wPOiKsWkRzkA0jW
	 +ygphjlMYi/xw==
Date: Wed, 3 Jul 2024 15:33:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	patchwork-lst@pengutronix.de, linux-perf-users@vger.kernel.org,
	kernel@pengutronix.de, Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf jevents: return potentially empty metrics table
Message-ID: <ZoXRr9wcE98ijyFA@google.com>
References: <20240531194414.1849270-1-l.stach@pengutronix.de>
 <8b31bc0823df42e1ef4c22eac159fa58694887c7.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b31bc0823df42e1ef4c22eac159fa58694887c7.camel@pengutronix.de>

Hello,

On Mon, Jul 01, 2024 at 07:19:55PM +0200, Lucas Stach wrote:
> Hi,
> 
> has this patch fallen through the cracks? It fixes a functional
> regression where the DDR controller metrics are completely unavailable
> on all i.MX8M* systems and thus would be nice if someone could have a
> look.
> 
> Regards,
> Lucas
> 
> Am Freitag, dem 31.05.2024 um 21:44 +0200 schrieb Lucas Stach:
> > Don't return NULL when a empty (num_pmus = 0) metrics table is encountered,
> > as this causes many of the users to bail out, which will skip matching any
> > potentially existing sys metrics later on. Instead return the empty table
> > which will be handled properly by the iterators and allows matching to
> > continue.
> > 
> > This fixes metrics reporting on systems where only the sys, but not the
> > core PMUs have metrics defined.
> > 
> > Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Looks ok to me.  Ian?

Thanks,
Namhyung


> > ---
> >  tools/perf/pmu-events/jevents.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index e42efc16723e..0a1ed9ee1429 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -1081,7 +1081,7 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
> >          if (!map)
> >                  return NULL;
> >  
> > -        if (!pmu)
> > +        if (!pmu || !map->metric_table.num_pmus)
> >                  return &map->metric_table;
> >  
> >          for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
> 
