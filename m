Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E21990CE;
	Thu,  6 Jun 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694938; cv=none; b=AC7K6X2WmDK7WIx1wbiG4MzqfHcupcQAQwKKWifbFcd18NXa/2lcY2coGSrwvFrK+7d6PC7XSIThjhdveXKVqNX6549/EVF1ri4XZj0Mjk2AAHInjOsGNHCRcYELXX+yDON5G+wKb66XI7vR0WbOYGaRinLSKAsa0u5r3mBB5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694938; c=relaxed/simple;
	bh=0VOTymSltSm46M0tWgnYW1sxiIawEOkUL0FrWY5YCPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ3BSYpVTwZ7y82ZT30BaPoZZqcEQy3pwpN9p2eIIBwH8mAaaMbyMSglYPHAr6Pg1kULvPkRX3Bc+UPTRqi7BhZRTiFecZH8HIQZPhbbDOxfWXbZEjGPHwXMrtnvWg4VNaxWpGrI0xRcs+B6sqRePCJFPml377jBjrZY0qHENAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP3yt6rB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP3yt6rB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49D7C2BD10;
	Thu,  6 Jun 2024 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717694938;
	bh=0VOTymSltSm46M0tWgnYW1sxiIawEOkUL0FrWY5YCPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dP3yt6rBauKLyUXSmvUQlKMv9b+IZxxP5U5a9chY/5DoATvlBY+jPRJfZjGzufEzK
	 I4cFzo9XU1/Q6vPMcVBsrP45WiA8bmK3xJx6wk300XvvAzrp0DJZSaWW1tztjieZJ5
	 +81x+uZjb7UWRhCXjEOEQqz1nQzx9n58qg5f9tRuecRkM4znRbyTMNPwZTwMIlaGZS
	 ztwbh33zNyncdklSDwYeXSmdxnkW9FBBwvHN6IQX0dNLHKHvHY/KVcxqLGQbhpU5XY
	 TvaJ+VAbB45PxsYntGZ8TM2+JeEGQk3P5rcdHlgG2a4NhpuDMVmHnX7FVi1QK75u7s
	 HxwLBGk97+R+Q==
Date: Thu, 6 Jun 2024 10:28:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/6] perf: build: Setup PKG_CONFIG_LIBDIR for cross
 compilation
Message-ID: <ZmHx2EFK9cSWgUIK@google.com>
References: <20240604093223.1934236-1-leo.yan@arm.com>
 <20240604093223.1934236-2-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604093223.1934236-2-leo.yan@arm.com>

Hi Leo,

On Tue, Jun 04, 2024 at 10:32:18AM +0100, Leo Yan wrote:
> On recent Linux distros like Ubuntu Noble and Debian Bookworm, the
> 'pkg-config-aarch64-linux-gnu' package is missing. As a result, the
> aarch64-linux-gnu-pkg-config command is not available, which causes
> build failures.
> 
> Alternatively, this commit sets the PKG_CONFIG_LIBDIR environment
> variable dynamically based on the cross compiler to ensure the correct
> package configurations.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/feature/Makefile | 14 +++++++++++++-
>  tools/perf/Makefile.perf     | 15 ++++++++++++++-
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index ed54cef450f5..6f52f892f9a3 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -82,7 +82,19 @@ FILES=                                          \
>  
>  FILES := $(addprefix $(OUTPUT),$(FILES))
>  
> -PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> +PKG_CONFIG ?= pkg-config
> +
> +ifdef CROSS_COMPILE
> +  ifndef PKG_CONFIG_LIBDIR

Can we do that only if the cross-compile-pkg-config is not available?

Thanks,
Namhyung


> +    CROSS_ARCH = $(shell $(CC) -dumpmachine)
> +    PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
> +    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
> +    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
> +    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
> +    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
> +    export PKG_CONFIG_LIBDIR
> +  endif
> +endif
>  
>  all: $(FILES)
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5c35c0d89306..c1553a546a4f 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -193,7 +193,20 @@ HOSTLD  ?= ld
>  HOSTAR  ?= ar
>  CLANG   ?= clang
>  
> -PKG_CONFIG = $(CROSS_COMPILE)pkg-config
> +PKG_CONFIG ?= pkg-config
> +
> +# Set the PKG_CONFIG_LIBDIR for cross compilation.
> +ifdef CROSS_COMPILE
> +  ifndef PKG_CONFIG_LIBDIR
> +    CROSS_ARCH = $(shell $(CC) -dumpmachine)
> +    PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
> +    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
> +    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
> +    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
> +    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
> +    export PKG_CONFIG_LIBDIR
> +  endif
> +endif
>  
>  RM      = rm -f
>  LN      = ln -f
> -- 
> 2.34.1
> 
