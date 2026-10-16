Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A94E80B6;
	Fri, 16 Oct 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161107; cv=none; b=ZWULJmxks39VEtwNdqbw2fae10DoxV0amRhPe9nWBjQ6Tm2eqMuE7VIcr/1X5LOX142yq3tTFl1BEeycieddmnO7UHJV5NM7VC2GVmVHQSjdrRKNqM9DbwW7yezA+TiD2loM6M1nyKMY4nrUlJgZ/bRW8LGXSrb6m6joqlOkDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161107; c=relaxed/simple;
	bh=ZVdy5Cz3DjKZ34TIfzoW/satpORc0d8M1TxE2FIIDSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZB+Ry5ETvz8p5EuLlBVR6n1mJch1Yxe2TsX9KZOT6SU3zuTU/YAOTx15/LU81OeaazY9VKoLyy28k7kNhciGWqd5u6pT3cIaxkJegbI4C7Y+OK/g08JSCw9KJKLmF6mZkVQkYB+bSIi1oKs9EGs2pe1cTRU30sE+ooIN9pss7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIkbO2Qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIkbO2Qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4791F000C4;
	Fri, 16 Oct 2026 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161106;
	bh=lc2UzAwqjINRM2lPF6747JxhVVG9TcyYOOdH7tVVz6w=;
	h=From:To:Cc:Subject:Date;
	b=BIkbO2Qg2MC+Lxzk1xNjZG/ed0DaLOC2F1L38e9adOEvabpZJ/oN8ak9/CRegszsT
	 8JE5mQM9K6FNP05TsE82YB+gyFcU2nnrRGVgFAGscXF0XBwON2bOCKshTgzksrpIVJ
	 SRi8xkub1oM8XfOyYVRbmJy1Of6kol3GrbUxW3bweKyYbZPpbfweRKaaY9bOoSRgzO
	 JV5N3TMW92K59qERkFT3UtmhEZas7OLDF4C9D+xJZnRsOgRVPB222GtbrKOhx5wzHu
	 +nH6VPlrgCWPoDbM+OopMdmNEnXNQh45dCSjqSG2fL6Vf6TUHf/oHcGfUPO+/UbmkA
	 OOqbxpNB/5jIw==
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/7] kbuild: build the userspace tools in tools/ with the kernel
Date: Fri, 16 Oct 2026 10:31:36 -0400
Message-ID: <20261016143143.3613501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
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

3/7 is against mainline. perf-tools-next renamed NO_LIBPYTHON to
NO_PYTHON_MODULE and runs mypy and pylint by default, so there it also
needs NO_PYTHON_MODULE, NO_MYPY and NO_PYLINT.

v1: https://lore.kernel.org/r/20261011233647.2454648-1-sashal@kernel.org

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
 tools/Kconfig                              | 330 +++++++++++++++++++++
 tools/Makefile.kbuild                      | 205 +++++++++++++
 tools/perf/Makefile.config                 |   8 +-
 tools/perf/Makefile.perf                   |  40 ++-
 tools/perf/tests/make                      |   8 +-
 11 files changed, 617 insertions(+), 18 deletions(-)
 create mode 100644 tools/Kconfig
 create mode 100644 tools/Makefile.kbuild


base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
prerequisite-patch-id: 68eb8785244b88ec7e696e716420e2d9b1367dbc
prerequisite-patch-id: 37c57cf4c2a9700788cd1755912753f363cbb3f9
prerequisite-patch-id: 7772557d5d842a42f1bbb3ee18d41f337db9783a
prerequisite-patch-id: 75abf8d47ec8093740c215e9eebe7bbb5846ddd6
prerequisite-patch-id: de33c5273a0f7619a54dc6d1fd9c47383b7dd60e
prerequisite-patch-id: 5243b7b03f2c12a6e66c353b0c083f7f21fd7ba2
prerequisite-patch-id: 7153a847ba7b05e49a670caba5d5b8fa2508eff1
prerequisite-patch-id: 67a995618952454c30eb77960a5bf6f897d22547
prerequisite-patch-id: f0580be789bfbd90c903bfef8cf6099609e63347
prerequisite-patch-id: 975b27a83085ae7532771fbd7bb17b779ea2c254
prerequisite-patch-id: 1eee5ec66bc4c1ff3ba9f57e005484ed514c77a1
prerequisite-patch-id: 333bf51a132f726bf970b5963017bdc607c0e315
prerequisite-patch-id: 7853ec5197ec9b9322a102a6b02dd62bba4df102
prerequisite-patch-id: bc69d99570e4326ce7736b244838e1e97cc13358
prerequisite-patch-id: 7a28872d234cdfa7bd5ec851e9dde01a65e91130
prerequisite-patch-id: f75a478f103e8707f7ce1ebb136e3a605f026cae
prerequisite-patch-id: c6aacf3772c239df0224afb7e4bb661fb9b81c63
prerequisite-patch-id: a71f47de3fd339d680c9f18e80f5bcde7eae0abf
-- 
2.53.0

