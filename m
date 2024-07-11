Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DEB42AB5;
	Thu, 11 Jul 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735714; cv=none; b=bdyIj3gKNvLpSFMdyYK+Zm/EsQzyw4yJlEXiLSHGni2ijm6lj9RS8CEZ64HfyFLNQlzWswibWSWwol2PGEvQthwR82/hqF+Ai0bMtjllooPlZIpo0os8qdS0uj5tRRVs34daTVIx2mdoa8y3P8KGFpXX8Pg4oWsu4Gopm6l3roA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735714; c=relaxed/simple;
	bh=djdztjiMohQIgYnDLRcYcPqXdFDkPuGeeTVUgFY6hbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEe6kvlxlvbrmkh9/xtKTGyY3jGAA/K2+dimhwN5LAqRQgqQBAc0VGOLm18hii3YhgxDDAGzwvTe5mTG0Gt7d5IxSOAMOX2lha9qJw7WJGzX88DAXm/ZM/blJljNGkVE6wtQbV68aftNMNngC1sx9OlCvJeQDFmpoQvho5ezRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRRCW1+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRRCW1+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A8DC116B1;
	Thu, 11 Jul 2024 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735714;
	bh=djdztjiMohQIgYnDLRcYcPqXdFDkPuGeeTVUgFY6hbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRRCW1+Y0fhMUNO7PJroj4O2Mk/VC4hRrsWgyqVax+6zKJmL9nLLTqJMbNKAGC9d8
	 0z9KEL787lp6cXbk9sYFG+LT42CRgBG4slpXOhSfJkf//p+joYQec9byAY8zPL/PX3
	 JPz7lNTXMRUQ5tWxx0TaLBCRu+qtt8A4AmGzKoID/wOAPRmxia3NepLKN11F9t5esP
	 8hS2wq7dkF9FTQuUqN6JgJfvGVZjxTQjck0Q+1skG+fq/77Quv9e3qyH60+8JvmMm3
	 sYYd/hiAsIxv6YudcHRQ+MRG/rQ7Ohaf4QHmo+eCBRBbNPiXAVQPLU65VF7yL3seQR
	 D0vOG2PU+DB+Q==
Date: Thu, 11 Jul 2024 15:08:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] perf build: Conditionally add feature check flags
 for libtrace{event,fs}
Message-ID: <ZpBX3gE1wJ89gUlt@google.com>
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

Hello,

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

Due to the timing of the merge window, I'll apply this patch (1/6 only)
with the following modification.  Please take a look and update v3.

Thanks,
Namhyung

---
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5387babb8f04..a4829b6532d8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -184,19 +184,17 @@ FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
 
 ifneq ($(NO_LIBTRACEEVENT),1)
   ifeq ($(call get-executable,$(PKG_CONFIG)),)
-  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
+    $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
   endif
 endif
-ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
-  # for linking with debug library, run like:
-  # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
-  FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
-  FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
-endif
-ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
-  FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
-  FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
-endif
+
+# for linking with debug library, run like:
+# make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
+FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent 2>/dev/null)
+FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent 2>/dev/null)
+
+FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null)
+FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs 2>/dev/null)
 
 FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 # include ARCH specific config

