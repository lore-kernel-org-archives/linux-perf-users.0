Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC11798F;
	Wed, 15 Jan 2025 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907817; cv=none; b=I46US03avPDrqovNwL4Dx9OdMkd0E693NCi8L7bz4pHLXS4GHJtQeCchuBMSD6T+Tf9mgBR93I5hyiuyJ5QFKjjFVx1O0oh/FLIkQ6g6dsSzYX3yrFBmTiAbjZOI4uF/xSMffFPRAOFYeAnRUBeQUbSy+CaWmPUqZExxVGBGMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907817; c=relaxed/simple;
	bh=t9IoNRRCbOWQRw25rwjkYf6zDbI9Dtsr5fab7DWXAT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1dXsf2q/Mm9I2aeEAoIKfFpivy4DdpcrA7sd2HMyHkraiHaJBINZas6f4JWuOOP+n84qiLKb4r4T0o9mTz5cwYXecGQ6ayGQ0Cb8fnzATNcM4D7Ykfj+ZOvIfdChHzsykGv44klA3koNC0JnIMXIwJk97aC8cqIa8fzunHAFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeyjP26i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeyjP26i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AA0C4CEDD;
	Wed, 15 Jan 2025 02:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736907816;
	bh=t9IoNRRCbOWQRw25rwjkYf6zDbI9Dtsr5fab7DWXAT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AeyjP26i3xXsH95t7VhlwUX4/segivJul/tp7J/qBzO03r0FtkQNU0y68QahLAAtt
	 sGk8kjbxiQTAzfjaR0Guqp3NRqH5AiXQ00jCe7cYCfAfPK1w2mi8fvqV0IrP+i0G2M
	 b534IvM5wa1+xoCIAf4wzTkFp2hs3dpkGi/RT86/KQvL7fQXMaralVOf33GgD7QB9l
	 JAPRXkCLh8FjsQp/kTQBzf7z9IFJeQt7HyyNdJvWIFOG6gfaggouXNimL6bKzbWrc6
	 kiARitriDPMoRN8VJzRHQLn7L3a4b7suDA2PjEoMcnSikv1++hXNoNV8n7PXmYV4Ew
	 2thbOUCTjM3LQ==
Date: Tue, 14 Jan 2025 23:23:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH FOR-NEXT] perf tools: Expose quiet/verbose variables in
 Makefile.perf
Message-ID: <Z4ccJVRHiApkvqxb@x1>
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

Re-tested, now the lines below continue to appear, and also the 'make -C
tools/perf build-test' that was failiong on the first patch submission
is now ok as well, so I re issue my:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

At this point this will go thru Namhyung, that will process patches
while I'm in vacation for perf-tools-next as well, thanks!

- Arnaldo
 
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
