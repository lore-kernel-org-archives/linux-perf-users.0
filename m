Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08E55821F;
	Thu, 15 Oct 2026 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090364; cv=none; b=maG2sLVnpgr2cXe4qNRgV2oNrkZLX65d82NDqQKEDMYZM1XUN03y5qbytfP/Yq3XOJnK0rP5cgM84nttSQ3zpOaH/VJAcBa0J/v0VL6c2J12h57MIMgSDH9jEaotGgk9phCVAg0vydZCY1fhH1PqSWtcZzFf3PhIaBjJ+ImkrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090364; c=relaxed/simple;
	bh=LgJdMkuY3CxbGVuvdie+11He70UGUab1eNFyeH50fm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoIZig0c/46iw4rB/trP6mB6vuegX7lHqk0ykPsrzeR15CUdZwrdzsX19sWE81149DBcmFlXkdaB3u2g9HpKLmjgNA8Spl/oR/8z7d1LaQmkH78cw/GAZnHYwh01cVfzHZEt0ScdF7RyOvX7QviXSUZVbjKHgm92PdKVuyTc5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1AuxVCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1AuxVCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890EE1F000C4;
	Thu, 15 Oct 2026 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792090361;
	bh=Njl37LUDsIFdauFRHaWsmyFWughBb0HjtnFZLbKLBCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P1AuxVCDtDzaGD11WMuGAROblSXSvHwJzTIeUkyME2nRdttFU8BqQK4gd06lSoVgJ
	 BSKir+YvMkcP3sUCmVFoWK002WP6TaGDJjYScyXJsogEjlK1GF9FbftB7jwkb+g94x
	 J3z2GIUt3tmQNhqR8zPJBxBvlgfcxC0riohLZzywTgqR+8yKIiEOdaeb2v8XX3xulz
	 FmD0I06pVbbShRA0qaHLoHPHaG8s80Rn4P0+g4cku4CehU1ehH0s0iwJ6gPGZOPlW8
	 sDg0/o3II8mhfzE6WDm7efCnGeXGcpIGILczqkcB1PIVo96O9fzicYw5GsjyIikCeQ
	 kVqqAYCLnDTgg==
Date: Thu, 15 Oct 2026 14:52:40 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/6] kbuild: add "make tools_build" to build
 userspace tools from tools/
Message-ID: <atEg-E51MHBHL8Ju@laps>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-3-sashal@kernel.org>
 <b0fa30a6-9f41-4c9a-a3fb-2634322e2bd1@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0fa30a6-9f41-4c9a-a3fb-2634322e2bd1@t-8ch.de>

On Tue, Oct 13, 2026 at 10:38:37PM +0200, Thomas Weißschuh wrote:
>On 2026-10-11 19:36:41-0400, Sasha Levin wrote:
>(...)
>
>> Assisted-by: LLM
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  .gitignore            |  5 +++
>>  Makefile              |  8 ++++-
>>  lib/Kconfig.debug     |  2 ++
>>  tools/Kconfig         | 72 +++++++++++++++++++++++++++++++++++++++
>>  tools/Makefile.kbuild | 79 +++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 165 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/Kconfig
>>  create mode 100644 tools/Makefile.kbuild
>
>(...)
>
>> diff --git a/tools/Kconfig b/tools/Kconfig
>> new file mode 100644
>> index 0000000000000..bf0643b39b86e
>> --- /dev/null
>> +++ b/tools/Kconfig
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config TOOLS_BUILD_ABI
>> +	def_bool X86_64 || ARM64
>> +
>> +config TOOLS_BUILD_GLIBC
>> +	def_bool $(success,echo '#include <features.h>' | $(CC) $(CLANG_FLAGS) $(USERCFLAGS) -E -dM -x c - | grep -q __GLIBC__)
>> +
>> +menuconfig TOOLS_BUILD
>> +	bool "Build userspace tools from tools/"
>> +	depends on CC_CAN_LINK && !UML
>
>Why !UML?

Building with ARCH=um was reaching the tools, which then set "-I
tools/arch/um/include" but that dir doesn't exist.

I worked around this for the RFC, but I think I can address it when I resent
the patches.

>> +	depends on TOOLS_BUILD_ABI && TOOLS_BUILD_GLIBC
>
>These dependencies could be on separate lines, it will reduce churn when
>they get modified.

ack

>> +	help
>> +	  Build the selected programs under tools/ for the target together
>> +	  with the kernel, as part of "make all", or alone with
>> +	  "make tools_build". Each program is built by its own build system
>> +	  into tools-build/ in the object tree. The tools then always match
>> +	  the kernel they were built with, and a change that breaks one of
>> +	  them shows up in the same build that compiles the kernel.
>> +
>> +	  This needs a compiler that can link glibc programs for the target,
>> +	  and is currently limited to x86_64 and arm64.
>> +
>> +	  If unsure, say N.
>
>(...)
>
>> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
>> new file mode 100644
>> index 0000000000000..820a2d9a3893b
>> --- /dev/null
>> +++ b/tools/Makefile.kbuild
>> @@ -0,0 +1,79 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Builds the userspace programs selected in tools/Kconfig for the target.
>> +# Invoked by "make tools_build", which "make all" runs when CONFIG_TOOLS_BUILD
>> +# is set. Each program is built by its own build system, the way it is built
>> +# standalone, into $(objtree)/tools-build/.
>> +
>> +PHONY := __tools_build
>> +__tools_build:
>> +
>> +include include/config/auto.conf
>> +
>> +abs_srctree := $(realpath $(srctree))
>> +toolsdir := $(abs_srctree)/tools
>> +outdir := $(CURDIR)/tools-build
>> +
>> +# kbuild's state and the user's compiler flags, from the environment or the
>> +# command line, would change how these build
>> +unexport srctree objtree srcroot VPATH building_out_of_srctree sub_make_done
>> +unexport CLANG_FLAGS INSTALL_HDR_PATH O
>> +unexport CFLAGS CPPFLAGS LDFLAGS EXTRA_CFLAGS EXTRA_LDFLAGS USERCFLAGS USERLDFLAGS
>> +space := $(subst ,, )
>> +overrides := $(subst \$(space),\@space@,$(MAKEOVERRIDES))
>> +MAKEOVERRIDES := $(subst \@space@,\$(space),$(filter-out O=% CFLAGS=% CPPFLAGS=% \
>> +	LDFLAGS=% EXTRA_CFLAGS=% EXTRA_LDFLAGS=% USERCFLAGS=% USERLDFLAGS=%,$(overrides)))
>> +
>> +# Keep Python's bytecode caches out of the source tree
>> +export PYTHONDONTWRITEBYTECODE := 1
>
>This should just be done in the toplevel Makefile IMO.

I originally added this because perf was silly, but apparently that was a bug
instead of intended behavior, which was fixed in 5479e1a13b759 ("perf tools:
Put Python bytecode in output directory"), so I think I can just drop this
altogether.

-- 
Thanks,
Sasha
