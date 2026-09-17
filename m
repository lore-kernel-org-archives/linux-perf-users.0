Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1719B5A3;
	Thu, 17 Sep 2026 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677387; cv=none; b=KosQUnUC0nxTAvA1SCGpVSO1gjQ1wl1a1abSmAF3HUFPYXvSeZaQV8gFin0Pgysiu96Cmxn8AlnbDWS25ZpbMnx/M030uvoIrv+4X7N0W/Eq1OOeCbCxePMBZzZ3NFg4AbAcfUQ4UTUjb9V+7JKYt/clpFMvjyFTMm94GjxPeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677387; c=relaxed/simple;
	bh=tPCyor+JHLDDUIjP4KkxM3aba5e0XMrtIXroiCLatfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bn5AsKJQog7Llealb8icfPdjoBbiEJ/9XKJlnMyo4HT4EN0ZUm1/0IxxY1k13S61apIaQldMWptHRMjouwvIhuaoorSi291cIq4EcgSDyJ+5Y6ZDuklX8XSo7uMkx1r/4O2FxX+Rcc1zU9P/X9giQGBMDlsx1AKq293ucZO+FIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY0EhyQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY0EhyQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1591F000FF;
	Thu, 17 Sep 2026 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789677386;
	bh=IS3MlobcLlwKq9sudALzpq6hLvsrjlCQIngY2Cfeuy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SY0EhyQx5NhFVac0CZ8DGTvQizjgPG1/zvIYkMvbF9F0YkSYq/62Iv84k03YPqk6z
	 AYX9zCOG7nVtivJBwUM1c2LfRCcPXMXrZZJHbXgGxNeaLT3OGwyYT4IJkMjx33tR1X
	 Py5I0HR7r13NWTyTJ3m7fmqwnlgPLe+iN6GDvud7hol4Y8eXwH3hU0K7SXLLHt2GO1
	 N+AIqM8NDkx3ssOSAADbyaDCzOtVyOhYHccoPWQs2KdXuDeoc9nkdTgGlDlTJNx9/8
	 vgz7AXa8g1J8xf1CQBYU0/i1vzaT/tyamQLzzhcvRKJ4JC18TtlckrrpMhpvYAhgoA
	 Xcz4ukj4r6UNQ==
Date: Thu, 17 Sep 2026 17:36:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 01/15] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Message-ID: <aqxPRkwFMfQ_gJyq@x2>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-2-acme@kernel.org>
 <CAP-5=fX5+7K_9eApj-t87iFVSbUPZDpgnMYWfSoCcDynrYqixA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX5+7K_9eApj-t87iFVSbUPZDpgnMYWfSoCcDynrYqixA@mail.gmail.com>

On Thu, Sep 17, 2026 at 10:58:15AM -0700, Ian Rogers wrote:
> On Thu, Sep 17, 2026 at 8:55 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> 
> [snip]
> 
> > +/*
> > + * The build IDs already fetched in this session, and the path of the file
> > + * that came back for each, so that the repeated requests for the same build
> > + * ID, dso__debuginfo() is called per symbol annotated, are answered with a
> > + * strdup() instead of another client: the file is in the debuginfod client
> > + * cache already and its path checked before being handed out, in case that
> > + * cache is cleaned from under us.
> > + *
> > + * Guarded by debuginfod__fetch_lock.  Only a fetch that brought a file back
> > + * gets an entry: one that didn't is recorded in debuginfod__misses as a miss,
> > + * and that is what keeps the rest of the session from asking for it again.
> > + * Like debuginfod__misses this grows with the number of build IDs in the
> > + * workload, one small entry each, and is not trimmed.
> > + */
> > +struct debuginfo_lookup {
> > +       struct list_head         node;
> > +       struct build_id          bid;
> > +       char                    *path;
> > +};
> > +
> > +static LIST_HEAD(debuginfo_lookups);
> 
> I'd still prefer keeping the debuginfos owned by the DSOs rather than
> having debuginfo use a global cache of debuginfos - I expect the
> debuginfos to have some non-trivial memory overhead. With the
> debuginfo in the DSO, when/if the DSO goes away we can reclaim all the
> memory without worrying about a separate global data structure. We can
> find DSOs in multiple ways with dsos__findnew_id:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/dsos.c#n343
> We match by name, but if those differ:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/dsos.c#n117
> We match by inode and/or build ID:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/dso.c#n1473
> 
> So struct dsos is a build ID indexed store of DSOs and their owned
> debuginfo. We find DSOs off a machine, but I believe we always have
> access to the relevant struct machine. In the worst case for probes,
> for example, we need to set up a host machine. Using machines
> inherently provides some lock sharding, and they also have the ability
> to reclaim memory.

Working on it, no preference, so doing it the way you describe seems ok,
will post later.

- Arnaldo
