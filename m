Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427121CD2A;
	Sun,  9 Jun 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717940892; cv=none; b=sysolDFQSF5MFMI6BRUMjcCKDEwW+gMZyUjfRSjAyKjMyNDOg7udqDZubbLQdzXfYGgVTvhuy1mdrZw5RVz5eucV5bMqjUSC7uUGxBdalstjw6MRQSbSfV2iJsyqIVZjkHoJwUwF1+MdQujMrUHW7/ccQY6Zpqn3v8Ic/ta5ehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717940892; c=relaxed/simple;
	bh=MsfDNyM9kCPGyW5bQ0n3e08qTzN3c/4LxFc+K0//VNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJtGNvExUUkRRK6P5OmD6FpRHOLOEwJ5PMP/RYpT6xQ8hQApBzqLGdovNpceGSvrPrP59QGNPXVtad3IuzBZsc5Hz+P1masraEz44YWLbZTfFb6k5AvffWLjGDPU5BNjcHbU66fRFKRbFbQFTfaWQjrQe34Xojf+QiGv6BjX9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7Ma1XWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7Ma1XWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD035C2BD10;
	Sun,  9 Jun 2024 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717940891;
	bh=MsfDNyM9kCPGyW5bQ0n3e08qTzN3c/4LxFc+K0//VNc=;
	h=From:To:Cc:Subject:Date:From;
	b=c7Ma1XWCDOr/booLcB1kSj17uKNqx7Oyts5rarIeSaR4WC7ni3SVAk5KER7bgeCIS
	 D2i7sXUt3LgIk3lgC7HMqHvADR+eorC7AIBqj3Y06pe4tiNI91DYH9zdLBYiE34vTh
	 5SGrNiN6jjQLJ36hPITXqXD5K8k6DtkJHmcLdsfY+XfKOAAkxAusFHfRK3iPWfgHt/
	 CgLgmfhCXmI0rkb9dyUaWpbLGST9pg4KPe4+4oVN9TCDWSwcHW5dwBbQQWXl/6L6bo
	 G28MOgf4fGYgon2OIczx9FT6xArq8jDQ/d8JneNrQfDx19dQds/wIPaIwzyRys74zk
	 c6kRdb6m3/+Xw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Milian Wolff <milian.wolff@kdab.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.10: 2nd batch
Date: Sun,  9 Jun 2024 10:47:32 -0300
Message-ID: <20240609134732.172580-1-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.10-2-2024-06-09

for you to fetch changes up to ca9680821dfec73c9100860bda4fab1f1309722e:

  perf bpf: Fix handling of minimal vmlinux.h file when interrupting the build (2024-06-05 11:33:00 -0300)

----------------------------------------------------------------
perf tools fixes for v6.10: 2nd batch

- Update copies of kernel headers, which resulted in support for the new
  'mseal' syscall, SUBVOL statx return mask bit, RISC-V and PPC prctls,
  fcntl's DUPFD_QUERY, POSTED_MSI_NOTIFICATION IRQ vector, 'map_shadow_stack'
  syscall for x86-32.

- Revert perf.data record memory allocation optimization that ended up
  causing a regression, work is being done to re-introduce it in the
  next merge window.

- Fix handling of minimal vmlinux.h file used with BPF's CO-RE when
  interrupting the build.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (12):
      tools include UAPI: Sync linux/stat.h with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers UAPI: Sync fcntl.h with the kernel sources to pick F_DUPFD_QUERY
      perf beauty: Update copy of linux/socket.h with the kernel sources
      perf trace beauty: Update the arch/x86/include/asm/irq_vectors.h copy with the kernel sources to pick POSTED_MSI_NOTIFICATION
      tools headers: Update the syscall tables and unistd.h, mostly to support the new 'mseal' syscall
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Sync kvm headers with the kernel sources
      tools headers UAPI: Update i915_drm.h with the kernel sources
      tools headers uapi: Sync linux/stat.h with the kernel sources to pick STATX_SUBVOL
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      Revert "perf record: Reduce memory for recording PERF_RECORD_LOST_SAMPLES event"

Namhyung Kim (1):
      perf bpf: Fix handling of minimal vmlinux.h file when interrupting the build

 tools/arch/arm64/include/asm/cputype.h             |  6 +++++
 tools/arch/x86/include/asm/msr-index.h             |  9 +++----
 tools/arch/x86/include/uapi/asm/kvm.h              | 22 +++++++++++++--
 tools/include/uapi/asm-generic/unistd.h            |  5 +++-
 tools/include/uapi/drm/i915_drm.h                  | 31 +++++++++++++++++++---
 tools/include/uapi/linux/kvm.h                     |  4 +--
 tools/include/uapi/linux/stat.h                    |  4 ++-
 tools/perf/Makefile.perf                           |  1 +
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  3 ++-
 tools/perf/builtin-record.c                        |  6 ++---
 tools/perf/builtin-trace.c                         |  2 +-
 .../beauty/arch/x86/include/asm/irq_vectors.h      |  8 +++++-
 tools/perf/trace/beauty/include/linux/socket.h     |  3 ++-
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 14 +++++-----
 tools/perf/trace/beauty/include/uapi/linux/prctl.h | 22 +++++++++++++++
 tools/perf/trace/beauty/include/uapi/linux/stat.h  |  4 ++-
 19 files changed, 118 insertions(+), 29 deletions(-)
