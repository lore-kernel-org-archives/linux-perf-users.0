Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4471DA332;
	Tue,  2 Jul 2024 23:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963210; cv=none; b=KHkEKGP1EaCMndkOYPxU8FtG8nCNEhrv+nB6NnNxkj50KwU6UeUt0wEQd79Prxzp+e2wMaUE1uE2VvfDzaHz/fhPsEXRkuiPynJHzYhuEf1+4W+IexDB4Eknoc6JdoQm8rwyznuTJYWwQsHGvprAAfvRrlEF377NSKOtCr3Pv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963210; c=relaxed/simple;
	bh=ozDuD4Psgba1OdA7ZnHbob123nne67USOF7W6rutdr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AypJPXVaPlBfSTFIXvB2mIx3NWKKo+T6e36O1GBsSkwiIIRnMvHQTsevBZ06hMLlIJ7zhANxG6cbUQSQkCrPK8KOBi5rHavIFaVNxCzhbayQZdD88sMoqrLiFne1zfb02cb4STUEvCXgq6BiLp5EzrYJrISVl661PfVh2IfwZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMRM6eya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMRM6eya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CBAC116B1;
	Tue,  2 Jul 2024 23:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719963209;
	bh=ozDuD4Psgba1OdA7ZnHbob123nne67USOF7W6rutdr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMRM6eya6aF17bPW5DLpY3Gt49pNgE5GKNVyCs5DNvVnx2IVGos4MLEccN/VcH+bf
	 Qx5WXCw+OGxCCwW7yM8yUPgCpEwl9/z7EqayobEkPgSF1jR9rn7y6y1g/3SDl0IE78
	 tX4+kmiwrvaWdoJB6a7ToRe5vmPcWMwfIt+S8e0Asr+5X3dS8Lx1/2ntWLoMEjYvVo
	 3Wml8HErtFMtcvb94rQR4FBCNy49znJga1D6zU7GXyY7hbS/EpLH+mPjIQ9OVo6zQi
	 RxdFAok1qGyyE62ZoVZuwFwZJnazdlBzryKF8p+lI2WsAZ1GHU3CiZQDN4LPz7CRQO
	 BzIIMNpBSqNuQ==
Date: Tue, 2 Jul 2024 16:33:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] perf build: Conditionally add feature check flags
 for libtrace{event,fs}
Message-ID: <ZoSOR0ULxXLxLZvA@google.com>
References: <20240628202608.3273329-1-amadio@gentoo.org>
 <20240628203432.3273625-1-amadio@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628203432.3273625-1-amadio@gentoo.org>

Hello,

On Fri, Jun 28, 2024 at 10:34:27PM +0200, Guilherme Amadio wrote:
> This avoids reported warnings when the packages are not installed.
> 
> Fixes: 0f0e1f44569061e3dc590cd0b8cb74d8fd53706b
> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>

Thanks for working on this.

> ---
>  tools/perf/Makefile.config | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5271a4c1d2b3..5387babb8f04 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -182,13 +182,21 @@ endif
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
> +ifneq ($(NO_LIBTRACEEVENT),1)
> +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> +  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)

I know you just copied the code, but IIRC we wanted to remove this dummy
assignment before.

> +  endif
> +endif
> +ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
> +  # for linking with debug library, run like:
> +  # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> +  FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> +  FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> +endif
> +ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
> +  FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> +  FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)

I'm curious if we can redirect stderr to /dev/null to surpress the
output when pkg-config is not installed.  Then we don't need to check
the `ifeq`.

Thanks,
Namhyung


> +endif
>  
>  FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
>  # include ARCH specific config
> @@ -208,12 +216,6 @@ ifeq ($(call get-executable,$(BISON)),)
>    $(error Error: $(BISON) is missing on this system, please install it)
>  endif
>  
> -ifneq ($(NO_LIBTRACEEVENT),1)
> -  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> -  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
> -  endif
> -endif
> -
>  ifneq ($(OUTPUT),)
>    ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
>      BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
> -- 
> 2.45.2
> 
