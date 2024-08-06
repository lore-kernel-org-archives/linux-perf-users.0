Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D33BB30;
	Tue,  6 Aug 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984617; cv=none; b=Rj3uNY73RUQaL0JvAIdT29D1/P4CznUvXLW3zVihmjxcHn30v3Lc/NEhf9uJjRMnWNvXBVJm/vI+zhwdElMej97eBPIySveV6Xz9JmGiZH79mrCKzbPKDd8RhnQBElWoR8g1o/t2OKdxhuoEShJJUdfZJTKEJz0MCWO2mkjp7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984617; c=relaxed/simple;
	bh=Uuzmt+G1XXTtnYH31M+MA+kwz1Lvn26M+bDbpb4G2dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afKPXiwZkGRcO3jqFuPGQdieak/jeFF8pLw7AVZUJ8UJB0yyDPWzheGW58WO7LxhUMa3ihoM/wR7f1IP4izmzBdgIrZ7y/7p45c+VHcYeRiq8kOeT8vyTUsqMfgmTsTDnkFu81wMRPxhERIu9Kw5JipOZYkUIUjcFevnw+Wq2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA9Udird; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA9Udird"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4301BC32786;
	Tue,  6 Aug 2024 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722984616;
	bh=Uuzmt+G1XXTtnYH31M+MA+kwz1Lvn26M+bDbpb4G2dM=;
	h=From:To:Cc:Subject:Date:From;
	b=oA9UdirdUjdmup4rGaYLV/AaZ+eCS+Ktn/6dKTJ0XMFiqhDKNL0DpcUYYFVn3Jd6Z
	 7SHHIawMDlC4n/hJDi4YSNyFrFr3zwvdqHCKrapYLIwt00hEddpQ0droQbsSremEvg
	 ocWhI/FmEvvBs4Ln89cvItqFT+U38TZrPv0DFsaNOVs2MMaRMm4T+6QUx2mqSWb4JE
	 4Ii81a7NULbyC+uWaRCDO+5wRicqAwswFE3Y0JaJKXM5B7ivxfFuVh6Qf9aA1SMJO6
	 wZaxFaIkHehc3d8rlupwzCPvCDAXj11ZzEJZTRV9sbgqq1ZdL39SSOLf3Se567cNqX
	 wBdSXiCmtaesg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCHSET 00/10] perf tools: Sync tools and kernel headers for v6.11
Date: Tue,  6 Aug 2024 15:50:03 -0700
Message-ID: <20240806225013.126130-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is the usual sync up in header files we keep in tools directory.
I put a file to give the reason of this work and not to repeat it in
every commit message.  The changes will be carried in the perf-tools
tree.

Thanks,
Namhyung


Namhyung Kim (10):
  perf tools: Add tools/include/uapi/README
  tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
  tools/include: Sync uapi/linux/kvm.h with the kernel sources
  tools/include: Sync uapi/linux/perf.h with the kernel sources
  tools/include: Sync uapi/sound/asound.h with the kernel sources
  tools/include: Sync uapi/asm-generic/unistd.h with the kernel sources
  tools/include: Sync network socket headers with the kernel sources
  tools/include: Sync filesystem headers with the kernel sources
  tools/include: Sync x86 headers with the kernel sources
  tools/include: Sync arm64 headers with the kernel sources

 tools/arch/arm64/include/asm/cputype.h        |  10 +
 tools/arch/arm64/include/uapi/asm/unistd.h    |  24 +-
 tools/arch/powerpc/include/uapi/asm/kvm.h     |   3 +
 tools/arch/x86/include/asm/cpufeatures.h      | 803 +++++++++---------
 tools/arch/x86/include/asm/msr-index.h        |  11 +
 tools/arch/x86/include/uapi/asm/kvm.h         |  49 ++
 tools/arch/x86/include/uapi/asm/svm.h         |   1 +
 tools/include/uapi/README                     |  73 ++
 tools/include/uapi/asm-generic/unistd.h       |   2 +-
 tools/include/uapi/drm/i915_drm.h             |  27 +
 tools/include/uapi/linux/in.h                 |   2 +
 tools/include/uapi/linux/kvm.h                |  17 +-
 tools/include/uapi/linux/perf_event.h         |   6 +-
 tools/include/uapi/linux/stat.h               |  12 +-
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   6 +-
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   2 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   8 +-
 .../perf/trace/beauty/include/linux/socket.h  |   5 +-
 .../perf/trace/beauty/include/uapi/linux/fs.h | 163 +++-
 .../trace/beauty/include/uapi/linux/mount.h   |  10 +-
 .../trace/beauty/include/uapi/linux/stat.h    |  12 +-
 .../trace/beauty/include/uapi/sound/asound.h  |   9 +-
 22 files changed, 810 insertions(+), 445 deletions(-)
 create mode 100644 tools/include/uapi/README

-- 
2.46.0.rc2.264.g509ed76dc8-goog

