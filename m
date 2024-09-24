Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B013B5B4;
	Tue, 24 Sep 2024 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209303; cv=none; b=jUK/MuHQoggJjQKhPstHKH1c3WjjjeLKcWceeXmOeR0bJQtmShcr9iKWrmsPKvFLS77CghlFP9YZi32imz0btre0Mi4JxuxcguSAXUi+O6ej6rJu7lBYjV9pFH4Ke/YrKIrsnpkejDuPgU7Ue1V1hZcofexG976VhChXRPjN2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209303; c=relaxed/simple;
	bh=3MgZYJkn6f98xkE+QLHYB0q8DJD6v27bHLrYRm2tnmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ2VLQvWlDwRBwpLjHKJDVH+3yrd1xgbHRoUMnO/wAQRevFRj8rV9Sb2uUI6R217QOO6Stk6nhxSYWqdQfxM4russi5EkmbmjPVF0wLlLlXZIKQuBrmzv4e08TnRqAuFkLuHjDQTXW2HtpfSM0QhSdEeWorBrSoS8mZTqLWK+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqNyHat2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqNyHat2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3356C4CEC4;
	Tue, 24 Sep 2024 20:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727209303;
	bh=3MgZYJkn6f98xkE+QLHYB0q8DJD6v27bHLrYRm2tnmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqNyHat26f3/B63jYioP0H/yySqUhS9GZfRchyIcOFrL0JS5A9kbQZG30obGrUIZA
	 MMiBBRI+0Xm0MXT+HWHBt9Pq8DCSGuPfOGYfRoWIb659UiiYppghB61pQRNfT//Ivi
	 v2HhC0tDdUnwpimixHcU3HIrCV98T6ZA2wee4kj6tI+EP/3Chjp+gR99RteS9EcnlJ
	 1filfrDu28juLaYF494LPQAa9oCayUw6CYihSzkX+OvOcpHQOjeAsKPMTgXTg7az9B
	 iB37USo4+0N5moxi+U+OUbG3tdGMF7X/OmmfLA14YKhiDHWVe1mH9ltekkxGDzxK5J
	 rpelNW6a6M81g==
Date: Tue, 24 Sep 2024 13:21:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 04/10] perf stat: Add --exclude-guest option
Message-ID: <ZvMfVe1VXwhCIOB9@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-5-namhyung@kernel.org>
 <b1002dc7-78bf-40ed-83af-12a50622fb76@linux.intel.com>
 <c26e646d-5ebf-473e-91e2-db28fc01e35d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c26e646d-5ebf-473e-91e2-db28fc01e35d@linaro.org>

Hello,

On Mon, Sep 23, 2024 at 09:47:17AM +0100, James Clark wrote:
> 
> 
> On 06/09/2024 3:33 pm, Liang, Kan wrote:
> > 
> > 
> > On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
> > > This option is to support the old behavior of setting exclude_guest by
> > > default.  Now it doesn't set the bit so users want the old behavior can
> > > use this option.
> > > 
> > >    $ perf stat true
> > > 
> > >     Performance counter stats for 'true':
> > > 
> > >                  0.86 msec task-clock:u                     #    0.443 CPUs utilized
> > >                     0      context-switches:u               #    0.000 /sec
> > >                     0      cpu-migrations:u                 #    0.000 /sec
> > >                    49      page-faults:u                    #   56.889 K/sec
> > >                   ...
> > > 
> > >    $ perf stat --exclude-guest true
> > > 
> > >     Performance counter stats for 'true':
> > > 
> > >                  0.79 msec task-clock:Hu                    #    0.490 CPUs utilized
> > >                     0      context-switches:Hu              #    0.000 /sec
> > >                     0      cpu-migrations:Hu                #    0.000 /sec
> > >                    49      page-faults:Hu                   #   62.078 K/sec
> > >                   ...
> > > 
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >   tools/perf/Documentation/perf-stat.txt | 7 +++++++
> > >   tools/perf/builtin-stat.c              | 2 ++
> > >   2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> > > index 2bc06367248691dd..d28d8370a856598f 100644
> > > --- a/tools/perf/Documentation/perf-stat.txt
> > > +++ b/tools/perf/Documentation/perf-stat.txt
> > > @@ -382,6 +382,13 @@ color the metric's computed value.
> > >   Don't print output, warnings or messages. This is useful with perf stat
> > >   record below to only write data to the perf.data file.
> > > +--exclude-guest::
> > > +Don't count event in the guest mode.  It was the old behavior but the
> > > +default is changed to count guest events also.  Use this option if you
> > > +want the old behavior (host only).  Note that this option needs to be
> > > +before other events in case you added -e/--event option in the command
> > > +line.
> > 
> > I'm not sure if we really need this option. I think it may bring more
> > trouble than what we get.
> > 
> > The name of the "--exclude-guest" sounds like a replacement of the event
> > modifier "H". But in fact, it's not. It should only affect the default.
> > It doesn't set the "H" for any events.

Well I think it's tricky but it'd set "H" modifier events after the
option.  But I have to agree that it can bring more troubles.

> > 
> > Except for the perf kvm user, I don't think there are many users which
> > care the exclude_guest. The behavior of the perf kvm is not changed. So
> > the option seems not that important. If we really want an option to
> > restore the old behavior, it's better to choose a better name and update
> > the description.

Personally I don't want to this option but just worried if there's a
case where exclude_guest is preferred.

> 
> Do we not want to keep exclude_guest for record, but remove it for stat?

What I really want is to synchronize record and stat behavior in terms
of the default exclusion mode.  If everyone is fine, I'd like to remove
exclude_guest from the default and set it only if needed (through the
fallback) like we do for exclude_kernel.

> 
> Because in record the addresses of guest samples don't make sense without
> extra work, but for stat you might want to see an overview of the whole
> system.

I think it depends on the use case and (power) users should know about
their environment and requirement.  The concern is what's the reasonable
default, but I think it should be the same both in perf record and stat
at least.

> 
> For Coresight tracing and SPE we would want to keep exclude_guest, otherwise
> you generate a load of extra trace that you can't make use of. Say you were
> doing PGO on your host you wouldn't be recompiling anything the guests were
> running.

For the specific use case, I think we can guide users to add "H"
modifier (I guess it's not the default event for perf record).
Maybe we can consider per-PMU default attributes.

> 
> If we do change the defaults isn't ':H' already enough to go back to the old
> behavior? I'm wondering why we need an argument when all the other exclude
> rules are done with the letter modifiers?

I'm not sure I follow this.  But maybe we don't need this option at all.
We can add ":H" for every event but I'm too lazy to add them to all the
default events in perf data. :)

Thanks,
Namhyung
 
> > > +
> > >   STAT RECORD
> > >   -----------
> > >   Stores stat data into perf data file.
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index d8315dae930184ba..4d47675af5cc3094 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -2491,6 +2491,8 @@ int cmd_stat(int argc, const char **argv)
> > >   		OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
> > >   				"Configure all used events to run in user space.",
> > >   				PARSE_OPT_EXCLUSIVE),
> > > +		OPT_BOOLEAN(0, "exclude-guest", &exclude_HG_default,
> > > +			"Don't count events in the guest mode"),
> > >   		OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
> > >   			"Use with 'percore' event qualifier to show the event "
> > >   			"counts of one hardware thread by sum up total hardware "
> 
