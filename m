Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161321D432D;
	Tue, 13 Jan 2026 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338101; cv=none; b=KpR1ZRqHc09NmixD7rzAAq4Z7O0BHXg55ta/R6/nKTLu2jffxpE6n1qGRI2eWyOH6UeRrDKUrbhcJZx8VvCUsyzsO+Ku96MHG1Oyrp1kgoHHDPumCAHr/ILGw9MeSVjC3GPDHuctrqpa1jGOaDxnxKO6Ypx/arRPIvO/6bgoX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338101; c=relaxed/simple;
	bh=8BuC3uPN/BYM88IDzqSaQ1+hs1vVGCV47S+Cpmif9yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFwZ8ozR2eTOmqJfUhzF7IiHZInGsHydwC0WvaMdIj5AM4PS3NUqW0aDtmu88EZ6KPwCNxFstWPARTvDQH/XoF/Z1v0pbOL6waY/FcZCMdmrR69l+1s0v+dIIfpVYDObg9GUGhiHrKTmEU5/9sPoTtT7PpZs8P4smg3BILSWtI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCilBLwt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCilBLwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A5FC116C6;
	Tue, 13 Jan 2026 21:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768338100;
	bh=8BuC3uPN/BYM88IDzqSaQ1+hs1vVGCV47S+Cpmif9yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCilBLwtTFRvZt+lRmRumMfvNaGG4EnOPWncpu8wEGnJJSVjNRVHzaV8qahSInZIm
	 atUPE8FACN4WXuvG6h7MTK5TuQOTNpVTDRvlqqVrOh4odMbv9Wkw3IKkHonN5OToiz
	 oA3MDuVs2Sofz0iyBymLyKyem4s0JHSrc3YPex2bufAhOw1tn88GInt5XhcQ/Fw6ug
	 7VlMOlutjIOnCHAE0tyUqnOYaEwXb0mWMdhdAkFJNFeFtqqoixxs6Wb2w7Ch2JZyCC
	 lf6zTxhpaRdunStI0aHgT74rXbvp4C6xBHHHHzib8ieU6LMRGnNV+Vqag1mS2d51Up
	 RKjiUKxb4M01g==
Date: Tue, 13 Jan 2026 18:01:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v4 00/14] perf cs-etm/arm-spe: Remove hard coded config
 fields
Message-ID: <aWaysdXYIWi4nB1D@x1>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>

On Mon, Dec 22, 2025 at 03:14:25PM +0000, James Clark wrote:
> The specific config field that an event format attribute is in is
> consistently hard coded, even though the API is supposed to be that the
> driver publishes the config field name. To stop this pattern from being
> copy pasted and causing problems in the future, replace them all with
> calls to a new helper that returns the value that a user set.
> 
> This reveals some issues in evsel__set_config_if_unset(). It doesn't
> work with sparse bitfields, which are an unused but documented feature.
> And it also only writes to the attr.config field. To fix it we need to
> start tracking user changes for all config fields and then use existing
> helper functions that support sparse bitfields. Some other refactoring
> was also required and a test was added.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> ---
> Changes in v4:
> - Constify some function args (Ian)
> - Move some evsel__* functions to evsel.c and make some pmu.c functions
>   public to support this (Ian)
> - Drop pmu arg where it can be fetched from evsel->pmu (Ian)
> - Link to v3: https://lore.kernel.org/r/20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org
> 
> Changes in v3:
> - Fix uninitialized variable warning on GCC
> - Fix leak of evlist in test
> - Confirm no type punning issues with ubsan (Ian)
> - Link to v2: https://lore.kernel.org/r/20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org
> 
> Changes in v2:
> - Remove macros in get_config_chgs() and some other refactoring.
> - Support sparse bitfields in evsel__set_config_if_unset().
> - Always track user changes instead of only when
>   'pmu->perf_event_attr_init_default' is set.
> - Add a test.
> - Don't bail out in cs-etm.c if any format fields are missing (Leo).
> - Rename 'guess' to 'synth' (Mike).
> - Link to v1: https://lore.kernel.org/r/20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org
> 
> ---
> James Clark (14):
>       perf parse-events: Refactor get_config_terms() to remove macros
>       perf evsel: Refactor evsel__set_config_if_unset() arguments
>       perf evsel: Move evsel__* functions to evsel.c
>       perf evsel: Support sparse fields in evsel__set_config_if_unset()
>       perf parse-events: Track all user changed config bits
>       perf evsel: apply evsel__set_config_if_unset() to all config fields
>       perf evsel: Add a helper to get the value of a config field
>       perf parse-events: Always track user config changes
>       perf tests: Test evsel__set_config_if_unset() and config change tracking
>       perf cs-etm: Make a helper to find the Coresight evsel
>       perf cs-etm: Don't use hard coded config bits when setting up ETMCR
>       perf cs-etm: Don't use hard coded config bits when setting up TRCCONFIGR
>       perf cs-etm: Don't hard code config attribute when configuring the event
>       perf arm-spe: Don't hard code config attribute
> 
>  tools/perf/arch/arm/util/cs-etm.c    | 201 +++++++++++++++-------------
>  tools/perf/arch/arm64/util/arm-spe.c |  17 +--
>  tools/perf/arch/x86/util/intel-pt.c  |   3 +-
>  tools/perf/tests/pmu.c               |  91 +++++++++++++
>  tools/perf/util/evsel.c              | 112 +++++++++++++++-
>  tools/perf/util/evsel.h              |   6 +-
>  tools/perf/util/evsel_config.h       |   7 +-
>  tools/perf/util/parse-events.c       | 248 ++++++++++++++++++++---------------
>  tools/perf/util/pmu.c                |  95 ++++----------
>  tools/perf/util/pmu.h                |  34 ++++-
>  10 files changed, 529 insertions(+), 285 deletions(-)
> ---
> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> change-id: 20251112-james-perf-config-bits-bee7106f0f00
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 
