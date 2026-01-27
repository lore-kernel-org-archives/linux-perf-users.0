Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F232143D;
	Tue, 27 Jan 2026 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533466; cv=none; b=kwCjH6DWGmDnGWybYzXLS3aRowy6EQrWQM2x0mIbbCUWSvV6nQLw4RfjAPArvAuIcOe1hWCMiBZnRO7pP/pvT+lrDKdN0362Ld7P/ivGaWrOsR6Q+kmGyh0xHsI2zKpR4ppAFxfwxk6q/ZvQIfONxLGbPlwNFeLrzzyKCc7tAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533466; c=relaxed/simple;
	bh=w+myaO0UhxZy5SuASeIiGUGV4FZVrE/r4B3Z3adX5Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7BxsK/sSvhmA8HBY76QWtgHqRbFBWiAaKBmLDKguV5ojQWFSlTadghDC5zMEmEwfK0Roi5V9UIIE/vK1wqW3h0OvBtv9cLqActTGXDydtyHf2JwNtU03gQRaXFKIWKQoD0JCSxRR1PKZPlvWlhhlnbaXEo909MNbDytaxYVmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUuyH/L8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUuyH/L8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E7DC116C6;
	Tue, 27 Jan 2026 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769533465;
	bh=w+myaO0UhxZy5SuASeIiGUGV4FZVrE/r4B3Z3adX5Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUuyH/L8SQ+XpzEaODzm2EOldBm7R7GdPB70AoQ9uwb/1lnSdVOcqusCYBp8YbUCg
	 +rlRd+m5AeqApjnGZg65d1AWsKWxNzfd3koSqfyiAysmcMosASo7voaoMXyq8CX1nC
	 KVckiDudMI43oxKpxnP9beYpwoClFfk17Xm1DxFt+q7BXTFHCb9IBfg8S7iubRQRUA
	 /Weumu2MOK4olxyz+uTJOhZxlk0OqBZjcZd9sdbp9EiMAQjhG+F0V1e0iy+MruVxLD
	 ezNI70+sichm+n1w88d563wXRHw2ipEjJp8/tcFEAA6TbNAdWo1Cl8/Mk0EoOhuWv7
	 n+HO9CKLcJFww==
Date: Tue, 27 Jan 2026 14:04:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] perf jevents: Handle deleted JSONS in out of source
 builds
Message-ID: <aXjwFhUEOUc7rNnZ@x1>
References: <20260121-james-perf-json-delete-fix-v2-1-2e10f895bfd7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-james-perf-json-delete-fix-v2-1-2e10f895bfd7@linaro.org>

On Wed, Jan 21, 2026 at 04:19:40PM +0000, James Clark wrote:
> Make the source folders a dependency for the generated folder root so
> that whenever a file is deleted from the source it will force a new
> fresh copy of all the JSON files and avoid stale deleted files.
> 
> JSON_DIRS_OUTPUT_ROOT needs to be a dependency of LEGACY_CACHE_JSON so
> that the root folder doesn't get cleaned after the legacy JSON is
> generated. But this is a no-op with in-source builds as
> JSON_DIRS_OUTPUT_ROOT is unset.
> 
> JSON_DIRS is added as a dependency of PMU_EVENTS_C which also forces a
> re-build for in source builds when JSON files are deleted. This could
> have also resulted in stale builds, but never a broken one.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/linux-next/aW5XSAo88_LBPSYI@sirena.org.uk/
> Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> This is a bit of a hack and I thought that making jevents.py handle
> multiple input folders would be a much better solution than this. Then
> we could have "gen-pmu-events" for only generated files and "pmu-events"
> for only in-tree input files. It would be very clear what's generated
> and what's not and all copying rules and special clean rules just
> disappear (and this isn't the first time these rules have caused build
> issues).
> 
> Unfortunately, after a while of trying to modify the script I thought it
> was too invasive for now. The script does output per-file at the very
> bottom of the logic in process_one_file(), so adding files in another
> folder ends up re-emitting section headers when another chunk is output.
> Although other parts of the script do build things up in memory before
> outputting so it was possible to make those parts work with multiple
> folders transparently.
> ---
> Changes in v2:
> - Drop dependency on rsync by wiping the output folder any time a source
>   folder is updated.
> - Also fix the same issue for in source builds by adding the source
>   folders as a dependency of PMU_EVENTS_C.
> - Link to v1: https://lore.kernel.org/r/20260120-james-perf-json-delete-fix-v1-1-bae2194b1dcf@linaro.org
> ---
>  tools/perf/pmu-events/Build | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index a46ab7b612df..4f9ef624ba70 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -1,5 +1,6 @@
>  pmu-events-y	+= pmu-events.o
>  JSON		=  $(shell find pmu-events/arch -name '*.json' -o -name '*.csv')
> +JSON_DIRS	=  $(shell find pmu-events/arch -type d)
>  JDIR_TEST	=  pmu-events/arch/test
>  JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
>  			find $(JDIR_TEST) -name '*.json')
> @@ -31,16 +32,23 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
>  else
>  # Copy checked-in json to OUTPUT for generation if it's an out of source build
>  ifneq ($(OUTPUT),)
> -$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
> +# Remove all output directories when any source directory timestamp changes
> +# so there are no stale deleted files
> +JSON_DIRS_ROOT = $(OUTPUT)pmu-events/arch/
> +$(JSON_DIRS_ROOT): $(JSON_DIRS)
> +	$(Q)$(call echo-cmd,gen)rm -rf $@
> +	$(Q)mkdir -p $@
> +
> +$(OUTPUT)pmu-events/arch/%: pmu-events/arch/% $(JSON_DIRS_ROOT)
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,gen)cp $< $@
>  endif
>  
> -$(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
> +$(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY) $(JSON_DIRS_ROOT)
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
>  
> -GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
> +GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON) $(JSON_DIRS)
>  
>  $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
>  	$(call rule_mkdir)
> 
> ---
> base-commit: 571d29baa07e83e637075239f379f91353c24ec9
> change-id: 20260120-james-perf-json-delete-fix-71553b379e8e
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
