Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6570830;
	Thu, 19 Dec 2024 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734585293; cv=none; b=DXAFe4i8i1tFQP80+OXeKBHu+MGfZxYvnlqdto0ScrBtNmE6DSG7wtPsjC2IES9qOKLkxEe/BCSm9I4BjE6kjOwBVFId9yy5OH/fRoNUkysewCcxIRvs5RevRNLkUJtg+yH39jDq5V7oVIKmkUqHDpIXChC9B8oIYPEVzxs6hYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734585293; c=relaxed/simple;
	bh=9S/SXSTlpgwmKEOP7Bq6jxmZxOTOOZbtIeLPyJXyrjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyX33gLKl/PDnk5omN7OOsr7YdliNaz6h4MDcs8/i1+8W38Y4uEBhW3RV6mDaqHIw3JSYq+qHp7pQS/+8fjL/JCACFiAfkJ1fC3yleIXDOlMSZHde4jYG46uDZn+0P7Lwkev6WbbaGJBizw9F58jnU7sDCQ04IZyQ8XJ72U6uKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnOIMm8g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnOIMm8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDE5C4CED0;
	Thu, 19 Dec 2024 05:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734585292;
	bh=9S/SXSTlpgwmKEOP7Bq6jxmZxOTOOZbtIeLPyJXyrjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnOIMm8gJLiPDN9yZvyb9m8yXYRDDWWAhs/gNeOZnBSz6I2g5t1tEakcrzDl5tsyr
	 UQzcDVl3f+IORiFXKLgMTTnzVoJ09UUASfSaVW/d+/0QGHnRWUcHiJRmMAsNNhboEW
	 MfozyPcC/KWo31eMhVC4vzx/QUYA4YTYjY6RQJ3nDgIY7u6cXNUsWe+WT8Oh45vKA9
	 OlpgNV+DIs84Zzouu2ltzKcLBbejDgN4sIrnvOI2aqRaFUtnlfGwbP2rc1xaHJ7QzH
	 aTHNpBFEhqxeRUzYCPIG3Wye2VisKHxqHKh+TA+SlQGqsenFWYoSog+lBrgSHZZjf8
	 IcghgUVf4V0gg==
Date: Wed, 18 Dec 2024 21:14:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cpumap: Fix die and cluster IDs
Message-ID: <Z2OryhgI8IpxktAG@google.com>
References: <20241218115552.912517-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218115552.912517-1-james.clark@linaro.org>

Hello,

On Wed, Dec 18, 2024 at 11:55:51AM +0000, James Clark wrote:
> Now that filename__read_int() returns -errno instead of -1 these
> statements need to be updated otherwise error values will be used as
> die IDs.
> 
> This appears as a -2 die ID when the platform doesn't export one:
> 
>   $ perf stat --per-core -a -- true
> 
>   S36-D-2-C0            1               9.45 msec cpu-clock
> 
> And the session topology test fails:
> 
>   $ perf test -vvv topology
> 
>   CPU 0, core 0, socket 36
>   CPU 1, core 1, socket 36
>   CPU 2, core 2, socket 36
>   CPU 3, core 3, socket 36
>   FAILED tests/topology.c:137 Cpu map - Die ID doesn't match
>   ---- end(-1) ----
>   38: Session topology                                                : FAILED!
> 
> Fixes: 05be17eed774 ("tool api fs: Correctly encode errno for read/write open failures")
> Signed-off-by: James Clark <james.clark@linaro.org>

I think I reported the same issue earlier, anyway.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/cpumap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 27094211edd8..5c329ad614e9 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -293,7 +293,7 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
>  
>  	die = cpu__get_die_id(cpu);
>  	/* There is no die_id on legacy system. */
> -	if (die == -1)
> +	if (die < 0)
>  		die = 0;
>  
>  	/*
> @@ -322,7 +322,7 @@ struct aggr_cpu_id aggr_cpu_id__cluster(struct perf_cpu cpu, void *data)
>  	struct aggr_cpu_id id;
>  
>  	/* There is no cluster_id on legacy system. */
> -	if (cluster == -1)
> +	if (cluster < 0)
>  		cluster = 0;
>  
>  	id = aggr_cpu_id__die(cpu, data);
> -- 
> 2.34.1
> 
