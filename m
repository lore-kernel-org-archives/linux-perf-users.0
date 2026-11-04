Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823058;
	b=D4JcqHSzlgVld2qwiUf/dkEmcmjhKYY1kL1gyfhzGLrqEkA2vrySUGz+lBwmr7qjh/R6
	 sc4Nw3O3Knspyi3nDHS0ZpoWnWlsuSO6B168uQa7sNEshN0YuWmlAJXwFwQCTvl9FSqko
	 F7dxui96RGioTiiQRmB70AgyJ88PqGGqLtduFzxFvg/q2P8RCu2j5VV+12J9ftSO0hGwT
	 PSJXZQER9b/0+QFCfC/NFwxsuUfqTRmQAN+byCsene6Y19XUwQciwzohU4zEVNiApg6PK
	 9TYxKsehAZURmQG76PVON8k2V0j2A9/TkwXE2JHVGcIZ5fv3CBahIwNESlEg1hVbUhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cZ6yFI7uUXsNpfZcP6QwBP/s11ZaCftZOiY0AOuJYFY=;
	b=JsMhWVsXMMvv/kMkIIIcR6Ura/sLz8ZUHCa/giPSV+NGpuFX5Ia1UtFx/52rtXFq56vt
	 Z8pZzVbns4rQxDReP2odg0NTF7m/7wj1zvzd1pBlKi+WkObN5IkNmlt3Lrz3DsKl/IXEv
	 y6Skn3c2XlxdCIK8muLudO/54dBApKf2liQxHRMFDAOlkRZFerHqi9Tmpgx6eFt9nOrj8
	 YldmIdb6rR5BCgWvmJpyLy/4tSP2KIq7YkGVET5Sto8IsUBZClMZi23IS9mq5GWjltyfM
	 DcJchyoA+GdGOIM4rQl36bKN43BuBd0ZkSCv4P9ZoK7qWZxP8wmVQa/Amft+A4swvUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6CfLZuA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589D6070F3B;
	Wed,  4 Nov 2026 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6CfLZuA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB371F000C1;
	Wed,  4 Nov 2026 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823058;
	bh=cZ6yFI7uUXsNpfZcP6QwBP/s11ZaCftZOiY0AOuJYFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n6CfLZuAume0uCWHjBTy8MGLChXDsG2YSrXEf3W3ANF0TYe0v4ydfu4iDhKsx1VWQ
	 EiBceW5hAsWsQ+MJN4mITvSpMkFEmcVNEmUvbNHXnGSQt8srZJ861FH1LrzAS/4fv4
	 4tnk5jnYX7977eLJ5k3FT7l7ZMawroT/TvRGIYf1LT9GS8eayXQx+Zu8kQYrh/49TO
	 PIgWy9WesJxttg1upq0t75ZceWVS5AK2qYbQdtOKQ+zy5DmqMUsApu1sxRAlOvCacv
	 vZYb1OqqfdPXcMWWWXhRU8eR+Rp3JTkdHxe/rCMek9fW0wPafZ3ppHeOFqICDoAAhi
	 jKnblf+ZyyN3A==
Date: Wed, 4 Nov 2026 17:10:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kbuild: build the userspace tools in tools/ with
 the kernel
Message-ID: <auuRTxKE-I8Tyji-@phoenix2>
References: <20261102021253.2545235-1-sashal@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102021253.2545235-1-sashal@kernel.org>

On Sun, Nov 01, 2026 at 09:12:46PM -0500, Sasha Levin wrote:
> The userspace programs under tools/ are disconnected from the rest of the
> kernel's build system. Each has its own makefiles and build framework, and
> "make" never builds them: apart from the few host tools the build itself needs,
> such as objtool and resolve_btfids, nothing under tools/ is compiled as part of
> a kernel build.
 
> That makes them easy to break. Most people, and most of the build bots, check a
> change with "make allmodconfig && make", which doesn't cover tools/ at all. A

Well, by definition nothing that changes in the kernel should break at
least tools/perf, see:

tools/include/uapi/README

"
Why we want a copy of kernel headers in tools?
==============================================

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.
"

So tools shouldn't be using anything outside tools and people updating
tools/ living shared headers should test the other subsystems that use
it.

Recently I added:

⬢ [acme@toolbx perf-tools-next]$ make -C tools/perf help | grep headers
  check-headers         - check which header copies are out of sync with the kernel
  sync-headers          - sync those header copies with the kernel, creating commits
⬢ [acme@toolbx perf-tools-next]$

That calls:

acme@phoenix2:~/git/perf-tools-next$ tools/perf/scripts/sync-headers.sh --help
Usage: sync-headers.sh [OPTIONS]

Sync tools/ header copies with the kernel sources and create commits.
<SNIP>
The script:
  1. Runs 'make -C tools/perf check-headers' to find stale copies.
  2. For each stale header, identifies the kernel commits that changed it,
     including the merges that brought content of their own.
  3. Copies the kernel header into the tools/ tree, skipping it when only
     the tools/ copy changed (it is ahead) or when it carries intentional
     edits, and stopping for manual investigation when both sides have
     content the other lacks.
  4. For beauty headers, runs the relevant beauty script(s) before and
     after, showing new/changed string table entries.
  5. Builds perf and the other consumers of the header to verify nothing
     breaks.
  6. Creates a git commit per header (or group) with the standard commit
     message format.

     -----

See point #5.

Having more people testing that perf continues to build if the existing
rules described above is only good and I thank you for the work you are
doing, I just wanted to clarify how tools/perf/ has been working with
this over the years and the recent extra scripting around the updates
that we do while maintaining tools/perf.

- Arnaldo

