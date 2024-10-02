Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41376383A3;
	Wed,  2 Oct 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827345; cv=none; b=YZi6H+EGiW20L5TnSMe0sGgDzTnU3KZRc2CoCSseHbAadx8TSxWjcgTauVy5QMxZ1+WRZg6QKy0YIbOzqSZoBHGLDiwvjA/R0LvwR2IBsAA7e2KNsGmv8x9SxQEo59RlhqFUHqXfludGMTlFa+wQVcQtmBRZrpf8M4ZSXZQknNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827345; c=relaxed/simple;
	bh=CnYnjc8Dj7I3zu6bzXLJb5nblWfEQ21GZWp9gH57xxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i36lFulwa0STaS2/9dUDxEwZMvShUkkY7mMQYa2UUQpHaOuDdoi3USNSSr/oP8W9kGjUpxW0qapmcMISqbDNCgzG2qxAmZcNHfJtWTl7emB+L8qBeBH+EMj/UVMgTgiQR+aM43yAI0BHn2ZWa0WsPu0COrmskEyt0cwwUoHoWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9brPOcG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9brPOcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D24C4CECF;
	Wed,  2 Oct 2024 00:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727827345;
	bh=CnYnjc8Dj7I3zu6bzXLJb5nblWfEQ21GZWp9gH57xxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9brPOcGGWxDGmraTBD0jdtV8NSQ1frrmeHdFG2H+ioVMSXGcJzVTWGiGPw8sLdWf
	 jF8zUO/f5rFWtyPos1C9mGBphrWGZ50J7ymLvzcOk0SlPfQCtkmNwu0quLFwUy0kX/
	 pZ/UmkSeiOMD7NUdV6zoOQRu0Q4u0wzCUIswAnz5FVENvEvZEq+7JucyoAdr9kneEg
	 amoh2f/k6P6W1iguDEHwqaNnz01e0k46eAjYRXXgFJwkMWjq8SBp+/QFIpu1L+FMQu
	 UXuo5OFdGbVJKg6LIg+hsZKi+mdtcTGggCe/G/TfuuJiw6slHRGwAvtWvVTLDkcn/Z
	 oWF5vtws/wn5g==
Date: Tue, 1 Oct 2024 17:02:23 -0700
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
Subject: Re: [PATCH v2 1/4] perf stat: Fix affinity memory leaks on error path
Message-ID: <ZvyNj3_pf8r8oKk1@google.com>
References: <20241001052327.7052-1-irogers@google.com>
 <20241001052327.7052-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001052327.7052-2-irogers@google.com>

On Mon, Sep 30, 2024 at 10:23:24PM -0700, Ian Rogers wrote:
> Missed cleanup when an error occurs.
> 
> Fixes: 49de179577e7 ("perf stat: No need to setup affinities when starting a workload")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 1521b6df2606..3e6b9f216e80 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -827,6 +827,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		}
>  	}
>  	affinity__cleanup(affinity);
> +	affinity = NULL;
>  
>  	evlist__for_each_entry(evsel_list, counter) {
>  		if (!counter->supported) {
> @@ -965,6 +966,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	if (forks)
>  		evlist__cancel_workload(evsel_list);
>  
> +	affinity__cleanup(affinity);
>  	return err;

Much better now, thanks!
Namhyung


>  }
>  
> -- 
> 2.46.1.824.gd892dcdcdd-goog
> 
