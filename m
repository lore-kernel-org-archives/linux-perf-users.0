Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479481A3166;
	Tue, 21 Oct 2025 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019800; cv=none; b=BgzNx/50b1ncltT2mqPtcHAG9BkqswVCzCePV7VDlrzQKi1Xspb15XrkbfPmEjtmPfw0p055B3W/XjvTgPXckOO/7d3vlNTjtOE7Fyb//MtNm4SpNA9AhR/SxYINvdIBYq4GkiZp/VcHaX/yoxBYTMjy0z7LbL6Xm7JePrs6A/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019800; c=relaxed/simple;
	bh=tPbHsX8J9214hVMLxIa6V2MLS+beit8zdm08Y/aeRVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsLMDwutNKJs3JOj6X/nA1bGDl3Z2M+oprq7SFJ2ezRAxLofD7gOYktxlxQaXfqOPIpleYlBYbtxDSA4G17PKIvU9L5sCk3FSuXpDUokkkhkLjJiw+5U/hnvYTnZorIbgbRu/Vnnclua2jtEVXKnFK1ZtI9vHkvrqjU6Lf64q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqCVdTce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqCVdTce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F81C4CEF1;
	Tue, 21 Oct 2025 04:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761019799;
	bh=tPbHsX8J9214hVMLxIa6V2MLS+beit8zdm08Y/aeRVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqCVdTceSBIx1rbts5SxtlOR6ojJDcgFW1MV/tkkZBrO20lG6aEITYysfn7HElko4
	 e45cNaf1GG1Nb8IhRj9jxKek8islbm9dXNQUGoe2EOvt0mq9Uq9Q2ZiMR6qEq1yS7g
	 z5atHgQAT+UFHCUYqESIpbBAb6/spqMY/kJxQrQTDoeuULaLnHYogDxxzE42x8X/cg
	 yARjKvZBFep4hK6u5QDIffAKC7t/iKx7E/EUlu+Xxq6Rn9+v4q+9FQiEV0V/67lULR
	 hRXqoT4vc088KTT+NB+sTu8FNjF4QC3bO8VanP1josJt41rX2S6aq2pZWzjg3A5ouh
	 MQAqfETXEzBgA==
Date: Tue, 21 Oct 2025 13:09:55 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf jevents: Suppress circular dependency warnings
Message-ID: <aPcHk3yy0Q7jxK01@google.com>
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
 <20251020-james-perf-fix-json-find-v1-3-627b938ccf0d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020-james-perf-fix-json-find-v1-3-627b938ccf0d@linaro.org>

On Mon, Oct 20, 2025 at 05:08:28PM +0100, James Clark wrote:
> When doing an in source build, $(OUTPUT) is empty so the rule has the
> same input and output file. Suppress the warning by only adding the rule
> when doing an out of source build. The same condition already exists for
> the clean rule for json files.
> 
> This fixes the following warnings:
> 
>   make[3]: Circular pmu-events/arch/nds32/mapfile.csv <- pmu-events/arch/nds32/mapfile.csv dependency dropped.
>   make[3]: Circular pmu-events/arch/powerpc/mapfile.csv <- pmu-events/arch/powerpc/mapfile.csv dependency dropped.
>   ...

I noticed this too and confirm it's fixed by this change.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/pmu-events/Build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index c5e2d5f13766..a46ab7b612df 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -29,10 +29,12 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,gen)cp $< $@
>  else
> -# Copy checked-in json for generation.
> +# Copy checked-in json to OUTPUT for generation if it's an out of source build
> +ifneq ($(OUTPUT),)
>  $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,gen)cp $< $@
> +endif
>  
>  $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
>  	$(call rule_mkdir)
> 
> -- 
> 2.34.1
> 
