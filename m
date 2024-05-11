Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE31B7F7;
	Sat, 11 May 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715448357; cv=none; b=EXVVkkaDjwGB+uOCLhLNd5SMRJfSCMcW3H7k94fBQD04gqCE2+C2Y//UTskp0aYVPf2jHzBXztPJtBf+WNElMHInWehSGLSVTKLpoUAWiFtqLYMtT/DUZb4Ny8rfHLqil9sqsvvQBeYVkujY3ef6jER46PX56jIgc7Uv9+nxA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715448357; c=relaxed/simple;
	bh=aL3mmxLvwuw3oHrq+8iQZnMxFxtXlmbmE4RA55WoXDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+sC77DuSO5mtNeu53Nyn/Np3M71RfekcKAGPL502Exz3yNnQf6Z8+GrAoxFYAFhucKfAKSEj/50Ge6WmIWSHLUv9rSaFK+b2jXSWynhtpE+064Mr8oeVqQB3zoQrY0EMyfpAauIo73OgmNvD7CACaxkYrLE3TPOXNqK4BlUta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGzbM93d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGzbM93d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B339C2BBFC;
	Sat, 11 May 2024 17:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715448356;
	bh=aL3mmxLvwuw3oHrq+8iQZnMxFxtXlmbmE4RA55WoXDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGzbM93dmJZR2TWr8nOkCBNZitkkYBjMoKdW4a97qEilIP512QlirK7SKk7vi6mAj
	 +5fwPi9IhOldE2siZVmd+Kszu7lxzMGELuCEVmua2XfjGSzoxagEUxSceu0/1LPw1B
	 wvP4hgTCgbgYhfG8n4J1wEa7n+gRYT+iqpZbA4COdIGhECvkN2Ko3lXZYrSBil8g3O
	 pX1izWtx7M+a2/c1TzPtA7kVIauaS1+yseDUvagmNHTgqTPy6XM5XZk+ZPkJCUthl0
	 ailMD7XN0d6K2bMT3Dw3YJ9xH9dUCxcp7NWPKiz2hA8/rC7UUk5hOsDSG3beyLh7NO
	 mT/MeFTfD4yog==
Date: Sat, 11 May 2024 14:25:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf list: Fix the --no-desc option
Message-ID: <Zj-qIbUN2XFBnvP8@x1>
References: <20240508133518.3204221-1-leitao@debian.org>
 <Zj-WE1aG7ihtevG3@x1>
 <CAP-5=fXXYVgb4rnftaiTZTEniGOr5NnpfXJFNqX96GXP6=oTiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXXYVgb4rnftaiTZTEniGOr5NnpfXJFNqX96GXP6=oTiA@mail.gmail.com>

