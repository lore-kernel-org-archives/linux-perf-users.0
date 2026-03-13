Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0E35DA79;
	Fri, 13 Mar 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414891; cv=none; b=UNtCNUXFTZnkSA7TIGkShAAKJdD+3eERjUgphRhj/N3GK98i5ldYPW5N0bVPbZLxmU6790ZTygBoVAx6mx7+FOfDUJueDU9rClvY7fjq2USRCfeT+QuoKZAdoYLVWrHWGDzGaqdDs70VuMNq8qKekjWYXmOPUl2B3pfj9l2Dr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414891; c=relaxed/simple;
	bh=k8I8bAXrnAz84SkoUYj+nj9OUQjwxWrTL3YDjclDP18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8+PM+VdAD4XResVxBMj2xh6RVVSJDHQDxcdHceRnNF1Z8+el8huMBwcRFHsmkSm1TnIHnjMlmHOqvRJ5qU/IkVqcDmMtgg9pK2xsF1M+Q1VEM8fXxgmVWBB1ycwLuFFh+u5feeaagyHfeggORrHiaDcDu8YT7QOM7NaEdo/N+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEO7X26B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEO7X26B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B52C19421;
	Fri, 13 Mar 2026 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773414891;
	bh=k8I8bAXrnAz84SkoUYj+nj9OUQjwxWrTL3YDjclDP18=;
	h=From:To:Cc:Subject:Date:From;
	b=CEO7X26BGNGXf7/834VeTsavOqbs9D+3PlcSX6dEq6XVk/hF2CG5VBp5mCRsQ7H/+
	 iPpzotBPPSqkGAyWIvow3l6lDKtSOrrYCMXOvV8MFi6gqA2dUHBSirPOi5lmIG9V7k
	 haPrTkLMqqJ18nf1mUwvccQXJg+wARXkgawRnyULKSXBdq6GI+aC3VCvsL7Eoq2oRw
	 V4U9nTFXstWkzY+bbU6TeXDhQYBQl7Em+PXRBf8ez4MUmFhl0t8CPQJS82DDEvotTC
	 D7Ftpw9tqJJWVDMcl68KBBGvxchnkBLAmrP5cvYcOTnGGzNBkks8+nFjmhrWDBwDpb
	 fylP/IPV7aFCQ==
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
	Changqing Li <changqing.li@windriver.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Leo Yan <leo.yan@arm.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Peter Collingbourne <pcc@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v7.0
Date: Fri, 13 Mar 2026 12:14:34 -0300
Message-ID: <20260313151434.1695228-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
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


The following changes since commit 0031c06807cfa8aa51a759ff8aa09e1aa48149af:

  Merge tag 'cgroup-for-7.0-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2026-03-03 14:25:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.0-1-2026-03-13

for you to fetch changes up to 35b16a7a2c4fc458304447128b86514ce9f70f3c:

  perf synthetic-events: Fix stale build ID in module MMAP2 records (2026-03-11 17:47:42 -0300)

----------------------------------------------------------------
perf tools fixes for v7.0:

- Fix stale build ID in module MMAP2 records in events synthesized for
  pre-existing processes.

- Fix rust cross compilation.

- hashmap__new() error pointer return handling fixes.

- Fix off-by-one bug in outside of functions check on the disasm code.

- Update header copies of kernel headers, including prctl.h, mount.h, fs.h,
  irq_vectors.h, perf_event.h, gfp_types.h, kvm.h, cpufeatures.h msr-index.h,
  also the syscall tables files that introduced the 'rseq_slice_yield' syscall.

- Finish removal of ETM_OPT_* on the ARM coresight support, needed to sync
  the coresight-pmu.h header with the kernel sources.

- Make in-target rule robust against too long argument error.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (12):
      tools headers: Sync uapi/linux/prctl.h with the kernel source
      perf beauty: Sync linux/mount.h copy with the kernel sources
      perf beauty: Sync UAPI linux/fs.h with kernel sources
      perf beauty: Update the arch/x86/include/asm/irq_vectors.h copy with the kernel sources
      perf beauty: Update the linux/perf_event.h copy with the kernel sources
      tools headers: Update the linux/gfp_types.h copy with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers x86 cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools arch x86: Sync msr-index.h to pick MSR_{OMR_[0-3],CORE_PERF_GLOBAL_STATUS_SET}
      tools headers: Update the syscall tables and unistd.h, to support the new 'rseq_slice_yield' syscall
      tools headers UAPI: Update tools' copy of linux/coresight-pmu.h

Changqing Li (1):
      tools build: Make in-target rule robust against too long argument error

Chen Ni (2):
      perf annotate: Fix hashmap__new() error checking
      perf ftrace: Fix hashmap__new() error checking

Chuck Lever (1):
      perf synthetic-events: Fix stale build ID in module MMAP2 records

Dmitrii Dolgov (1):
      tools build: Fix rust cross compilation

Ian Rogers (1):
      perf annotate loongarch: Fix off-by-one bug in outside check

James Clark (2):
      perf cs-etm: Finish removal of ETM_OPT_*
      perf cs-etm: Sync coresight-pmu.h header with the kernel sources

Markus Mayer (1):
      perf build: Prevent "argument list too long" error

Peter Collingbourne (1):
      perf disasm: Fix off-by-one bug in outside check

 tools/arch/x86/include/asm/amd/ibs.h               |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h           |   4 +-
 tools/arch/x86/include/asm/msr-index.h             |   6 +
 tools/arch/x86/include/uapi/asm/kvm.h              |   8 +-
 tools/build/Build.include                          |   9 +
 tools/build/Makefile.build                         |   6 +-
 tools/include/linux/coresight-pmu.h                |  24 -
 tools/include/linux/gfp_types.h                    |   9 +-
 tools/include/uapi/asm-generic/unistd.h            |   5 +-
 tools/include/uapi/linux/kvm.h                     |  24 +-
 tools/include/uapi/linux/perf_event.h              |   2 +-
 tools/perf/Makefile.config                         |  18 +
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     |   1 +
 tools/perf/arch/arm/util/cs-etm.c                  |  14 -
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |   1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    | 859 ++++++++++-----------
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      |   1 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   |   3 +-
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  |   1 +
 tools/perf/builtin-ftrace.c                        |   9 +-
 tools/perf/pmu-events/Build                        |   3 +-
 .../beauty/arch/x86/include/asm/irq_vectors.h      |   1 +
 tools/perf/trace/beauty/include/uapi/linux/fs.h    |   1 +
 tools/perf/trace/beauty/include/uapi/linux/mount.h |  13 +-
 tools/perf/trace/beauty/include/uapi/linux/prctl.h |  37 +
 tools/perf/util/annotate-arch/annotate-loongarch.c |   2 +-
 tools/perf/util/annotate.c                         |   5 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   2 +-
 tools/perf/util/cs-etm.c                           |  36 +-
 tools/perf/util/cs-etm.h                           |  15 +
 tools/perf/util/disasm.c                           |   2 +-
 tools/perf/util/synthetic-events.c                 |   5 +
 tools/scripts/syscall.tbl                          |   1 +
 37 files changed, 584 insertions(+), 550 deletions(-)
