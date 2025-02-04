Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490021579C;
	Tue,  4 Feb 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692213; cv=none; b=E90bM4V9joSPPs0bGwK9v3dBdjXmmZNHn9eVX4xcCyyOrHwg43RR8rWfdcSIY+P8Ywamgd3haIlmqF5oLvnt1o+W50/86xs8oCsDI7Z5cI6P2Od9BXMtcCywEXGUsxyi/D0NRSJa0q5cE0WsTSCE8tMkjzCkSnjcbWWTZQRu8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692213; c=relaxed/simple;
	bh=LMxgtUXdm16/XY03BlQFhqU/FE+rDQod7akBLrqxDds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGor8yJydBNlEsnXFITnvIh+ejSGxxXZ6aYTEn6pp8TzyiT1uRbviP+tfym5LXhPCHCKTF2P+eznjTDeb2dy23EQ4f62INkBKWyGU6ywo/uYvPQoeY7Io4gMFz0t1rKX962vL8SQZMprBDvoDCj6IxSBuCTV9NYYDbFm8l0GY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SD1NBB6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SD1NBB6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6045DC4CEDF;
	Tue,  4 Feb 2025 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738692212;
	bh=LMxgtUXdm16/XY03BlQFhqU/FE+rDQod7akBLrqxDds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SD1NBB6El+2WQI6SxIrFiUvpUtTbtcjV/fWXlZqOf7mSLb2AXrriTqDjJghs2Z5Z6
	 YJn67Jvat4w2CwrIJlNNTpJmxLc0Onu1EVPaTReT9dRUmiZ4dZBE5lXsf9FX2ReowP
	 P+ck8G1A9/RrFGG7oUMS3tUh6h4PE+oDv3KnvTCk=
Date: Tue, 4 Feb 2025 19:03:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>,
	Vince Weaver <vincent.weaver@maine.edu>,
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
Message-ID: <2025020444-savage-latrine-0c31@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <87pljyyx68.fsf@ubik.fi.intel.com>
 <2025020426-spool-refreeze-2870@gregkh>
 <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
 <2025020408-apron-fled-d29e@gregkh>
 <6edcf7f8-d496-524e-2250-49284dfb55e4@maine.edu>
 <2025020447-gyration-wireless-f7da@gregkh>
 <CAP-5=fWT5J0svFsA-jqvE4P=NnTdrsKPF9x6JHkUEDp-vBd_1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWT5J0svFsA-jqvE4P=NnTdrsKPF9x6JHkUEDp-vBd_1w@mail.gmail.com>

On Tue, Feb 04, 2025 at 09:49:55AM -0800, Ian Rogers wrote:
> On Tue, Feb 4, 2025 at 9:12 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 04, 2025 at 11:41:38AM -0500, Vince Weaver wrote:
> > > On Tue, 4 Feb 2025, Greg Kroah-Hartman wrote:
> > >
> > > >
> > > > It seems that the majority of the perf code IS looking in the correct
> > > > place, just mem-events.c seemed wrong.
> > >
> > > I hate to tell you, but other places in userspace are depending on the
> > > current setup.  libpfm4, used by PAPI, is looking directly in /sys/devices
> > > for pmus and will break with the changes you are planning.
> >
> > Then that too needs to be fixed, sorry.  Again, devices can, and will,
> > move around in /sys/devices/ you can never hard-code any paths there.
> > Any userspace code must ALWAYS be able to handle that, that's a sysfs
> > requirement.
> >
> > And do you have a link to the source for that code?  Good news is that
> > if the code is fixed in userspace, it will work for any kernel (old or
> > new).
> 
> +Stephane Eranian
> 
> I see use of /sys/devices in at least:
> https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/pfmlib_perf_event_pmu.c
> I imagine it isn't a big job to clean it up.

Nope, all that has to happen is this line:
	snprintf(buf, PATH_MAX, "/sys/devices/%s/events/%s", e->pmu ? e->pmu : "cpu", e->name);
be changed to:
	snprintf(buf, PATH_MAX, "/sys/bus/event_source/devices/%s/events/%s", e->pmu ? e->pmu : "cpu", e->name);


thanks,

greg k-h
