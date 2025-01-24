Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F129406;
	Fri, 24 Jan 2025 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762791; cv=none; b=IHOJ/95bCNZDMgMx0m0ISugk9/8aX2/9mxiiTYjrD0lMV8+747VR/53eBjN6jc49LvO3hWS2zYWE2LLliFbmw38GD4C0lRWvlMvLuz3fG6L+1tSmD+2TCTvj3OpahSSINffPpAP9puYZMO/318E3u8xE/++Aaju0TQ1NjF0UKJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762791; c=relaxed/simple;
	bh=23h2N0J0op8KeazT0P0tjeAHBYjzvF8jpbLqUXKUSB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9RW2dMPa0NN3aQfI5LeDM1iA0cnbuE/8+aCvLCrJf8+miYKk3Miaeh72OzI7Fr6CILZ1617pqGhZdgE0aw2BzlMR6iIwd43G0nwHDWo8a7dV3aBE7rAP69L2kQ1pxjuc9/2k9WdluHjEBrOettYZZTZhO5xSeSQ6kMnsdkfqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7+e64wy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7+e64wy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B582C4CED2;
	Fri, 24 Jan 2025 23:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737762790;
	bh=23h2N0J0op8KeazT0P0tjeAHBYjzvF8jpbLqUXKUSB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7+e64wykP41A8/fkNSLgq/Vy/sAf25xAWRVnOnddQNJvKptC2L20LXy8x/j7/msN
	 XEgbsGauMMdPrSfs8SxFEVgcZVhcV06ahIPXH8X9hgExpTrUSv1EzGyQ97y8zU/w5I
	 xw0y9BqmiMz5N1gPWkirlxaQJG+zJYrCIKvblOHYge/cMTcrAvlNNSZVsobJ6ENKw4
	 Q+9PknRtoSghVRbP8sF4x4ddpFzx4qnJF12yh/9uzCLkg3C6iV2t0vp9ePtVplUaJB
	 nVm0+tP4VlPi+WPLTweNVSDFTgld03cgcfcSQJ+HHYwgxbXM4ZEA+cmqHpvwrNqcMX
	 SPqHGMEKwNTGA==
Date: Fri, 24 Jan 2025 15:53:08 -0800
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
	John Garry <john.g.garry@oracle.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 4/6] perf build: Add pylint build tests
Message-ID: <Z5Qn5Felm8K32DeK@google.com>
References: <20241025172303.77538-1-irogers@google.com>
 <20241025172303.77538-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025172303.77538-5-irogers@google.com>

On Fri, Oct 25, 2024 at 10:23:01AM -0700, Ian Rogers wrote:
> If PYLINT=1 is passed to the build then run pylint over python code in
> perf. Unlike shellcheck this isn't default on as there are currently
> too many errors.

Same as the previous.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Build            | 13 +++++++++++++
>  tools/perf/Makefile.perf    |  7 ++++++-
>  tools/perf/pmu-events/Build | 13 ++++++++++++-
>  tools/perf/scripts/Build    | 13 +++++++++++++
>  tools/perf/tests/Build      | 13 +++++++++++++
>  tools/perf/util/Build       | 12 ++++++++++++
>  6 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Build b/tools/perf/Build
> index 312914994c89..06107f1e1d42 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -89,3 +89,16 @@ $(OUTPUT)%.mypy_log: %
>  	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-y += $(MYPY_TEST_LOGS)
> +
> +ifdef PYLINT
> +  PY_TESTS := $(shell find python -type f -name '*.py')
> +  PYLINT_TEST_LOGS := $(PY_TESTS:python/%=python/%.pylint_log)
> +else
> +  PYLINT_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.pylint_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +perf-y += $(PYLINT_TEST_LOGS)
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 333afe29b1e2..6b5b420d794a 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -282,8 +282,13 @@ ifeq ($(MYPY),1)
>    MYPY := $(shell which mypy 2> /dev/null)
>  endif
>  
> +# Runs pylint on perf python files
> +ifeq ($(PYLINT),1)
> +  PYLINT := $(shell which pylint 2> /dev/null)
> +endif
> +
>  export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> -export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY
> +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
>  
>  include $(srctree)/tools/build/Makefile.include
>  
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index fc1dc810ffb6..32f387d48908 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -52,8 +52,19 @@ $(OUTPUT)%.mypy_log: %
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
>  
> +ifdef PYLINT
> +  PMU_EVENTS_PY_TESTS := $(wildcard *.py)
> +  PMU_EVENTS_PYLINT_TEST_LOGS := $(JEVENTS_PY_TESTS:%=%.pylint_log)
> +else
> +  PMU_EVENTS_PYLINT_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.pylint_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
> +
>  $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
> -    $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS)
> +    $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_EVENTS_PYLINT_TEST_LOGS)
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
>  endif
> diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
> index a5350dc6ac50..91229a1fe3ff 100644
> --- a/tools/perf/scripts/Build
> +++ b/tools/perf/scripts/Build
> @@ -15,3 +15,16 @@ $(OUTPUT)%.mypy_log: %
>  	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-y += $(MYPY_TEST_LOGS)
> +
> +ifdef PYLINT
> +  PY_TESTS := $(shell find python -type f -name '*.py')
> +  PYLINT_TEST_LOGS := $(PY_TESTS:python/%=python/%.pylint_log)
> +else
> +  PYLINT_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.pylint_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +perf-y += $(PYLINT_TEST_LOGS)
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 4d7c38a2bf6c..5fe011cf897b 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -104,3 +104,16 @@ $(OUTPUT)%.mypy_log: %
>  	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-test-y += $(MYPY_TEST_LOGS)
> +
> +ifdef PYLINT
> +  PY_TESTS := $(shell find tests/shell -type f -name '*.py')
> +  PYLINT_TEST_LOGS := $(PY_TESTS:tests/shell/%=shell/%.pylint_log)
> +else
> +  PYLINT_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.pylint_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +perf-test-y += $(PYLINT_TEST_LOGS)
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 3baa1f41502d..c33e2372579e 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -422,3 +422,15 @@ $(OUTPUT)%.mypy_log: %
>  	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-util-y += $(MYPY_TEST_LOGS)
> +
> +ifdef PYLINT
> +  PYLINT_TEST_LOGS := $(PY_TESTS:%=%.pylint_log)
> +else
> +  PYLINT_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.pylint_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +perf-util-y += $(PYLINT_TEST_LOGS)
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
