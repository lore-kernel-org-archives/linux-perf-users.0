Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5C38F82;
	Wed,  5 Feb 2025 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734087; cv=none; b=ShU1R8+0iD8rPIVu6dIB6d7mHI1Zu7FoWqDq4gf7SLH3JgOPhwrvytLuFMas6SnV2DATVXwrdRieKUFCm4fCPEyYHeuXeXHe2mthqGtBPisL7HaxBHCuObd4rJywKdJV6XDJv86ggYNZWzQ2WhKHDTjkwsU643X/j+PRs4NW2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734087; c=relaxed/simple;
	bh=1znfjpmGQuBCHLJwkeEX/T+iTnl+W6hHb8DyxGwflCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLcR2gQH/qKCyiL7qDqBpX0LmAv1d6m+uGla9DP/CjCLTX6u1cWK0gjNfbZHUu5Q4FfC+oQfBLF78vBFIWJaO+MyZ2MC7Wuuo7fS+ksU0F9Zidq2R4jqB2pc5aGdpbfdxiQ7pl45F8bUWMejs06Sg0CFQ/vgKHGO5ox8gRe00ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRUnCidD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRUnCidD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F050C4CED1;
	Wed,  5 Feb 2025 05:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738734087;
	bh=1znfjpmGQuBCHLJwkeEX/T+iTnl+W6hHb8DyxGwflCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRUnCidDOUJ+NbY0Xbfn7IcJPjqfsxguURSXJa50UgyIwUz51lxPDlvaYKZTSvqA1
	 kwVT49l2uAAAsMWWcbwsWVbfbbUfEU8C+j9mexTpArvlGwTdgCp63dbylHq/LyHmzL
	 ZMm6Hs7q4Kn+X7402XQJBLaJNRtfXUyZOuHXUAdY=
Date: Wed, 5 Feb 2025 06:41:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
Message-ID: <2025020507-anteater-icy-44ab@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <CAP-5=fXwprvLc3ubPmAuyUaTL2aD1frqL+RHJzkp8oe5z85oRw@mail.gmail.com>
 <2025020444-chivalry-wanting-7f0c@gregkh>
 <CAP-5=fUk3DB4orma=vM=+cKrztsRqHVhvvPk+py+G+9w9sOdqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUk3DB4orma=vM=+cKrztsRqHVhvvPk+py+G+9w9sOdqg@mail.gmail.com>

On Tue, Feb 04, 2025 at 10:17:17AM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 11:05 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 03, 2025 at 11:44:13AM -0800, Ian Rogers wrote:
> > > On Mon, Feb 3, 2025 at 11:25 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> [snip]
> > > > Note, if you all don't like "pmu_bus" for the name, that's fine, please
> > > > let me know and I can rename it to something else, but it should be
> > > > something to get these objects out of the root sysfs directory.
> > >
> > > Excuse my ignorance, does the event_source bus already provide a
> > > similar solution?
> > > ```
> > > $ ls /sys/bus/event_source/devices
> > > breakpoint   i915       msr         uncore_arb     uncore_cbox_3
> > > uncore_cbox_7              uprobe
> > > cpu          intel_bts  power       uncore_cbox_0  uncore_cbox_4  uncore_clock
> > > cstate_core  intel_pt   software    uncore_cbox_1  uncore_cbox_5
> > > uncore_imc_free_running_0
> > > cstate_pkg   kprobe     tracepoint  uncore_cbox_2  uncore_cbox_6
> > > uncore_imc_free_running_1
> > > $ ls /sys/devices
> > > breakpoint   intel_pt     platform    uncore_arb     uncore_cbox_5
> > >          uprobe
> > > cpu          isa          pnp0        uncore_cbox_0  uncore_cbox_6
> > >          virtual
> > > cstate_core  kprobe       power       uncore_cbox_1  uncore_cbox_7
> > > cstate_pkg   LNXSYSTM:00  software    uncore_cbox_2  uncore_clock
> > > i915         msr          system      uncore_cbox_3  uncore_imc_free_running_0
> > > intel_bts    pci0000:00   tracepoint  uncore_cbox_4  uncore_imc_free_running_1
> > > ```
> >
> > Those are the exact same device structures :)
> >
> > Look at /sys/bus/event_source/devices/ those are symlinks back to
> > /sys/devices.  In other words, that's the exact same structures, and
> > the mess in /sys/devices/ with these event devices is what I am trying
> > to clean up.
> 
> Thanks! Again my ignorance, why do we need pmu_bus?

You need some sort of "bus" to group all of your devices on.  It could
also be a class, your call.  This is how the driver model in the kernel
works.

> Could the symlinks in event_source be the actual devices?

That's not how the driver model works.

> Perhaps for temporary compatibility some symlinks could be placed in
> /sys/devices?

No, /sys/devices/ is never guaranteed to have stable placement.

And define "temporary" :)

thanks,

greg k-h
