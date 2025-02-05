Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FB610C;
	Thu,  6 Feb 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852021; cv=none; b=g+3W1Zv2h3QJZEyHWPfoDC4DOw7+t0HPUe/Rm6Soxd1xk8eqlOK3w1gZ+LMZGDJ+F/IoHfRXWqLoWrfXDuX11stVZCYi5asMD229F/Ly8Tm2DNqHRy5Xb1yKEUD9BBWOQAR4Esl6vIug7k7y0eLUbyPmUEpRFyxdYgkadI/4vss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852021; c=relaxed/simple;
	bh=IR+bSwBGh2vC4Oz3R9Xxmj7nnFh8baL2VkXuxEEiUPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m41PSNqBIcTPVbaJxJycet6PbzX6/HJgm3D4OiYqva6Z/EowttQcgvcNP5lJU9bHVehkUItK8u+dyGocSXHXHhTOPnWbcxZwIvGW4k/goqq3RArgdtKiOfGERtPpHrhQ1PtcuYGh27nZ/ndlyCIdlHQKIURO937HoOZHdfuVnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JGV7h1RE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JGV7h1RE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5899CC4CEDD;
	Thu,  6 Feb 2025 14:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738852021;
	bh=IR+bSwBGh2vC4Oz3R9Xxmj7nnFh8baL2VkXuxEEiUPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGV7h1REle3HMwFsnsvx/1mWg96yeNPo2bQnxxJ+1fO1PHqTK/lipKANb0kXHQE9P
	 ysre9S3FNW9Pvzp5vpwa89ERlI1ZXxb2Ls6e6/mzZJwJeFwTX17Ri1gktK9k7w9bNy
	 nOc3z9c70YNBEB00T2FrF7tLYnxBKOqrxlKC0s2U=
Date: Wed, 5 Feb 2025 17:00:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
Message-ID: <2025020538-risk-snoring-1b83@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <87pljyyx68.fsf@ubik.fi.intel.com>
 <2025020426-spool-refreeze-2870@gregkh>
 <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
 <2025020408-apron-fled-d29e@gregkh>
 <9656a86c-30fb-48d9-9327-920cd449e73a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9656a86c-30fb-48d9-9327-920cd449e73a@linux.intel.com>

On Tue, Feb 04, 2025 at 01:23:51PM -0500, Liang, Kan wrote:
> 
> 
> On 2025-02-04 11:28 a.m., Greg Kroah-Hartman wrote:
> > On Tue, Feb 04, 2025 at 09:06:18AM -0500, Liang, Kan wrote:
> >>
> >>
> >> On 2025-02-04 5:16 a.m., Greg Kroah-Hartman wrote:
> >>> On Tue, Feb 04, 2025 at 09:41:03AM +0200, Alexander Shishkin wrote:
> >>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >>>>
> >>>>> In sysfs, for some reason, all pmu devices seem to show up in the "root"
> >>>>> of /sys/devices/ making for a confusing mess as these devices are not
> >>>>> really at the root of the system at all.
> >>>>>
> >>>>> Create a fake root devices, "pmu_bus" and place them all under there if
> >>>>> they do not already have a parent device set, cleaning up sysfs to look
> >>>>> more sane.
> >>>>
> >>>> Yeah, so what happens to the userspace that uses them via /sys/devices/*
> >>>> directly? Even I have scripts that do that.
> >>>
> >>> You should never be doing that, as you have no idea what type of devices
> >>> are in that location in the tree.  You should be doing what the
> >>> documentation says to do, and look in /sys/bus/event_source/devices/
> >>> instead.  That didn't change here.
> >>>
> >>
> >> Not just the script, the /sys/devices/ is also used in the current perf
> >> tool. For example,
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/mem-events.c#n192
> >>
> >> And the comments and document in the perf tool.
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/pmu.c#n39
> > 
> > Note, this file looks to work properly, it's just the comment that is
> > incorrect.
> > 
> > Any hints on what perf command or test I should run to verify I did get
> > this all right?
> 
> For the perf tool, "perf test" should be run at minimum.

Cool, I never noticed that, I'll use that to start with.

> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-list.txt#n191
> > 
> > I'll fix that.
> > 
> >> I think it should bring big impact for the end user, especially when
> >> they still use an older perf tool and script.
> > 
> > It seems that the majority of the perf code IS looking in the correct
> > place, just mem-events.c seemed wrong.
> > 
> 
> There should be two more.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-stat.c#n100

But that's a cpu device, not a event_bus device, right?

Oh, no, wow, yeah, that is an event_bus device.  Now that's confusing, I
imagine the sysfs cpu authors get annoyed at that one...

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/x86/util/iostat.c#n35

Ah, missed that one too, thanks!

greg k-h
