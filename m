Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4213A25B;
	Wed,  3 Jul 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010161; cv=none; b=SRFyfO5b/0C8fEYWgC4PFmVjLafN+bGAqRgH9ofWLUJAzbQpVlb72EcuaDAXjF7wVGDFLirvDiUVjoKqNkUcsbh+ffqFWTsBhOkXAC8mfVw+asp4MXr+5STCJVQpgt3MqaERxYBK86iiYuK7iF8ZsH96FeOjTIqyroNY07QMurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010161; c=relaxed/simple;
	bh=onepRnVIoj8wYu4Zze0ForhgqtXoWegKGDXPt8UNkJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmmSAmu35j9/3CsTkuf6OswGL6c3NRJpmpZq/3huzN3apBZFToA0AGyUCi9qMoaPwB+/dKWQgiCDfY/2Cd8Pf0xSOUvHYM6u3eDJ3JmY3YpEx0SzgikjqQGp6vVI9d+My4wLvs/R9yFWVeU/RpWUwan9T0BeY108bYWc8SXvGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Wed, 3 Jul 2024 14:35:54 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] perf build: Conditionally add feature check flags
 for libtrace{event,fs}
Message-ID: <ZoVFqiZdTXy1glLc@gentoo.org>
References: <20240628202608.3273329-1-amadio@gentoo.org>
 <20240628203432.3273625-1-amadio@gentoo.org>
 <ZoSOR0ULxXLxLZvA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoSOR0ULxXLxLZvA@google.com>

Hello,

On Tue, Jul 02, 2024 at 04:33:27PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Jun 28, 2024 at 10:34:27PM +0200, Guilherme Amadio wrote:
> > This avoids reported warnings when the packages are not installed.
> > 
> > Fixes: 0f0e1f44569061e3dc590cd0b8cb74d8fd53706b
> > Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> 
> Thanks for working on this.
> 
> > ---
> >  tools/perf/Makefile.config | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 5271a4c1d2b3..5387babb8f04 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -182,13 +182,21 @@ endif
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
> > +ifneq ($(NO_LIBTRACEEVENT),1)
> > +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> > +  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
> 
> I know you just copied the code, but IIRC we wanted to remove this dummy
> assignment before.

Sure, I will change this. I think we can also remove the "dummy :=" part and
just do $(error Error: ...), like it's done in other places.

> > +  endif
> > +endif
> > +ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
> > +  # for linking with debug library, run like:
> > +  # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> > +  FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> > +  FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> > +endif
> > +ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
> > +  FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> > +  FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> 
> I'm curious if we can redirect stderr to /dev/null to surpress the
> output when pkg-config is not installed.  Then we don't need to check
> the `ifeq`.

I was wondering that myself when I added the check, if you prefer to redirect
stderr to /dev/null, I will do it that way then when I submit v3.

Thanks for the review.

Best regards,
-Guilherme

> 
> Thanks,
> Namhyung
> 
> 
> > +endif
> >  
> >  FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
> >  # include ARCH specific config
> > @@ -208,12 +216,6 @@ ifeq ($(call get-executable,$(BISON)),)
> >    $(error Error: $(BISON) is missing on this system, please install it)
> >  endif
> >  
> > -ifneq ($(NO_LIBTRACEEVENT),1)
> > -  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> > -  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
> > -  endif
> > -endif
> > -
> >  ifneq ($(OUTPUT),)
> >    ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
> >      BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
> > -- 
> > 2.45.2
> > 
