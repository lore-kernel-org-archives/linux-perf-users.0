Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F61F585C;
	Fri, 23 May 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036019; cv=none; b=RyPHZi6tGCt00og1qKpLYjmrc4dFGapyr2OVCE+uA0fUl/ZXimVuoNuBiiZSdx5pedbc+Wc+ouTtfF2pP740iERGFBl/v+s0utlHmsTawGINR5EdN34D8tDQmDOgjy4b+zu3r0EpXvqwGfUGHu3Smh1jK+ZzWWQNwXN53RZRzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036019; c=relaxed/simple;
	bh=bgMBIwukVf/gTtf1D/w0CEf4p3yBeSktnbqXUSjKooE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNSryJ1I/gihTbh3+5EpyEGU1fCyRakw4uqNHVQO4A2kFMaJAYtnWEBYDmCbE2FIDuadaZQyWwbQJVxprADy3VLZecfyll213PYbkHiAsmSCgR5BxtG4zCLwkM1Xkpq9FDrLWWE7+JHysIH9clWYFK90QI9SVDJg5y+zZeNI2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlXvza7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlXvza7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF73C4CEE9;
	Fri, 23 May 2025 21:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748036018;
	bh=bgMBIwukVf/gTtf1D/w0CEf4p3yBeSktnbqXUSjKooE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HlXvza7qhwgXtXoz5XysoR494WNv950NXbEBSaXt1Iy3ida3O68jQfUiNyut/sU2b
	 C9hdjlwzXatiJHbLyxUkP5NlvLHHpjCJoLOXEv8jYypEOz4klg92fETElFIcsENn13
	 L3HzYoq4UFHmzRtjbr8bhSqHJOOVuP5pumWd/gN9B+YSn8SxKp5qxGSQ72ii9H0aR8
	 Juo3ZS5Ln32ZAjBIwIdkuoC8p8UJ9m+y7L/mA1bi5CK+6ScdNLbTllz/I65xzT7AI+
	 m5XXvJ0Izq0g3L61Urm7lmdPpYhXnsGjB4/aafbLPH50+d38ZtL1L9gmAkwtfYa9l2
	 eU/Ro5/OofhSw==
Date: Fri, 23 May 2025 14:33:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf test: Support arch-specific shell tests
Message-ID: <aDDpsC2sUQaC7LuZ@google.com>
References: <20250522171044.1075583-1-namhyung@kernel.org>
 <CAP-5=fXDaKueO9HE-Gr3Q7R6qm2EjwnL845nh7R2OU+DCfrhyA@mail.gmail.com>
 <4763aca8-a140-4291-b12e-e03cc0d82bdd@linaro.org>
 <CAP-5=fWUZ78s1DMzQV8SP0U8Hb=TnCwB1_t2_o+3UcoJeyi=0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWUZ78s1DMzQV8SP0U8Hb=TnCwB1_t2_o+3UcoJeyi=0Q@mail.gmail.com>

Hi Ian,

