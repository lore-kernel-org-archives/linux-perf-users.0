Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF30192B70;
	Wed,  3 Jul 2024 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042192; cv=none; b=TGbGDqg/3+6oFh/9XWciFsyAjH1ox3SPJk11Zfmd4cSZ0GLhsWxLPoUpVXhL9hvvzMHxcjSU8OXyzM46tAVSdaq7ErJp2n5/3/0vYrOASDL+3U9uFEO9bN38dOEtVb/RVwxafhhLhK7PIDqs+1fhPnzfmXTDzXAG/lAc1FMWr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042192; c=relaxed/simple;
	bh=FNqtIxiz/iLSE0auqATLt3TNJBkF0qDalYBF2yAIu+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLCB+Sw/1RT+eZ8eF1rJxL+BJmuCfGYWvQrboY7/aRl0Sl3N3PnKdbZEdIioyZw/X5Y7lFjKb18Q5qyhvVdJeoTcltTLAnV5DXi8HMZINas2VShU+jIAHunYXym8ZjWOCn7fvP4OdM4OM5uL/yKsyKadBGSy+XzucwrRGgXeErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pv01mkK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv01mkK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DE8C2BD10;
	Wed,  3 Jul 2024 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720042191;
	bh=FNqtIxiz/iLSE0auqATLt3TNJBkF0qDalYBF2yAIu+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pv01mkK1YBpFTAXKz488wlegYxCoyJ4soI5WNa957/Xie4y5GMbcs8mVvthbT9BAI
	 SA5VL+ZSQLB3F800JE6hrfXLNAu5sxl2m9fkfywTgJWUw0XH9EBXCJ3x6GUxJ0DlK2
	 MfauCsZNyW+QtbE9rH6IMsKP9o8ru8OSHh6JB2ExKZD1HojBsqOWV07RgO6erqAYuj
	 cNgjQpw1a+TAALghtCWK/dSyJo8Adb9z/pyvn9tIDSc23FZkFEnyqU/KS7yG4VFdol
	 MHRZz8fHu4ala5dLONlnQJi+zSwKtCferT2H2PkrHK67uw9zS1ytK62XpFyKWhwXiC
	 Zwj2d3RrrpIuA==
Date: Wed, 3 Jul 2024 14:29:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] perf build: Conditionally add feature check flags
 for libtrace{event,fs}
Message-ID: <ZoXCzbU_oHSZQzO7@google.com>
References: <20240628202608.3273329-1-amadio@gentoo.org>
 <20240628203432.3273625-1-amadio@gentoo.org>
 <ZoSOR0ULxXLxLZvA@google.com>
 <ZoVFqiZdTXy1glLc@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoVFqiZdTXy1glLc@gentoo.org>

On Wed, Jul 03, 2024 at 02:35:54PM +0200, Guilherme Amadio wrote:
> Hello,
> 
> On Tue, Jul 02, 2024 at 04:33:27PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Fri, Jun 28, 2024 at 10:34:27PM +0200, Guilherme Amadio wrote:
> > > This avoids reported warnings when the packages are not installed.
> > > 
> > > Fixes: 0f0e1f44569061e3dc590cd0b8cb74d8fd53706b
> > > Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> > 
> > Thanks for working on this.
> > 
> > > ---
> > >  tools/perf/Makefile.config | 28 +++++++++++++++-------------
> > >  1 file changed, 15 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 5271a4c1d2b3..5387babb8f04 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -182,13 +182,21 @@ endif
> > >  FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
> > >  FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
> > >  
> > > -# for linking with debug library, run like:
> > > -# make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> > > -FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> > > -FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> > > -
> > > -FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> > > -FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> > > +ifneq ($(NO_LIBTRACEEVENT),1)
> > > +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> > > +  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
> > 
> > I know you just copied the code, but IIRC we wanted to remove this dummy
> > assignment before.
> 
> Sure, I will change this. I think we can also remove the "dummy :=" part and
> just do $(error Error: ...), like it's done in other places.

Exactly.

> 
> > > +  endif
> > > +endif
> > > +ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
> > > +  # for linking with debug library, run like:
> > > +  # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> > > +  FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> > > +  FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> > > +endif
> > > +ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
> > > +  FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> > > +  FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> > 
> > I'm curious if we can redirect stderr to /dev/null to surpress the
> > output when pkg-config is not installed.  Then we don't need to check
> > the `ifeq`.
> 
> I was wondering that myself when I added the check, if you prefer to redirect
> stderr to /dev/null, I will do it that way then when I submit v3.

Yep, let's have a fewer lines of changes.

> 
> Thanks for the review.

No problem and thanks for your contribution!

Thanks,
Namhyung

> > 
> > > +endif
> > >  
> > >  FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
> > >  # include ARCH specific config
> > > @@ -208,12 +216,6 @@ ifeq ($(call get-executable,$(BISON)),)
> > >    $(error Error: $(BISON) is missing on this system, please install it)
> > >  endif
> > >  
> > > -ifneq ($(NO_LIBTRACEEVENT),1)
> > > -  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> > > -  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
> > > -  endif
> > > -endif
> > > -
> > >  ifneq ($(OUTPUT),)
> > >    ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
> > >      BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
> > > -- 
> > > 2.45.2
> > > 
