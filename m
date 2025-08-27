Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E97260A;
	Wed, 27 Aug 2025 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338502; cv=none; b=bTg2In5CbCPfAMfUnu0XEGkwhDYmyZNsFKE9EBY5T6WN4LNtR3f+EpvL/oUNTLGsBfWYMss32tC2+4t1ADNcoZHDrebTOtUPrwQKSIXh8swE73CAK93SRxNcCEujMmLOksdzUZWJWxj2WNe8HlhdPsoVZFLA+hBZWB4eL5ptaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338502; c=relaxed/simple;
	bh=HYsAii2/HLSQBeXT+P2UaCT6xr1iko5uLaQwFjvygSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkCiHkpD8q2Kh5/LQQa/VynyLCreSXfR3ouHt0Wb2Vbz5avXzYdauqkNXGmZU2H4BCZ307231OIKnzM8iNkqcBA8MYycfuhd6ixJd7By2Nj57JmQANnO0w5+0xwsW98pjEnbDkfnnoK4cuImJoV7SOFziYYvBvvxZhyF06qbAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMIT8nuJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMIT8nuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB17BC4CEEB;
	Wed, 27 Aug 2025 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756338502;
	bh=HYsAii2/HLSQBeXT+P2UaCT6xr1iko5uLaQwFjvygSw=;
	h=From:To:Cc:Subject:Date:From;
	b=aMIT8nuJR0oR8XiverHENSD1rBE8lVUzZ/wr8/EHJO1Wf3ss3wnSDeNRA0tvtEWWt
	 kqv/gXrYdmg3sjgMXGavGYhiSa8FtdQq+OrrruTZ84pEPZBCXBiEVx8XXaQq09T/56
	 P6IAJqaK6oOxZClyczCUKSMV4LNNwFEvDoGz4yhLgU0LTm3HfqxnESvqxOfoqFruK8
	 4DzzPXUSRjU6fgiOIv4dpT6Df0nA5QRS4MNqxaB+3Ti2B40kn5MhSzy7HcwFRgtj2k
	 W4ihyDegNaY3WOCReGaFEDFHqCQrLzSRm9/X3WfJZq6u2keHEwzhPT4TyPhWL1fhR7
	 CQZRvLBaeg/HQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.17-rc4
Date: Wed, 27 Aug 2025 16:48:17 -0700
Message-ID: <20250827234817.4156091-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.17.

I've noticed a number of test failures when preparing this pull request.
I didn't notice it since it happens when running the tests in parallel.
So far git bisect couldn't find the correct bad commit but I don't think
it belongs to this series.  I'll keep investigating.

Thanks,
Namhyung


The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.17-2025-08-27

for you to fetch changes up to 2c369d91d0933aaff96b6b807b22363e6a38a625:

  perf symbol: Add blocking argument to filename__read_build_id (2025-08-25 15:07:18 -0700)

----------------------------------------------------------------
perf-tools fixes for v6.17-rc4

A list of kernel header sync changes and two build-id fixes.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Ian Rogers (2):
      perf symbol-minimal: Fix ehdr reading in filename__read_build_id
      perf symbol: Add blocking argument to filename__read_build_id

Namhyung Kim (12):
      perf test: Fix a build error in x86 topdown test
      tools headers: Sync KVM headers with the kernel source
      tools headers: Sync linux/bits.h with the kernel source
      tools headers: Sync linux/cfi_types.h with the kernel source
      tools headers: Sync x86 headers with the kernel source
      tools headers: Sync arm64 headers with the kernel source
      tools headers: Sync powerpc headers with the kernel source
      tools headers: Sync syscall tables with the kernel source
      tools headers: Sync uapi/linux/fcntl.h with the kernel source
      tools headers: Sync uapi/linux/fs.h with the kernel source
      tools headers: Sync uapi/linux/prctl.h with the kernel source
      tools headers: Sync uapi/linux/vhost.h with the kernel source

 tools/arch/arm64/include/asm/cputype.h             | 28 +++++++
 tools/arch/powerpc/include/uapi/asm/kvm.h          | 13 ----
 tools/arch/x86/include/asm/cpufeatures.h           | 10 ++-
 tools/arch/x86/include/asm/msr-index.h             |  7 ++
 tools/arch/x86/include/uapi/asm/kvm.h              |  8 +-
 tools/include/linux/bits.h                         | 29 ++-----
 tools/include/linux/cfi_types.h                    | 23 ++++++
 tools/include/uapi/asm-generic/unistd.h            |  8 +-
 tools/include/uapi/linux/kvm.h                     | 27 +++++++
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     |  2 +
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  2 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  2 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  2 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      |  2 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   |  2 +
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl  |  2 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  2 +
 tools/perf/arch/x86/tests/topdown.c                |  1 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  |  2 +
 tools/perf/bench/inject-buildid.c                  |  2 +-
 tools/perf/builtin-buildid-cache.c                 |  8 +-
 tools/perf/builtin-inject.c                        |  4 +-
 tools/perf/tests/sdt.c                             |  2 +-
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 18 +++++
 tools/perf/trace/beauty/include/uapi/linux/fs.h    | 88 ++++++++++++++++++++++
 tools/perf/trace/beauty/include/uapi/linux/prctl.h |  9 ++-
 tools/perf/trace/beauty/include/uapi/linux/vhost.h | 35 +++++++++
 tools/perf/util/build-id.c                         |  4 +-
 tools/perf/util/debuginfo.c                        |  8 +-
 tools/perf/util/dsos.c                             |  4 +-
 tools/perf/util/symbol-elf.c                       |  9 ++-
 tools/perf/util/symbol-minimal.c                   | 59 +++++++--------
 tools/perf/util/symbol.c                           |  8 +-
 tools/perf/util/symbol.h                           |  2 +-
 tools/perf/util/synthetic-events.c                 |  2 +-
 tools/scripts/syscall.tbl                          |  2 +
 36 files changed, 342 insertions(+), 94 deletions(-)
