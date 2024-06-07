Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E208249F
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Jun 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761878; cv=none; b=nyv/x+JorHsRpLeQE7LI8GkCyKHTy36C4q6fLmd8/7hqwFHeaaJf37gU73vR8vF5HJdQjAQTKk2bAqqgPcJEs2Cu5mACD/QAN8LsO0we9SSUvdzl6Z5P0zsByzLqZ1lPkEY6lEpSBRQ4iTZ+Xvm7Yd6qKpcQT+5AvL2q6S2tL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761878; c=relaxed/simple;
	bh=3yiI1XFIefBVXYrrmj9ELPKOJK2WltXgzQzUxW8MTFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3y5gf30mo42+Dz/VD87iWe30beIORq8Vv1azRxkiSho5pBoEBRhMKaGG27UN21nXSW2GNWgSGVjqEwZgaKwaPNdcpAw6DRldAH4oEoh/ZllzeMz9eujYbTLj1b+6dLKuWKb4mFTQ5dYex1o81zLfF3LnP/qdnUfvD5+gEP2IyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 7 Jun 2024 14:04:31 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Leo Yan <leo.yan@arm.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf build: Use pkg-config for feature check for
 libtrace{event,fs}
Message-ID: <ZmL3T8wACBQNbAmv@gentoo.org>
References: <20240606153625.2255470-1-amadio@gentoo.org>
 <20240606153625.2255470-2-amadio@gentoo.org>
 <b914e8b4-c3b3-4809-8708-69b53c25a294@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b914e8b4-c3b3-4809-8708-69b53c25a294@arm.com>

Dear Leo,

On Thu, Jun 06, 2024 at 05:28:47PM +0100, Leo Yan wrote:
> 
> 
> On 6/6/24 16:33, amadio@gentoo.org wrote:
> > From: Guilherme Amadio <amadio@gentoo.org>
> >
> > Needed to add required include directories for the feature detection
> > to succeed. The header tracefs.h is installed either into the include
> > directory /usr/include/tracefs/tracefs.h when using the Makefile, or
> > into /usr/include/libtracefs/tracefs.h when using meson to build
> > libtracefs. The header tracefs.h uses #include <event-parse.h> from
> > libtraceevent, so pkg-config needs to pick the correct include directory
> > for libtracefs and add the one for libtraceevent to succeed.
> >
> > Note that in baa2ca59ec1e31ccbe3f24ff0368152b36f68720 the variable
> > LIBTRACEEVENT_DIR was introduced, and now the method to compile against
> > non-standard locations requires PKG_CONFIG_PATH to be set instead, which
> > works for both libtraceevent and libtracefs.
> 
> Should we advise users to use PKG_CONFIG_LIBDIR or PKG_CONFIG_PATH?
> 
> When I wrote the patch set [1], at the beginning I also used the env
> PKG_CONFIG_PATH, but later I think PKG_CONFIG_LIBDIR is better for users
> for only lib path setting.
> 
> [1]
> https://lore.kernel.org/linux-perf-users/20240604093223.1934236-3-leo.yan@arm.com/T/#mec2e44d6091dc1cf5f827b6542592b2938f1b697

Thank you for the review. The documentation says:

- PKG_CONFIG_PATH:        List of secondary directories where `.pc' files are looked up.
- PKG_CONFIG_LIBDIR:      List of primary directories where `.pc' files are looked up.
- PKG_CONFIG_SYSROOT_DIR: `sysroot' directory, will be prepended to every path defined in PKG_CONFIG_PATH.  Useful for cross compilation.

So I think what's best depends on what the user is doing. In my case, I
was not cross-compiling, just using a non-standard location from where
to pick up the dependencies in /opt. For cross-compilation, using
PKG_CONFIG_SYSROOT_DIR might make sense instead of either of the other
two options. I will update the comment accordingly.

The other question I have is about other dependencies that use a similar
style, like capstone, should we also update them in the same way to rely
on pkg-config?

Best regards,
-Guilherme

> 
> > Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> > Cc: Ian Rogers <irogers@google.com>
> > ---
> >   tools/build/feature/test-libtracefs.c |  2 +-
> >   tools/perf/Makefile.config            | 27 +++++++++++++--------------
> >   2 files changed, 14 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/build/feature/test-libtracefs.c b/tools/build/feature/test-libtracefs.c
> > index 8eff16c0c10b..29a757a7d848 100644
> > --- a/tools/build/feature/test-libtracefs.c
> > +++ b/tools/build/feature/test-libtracefs.c
> > @@ -1,5 +1,5 @@
> >   // SPDX-License-Identifier: GPL-2.0
> > -#include <tracefs/tracefs.h>
> > +#include <tracefs.h>
> >
> >   int main(void)
> >   {
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 7f1e016a9253..54a6c6bf23c7 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -183,14 +183,12 @@ FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
> >   FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
> >
> >   # for linking with debug library, run like:
> > -# make DEBUG=1 LIBTRACEEVENT_DIR=/opt/libtraceevent/
> > -TRACEEVENTLIBS := -ltraceevent
> > -ifdef LIBTRACEEVENT_DIR
> > -  LIBTRACEEVENT_CFLAGS  := -I$(LIBTRACEEVENT_DIR)/include
> > -  LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
> > -endif
> > -FEATURE_CHECK_CFLAGS-libtraceevent := $(LIBTRACEEVENT_CFLAGS)
> > -FEATURE_CHECK_LDFLAGS-libtraceevent := $(LIBTRACEEVENT_LDFLAGS) $(TRACEEVENTLIBS)
> > +# make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> > +FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> > +FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> > +
> > +FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> > +FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> >
> >   FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
> >   # include ARCH specific config
> > @@ -1178,10 +1176,10 @@ endif
> >   ifneq ($(NO_LIBTRACEEVENT),1)
> >     $(call feature_check,libtraceevent)
> >     ifeq ($(feature-libtraceevent), 1)
> > -    CFLAGS += -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
> > -    LDFLAGS += $(LIBTRACEEVENT_LDFLAGS)
> > -    EXTLIBS += ${TRACEEVENTLIBS}
> > -    LIBTRACEEVENT_VERSION := $(shell PKG_CONFIG_PATH=$(LIBTRACEEVENT_DIR) $(PKG_CONFIG) --modversion libtraceevent)
> > +    CFLAGS += -DHAVE_LIBTRACEEVENT
> > +    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtraceevent)
> > +    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtraceevent)
> > +    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
> >       LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
> >       LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
> >       LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
> > @@ -1194,7 +1192,9 @@ ifneq ($(NO_LIBTRACEEVENT),1)
> >
> >     $(call feature_check,libtracefs)
> >     ifeq ($(feature-libtracefs), 1)
> > -    EXTLIBS += -ltracefs
> > +    CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs)
> > +    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
> > +    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtracefs)
> >       LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs)
> >       LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
> >       LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
> > @@ -1315,7 +1315,6 @@ ifeq ($(VF),1)
> >     $(call print_var,LIBUNWIND_DIR)
> >     $(call print_var,LIBDW_DIR)
> >     $(call print_var,JDIR)
> > -  $(call print_var,LIBTRACEEVENT_DIR)
> 
> Except above comment, the change looks good to me:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> >
> >     ifeq ($(dwarf-post-unwind),1)
> >       $(call feature_print_text,"DWARF post unwind library", $(dwarf-post-unwind-text)) $(info $(MSG))
> > --
> > 2.45.1
> >
> >
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
