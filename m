Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C3153810;
	Fri, 28 Jun 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579999; cv=none; b=tg8/lIwgEFrp8J6nOd7bvjRTNqlcewNe9XQWYFSrrBFprNuM4KfEeI2h5eU9KzfflnzqgvawW/RdxrrtAL+UBk62iiv2y/MNdng2leqhNus0ogo5CN444H/oYx/ePi/zui7aPNIOH317HoTJvBXz109e2AxVSSIOVnsqiM/WnPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579999; c=relaxed/simple;
	bh=wQCInJ35AszCmCScjJW40EMhXqw/XPAuyr6O08xil0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D34iFjBnVpgpUHTMyr1PH/MlmNrKMD6Il9Kwd1CmPMu/R16ZNFZ/fBKwibsD452MDXdEx98525rQmIh44MnxFBpLPU+HHvSm7x4jfD2o/q05iFTuiS+PthM13Stkyi7ewNBluuiUQ03sdCvOxLm31wT2cBTXoZa2OuImGQDMscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 28 Jun 2024 15:06:32 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf build: conditionally add feature check flags
 for libtrace{event,fs}
Message-ID: <Zn61WOXCq0MRQovH@gentoo.org>
References: <20240627150606.2224888-1-amadio@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627150606.2224888-1-amadio@gentoo.org>

Hi Arnaldo,

On Thu, Jun 27, 2024 at 05:06:05PM +0200, Guilherme Amadio wrote:
> This avoids reported warnings when the packages are not installed.
> 
> Fixes: 0f0e1f44569061e3dc590cd0b8cb74d8fd53706b
> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> ---
>  tools/perf/Makefile.config | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 81f73f68d256..987b48f242d3 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -182,14 +182,6 @@ endif
>  FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
>  FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
>  
> -# for linking with debug library, run like:
> -# make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> -FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> -FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> -
> -FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> -FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> -
>  FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
>  # include ARCH specific config
>  -include $(src-perf)/arch/$(SRCARCH)/Makefile
> @@ -211,6 +203,17 @@ endif
>  ifneq ($(NO_LIBTRACEEVENT),1)
>    ifeq ($(call get-executable,$(PKG_CONFIG)),)
>    dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
> +  else
> +    ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent),0)

There is a problem here which I noticed while working on the fix for
the problem reported by Thorsten (in tools/verification/rv). We need

-    ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent),0)
+    ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)

to produce a 0 in the output, otherwise it doesn't work. I will send a v2 fixing this.

For the feature checks that depend on using FEATURE_CHECK_* like the ones below,
it looks like the best would be to find a good common place to do it instead of
redeclaring these required flags on various subdirectories. I thought about
doing that in tools/build/Makefile.feature, but since these flags depend on
using $(PKG_CONFIG), and that is also set in various places, I thought I'd ask
first before going ahead. The idea I have is to gather somewhere the packages
that are used via their .pc files, and set the appropriate FEATURE_CHECK_* flags
such that all subdirectories could get them automatically. That may require setting 
PKG_CONFIG in a common place as well, and then dropping it from places such as
tools/perf/Makefile.perf. Maybe something like this is Makefile.feature:

PKG_CONFIG = $(CROSS_COMPILE)pkg-config

ifneq ($(call get-executable,$(PKG_CONFIG)),)
    # libtraceevent
    ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
      FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent 2>/dev/null)
      FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent 2>/dev/null)
    endif

    # libtracefs
    ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
      FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
      FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
    endif

    # ... other packages
endif

and this shows that we could also define a function for this, and call it for
each package, which would simplify things a bit more. These are the Makefiles
that need to be adjusted:

tools/perf/Makefile.config
tools/tracing/latency/Makefile.config
tools/tracing/rtla/Makefile.config
tools/verification/rv/Makefile.config

Best regards,
-Guilherme

> +      # for linking with debug library, run like:
> +      # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> +      FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> +      FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> +    endif
> +    ifeq ($(shell $(PKG_CONFIG) --exists libtracefs),0)
> +      FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> +      FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> +    endif
>    endif
>  endif
>  
> -- 
> 2.45.2
> 
