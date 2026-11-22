Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795381900;
	b=JCfsIJyvuwaxBspoRr7B7/yHoDKJafIr3m7rrJOY8bpPImDeQ8xnK0fGhQGl5RpTpvTr
	 QBZFTpkwNsjk7qVr6D1trGGMgazbGDUq63Pe5yOSHxymtetH+xgGilkodySb5Djd6CPMO
	 q36K1M6zxg6pHnXPoLOS5wtdz6B/LN1mNHbDucTc32cU9N87ROMH/qhIsh1Cus1ADy55O
	 1NFhjPX+iK+8CPdU1nna77hW7ikpVPFIrbyqtQ8cBU0t/zFqQ3kXp6Ci77OMNBVamHys9
	 o5ft8SE+YowSoB4KegW8dofqTYFOlUkaQICM3okmrmqU8SnJ6ln9AqbClIO1Y67lIkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381900;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7DGS+aSj3MfbwNJQG55DXM8DL4mRFc1N+IMzJ1ybSnU=;
	b=dGNnEGwSU23SRxsl8nWXoVPcdZUM17/GGlAgK9lpLIfOZbzjR3+/EWdaPysSV7LTBWVJ
	 XawGJ1qHcXaRgLnL5LZ4pcHvhJkmUyaqWbFPKfdyCuXhduaunz/y3eAzp4WUsUCTdJ9YE
	 mKspBi0SoYHyfnMNYmZg9T+3/KyqxHDuLWDrM3amTSj03/byjzUN0QPhSst9Bqf4Znbsa
	 PrsntGd4ZN6JYWTNR2fTCFkpbM4YrESRn3brg63kirfTZZ7RuNlvHrrtRkIA38oygii+p
	 8mNQd4H0FKmCdLXfkJYJtYkxwgJqgHfS5Az6e0xSskQiPlxPo2K2kmbKyRZLguqj2Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vw6zNiz5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B6606A31D;
	Sun, 22 Nov 2026 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vw6zNiz5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC091F000D4;
	Sun, 22 Nov 2026 21:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795381899;
	bh=7DGS+aSj3MfbwNJQG55DXM8DL4mRFc1N+IMzJ1ybSnU=;
	h=From:To:Cc:Subject:Date;
	b=Vw6zNiz5HuVYs+r57N6ZyQkwapSmkIYkCqgpvs/lIHpq4xgGRS43P916PkKbWWqdB
	 ZLmcf7VbuEKrP/cW8/f+wavP+GwEOmfReb/tQRn2BEvPMFop+6Yheb0QMxCNdJitIL
	 dw6eccYrPXsH9n6WO1rjF2KofU0gq730/0t9MdxuHKzuW+TkJ8oZ/Ba6AMGz9nitUE
	 pGAJWHGIPORM0u9OBzonPiKJOA8VZBAheZyg4MKW71ZfVArNvXtnSfw9bHZp+R8Oxa
	 e9rqjYZhOxgHP1tFwjtYI4XdFIKneiwmeJCXKvmNbwxiyWBNUx+6cpBcNj3oLrije6
	 S6v4eGnGejNgg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Dmitry Safonov <dima@arista.com>,
	Gu Bin <gubin@cmss.chinamobile.com>,
	Leo Yan <leo.yan@arm.com>,
	Li RongQing <lirongqing@baidu.com>,
	Paul Moses <p@1g4.org>,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v7.4
Date: Sun, 22 Nov 2026 18:11:28 -0300
Message-ID: <20261122211128.12684-1-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

	I signed this with a new key, that is already in the kernel.org
pgpkeys git repo.

	Please consider pulling.

Best regards,

- Arnaldo

The following changes since commit 05441d697f7f9a927264f4058cbbc6a03dfcac9d:

  Merge tag 'cocci-7.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux (2026-11-03 08:36:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.4-1-2026-11-22

for you to fetch changes up to 82838789646f9f5881dd1c8b3a3c960ee2a28772:

  perf record: Skip affinity for per-thread mmap buffers (2026-11-09 18:19:20 -0300)

----------------------------------------------------------------
perf tools fixes for v7.4

- perf record: skip affinity for per-thread mmap buffers and reject CPU
  indices at the mask size, avoiding out-of-bounds bitmap accesses.

- perf test: use software events for system-wide tests, mark the LBR test
  exclusive, and fix probe_vfs_getname debuginfo detection via a dry run.

- perf build: add -lzstd to the libbfd feature fallback for static
  binutils, and pass OUTPUT explicitly when building internal libraries.

- perf trace beauty: split the KVM ioctl table by direction so read and
  write ioctls sharing a number no longer conflict at build time.

- perf kvm: fix arm64 VM-exit duration accounting by pairing kvm_exit
  with the following kvm_entry as the end event.

