Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7092F24;
	Thu, 31 Jul 2025 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972080; cv=none; b=WtcKXUjaYSZz3ajNV9dTLVshBaxYAHWnJSZMEK4aBqk23kMDPsi1mOBL9bClb9FMcmjWq3jmiA/o6xoFnVvAY6yTkK3kPgAJkG2KkEzhTuw33X9KkSa7dZHNMG+oph9og7wCBbEbRz4dY5jG7o7MM9UjVmlt3fcIpUE4pCYNSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972080; c=relaxed/simple;
	bh=YvkhVEKHiFCSgueJOvMY7F1eqvA7abEEJmcPkLGjnQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcUGIK9/F/ThTsp4Q+i8TlFDaP5GnK5sUx03a0dvTVQWa9gQm9e+J8rJj9NmfHpnxgHvL2pzmBH/OM5n8ptA+YaXuJpRfD5bOM3VIRNO3WhK+vhiUtPc/Q5qbEKzIpZsBlEeBAD7bIJ1Vw4HJ2r8MRX9QeTDmFn7ZB29/AgJCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKkp0+1I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKkp0+1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB77BC4CEEF;
	Thu, 31 Jul 2025 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753972080;
	bh=YvkhVEKHiFCSgueJOvMY7F1eqvA7abEEJmcPkLGjnQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKkp0+1IYbpvCLpYlzgVyoLt1/WihpIu7UZZ5KgN1GwvmNr7imEGm/4RjlP5H/x6D
	 EbShJT5h+yBNklWfOKmAvVfLJZ9mtCr5EpwNzg9LsMUCCxd2kJ6KXpnoKekfmNmyOK
	 yT7feSGie8f9aqBlme4SJ0bs3Dx/t8LunM85Mze35kRfK2TDrvs36VmFXuvsvZf98i
	 10K1l3N5QPueUc7y3mkV3BXVQfaMihXZSM9nyL8E6jsBzk/P1XCgkFHGAc7Lv6clxX
	 Axkc5kz6WYZ6x0M+3lgffXYDMRoh9qlPOGnzDZD8LY2Zcil/nrCzo8hgumB0pQlVmq
	 nJUB6GIRS90Bw==
Date: Thu, 31 Jul 2025 11:27:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf record: Cache build-ID of hit DSOs only
Message-ID: <aIt9bTQhAo8G3oqH@x1>
References: <20250731070330.57116-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731070330.57116-1-namhyung@kernel.org>

On Thu, Jul 31, 2025 at 12:03:30AM -0700, Namhyung Kim wrote:
> It post-processes samples to find which DSO has samples.  Based on that
> info, it can save used DSOs in the build-ID cache directory.  But for
> some reason, it saves all DSOs without checking the hit mark.  Skipping
> unused DSOs can give some speedup especially with --buildid-mmap being
> default.
 
> On my idle machine, `time perf record -a sleep 1` goes down from 3 sec
> to 1.5 sec with this change.

Good stuff, and this is in line with the original intent, don't cache
uninteresting things.

But now I have do some digging, as this should've been the case since
the start, why would we go to the trouble of traversing perf.data,
processing all samples, yadda, yadda to then not look at it when caching
files?

The whole process of reading the build ids at the end is done here:

bool dsos__read_build_ids(struct dsos *dsos, bool with_hits)
{
        struct dsos__read_build_ids_cb_args args = {
                .with_hits = with_hits,
                .have_build_id = false,
        };

        dsos__for_each_dso(dsos, dsos__read_build_ids_cb, &args);
        return args.have_build_id;
}

And that dsos__read_build_ids_cb thing specifically looks at:

static int dsos__read_build_ids_cb(struct dso *dso, void *data)
{
        struct dsos__read_build_ids_cb_args *args = data;
        struct nscookie nsc;
        struct build_id bid = { .size = 0, };
                                
        if (args->with_hits && !dso__hit(dso) && !dso__is_vdso(dso))
                return 0;
<SNIP>

So it will not try to read the build id if that DSO has no samples.

But, that was written before PERF_RECORD_MMAP* came with a build-id, so
it _will_ have a build-id and thus checking if it has hits is needed.

In the past DSOs without hits wouldn't have a build-id because
dsos__read_build_ids_cb() would not read that build-id from the ELF
file.

Ok, now that makes sense:

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

This could have a Fixes attached to it, one that doesn't fixes something
that is not working, but speeds up processing by overcoming an oversight
when adding build-ids to MMAP records, so I think a:

Fixes: e29386c8f7d71fa5 ("perf record: Add --buildid-mmap option to enable PERF_RECORD_MMAP2's build id")

Is worth.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/build-id.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index e2b295fe4d2fe552..a7018a3b0437a699 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -872,7 +872,7 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
>  	char *allocated_name = NULL;
>  	int ret = 0;
>  
> -	if (!dso__has_build_id(dso))
> +	if (!dso__has_build_id(dso) || !dso__hit(dso))
>  		return 0;
>  
>  	if (dso__is_kcore(dso)) {
> -- 
> 2.50.1
