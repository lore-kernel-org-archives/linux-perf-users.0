Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190F2BEFE5;
	Fri, 19 Sep 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311692; cv=none; b=jG3GqHaodfND1Zo6alUFFXwpTt/0iaxN33Oj3Fy5gwtpqpTq36s+PQXUfD5nr0ehvthJ1rbAVz4b8smRby0Ctpnzrnxk+G0JTC1k5vmJH0IpVNS3aE18Zybaeesis98HdvponCSis54c7JMnuRTsvQ0Z5J/eQkqhwsOaTBT0iww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311692; c=relaxed/simple;
	bh=/u9N2N5fkn6zovj4uW2ex3jJMI8hcVQzf0p9IAFiSNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiHn/bwa4Ybcs1E6brYRHpBz0WU13meemU9PwJx8Ub5+E1DvdawDAGwfqdxCHpcIsGsnd+mbQ6k7pjexRUHbcEH7i3PREOCLkfhLH2pl9F6TLb+gKbnMMvYH//HpWkFiT+IqnBYGkafTK1/AXrWgyPk3edhVKbkYAKPSTQXMEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnLCW/Zj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnLCW/Zj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABA1C4CEF0;
	Fri, 19 Sep 2025 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758311690;
	bh=/u9N2N5fkn6zovj4uW2ex3jJMI8hcVQzf0p9IAFiSNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnLCW/ZjKV/mJzg120Hg9/9vzwnNvU1uYA4tCeIIcekwdjGBltOO5J6XEp0LbNyu/
	 HTkp5eLEwPT9f98mAovq4LMPooRc6IAL1f6nMoX7BDtSERQZ0ujVQZu8m7XqCkpNH6
	 jyPr1dX3X7YRSaqomFexfSZ9LClBohexvrkOkgFBkYmr9sOhV2LFnwQ5Ue0Gtw7bax
	 SA6X1BFKEVZcicgvJGjVhVkZHcSaSWq6GSfoRfK/faXTomHCj2Aj7mQw2XKP/AAgO6
	 1oWCZ+RCZmvw8nh2mFFjlhy2+lzancIjHuBYrjC6qDgxy63x9yJbD602sSuqIJJpKj
	 jOFv12/Otf5RA==
Date: Fri, 19 Sep 2025 16:54:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf evsel: Ensure the fallback message is always
 written to
Message-ID: <aM21BtgwBRBWrEEs@x1>
References: <20250918172416.1247940-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918172416.1247940-1-irogers@google.com>

On Thu, Sep 18, 2025 at 10:24:15AM -0700, Ian Rogers wrote:
> The fallback message is unconditionally printed in places like
> record__open. If no fallback is attempted this can lead to printing
> uninitialized data, crashes, etc.
> 
> Fixes: c0a54341c0e8 ("perf evsel: Introduce event fallback method")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo

> ---
>  tools/perf/util/evsel.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 477cddf08c5c..814ef6f6b32a 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3565,7 +3565,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
>  
>  		/* If event has exclude user then don't exclude kernel. */
>  		if (evsel->core.attr.exclude_user)
> -			return false;
> +			goto no_fallback;
>  
>  		/* Is there already the separator in the name. */
>  		if (strchr(name, '/') ||
> @@ -3573,7 +3573,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
>  			sep = "";
>  
>  		if (asprintf(&new_name, "%s%su", name, sep) < 0)
> -			return false;
> +			goto no_fallback;
>  
>  		free(evsel->name);
>  		evsel->name = new_name;
> @@ -3596,17 +3596,19 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
>  			sep = "";
>  
>  		if (asprintf(&new_name, "%s%sH", name, sep) < 0)
> -			return false;
> +			goto no_fallback;
>  
>  		free(evsel->name);
>  		evsel->name = new_name;
>  		/* Apple M1 requires exclude_guest */
> -		scnprintf(msg, msgsize, "trying to fall back to excluding guest samples");
> +		scnprintf(msg, msgsize, "Trying to fall back to excluding guest samples");
>  		evsel->core.attr.exclude_guest = 1;
>  
>  		return true;
>  	}
> -
> +no_fallback:
> +	scnprintf(msg, msgsize, "No fallback found for '%s' for error %d",
> +		  evsel__name(evsel), err);
>  	return false;
>  }
>  
> -- 
> 2.51.0.470.ga7dc726c21-goog
