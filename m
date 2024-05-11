Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C859168;
	Sat, 11 May 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443222; cv=none; b=hCxZtEH1IelOSMPWK3zCGT8sckaCGeZm4ELkRXFC51zryFL5wxVMuJnKMVMtspmv6LQs5PAMiHQf72qxX0mPbdSVi495gZ609GEAAiowzpCe/qOEvouvrkkuKLCdE/ZnYElijYZo+7HRmo6oofh0zl3v41JJAXltCab8LG9l61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443222; c=relaxed/simple;
	bh=4RU5pmRcasLa6t1vQtWaBBhz5hmNj4hjlUm6xeEFBYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Abr68oAOYLO/HFJVxIjBe+RqascvqofELwJGYbXo2z/kM+kDp6VJiiutZuVARN0dBpaBoRyhAq6qtLSrEiVawakUOl1a+Qe/bwcODo914BWY5C4Vua0hjSY9pjhYfmDRKx7mdLlwdzXOJw52TSkY49jeFV+TeXX1z2EV/P4J9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbKFK7Nk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbKFK7Nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2747C2BD11;
	Sat, 11 May 2024 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715443222;
	bh=4RU5pmRcasLa6t1vQtWaBBhz5hmNj4hjlUm6xeEFBYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbKFK7NkcUtfy8eyfMICBL7Y5FjoJ4D+wkK79WT0kd4QDXPyrKvv3EeWCCXIcCTj9
	 cMoBUHh8IAfajolbibai/xk+c7rViLljrhZvRuO11fjLaBUcoIH9RdTK8TwgILQ9Co
	 xfNs1Y2eXkeLNCU31UKOMP9gIPN7CWFUcd+Hd/MjCY5ccuAObxL/1wLHscOZSeBGGF
	 CJ3h2jia4LiXhGG1QBIkQKJux44DjNnpVL5GELkRiqUTI0BOr5DM6ax73GzlzLSJDI
	 Bec73GXmWEXEzEJyjSCUy7pWMK3nMehh4xK/wR75YU98EAw++9pSOqrYSp9dsR5K1k
	 DQV+ntdJrAVCA==
Date: Sat, 11 May 2024 13:00:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf list: Fix the --no-desc option
Message-ID: <Zj-WE1aG7ihtevG3@x1>
References: <20240508133518.3204221-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508133518.3204221-1-leitao@debian.org>

On Wed, May 08, 2024 at 06:35:17AM -0700, Breno Leitao wrote:
> Currently, the --no-desc option in perf list isn't functioning as
> intended.
> 
> This issue arises from the overwriting of struct option->desc with the
> opposite value of struct option->long_desc. Consequently, whatever
> parse_options() returns at struct option->desc gets overridden later,
> rendering the --desc or --no-desc arguments ineffective.
> 
> To resolve this, set ->desc as true by default and allow parse_options()
> to adjust it accordingly. This adjustment will fix the --no-desc
> option while preserving the functionality of the other parameters.


Thanks, applied to perf-tools-next, and added this:

    Committer testing:
    
    Before:
    
      $ perf list --no-desc
      <SNIP>
      cache:
        longest_lat_cache.miss
             [Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis. Unit: cpu_atom]
        longest_lat_cache.reference
             [Counts the number of cacheable memory requests that access the LLC. Counts on a per core basis. Unit: cpu_atom]
        mem_bound_stalls.ifetch
             [Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the L2,LLC,DRAM or MMIO (Non-DRAM). Unit: cpu_atom]
        mem_bound_stalls.ifetch_dram_hit
             [Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non-DRAM). Unit: cpu_atom]
        mem_bound_stalls.ifetch_l2_hit
             [Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the L2 cache. Unit: cpu_atom]
        mem_bound_stalls.ifetch_llc_hit
             [Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the LLC or other core with HITE/F/M. Unit: cpu_atom]
      <SNIP>
    
    After:
    
      $ perf list --no-desc
      <SNIP>
        cache:
        longest_lat_cache.miss
        longest_lat_cache.reference
        mem_bound_stalls.ifetch
        mem_bound_stalls.ifetch_dram_hit
        mem_bound_stalls.ifetch_l2_hit
        mem_bound_stalls.ifetch_llc_hit
      <SNIP>
    
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/perf/builtin-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 02bf608d585e..58589f67e800 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -491,6 +491,7 @@ int cmd_list(int argc, const char **argv)
>  	int i, ret = 0;
>  	struct print_state default_ps = {
>  		.fp = stdout,
> +		.desc = true,
>  	};
>  	struct print_state json_ps = {
>  		.fp = stdout,
> @@ -563,7 +564,6 @@ int cmd_list(int argc, const char **argv)
>  		};
>  		ps = &json_ps;
>  	} else {
> -		default_ps.desc = !default_ps.long_desc;
>  		default_ps.last_topic = strdup("");
>  		assert(default_ps.last_topic);
>  		default_ps.visited_metrics = strlist__new(NULL, NULL);
> -- 
> 2.43.0
