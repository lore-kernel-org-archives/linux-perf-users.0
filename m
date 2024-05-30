Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F917545;
	Thu, 30 May 2024 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109504; cv=none; b=fC4mXrFz8CeaN2j99sH8DcHcITBxk+7jMlfe0g7JggS70ZqHGN9n6FKeojV3MGVWpoOSJgLjefse+6PS1sTTqej4gZX38uuuEN+oib0+cuEzzoxw99EK1T7kr59zbBp5OrXJ68kU8fM/R5cHImSTOwi5GCDe4nJ/rapOclb+yj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109504; c=relaxed/simple;
	bh=5MoWl4cipWj3Mhd5Zbuh2px9BzjUnrX11GBXlLvgsmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcOhjvpqYTicO5lief0qIYU9HADcRT1WQSdWsuqkzAdF44Mv630bXMeKZCLnn1U222wjPKDQSVjNNNA5XhHIqc/91NCZT2B1i7oYle1bnqjhKrAGiBoYfD1TXXfpt0nUDBnHV0yMTT8+gXOAPQioV5PURCWtpzqevrIDsubL/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgYQwgTy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgYQwgTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B28C2BBFC;
	Thu, 30 May 2024 22:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717109503;
	bh=5MoWl4cipWj3Mhd5Zbuh2px9BzjUnrX11GBXlLvgsmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgYQwgTypAE74OdO5a0czXJg104IC0qvO9oLl1T2ZxImVjilcK1+s8y5VeAkYckma
	 tJvMTHSz13ON7ML0J9a/RodSEXCDKzw0h6bN0+oo5s/LHStwQHfUMvgDDuO/RBdD97
	 gw0wjcJGeQbswSykt8xId4b/JuN2N1BwYz1DXK4TkYK96xP3AssqNGcwppiO/mWrA2
	 46Nzov5rzhkeKrUQkAs3A4QnJ3Zo4esh/eSgXE9Tax6NNi/BIYg8fGFwoWD+dTn1ga
	 /5FlVgSH8G0nSu9q+G/Cw++BOVesx0Mdg73TFOnhBjdh+GxsFcnmoaW9mGgiixt7Ss
	 9wfLcUP0Nebfg==
Date: Thu, 30 May 2024 15:51:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <ZlkC_Tm6kKIL3Phc@google.com>
References: <20240527105842.GB33806@debian-dev>
 <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1>
 <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com>
 <Zld3dlJHjFMFG02v@x1>
 <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
 <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com>
 <aee9254e-81c1-464a-8a28-f971615baffc@arm.com>
 <CAP-5=fVynt-8cH6Jc5VyfBLBOqkF+v_7kknHdUPZBM1r3WwhTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVynt-8cH6Jc5VyfBLBOqkF+v_7kknHdUPZBM1r3WwhTQ@mail.gmail.com>

On Thu, May 30, 2024 at 06:46:08AM -0700, Ian Rogers wrote:
> On Thu, May 30, 2024 at 5:48 AM James Clark <james.clark@arm.com> wrote:
> >
> > On 30/05/2024 06:35, Namhyung Kim wrote:
> > > On Wed, May 29, 2024 at 12:25 PM Ian Rogers <irogers@google.com> wrote:
> > >> We can fix the arm_dsu bug by renaming cycles there. If that's too
> > >> hard to land, clearing up ambiguity by adding a PMU name has always
> > >> been the way to do this. My preference for v6.10 is revert the revert,
> > >> then add either a rename of the arm_dsu event and/or the change here.
> > >>
> > >> We can make perf record tolerant and ignore opening events on PMUs
> > >> that don't support sampling, but I think it is too big a thing to do
> > >> for v6.10.
> > >
> > > How about adding a flag to parse_event_option_args so that we
> > > can check if it's for sampling events.  And then we might skip
> > > uncore PMUs easily (assuming arm_dsu PMU is uncore).
> >
> > It's uncore yes.
> >
> > Couldn't we theoretically have a core PMU that still doesn't support
> > sampling though? And then we'd end up in the same situation. Attempting
> > to open the event is the only sure way of knowing, rather than trying to
> > guess with some heuristic in userspace?
> >
> > Maybe a bit too hypothetical but still worth considering.

Then I think it's a real problem and perf should report it like we do
now.

> >
> > >
> > > It might not be a perfect solution but it could be a simple one.
> > > Ideally I think it'd be nice if the kernel exports more information
> > > about the PMUs like sampling and exclude capabilities.
> > > > Thanks,
> > > Namhyung
> >
> > That seems like a much better suggestion. Especially with the ever
> > expanding retry/fallback mechanism that can never really take into
> > account every combination of event attributes that can fail.
> 
> I think this approach can work but we may break PMUs.
> 
> Rather than use `is_core` on `struct pmu` we could have say a
> `supports_sampling` and we pass to parse_events an option to exclude
> any PMU that doesn't have that flag. Now obviously more than just core
> PMUs support sampling. All software PMUs, tracepoints, probes. We have
> an imprecise list of these in perf_pmu__is_software. So we can set
> supports_sampling for perf_pmu__is_software and is_core.

Yep, we can do that if the kernel provides the info.  But before that
I think it's practical to skip uncore PMUs and hope other PMUs don't
have event aliases clashing with the legacy names. :)

> 
> I think the problem comes for things like the AMD IBS PMUs, intel_bts
> and intel_pt. Often these only support sampling but aren't core. There
> may be IBM S390 PMUs or other vendor PMUs that are similar. If we can
> make a list of all these PMU names then we can use that to set
> supports_sampling and not break event parsing for these PMUs.
> 
> The name list sounds somewhat impractical, let's say we lazily compute
> the supports_sampling on a PMU. We need the sampling equivalent of
> is_event_supported:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/print-events.c?h=perf-tools-next#n242
> is_event_supported has had bugs, look at the exclude_guest workaround
> for Apple PMUs. It also isn't clear to me how we choose the event
> config that we're going to probe to determine whether sampling works.
> The perf_event_open may reject the test because of a bad config and
> not because sampling isn't supported.
> 
> So I think we can make the approach work if we had either:
> 1) a list of PMUs that support sampling,
> 2) a reliable "is_sampling_supported" test.
> 
> I'm not sure of the advantages of doing (2) rather than just creating
> the set of evsels and ignoring those that fail to open. Ignoring
> evsels that fail to open seems more unlikely to break anything as the
> user is giving the events/config values for the PMUs they care about.

Yep, that's also possible.  I'm ok if you want to go that direction.

Thanks,
Namhyung
