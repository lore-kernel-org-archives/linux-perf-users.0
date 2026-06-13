Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC417736;
	Sat, 13 Jun 2026 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309944; cv=none; b=k/f3LzqvcxFkDrgKELxodiiD2sgOUcyeq8O15yDgGgDR704x1oaeu1A4ycuSOwwgX5Tonhi/f8XRUvPIKrSCdr5cU8aYHDxcTbyyf0uxrQrXSSipO0zYFWU2ViESMlXuQhDKbj4AqQgb4uxys5UyWox/cP+G9sZMHemB4qaneOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309944; c=relaxed/simple;
	bh=s9wEgyjdhRfjH5C13CwDAayeGuBy1soYrmTfgHHAGOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF15ckJOAytbzDf5bN8uXNUbnOGrczK7HZaA3gWmtuXMwatjvhXRAVLGlk6UmSJkZiG9tVGELU567afjguidwN5t+Nbi0dWyztE9jTW6Pv/8QI5eiOnOGZ/HIO7NrJgrMLRSG7EumHLajeyL5agFK4nWMUGXoRwYhRUjSpwcGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdbZYmEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdbZYmEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AB21F000E9;
	Sat, 13 Jun 2026 00:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781309942;
	bh=1+W/nE4Enrv8b0fiQweSEVaYEqxXed0vyvV8mWsyMyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cdbZYmEHq/You/7EjCW8eeyHtbBVLm9Wm/OwaT1IYZgqWkInawKQMSgG1cOSlCqMR
	 YtleIInoq6Rx0hyxTeaM5aX4n8sCJSk1mgvSCMweGJzp9oN7z/NQ+ebjLHSXV3Wqq3
	 AsdograxtjsOXDY2u+1VfU2XErZWuCHuX3aJB8BOQSpRrIIPVA7RJV4SoIV8z08Bpl
	 L4zxlCRhk6lenlh3vvWPddCwH/rjyndwdJmG43DDJJtqFc2W9V9rTcSUDRS62hFbbj
	 VjrlP3wWG2i3aRnBUxcGIAQndnAUlgkHBdEtBdqCkBxDyHruHVKpeK5GpEXkaZMojt
	 tlOZwgTMy0UBw==
Date: Fri, 12 Jun 2026 21:18:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v20 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Message-ID: <aiyh8wqvs81vdxeu@x1>
References: <20260611164122.3974068-3-irogers@google.com>
 <20260611172823.1999F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611172823.1999F1F00893@smtp.kernel.org>

On Thu, Jun 11, 2026 at 05:28:22PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Heap out-of-bounds read/write in `perf_event__repipe_attr` via TOCTOU race condition
> --
> 
> commit 0ecff6d57b51709063f6cde26a7febea45ab1d6a
> Author: Ian Rogers <irogers@google.com>
> 
> perf inject: Add ASLR virtual address remapping
> 
> This patch introduces the core ASLR remapping tool infrastructure and
> implements remapping/tracking for metadata events. Sample events are
> delegated without remapping for now.
> 
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index 75ffe31d03fe..8bb37095e2de 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -234,20 +237,36 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
> >  	u64 *ids;
> >  	int ret;
> >  
> > +	union perf_event *aslr_event = NULL;
> > +
> >  	ret = perf_event__process_attr(tool, event, pevlist);
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (inject->aslr) {
> > +		aslr_event = malloc(event->header.size);
> > +		if (!aslr_event)
> > +			return -ENOMEM;
> > +		memcpy(aslr_event, event, event->header.size);

Don't we have memdup? I.e.

		aslr_event = memdup(event, event->header.size);
		if (!aslr_event)
			return -ENOMEM;

> > +		aslr_tool__strip_attr_event(aslr_event, pevlist);
> > +		event = aslr_event;
> > +	}
> 
> [Severity: Medium]
> Could this introduce a TOCTOU (Time-Of-Check to Time-Of-Use) race condition?
> 
> Since event points directly to the memory-mapped perf.data file contents,
> reading event->header.size multiple times without READ_ONCE allows a
> concurrent modification to change the size between the malloc() and memcpy()
> calls.
> 
> This could result in a heap buffer overflow during memcpy(), or bypass the
> earlier size validation done in perf_event__process_attr(). This would leave
> malicious sizes in the copied event->attr.attr.size for
> aslr_tool__strip_attr_event() to blindly trust.
> 
> > diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> > new file mode 100644
> > index 000000000000..56fc444fbf54
> > --- /dev/null
> > +++ b/tools/perf/util/aslr.c
> [ ... ]
> > +void aslr_tool__strip_attr_event(union perf_event *event, struct evlist **pevlist __maybe_unused)
> > +{
> > +	u32 attr_size;
> > +
> > +	attr_size = event->attr.attr.size ?: PERF_ATTR_SIZE_VER0;

Not for now, but this is a common pattern, we should eventually have:

	u32 attr_size = perf_event_attr__size(&event->attr);

acme@x1:~/git/perf-tools-next$ git grep '?: PERF_ATTR_SIZE_VER0'
tools/perf/builtin-inject.c:    attr_size = raw_attr_size ?: PERF_ATTR_SIZE_VER0;
tools/perf/util/header.c:       attr_size = raw_attr_size ?: PERF_ATTR_SIZE_VER0;
tools/perf/util/perf_event_attr_fprintf.c:      u32 attr_size = attr->size ?: PERF_ATTR_SIZE_VER0;
acme@x1:~/git/perf-tools-next$

And now the one in this series.

> > +	if (attr_size >= (offsetof(struct perf_event_attr, sample_type) + sizeof(u64))) {
> > +		event->attr.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
> > +	}
> > +
> > +	if (attr_size >= (offsetof(struct perf_event_attr, type) + sizeof(u32))) {
> > +		u32 type = event->attr.attr.type;
> > +
> > +		if (type == PERF_TYPE_BREAKPOINT &&
> > +		    attr_size >= (offsetof(struct perf_event_attr, bp_addr) + sizeof(u64))) {
> > +			event->attr.attr.bp_addr = 0;
> > +		} else if (type >= PERF_TYPE_MAX) {
> > +			struct perf_pmu *pmu;
> > +
> > +			pmu = perf_pmus__find_by_type(type);
> > +			if (pmu && (!strcmp(pmu->name, "kprobe") ||
> > +				    !strcmp(pmu->name, "uprobe"))) {
> > +				if (attr_size >= (offsetof(struct perf_event_attr, config1) + sizeof(u64)))
> > +					event->attr.attr.config1 = 0;
> > +				if (attr_size >= (offsetof(struct perf_event_attr, config2) + sizeof(u64)))
> > +					event->attr.attr.config2 = 0;
> 
> [Severity: Medium]
> If a malicious size is copied into the heap buffer due to the TOCTOU race in
> perf_event__repipe_attr(), does this code perform an out-of-bounds write?
> 
> Since aslr_tool__strip_attr_event() implicitly trusts the attr_size read
> from the heap copy, clearing config1 and config2 could overwrite adjacent
> heap memory if attr_size is large, but the actual allocated
> event->header.size was small.
> 
> > +			}
> > +		}
> > +	}
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260611164122.3974068-1-irogers@google.com?part=2
