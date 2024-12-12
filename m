Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2A1547F5;
	Thu, 12 Dec 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040626; cv=none; b=Evbx6JzVHUrDJmYYTkvuOwic5UPhVQvJXdcbQPhVCk7A+TozM+RQMBD3nWBkNAyW2XEWyzKlBAM4ewJV3VYfSWSEAwYKz09gIiOAyCvZzyTsYBd0WGxLAIM5mySh8piNFj0sWWOmCxIWZlGB/2TumgGNKTrGpbx68/KEVSHG7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040626; c=relaxed/simple;
	bh=249/LUBkn9yAKizD1YcqTLacfbwnKtaQQBj+hlgwpi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGJLc6S8kASJuGFeN7MNdzRoiEhEJtFxOBEtRR5m/Qit98aE/YWNEn1p0mFGtmujqGzxPggZKzcXh+C7P/Qa5G9GrvPfEZaGjnHEj7NILUUMGGCRJd+LZrwyho2SScvbWFt/49xhhfN4ClxVjkuG80Dt7JTeZ2jhImtrB54ouYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIKSRmhl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIKSRmhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674BEC4CECE;
	Thu, 12 Dec 2024 21:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734040625;
	bh=249/LUBkn9yAKizD1YcqTLacfbwnKtaQQBj+hlgwpi8=;
	h=From:To:Cc:Subject:Date:From;
	b=JIKSRmhlGnzVX3HcBiBIgisvNsX4tpDE7xGelhKbrtWf8iwIVyBNqDcVjooK+L/VD
	 2h81mGoLbDQ8u/IDv3DHVeypftqq793LHwH0+dEJK/piVlfdnQf/dRsIZxZt7Gx0IQ
	 f2dPpnYAM1MLI5+lEE5jZpAw+mM93VLwG/VkWvJbVS1ENT6fZDSzvbfU8iO+tuikX3
	 ONTQRfnqntbe7jC06oF3YkXVXHV88PBhFP0umN7XZlXtWmUh0Ye99nRuKYv+SmV9yL
	 Y1gNH0sEy0cAKMowJtRBamYZ4Fp8v4koEKHRAl6vT9ZIo9YyYzofOktyYKEPQCNaEJ
	 +9outzucfK6iQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.13
Date: Thu, 12 Dec 2024 13:57:02 -0800
Message-ID: <20241212215702.70608-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.13.

Thanks,
Namhyung


The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.13-2024-12-12

for you to fetch changes up to 434fffa926b10706f2bde2db22979d68463302fc:

  perf probe: Fix uninitialized variable (2024-12-11 21:40:46 -0800)

----------------------------------------------------------------
perf tools fixes for v6.13

A set of random fixes for this cycle.

perf record
-----------
* Fix build-id event size calculation in perf record
* Fix perf record -C/--cpu option on hybrid systems
* Fix perf mem record with precise-ip on SapphireRapids

perf test
---------
* Refresh hwmon directory before reading the test files
* Make sure system_tsc_freq event is tested on x86 only

Others
------
* Usual header file sync
* Fix undefined behavior in perf ftrace profile
* Properly initialize a return variable in perf probe

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      perf machine: Initialize machine->env to address a segfault

Ian Rogers (3):
      perf hwmon_pmu: Use openat rather than dup to refresh directory
      perf test hwmon_pmu: Fix event file location
      perf test expr: Fix system_tsc_freq for only x86

James Clark (3):
      perf test: Don't signal all processes on system when interrupting tests
      libperf: evlist: Fix --cpu argument on hybrid platform
      perf probe: Fix uninitialized variable

Kuan-Wei Chiu (1):
      perf ftrace: Fix undefined behavior in cmp_profile_data()

Namhyung Kim (13):
      perf tools: Fix build-id event recording
      tools headers: Sync uapi/drm/drm.h with the kernel sources
      tools headers: Sync uapi/linux/perf_event.h with the kernel sources
      tools headers: Sync uapi/linux/kvm.h with the kernel sources
      tools headers: Sync x86 kvm and cpufeature headers with the kernel
      tools headers: Sync arm64 kvm header with the kernel sources
      tools headers: Sync *xattrat syscall changes with the kernel sources
      tools headers: Sync uapi/asm-generic/mman.h with the kernel sources
      tools headers: Sync uapi/linux/fcntl.h with the kernel sources
      tools headers: Sync uapi/linux/mount.h with the kernel sources
      tools headers: Sync uapi/linux/prctl.h with the kernel sources
      perf tools: Fix build error on generated/fs_at_flags_array.c
      perf tools: Fix precise_ip fallback logic

 tools/arch/arm64/include/uapi/asm/kvm.h            |  6 +++++
 tools/arch/x86/include/asm/cpufeatures.h           | 11 ++++++--
 tools/arch/x86/include/uapi/asm/kvm.h              |  1 +
 tools/include/uapi/asm-generic/mman.h              |  4 +++
 tools/include/uapi/asm-generic/unistd.h            | 11 +++++++-
 tools/include/uapi/drm/drm.h                       | 17 +++++++++++++
 tools/include/uapi/linux/kvm.h                     |  8 ++++++
 tools/include/uapi/linux/perf_event.h              | 11 +++++++-
 tools/lib/perf/evlist.c                            | 18 ++++++++++++--
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  4 +++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  4 +++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  4 +++
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl  |  4 +++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  4 +++
 tools/perf/builtin-ftrace.c                        |  3 ++-
 tools/perf/tests/builtin-test.c                    |  2 +-
 tools/perf/tests/expr.c                            | 19 ++++++++------
 tools/perf/tests/hwmon_pmu.c                       | 29 ++++++++++++++--------
 tools/perf/trace/beauty/fs_at_flags.sh             |  3 ++-
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h |  5 +---
 tools/perf/trace/beauty/include/uapi/linux/mount.h | 14 +++++++++--
 tools/perf/trace/beauty/include/uapi/linux/prctl.h | 27 +++++++++++++++++++-
 tools/perf/util/build-id.c                         |  4 +--
 tools/perf/util/evsel.c                            |  6 ++---
 tools/perf/util/hwmon_pmu.c                        | 15 ++++++++---
 tools/perf/util/machine.c                          |  2 ++
 tools/perf/util/probe-event.c                      |  2 +-
 27 files changed, 194 insertions(+), 44 deletions(-)