On Fri, May 23, 2025 at 10:54:02AM -0700, Ian Rogers wrote:
> On Fri, May 23, 2025 at 3:48 AM James Clark <james.clark@linaro.org> wrote:
> >
> > On 22/05/2025 9:09 pm, Ian Rogers wrote:
> > > On Thu, May 22, 2025 at 10:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >>
> > >> This is a preparation for shell tests belong to an arch.
> > >
> > > I keep repeating that I don't like arch and I think ideally we'd be
> > > getting rid of the C arch tests. I just sent out a patch doing this
> > > for 1 test:
> > > https://lore.kernel.org/lkml/20250521165317.713463-2-irogers@google.com/
> > > We should be able to make perf, tests, etc. dependent on a PMU rather
> > > than an architecture. This means that running perf built for ARM will
> > > be able to do things running on an instruction emulator on x86. It
> >
> > In this case for Arm SPE and Coresight you can only generate trace by
> > running on a full model or a real CPU, so I'm not sure if we could ever
> > get close to running on just an emulator.
> 
> Ok, that's the SPE and coresight PMUs, shouldn't the bulk of "perf
> test" pass under an emulator and those tests skip when the PMUs aren't
> there?
> 
> > > means the tool, the kernel APIs, etc. are generic and new
> > > architectures like RISC-V can test things. It means cross-platform
> > > (record on 1 machine type, report on another) can work without
> > > tripping over load bearing architecture ifdefs. It means that we
> >
> > I have thought about adding some generic decoding side tests for SPE and
> > Coresight, but couldn't really get past the fact that you need to put
> > the trace dump _and_ the binaries traced into the git repo. Not only
> > would this benefit testing on other arches like you say, but it would
> > also lock down that decoding of a known file doesn't regress which we
> > can't currently do by generating new trace every time the test runs.
> >
> > If we ever added this they would be separate tests though so they could
> > go in the top level folder, where the ones in the arch folder would
> > continue to do record and decode. Maybe naming the folders by PMU could
> > work, but you could also have both PMU name and arch name folders like:
> >
> > Recording/requires hardware:
> >
> >    tools/perf/arch/arm64/tests/shell/cs_etm/
> >
> > Cross platform decode tests:
> >
> >    tools/perf/tests/shell/cs_etm/
> >
> > Which would mirror how the source files are currently laid out:
> >
> >   tools/perf/arch/arm/util/cs-etm.c
> >   tools/perf/util/cs-etm.c
> 
> So this a digression, I don't necessarily disagree with it. Back to
> adding arch-specific shell tests, we should be working hard to not
> target work to a particular architecture. Making code, tests, etc.
> specific to an architecture means someone, quite often myself, has to
> come along later and undo the damage. Hybrid being a very large and
> long case in point where >1 core PMU was hard coded to only work
> within the tool for two specific PMUs. To be specific as to why
> notions of architecture in the code base are actively harmful (off the
> top of my head):
> 
> 1) architecture isn't a specific enough term as PMUs are always
> evolving so we need to support figuring this out, not just hiding the
> affected code by an ifdef or build option;
> 
> 2) lower and more problematic test coverage (will we shellcheck an ARM
> test on x86? we're lowering the container coverage or requiring it to
> be run on multiple architectures);
> 
> 3) the tests need to be able to handle being on the architecture with
> or without the PMU (such as under a hypervisor);
> 3.1) the without PMU case is a very frequent source of my patching
> tests as most people test on a bare metal development machines and
> forget continuous testing environments;
> 3.2) this kind of support can enable continuous testing efforts that
> are run under an emulator. If a cloud has no ARM offering they can at
> least emulator test, and SuSE have at least offered this. Google may
> or may not run testing through emulators and tests need to handle it,
> we have and do carry patches for this;
> 
> 4) broken cross-platform support, such as with sample parsing where
> decoding a sample is missing pieces when not done on x86 (come on,
> this is terrible and we don't want more of it);
> 
> 5) the tests do and should make use of common library code for things
> like checking the perf event permissions, this code lives in
> tools/perf/tests/shell/lib but the arch dependencies go where? We
> shouldn't reinvent the shell testing environment per architecture.
> 
> 
> I get that vendors would quite like things not to work on other
> architectures, or for event parsing [1], testing, etc. to be in some
> way crippled and require architecture specific reinvention. Why should
> their engineers invest in infrastructure and testing that could
> benefit someone else? Heck sometimes it feels like vendors may be
> doing everything in their power via broken PMU names, event names,
> etc. to make common infrastructure break when not run in their arch
> specific way [2]? I see things differently and indeed when things go
> wrong vendors argue that the generic code/behaviors needs to be
> changed (I'm thinking of Mark Rutland on Apple PMU support and the
> generic behavior changes made at that time that are now not carried
> through leading to event parsing and display inconsistencies as well
> as RISC-V needing to adopt a different event lookup strategy).
> 
> I want the perf tool to have its behavior be generic. The kernel has
> an arch directory for understandable reasons, for the perf tool the
> key thing is the PMU and we've been building out the infrastructure
> for this. Should the perf tool have every event, metric or syscall
> number for every architecture? For cross-platform work it doesn't seem
> like a completely terrible idea. I'm sensitive to binary size [3] so
> I'm not pushing on it.
> 
> Anyway, this change is unnecessary as the current skipping behavior
> works and is better for the reasons enumerated above. This change gets
> a very large nack from me. I'm supportive of more IBS coverage in the
> rest of the series, but this change isn't required for that.

Thanks for the review.  I understand your concern and it'd be nice to
increase the cross-platform coverage.  I don't know if AMD IBS is
available in an emulator but it should be fine to have this test in the
generic place.

Thanks,
Namhyung

> 
> [1] https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/drivers/perf/arm_cspmu/arm_cspmu.c?h=perf-tools-next#n150
> - please call it cpu_cycles to avoid ambiguity with the legacy event.
> [3] https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/
> 
> 
> 
> > Thanks
> > James
> >
> > > benefit from more testing on generic pieces of code on all
> > > architectures - like sample parsing. We can always strcmp the PMU name
> > > or the architecture at runtime.
> > >
> > > Structure wise we could have:
> > > tools/perf/pmu/ibs_op/tests/
> > > tools/perf/pmu/ibs_op/tests/shell
> > >
> > > It feels noisy compared to just having the shell test in
> > > tools/perf/tests/shell skip when the PMU isn't present. There are also
> > > things like library dependencies that aren't clear when we have >1
> > > directory. I'd prefer if new testing followed the existing model
> > > rather than this.
> > >
> > > Thanks,
> > > Ian
> > >
