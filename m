Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DF253F0C;
	Tue, 29 Apr 2025 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955090; cv=none; b=NPgQ4sl/PwBsCrR4/KpRPlvl83y1cbqZ8c9UuZvVXDYa4DY2tLvcPY9J+1YIgMOj7+r+mxcmaKm2GPKvWVIwViV7d9s/Cp6VcBnADtY/bn5RCki7ZUfUht6Pi+ElnXSFdYvvgaLkX2ClpO0lPn3Baw2BOlzwBpm77FeUK15Bbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955090; c=relaxed/simple;
	bh=E06KLMc9ut2C8183Z9uZRwX896+RnnB8y+ankyRhiOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf/R12RVCScX2MajSVpsSp8Eu4+Hp4DqV3xSc2jsuKJ8XYT6mSNKrwjRnubOK8SQuSgoHEYA9EAWm0weCZZGXSSN1v7X1urI1oloGlfvM3tC+8lbPXyy7tIu8BL9DHgHqU3GVsjXBdv0X6a2ZzNT11307zdajtbJ1z2tWboXsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp0QfeAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp0QfeAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23A9C4CEE3;
	Tue, 29 Apr 2025 19:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745955090;
	bh=E06KLMc9ut2C8183Z9uZRwX896+RnnB8y+ankyRhiOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tp0QfeANEdC5O/loeaMJSlz3kEDkDGfMcsD9PiQSQd4iB+q/F+f6Kba/QTI7BkfCq
	 cJvKTnAJ6OJE2ClINacBN0vHNfQyy8c2v2u55sDA/zHI8xY585KFrH/35AvfL1XN6O
	 hPeHOhTFta0C+SL9ZAn6RLR6yxAB2Wl7s+ONGwetTDQNGJoiSJEf1ycaO0DZdM91c3
	 CfGGmc3X8srNWiaIZGkajWSH1hZQhfJw/xB3Wr0Q/n+PnMD908MXqNsa7J50lsGceP
	 iZWcpPvCBkZVrmliEU30k5D1RoN5fqoAzG/svCJ8Ie5AHj2FSaK3xX5BHPO+Ae3rTf
	 k8mLXqOx/M3+Q==
Date: Tue, 29 Apr 2025 12:31:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, linux@leemhuis.info,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix in-source libperf build
Message-ID: <aBEpEEN1zKQyeROr@google.com>
References: <20250429-james-perf-fix-libperf-in-source-build-v1-1-a1a827ac15e5@linaro.org>
 <aBEUFK6o41mlkd9j@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBEUFK6o41mlkd9j@x1>

On Tue, Apr 29, 2025 at 03:01:56PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 29, 2025 at 03:22:18PM +0100, James Clark wrote:
> > When libperf is built alone in-source, $(OUTPUT) isn't set. This causes
> > the generated uapi path to resolve to '/../arch' which results in a
> > permissions error:
>  
> >   mkdir: cannot create directory '/../arch': Permission denied
> 
> So this requires the only outstanding patch in perf-tools/perf-tools:
> 
> ⬢ [acme@toolbx perf-tools-next]$ git log -5 --oneline perf-tools/perf-tools
> bfb713ea53c746b0 (perf-tools/tmp.perf-tools, perf-tools/perf-tools, perf-tools) perf tools: Fix arm64 build by generating unistd_64.h
> 9c32cda43eb78f78 (tag: v6.15-rc3) Linux 6.15-rc3
> ac71fabf15679fc7 gcc-15: work around sequence-point warning
> 05e8d261a34e5c63 gcc-15: add '__nonstring' markers to byte arrays
> be913e7c4034bd7a gcc-15: get rid of misc extra NUL character padding
> ⬢ [acme@toolbx perf-tools-next]$
> 
> So probably should go to there, to be submitted to Linus in the current
> merge window, right?
> 
> Namhyung?

Yep, I'll add it to the perf-tools tree and send a PR later.

Thanks,
Namhyung

> 
> - Arnaldo
>  
> > Fix it by removing the preceding '/..' which means that it gets
> > generated either in the tools/lib/perf part of the tree or the OUTPUT
> > folder. Some other rules that rely on OUTPUT further refine this
> > conditionally depending on whether it's an in-source or out-of-source
> > build, but I don't think we need the extra complexity here. And this
> > rule is slightly different to others because the header is needed by
> > both libperf and Perf. This is further complicated by the fact that Perf
> > always passes O=... to libperf even for in source builds, meaning that
> > OUTPUT isn't set consistently between projects.
> > 
> > Because we're no longer going one level up to try to generate the file
> > in the tools/ folder, Perf's include rule needs to descend into libperf.
> > Also fix the clean rule while we're here.
> > 
> > Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> > Closes: https://lore.kernel.org/linux-perf-users/7703f88e-ccb7-4c98-9da4-8aad224e780f@leemhuis.info/
> > Fixes: bfb713ea53c7 ("perf tools: Fix arm64 build by generating unistd_64.h")
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >  tools/lib/perf/Makefile    | 6 +++---
> >  tools/perf/Makefile.config | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> > index 1a19b5013f45..7fbb50b74c00 100644
> > --- a/tools/lib/perf/Makefile
> > +++ b/tools/lib/perf/Makefile
> > @@ -42,7 +42,7 @@ libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
> >  TEST_ARGS := $(if $(V),-v)
> >  
> >  INCLUDES = \
> > --I$(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi \
> > +-I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi \
> >  -I$(srctree)/tools/lib/perf/include \
> >  -I$(srctree)/tools/lib/ \
> >  -I$(srctree)/tools/include \
> > @@ -100,7 +100,7 @@ $(LIBAPI)-clean:
> >  	$(call QUIET_CLEAN, libapi)
> >  	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
> >  
> > -uapi-asm := $(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi/asm
> > +uapi-asm := $(OUTPUT)arch/$(SRCARCH)/include/generated/uapi/asm
> >  ifeq ($(SRCARCH),arm64)
> >  	syscall-y := $(uapi-asm)/unistd_64.h
> >  endif
> > @@ -130,7 +130,7 @@ all: fixdep
> >  clean: $(LIBAPI)-clean
> >  	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
> >                  *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd tests/*.o LIBPERF-CFLAGS $(LIBPERF_PC) \
> > -                $(TESTS_STATIC) $(TESTS_SHARED)
> > +                $(TESTS_STATIC) $(TESTS_SHARED) $(syscall-y)
> >  
> >  TESTS_IN = tests-in.o
> >  
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index a52482654d4b..b7769a22fe1a 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -29,7 +29,7 @@ include $(srctree)/tools/scripts/Makefile.arch
> >  $(call detected_var,SRCARCH)
> >  
> >  CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
> > -CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi
> > +CFLAGS += -I$(OUTPUT)libperf/arch/$(SRCARCH)/include/generated/uapi
> >  
> >  # Additional ARCH settings for ppc
> >  ifeq ($(SRCARCH),powerpc)
> > 
> > ---
> > base-commit: bfb713ea53c746b07ae69fe97fa9b5388e4f34f9
> > change-id: 20250429-james-perf-fix-libperf-in-source-build-15609cc212aa
> > 
> > Best regards,
> > -- 
> > James Clark <james.clark@linaro.org>
> > 
