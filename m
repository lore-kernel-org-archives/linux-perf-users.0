Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60115666D;
	Mon, 30 Sep 2024 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728573; cv=none; b=p1EdbLg5zZgVMYs55TxQ9dPIKrs7GDTZtCJxtdvifxItXLJfi3y2f2AlnTBkTXNlJrl02afxnqQdpp06B+HapsckS+kCuOXX7gMU997OXE9KXipch3BKTGzRtE+xqfQL6D+TQ8+Ci2Bh7fNqPcEQcaI6lhT2CZ/nU1s1hV/XU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728573; c=relaxed/simple;
	bh=dL2IXov3kbWzZfnnbaP79rYJ267Xn3W7OnSInDerbQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBBf0I+5cwUArelr+lUtwOoXHKrYZaL2b0JslktzansKSLhUbAPDXlVrNXrk29CEdka/X9v6xTAlQ7aOSrG7vWobmqiWANFI7GiuYrVEyi6ijduPaPv7F7ttjQMdjI6jrjhgjPxPt9yEJIGzTysfX8N7dOwDKVl/JAYGoaS1RcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSCQwSGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSCQwSGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA9CC4CED0;
	Mon, 30 Sep 2024 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727728573;
	bh=dL2IXov3kbWzZfnnbaP79rYJ267Xn3W7OnSInDerbQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSCQwSGBakjvfgc5ANc8IyQ4y88TkJKkH83ubH8h5nHMWNQ3gNzUofg4X0wJIpzBH
	 56aYzkNpd2C6YfVWYjL4HQCoqHBCVxBTLkZUtGyR3JncltF4gO/iG+JZfhoT7mQ+pn
	 KJVPSnSoAESOcffN5i1/kYTsq8LcWco6VhH6nANra4sQ97RN6SjjuPPXaORIckScn1
	 h7nzBR+PuJEk60IRfFCAI1tOKBDfyxbLwSmrpqmkoXhP/RER+uS3sQMZG+z1x64alY
	 ++JawD4/QZrSq/IXD7LAzstXznWCGF4d1RY/r2H1Q3rHVtGOmB3fUlScvGbz8Pu+Lg
	 L68Bcadg3gkIw==
Date: Mon, 30 Sep 2024 13:36:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
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
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH 01/10] perf tools: Add fallback for exclude_guest
Message-ID: <ZvsLu7-avQHVvp7c@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-2-namhyung@kernel.org>
 <f171c2e5-3468-4cdb-b369-87e5aeb6660b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f171c2e5-3468-4cdb-b369-87e5aeb6660b@linux.intel.com>

On Fri, Sep 06, 2024 at 09:47:53AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
> > Commit 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
> > changed to parse "cycles:P" event instead of creating a new cycles
> > event for perf record.  But it also changed the way how modifiers are
> > handled so it doesn't set the exclude_guest bit by default.
> > 
> > It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
> > if not.  Let's add a fallback so that it can work with default events.
> > 
> > Fixes: 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c |  3 +--
> >  tools/perf/util/evsel.c   | 21 +++++++++++++++++++++
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index cf985cdb9a6ee588..d8315dae930184ba 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -639,8 +639,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
> >  	 * (behavior changed with commit b0a873e).
> >  	 */
> >  	if (errno == EINVAL || errno == ENOSYS ||
> > -	    errno == ENOENT || errno == EOPNOTSUPP ||
> > -	    errno == ENXIO) {
> > +	    errno == ENOENT || errno == ENXIO) {
> >  		if (verbose > 0)
> >  			ui__warning("%s event is not supported by the kernel.\n",
> >  				    evsel__name(counter));
> 
> It seems the behavior for other reasons which trigger the 'EOPNOTSUPP'
> is changed as well.
> At least, it looks like we don't skip the member event with EOPNOTSUPP
> anymore.
> 
> I'm not sure if it's a big deal. But I think we'd better mention it in
> the change log or the comments.

Yeah I think it should handle EOPNOTSUPP at the end of the function to
maintain the behavior.  Still it's not exactly the same but I think the
skippable case is ok.  Thanks for pointing this out.

Thanks,
Namhyung

> 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 49cc71511c0c8ce8..d59ad76b28758906 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3244,6 +3244,27 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
> >  		evsel->core.attr.exclude_kernel = 1;
> >  		evsel->core.attr.exclude_hv     = 1;
> >  
> > +		return true;
> > +	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
> > +		   !evsel->exclude_GH) {
> > +		const char *name = evsel__name(evsel);
> > +		char *new_name;
> > +		const char *sep = ":";
> > +
> > +		/* Is there already the separator in the name. */
> > +		if (strchr(name, '/') ||
> > +		    (strchr(name, ':') && !evsel->is_libpfm_event))
> > +			sep = "";
> > +
> > +		if (asprintf(&new_name, "%s%sH", name, sep) < 0)
> > +			return false;
> > +
> > +		free(evsel->name);
> > +		evsel->name = new_name;
> > +		/* Apple M1 requires exclude_guest */
> > +		scnprintf(msg, msgsize, "trying to fall back to excluding guest samples");
> > +		evsel->core.attr.exclude_guest = 1;
> > +
> >  		return true;
> >  	}
> >  
