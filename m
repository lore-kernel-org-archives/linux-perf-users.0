Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B718C933;
	Sun, 13 Apr 2025 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744586742; cv=none; b=nRGEs7n9bj88segX0pF1PbT4UTsQoBW90skcy8m4D+tlUI1ndkLErDvbTNoTHFjO6wjBccPfkHk3DjEnUB46ortXBbL2wtgXGr2DCET5g/h/lmAjt7IMQ8EvLcXbKmk57zoKQL/DCXkx7ze7nIoeJLdEemPZ0C5dl6odH9d0q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744586742; c=relaxed/simple;
	bh=cj7tLYWkJnjZzDsM0vjGoO+h1qysMwJqyctJfx39jw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbdhG5N0cf/AghWX4FmJelTb649/MI9QUw3UGwfogkPfVpBdsHq5dXImttV7ChPqAEJgnqd3nN32QGzEdDtOKFB/bcRg+wkvt1wr2dOu3I2nS5GUTYG4A5o+j0Rvn4bXdLzJeEN/FonrkxpUC6xcgodjMcprEFM2rWF2TthyEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Memyz3B+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Memyz3B+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E83C4CEDD;
	Sun, 13 Apr 2025 23:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744586742;
	bh=cj7tLYWkJnjZzDsM0vjGoO+h1qysMwJqyctJfx39jw8=;
	h=From:To:Cc:Subject:Date:From;
	b=Memyz3B+n9+xGqaE4XoOoGH1yC5HeZDc+18Xdr4yBqcFXQzgH4iPzNuKfoN7Aiz9u
	 Ur/2eht7pG/ZF1N78HV2l2t06NcbS4fhSdaDp8Q6FKsAbn3Xx/To2z5LeDjeFwchrK
	 OStsiTbLx9bA+vaWTSK+omFEJ+N35sVO3ce7SukilGWcyI0V+ugYr+/00acmnHGw94
	 +exO6pSeNHzmf/wU+HuXVWT+Rwfxor3/czWtmVAMmGTa4DkuRifkgp9R1JiY6Cf7r5
	 fzt1tlOKLfS1fF+RXr62p/KHP6VNAQ3CLKo2uu9Puw9Yc63zO+aw6yYAsMu6cxXmQw
	 4H4Y0LIBB+GnA==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.15-rc2
Date: Sun, 13 Apr 2025 16:25:38 -0700
Message-ID: <20250413232538.4094456-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.15.

Thanks,
Namhyung


The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.15-2025-04-13

for you to fetch changes up to 2b70702917337a8d6d07f03eed961e0119091647:

  perf tools: Remove evsel__handle_error_quirks() (2025-04-11 09:22:49 -0700)

----------------------------------------------------------------
perf tools fixes for v6.15-rc2

A couple of fixes and the usual tooling header updates.

* fix a build error on ARM64 when libunwind is requested
* fix an infinite loop with branch stack on AMD Zen3
* sync tooling headers with the kernel source

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      perf libunwind arm64: Fix missing close parens in an if statement

Namhyung Kim (11):
      tools headers: Update the KVM headers with the kernel sources
      tools headers: Update the socket headers with the kernel sources
      tools headers: Update the uapi/linux/perf_event.h copy with the kernel sources
      tools headers: Update the VFS headers with the kernel sources
      tools headers: Update the syscall table with the kernel sources
      tools headers: Update the uapi/linux/prctl.h copy with the kernel sources
      tools headers: Update the uapi/asm-generic/mman-common.h copy with the kernel sources
      tools headers: Update the linux/unaligned.h copy with the kernel sources
      tools headers: Update the x86 headers with the kernel sources
      tools headers: Update the arch/x86/lib/memset_64.S copy with the kernel sources
      perf tools: Remove evsel__handle_error_quirks()

 tools/arch/arm64/include/uapi/asm/kvm.h            |  5 +-
 tools/arch/arm64/include/uapi/asm/unistd.h         | 24 +-----
 tools/arch/x86/include/asm/cpufeatures.h           | 28 ++++--
 tools/arch/x86/include/asm/msr-index.h             | 31 ++++---
 tools/arch/x86/include/uapi/asm/kvm.h              |  4 +
 tools/arch/x86/include/uapi/asm/svm.h              |  2 +
 tools/arch/x86/lib/memset_64.S                     |  3 +-
 tools/include/linux/cfi_types.h                    | 45 ++++++++++
 tools/include/uapi/asm-generic/mman-common.h       |  1 +
 tools/include/uapi/asm-generic/unistd.h            |  4 +-
 tools/include/uapi/linux/in.h                      |  2 +
 tools/include/uapi/linux/kvm.h                     |  9 +-
 tools/include/uapi/linux/perf_event.h              |  2 +
 tools/include/uapi/linux/stat.h                    | 99 ++++++++++++++++------
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     |  1 +
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  1 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      |  1 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   |  1 +
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl  |  3 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  |  1 +
 tools/perf/check-headers.sh                        |  1 +
 tools/perf/trace/beauty/include/linux/socket.h     |  2 +
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h |  4 +
 tools/perf/trace/beauty/include/uapi/linux/fs.h    | 21 +++--
 tools/perf/trace/beauty/include/uapi/linux/mount.h | 10 ++-
 tools/perf/trace/beauty/include/uapi/linux/prctl.h | 11 +++
 tools/perf/trace/beauty/include/uapi/linux/stat.h  | 99 ++++++++++++++++------
 .../perf/trace/beauty/include/uapi/sound/asound.h  |  8 +-
 tools/perf/util/evsel.c                            | 22 -----
 tools/perf/util/unwind-libunwind-local.c           |  2 +-
 tools/scripts/syscall.tbl                          |  1 +
 34 files changed, 319 insertions(+), 132 deletions(-)
 create mode 100644 tools/include/linux/cfi_types.h