- perf hist: use each branch's own cycle count for the sample weight
  instead of the first branch's, fixing multi-entry branch stacks.

- perf jevents: don't encode MSRs with no value, avoiding unset ldlat
  values in the affected Intel latency events.

- perf vendor events arm64 AmpereOneX: deprecate the old event name so
  scripts using it keep working while the renamed event is listed.

- perf intel-bts and intel-pt: free the old snapshot reference array when
  it grows past sixteen mappings, avoiding a leak.

- perf timechart and treport: initialize inherited attributes in their
  constructors, avoiding pylint warnings without Textual.

- perf tools: fix sync-headers generated commit messages to use longer
  SHAs and drop hunk headers that checkpatch mistakes for diff content.

- Sync the tools/ copies of gfp_types.h, gfp.h, KVM, sound/asound.h,
  msr-index.h, cpufeatures.h and if_addr.h with the kernel sources.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (8):
      tools headers UAPI: Sync linux/if_addr.h with the kernel sources
      tools arch x86: Sync the cpufeatures.h copy with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers: Sync UAPI sound/asound.h with the kernel sources
      perf trace beauty: Split the KVM ioctl table by direction
      tools headers: Sync KVM headers with the kernel sources
      tools headers: Sync linux/gfp_types.h with the kernel sources
      perf tools: Fix the sync-headers generated commit messages

Dmitry Safonov (1):
      perf build: Override OUTPUT when building internal libraries

Gu Bin (1):
      perf hist: Fix branch_info index for sample weight

Ian Rogers (3):
      tools build: Add explicitly sequenced -lzstd to libbfd feature fallback
      perf build: Add explicitly sequenced -lzstd to libbfd feature fallback
      perf jevents: Don't encode MSRs with no value

James Clark (2):
      perf test probe_vfs_getname: Fix missing debuginfo detection
      perf test: Don't starve per-process tests with system-wide events

Leo Yan (2):
      perf treport: Initialize the subtitle in the constructor
      perf timechart: Initialize Textual attributes in constructors

Li RongQing (3):
      perf kvm: Fix arm64 VM-exit duration accounting
      perf intel-pt: Free the old snapshot reference array after growing it
      perf intel-bts: Free the old snapshot reference array after growing it

Paul Moses (2):
      perf record: Reject CPU indices equal to the mask size
      perf record: Skip affinity for per-thread mmap buffers

TAKANO Mitsuhiro (1):
      perf vendor events arm64 AmpereOneX: Deprecate BPU_FLUSH_MEM_FAULT

 tools/arch/x86/include/asm/cpufeatures.h              |  6 +++++-
 tools/arch/x86/include/asm/msr-index.h                |  7 +++++++
 tools/arch/x86/include/uapi/asm/svm.h                 |  2 ++
 tools/build/Makefile.feature                          |  3 ++-
 tools/build/feature/Makefile                          | 19 +++++++++++++------
 tools/include/linux/gfp.h                             |  4 ----
 tools/include/linux/gfp_types.h                       | 11 ++++++++---
 tools/include/uapi/linux/if_addr.h                    |  1 +
 tools/include/uapi/linux/kvm.h                        | 16 ++++++++++++++++
 tools/perf/Makefile.config                            |  3 +++
 tools/perf/Makefile.perf                              |  8 ++++----
 tools/perf/arch/x86/util/intel-bts.c                  |  1 +
 tools/perf/arch/x86/util/intel-pt.c                   |  1 +
 tools/perf/builtin-record.c                           |  6 +++---
 .../arch/arm64/ampere/ampereonex/memory.json          |  5 +++--
 tools/perf/pmu-events/jevents.py                      |  2 +-
 tools/perf/python/treport.py                          |  2 +-
 tools/perf/python/ttimechart.py                       |  2 ++
 tools/perf/scripts/sync-headers.sh                    | 18 +++++++++---------
 tools/perf/tests/shell/lib/probe_vfs_getname.sh       |  7 ++++++-
 tools/perf/tests/shell/record.sh                      |  6 +++---
 tools/perf/tests/shell/record_lbr.sh                  |  2 +-
 tools/perf/tests/shell/record_sideband.sh             |  4 ++--
 tools/perf/trace/beauty/include/uapi/sound/asound.h   |  3 ++-
 tools/perf/trace/beauty/ioctl.c                       |  6 ++++--
 tools/perf/trace/beauty/kvm_ioctl.sh                  |  9 +++++++++
 tools/perf/util/hist.c                                |  2 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c        | 14 +++++++-------
 tools/perf/util/mmap.c                                |  4 ++--
 29 files changed, 119 insertions(+), 55 deletions(-)
