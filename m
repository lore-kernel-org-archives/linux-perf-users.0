Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F013E048;
	Thu,  6 Jun 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681626; cv=none; b=RPgoEn/wH+kyfenrMFkF4hAK0Zw5i2MYUvU98W9uZCBO/zYKC8mnAwAR/MJnb0WBB7RAddXJpwnUOoqPX5bOYJ3EdaB5xGsHdlTz/CnJYpA8BGYfEratlBDcVqFdCp8kU2UQoOu5eEz6UsiRo3lC+Av+7MlOOc3HbCq1jJdrHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681626; c=relaxed/simple;
	bh=HKbs6KEJJv7rnYC3V1+3YTC08XWD0qNNBYHnC3DJ9pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubi0kMF5M9sPNkPLLkrqbyZ92JbarCePa+XzE4+y1cB38yyqZTjXRqMIhKn3N/DBnIhN0OtnXUQC+ZqlRo6f4TtF1SenK75dV6tqF4EAueOUadh9mTSxN4LeXCyQNAoDUIXkyvu4Kvk63oiV2SuwmjdIsBE/XfbllUHTKBM8MqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfGgTXTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfGgTXTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54F9C2BD10;
	Thu,  6 Jun 2024 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717681625;
	bh=HKbs6KEJJv7rnYC3V1+3YTC08XWD0qNNBYHnC3DJ9pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfGgTXTtPV8T7/S3RnEiAb8n2+b7IZ+cceY2/+q8O5Et6XzQBkTH0fKkVBug1lLzv
	 /DlpWZ0ircGd2Q7nAD5SUyGSaafIXXFH5fCUWiubXNsbtHC2bDNo9clXgRX7Zt5Ky4
	 DD2Lt5seTBlepcQkreZ42GPIS7OKhO4q+xNEyCGDoEKCDAOn6hVBy/ZHBEeqLbL2p7
	 3G2kCyDHFOdh8/UGZNyZL3SfG2k375yMaZNTR6+Ch1+uk1AWoQ/m1hqLqJN6yenS7y
	 ulkXFz2P7ncO+ppY4jJfivcYzoBri5Fn0AOFd4/slmcmRPgj1OnwuX5kK2OaOCacd/
	 qqMNEDnIx4QHg==
Date: Thu, 6 Jun 2024 10:47:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core
 PMUs
Message-ID: <ZmG91mG32AKViIbh@x1>
References: <ZlY0F_lmB37g10OK@x1>
 <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com>
 <Zld3dlJHjFMFG02v@x1>
 <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
 <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com>
 <aee9254e-81c1-464a-8a28-f971615baffc@arm.com>
 <CAP-5=fVynt-8cH6Jc5VyfBLBOqkF+v_7kknHdUPZBM1r3WwhTQ@mail.gmail.com>
 <ZlkC_Tm6kKIL3Phc@google.com>
 <CAM9d7ciTbHngfimDNsXS_adR7xg4ZHvSHzVhAzuQ6o-nQ2nsMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciTbHngfimDNsXS_adR7xg4ZHvSHzVhAzuQ6o-nQ2nsMQ@mail.gmail.com>

On Wed, Jun 05, 2024 at 01:29:02PM -0700, Namhyung Kim wrote:
> On Thu, May 30, 2024 at 3:52 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Thu, May 30, 2024 at 06:46:08AM -0700, Ian Rogers wrote:
> > > On Thu, May 30, 2024 at 5:48 AM James Clark <james.clark@arm.com> wrote:
> > > > On 30/05/2024 06:35, Namhyung Kim wrote:
> > > > > It might not be a perfect solution but it could be a simple one.
> > > > > Ideally I think it'd be nice if the kernel exports more information
> > > > > about the PMUs like sampling and exclude capabilities.

> > > > That seems like a much better suggestion. Especially with the ever
> > > > expanding retry/fallback mechanism that can never really take into
> > > > account every combination of event attributes that can fail.

> > > I think this approach can work but we may break PMUs.

> > > Rather than use `is_core` on `struct pmu` we could have say a
> > > `supports_sampling` and we pass to parse_events an option to exclude
> > > any PMU that doesn't have that flag. Now obviously more than just core
> > > PMUs support sampling. All software PMUs, tracepoints, probes. We have
> > > an imprecise list of these in perf_pmu__is_software. So we can set
> > > supports_sampling for perf_pmu__is_software and is_core.

> > Yep, we can do that if the kernel provides the info.  But before that
> > I think it's practical to skip uncore PMUs and hope other PMUs don't
> > have event aliases clashing with the legacy names. :)

> > > I think the problem comes for things like the AMD IBS PMUs, intel_bts
> > > and intel_pt. Often these only support sampling but aren't core. There
> > > may be IBM S390 PMUs or other vendor PMUs that are similar. If we can
> > > make a list of all these PMU names then we can use that to set
> > > supports_sampling and not break event parsing for these PMUs.

> > > The name list sounds somewhat impractical, let's say we lazily compute
> > > the supports_sampling on a PMU. We need the sampling equivalent of
> > > is_event_supported:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/print-events.c?h=perf-tools-next#n242
> > > is_event_supported has had bugs, look at the exclude_guest workaround
> > > for Apple PMUs. It also isn't clear to me how we choose the event
> > > config that we're going to probe to determine whether sampling works.
> > > The perf_event_open may reject the test because of a bad config and
> > > not because sampling isn't supported.

> > > So I think we can make the approach work if we had either:
> > > 1) a list of PMUs that support sampling,
> > > 2) a reliable "is_sampling_supported" test.

> > > I'm not sure of the advantages of doing (2) rather than just creating
> > > the set of evsels and ignoring those that fail to open. Ignoring
> > > evsels that fail to open seems more unlikely to break anything as the
> > > user is giving the events/config values for the PMUs they care about.

> > Yep, that's also possible.  I'm ok if you want to go that direction.
 
> Hmm.. I thought about this again.  But it can be a problem if we ignore
> any failures as it can be a real error due to other reason - e.g. not
> supported configuration or other user mistakes.

Well, we should not ignore any failures, just look at
evsel__open_strerror(), we get some error from the kernel, we know we're
doing something, we put it into context, and then we try to provide the
most helpful message to the user.

The question here is how to figure out if what we want to do (sample)
makes sense for this event that has the name we used, since we're using
a "wildcard", a "well known event name" that should be translated to
events in all PMUs where it "matches", if those actual per-PMU events
can provide what the user is asking.

My suggestion about using pr_debug() is a compromise, one that will not
show warnings all the time for such a common case (cycles) while
allowing the use to follow a common, in tools/perf, way of diagnosing
when things don't look sane, which is to ask for verbose mode.

The best thing would be for us to be able to query, using existing
facilities, if what we want is possible, i.e. interpret the error coming
from the kernel in the context of what we are asking.

If this is not possible because the error is too generic (EINVAL) and
can map to multiple other things, then we can try to have a new kernel
facility for us to get this info in a authoritative way and use a
pr_warning() knowing that that warning will go away as the kernel is
updated.

Or we could use a big hammer, special handling some PMUs/events we know
can't sample and avoiding those when they fail, ugly, but should work,
and this is just for this "well known event names" people have been
using since forever. Those wanting specific events to be used should
know better and specify it precisely in the command line.

Does this sum up all the discussion so far?

Cheers,

- Arnaldo
