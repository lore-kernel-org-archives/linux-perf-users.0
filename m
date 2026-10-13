Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3654EEBD;
	Tue, 13 Oct 2026 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923925; cv=none; b=SyXIYgM9W1ul3ccrJ48vj/i+MFCpY3yaBVHPd35gGs7k0czMmSNpj9h4quikfHAr6/iqvfx5ZHQ5fXe2WWzGskLoVrCETTTr0VQ+fi9EWXNHj+vHKx7TghIC9fdZZp8581+LPd02A7toz11xHZdhil8PsDVw0BhHFfjPi9EuN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923925; c=relaxed/simple;
	bh=t+rv9DZjlHa1AnpVnE5Lh7gvgLdHD5mWAXOsSnLe2jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szemTQTBIh19XclaWTHT7Hrgsh8kru0OoIORS2Ks2RxgZ28yNijwzU71iBi3tLWqQab/QzdBRL66k3/JIeCbl0RHLK4qCyq8L8bnY8u3q1ogYf8+kwhUIcaFR7QnriXacoeJ/HK+l4WOc+39vtMDeujVFqTSSnbm3suJZdy1QXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=Xp7PgWmv; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="Xp7PgWmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1791923918; bh=t+rv9DZjlHa1AnpVnE5Lh7gvgLdHD5mWAXOsSnLe2jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xp7PgWmvcUnUxiRG7k4cmWjIb/dtqkaf+8bccLc4jw8XeSC7i2CkINMmDYWaP3NwO
	 IVK4Ibxeg/KAKky6w6RCNILKdFDEQgrxZofozyqB5qitTsCNh9XeZ56ODEr3Np6AVQ
	 OdAtM/flgKnVOiy221T9w8WAjRz37YLOa4c1EPDg=
Date: Tue, 13 Oct 2026 22:38:37 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/6] kbuild: add "make tools_build" to build
 userspace tools from tools/
Message-ID: <b0fa30a6-9f41-4c9a-a3fb-2634322e2bd1@t-8ch.de>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011233647.2454648-3-sashal@kernel.org>

On 2026-10-11 19:36:41-0400, Sasha Levin wrote:
(...)

> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .gitignore            |  5 +++
>  Makefile              |  8 ++++-
>  lib/Kconfig.debug     |  2 ++
>  tools/Kconfig         | 72 +++++++++++++++++++++++++++++++++++++++
>  tools/Makefile.kbuild | 79 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 165 insertions(+), 1 deletion(-)
>  create mode 100644 tools/Kconfig
>  create mode 100644 tools/Makefile.kbuild

(...)

> diff --git a/tools/Kconfig b/tools/Kconfig
> new file mode 100644
> index 0000000000000..bf0643b39b86e
> --- /dev/null
> +++ b/tools/Kconfig
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config TOOLS_BUILD_ABI
> +	def_bool X86_64 || ARM64
> +
> +config TOOLS_BUILD_GLIBC
> +	def_bool $(success,echo '#include <features.h>' | $(CC) $(CLANG_FLAGS) $(USERCFLAGS) -E -dM -x c - | grep -q __GLIBC__)
> +
> +menuconfig TOOLS_BUILD
> +	bool "Build userspace tools from tools/"
> +	depends on CC_CAN_LINK && !UML

Why !UML?

> +	depends on TOOLS_BUILD_ABI && TOOLS_BUILD_GLIBC

These dependencies could be on separate lines, it will reduce churn when
they get modified.

> +	help
> +	  Build the selected programs under tools/ for the target together
> +	  with the kernel, as part of "make all", or alone with
> +	  "make tools_build". Each program is built by its own build system
> +	  into tools-build/ in the object tree. The tools then always match
> +	  the kernel they were built with, and a change that breaks one of
> +	  them shows up in the same build that compiles the kernel.
> +
> +	  This needs a compiler that can link glibc programs for the target,
> +	  and is currently limited to x86_64 and arm64.
> +
> +	  If unsure, say N.

(...)

> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
> new file mode 100644
> index 0000000000000..820a2d9a3893b
> --- /dev/null
> +++ b/tools/Makefile.kbuild
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Builds the userspace programs selected in tools/Kconfig for the target.
> +# Invoked by "make tools_build", which "make all" runs when CONFIG_TOOLS_BUILD
> +# is set. Each program is built by its own build system, the way it is built
> +# standalone, into $(objtree)/tools-build/.
> +
> +PHONY := __tools_build
> +__tools_build:
> +
> +include include/config/auto.conf
> +
> +abs_srctree := $(realpath $(srctree))
> +toolsdir := $(abs_srctree)/tools
> +outdir := $(CURDIR)/tools-build
> +
> +# kbuild's state and the user's compiler flags, from the environment or the
> +# command line, would change how these build
> +unexport srctree objtree srcroot VPATH building_out_of_srctree sub_make_done
> +unexport CLANG_FLAGS INSTALL_HDR_PATH O
> +unexport CFLAGS CPPFLAGS LDFLAGS EXTRA_CFLAGS EXTRA_LDFLAGS USERCFLAGS USERLDFLAGS
> +space := $(subst ,, )
> +overrides := $(subst \$(space),\@space@,$(MAKEOVERRIDES))
> +MAKEOVERRIDES := $(subst \@space@,\$(space),$(filter-out O=% CFLAGS=% CPPFLAGS=% \
> +	LDFLAGS=% EXTRA_CFLAGS=% EXTRA_LDFLAGS=% USERCFLAGS=% USERLDFLAGS=%,$(overrides)))
> +
> +# Keep Python's bytecode caches out of the source tree
> +export PYTHONDONTWRITEBYTECODE := 1

This should just be done in the toplevel Makefile IMO.

> +# The compiler CONFIG_CC_CAN_LINK was tested with. The tools take linker
> +# flags from LDFLAGS.
> +tools-cc := $(CC) $(USERCFLAGS) $(KBUILD_USERABI)
> +ifneq ($(USERLDFLAGS),)
> +override LDFLAGS := $(USERLDFLAGS)
> +export LDFLAGS
> +endif

(...)
