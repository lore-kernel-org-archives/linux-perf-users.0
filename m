Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236617CA1B;
	Mon, 30 Sep 2024 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730221; cv=none; b=rHCwlRXR5ZXTsergh2XKcR6n69TtCialr5+/PYz60lvzqoB/gLIC+DSpznkOyKNWFwyUWZklY0VHb76bnCeSj46bBpXq7U/4ilG3GDF6xydIlaD3rbLYYJEakh6uaFLIKFC9HgJvAngCTo8M+En5mtNy99GouY2nG9jTlD+iJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730221; c=relaxed/simple;
	bh=tLJCoN7NqsMwn5wS0dO6c4qIgLV6+/CFLLkFGHNeZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPes7WQmkBVFFyH81NAlm8lgwJDYw4YHaaSiAMHF8tqddMz6+E9Q33w2OJW8ZMP0bR1LJHbiRSPoV+8CPQXBpf/0L8UxSm1y1rFBvAZ/mGaFu70prtSa168WeS62qz5r9MH29wrz6aG3Xrzm7n+6YgkcR75GmEuWIonIMVt9H/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC+ubDMO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC+ubDMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB871C4CEC7;
	Mon, 30 Sep 2024 21:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727730220;
	bh=tLJCoN7NqsMwn5wS0dO6c4qIgLV6+/CFLLkFGHNeZCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NC+ubDMO6Z+2p9rywg5YhTAIGeryBrcBigubejMSLpTHfsjH+m7/1vbH+rtDdnCMd
	 iHyFtUes5zAn7G63nSdMg3TOI5+8UeDGq0rerYn9AQoESK4H9bTgWdBSzENcCMbe1N
	 IYrCW2tdX+t1TBn62sLVhY4jsCVNSyoeDHA6htomm31XiQImay3ONM9bJodonNq3Gy
	 aV62iF8tP+EpSBNrDYKzEBN1xYp9DublA3jIt1pNHPiw6oyXTbom9TFQUCCKfY3szh
	 6Go3Le1Ez5YgrFWHYUj2RmcRJUtdkJ9HaDtoNUIauxeobhWxw2iEeVsnbPx6RHOIuQ
	 6gTupQFIJan4A==
Date: Mon, 30 Sep 2024 14:03:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] perf stat: Fix affinity memory leaks on error path
Message-ID: <ZvsSKpa0UhcVKBma@google.com>
References: <20240924202916.1560687-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924202916.1560687-1-irogers@google.com>

On Tue, Sep 24, 2024 at 01:29:13PM -0700, Ian Rogers wrote:
> Missed cleanup when an error occurs.

I think there's one more place for this - after bpf_counter__load()
failed.  You may add a new label to handle it together in the error
path.

Also it doesn't apply to the latest tree, please rebase!

Thanks,
Namhyung

> 
> Fixes: 49de179577e7 ("perf stat: No need to setup affinities when starting a workload")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 689a3d43c258..cc55df3ccb18 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -767,6 +767,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  			switch (stat_handle_error(counter)) {
>  			case COUNTER_FATAL:
> +				affinity__cleanup(affinity);
>  				return -1;
>  			case COUNTER_RETRY:
>  				goto try_again;
> @@ -808,6 +809,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  				switch (stat_handle_error(counter)) {
>  				case COUNTER_FATAL:
> +					affinity__cleanup(affinity);
>  					return -1;
>  				case COUNTER_RETRY:
>  					goto try_again_reset;
> -- 
> 2.46.0.792.g87dc391469-goog
> 
