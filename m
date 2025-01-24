Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F929406;
	Fri, 24 Jan 2025 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762692; cv=none; b=sV0Dor9n+Sm4VpR9ZDRuTCOKcpHtkHkhdPS2rhD89+9GzNfFTC9udTXA4lxV5FgFZ5yKOsdhteUa/cmNbri0R6s9cq7ik3mk/WDpABGdSPqvsRljoAjF9lMKy6plfg0Yis8bfrxP79R8kh0fXryO1H4oSnJEzBupd1polwcwSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762692; c=relaxed/simple;
	bh=K6OAcFIlRweAXHPSwKcQ9hBPyKLgZRmWPorGdO7EKvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXPV9rOoN3GQFqhMmlxwIOyHli8ML/3dkOHEbqHtD594gquKYuaj5xcpTMR+8cTQ0bgfhnTNdYfNuL8Ms0YsLuyXqIL+juXw1mDRcaJFjQvzMFfYRN/Om7s7qgk9b7BPJqw067Ss2GiQC87QhZa4r/6eqsi8uPAkdeolFHldnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLWOUXuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLWOUXuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5737C4CED2;
	Fri, 24 Jan 2025 23:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737762691;
	bh=K6OAcFIlRweAXHPSwKcQ9hBPyKLgZRmWPorGdO7EKvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLWOUXuV1qA57Ju64GkQsqLbkdgiqS0R/XvyWZWZTJPJjP+BPVb8hm244szsEiIst
	 p2tWX6Rc96yT1NiqbPgpXsrrU6pKi2JAnc8OSIuGG6PBJUFl/H1b9nhUOR2CU+igVf
	 mJxNPIx5tF1Xyj9q2T2Faw3TyMzCobX6rSQXkH/gptlOy+h47+Bom4VGFLO7SRoDHS
	 YEmMXovze4oGHIhjHyyh9S94DZ2TgNLMsU8naUSM4shDc6pXj9wnqncVKCcrJmKPKb
	 Cofy/PgJRkdP/LcpEG3G2zxR+//yYGqzRocOF8Otm+fzgdB73xrqZbAFa5v8H9cIfk
	 xoKa5pzyobpyA==
Date: Fri, 24 Jan 2025 15:51:29 -0800
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
Subject: Re: [PATCH v1 3/6] perf build: Add mypy build tests
Message-ID: <Z5QngQQZBIekSl_v@google.com>
References: <20241025172303.77538-1-irogers@google.com>
 <20241025172303.77538-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025172303.77538-4-irogers@google.com>

On Fri, Oct 25, 2024 at 10:23:00AM -0700, Ian Rogers wrote:
> If MYPY=1 is passed to the build then run mypy over python code in
> perf. Unlike shellcheck this isn't default on as there are currently
> too many errors.

Can you please add an example output in the commit log?  Also you need
to add a comment to describe the build option.

Is it ok to pass the option on a system that doesn't have mypy?

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Build            | 13 +++++++++++++
>  tools/perf/Makefile.perf    |  7 ++++++-
>  tools/perf/pmu-events/Build | 14 +++++++++++++-
>  tools/perf/scripts/Build    | 13 +++++++++++++
>  tools/perf/tests/Build      | 13 +++++++++++++
>  tools/perf/util/Build       | 13 +++++++++++++
>  6 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Build b/tools/perf/Build
> index 5e385f370dd7..312914994c89 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -76,3 +76,16 @@ $(OUTPUT)%.shellcheck_log: %
>  	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-y += $(SHELL_TEST_LOGS)
> +
> +ifdef MYPY
> +  PY_TESTS := $(shell find python -type f -name '*.py')
> +  MYPY_TEST_LOGS := $(PY_TESTS:python/%=python/%.mypy_log)
> +else
> +  MYPY_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.mypy_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +perf-y += $(MYPY_TEST_LOGS)
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a9f2a9f6ebf0..333afe29b1e2 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -277,8 +277,13 @@ ifneq ($(SHELLCHECK),)
>    endif
>  endif
>  
> +# Runs mypy on perf python files
> +ifeq ($(MYPY),1)
> +  MYPY := $(shell which mypy 2> /dev/null)
> +endif
> +
>  export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> -export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK
> +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY
>  
>  include $(srctree)/tools/build/Makefile.include
>  
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index d941bc9d16e9..fc1dc810ffb6 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -41,7 +41,19 @@ $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,test)diff -u $^ 2> $@ || (cat $@ && false)
>  
> -$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
> +ifdef MYPY
> +  PMU_EVENTS_PY_TESTS := $(wildcard *.py)
> +  PMU_EVENTS_MYPY_TEST_LOGS := $(JEVENTS_PY_TESTS:%=%.mypy_log)
> +else
> +  PMU_EVENTS_MYPY_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.mypy_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
> +    $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS)
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
>  endif
> diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
> index 46f0c6f76dbf..a5350dc6ac50 100644
> --- a/tools/perf/scripts/Build
> +++ b/tools/perf/scripts/Build
> @@ -2,3 +2,16 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    perf-util-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
>  endif
>  perf-util-$(CONFIG_LIBPYTHON) += python/Perf-Trace-Util/
> +
> +ifdef MYPY
> +  PY_TESTS := $(shell find python -type f -name '*.py')
> +  MYPY_TEST_LOGS := $(PY_TESTS:python/%=python/%.mypy_log)
> +else
> +  MYPY_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.mypy_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +perf-y += $(MYPY_TEST_LOGS)
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index a51d28c7431c..4d7c38a2bf6c 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -91,3 +91,16 @@ $(OUTPUT)%.shellcheck_log: %
>  	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-test-y += $(SHELL_TEST_LOGS)
> +
> +ifdef MYPY
> +  PY_TESTS := $(shell find tests/shell -type f -name '*.py')
> +  MYPY_TEST_LOGS := $(PY_TESTS:tests/shell/%=shell/%.mypy_log)
> +else
> +  MYPY_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.mypy_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +perf-test-y += $(MYPY_TEST_LOGS)
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 18cd02ccd3ff..3baa1f41502d 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -409,3 +409,16 @@ $(OUTPUT)%.shellcheck_log: %
>  	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
>  
>  perf-util-y += $(SHELL_TEST_LOGS)
> +
> +PY_TESTS := setup.py
> +ifdef MYPY
> +  MYPY_TEST_LOGS := $(PY_TESTS:%=%.mypy_log)
> +else
> +  MYPY_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.mypy_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +perf-util-y += $(MYPY_TEST_LOGS)
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
