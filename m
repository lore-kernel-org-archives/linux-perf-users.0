Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513272;
	b=hPKwKLUutTSm1gkCnFx2vGl5KBNMF6scM43p4TODmvDmL7RKuJM7RS/4g8xFb/Vacl88
	 1qTUB/YkWbXvFOjF46J3OqrMeNVmWyYTXpqF2DdDUj1T63Wijg4ldoA/Tv9FPRPlJja+U
	 bryJeqYCuXoDmMa2Mw13/UJuJNNeCe/A9sEdwBsw5my4m4G54IdCM3Sp0DS4aLlWbdxr0
	 5AsauNx5y92brMXOhQCPyBbMjQRAuG7oVE7hQ1oTwV3x/MdycxRku2rSCJBdMnogc0yZ+
	 bkbGrtfNjzJGCkiwrlXuGvFd1eyzqIezUxtNL6ZNR8B5aBupkocbUV2cM5CHm1E+5jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513272;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Al7L2vmnROtiY16ywEPYKgUMAtlCRu8q02njAWz4C9c=;
	b=rITxaWeGoq5cmTiqo4qnXRJwcbGfLv5whUiFvxPNHs/WFd9oImsX5M5eWE9kal38e1As
	 VFJCC0ddtkiT6vAlvuQJlC8M4XVZ/GZXXW+E3TUovcpqLHcHkkosxq8TZw9xeKtTy8FtF
	 Zi8fJ/FSvgzcPID5gX3uQBoS7tnTYDaIGiBl8NAjou6Qg696YJPhysO0ZjkVJGzGgq9PS
	 zaO3tQS8WNVMZWCMD3cVtkyXBCR6jReZdqbsHMZh3uej+vYmlPi27/4d83emCbdJObFi5
	 zZVb4at1+rE+S7Z5E3B2ner/GrK/H7egIuXyk7RNnI4urRylObUfmOqhvYn79rl0Pkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERSRfY0v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D00606A321;
	Thu, 12 Nov 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERSRfY0v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3641F000C4;
	Thu, 12 Nov 2026 19:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513271;
	bh=Al7L2vmnROtiY16ywEPYKgUMAtlCRu8q02njAWz4C9c=;
	h=From:To:Cc:Subject:Date;
	b=ERSRfY0vgBH1Sz2MKyal27DMBAKQmbauejfEpZ77qVKrgfe5g4R9+6wrTB5jI6cWq
	 d2SGsp0cJ8+2ncDVizjQ135d0gu7aoJJUmZ1Bs6WEANn9xeyWDDKQ6m9B7Uy/+86yt
	 KHr6cV8mVtENA9bkNSCgpAa/8U41IO8yMKlhSg4HTeXMqEmbYdK9JmsNzmSEpfmSJO
	 XlDmCVzKX5izaoI5vD492UxOyMtX5t8qVb5u2nDvRXD+kT03s7DGG9W8m47LArntNV
	 koyqqlBllT4HTTOUnzb0BSZ0/XlGjuH2X5cm/7jMSlBred8HErmJLoHvPW5Sb6quSk
	 0QlAy4fkub9ZQ==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] kbuild: build the userspace tools in tools/ with the kernel
Date: Thu, 12 Nov 2026 14:54:20 -0500
Message-ID: <20261112195427.3411746-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The userspace programs under tools/ are disconnected from the rest of the
kernel's build system. Each has its own makefiles and build framework, and
"make" never builds them: apart from the few host tools the build itself needs,
such as objtool and resolve_btfids, nothing under tools/ is compiled as part of
a kernel build.

That makes them easy to break. Most people, and most of the build bots, check a
change with "make allmodconfig && make", which doesn't cover tools/ at all. A
change that breaks a tool passes every build check and is only noticed when
someone happens to build that tool by hand, often much later.

We keep seeing this in tools/testing/: selftests that stop building after a
change elsewhere in the tree, or after a backport to a stable tree, and stay
broken until someone tries to build them. Others brought up the same concern at
LPC.

This series lets the kernel build also build the tools it is configured for:

- tools/Kconfig adds a "Build userspace tools from tools/" menu
  (CONFIG_TOOLS_BUILD) with one entry per tool and per selftests
  directory, so .config records what gets built, and a tool that breaks
  can be turned off on its own.

- "make tools_build" builds the selected tools for the target, each with
  its own build system as it is built standalone, into tools-build/ in
  the object tree.

- With CONFIG_TOOLS_BUILD=y, "make all" builds them too. allmodconfig
  and allyesconfig enable every entry that applies to the target when
  the compiler can link glibc programs for it (currently x86_64 and
  arm64), so the usual build test catches tools breakage. Other
  toolchains are unaffected, as are "make vmlinux", "make modules" and
  external module builds.

This is useful beyond build testing: the tools are built for the same
target, from the same tree, as the kernel they go with.

The selftests need "selftests: lib.mk: define LINK.c, COMPILE.S and LINK.S
when make has none" [1], which is not in mainline yet. Without it, most of
them fail to build in tools_build.

