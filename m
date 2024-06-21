Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3216F296;
	Fri, 21 Jun 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011924; cv=none; b=drWBHwhkcuViMt+JgJajUyOLr+URdR0OTMfYUQMTVvc8I1zS6f0c1bqgTYUSBotnmVahtQnFqMT2fnTTPMrpCAWF/8tyq9a+mM4Jq2m6Kx0hI51WAD8N2edToWbW376ZsOx87DnH/1HXLVSCNLAVTR8nMjlYFJkK/1VPoIsF9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011924; c=relaxed/simple;
	bh=LaHBdfPEb3h/hEvMVTOBXBpwhvEm8ipahU8Hds9Q29Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1HwbSSprOukI92u/zymYzrEYbdqqF0on1ZLeHIbMg9CPjXjOC7fkhVATwtH/njV66DghW6jdGJ7tLGGxcUfBY8AoJC3c6Clv3obCJdPJ9oBvQMIWC1PTv7OPP8xiCpSNEfplE61DTpQT/NkX6VwTcarZ2g4NU4qYBp0nDxzaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeAdrHYi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeAdrHYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BFDC2BBFC;
	Fri, 21 Jun 2024 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719011923;
	bh=LaHBdfPEb3h/hEvMVTOBXBpwhvEm8ipahU8Hds9Q29Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeAdrHYiCRFdJrk73xQtG5CAz+XT0hGwHcHDovcPljJP3l7ejTw92wWPYCXw+DMd8
	 KAkAXooz/nvg+rL9s8jUETrVISqK0557SIYRXUXYJF12Cun2TQC8wMM0alVIgdV24I
	 QQB4FyIhoAuIX7ZN2oc4VIxsMaK1g1W/0Y2l1xJGjcVz48N5z+onGndcnrfkcQYtc1
	 Y0HL1EOUsPSZu3R/0u/mMWnp71SUuCuSSpUGJEcqLICz+WKcoqs2FGW/2OUHmfOH/Z
	 D0fKXNKg2H0lOmVUnEsEtbYh8AQgggik7RWZZgA9Lnac8Zph941JbiSdeets2G5eYw
	 ZhrIIrrN7bRRA==
Date: Fri, 21 Jun 2024 16:18:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v2 1/6] perf: build: Setup PKG_CONFIG_LIBDIR for cross
 compilation
Message-ID: <ZnYKUfr4f-0NFw6r@google.com>
References: <20240610095433.336295-1-leo.yan@arm.com>
 <20240610095433.336295-2-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610095433.336295-2-leo.yan@arm.com>

Hello,

On Mon, Jun 10, 2024 at 10:54:28AM +0100, Leo Yan wrote:
> On recent Linux distros like Ubuntu Noble and Debian Bookworm, the
> 'pkg-config-aarch64-linux-gnu' package is missing. As a result, the
> aarch64-linux-gnu-pkg-config command is not available, which causes
> build failures.
> 
> When a build passes the environment variables PKG_CONFIG_LIBDIR or
> PKG_CONFIG_PATH, like a user uses make command or a build system
> (like Yocto, Buildroot, etc) prepares the variables and passes to the
> Perf's Makefile, the commit keeps these variables for package
> configuration. Otherwise, this commit sets the PKG_CONFIG_LIBDIR
> variable to use the Multiarch libs for the cross compilation.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/feature/Makefile | 26 +++++++++++++++++++++++++-
>  tools/perf/Makefile.perf     | 26 +++++++++++++++++++++++++-
>  2 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index ed54cef450f5..084f803093c3 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -82,7 +82,31 @@ FILES=                                          \
>  
>  FILES := $(addprefix $(OUTPUT),$(FILES))
>  
> -PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> +# Some distros provide the command $(CROSS_COMPILE)pkg-config for
> +# searching packges installed with Multiarch. Use it for cross
> +# compilation if it is existed.
> +ifneq (, $(shell which $(CROSS_COMPILE)pkg-config))
> +  PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> +else
> +  PKG_CONFIG ?= pkg-config
> +
> +  # PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR is required for the cross
> +  # compilation. If both is not set, try to set the lib paths installed
> +  # by multiarch.
> +  ifdef CROSS_COMPILE
> +    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH),)

Maybe you want to check PKG_CONFIG_SYSROOT_DIR too.


> +      CROSS_ARCH = $(shell $(CC) -dumpmachine)
> +      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/

I'm not sure why this ordering.. don't you want to check
CROSS_ARCH directories first and then /usr/local/share and
/usr/share directory?


> +      export PKG_CONFIG_LIBDIR
> +      $(warning Missing PKG_CONFIG_LIBDIR and PKG_CONFIG_PATH for cross compilation,)
> +      $(warning set PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) for building with Multiarch libs.)
> +    endif
> +  endif
> +endif
>  
>  all: $(FILES)
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5c35c0d89306..2c9e89415e48 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -193,7 +193,31 @@ HOSTLD  ?= ld
>  HOSTAR  ?= ar
>  CLANG   ?= clang
>  
> -PKG_CONFIG = $(CROSS_COMPILE)pkg-config
> +# Some distros provide the command $(CROSS_COMPILE)pkg-config for
> +# searching packges installed with Multiarch. Use it for cross
> +# compilation if it is existed.
> +ifneq (, $(shell which $(CROSS_COMPILE)pkg-config))
> +  PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> +else
> +  PKG_CONFIG ?= pkg-config
> +
> +  # PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR is required for the cross
> +  # compilation. If both is not set, try to set the lib paths installed
> +  # by multiarch.
> +  ifdef CROSS_COMPILE
> +    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH),)
> +      CROSS_ARCH = $(shell $(CC) -dumpmachine)
> +      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/

Ditto.

Thanks,
Namhyung


> +      export PKG_CONFIG_LIBDIR
> +      $(warning Missing PKG_CONFIG_LIBDIR and PKG_CONFIG_PATH for cross compilation,)
> +      $(warning set PKG_CONFIG_LIBDIR to $(PKG_CONFIG_LIBDIR) for using libs with Multiarch.)
> +    endif
> +  endif
> +endif
>  
>  RM      = rm -f
>  LN      = ln -f
> -- 
> 2.34.1
> 
