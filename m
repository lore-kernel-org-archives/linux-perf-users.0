Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273FBE6C;
	Thu, 31 Jul 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982991; cv=none; b=mGE8nskJWJjkdsQ/N1EmI8w176R+RXWXXTnzRZO06njI+wyBMyfdlYuKfwm2PEOXSGvqGw9Db55swOCuX+3CO7oaKbuYhWKnZIOGv8vIJTCPf/sbvU9+KNeNKFraIpDPCqvQUNQfWoUjtOHS2AsX+D9Ffd5FJzqdxyU5LSpvQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982991; c=relaxed/simple;
	bh=e5jgqySpdEc4DwpBdabTILVgcW1l93r2WSzWO8xi3Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMKb5TAurW+PdkPkQjiaAQZU0hsYaKa88Z5rNQJy666spqKWnJbEtOCCNf/iTPVR/BDMkHq+QU8z1M5QqAM39ez4BAAY0zisk5pjTyp9mj80z0q0aJ1gNSjMQ28Ah7K7ixupIPXq8KEN7dFuOWIo6ykT4gSQflyK47R1zV0QZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGAtKN7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGAtKN7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67736C4CEEF;
	Thu, 31 Jul 2025 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753982990;
	bh=e5jgqySpdEc4DwpBdabTILVgcW1l93r2WSzWO8xi3Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGAtKN7S7xTbKzvf38ip2eImWsn6Nv0qA7JAHFPWckwXwdgWGGYBoGwzxDZrG5Aqx
	 hfEFXcIZB/RlE59doUj9pZ8moEM0TqUEDnTh8p/N704V8pNUIgQxczxPaACnQYCNnO
	 8AXNO1cUYRFTsM+3FSASljIxgubgcSGGXurg6/orL3JM4eqror9OZbsV3z/YojyeQZ
	 SovK2Zk0WFGjmB5/b2u1OEfJG/SZfomitGW10f1NYEqErkbABiakadcz4SaZN4JdgC
	 caFg2gQw6KGgktkBztYXc3J5bRpz6ZDieZ0RAt3oAX+WZAYDOtLpvW/ZhpmwuXzUw8
	 QNIa9Dd01K+9g==
Date: Thu, 31 Jul 2025 10:29:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf record: Cache build-ID of hit DSOs only
Message-ID: <aIuoDHBGeoFYF2fh@google.com>
References: <20250731070330.57116-1-namhyung@kernel.org>
 <aIt9bTQhAo8G3oqH@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIt9bTQhAo8G3oqH@x1>

Hi Arnaldo,

On Thu, Jul 31, 2025 at 11:27:57AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jul 31, 2025 at 12:03:30AM -0700, Namhyung Kim wrote:
> > It post-processes samples to find which DSO has samples.  Based on that
> > info, it can save used DSOs in the build-ID cache directory.  But for
> > some reason, it saves all DSOs without checking the hit mark.  Skipping
> > unused DSOs can give some speedup especially with --buildid-mmap being
> > default.
>  
> > On my idle machine, `time perf record -a sleep 1` goes down from 3 sec
> > to 1.5 sec with this change.
> 
> Good stuff, and this is in line with the original intent, don't cache
> uninteresting things.
> 
> But now I have do some digging, as this should've been the case since
> the start, why would we go to the trouble of traversing perf.data,
> processing all samples, yadda, yadda to then not look at it when caching
> files?
> 
> The whole process of reading the build ids at the end is done here:
> 
> bool dsos__read_build_ids(struct dsos *dsos, bool with_hits)
> {
>         struct dsos__read_build_ids_cb_args args = {
>                 .with_hits = with_hits,
>                 .have_build_id = false,
>         };
> 
>         dsos__for_each_dso(dsos, dsos__read_build_ids_cb, &args);
>         return args.have_build_id;
> }
> 
> And that dsos__read_build_ids_cb thing specifically looks at:
> 
> static int dsos__read_build_ids_cb(struct dso *dso, void *data)
> {
>         struct dsos__read_build_ids_cb_args *args = data;
>         struct nscookie nsc;
>         struct build_id bid = { .size = 0, };
>                                 
>         if (args->with_hits && !dso__hit(dso) && !dso__is_vdso(dso))
>                 return 0;
> <SNIP>
> 
> So it will not try to read the build id if that DSO has no samples.
> 
> But, that was written before PERF_RECORD_MMAP* came with a build-id, so
> it _will_ have a build-id and thus checking if it has hits is needed.
> 
> In the past DSOs without hits wouldn't have a build-id because
> dsos__read_build_ids_cb() would not read that build-id from the ELF
> file.

Yep, I think that's the reason.

> 
> Ok, now that makes sense:
> 
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!

> 
> This could have a Fixes attached to it, one that doesn't fixes something
> that is not working, but speeds up processing by overcoming an oversight
> when adding build-ids to MMAP records, so I think a:
> 
> Fixes: e29386c8f7d71fa5 ("perf record: Add --buildid-mmap option to enable PERF_RECORD_MMAP2's build id")
> 
> Is worth.

Sure, will add.

Thanks,
Namhyung