I used LLM coding assistants to write and review these patches. I reviewed
and tested every change.

Changes in v4:
- 2/7: Check for glibc with the 64-bit flag that CC_CAN_LINK uses, so a
  compiler that defaults to 32-bit is not taken for one without glibc.
  Rebuild a tool when the compiler changes. The rebuild check only
  looks at files, not at directories.
- 4/7: perf can only be built without MINIMAL=1 when pkg-config, libelf
  and libtraceevent are found for the target, and never with
  COMPILE_TEST, so a randconfig build does not fail over a missing
  library.
- 5/7: Keep the vDSO selftest from running "make headers" in the kernel
  build a second time. Leave the headers the kernel build generates out
  of the rebuild check, which rebuilt the vDSO and x86 selftests on
  every build in the source tree. Rebuild the selftests when a makefile
  under tools/scripts or scripts/subarch.include changes.

Changes in v3:
- Rebase onto v7.4-rc1 and drop the RFC prefix.
- 3/7: The perf-tools-next changes are in mainline now, so MINIMAL=1 sets
  NO_PYTHON_MODULE instead of NO_LIBPYTHON and also sets NO_MYPY and
  NO_PYLINT. This is the version that was posted on its own [2]. Add the
  Acked-by tags from Namhyung and Arnaldo.
- 4/7: Add Namhyung's Acked-by.
- 5/7: Add Shuah's Reviewed-by. Add entries for the selftests new in v7.4
  that build with only a C library: filesystems/configfs,
  filesystems/file_stressor, filesystems/freeze and nfsd.

Changes in v2:
- 1/7: Add Thomas's Reviewed-by.
- 2/7: Put each "depends on" condition on its own line. Allow UML: the
  tools are built for the architecture UML runs on (HEADER_ARCH), as
  their build systems do not know ARCH=um. Drop the
  PYTHONDONTWRITEBYTECODE export, as 5479e1a13b75 ("perf tools: Put
  Python bytecode in output directory") in perf-tools-next keeps perf's
  bytecode in its output directory.
- 3/7: New. Add MINIMAL=1 to perf, which turns off every optional
  feature, as Ian suggested.
- 4/7: Build perf with MINIMAL=1 instead of a list of NO_* variables.
- 5/7: As with "make kselftest-all", a selftest that fails to build no
  longer fails the build unless FORCE_TARGETS is set, and
  kselftest_deps.sh lists the libraries it needs that the compiler
  cannot link with. Also rebuild the selftests when headers under
  tools/arch change, the vDSO test when kernel headers change, and the
  x86 tests when the x86 headers they include change.

v3: https://lore.kernel.org/r/20261102021253.2545235-1-sashal@kernel.org
v2: https://lore.kernel.org/r/20261016143143.3613501-1-sashal@kernel.org
v1: https://lore.kernel.org/r/20261011233647.2454648-1-sashal@kernel.org

[1] https://lore.kernel.org/r/20261011223358.2327625-6-sashal@kernel.org
[2] https://lore.kernel.org/r/20261018135321.3986899-1-sashal@kernel.org

Sasha Levin (7):
  kbuild: factor the userspace ABI flags out into KBUILD_USERABI
  kbuild: add "make tools_build" to build userspace tools from tools/
  perf build: Add MINIMAL=1 to build without optional features
  tools: build perf in tools_build
  tools: build kernel selftests in tools_build
  kbuild: build the tools selected in tools/Kconfig as part of "make
    all"
  Documentation: describe building tools with the kernel

 .gitignore                                 |   5 +
 Documentation/dev-tools/kselftest.rst      |   4 +
 Documentation/kbuild/kbuild.rst            |   4 +-
 Documentation/process/submit-checklist.rst |   5 +
 Makefile                                   |  24 +-
 lib/Kconfig.debug                          |   2 +
 tools/Kconfig                              | 350 +++++++++++++++++++++
 tools/Makefile.kbuild                      | 219 +++++++++++++
 tools/perf/Makefile.config                 |   8 +-
 tools/perf/Makefile.perf                   |  42 ++-
 tools/perf/tests/make                      |   8 +-
 11 files changed, 653 insertions(+), 18 deletions(-)
 create mode 100644 tools/Kconfig
 create mode 100644 tools/Makefile.kbuild


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
prerequisite-patch-id: 68eb8785244b88ec7e696e716420e2d9b1367dbc
prerequisite-patch-id: 37c57cf4c2a9700788cd1755912753f363cbb3f9
prerequisite-patch-id: 5243b7b03f2c12a6e66c353b0c083f7f21fd7ba2
prerequisite-patch-id: 7153a847ba7b05e49a670caba5d5b8fa2508eff1
prerequisite-patch-id: 67a995618952454c30eb77960a5bf6f897d22547
prerequisite-patch-id: bc69d99570e4326ce7736b244838e1e97cc13358
prerequisite-patch-id: 7a28872d234cdfa7bd5ec851e9dde01a65e91130
prerequisite-patch-id: a71f47de3fd339d680c9f18e80f5bcde7eae0abf
-- 
2.53.0

