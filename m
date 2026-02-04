Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272F395242;
	Wed,  4 Feb 2026 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240892; cv=none; b=HEEUGIQVwt7U01isEAh/0mLQLrzzepYHpsxrSpTDHdfm0zBN5bgPrJ28uilup2ifKLfBU2mBQUVh5elDG4xOhLJ5Ek+B6LsgriAjNXezuy4Nc81Ng+aAw++Edv4JhUeOr3TYH5UO5rIsTuXOcsV80ftSWTHEUr2AGfdSgpkhato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240892; c=relaxed/simple;
	bh=WnWbssPFaTENG/BjJfogbLUUlFgdyizRFHyJf/4pmNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMGTxjSZxP3MHGk1/MENIypCc6OhsRksTW4APGSYna8HEe7JFmSpSTtZ9Cxdmfq+X8PafBYqcormOlHvGxITH7zjvy2N5AVriLFFW6VPpmB62ir0bYTMSmW4LqIoSQBHKQOjNiL/M/sLSPEWw+By/Sx3PW5ZgYVomTP/Osa/svc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4xZhFzf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4xZhFzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC22C4CEF7;
	Wed,  4 Feb 2026 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770240892;
	bh=WnWbssPFaTENG/BjJfogbLUUlFgdyizRFHyJf/4pmNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4xZhFzf4xZVxXrTtmmoq45DViznUD07i8JfvNQtpv31uBS/Ae4xsf4iB9L05Cr/y
	 NkRWIcZJxOZAvDkgpJ7gEo37U5LuE8RZWeBhFFUdB1JyOL+ToKlGzPmtS7ZmC04fOh
	 599Zhs6XpA0PuCsqx2FHuXaFuwbsyaErj3VT2/JolVWLYRM65cIz9E3s6nVAwPZCEc
	 NvPrNcwSbrNPzo0zOTmG1dqklHzk5p5fFWtwO1M8JN2KIAi4clqXN0UTZHLAqK0tIk
	 gTF/KxvsR0WuJOwaqfBo8+tg0yjJCRqFHLyUXBFrL+X1X+6V3WzM+m8uVQ8RjmKuLE
	 /uYUhxJbYpksQ==
Date: Wed, 4 Feb 2026 13:34:49 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	"Chen, Zide" <zide.chen@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: Re: [PATCH V2 11/13] perf pmu: Relax uncore wildcard matching to
 allow numeric suffix
Message-ID: <aYO7eSe1bpQIOktr@google.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-12-zide.chen@intel.com>
 <CAP-5=fVO+dSstWmYiTvu7o66hahiUKig4r=FEfu+FvUN8+nvcg@mail.gmail.com>
 <12dbc1f5-022d-4653-8ac7-01c503a860dd@linux.intel.com>
 <CAP-5=fXnMgwoa=VF2oK6D_rXvEOLCyq2PHkXoyN42KOgaWBTgQ@mail.gmail.com>
 <CAP-5=fVVZbb0qSDw+geqbb2m0rtb4gS3xSgO-iK6hJp-R2MWLQ@mail.gmail.com>
 <d8b6e506-a235-4d50-b223-bf979247c4ca@intel.com>
 <f39e1250-228b-406e-95c2-1a30897dbd0d@linux.intel.com>
 <CAP-5=fW5PHB-5DmY-rh+BbP2JEH+0Z+=tdoe_iZW_TVNQnUbwg@mail.gmail.com>
 <CAP-5=fWofHz9fq=RLo90G_FQ2sjn4RyBp10d=wTOvJhxdvc_wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWofHz9fq=RLo90G_FQ2sjn4RyBp10d=wTOvJhxdvc_wQ@mail.gmail.com>

Hi Peter and Ingo,

