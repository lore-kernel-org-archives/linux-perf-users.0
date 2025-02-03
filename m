Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4321FF1D1;
	Mon,  3 Feb 2025 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574985; cv=none; b=ukWKuAPVkquI+RnQRCGgW+g4/E+pd3Ni/lUrN+Vlv5py9FRc8IpGWmOp4Dxuouhai/bMFTSDstDE82ldG9j1h7Ng3qMSJjnt+E4FbGLtZUnO0JQu5ex1cD52hiv+lJyb/Gyhpbtr4Kt3vNq2d2H33rqJKAn2Pnz/0UrsO2DSMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574985; c=relaxed/simple;
	bh=TZKBR/r34WNq13ZxlLK4zNq2VCGwmLNvxPGHJHEPi4w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC11dzu/RfbZOBJtdGTfnspWe63pKGlFSh8B7jUivqxTdAvm/BLmwss9n/nJ3pQ6z9IxPOrNNO4S3V2yh2U5YjYK4duMC8duyGeD7wJ9KDiHo1xsK+POWnAJPLrXBseIV1RNbYaPHjQFs0ro/Otq1v1WjZZ2644fFvcCwKCpFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMO8T5PD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMO8T5PD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43618283d48so30292615e9.1;
        Mon, 03 Feb 2025 01:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738574982; x=1739179782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5BmdsxYindROyEwYQx0IEqFZPb+xMDZtfISooSkYtE=;
        b=RMO8T5PDKtDVLHW4j2i8lrVyHnlfo/9Jr6wWxu3wPWUcnTUm7/dGebmxEvW0PVsniW
         fq8VEBFVjRVwd+Yyxp2e5iInK2Hj285mrgGAS+MR+RqC01db4Vu5ZxqBpKFGv9LA3xsv
         kfW+Xr6j48uKazktVUMr2Fx3RViDljm6bZ8Y+/6j/AXmIfwcTznLKebDHoIgZA5rIZsN
         Y10jObCBuTYRz11Do/G0cGaBKvDRULYpUTo4yWBeMWzCD++vIZUCQB5FwhY6Fk3hq6tZ
         2LgDnQVJ73oGIzrAUxtgZtlk75HBYQXuaVekRKD3wg10mBqjSFe4Fs/swvD66v/CzTIB
         L1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738574982; x=1739179782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5BmdsxYindROyEwYQx0IEqFZPb+xMDZtfISooSkYtE=;
        b=YkwXYkIrXQqvs3XycERwkCqqspj9Y7a1o+FQ662cgWZh5EswOvKGLvZTqUYKzbAvDG
         mIzUgwD5WSVpd8YHddOL3dZPj1ldhLoDXUZzgw/muXojYbEPr0YicAiXp0yxLgyC8xma
         rxy4yGd9Bt4rDRlMq2bn+wjwnOy8sm1Ddm802p5QG5eSvP73nI3NpbKYJ894TAbbOFd6
         I6Kcigwz99Od3L8b61ZaxtF7Ep/Vk/qTWA8En5KVImVFLQ/0eBRUCqPWRFi1hb2zZDfh
         dAzG8cS4rff9rNmHrWjl++IcVTAxUVdSLTqOC7maDe7IjJvh1KWWkWSpyoYWqo84WJjS
         /y9A==
X-Forwarded-Encrypted: i=1; AJvYcCW5HdZCnF0OLVQyqtpaAKEX5aV0JefMiZL774xYh5ih336nngL976oIIT3WTEJ6QRL0R2myYanjMQqTvEE=@vger.kernel.org, AJvYcCWIfzvq69nA9Hum1Ras55BZniqjDIyd34rkcw33Y57VWadXLkzsvTweI6BQJBDlrgC+ZWMyOC+gJvuFLBBZTlu6Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WeugsyOkodiP8GDIg/bx3r/LpzRf9kTtjCY77U7d+dfz2ENd
	iC05v+yGqw4LvHBTDV9/a5uAfA42I/09nZAf6juOsJ7JHBCHvmHH3YfYNVfodqw=
X-Gm-Gg: ASbGncsVz8J/Nri9AinIYu/xnCNq30LdWKc3avMDuwVSLsGLLeiv3cBvoaAmoporSdm
	bqk1iMmat755REzH8+dsjSPTJT7mGj6E/FHFeA1DaIEMcJI/wBEmFryZ8cY6qUJNSSOIkRLtUsT
	5D9JsQZtMOoF3e1Cut+IqwHF//KybtRRICEl4RZcidlxJLvsm1wngucSExSBHIUxWel0qWkhRo8
	g/IdLC/lbGHqnKqdSkx1QcY1Td01p7wAl9bg+IhtU5af4DVByHxN4BKUnmZt1ABlnU3BJFNrDWc
	2Q2chCw86sOiz8bAe0tJfMs37xdRi6V+pDfecJOpJTS44qaP
X-Google-Smtp-Source: AGHT+IFuHW3hM3BOGY6M8cP0ZLEbBCcmhBayM4i5XZ+NC6RZgJD3BLrQOTvbi7YGzPw1vjzIo5sGpA==
X-Received: by 2002:a5d:648b:0:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38c51930c8dmr15385208f8f.9.1738574981803;
        Mon, 03 Feb 2025 01:29:41 -0800 (PST)
