Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAD17DA03;
	Tue,  2 Jul 2024 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963649; cv=none; b=VjpBynwDBuRVgtmSIkEPlmIW2bmopgL6LQnMQl38KK13TBeVCBn1LvZnbcARSDRq/GF/AWJcSwPXFHFf2gt+G70v22t1aqCD7K8JwRxnqtt2qMhiOaUv9L9Qji+kLhgJ3DWrAgufy6p65ClSNI3CWj3QXHv2UYfA2FwyjcwKSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963649; c=relaxed/simple;
	bh=r6NI3gRk8PvoRVepVbEFbr7nnjKYdoij5IyeZd/5+XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYekWS69PtvW/qCBcsoqytZ4Gu2+7l7awjy0bxSpohxOWXkvHQf7DUTViolFDqZjV3tthhniR4QrK1scsefb5uWDbTQ/99K4h/+dGGnWio1z5gmBzbmwQocCmdxX0va4etWM9f/j9PQXCwJK6LKGUQS2cNbMGuXrLO4c02iZ/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyFhom0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyFhom0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5053AC4AF0D;
	Tue,  2 Jul 2024 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719963648;
	bh=r6NI3gRk8PvoRVepVbEFbr7nnjKYdoij5IyeZd/5+XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyFhom0uD7GC8yV1UwEOtghiO75l38Bm2NAd0AxMh78KM7zMwK3th806oQv8ZILgE
	 CBcKOOzSN+i+nKx75Vccmu8JYv0UtrfVk5h3kwX48EeTq3x3eGu7r/cotSOSNrE4zq
	 pZ+TJOQ1X/lXymtMlD1lNa4/j3lzm7dKfucl5ucAMemrgLWlGTvluc7T4Sn5CnUTNG
	 WU2Okw0Gd305WApQSPAf8wtDC2vvSYj48qLYMgpp2mUMYySB6tIaPt6ua21yIQYkJD
	 2TFbdwnUlTck+oLFzbA/0sps42ojnmuZjZS9/BWwyEaLeegzfXVQ2J73lcQviPUMfQ
	 yRSITSdUogLOg==
Date: Tue, 2 Jul 2024 16:40:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] tools: Make pkg-config dependency checks usable
 by other tools
Message-ID: <ZoSP_vFMVl83pxES@google.com>
References: <20240628202608.3273329-1-amadio@gentoo.org>
 <20240628203432.3273625-1-amadio@gentoo.org>
 <20240628203432.3273625-3-amadio@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628203432.3273625-3-amadio@gentoo.org>

+CC Steve and linux-trace-kernel list.

Thanks,
Namhyung

On Fri, Jun 28, 2024 at 10:34:29PM +0200, Guilherme Amadio wrote:
> Other tools, in tools/verification and tools/tracing, make use of
> libtraceevent and libtracefs as dependencies. This allows setting
> up the feature check flags for them as well.
> 
> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> ---
>  tools/build/Makefile.feature | 20 ++++++++++++++++++++
>  tools/perf/Makefile.config   | 10 ----------
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 1e2ab148d5db..79a03e034073 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -149,6 +149,26 @@ FEATURE_DISPLAY ?=              \
>  #
>  FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
>  
> +#
> +# Declare list of feature dependency packages that provide pkg-config files.
> +#
> +FEATURE_PKG_CONFIG ?=           \
> +         libtraceevent          \
> +         libtracefs
> +
> +feature_pkg_config = $(eval $(feature_pkg_config_code))
> +define feature_pkg_config_code
> +  ifeq ($(shell $(PKG_CONFIG) --exists $(1) 2>&1 1>/dev/null; echo $$?),0)
> +    FEATURE_CHECK_CFLAGS-$(1) := $(shell $(PKG_CONFIG) --cflags $(1))
> +    FEATURE_CHECK_LDFLAGS-$(1) := $(shell $(PKG_CONFIG) --libs $(1))
> +  endif
> +endef
> +
> +# Set FEATURE_CHECK_(C|LD)FLAGS-$(package) for packages using pkg-config.
> +ifneq ($(PKG_CONFIG),)
> +  $(foreach package,$(FEATURE_PKG_CONFIG),$(call feature_pkg_config,$(package)))
> +endif
> +
>  # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
>  # If in the future we need per-feature checks/flags for features not
>  # mentioned in this list we need to refactor this ;-).
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ba51ecfca02b..23f2b54d8ee6 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -187,16 +187,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>    dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
>    endif
>  endif
> -ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
> -  # for linking with debug library, run like:
> -  # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> -  FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> -  FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> -endif
> -ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
> -  FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> -  FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> -endif
>  
>  FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
>  # include ARCH specific config
> -- 
> 2.45.2
> 
