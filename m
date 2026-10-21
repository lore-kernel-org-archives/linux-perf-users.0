Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625036;
	b=VA0R2UsmOF4CQY7Uk8aIERL3k1hxOFs7BNPSADD35XRw/AvROMUYFPbphSIZBOD1U0Tr
	 9qQqE4ha2aSH6aM8vzYO+AtHw1ldFkYrSGXUmODcLuh6tASxvG+XJvT/EjSGpbpMbLXpa
	 4IIEJY9KL0VnTfUaKGoPGMSArLqFzUIhmgmiclUWp6KLVPiE39gbybXEwgF6bn7jyxqcB
	 44nYVlC8s3fpd9IrDXbY9B/MkPCGTGLrSbt9MUMZ9LQEGvjYLSBG1yt2vTmcYCyHHJCIq
	 7hZ7QLYezvGldRJmzEhd1xuoP0RB5gnD3O4LLk4bMsIuaXcofJ+WkaCPh0gZiDUmbWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625036;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qjj5hZjI8xw1hJvXTB1lpAtU8s+DbInFpqaIpOJfVII=;
	b=SApf9DoDWUtuQdmLFyt1Aguw0AZhbKAiIaVhojp7JxzzvoK4DZTrVJzcnleTPsJHuCE2
	 N2TOip+Spq6MFUjwohJvoxVGWLofcyzA6zjfzCDd/H6K/F9ewD/LRv2yJpnVbXfBtSYOl
	 VsEeOQgBs2WfWT53xs5wzjPvQdwFGGd2Dp3d1oe47/MfnOyIho7cOG8dZmodJSzURBOOm
	 QFlS9kZ7Tio0X6FyrBcVLuYpt/4dXxIN98P36+4lZDxcNoYlWdIBnzuxRblKQllt2bDeH
	 iWm4rHaxI7GVJoBmsHMGA3HDGO/3Gsy7iAtewirG+iqhYOMSHBZcvk9Du5o4CXS2Ycw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZF0AvHr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C7606A319;
	Wed, 21 Oct 2026 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZF0AvHr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D84C1F000C1;
	Wed, 21 Oct 2026 23:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625036;
	bh=qjj5hZjI8xw1hJvXTB1lpAtU8s+DbInFpqaIpOJfVII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hZF0AvHrtrBbOyeslQSvPK3nLyRD6q5W+1DcrndySbgKuAw179TvOSArbO0qOftOk
	 xHNg4IjuxWO0239SLU/mBnNhtQo2d6ctQQznaBwwlkNVQ+XgRk9fj6jqbpZq1PquFa
	 45um5GpbsOSY1FM6jPxqhle3dNBiY/ligqvxLaJkclnNZVS6/PiddIDktWU3AGmfQ8
	 AUvHRPo6L8DkI493SpLgLTLTLdbBJhjZWYRUG4nE3RYWhbLbvuNItuOMF0fdAeJcC7
	 qQ3uMri5zBImazHcxrTMp2WCepEDhkVqRmcmFtiAV5xYeAuKu/fS3Ls0hJVl/PkgvQ
	 Q/EylziyUIRRA==
Date: Wed, 21 Oct 2026 16:23:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/7] tools: build perf in tools_build
Message-ID: <atlJij2v6sbOYZot@google.com>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-5-sashal@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016143143.3613501-5-sashal@kernel.org>

On Fri, Oct 16, 2026 at 10:31:40AM -0400, Sasha Levin wrote:
> Add CONFIG_TOOLS_BUILD_PERF. perf is built as it is built standalone,
> with optional features enabled when their libraries are installed, and
> with perf's WERROR setting following CONFIG_WERROR. The feature table is
> left out of the kernel build log.
> 
> CONFIG_TOOLS_BUILD_PERF_MINIMAL builds it with MINIMAL=1 instead, which
> turns every optional feature off, so the result does not depend on the
> build machine. allmodconfig and allyesconfig turn it on.
> 
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/Kconfig         | 16 ++++++++++++++++
>  tools/Makefile.kbuild | 10 ++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/tools/Kconfig b/tools/Kconfig
> index 2d05c8e593e21..4f13e3b104377 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -60,6 +60,22 @@ config TOOLS_BUILD_IIO
>  	help
>  	  Build tools/iio (lsiio, iio_event_monitor, iio_generic_buffer).
>  
> +config TOOLS_BUILD_PERF
> +	bool "perf"
> +	help
> +	  Build tools/perf. As in a standalone perf build, optional
> +	  features are enabled when the libraries they need are installed.
> +
> +config TOOLS_BUILD_PERF_MINIMAL
> +	bool "Build perf with all optional features disabled"
> +	depends on TOOLS_BUILD_PERF
> +	help
> +	  Build perf with MINIMAL=1, which turns off every optional
> +	  feature, so that the result does not depend on which libraries
> +	  the build machine has installed. allmodconfig and allyesconfig
> +	  turn this on, which keeps their builds the same on every
> +	  machine.
> +
>  config TOOLS_BUILD_SPI
>  	bool "SPI tools"
>  	help
> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
> index 8cfa7f80039cd..4b3ea73bc8ab9 100644
> --- a/tools/Makefile.kbuild
> +++ b/tools/Makefile.kbuild
> @@ -79,6 +79,16 @@ PHONY += $(tool-targets)
>  $(tool-targets): tool-%: FORCE
>  	$(call build,$(outdir)/$*,-C $(toolsdir)/$* O=$(outdir)/$* CC='$(call escsq,$(tools-cc))',,TOOLS_BUILD_$(shell echo $* | tr a-z A-Z))
>  
> +# perf, without the feature table in the kernel build log
> +perf-flags := CC='$(call escsq,$(tools-cc))' FEATURE_DISPLAY= WERROR=$(if $(CONFIG_WERROR),1,0)
> +perf-flags-$(CONFIG_TOOLS_BUILD_PERF_MINIMAL) += MINIMAL=1
> +
> +__tools_build: $(if $(CONFIG_TOOLS_BUILD_PERF),perf)
> +
> +PHONY += perf
> +perf: FORCE
> +	$(call build,$(outdir)/perf,-C $(toolsdir)/perf -f Makefile.perf O=$(outdir)/perf $(perf-flags) $(perf-flags-y),,TOOLS_BUILD_PERF)
> +
>  PHONY += FORCE
>  FORCE:
>  
> -- 
> 2.53.0
> 
