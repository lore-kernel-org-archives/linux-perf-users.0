Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86623817E;
	Sun, 11 Oct 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761810; cv=none; b=sWpef3LyEO9EYskVsBZFu8xv1TBdPGaosWaj3YMQRKyR8P0RY6TClzLR0bNOp+4LbJwQCL48l4Enf5odEqxGiqSYdu1a0cf7o6N9A/EbCaxXepH2t6YB11+wOmba5Huldj9vjvJ78nt22/jC2l+xO7IEap6iE0O560ZUg7tcE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761810; c=relaxed/simple;
	bh=27GIcmxdEnb0vepu7ukk7BD5+WBojxM6q3nRXJtR9yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nI3cWzAG2QL68GkNCVw726zs767tO5sgK9frQlMRqHpUIr3yD5il7RPzB+V50Pn37NP8OJIaRGcSy32BVNa5XZ4kJ6euG5laLwo6LGrHtk7oNV/pX/FXcHtrCFrvV9aTOIU6uqjzS8p/Vkc0h9ucCdTRp4tarBXD0zl1Dr6OdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDMvyo0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDMvyo0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABAA1F0089B;
	Sun, 11 Oct 2026 23:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761809;
	bh=GTQoJF77ZZyL5Isged6CeeOoQpGQXCdc3xg6ntjU7wo=;
	h=From:To:Cc:Subject:Date;
	b=VDMvyo0YaXtdQSGmIeqc0LtNswo+NKROnDg8cZEv+aH07QJHTZ5o/jzmotezb6tM/
	 XJ3xfe+PR9U5CX/pPIIXS/OhvSXtqwNjEoWiGnSuSxe2qttzt+TWEgmEk3QFSPf2ux
	 eKrR+/+klyfrMhFpsfNGSHXS+FbG/pMg9utYTYVgJu32hap9qHUVz0pBfHT7f+e0GH
	 2Sz0kiOU8FCaIjtfmSCqtGu5/dW3NmlYuZVFadGKA35tYf0UxbXJK7Ld4DB0pscv+Q
	 uoHJ3yTpzczHexlo9pkfL2J2jsgIS4HsJ+E0KK1upf5v3eTDliQTgskicQWpur+mqr
	 mGXmJKlEwwjiQ==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 0/6] kbuild: build the userspace tools in tools/ with the kernel
Date: Sun, 11 Oct 2026 19:36:39 -0400
Message-ID: <20261011233647.2454648-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
  and allyesconfig enable every entry when the compiler can link
  userspace programs, so the usual build test catches tools breakage.
  Toolchains without a C library are unaffected, as are "make vmlinux",
  "make modules" and external module builds.

This is useful beyond build testing: the tools are built for the same
target, from the same tree, as the kernel they go with.

Sasha Levin (6):
  kbuild: factor the userspace ABI flags out into KBUILD_USERABI
  kbuild: add "make tools_build" to build userspace tools from tools/
  tools: build perf in tools_build
  tools: build kernel selftests in tools_build
  kbuild: build the tools selected in tools/Kconfig as part of "make
    all"
  Documentation: describe building tools with the kernel

 .gitignore                                 |   5 +
 Documentation/dev-tools/kselftest.rst      |   4 +
 Documentation/kbuild/kbuild.rst            |   5 +-
 Documentation/process/submit-checklist.rst |   5 +
 Makefile                                   |  24 +-
 lib/Kconfig.debug                          |   2 +
 tools/Kconfig                              | 326 +++++++++++++++++++++
 tools/Makefile.kbuild                      | 198 +++++++++++++
 8 files changed, 562 insertions(+), 7 deletions(-)
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
prerequisite-patch-id: fa973600f98f37417659bbe282f76d7cbdfd84ff
prerequisite-patch-id: 333bf51a132f726bf970b5963017bdc607c0e315
prerequisite-patch-id: 7853ec5197ec9b9322a102a6b02dd62bba4df102
prerequisite-patch-id: 70780a52552f78b640178774bce254616b06f831
prerequisite-patch-id: 7a28872d234cdfa7bd5ec851e9dde01a65e91130
prerequisite-patch-id: f75a478f103e8707f7ce1ebb136e3a605f026cae
prerequisite-patch-id: c6aacf3772c239df0224afb7e4bb661fb9b81c63
prerequisite-patch-id: a71f47de3fd339d680c9f18e80f5bcde7eae0abf
-- 
2.53.0

