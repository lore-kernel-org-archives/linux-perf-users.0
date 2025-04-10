Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC605136E;
	Thu, 10 Apr 2025 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243887; cv=none; b=WCDDQy8bl022FTIVvwgLBgb2AjW19JuXzGn/0iGrWX+Mz6YJ3BU+jRe13bUZAeekRBDAvjEawKe2rNuxNLUamKady+umywRoFnG1nMItemntU0t8T+WNzvSor9RiSZxDgXcBW8WEJCZkFPX0znHruJQdnmjetu1fzNahsO/DCtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243887; c=relaxed/simple;
	bh=6PX2y6AJPpGl3dKhFzuaAcuIp0YPP478TUGxJCS4N7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHi9sivV+6ja2QsiDhlZMHj/LiolbpjZTL3SWluMVnpUkdDdCuOMzqGmWfYympJg/rMPnygS5WBKWnv2fW5EgSpp7FG/F/ilH+0i8cyZeUU/8l5tEf7s+s2fJt/QySRlyRaYrmnDQKM70kDH66/fJHfhtHhlR23fDxaiOgn8zTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDiXHPGj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDiXHPGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95F3C4CEE2;
	Thu, 10 Apr 2025 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243887;
	bh=6PX2y6AJPpGl3dKhFzuaAcuIp0YPP478TUGxJCS4N7I=;
	h=From:To:Cc:Subject:Date:From;
	b=BDiXHPGj7FQuHNnFg+Y2RHhsOi+rdKDBGaXtN9tbpZhCBo5kbdxrl5aqZBkmyL3Rq
	 1yyM2VRUKCDscrJ78v256Mj9d4WqIgBMPKk65w/0p/CuO9ZK2n0t4w2ErXEaNF4TDN
	 pOcjY5J6EZKBH04eL6r3fUgjU2c0QWwaALxF/zM/8YGrdrIDFV8sr50KOjf0UdfKAc
	 JRjmk/rWP+7iDmUPcoGb7fMAakJnhSYDuN+f3J6g/IzrjCDmMncfEZtRhmZXqeUn5B
	 OzAgYdYquhSLVK+R/Q+9LWtS7U6Sfr8pVLSXB7IeRtKQbMp400fNk30lIgbPrGfteu
	 AC7CxlTa+EN9g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET 00/10] tools headers: Sync header files with the kernel
Date: Wed,  9 Apr 2025 17:11:15 -0700
Message-ID: <20250410001125.391820-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

FYI I'm carrying these changes in the perf tools tree so make perf trace
beautifiers get the recent changes in syscall, ioctl, and so on.  For the
background, please see tools/include/uapi/README.

Still there are some remaining items but it requires a bit more changes.
So I'd like to leave them for the next cycle.

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
    diff -u tools/include/linux/bits.h include/linux/bits.h
    diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Thanks,
Namhyung


Namhyung Kim (10):
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

 tools/arch/arm64/include/uapi/asm/kvm.h       |  5 +-
 tools/arch/arm64/include/uapi/asm/unistd.h    | 24 +----
 tools/arch/x86/include/asm/cpufeatures.h      | 28 ++++--
 tools/arch/x86/include/asm/msr-index.h        | 31 +++---
 tools/arch/x86/include/uapi/asm/kvm.h         |  4 +
 tools/arch/x86/include/uapi/asm/svm.h         |  2 +
 tools/arch/x86/lib/memset_64.S                |  3 +-
 tools/include/linux/cfi_types.h               | 45 +++++++++
 tools/include/uapi/asm-generic/mman-common.h  |  1 +
 tools/include/uapi/asm-generic/unistd.h       |  4 +-
 tools/include/uapi/linux/in.h                 |  2 +
 tools/include/uapi/linux/kvm.h                |  9 +-
 tools/include/uapi/linux/perf_event.h         |  2 +
 tools/include/uapi/linux/stat.h               | 99 ++++++++++++++-----
 .../perf/arch/arm/entry/syscalls/syscall.tbl  |  1 +
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  1 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  1 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl |  1 +
 .../arch/sparc/entry/syscalls/syscall.tbl     |  1 +
 .../arch/x86/entry/syscalls/syscall_32.tbl    |  3 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  1 +
 .../arch/xtensa/entry/syscalls/syscall.tbl    |  1 +
 tools/perf/check-headers.sh                   |  1 +
 .../perf/trace/beauty/include/linux/socket.h  |  2 +
 .../trace/beauty/include/uapi/linux/fcntl.h   |  4 +
 .../perf/trace/beauty/include/uapi/linux/fs.h | 21 +++-
 .../trace/beauty/include/uapi/linux/mount.h   | 10 +-
 .../trace/beauty/include/uapi/linux/prctl.h   | 11 +++
 .../trace/beauty/include/uapi/linux/stat.h    | 99 ++++++++++++++-----
 .../trace/beauty/include/uapi/sound/asound.h  |  8 +-
 tools/scripts/syscall.tbl                     |  1 +
 32 files changed, 318 insertions(+), 109 deletions(-)
 create mode 100644 tools/include/linux/cfi_types.h


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.49.0.504.g3bcea36a83-goog

