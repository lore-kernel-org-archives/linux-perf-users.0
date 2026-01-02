Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC03A1E6C;
	Fri,  2 Jan 2026 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767391278; cv=none; b=ti6OcxrrA3BngVWWRTYuT4AiAalWkywz0y16S19YqiUkY+ecFGYpbdxf7pGB1z9iWpvTg7jK5mdwsw7yioIOI8RHe9ZJe3jMyMyfaoqklB+e8HB9wX5+6p7LD5S5w8HxNk59W6USWEGjEOdTehZzSUI+l+pd4e+TbJYrfc2AWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767391278; c=relaxed/simple;
	bh=Uh/LMNjKmrWpYkziSkPE4JlCUjQu+3ILa4yLZ8PgglE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QK5hCbG4zy2bOuQqunhjvV6w03/9Q+Lmfab9eEpG8nP4MJaOLXeaotBHmvIQ14KkCrNV2BxKEQAHmyYnKz7zRQdej+ZodOb67qSoKTaOpZ7Xrl4zeFGq3Uwv/5LlF6YoQQiW7y0Q32k6eaCpgwwl9b+3adoDJ4mRqe9kao94AQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgjCXSli; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgjCXSli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4ADC116B1;
	Fri,  2 Jan 2026 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767391277;
	bh=Uh/LMNjKmrWpYkziSkPE4JlCUjQu+3ILa4yLZ8PgglE=;
	h=From:To:Cc:Subject:Date:From;
	b=QgjCXSliIko/l6kJjLkCIvT3tROqc6SVr0PWVK4hlNhiQyC8GwSQflz1k46FwrYCm
	 dGlGQnlSXAhrl3dXUX7FTiIKYuaVPiN9gdYugF+DW4luX2LvgUygeb5bQ2o8j0jd4F
	 09e1uL5iLKlMRE+hhcc0oEQK/BfYwcO80BjnyuAGi0TVgXcfOO9WOSDVQBypIJ11If
	 fRmth0Gr4mWV0yWbyv8X25u6ckD2eodoVrgycMEAx5EuHVkBEhPiHv2GM9Pk6lDcgm
	 9zEI4/p3lPoAkUNBNUVCnM6KZyLEeDyX1FuFi8WrLb379aDqt77wPRL2/ETq8kg4yg
	 Dvy3csh2jA0Lg==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.19-rc4
Date: Fri,  2 Jan 2026 14:01:13 -0800
Message-ID: <20260102220113.3067493-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.19.
You should be able to find my GPG key from the server now.

Thanks,
Namhyung


The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.19-2026-01-02

for you to fetch changes up to fe072f651083c612278de82ce08bccdfecf574b3:

  tools build: Fix the common set of features test wrt libopenssl (2025-12-27 20:26:44 -0800)

----------------------------------------------------------------
perf-tools fixes and updates for v6.19

A number of small updates:

 - skip building BPF skeletons if libopenssl is missing
 - a couple of test updates
 - handle error cases of filename__read_build_id()
 - support NVIDIA Olympus for ARM SPE profiling
 - update tool headers to sync with the kernel

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      tools build: Fix the common set of features test wrt libopenssl

Besar Wicaksono (2):
      tools headers arm64: Add NVIDIA Olympus part
      perf arm-spe: Add NVIDIA Olympus to neoverse list

Ian Rogers (3):
      perf symbol: Fix ENOENT case for filename__read_build_id
      perf tests kvm: Avoid leaving perf.data.guest file around
      perf tests top: Make the test exclusive

Namhyung Kim (13):
      tools/build: Add a feature test for libopenssl
      perf tools: Disable BPF skeleton if no libopenssl found
      tools headers: Sync UAPI drm/drm.h with kernel sources
      tools headers: Sync UAPI KVM headers with kernel sources
      tools headers: Sync UAPI linux/fcntl.h with kernel sources
      tools headers: Sync UAPI linux/fs.h with kernel sources
      tools headers: Sync UAPI linux/mount.h with kernel sources
      tools headers: Sync UAPI sound/asound.h with kernel sources
      tools headers: Sync x86 headers with kernel sources
      tools headers: Sync arm64 headers with kernel sources
      tools headers: Sync linux/gfp_types.h with kernel sources
      tools headers: Sync linux/socket.h with kernel sources
      tools headers: Sync syscall table with kernel sources

 tools/arch/arm64/include/asm/cputype.h             |  8 +++---
 tools/arch/x86/include/asm/cpufeatures.h           | 11 ++++++++
 tools/arch/x86/include/asm/msr-index.h             | 30 ++++++++++++++++++++++
 tools/arch/x86/include/uapi/asm/kvm.h              |  1 +
 tools/build/Makefile.feature                       |  6 +++--
 tools/build/feature/Makefile                       | 10 +++++---
 tools/build/feature/test-all.c                     |  5 ++++
 tools/build/feature/test-libopenssl.c              |  7 +++++
 tools/include/linux/gfp_types.h                    |  6 -----
 tools/include/uapi/asm-generic/unistd.h            |  4 ++-
 tools/include/uapi/drm/drm.h                       | 15 +++++++++++
 tools/include/uapi/linux/kvm.h                     | 11 ++++++++
 tools/perf/Makefile.config                         |  8 ++++++
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     |  1 +
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  1 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      |  1 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   |  1 +
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl  |  1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  |  1 +
 tools/perf/builtin-buildid-cache.c                 |  6 +++--
 tools/perf/tests/shell/kvm.sh                      |  2 +-
 tools/perf/tests/shell/top.sh                      |  2 +-
 tools/perf/trace/beauty/include/linux/socket.h     | 24 ++++++++++++++---
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 12 +++++++++
 tools/perf/trace/beauty/include/uapi/linux/fs.h    |  3 ++-
 tools/perf/trace/beauty/include/uapi/linux/mount.h |  2 +-
 .../perf/trace/beauty/include/uapi/sound/asound.h  |  2 +-
 tools/perf/util/arm-spe.c                          |  1 +
 tools/perf/util/libbfd.c                           |  4 ++-
 tools/perf/util/symbol-elf.c                       |  4 ++-
 tools/perf/util/symbol-minimal.c                   |  4 ++-
 tools/scripts/syscall.tbl                          |  1 +
 35 files changed, 170 insertions(+), 28 deletions(-)
 create mode 100644 tools/build/feature/test-libopenssl.c
