Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1785270;
	Fri, 10 Jan 2025 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736470735; cv=none; b=fsZTCu8l+//pCKrrjCHnUGEpR6YtCXtJDJpi03IFQ2c1DhgzGIqrWak0V16o+NT8PHeymipxtMPyeJQYYrSxYYR1enzFE4NLCwL5MazTJOlD7MDZo68FpranpppEBluICDo3NzkTg2D712yiZwybrM/if+bdJjHFXW8+fkBqw/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736470735; c=relaxed/simple;
	bh=kWh0eUdcriBV8O8nsILNy0hVf9xZI22rVgxbjf4gMag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhjVbmZVBmknduC1Jrg6wo41GA1nMpGTXf58HFfo6Odq2vwcrooji4gB8ELdXsDCYMBm6iyKbvF9k3GhOcPDenxLgOKwpvuaOUrCuhPMXAt8F6V6f3l4wDvfOPD6R4jJD+Yfgv0ZnPUFM9CZmm0TekOws7PnvJfaNaYNeyJdBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKHAOvtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKHAOvtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AB7C4CED2;
	Fri, 10 Jan 2025 00:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736470735;
	bh=kWh0eUdcriBV8O8nsILNy0hVf9xZI22rVgxbjf4gMag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKHAOvtV74AsxgSI4GzkXVez1SCCb2AsDU4A/Sjs/DEaNLRSwphyUtRC0JhOBeqD1
	 eVWzganjHn3tNPiizyqd0JvpzVET5yOm554HEVq8cW76qbpbqNucZ0M++14+MmBtyj
	 oGDYR0nuQi/cp1U1txOBrnxaV4o0x6I5tzjrmBo9jBmo44+cszKSaUr4HsbsZle8Te
	 In9vVWYQYuLAbU1BMOe97P0U+v6vQaBmhhk5JDUgkRrmj6mR49vdV9zkm3vVCV0QyO
	 UxEACfyehmPLgeZTqcJCznIzPOMopkER+K/kscm8BhMj7wGjUWih2zv1tHdl8penIE
	 NMgvkhUCpzlXQ==
Date: Thu, 9 Jan 2025 16:58:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] perf test: Remove parallel option documentation
Message-ID: <Z4BwzZ27OrG19EL7@google.com>
References: <20250109215055.454888-1-irogers@google.com>
 <20250109215055.454888-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109215055.454888-4-irogers@google.com>

On Thu, Jan 09, 2025 at 01:50:53PM -0800, Ian Rogers wrote:
> The parallel option was removed in commit 94d1a913bdc4 ("perf test:
> Make parallel testing the default").
> 
> Fixes: 94d1a913bdc4 ("perf test: Make parallel testing the default")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-test.txt | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
> index efcdec528a8f..8f8a3c367570 100644
> --- a/tools/perf/Documentation/perf-test.txt
> +++ b/tools/perf/Documentation/perf-test.txt
> @@ -35,12 +35,6 @@ OPTIONS
>  --sequential::
>  	Run tests one after the other, this is the default mode.

This needs to be changed too as it's not the default anymore. :)

Thanks,
Namhyung

>  
> --p:: 
> ---parallel::
> -	Run tests in parallel, speeds up the whole process but is not safe with
> -	the current infrastructure, where some tests that compete for some resources,
> -	for instance, 'perf probe' tests that add/remove probes or clean all probes, etc.
> -
>  -F::
>  --dont-fork::
>  	Do not fork child for each test, run all tests within single process, this
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
