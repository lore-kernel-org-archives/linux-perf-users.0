Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619349B468;
	Wed, 16 Sep 2026 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585350; cv=none; b=JKHg1OQkrlGwKTanzr38Y3eZbxCBFVEJ5/T8QKS/qbAPS3o1NylnFO0vxnlZU5w/4dMEH21a3T/7WvP6fW5fWB81i8ZOSd0VMVt2MrAAOirTVdSv9f5LQ6I6C2W5JmVYM2gsMA44FtrZg8L48CtPN+rW3zDl5+h1ETi1gr9qVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585350; c=relaxed/simple;
	bh=cx6YlY2EdJ+cNjWHxG0MUy1VTj9IPDy5W9mL2MWARdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSClskXDEoQ7mxOufLYu14/IDDh/cXlmfs2svf7P/bMdVjn0apAGy4OVW+s6jXKA03vjWI8Yc1fJFYOYNXKG1FPZyqYARGGKsyEe3O5zEt/VAqEUYxaYauG6J1Gsv5J60xzDF8QdFpoyDPfNhMtLKpntP87s7hyapvL9r8YEKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD5h3PL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD5h3PL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14601F000FF;
	Wed, 16 Sep 2026 19:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585333;
	bh=Xo27toqevnPdEBMDm6fesTvae198prwaWdMkd4Swf6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BD5h3PL0Mn1piVpYcwogBCSkESdoFyZgEqOt/AKS1UHLApsUTjFdJjas+gUBwhoVG
	 8Sy9JHm0QVLkSPIrrrF7QRdmKXpvjppCHX5o5Mnc31MV9KKQ/YUn0J89eGcptHctJW
	 b9tGU42q56jK4TBiWw/RLTQmr6HMSb6SgBtqZbwn0a8C1+4HQCOOqlZWKSbEF1AP6G
	 sSjzjSQ8hY5kgJ59q6DmbOzVLmU4jThPTLd36acQHoEBFBRLpFi3RpmLgja0PFwph7
	 W+iSCkPGaZ1J/PZdGAn1uH7SlF7Wqyr+SQGYXra7Yw4YhCnhNmVKVvNmalOlTqUASu
	 gVA3cPvgSRjsA==
Date: Wed, 16 Sep 2026 16:02:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 02/12] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Message-ID: <aqrnssk8iekDb2jC@x2>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-3-acme@kernel.org>
 <CAP-5=fWr46YKripkCvFHO23k+0SUHfGgYBTDc_qp=ev_Fucc1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWr46YKripkCvFHO23k+0SUHfGgYBTDc_qp=ev_Fucc1Q@mail.gmail.com>

On Wed, Sep 16, 2026 at 10:59:31AM -0700, Ian Rogers wrote:
> On Wed, Sep 16, 2026 at 4:48 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > perf already uses debuginfod to fetch source files when annotating
> > (via probe-finder.c) and 'perf probe' has open_from_debuginfod(),
> > which queries debuginfo keyed by build ID when a module's debuginfo
> > isn't found locally, largely the same thing this adds; eventually
> > that one could be moved over to the new helper.  For the analysis
> > tools there was no way to obtain the debuginfo for a DSO in a
> > profile when it isn't available locally under the name the DSO was
> > opened with, for instance the vmlinux for the kernel a profile was
> > recorded on when processing it on another machine, or after the
> > kernel and its debuginfo package got upgraded in between.
> >
> > Add debuginfo__find_build_id(), that uses the debuginfod client to
> > locate a debuginfo file keyed by the build ID, checking its local
> > cache first and then querying the servers in DEBUGINFOD_URLS, and
> > debuginfo__new_build_id(), that opens the DWARF in the file it finds.
 
> When do we have a build ID but not a DSO? The current intent is that

Trying to parse this: Before we had a PERF_RECORD_MMAP with a dso name
that we, at the end, when enabled, would look for a build-id to add to
the perf.data headers, now we get both in the PERF_RECORD_MMAP3, right?

> dso__debuginfo hide these complexities. We currently don't purge DSOs

From the cache, right, and that is a problem, we need to do that LRU you
mention, to not have a ever growing cache.

There is a recent patch from someone at Uber about another aspect of
this, the symtabs loaded in memory for resolving symbols are not in any
way constrained, we go on loading, not purging, hope that patch gets
resubmitted addressing the sashiko reviews that were acknowledged.

> and the first call to dso__debuginfo should trigger loading with the
> DSO owning the debuginfo. With this change we now have a duplication
> of DSO's data, keyed by build ID and mapping directly to the
> debuginfo. I can't see a performance or efficiency gain and we could
> potentially implement some kind of LRU mechanism for DSOs, which would
> benefit memory usage for things like perf top.
 
> > The debuginfod client fails when DEBUGINFOD_URLS isn't set even when
> > what it wants is in its local cache, and the distro setup scripts that
> > populate it from /etc/debuginfod don't reach cron jobs, systemd services
> > and other environments that don't source the profile scripts, so also
> > set it from the .urls files in /etc/debuginfod when not set.
 
> I found the explanation above hard to follow. Are we setting an
> environment variable because debuginfod isn't respecting its /etc
> setup?

IIRC what I saw was the debuginfod client not finding things in the
cache when that DEBUGINFO_URLS variable wasn't set, so setting it
doesn't mean to ask for downloads necessarily, but to use what is
already cached locally.
 
> > That has
> > to happen before any thread that can call getenv() is started, as
> > setenv() is not thread safe, and there are getenv()s outside the fetch
> > lock: libdebuginfod reads DEBUGINFOD_URLS in every debuginfod_begin(),
> > which perf also does in build-id.c, probe-event.c and probe-finder.c,
> > so do it from symbol__init(), on the single-threaded setup, and not
> > lazily from the fetch path.
> >
> > Querying servers, possibly third party ones, sends off-box the build
> > IDs of the binaries being analysed and a fetch can take a while, so
> > this is opt-out: on by default, off with --no-debuginfod, with
> > core.debuginfod=false, per tool with report.debuginfod and
> > top.debuginfod, and, since users that set buildid.dir to /dev/null
> > (e.g. Linus) or otherwise turn the local build-id cache off clearly
> > don't want fetched files stored on the box, off too in that case.

> > The opt-outs also cover libdwfl's own debuginfod client, that reads
> > DEBUGINFOD_URLS in every query: when debuginfod is off, be it with
> > --no-debuginfod, core.debuginfod=false or by disabling the build-id
> > cache, the variable is set to the empty string, that the client treats
> > as an opt-out and fails the query without even looking at its cache,
> > instead of being exported from /etc/debuginfod.  Tools that manage
> > DEBUGINFOD_URLS themselves, such as 'perf record --debuginfod', keep
> > doing so.
 
> Libdwfl is part of elfutils and so is debuginfod. Is it possible to
> share clients?

We need to stop using ~/.debug/ and move to have the cache where elfutils
libraries have it.

Transitioning should just use ~/.debug if available but saving copies of
local DSOs like perf does in the elfutils cache directory.

<SNIP>
 
> > +static bool build_id__equal(const struct build_id *a, const struct build_id *b)
> > +{
> > +       return a->size == b->size && memcmp(a->data, b->data, a->size) == 0;
> > +}
> 
> This is probably worth moving to the build-id.[ch] file. I see similar
> logic in places like __dso_id__cmp,  dso__missing_buildid_cache in
> builitin-buildid-cache.c and sort__dcacheline_cmp. dso__build_id_equal
> has some special backward compatibility checks.

Agreed, will do.

- Arnaldo
