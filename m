Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78EF208D0;
	Fri, 28 Jun 2024 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544276; cv=none; b=m9Gts2t+wSJnrIkdDcYDHJG6QG353LXsd7AlCNyVFhinR1sHndDkkGLqxxEAC+EUilm+wX9KnQ3uGYFEfAdBwRld5Su0Et4NlhdGGkKLgLA3v3Dy7jX0GN5sR15EYX/xRCEIN0jVdDI/cTRUj7pkfax95Rl5M9zjBvnxvyE3Khk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544276; c=relaxed/simple;
	bh=kRo5ctG1rFTQqJeB5tVlcVlT5rJH72i5XfyhsbRL2NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilTEHoIg48Xh2wtJEj5/up064MtLwJOQWbaZBE0gf+QjYsQD3EZCUJzs/eltMyowkLAOSi3WzpwviRCFAJhXjFfgn6YLpjiWm7p+m3WDL1azVxMsutz7EJivbf1wnyfE4XC2dlMJlo775ssloBHhbgIdNrfSMWve8x4ggF/rGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srC9rgHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srC9rgHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72F6C116B1;
	Fri, 28 Jun 2024 03:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544276;
	bh=kRo5ctG1rFTQqJeB5tVlcVlT5rJH72i5XfyhsbRL2NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srC9rgHVUOqPNLuOiWEi6Z+0HkZcbvEnR4sfZftuTSk2F/WB6+zKUb8XFLs/XqWml
	 nGYm3+hyJCAibINP6QdO2w4ow7e7LWR5ODbWtflHqhoz6A0DNPFwjdIO59olqhqNcb
	 IBsUQvL9dPJklnV5Q6FjCnMujMCPRTEVOw5+62u6OOXK97SzI0zzM1KyEsr8uNVrmg
	 R9kAkZ4l47TEiWZ42Ue5yhWhhJSBAscC40jjkxlbBZhxTetKB1SHiDLxkmTwqB53Ig
	 NFiFU+u9WwcbnzSlV9Zb96U43/uLqZyjxDhciiHEudwlBDpulMPWfgK4wpaKx6Royk
	 KfstyqM2Zb9pw==
Date: Thu, 27 Jun 2024 20:11:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
	Chen Yu <yu.c.chen@intel.com>, Fernand Sieber <sieberf@amazon.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2] perf sched replay: Fix -r/--repeat command line
 option for infinity
Message-ID: <Zn4p0kMIsLNlv04X@google.com>
References: <20240621171909.24119-1-vineethr@linux.ibm.com>
 <51e9fd2f-7d86-40cb-b307-0b0b396ca32a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51e9fd2f-7d86-40cb-b307-0b0b396ca32a@linux.ibm.com>

On Fri, Jun 28, 2024 at 08:00:14AM +0530, Madadi Vineeth Reddy wrote:
> On 21/06/24 22:49, Madadi Vineeth Reddy wrote:
> > Currently, the -r/--repeat option accepts values from 0 and complains
> > for -1. The help section specifies:
> > -r, --repeat <n>      repeat the workload replay N times (-1: infinite)
> > 
> > The -r -1 option raises an error because replay_repeat is defined as
> > an unsigned int.
> > 
> > In the current implementation, the workload is repeated n times when
> > -r <n> is used, except when n is 0.
> > 
> > When -r is set to 0, the workload is also repeated once. This happens
> > because when -r=0, the run_one_test function is not called. (Note that
> > mutex unlocking, which is essential for child threads spawned to emulate
> > the workload, happens in run_one_test.) However, mutex unlocking is
> > still performed in the destroy_tasks function. Thus, -r=0 results in the
> > workload running once coincidentally.
> > 
> > To clarify and maintain the existing logic for -r >= 1 (which runs the
> > workload the specified number of times) and to fix the issue with infinite
> > runs, make -r=0 perform an infinite run.
> > 
> > Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> > Reviewed-by: James Clark <james.clark@arm.com>
> > 
> 
> Hi all,
> Any suggestions/comments on this patch?

I think the original intention was to set replay_repeat to UINT_MAX
using -1.  But it seems to refuse the negative number now.

Maybe you can simply set it to UNIT_MAX for -r 0.

Thanks,
Namhyung


> > ---
> > Changes in v2:
> > - Kept the existing 'for' loop and added a condition for infinite
> >   looping. (James Clark)
> > - This change also ensures that integer overflow doesn't occur when
> >   'replay_repeat' is zero.
> > - Add Reviewed-by tag from James Clark.
> > - Rebase against perf-tools-next commit 788c5160526a ("perf vendor
> >   events: Add westmereex counter information")
> > - Link to v1: https://lore.kernel.org/all/20240618112907.15131-1-vineethr@linux.ibm.com/
> > 
> >  tools/perf/Documentation/perf-sched.txt |  7 +++++++
> >  tools/perf/builtin-sched.c              | 11 ++++++++---
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> > index a216d2991b19..f1be8f0b249e 100644
> > --- a/tools/perf/Documentation/perf-sched.txt
> > +++ b/tools/perf/Documentation/perf-sched.txt
> > @@ -202,6 +202,13 @@ OPTIONS for 'perf sched timehist'
> >  --state::
> >  	Show task state when it switched out.
> >  
> > +OPTIONS for 'perf sched replay'
> > +------------------------------
> > +
> > +-r::
> > +--repeat <n>::
> > +	repeat the workload n times (0: infinite). Default is 10.
> > +
> >  SEE ALSO
> >  --------
> >  linkperf:perf-record[1]
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 8cdf18139a7e..51b3dea404bc 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -3383,8 +3383,13 @@ static int perf_sched__replay(struct perf_sched *sched)
> >  	sched->thread_funcs_exit = false;
> >  	create_tasks(sched);
> >  	printf("------------------------------------------------------------\n");
> > -	for (i = 0; i < sched->replay_repeat; i++)
> > -		run_one_test(sched);
> > +	if (sched->replay_repeat == 0) {
> > +		while (1)
> > +			run_one_test(sched);
> > +	} else {
> > +		for (i = 0; i < sched->replay_repeat; i++)
> > +			run_one_test(sched);
> > +	}
> >  
> >  	sched->thread_funcs_exit = true;
> >  	destroy_tasks(sched);
> > @@ -3548,7 +3553,7 @@ int cmd_sched(int argc, const char **argv)
> >  	};
> >  	const struct option replay_options[] = {
> >  	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
> > -		     "repeat the workload replay N times (-1: infinite)"),
> > +		     "repeat the workload replay N times (0: infinite)"),
> >  	OPT_PARENT(sched_options)
> >  	};
> >  	const struct option map_options[] = {
> 
