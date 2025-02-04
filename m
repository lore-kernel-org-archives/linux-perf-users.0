Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47278215170;
	Tue,  4 Feb 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686504; cv=none; b=i3cNnDeJUfEKFyjZRskUtb1wnHlBtG/Ic1gqWDB+R5shyOzrA06JgUn1H113yaV+JXuJyMBLhYnYbeb+ChraXr6qqS6WBP6/o1SHoA+gLEKCptAnHe+hplzBK4rYieIhhstYOlOxb/qZclOBRlnwEaqCAec9HL25703y8bOfuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686504; c=relaxed/simple;
	bh=eQuMDc1znz6lOBOFijAh/R5x2DqPsHu1UW9pkX5clqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrTExuI6KaNhqpOrTkZwDGNSkW10ejsqbrbWwBegXxpyw93F5cxc74C4l52U/39LCFyt90t+uHGAgOFSEKVStogczULGmNu9TmoHOoPgVtE46tPNKXNWIln4urusYgRYNJTOeC+V7YlpAFb1A/6hQBQAozsUIvMnrpTTfLSad6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UqEd55x7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UqEd55x7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C975C4CEDF;
	Tue,  4 Feb 2025 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738686503;
	bh=eQuMDc1znz6lOBOFijAh/R5x2DqPsHu1UW9pkX5clqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqEd55x7lXfaE+iQiOQAem6JbKHKZ4i5SMGDL5DLlma6TyEz8VuLscpitHElAijyZ
	 SCgG+ToBDaqsttFUojCjhUdmlO02ZfXuhlRiquqNuQkDdvcgo7oFmPlvfnhCTW3T7G
	 lLrSQJHOR/lia6kB4qdC/7H3sl6kK+cAsqxfRhVs=
Date: Tue, 4 Feb 2025 17:28:20 +0100
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
Message-ID: <2025020408-apron-fled-d29e@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <87pljyyx68.fsf@ubik.fi.intel.com>
 <2025020426-spool-refreeze-2870@gregkh>
 <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>

On Tue, Feb 04, 2025 at 09:06:18AM -0500, Liang, Kan wrote:
> 
> 
> On 2025-02-04 5:16 a.m., Greg Kroah-Hartman wrote:
> > On Tue, Feb 04, 2025 at 09:41:03AM +0200, Alexander Shishkin wrote:
> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >>
> >>> In sysfs, for some reason, all pmu devices seem to show up in the "root"
> >>> of /sys/devices/ making for a confusing mess as these devices are not
> >>> really at the root of the system at all.
> >>>
> >>> Create a fake root devices, "pmu_bus" and place them all under there if
> >>> they do not already have a parent device set, cleaning up sysfs to look
> >>> more sane.
> >>
> >> Yeah, so what happens to the userspace that uses them via /sys/devices/*
> >> directly? Even I have scripts that do that.
> > 
> > You should never be doing that, as you have no idea what type of devices
> > are in that location in the tree.  You should be doing what the
> > documentation says to do, and look in /sys/bus/event_source/devices/
> > instead.  That didn't change here.
> >
> 
> Not just the script, the /sys/devices/ is also used in the current perf
> tool. For example,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/mem-events.c#n192
> 
> And the comments and document in the perf tool.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/pmu.c#n39

Note, this file looks to work properly, it's just the comment that is
incorrect.

Any hints on what perf command or test I should run to verify I did get
this all right?

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-list.txt#n191

I'll fix that.

> I think it should bring big impact for the end user, especially when
> they still use an older perf tool and script.

It seems that the majority of the perf code IS looking in the correct
place, just mem-events.c seemed wrong.

thanks,

greg k-h