Received: from krava (213.11-246-81.adsl-static.isp.belgacom.be. [81.246.11.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ece21sm12028822f8f.20.2025.02.03.01.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 01:29:41 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 3 Feb 2025 10:29:39 +0100
To: Charlie Jenkins <charlie@rivosinc.com>
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
Message-ID: <Z6CMg7uNReyGTq4y@krava>
References: <20250114-perf_make_test-v1-1-decc1c517b11@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-perf_make_test-v1-1-decc1c517b11@rivosinc.com>

On Tue, Jan 14, 2025 at 11:35:44AM -0800, Charlie Jenkins wrote:
> The variables to make builds silent/verbose live inside
> tools/build/Makefile.build. Move those variables to the top-level
> Makefile.perf to be generally available.
> 
> Committer testing:
> 
> See the SYSCALL lines, now they are consistent with the other
> operations in other lines:
>   SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
>   SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
>   GEN     /tmp/build/perf-tools-next/common-cmds.h
>   GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
>   PERF_VERSION = 6.13.rc2.g3d94bb6ed1d0
>   GEN     perf-archive
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   GEN     perf-iostat
>   CC      /tmp/build/perf-tools-next/jvmti/libjvmti.o
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/Makefile.build                | 20 -----------------
>  tools/perf/Makefile.perf                  | 37 ++++++++++++++++++++++++++++++-
>  tools/perf/tests/shell/coresight/Makefile |  2 +-
>  3 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index 5fb3fb3d97e0fd114e245805809e4fc926b4343e..e710ed67a1b49d9fda11db02821bbd8d36066b44 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -12,26 +12,6 @@
>  PHONY := __build
>  __build:
>  
> -ifeq ($(V),1)
> -  quiet =
> -  Q =
> -else
> -  quiet=quiet_
> -  Q=@
> -endif
> -
> -# If the user is running make -s (silent mode), suppress echoing of commands
> -# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> -ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> -short-opts := $(firstword -$(MAKEFLAGS))
> -else
> -short-opts := $(filter-out --%,$(MAKEFLAGS))
> -endif
> -
> -ifneq ($(findstring s,$(short-opts)),)
> -  quiet=silent_
> -endif
> -
>  build-dir := $(srctree)/tools/build

hi,
if we move this out of here, we need to fix other tools that rely on that,
bpftool and resolve_btfids do not build quietly now

but not sure what was the reason of moving it out, the code in Makefile.perf
seems same as the one above

thanks,
jirka


>  
>  # Define $(fixdep) for dep-cmd function
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a449d0015536442273a9268b37be34e4757f577a..55d6ce9ea52fb2a57b8632cc6d0ddc501e29cbfc 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -161,12 +161,47 @@ export VPATH
>  SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
>  endif
>  
> +# Beautify output
> +# ---------------------------------------------------------------------------
> +#
> +# Most of build commands in Kbuild start with "cmd_". You can optionally define
> +# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
> +# that command is printed by default.
> +#
> +# e.g.)
> +#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
> +#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
> +#
> +# A simple variant is to prefix commands with $(Q) - that's useful
> +# for commands that shall be hidden in non-verbose mode.
> +#
> +#    $(Q)$(MAKE) $(build)=scripts/basic
> +#
> +# To put more focus on warnings, be less verbose as default
> +# Use 'make V=1' to see the full commands
> +
>  ifeq ($(V),1)
> +  quiet =
>    Q =
>  else
> -  Q = @
> +  quiet=quiet_
> +  Q=@
>  endif
>  
> +# If the user is running make -s (silent mode), suppress echoing of commands
> +# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> +short-opts := $(firstword -$(MAKEFLAGS))
> +else
> +short-opts := $(filter-out --%,$(MAKEFLAGS))
> +endif
> +
> +ifneq ($(findstring s,$(short-opts)),)
> +  quiet=silent_
> +endif
> +
> +export quiet Q
> +
>  # Do not use make's built-in rules
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS += -r
> diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
> index b070e779703e9fbd70f88c826172b2150ee3d302..fa08fd9a5991dd889583edc1afe8304e72278f64 100644
> --- a/tools/perf/tests/shell/coresight/Makefile
> +++ b/tools/perf/tests/shell/coresight/Makefile
> @@ -24,6 +24,6 @@ CLEANDIRS = $(SUBDIRS:%=clean-%)
>  
>  clean: $(CLEANDIRS)
>  $(CLEANDIRS):
> -	$(call QUIET_CLEAN, test-$(@:clean-%=%)) $(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
> +	$(call QUIET_CLEAN, test-$(@:clean-%=%)) $(MAKE) -C $(@:clean-%=%) clean >/dev/null
>  
>  .PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
> 
> ---
> base-commit: e9cbc854d8b148e3491291fb615e94261970fb54
> change-id: 20250114-perf_make_test-1141d4ad8877
> -- 
> - Charlie
> 
