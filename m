Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE5C433DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Dec 2020 18:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28296225AA
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Dec 2020 18:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgLXS5G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Dec 2020 13:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728700AbgLXS5F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Dec 2020 13:57:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C1AC2251F;
        Thu, 24 Dec 2020 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608836184;
        bh=3fEOoVN3v85ZLXYTJvG9vsq1Z12D8NDaw4YVnTSDgdM=;
        h=From:To:Cc:Subject:Date:From;
        b=QA+olRfAJ2JfSJ6jt8dZ0pRjt+ErWK77VXYonAcCoB5E/Y/5FYpQqcmLSFLBddGXz
         l8fb8djrPwC9osaoS+1pKUvygsvE4LOdg19Ga3rvlLTDzPMtglEnn0iDwkI6V8vwQX
         uaK/A0WWEPcmPh9qbO03XKz7xYtB4LsFkXUA4sSovo0ph3U0mTjHHG1K/JWbHuEYd1
         oxEzpA5/hJej3UzCJVHGD7hutND3EOTa9/kYBTbF1gl9WNJfamdKD7ykIor+Vu63XN
         JqC8tQ/kIufYPG23AERxjlBbjMr4ebxK+c9/lWZrp7qzyquHJfpqh2KqRXKf19aAXL
         ouIj7+Z8pzy7Q==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.11, 2nd batch
Date:   Thu, 24 Dec 2020 15:56:33 -0300
Message-Id: <20201224185633.514066-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 58cf05f597b03a8212d9ecf2c79ee046d3ee8ad9:

  Merge tag 'sound-fix-5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2020-12-23 15:11:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-2020-12-24

for you to fetch changes up to 5149303fdfe5c67ddb51c911e23262f781cd75eb:

  perf probe: Fix memory leak when synthesizing SDT probes (2020-12-24 10:52:10 -0300)

----------------------------------------------------------------
perf tools changes for v5.11, 2nd batch:

- Refactor 'perf stat' per CPU/socket/die/thread aggregation fixing use
  cases in ARM machines.

- Fix memory leak when synthesizing SDT probes in 'perf probe'.

- Update kernel header copies related to KVM, epol_pwait, msr-index and
  powerpc and s390 syscall tables.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results in the signed tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-2020-12-24

----------------------------------------------------------------

Arnaldo Carvalho de Melo (8):
      tools headers UAPI: Update epoll_pwait2 affected files
      tools headers cpufeatures: Sync with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      tools headers UAPI: Sync KVM's vmx.h header with the kernel sources
      tools kvm headers: Update KVM headers from the kernel sources
      tools headers UAPI: Synch KVM's svm.h header with the kernel
      perf probe: Fix memory leak when synthesizing SDT probes

James Clark (12):
      perf tests: Improve topology test to check all aggregation types
      perf cpumap: Use existing allocator to avoid using malloc
      perf cpumap: Add new struct for cpu aggregation
      perf stat: Replace aggregation ID with a struct
      perf cpumap: Add new map type for aggregation
      perf cpumap: Drop in cpu_aggr_map struct
      perf stat aggregation: Start using cpu_aggr_id in map
      perf stat aggregation: Add separate node member
      perf stat aggregation: Add separate socket member
      perf stat aggregation: Add separate die member
      perf stat aggregation: Add separate core member
      perf stat aggregation: Add separate thread member

Tiezhu Yang (4):
      perf powerpc: Move syscall.tbl check to check-headers.sh
      perf s390: Move syscall.tbl check into check-headers.sh
      perf tools: Update powerpc's syscall.tbl copy from the kernel sources
      perf tools: Update s390's syscall.tbl copy from the kernel sources

 tools/arch/arm64/include/uapi/asm/kvm.h            |   3 -
 tools/arch/x86/include/asm/cpufeatures.h           |   2 +
 tools/arch/x86/include/asm/msr-index.h             |   1 +
 tools/arch/x86/include/uapi/asm/kvm.h              |   1 +
 tools/arch/x86/include/uapi/asm/svm.h              |  28 ++
 tools/arch/x86/include/uapi/asm/vmx.h              |   2 +
 tools/include/uapi/asm-generic/unistd.h            |   4 +-
 tools/include/uapi/linux/kvm.h                     |  56 ++-
 tools/perf/arch/powerpc/Makefile                   |   7 -
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  26 +-
 tools/perf/arch/s390/Makefile                      |   4 -
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    | 396 ++++++++++++---------
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/builtin-stat.c                          | 128 +++----
 tools/perf/check-headers.sh                        |   2 +
 tools/perf/tests/topology.c                        |  64 +++-
 tools/perf/trace/beauty/tracepoints/x86_msr.sh     |   2 +-
 tools/perf/util/cpumap.c                           | 171 ++++++---
 tools/perf/util/cpumap.h                           |  55 +--
 tools/perf/util/probe-file.c                       |  13 +-
 tools/perf/util/stat-display.c                     | 102 +++---
 tools/perf/util/stat.c                             |   2 +-
 tools/perf/util/stat.h                             |   9 +-
 23 files changed, 688 insertions(+), 391 deletions(-)
