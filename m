Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041325394B;
	Tue, 29 Apr 2025 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949720; cv=none; b=C1kM0kntviZu9PKb8gg6yTD5MQWOwP6JbpNTORLAdj6y7+37XKg/yLMltmDnPwBj/aXV5ihr7Be2U4XWqmF1qCWnnLY5ZkDlrQyRFaA17RzCw5RVDy5Oq9rbMllb4u5Co3dODEvi/YWHNfo2zT3b4wxn6nLyWFqk1v6sf7Y+oNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949720; c=relaxed/simple;
	bh=592Ml20d/7CsLvSvbhwM3alxfNaRGpjjJKzbJ1oRFUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njHvLfDI/mMxCOsj9z9+a4PaGcR9rLRRmQ5yVc4URhf0ttR2VrrYq1Ndwy0XPQix6ndtcvqPNwo6p+ajsnZ5vMsJu3ddGu4T72mNjFvYkQg+HOVgUH51WUjTJ3a4qXw7SHFpgJ2zWPYnQzE7xXNxIwDnwf/TAT21BClv6Ck7XQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImGvbmLj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImGvbmLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B81C4CEE3;
	Tue, 29 Apr 2025 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745949719;
	bh=592Ml20d/7CsLvSvbhwM3alxfNaRGpjjJKzbJ1oRFUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImGvbmLj7vAizxTOJHyYd9JOx8FSRs9TsWm0qO7ao89jbgnThxRHV1dxIeUi01RwT
	 TEbLv918l61ZCWv2mDJSXT68VUHZuUWtxPTTiVGjUVWZx/iVr9FU07u8BnzCxINJ+c
	 +FsM1EFGjItysmxJ6rpj7MB5IkdOpneByK+6C1guefLvW4fXnUQTVpDjjWD+GKE0Sg
	 EsXebkyWaRJNlMdOJVd9fzdUyWGxRCA5zKuMg+va5GwmGbj1ECn2WyDZ8KC9v25fRl
	 OGb9QC7OuY1x2YAST72aRcom7u+uUcGrpeQPnRvCK8BUTrUlnhlOnsP+s6JhQ/XzvV
	 KvoKVJksHt7GA==
Date: Tue, 29 Apr 2025 15:01:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, linux@leemhuis.info,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix in-source libperf build
Message-ID: <aBEUFK6o41mlkd9j@x1>
References: <20250429-james-perf-fix-libperf-in-source-build-v1-1-a1a827ac15e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429-james-perf-fix-libperf-in-source-build-v1-1-a1a827ac15e5@linaro.org>

On Tue, Apr 29, 2025 at 03:22:18PM +0100, James Clark wrote:
> When libperf is built alone in-source, $(OUTPUT) isn't set. This causes
> the generated uapi path to resolve to '/../arch' which results in a
> permissions error:
 
>   mkdir: cannot create directory '/../arch': Permission denied

So this requires the only outstanding patch in perf-tools/perf-tools:

⬢ [acme@toolbx perf-tools-next]$ git log -5 --oneline perf-tools/perf-tools
bfb713ea53c746b0 (perf-tools/tmp.perf-tools, perf-tools/perf-tools, perf-tools) perf tools: Fix arm64 build by generating unistd_64.h
9c32cda43eb78f78 (tag: v6.15-rc3) Linux 6.15-rc3
ac71fabf15679fc7 gcc-15: work around sequence-point warning
05e8d261a34e5c63 gcc-15: add '__nonstring' markers to byte arrays
be913e7c4034bd7a gcc-15: get rid of misc extra NUL character padding
⬢ [acme@toolbx perf-tools-next]$

So probably should go to there, to be submitted to Linus in the current
merge window, right?

Namhyung?

- Arnaldo
 
> Fix it by removing the preceding '/..' which means that it gets
> generated either in the tools/lib/perf part of the tree or the OUTPUT
> folder. Some other rules that rely on OUTPUT further refine this
> conditionally depending on whether it's an in-source or out-of-source
> build, but I don't think we need the extra complexity here. And this
> rule is slightly different to others because the header is needed by
> both libperf and Perf. This is further complicated by the fact that Perf
> always passes O=... to libperf even for in source builds, meaning that
> OUTPUT isn't set consistently between projects.
> 
> Because we're no longer going one level up to try to generate the file
> in the tools/ folder, Perf's include rule needs to descend into libperf.
> Also fix the clean rule while we're here.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/linux-perf-users/7703f88e-ccb7-4c98-9da4-8aad224e780f@leemhuis.info/
> Fixes: bfb713ea53c7 ("perf tools: Fix arm64 build by generating unistd_64.h")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/lib/perf/Makefile    | 6 +++---
>  tools/perf/Makefile.config | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 1a19b5013f45..7fbb50b74c00 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -42,7 +42,7 @@ libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
>  TEST_ARGS := $(if $(V),-v)
>  
>  INCLUDES = \
> --I$(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi \
> +-I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi \
>  -I$(srctree)/tools/lib/perf/include \
>  -I$(srctree)/tools/lib/ \
>  -I$(srctree)/tools/include \
> @@ -100,7 +100,7 @@ $(LIBAPI)-clean:
>  	$(call QUIET_CLEAN, libapi)
>  	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
>  
> -uapi-asm := $(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi/asm
> +uapi-asm := $(OUTPUT)arch/$(SRCARCH)/include/generated/uapi/asm
>  ifeq ($(SRCARCH),arm64)
>  	syscall-y := $(uapi-asm)/unistd_64.h
>  endif
> @@ -130,7 +130,7 @@ all: fixdep
>  clean: $(LIBAPI)-clean
>  	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
>                  *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd tests/*.o LIBPERF-CFLAGS $(LIBPERF_PC) \
> -                $(TESTS_STATIC) $(TESTS_SHARED)
> +                $(TESTS_STATIC) $(TESTS_SHARED) $(syscall-y)
>  
>  TESTS_IN = tests-in.o
>  
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a52482654d4b..b7769a22fe1a 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -29,7 +29,7 @@ include $(srctree)/tools/scripts/Makefile.arch
>  $(call detected_var,SRCARCH)
>  
>  CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
> -CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi
> +CFLAGS += -I$(OUTPUT)libperf/arch/$(SRCARCH)/include/generated/uapi
>  
>  # Additional ARCH settings for ppc
>  ifeq ($(SRCARCH),powerpc)
> 
> ---
> base-commit: bfb713ea53c746b07ae69fe97fa9b5388e4f34f9
> change-id: 20250429-james-perf-fix-libperf-in-source-build-15609cc212aa
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 