> change that breaks a tool passes every build check and is only noticed when
> someone happens to build that tool by hand, often much later.
> 
> We keep seeing this in tools/testing/: selftests that stop building after a
> change elsewhere in the tree, or after a backport to a stable tree, and stay
> broken until someone tries to build them. Others brought up the same concern at
> LPC.
> 
> This series lets the kernel build also build the tools it is configured for:
> 
> - tools/Kconfig adds a "Build userspace tools from tools/" menu
>   (CONFIG_TOOLS_BUILD) with one entry per tool and per selftests
>   directory, so .config records what gets built, and a tool that breaks
>   can be turned off on its own.
> 
> - "make tools_build" builds the selected tools for the target, each with
>   its own build system as it is built standalone, into tools-build/ in
>   the object tree.
> 
> - With CONFIG_TOOLS_BUILD=y, "make all" builds them too. allmodconfig
>   and allyesconfig enable every entry that applies to the target when
>   the compiler can link glibc programs for it (currently x86_64 and
>   arm64), so the usual build test catches tools breakage. Other
>   toolchains are unaffected, as are "make vmlinux", "make modules" and
>   external module builds.
> 
> This is useful beyond build testing: the tools are built for the same
> target, from the same tree, as the kernel they go with.
> 
> The selftests need "selftests: lib.mk: define LINK.c, COMPILE.S and LINK.S
> when make has none" [1], which is not in mainline yet. Without it, most of
> them fail to build in tools_build.
> 
> I used LLM coding assistants to write and review these patches. I reviewed
> and tested every change.
> 
> Changes in v3:
> - Rebase onto v7.4-rc1 and drop the RFC prefix.
> - 3/7: The perf-tools-next changes are in mainline now, so MINIMAL=1 sets
>   NO_PYTHON_MODULE instead of NO_LIBPYTHON and also sets NO_MYPY and
>   NO_PYLINT. This is the version that was posted on its own [2]. Add the
>   Acked-by tags from Namhyung and Arnaldo.
> - 4/7: Add Namhyung's Acked-by.
> - 5/7: Add Shuah's Reviewed-by. Add entries for the selftests new in v7.4
>   that build with only a C library: filesystems/configfs,
>   filesystems/file_stressor, filesystems/freeze and nfsd.
> 
> Changes in v2:
> - 1/7: Add Thomas's Reviewed-by.
> - 2/7: Put each "depends on" condition on its own line. Allow UML: the
>   tools are built for the architecture UML runs on (HEADER_ARCH), as
>   their build systems do not know ARCH=um. Drop the
>   PYTHONDONTWRITEBYTECODE export, as 5479e1a13b75 ("perf tools: Put
>   Python bytecode in output directory") in perf-tools-next keeps perf's
>   bytecode in its output directory.
> - 3/7: New. Add MINIMAL=1 to perf, which turns off every optional
>   feature, as Ian suggested.
> - 4/7: Build perf with MINIMAL=1 instead of a list of NO_* variables.
> - 5/7: As with "make kselftest-all", a selftest that fails to build no
>   longer fails the build unless FORCE_TARGETS is set, and
>   kselftest_deps.sh lists the libraries it needs that the compiler
>   cannot link with. Also rebuild the selftests when headers under
>   tools/arch change, the vDSO test when kernel headers change, and the
>   x86 tests when the x86 headers they include change.
> 
> v2: https://lore.kernel.org/r/20261016143143.3613501-1-sashal@kernel.org
> v1: https://lore.kernel.org/r/20261011233647.2454648-1-sashal@kernel.org
> 
> [1] https://lore.kernel.org/r/20261011223358.2327625-6-sashal@kernel.org
> [2] https://lore.kernel.org/r/20261018135321.3986899-1-sashal@kernel.org
> 
> Sasha Levin (7):
>   kbuild: factor the userspace ABI flags out into KBUILD_USERABI
>   kbuild: add "make tools_build" to build userspace tools from tools/
>   perf build: Add MINIMAL=1 to build without optional features
>   tools: build perf in tools_build
>   tools: build kernel selftests in tools_build
>   kbuild: build the tools selected in tools/Kconfig as part of "make
>     all"
>   Documentation: describe building tools with the kernel
> 
>  .gitignore                                 |   5 +
>  Documentation/dev-tools/kselftest.rst      |   4 +
>  Documentation/kbuild/kbuild.rst            |   4 +-
>  Documentation/process/submit-checklist.rst |   5 +
>  Makefile                                   |  24 +-
>  lib/Kconfig.debug                          |   2 +
>  tools/Kconfig                              | 342 +++++++++++++++++++++
>  tools/Makefile.kbuild                      | 209 +++++++++++++
>  tools/perf/Makefile.config                 |   8 +-
>  tools/perf/Makefile.perf                   |  42 ++-
>  tools/perf/tests/make                      |   8 +-
>  11 files changed, 635 insertions(+), 18 deletions(-)
>  create mode 100644 tools/Kconfig
>  create mode 100644 tools/Makefile.kbuild
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> prerequisite-patch-id: 68eb8785244b88ec7e696e716420e2d9b1367dbc
> prerequisite-patch-id: 37c57cf4c2a9700788cd1755912753f363cbb3f9
> prerequisite-patch-id: 5243b7b03f2c12a6e66c353b0c083f7f21fd7ba2
> prerequisite-patch-id: 7153a847ba7b05e49a670caba5d5b8fa2508eff1
> prerequisite-patch-id: 67a995618952454c30eb77960a5bf6f897d22547
> prerequisite-patch-id: bc69d99570e4326ce7736b244838e1e97cc13358
> prerequisite-patch-id: 7a28872d234cdfa7bd5ec851e9dde01a65e91130
> prerequisite-patch-id: a71f47de3fd339d680c9f18e80f5bcde7eae0abf
> -- 
> 2.53.0
