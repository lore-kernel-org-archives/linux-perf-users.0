Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672003;
	b=yP6dPo2ypNI4+L0w8mcaXQSH2pXsx4tcfhvh14AkGJGEnOvDnRJGXDN3GKwpOTxU1n6L
	 Eh6gM8lIh8GcTyd3SC4D7t7GrkR+D16TsJxeHOEm+/jF2p2zgCu/dEU4dqubkoH/GtXgv
	 HgExUkky9lysvAV0vQ6nNiCv2bZp2WatjXUJQCBXkM+GH2+h7bX2uHEu+qW7/68BmLis0
	 kauzB8qpkRD56VYFw6rdsGupqFiwdoe+wXi1aHSJBLEEgJEwNR8tYz6D6vW1FuJ3hiBIc
	 yCh9EtbD79oixxxBVhnfSWyU6s7kR5y/3Z08a2DJ5r1FY7yzk3IqOH2VVvM4piEr9ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mWh086qMCDkQpMNwRFil3pzUNTpRkKGPpLFfZ+JQ6K8=;
	b=wV5Q1F6Nn7finp6FpJo7MVkmtJWOChwkf43IYyDWs3oJh3EEnHazGSSVhC6h2ie3YWEZ
	 G4ee6ReKCY1dNslB8QN/btgt8mCKR845ELdaNH/B3eq2W5IaZwacal4P4xnks0RjDVEWD
	 5/cO7rH80Fu39da+udgVaexg7zb/zx0WTc66NZR6VA6guJ6+wl1e4WrmXc5IdI8AHRBZ8
	 PS1rIRLvWZxbI2wuNrTIn49gH0nW9icUUBiUivaZkgHsfvwFZn4obAXMnqYeyWbc5nvwK
	 egvBSVyfcDQEHufZ440a6z0O71VU1fAcbiqbsMtuGhxmCRTGKXB5rlOQgeYCrAJXaiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5eACxTU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F0606A324;
	Tue,  3 Nov 2026 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5eACxTU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87011F00919;
	Tue,  3 Nov 2026 02:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672002;
	bh=mWh086qMCDkQpMNwRFil3pzUNTpRkKGPpLFfZ+JQ6K8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z5eACxTUltOwoyXlUrrM4Npqwi8JcT39uHUY4GdL3+XXS6m+9P5Wi832wpkoXMPEy
	 pqWbXrBay5cOWaaBrH87/JrdxCkmzLLbbPOPPiQvGZ+6jFzbkMuZvX81s5uzQkKWQo
	 XxjJAZTldn7rw8CWmkBuKxVGy1V50/+FHi7ghh9FHu2MR6d4IRss0pmWseWNMlEV4a
	 Mz0lVIwe793AFmt0ioukTYMePV8rVx5cOgWxLI+w06itYCqNAlvGpW/dehtbfavGdW
	 eYUYEvSOwONJaNeKqRfSyJJLRiOdvK43lRrvVg/YZbRJIB8X/eb3bOrnyNKYaJZAWi
	 j5jMXbSOtYp1A==
Message-ID: <sashiko-outbox-194450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] kbuild: add "make tools_build" to build
 userspace tools from tools/
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: "Shuah Khan" <shuah@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Andrew Morton" <akpm@linux-foundation.org>, "Thorsten
 Leemhuis" <linux@leemhuis.info>
In-Reply-To: <20261102021253.2545235-3-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
 <20261102021253.2545235-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:13:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] kbuild: USERLDFLAGS in LDFLAGS is ignored when building tools/dma
- [Low] kbuild: missing $(m64-flag) in CONFIG_TOOLS_BUILD_GLIBC preprocesso=
r probe
--

commit 73fb4c9163d06e31dd88981052867f3114563466
Author: Sasha Levin <sashal@kernel.org>

kbuild: add "make tools_build" to build userspace tools from tools/

This commit introduces a CONFIG_TOOLS_BUILD menu in tools/Kconfig and a
tools_build make target backed by tools/Makefile.kbuild to build selected
userspace tools for the target architecture into tools-build/.

> diff --git a/tools/Kconfig b/tools/Kconfig
> new file mode 100644
> index 0000000000000..2d05c8e593e21
> --- /dev/null
> +++ b/tools/Kconfig
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config TOOLS_BUILD_ABI
> +	def_bool X86_64 || ARM64
> +
> +config TOOLS_BUILD_GLIBC
> +	def_bool $(success,echo '#include <features.h>' | $(CC) $(CLANG_FLAGS) =
$(USERCFLAGS) -E -dM -x c - | grep -q __GLIBC__)

[Severity: Low]
Should this preprocessor probe also pass $(m64-flag)?

In scripts/Kconfig.toolchain, CC_CAN_LINK passes $(m64-flag) to
cc_can_link_user when 64BIT is enabled, and tools/Makefile.kbuild passes
$(KBUILD_USERABI) (which includes -m64 on x86_64) in tools-cc.

When configuring an x86_64 kernel with a biarch GCC toolchain that defaults
to 32-bit mode and only has 64-bit glibc development headers
(gnu/stubs-64.h) installed without 32-bit headers (gnu/stubs-32.h), running
$(CC) $(CLANG_FLAGS) $(USERCFLAGS) -E -dM -x c - without $(m64-flag)
preprocesses <features.h> in 32-bit mode. That fails with a fatal error on
the missing <gnu/stubs-32.h> before -dM outputs macro definitions, causing
TOOLS_BUILD_GLIBC to evaluate to n even though the compiler can build 64-bit
glibc programs for the target.

[ ... ]

> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
> new file mode 100644
> index 0000000000000..8cfa7f80039cd
> --- /dev/null
> +++ b/tools/Makefile.kbuild
> @@ -0,0 +1,85 @@
[ ... ]
> +# The compiler CONFIG_CC_CAN_LINK was tested with. The tools take linker
> +# flags from LDFLAGS.
> +tools-cc :=3D $(CC) $(USERCFLAGS) $(KBUILD_USERABI)
> +ifneq ($(USERLDFLAGS),)
> +override LDFLAGS :=3D $(USERLDFLAGS)
> +export LDFLAGS
> +endif

[Severity: Low]
Will USERLDFLAGS reach tools/dma when building with CONFIG_TOOLS_BUILD_DMA=
=3Dy?

Here USERLDFLAGS is only passed through the exported LDFLAGS variable and is
not included in tools-cc. However, tools/dma/Makefile compiles and links
dma_map_benchmark in a single rule without referencing $(LDFLAGS):

tools/dma/Makefile:
$(OUTPUT)$(DMA_MAP_BENCHMARK): prepare FORCE
	$(CC) $(CFLAGS) $(DMA_MAP_BENCHMARK).c -o $@

When a user specifies linker flags in USERLDFLAGS (such as --sysroot, -L,
-fuse-ld, or -static) that scripts/cc-can-link.sh validated for
CONFIG_CC_CAN_LINK, building tools/dma via make tools_build will drop those
flags and can fail to link or produce an improperly linked binary.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102021253.2545=
235-1-sashal@kernel.org?part=3D2
