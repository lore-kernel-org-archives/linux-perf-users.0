Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539B4D8C5;
	Fri, 28 Jun 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600889; cv=none; b=IxAxCAHIIGzQtXEVBTJ5xqqC+TtvIOZWyLcfKVBlQkYw8Mg1hu1UlMrS6eqKMkjqctozRi0HCYY0kBnBamkFSRKYhgKhlX3zMbiW+Zl24CwRF9Yuxwb6yphXaOrx5KdZ1lqsnJyN1RjHP1X4dVm9Sljw9S6B1GZg3b6G35srue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600889; c=relaxed/simple;
	bh=HAXhxkAWUpE1TYkqJaYgqnCgZ+0+6RZs1S/j2ZTrxk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDD93l1lkizy6vlu47w1vJc7Klh5AZkh7zV9K8ffFuNx0hXuTcXeqnCZH7g5DcWSolJ5B4NY7Mef0BX0iB+CLvHqwno7+KYvCK4UX1XLyVMcbMqf/r/2kp4CRrCVD9NgxGw3yYw+9icsKWEcIsLop0sDx2atFqAwjWyt2e4b63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoS1FMSc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoS1FMSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492A4C116B1;
	Fri, 28 Jun 2024 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600888;
	bh=HAXhxkAWUpE1TYkqJaYgqnCgZ+0+6RZs1S/j2ZTrxk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoS1FMSc+SVb/HeisCdWKasvTrGwvWOxo6NvWKZj0hr2+3MQNmr/SdVpYn5zCIVrF
	 OdTIdB9oyx9XDOr/mcGfHCHwOiaYR0akb4qBZlZXsz4OkfF4iaBGm9xnJ7JcqnIB4N
	 ra3f97JVS+9UasP4dcypkoLXhMbgKCwlm/mHWMrSPngAXtnJS8wsIh87OmYMrurCwW
	 XduLBXe+1wtjRvh8ImgJqnqaMjzSjQ/L0mL4Janm81SL8zTGBoeRNlDUim+qLQq89J
	 4L3e9uRZdMThjxCwyDkuHw2jlP/5UdM/qY6lb32XFD7Q8JEhM/UGzkS8RnTEFT4ovG
	 P3hkzGoBRHzWQ==
Date: Fri, 28 Jun 2024 11:54:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf build: conditionally add feature check flags
 for libtrace{event,fs}
Message-ID: <Zn8G9gyvo98AT8ni@google.com>
References: <20240627150606.2224888-1-amadio@gentoo.org>
 <Zn61WOXCq0MRQovH@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zn61WOXCq0MRQovH@gentoo.org>

Hello,

On Fri, Jun 28, 2024 at 03:06:32PM +0200, Guilherme Amadio wrote:
> Hi Arnaldo,
> 
> On Thu, Jun 27, 2024 at 05:06:05PM +0200, Guilherme Amadio wrote:
> > This avoids reported warnings when the packages are not installed.
> > 
> > Fixes: 0f0e1f44569061e3dc590cd0b8cb74d8fd53706b
> > Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> > ---
> >  tools/perf/Makefile.config | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 81f73f68d256..987b48f242d3 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -182,14 +182,6 @@ endif
> >  FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
> >  FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
> >  
> > -# for linking with debug library, run like:
> > -# make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> > -FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> > -FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> > -
> > -FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> > -FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> > -
> >  FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
> >  # include ARCH specific config
> >  -include $(src-perf)/arch/$(SRCARCH)/Makefile
> > @@ -211,6 +203,17 @@ endif
> >  ifneq ($(NO_LIBTRACEEVENT),1)
> >    ifeq ($(call get-executable,$(PKG_CONFIG)),)
> >    dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
> > +  else
> > +    ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent),0)
> 
> There is a problem here which I noticed while working on the fix for
> the problem reported by Thorsten (in tools/verification/rv). We need
> 
> -    ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent),0)
> +    ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
> 
> to produce a 0 in the output, otherwise it doesn't work. I will send a v2 fixing this.

Yeah, I've noticed this too.

> 
> For the feature checks that depend on using FEATURE_CHECK_* like the ones below,
> it looks like the best would be to find a good common place to do it instead of
> redeclaring these required flags on various subdirectories. I thought about
> doing that in tools/build/Makefile.feature, but since these flags depend on
> using $(PKG_CONFIG), and that is also set in various places, I thought I'd ask
> first before going ahead. The idea I have is to gather somewhere the packages
> that are used via their .pc files, and set the appropriate FEATURE_CHECK_* flags
> such that all subdirectories could get them automatically. That may require setting 
> PKG_CONFIG in a common place as well, and then dropping it from places such as
> tools/perf/Makefile.perf. Maybe something like this is Makefile.feature:
> 
> PKG_CONFIG = $(CROSS_COMPILE)pkg-config
> 
> ifneq ($(call get-executable,$(PKG_CONFIG)),)
>     # libtraceevent
>     ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
>       FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent 2>/dev/null)
>       FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent 2>/dev/null)
>     endif
> 
>     # libtracefs
>     ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
>       FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
>       FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
>     endif
> 
>     # ... other packages
> endif
> 
> and this shows that we could also define a function for this, and call it for
> each package, which would simplify things a bit more. These are the Makefiles
> that need to be adjusted:
> 
> tools/perf/Makefile.config
> tools/tracing/latency/Makefile.config
> tools/tracing/rtla/Makefile.config
> tools/verification/rv/Makefile.config

Sounds like a good idea.  It'd be great if we could remove the
duplication and share the common code for this.

Thanks,
Namhyung

> 
> > +      # for linking with debug library, run like:
> > +      # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> > +      FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> > +      FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> > +    endif
> > +    ifeq ($(shell $(PKG_CONFIG) --exists libtracefs),0)
> > +      FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> > +      FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> > +    endif
> >    endif
> >  endif
> >  
> > -- 
> > 2.45.2
> > 