On Tue, Feb 03, 2026 at 03:33:07PM -0800, Ian Rogers wrote:
> On Wed, Jan 21, 2026 at 11:10 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Jan 21, 2026 at 6:10 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
> > >
> > >
> > > On 1/22/2026 3:03 AM, Chen, Zide wrote:
> > > >
> > > > On 1/21/2026 10:19 AM, Ian Rogers wrote:
> > > >> On Wed, Jan 21, 2026 at 6:33 AM Ian Rogers <irogers@google.com> wrote:
> > > >>> On Wed, Jan 21, 2026 at 12:02 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
> > > >>>>
> > > >>>> On 1/21/2026 3:18 PM, Ian Rogers wrote:
> > > >>>>> On Wed, Dec 31, 2025 at 2:49 PM Zide Chen <zide.chen@intel.com> wrote:
> > > >>>>>> Diamond Rapids introduces two types of PCIe related uncore PMUs:
> > > >>>>>> "uncore_pcie4_*" and "uncore_pcie6_*".
> > > >>>>>>
> > > >>>>>> To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can match
> > > >>>>>> and collect events from both PMU types, slightly relax the wildcard
> > > >>>>>> matching logic in perf_pmu__match_wildcard().
> > > >>>>>>
> > > >>>>>> This change allows a wildcard such as "pcie" to match PMU names that
> > > >>>>>> include a numeric suffix, such as "pcie4_*" and "pcie6_*".
> > > >>>>>>
> > > >>>>>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > >>>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > >>>>>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > >>>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> > > >>>>> Can we not merge this. I'd missed a perf tool patch as it was hiding
> > > >>>>> in a bunch of kernel uncore updates. At the very least if wildcard
> > > >>>>> conventions are updated then the corresponding documentation needs
> > > >>>>> updating:
> > > >>>>> Documentation/ABI/testing/sysfs-bus-event_source-devices
> > > >>>> Ian, thanks for the information. We didn't notice there is such
> > > >>>> documentation to describe the name. :(
> > > >>>>
> > > >>>> Besides the documentation, are there other comments? We can update it
> > > >>>> together. Thanks.
> > > >>> The suffix handling is notoriously brittle. For example, ARM added hex
> > > >>> suffixes which are generally 12 characters of physical address rather
> > > >>> than the typical _0, _1, etc. What could go wrong? Well in some
> > > >>> situations ARM make their core PMU's follow the model name, so rather
> > > >>> than armv8_pmuv3_0 the core pmu is a name that ends with a model
> > > >>> number something like _a76, however, that is also a valid hex suffix.
> > > >>> So we have bumped the hex suffix to be at least 2 characters:
> > > >>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=tmp.perf-tools-next#n81
> > > >>> This also works around the naming of s390 PMUs (comments in the code).
> > > >>> ARM now have models like a720ae which would appear as a 5 character
> > > >>> hex suffix, and so this whole hex suffix thing is hanging together for
> > > >>> some part because we treat core and uncore PMUs differently. From my
> > > >>> pov, ideally the ARM uncore PMUs would have just used the _0, _1, etc.
> > > >>> naming convention and placed the physical address information into a
> > > >>> caps file, rather than trying to shoehorn it into the PMU name.
> > > >>> s390 pmu names have discrepancies that mean lots of their core PMUs
> > > >>> can match suffixes and Intel's i915 PMU name ("i915") will happily
> > > >>> match as just "i" as the underscore before the number is optional. A
> > > >>> change like this needs a range of testing on a variety of
> > > >>> architectures because the code has broken things in a lot of different
> > > >>> architecture types.
> > > >>>
> > > >>> Besides a lack of testing, going in through the wrong tree, the change
> > > >>> is changing suffix handling in one place but not all - at least
> > > >>> pmu_name_len_no_suffix wasn't updated. Let's get this out of the tree
> > > >>> and start again.
> > > >> To be explicit, things that I think are broken by this change:
> > > >>
> > > >> 1) ARM has PMUs called armv8_pmuv3_0, previously _0 would be the
> > > >> suffix and now 3_0 becomes the suffix. There may be other existing
> > > >> PMUs where this unintended behavioral change has happened. This may
> > > >> break output formatting but I think as the patch is incomplete that
> > > >> hasn't happened here.
> > > >>
> > > >> 2) as pmu_name_len_no_suffix wasn't updated it and assuming a machine
> > > >> with uncore_pcie4_0, uncore_pcie4_1, uncore_pcie6_0, uncore_pcie6_1
> > > >> and a common data_read event, the wildcarding for "pcie/data_read/"
> > > >> should match the event on the 4 PMUs, however, rather than the PMU
> > > >> name with no suffix (what pmu_name_len_no_suffix gives) being
> > > >> uncore_pcie it will be either uncore_pcie4 or uncore_pcie6 depending
> > > >> on which event/evsel we get the PMU name for. As the output will show
> > > >> an aggregated amount the output for "perf stat -e pcie/data_read/ .."
> > > >> the output may show just 1 event "pcie4/data_read/" rather than
> > > >> "pcie/data_read/" as the suffix length calculation is off and the
> > > >> number before the underscore not removed. In this example, it makes it
> > > >> look like just 2 events on 2 PMUs were read rather than the full 4
> > > >> events.
> > > >>
> > > >> So my point is, resolving this is complex and needs buy-in and testing
> > > >> from at least s390 and ARM. The easiest thing to do for now is to
> > > >> drop/revert the change.
> > >
> > > Sigh, the PMU name wildcard comparison is over complicated than I imagine...
> >
> > Agreed. One proposal from chatting with Namhyung is that in the future
> > we have some PMU base name file in sysfs, this will be used for
> > wildcard matching, giving the name with no suffix, etc. At some future
> > point that may allow us to not care about all of these overloaded uses
> > for the PMU name.
> >
> > Thanks,
> > Ian
> >
> > > I have no objection to drop this specific perf tools patch. Thanks.
> 
> I'm still seeing this patch in tip.git:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/tools/perf/util/pmu.c?h=perf/core&id=2246c24426fbc1069cb2a47e0624ccffe5f2627b
> with no revert:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/tools/perf/util/pmu.c?h=perf/core

Can you please revert the commit?  I know it's late in the cycle but Ian
found an issue in the tooling.  And in general, it'd be nice if all tool
changes can go through the perf-tools tree.

Of course, we can revert it and add changes in the tools tree for the
next cycle.  Let me know what you think.

Thanks,
Namhyung

