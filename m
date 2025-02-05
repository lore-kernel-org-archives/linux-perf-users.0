Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349AA15D1;
	Wed,  5 Feb 2025 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734350; cv=none; b=rr32xEyXTiP4iVVFMojsBumzg9jeKVB0nmkAXfS1qcngcxk2o5/kyiTDmP2+RF7NRrbFlGd1bTTBVX3d9YuI+qFQTW7RHyhW8HYJTmH1E3pzTr7DfeFJPYhAt74bOxkqyhFBL0coFNI2HaF7zexDEnoUKPwEhMEnsAxZF6CSZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734350; c=relaxed/simple;
	bh=+Zy/jcT6qJbB3DO11CDNJUJ2pk2f9Zp9TZqkMYti70g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCqGpaRhjVWBaNcwT0NiFpirrqOpQpcTimURh29V0Wj8WtmAxPkRUZND484m9UflwZTy+Ld6p4ypc2b7ZkimtCV/APXV28Rr2BYN1+GJqepITVitCMlJ0ETRRS0Xw+IJmb1R+w1Yb1xRkdS+vpp9iMEmTwViP3ozm8GsC2R4JoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C/XNTkMW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/XNTkMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C23C4CED1;
	Wed,  5 Feb 2025 05:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738734349;
	bh=+Zy/jcT6qJbB3DO11CDNJUJ2pk2f9Zp9TZqkMYti70g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/XNTkMWZMsMbHTXdqe5H1Ia0kWs4Yv76nWXftOOzpwsCFjSzSLpRnzaL/Y0GK3Hi
	 NdI4t4V2byLfFd4Y9fMMLnMijEQYz2wkYDHE1L/SlDM4uytZMAk+s8U8HdYssJSovG
	 taJCFZdBirfMo2E9m1toFmvMM0HRL2vCtLGmd9ew=
Date: Wed, 5 Feb 2025 06:45:41 +0100
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
Message-ID: <2025020535-curvature-citable-ab6a@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <87pljyyx68.fsf@ubik.fi.intel.com>
 <2025020426-spool-refreeze-2870@gregkh>
 <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
 <2025020408-apron-fled-d29e@gregkh>
 <6edcf7f8-d496-524e-2250-49284dfb55e4@maine.edu>
 <2025020447-gyration-wireless-f7da@gregkh>
 <CAP-5=fWT5J0svFsA-jqvE4P=NnTdrsKPF9x6JHkUEDp-vBd_1w@mail.gmail.com>
 <2025020444-savage-latrine-0c31@gregkh>
 <97541134-7c32-94a8-7642-a82f3292dc38@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97541134-7c32-94a8-7642-a82f3292dc38@maine.edu>

On Tue, Feb 04, 2025 at 08:21:17PM -0500, Vince Weaver wrote:
> On Tue, 4 Feb 2025, Greg Kroah-Hartman wrote:
> 
> > On Tue, Feb 04, 2025 at 09:49:55AM -0800, Ian Rogers wrote:
> > > On Tue, Feb 4, 2025 at 9:12 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Feb 04, 2025 at 11:41:38AM -0500, Vince Weaver wrote:
> > > > > On Tue, 4 Feb 2025, Greg Kroah-Hartman wrote:
> > > > >
> > > > > >
> > > > > > It seems that the majority of the perf code IS looking in the correct
> > > > > > place, just mem-events.c seemed wrong.
> > > > >
> > > > > I hate to tell you, but other places in userspace are depending on the
> > > > > current setup.  libpfm4, used by PAPI, is looking directly in /sys/devices
> > > > > for pmus and will break with the changes you are planning.
> > > >
> > > > Then that too needs to be fixed, sorry.  Again, devices can, and will,
> > > > move around in /sys/devices/ you can never hard-code any paths there.
> > > > Any userspace code must ALWAYS be able to handle that, that's a sysfs
> > > > requirement.
> > > >
> > > > And do you have a link to the source for that code?  Good news is that
> > > > if the code is fixed in userspace, it will work for any kernel (old or
> > > > new).
> > > 
> > > +Stephane Eranian
> > > 
> > > I see use of /sys/devices in at least:
> > > https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/pfmlib_perf_event_pmu.c
> > > I imagine it isn't a big job to clean it up.
> > 
> > Nope, all that has to happen is this line:
> > 	snprintf(buf, PATH_MAX, "/sys/devices/%s/events/%s", e->pmu ? e->pmu : "cpu", e->name);
> > be changed to:
> > 	snprintf(buf, PATH_MAX, "/sys/bus/event_source/devices/%s/events/%s", e->pmu ? e->pmu : "cpu", e->name);
> 
> it doesn't matter if it's a one line change, your proposed change breaks 
> userspace.

It breaks broken userspace :)

> I thought the rule was Linux didn't break userspace.
> Has that changed recently?

No, which is why I am working to fix these tools so that it will not be
broken.

> libpfm4/PAPI are widely used and deployed and in some cases possibly 
> statically linked into other projects.  It will take years for the change 
> to filter out to all users.

Great, as it is easy to get this type of fix into the stable kernels,
and then fix these tools, by the time those old systems eventually
update to a newer kernel version, it should "just work".

> Is there a technical reason for this proposed change of yours, or are you 
> just arbitrarily breaking userspace programs because you think /sys looks 
> cluttered to your personal taste?

I'm fixing up the bug where all of these devices accidentally got dumped
into the root of the device tree in the system.

Again, /sys/devices/ is NEVER guaranteed to have specific placement,
that's the whole point of sysfs in the first place.  We can, and do,
move devices around in there all the time (even every other boot), it's
just that some tools accidentally didn't realize this and now need to be
fixed.

This "grey area" between the kernel and userspace of sysfs (and other
virtual filesystems), always gets tweaked and changed over time.  sysfs
makes it much simpler to make those changes in relation to other
filesystems like /proc/ which is why it was designed this way in the
first place.

thanks,

greg k-h
