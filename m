Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C726ACC
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609015; cv=none; b=bK/Wgwq8DucmWAI51Zf+71WNkXI3ww4PuF8D+zxtje3MJ2m4PAIdRwBr/i1aOl6qKvqHnOcb9TiIRVuCzLOIet9Dg/DUVTwY+ICLGxChGismSnOoxEeSdXO8l6OPdsW/Y8cmNFzfta29oSWSZItmcOf1A2BblE1FYdHCjfg+Bgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609015; c=relaxed/simple;
	bh=Md0ZyVA7T00Guem6G1ZLUr5t9gVjCZza+gX2Ktb+2dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg9NRZIR3LHbTOSKr2TgG6r8wwWh54iCN4oA+tFbSKksXrCdrPgJeJILKMXW6JgaYhc36TA5Lopft/+8iAKPW/4vAPVcyCX7h8paS6lNHu9yYQEIlh8TmcMgAqk5ZiDizRViaSD7tMWGoOVpy8hPZymnKS9grHVk6gP4d17zHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W96HYgwj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W96HYgwj"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso6246648a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738609013; x=1739213813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+RIS1anmyO42kqLe5kMSgXbeXH0p5fPwJzPiSotpnQ=;
        b=W96HYgwjnu40c61U6tPEh6fYzJ7nILlhpJx4g1HDPO/IVQV7kbAO0gA2amXBcLpes7
         uR12jU97MXeTY2YPXvWvgygqpIay+QU/ZBWoF4E6CppE9ZDIiLykkmoFWOqIqaRfper1
         yNmy4luztDGA9lGhdac2ENZQhaqdT88wY1a30MnzpRoil5gOEoj+Wu9erHnk47HfUS+9
         lnIfG1RJN28baUtXFtH8bmqGT+940mN7W2toD21Q5LHGCiDfugC8UYMQja10bREnb4bb
         sC3I5BruXJekspI5I1E0ABih7JTjavHn+giTsYeUQMjpcvEN+sowJOdGleJMD6FNiThn
         OrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738609013; x=1739213813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+RIS1anmyO42kqLe5kMSgXbeXH0p5fPwJzPiSotpnQ=;
        b=MQ62dJnOzRT1Uow9NOzw685uyiNEzs0aMFL+mEdsi8NhIpyfgVsqnTWqyk4e6XrmCJ
         nTKsKFYF+IXkbvHuBSKAhQjw1SaMu/KGwrLZ6Ldp3DRXRoLzmGIzz23ZRFWWi7Xg6sPQ
         JrEJw04+fsoQmc6TeQ2Dg1sHItpSApFAIIxNbwCALy4EZzRquhnqjT2s4Csmpq1fl9tB
         n8hUbwn4Ezt6INAs6+Mm5AyWgAuRoi7UzwYtecxFQJ91JZ5OJ+LGSx3r7FKBYNC0scpv
         VvaIzUPhBWyRuECn3Rjkg/5g2E1AkYtjkHaMDPjyKdus8wnfhLDJrhhQY4uQ5GOOuCIM
         hiow==
X-Forwarded-Encrypted: i=1; AJvYcCXLyvSoEld2GPVeFqKHgTuuy4bjl8gwZ/qILze2z3LfPTgV9rBSk7xzAu+1hdmr8SUaDIvq7h0GM33d8Z8oe6Iv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+vHF+ZJ9pnEozaDnzn/dVuvH+QPQvlX45f9LiO/zT2rT6R42
	47x2nQW5QH00MtCcBGp49U/woKCSnVVfQmnW3I7dX+oDmQMapHo9Hj9Zh5y9o8U=
X-Gm-Gg: ASbGncs7+JzFejtGPVw7iUhSfeuOZaVbpbCJOKUm/tco0YVaFXKRJwwpE2HKppn9qta
	Uj/1XDdGGz7lVhVXFhC+NBaxSORgUfMpXHLNTi4c1970iGS+bCbsSaN3RGHbEV8JGEoWUk4h8vj
	ZIbzjBhaHvdUJVq+8kAfRNJpIwsTi6vh12nNJZGl8rFoLBlNYrY4zOU+r3H6d4qxt01xA0pRmyn
	QjCfVO86hgAsPPWclrHb2SnKTwdUpqfxeP2Rb1m9XZxN7fMxInzeXp/vXS1EKkML9GcHOtJ0K0Z
	QoEeR0ub8PU=
X-Google-Smtp-Source: AGHT+IGBmJ3n/5uuBCltpU7FGXXIJ95WtPO9k4G8JoNSK3omRq612AYeWOBWSdlpT4yrQ1aVkRoDkQ==
X-Received: by 2002:a17:90b:2dca:b0:2ee:b666:d14a with SMTP id 98e67ed59e1d1-2f83ac00cf5mr37307194a91.17.1738609012878;
        Mon, 03 Feb 2025 10:56:52 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:4f63:f9d5:2cbd:2947])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a91sm9433086a91.36.2025.02.03.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 10:56:52 -0800 (PST)
Date: Mon, 3 Feb 2025 10:56:48 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH FOR-NEXT] perf tools: Expose quiet/verbose variables in
 Makefile.perf
Message-ID: <Z6ERcG6ZAqL1cFAo@ghost>
References: <20250114-perf_make_test-v1-1-decc1c517b11@rivosinc.com>
 <Z6CMg7uNReyGTq4y@krava>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CMg7uNReyGTq4y@krava>