On Sat, May 11, 2024 at 09:11:00AM -0700, Ian Rogers wrote:
>    On Sat, May 11, 2024, 9:00 AM Arnaldo Carvalho de Melo
>    <[1]acme@kernel.org> wrote:
> 
>      On Wed, May 08, 2024 at 06:35:17AM -0700, Breno Leitao wrote:
>      > Currently, the --no-desc option in perf list isn't functioning as
>      > intended.
>      >
>      > This issue arises from the overwriting of struct option->desc with
>      the
>      > opposite value of struct option->long_desc. Consequently, whatever
>      > parse_options() returns at struct option->desc gets overridden
>      later,
>      > rendering the --desc or --no-desc arguments ineffective.
>      >
>      > To resolve this, set ->desc as true by default and allow
>      parse_options()
>      > to adjust it accordingly. This adjustment will fix the --no-desc
>      > option while preserving the functionality of the other parameters.
> 
>      Thanks, applied to perf-tools-next, and added this:
> 
>          Committer testing:
> 
>          Before:
> 
>            $ perf list --no-desc
>            <SNIP>
>            cache:
>              longest_lat_cache.miss
>                   [Counts the number of cacheable memory requests that
>      miss in the LLC. Counts on a per core basis. Unit: cpu_atom]
>              longest_lat_cache.reference
>                   [Counts the number of cacheable memory requests that
>      access the LLC. Counts on a per core basis. Unit: cpu_atom]
>              mem_bound_stalls.ifetch
>                   [Counts the number of cycles the core is stalled due to
>      an instruction cache or TLB miss which hit in the L2,LLC,DRAM or
>      MMIO (Non-DRAM). Unit: cpu_atom]
>              mem_bound_stalls.ifetch_dram_hit
>                   [Counts the number of cycles the core is stalled due to
>      an instruction cache or TLB miss which hit in DRAM or MMIO
>      (Non-DRAM). Unit: cpu_atom]
>              mem_bound_stalls.ifetch_l2_hit
>                   [Counts the number of cycles the core is stalled due to
>      an instruction cache or TLB miss which hit in the L2 cache. Unit:
>      cpu_atom]
>              mem_bound_stalls.ifetch_llc_hit
>                   [Counts the number of cycles the core is stalled due to
>      an instruction cache or TLB miss which hit in the LLC or other core
>      with HITE/F/M. Unit: cpu_atom]
>            <SNIP>
> 
>          After:
> 
>            $ perf list --no-desc
>            <SNIP>
>              cache:
>              longest_lat_cache.miss
>              longest_lat_cache.reference
>              mem_bound_stalls.ifetch
>              mem_bound_stalls.ifetch_dram_hit
>              mem_bound_stalls.ifetch_l2_hit
>              mem_bound_stalls.ifetch_llc_hit
>            <SNIP>
> 
>          Signed-off-by: Breno Leitao <[2]leitao@debian.org>
>          Tested-by: Arnaldo Carvalho de Melo <[3]acme@redhat.com>
> 
>      - Arnaldo
> 
>      > Signed-off-by: Breno Leitao <[4]leitao@debian.org>
>      > ---
>      >  tools/perf/builtin-list.c | 2 +-
>      >  1 file changed, 1 insertion(+), 1 deletion(-)
>      >
>      > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
>      > index 02bf608d585e..58589f67e800 100644
>      > --- a/tools/perf/builtin-list.c
>      > +++ b/tools/perf/builtin-list.c
>      > @@ -491,6 +491,7 @@ int cmd_list(int argc, const char **argv)
>      >       int i, ret = 0;
>      >       struct print_state default_ps = {
>      >               .fp = stdout,
>      > +             .desc = true,
>      >       };
>      >       struct print_state json_ps = {
>      >               .fp = stdout,
>      > @@ -563,7 +564,6 @@ int cmd_list(int argc, const char **argv)
>      >               };
>      >               ps = &json_ps;
>      >       } else {
>      > -             default_ps.desc = !default_ps.long_desc;
> 
>    Given this, did you test the long description behavior?

So, without the patch:

perf list
<SNIP>
cache:
  longest_lat_cache.miss
       [Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis. Unit: cpu_atom]
<SNIP>

perf list --long-desc
<SNIP>
cache:
  longest_lat_cache.miss
       [Counts the number of cacheable memory requests that miss in the Last Level Cache (LLC). Requests include demand loads,reads for ownership (RFO),instruction fetches and L1 HW
        prefetches. If the platform has an L3 cache,the LLC is the L3 cache,otherwise it is the L2 cache. Counts on a per core basis]
<SNIP>

perf list --no-desc
<SNIP>
cache:
  longest_lat_cache.miss
       [Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis. Unit: cpu_atom]
<SNIP>

With Breno's patch the default doesn't change, --no-desc gets fixed but
--long-desc is broken:

perf list --long-desc
<SNIP>
cache:
  longest_lat_cache.miss
       [Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis. Unit: cpu_atom]
       [Counts the number of cacheable memory requests that miss in the Last Level Cache (LLC). Requests include demand loads,reads for ownership (RFO),instruction fetches and L1 HW
        prefetches. If the platform has an L3 cache,the LLC is the L3 cache,otherwise it is the L2 cache. Counts on a per core basis]
<SNIP>

Thanks for asking the question, I'm dropping the patch, Breno, can you
try again?

- Arnaldo
