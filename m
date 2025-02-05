Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB815854F;
	Wed,  5 Feb 2025 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769973; cv=none; b=A8kVtfD5MKPhzWcQFxCAaSP8vOP4x9LdsR3JsE3aKw3a5EOfYer219Ptp9JcohfVba/iAE7Ycu4QPJLv5ZDk17Y58Fa0pDAbGsw33E+et35BgUQqrMeeun20GbxyEo68rJNn0CGSAkO+uZZZHRDht4C6CQE3Om58YA9sPpdSCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769973; c=relaxed/simple;
	bh=japP+wvHbAwuQdZr4+B9AUzscccGWhvFYFsUtJij36M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiQmmA78SmqL6s/8o6ej30iqzlRjxkg/kP2J92vayreZpckc0DyHwzoM0AMBaR5i/eL6r7Q4WW8rYNi2eQT01FKYdwPoQ3d/JQAcCecQj/WFyFkV5qeJd5+IEA1dURgkwQycz0jXd0kuxPrHBdLg4ziewsQM3RzaDQ6LQaE8ngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k46nZBTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k46nZBTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50978C4CED1;
	Wed,  5 Feb 2025 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738769972;
	bh=japP+wvHbAwuQdZr4+B9AUzscccGWhvFYFsUtJij36M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k46nZBTexzCnYYdudkKpg9uuYsC6iGxxyV8NhciK/LSs4+YCa87vvqjh68ajrND0g
	 pKD4a05vkedyQ4FU38k2/YI1RdXI/18I+Zx3HBCkQh3NcadefNXSOESH1HH2X/L3LR
	 TA38spom7Qk6w1srapJ6YpvYigJ80Hg284I/5Jpo=
Date: Wed, 5 Feb 2025 16:36:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Stephane Eranian <eranian@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
Message-ID: <2025020506-vineyard-replay-1801@gregkh>
References: <2025020426-spool-refreeze-2870@gregkh>
 <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
 <2025020408-apron-fled-d29e@gregkh>
 <6edcf7f8-d496-524e-2250-49284dfb55e4@maine.edu>
 <2025020447-gyration-wireless-f7da@gregkh>
 <CAP-5=fWT5J0svFsA-jqvE4P=NnTdrsKPF9x6JHkUEDp-vBd_1w@mail.gmail.com>
 <2025020444-savage-latrine-0c31@gregkh>
 <97541134-7c32-94a8-7642-a82f3292dc38@maine.edu>
 <2025020535-curvature-citable-ab6a@gregkh>
 <6cdaf5a4-0043-5cde-9b48-06fb7c1fd9e2@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cdaf5a4-0043-5cde-9b48-06fb7c1fd9e2@maine.edu>

On Wed, Feb 05, 2025 at 10:06:55AM -0500, Vince Weaver wrote:
> On Wed, 5 Feb 2025, Greg Kroah-Hartman wrote:
> 
> > On Tue, Feb 04, 2025 at 08:21:17PM -0500, Vince Weaver wrote:
> > > 
> > > it doesn't matter if it's a one line change, your proposed change breaks 
> > > userspace.
> > 
> > It breaks broken userspace :)
> 
> no, it breaks working code that's been working for 15 years, apparently on 
> some whim by you.

These devices have been here for 15 years?  I know I've been ignoring
them for a while, but I don't think that long.  Let me check, ok at
least 15, but there was not many event sources back then, and we didn't
really notice it.

Then in 2023, there was an attempt to fix up parent events in commit
143f83e2003a ("perf: Allow a PMU to have a parent"), which does properly
put pmu devices within the device tree.

So if for no other reason, the userspace tools need to be fixed up to
find those devices, they are broken as of 2023 as they can't find them
in the tree unless they follow the in-kernel documentation that says to
look in /sys/bus/event_source/*/devices (as documented in
Documentation/admin-guide/perf/* and many many Documentation/ABI/
entries.

Also, modern systems have way more "perf objects" than before, so
dumping them all at the root of sysfs is not ok, it might not have been
noticed in the past, but on modern systems today, it is.

> I thought we didn't break userspace.

We try not to, yes.  Again, this is an area where we do change all the
time, and in fact, sysfs was designed to allow this.  That's the rule of
sysfs, never treat the /sys/devices/ tree as stable.  Seems that some
tools didn't get that memo, so I'll go fix them up, not a big deal.

> > > libpfm4/PAPI are widely used and deployed and in some cases possibly 
> > > statically linked into other projects.  It will take years for the change 
> > > to filter out to all users.
> > 
> > Great, as it is easy to get this type of fix into the stable kernels,
> > and then fix these tools, by the time those old systems eventually
> > update to a newer kernel version, it should "just work".
> 
> no, that is the worst case scenario.  PAPI is installed on older systems, 
> often custom non-vendor packages.  So if you get this into stable then 
> these older RHEL systems the kernel will be updated suddenly breaking the 
> users with no warning.

So you really update RHEL systems with a custom kernel?  That kind of
defeats the purpose of RHEL, and wastes your support money you are
paying for it :)

RHEL can handle this just fine, they will update their packages
properly over time, I can wait.

> Even if we manage to get a change into libpfm4 and PAPI it will probably 
> be months before the next stable release, and again people tend not to 
> upgrade PAPI releases that often.

Fair enough, what is the release cycle of those tools?

> > I'm fixing up the bug where all of these devices accidentally got dumped
> > into the root of the device tree in the system.
> 
> is this a "bug" or just you shuffling around files for no reason?

It is a "bug" in that the devices should never have been there in the
first place, AND that userspace should never assume that /sys/devices is
stable.

It's also a "bug" in that these tools might end up trying to touch
devices they really aren't supposed to be touching as assuming anything
with an "events" subdir in the root of sysfs is going to break anyway on
their own.

Heck, I'm tempted to create a "/sys/devices/reset_me/events/" object now
just to see what kind of tools trip over that :)

> > Again, /sys/devices/ is NEVER guaranteed to have specific placement,
> > that's the whole point of sysfs in the first place.  We can, and do,
> > move devices around in there all the time (even every other boot), it's
> > just that some tools accidentally didn't realize this and now need to be
> > fixed.
> 
> great.  Slap a note about this happening in the appropriate "deprecated" 
> file with a timeline of 5 years out or whatever, and then when that comes 
> around then send your patch.

I'll send an updated patch soon and put it behind a config option for
those systems that want to do the right thing, update userspace, and
then remove the config option in a few years.  We've done it in the
past, not a big deal.

thanks for the review.

greg k-h