On Mon, Feb 03, 2025 at 10:29:39AM +0100, Jiri Olsa wrote:
> On Tue, Jan 14, 2025 at 11:35:44AM -0800, Charlie Jenkins wrote:
> > The variables to make builds silent/verbose live inside
> > tools/build/Makefile.build. Move those variables to the top-level
> > Makefile.perf to be generally available.
> > 
> > Committer testing:
> > 
> > See the SYSCALL lines, now they are consistent with the other
> > operations in other lines:
> >   SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
> >   SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
> >   GEN     /tmp/build/perf-tools-next/common-cmds.h
> >   GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
> >   PERF_VERSION = 6.13.rc2.g3d94bb6ed1d0
> >   GEN     perf-archive
> >   MKDIR   /tmp/build/perf-tools-next/jvmti/
> >   MKDIR   /tmp/build/perf-tools-next/jvmti/
> >   MKDIR   /tmp/build/perf-tools-next/jvmti/
> >   MKDIR   /tmp/build/perf-tools-next/jvmti/
> >   GEN     perf-iostat
> >   CC      /tmp/build/perf-tools-next/jvmti/libjvmti.o
> > 
> > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/build/Makefile.build                | 20 -----------------
> >  tools/perf/Makefile.perf                  | 37 ++++++++++++++++++++++++++++++-
> >  tools/perf/tests/shell/coresight/Makefile |  2 +-
> >  3 files changed, 37 insertions(+), 22 deletions(-)
> > 
> > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > index 5fb3fb3d97e0fd114e245805809e4fc926b4343e..e710ed67a1b49d9fda11db02821bbd8d36066b44 100644
> > --- a/tools/build/Makefile.build
> > +++ b/tools/build/Makefile.build
> > @@ -12,26 +12,6 @@
> >  PHONY := __build
> >  __build:
> >  
> > -ifeq ($(V),1)
> > -  quiet =
> > -  Q =
> > -else
> > -  quiet=quiet_
> > -  Q=@
> > -endif
> > -
> > -# If the user is running make -s (silent mode), suppress echoing of commands
> > -# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> > -ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > -short-opts := $(firstword -$(MAKEFLAGS))
> > -else
> > -short-opts := $(filter-out --%,$(MAKEFLAGS))
> > -endif
> > -
> > -ifneq ($(findstring s,$(short-opts)),)
> > -  quiet=silent_
> > -endif
> > -
> >  build-dir := $(srctree)/tools/build
> 
> hi,
> if we move this out of here, we need to fix other tools that rely on that,
> bpftool and resolve_btfids do not build quietly now
> 
> but not sure what was the reason of moving it out, the code in Makefile.perf
> seems same as the one above

perf/Makefile.syscalls wanted to support quiet building. Makefile.perf
imports both Makefile.syscalls and Makefile.build, so I moved this quiet
infrastructure into Makefile.perf so that both of these files could use
it.

I was trying to move the quiet infrastructure higher up in the callchain
so that the code did not need to be duplicated. Perhaps it is better to
move this into a separate file that exports "quiet" and "Q" and then can
be imported from bpf/Makefile, perf/Makefile.perf, and any other tool
that wants to have quiet builds?

- Charlie

> 
> thanks,
> jirka
> 
> 
> >  
> >  # Define $(fixdep) for dep-cmd function
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index a449d0015536442273a9268b37be34e4757f577a..55d6ce9ea52fb2a57b8632cc6d0ddc501e29cbfc 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -161,12 +161,47 @@ export VPATH
> >  SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
> >  endif
> >  
> > +# Beautify output
> > +# ---------------------------------------------------------------------------
> > +#
> > +# Most of build commands in Kbuild start with "cmd_". You can optionally define
> > +# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
> > +# that command is printed by default.
> > +#
> > +# e.g.)
> > +#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
> > +#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
> > +#
> > +# A simple variant is to prefix commands with $(Q) - that's useful
> > +# for commands that shall be hidden in non-verbose mode.
> > +#
> > +#    $(Q)$(MAKE) $(build)=scripts/basic
> > +#
> > +# To put more focus on warnings, be less verbose as default
> > +# Use 'make V=1' to see the full commands
> > +
> >  ifeq ($(V),1)
> > +  quiet =
> >    Q =
> >  else
> > -  Q = @
> > +  quiet=quiet_
> > +  Q=@
> >  endif
> >  
> > +# If the user is running make -s (silent mode), suppress echoing of commands
> > +# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> > +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > +short-opts := $(firstword -$(MAKEFLAGS))
> > +else
> > +short-opts := $(filter-out --%,$(MAKEFLAGS))
> > +endif
> > +
> > +ifneq ($(findstring s,$(short-opts)),)
> > +  quiet=silent_
> > +endif
> > +
> > +export quiet Q
> > +
> >  # Do not use make's built-in rules
> >  # (this improves performance and avoids hard-to-debug behaviour);
> >  MAKEFLAGS += -r
> > diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
> > index b070e779703e9fbd70f88c826172b2150ee3d302..fa08fd9a5991dd889583edc1afe8304e72278f64 100644
> > --- a/tools/perf/tests/shell/coresight/Makefile
> > +++ b/tools/perf/tests/shell/coresight/Makefile
> > @@ -24,6 +24,6 @@ CLEANDIRS = $(SUBDIRS:%=clean-%)
> >  
> >  clean: $(CLEANDIRS)
> >  $(CLEANDIRS):
> > -	$(call QUIET_CLEAN, test-$(@:clean-%=%)) $(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
> > +	$(call QUIET_CLEAN, test-$(@:clean-%=%)) $(MAKE) -C $(@:clean-%=%) clean >/dev/null
> >  
> >  .PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
> > 
> > ---
> > base-commit: e9cbc854d8b148e3491291fb615e94261970fb54
> > change-id: 20250114-perf_make_test-1141d4ad8877
> > -- 
> > - Charlie
> > 
