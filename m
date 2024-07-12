Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F510F7;
	Fri, 12 Jul 2024 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720759973; cv=none; b=t3pHt/oAMk01xt24nclQo75YuCsq6ogyWdI56RHObqayrqKji1DBKqpPgfXLnkmaTXT/Yf97oTBr2DYjkOaIjb4FQ7ZoCtqy4yZ0mxmaB1lUHvvQaY00DhivM1/KNndNSIrVu84c7n51G39fgtiVTHwgWokZ4nnxtZvuI77NLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720759973; c=relaxed/simple;
	bh=5k6ybLwj298W9LJSa6/ckxWtE0cEJjR/QAl+W5fFO9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz0tMiUKFGtMn55bm5bnS+QhVnLL9opZP+VUFbmXoBQoOcdcLLwaPgJ/KKGvi96RmcRK9DYgcp0XBkXnV8ap45m6PZqBbzmhwC2o3CtePBvdKJGq/4H8WfeQcsMy9GqdX51ecPVELneIh7dY/MHSngsZ5LhOUspkIxzEKkX7k+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIfVHXGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIfVHXGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5958CC3277B;
	Fri, 12 Jul 2024 04:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720759973;
	bh=5k6ybLwj298W9LJSa6/ckxWtE0cEJjR/QAl+W5fFO9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIfVHXGUBpIdP5o328eX5gcUPM7l3kdXclWd5b0O75pF5aHrY8X0sJuYc+c1kj734
	 0hEOJRLGJDPyXn0iXqquSFtXMOP1ouXIAxiNPT2OyGcZ/30c0YWQvAL/pud9544bYE
	 ukLeUi6MPvC+EKhIU66FauKBlyMl07s0JxzV9YWp6C+67NyZLQOZXGVk+S5kZXy1+4
	 CO3I9z7xgjpvkInIUqa1WH/plzuT7DJliWLbjtBCqBmz5QB42TFAoda5f0MQ0N7tDg
	 mVFT+lb9htzuhsBQV7nvbhh70ODbuBryL6CoX4ZbUlu0uOUmRMhtbJ1kXIUBYw6fbg
	 2HFBS3NmMkkMg==
Date: Thu, 11 Jul 2024 21:52:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	James Clark <james.clark@linaro.org>, amadio@gentoo.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/7] perf: build: Setup PKG_CONFIG_LIBDIR for cross
 compilation
Message-ID: <ZpC2n-iDsbc6gNEW@google.com>
References: <20240706182912.222780-1-leo.yan@arm.com>
 <20240706182912.222780-2-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706182912.222780-2-leo.yan@arm.com>

Hi Leo,

On Sat, Jul 06, 2024 at 07:29:06PM +0100, Leo Yan wrote:
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
> index ed54cef450f5..65fd2b2cfacb 100644
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

And PKG_CONFIG_SYSROOT_DIR too.


> +  # compilation. If both is not set, try to set the lib paths installed
> +  # by multiarch.
> +  ifdef CROSS_COMPILE
> +    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR),)
> +      CROSS_ARCH = $(shell $(CC) -dumpmachine)
> +      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
> +      export PKG_CONFIG_LIBDIR
> +      $(warning Missing PKG_CONFIG_LIBDIR and PKG_CONFIG_PATH for cross compilation,)

Probably you need to add it here too.

> +      $(warning set PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) for building with Multiarch libs.)

I guess the message would get too long.  Maybe it's ok to hide the
actual value..

In addition, I think this message will be displayed multiple times -
once here and later in Makefile.perf.  Maybe we can show it once in
the latter only?

Thanks,
Namhyung


> +    endif
> +  endif
> +endif
>  
>  all: $(FILES)
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5c35c0d89306..270490be0a1a 100644
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
> +    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR),)
> +      CROSS_ARCH = $(shell $(CC) -dumpmachine)
> +      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
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
