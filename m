Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C1258CF2;
	Fri, 24 Oct 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273017; cv=none; b=Fk/SvT4sQ/mJ4ewiTp29s7gN6HROqGAQte7S0+TdAo3VG7SW360TfXnXMv38/5Duw2jagNrMp7bKcPw0GnNQvhvm/OzAQOfcMJ8XtTVpDTG6wpK8lbxbYQoC5Jr6uVFNI0t7tWzoxufoNq4byhD3ErQlJbXWRc2DFXbGv4EsYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273017; c=relaxed/simple;
	bh=cRVH/Z2/F2hsw3RJ0lfDBMR70DwmivZ3OKy32kKwgiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYq1bCKo1tyrIZD3XmjQbbvVhwVTncFcAYe1O1mwGWiz53ZEHc9hw1TjRXsk9rj3OMXbaHM4RPA/tId0+KVhF9zefJAq45B06cnVTCkd3RzhhJoU5T0ShKtmDdaAu5p36+7xCLneFZWFGCaHAuuCOAiIGRvzu5ZZWuVHqUPDemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzQ7sgGG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzQ7sgGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48023C4CEE7;
	Fri, 24 Oct 2025 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761273016;
	bh=cRVH/Z2/F2hsw3RJ0lfDBMR70DwmivZ3OKy32kKwgiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzQ7sgGGKiM45lmLpEXO1CxhcDhiIry68VQ27cCukk8J3a1Hv8R1skKeIlNaJQ7OM
	 JVpfzuNTigfpn7QKiGSqyf8R1aoewY6Qn3dc3UBdSwK5PFpFu2RYxbqh58kMeyOUmJ
	 +MQkGJJdJD2FIGI0J+gm21uAH74XA3Q7eH1RkIEJVM525mivO8n8D4hCu8aLazStpa
	 WXDefLj8fmlEgwH79LdynEF7sWtBMqrJ7gLTyMQHgyV9sVcj+VUpc2w++AKGZwStBX
	 7IJSOtXKr0prvkMWqI1A9+dqPx/pon2+UIQKNwOMXJ7KMMxziffid4PnIdBf4FHdRU
	 oUuBotrNXQRfQ==
Date: Thu, 23 Oct 2025 19:30:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	thomas.falcon@intel.com, dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
Message-ID: <aPrktlANBHFtV52B@google.com>
References: <20251022220802.1335131-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022220802.1335131-1-zide.chen@intel.com>

Hello,

On Wed, Oct 22, 2025 at 03:08:02PM -0700, Zide Chen wrote:
> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> unconditionally called the precise_ip fallback and moved it after the
> missing-feature checks so that it could handle EINVAL as well.
> 
> However, this introduced an issue: after disabling missing features,
> the event could fail to open, which makes the subsequent precise_ip
> fallback useless since it will always fail.
> 
> For example, run the following command on Intel SPR:
> 
> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
> 
> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
> precise_ip == 3. It then sets attr.inherit = false, which triggers a

I'm curious about this part.  Why the kernel set 'inherit = false'?  IOW
how did the leader event (mem-loads-aux) succeed with inherit = true
then?

> kernel check failure since it doesn't match the group leader's inherit
> attribute. As a result, it continues to fail even after precise_ip is
> reduced.
> 
> By moving the precise_ip fallback earlier, this issue is resolved, as
> well as the kernel test robot report mentioned in commit
> c33aea446bf555ab.
> 
> No negative side effects are expected, because the precise_ip level is
> restored by evsel__precise_ip_fallback() if the fallback does not help.

I'm not sure.. some events may need a different (i.e. lower) precise
level than the max.  I think checking the missing feature later will
use the max precise level always.

Thanks,
Namhyung

> 
> This also aligns with commit 2b70702917337a8d ("perf tools: Remove
> evsel__handle_error_quirks()").
> 
> Fixes: af954f76eea56453 ("perf tools: Check fallback error and order")
> Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  tools/perf/util/evsel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ca74514c8707..6ce32533a213 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2714,12 +2714,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
>  		goto retry_open;
>  
> +	if (evsel__precise_ip_fallback(evsel))
> +		goto retry_open;
> +
>  	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
>  		goto fallback_missing_features;
>  
> -	if (evsel__precise_ip_fallback(evsel))
> -		goto retry_open;
> -
>  out_close:
>  	if (err)
>  		threads->err_thread = thread;
> -- 
> 2.51.0
> 
