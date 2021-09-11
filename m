Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2022CC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 23:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A646101D
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 23:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhIKXqi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 19:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhIKXqh (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Sep 2021 19:46:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80EBB61029;
        Sat, 11 Sep 2021 23:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631403924;
        bh=/Fp5DkHRyfzdwsNQIggnnZnnyQy8D8vN2ua5OG5FE2E=;
        h=From:To:Cc:Subject:Date:From;
        b=WViIUv4XDX3gcq6qKKM3lTJlFU26oqvHfVSG+vSTwSiKBbYHDdIWODkPv7u7HmN3U
         n74ukfjlnXUCmDPZttt1SteJhpL5OZfPFtOlhBK7cM/aG0RIvWxX8pFZp6FlKJxQn2
         leqefYn9lZlzBEyqYmJTtjA8ze48ks72cCtSzgoDMicEp9scth+LYZWIDiQafPPT/X
         YhnLQaNc8PYvyCVYnLvXzfH53KL9plF2b8bEZ8EsMYH6h/cmM6RwuyetwszZMsPOc/
         pXg48W3nsUPFG+cPgZP517R5H8sy99g4W+kLQOzzStVAheCiS3JNfwRLADKug6Horo
         mYqpw7aXFyKGQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.15: 2nd batch
Date:   Sat, 11 Sep 2021 20:45:13 -0300
Message-Id: <20210911234513.121740-1-acme@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit bf9f243f23e6623f310ba03fbb14e10ec3a61290:

  Merge tag '5.15-rc-ksmbd-part2' of git://git.samba.org/ksmbd (2021-09-09 16:17:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.15-2021-09-11

for you to fetch changes up to 17a99e521f67743a5d3405cba0aacd8a10f9ff7d:

  tools headers UAPI: Update tools's copy of drm.h headers (2021-09-11 16:24:10 -0300)

----------------------------------------------------------------
perf tools changes for v5.15: 2nd batch

- Add missing fields and remove some duplicate fields when printing a perf_event_attr.

- Fix hybrid config terms list corruption.

- Update kernel header copies, some resulted in new kernel features being
  automagically added to 'perf trace' syscall/tracepoint argument id->string translators.

- Add a file generated during the documentation build to .gitignore.

- Add an option to build without libbfd, as some distros, like Debian consider
  its ABI unstable.

- Add support to print a textual representation of IBS raw sample data in 'perf report'.

- Fix bpf 'perf test' sample mismatch reporting

- Fix passing arguments to stackcollapse report in a 'perf script' python script.

- Allow build-id with trailing zeros.

- Look for ImageBase in PE file to compute .text offset.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (3):
      perf tools: Fix perf_event_attr__fprintf() missing/dupl. fields
      perf tools: Factor out copy_config_terms() and free_config_terms()
      perf tools: Fix hybrid config terms list corruption

Arnaldo Carvalho de Melo (13):
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools headers UAPI: Sync files changed by new process_mrelease syscall and the removal of some compat entry points
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools include UAPI: Sync sound/asound.h copy with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      perf beauty: Cover more flags in the  move_mount syscall argument beautifier
      tools include UAPI: Update linux/mount.h copy
      perf bpf: Provide a weak btf__load_from_kernel_by_id() for older libbpf versions
      tools headers UAPI: Sync linux/in.h copy with the kernel sources
      tools headers UAPI: Sync linux/fs.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h headers

Ian Rogers (2):
      perf tools: Ignore Documentation dependency file
      perf tools: Add an option to build without libbfd

Kim Phillips (3):
      perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings
      perf report: Add tools/arch/x86/include/asm/amd-ibs.h
      perf report: Add support to print a textual representation of IBS raw sample data

Michael Petlan (2):
      perf test: Fix bpf test sample mismatch reporting
      perf scripts python: Fix passing arguments to stackcollapse report

Namhyung Kim (1):
      perf tools: Allow build-id with trailing zeros

Remi Bernon (1):
      perf symbol: Look for ImageBase in PE file to compute .text offset

 tools/arch/x86/include/asm/amd-ibs.h               | 132 ++++++
 tools/arch/x86/include/uapi/asm/kvm.h              |   1 +
 tools/include/uapi/asm-generic/unistd.h            |  14 +-
 tools/include/uapi/drm/drm.h                       |  14 +-
 tools/include/uapi/drm/i915_drm.h                  | 498 +++++++++++++++++----
 tools/include/uapi/linux/fs.h                      |   1 +
 tools/include/uapi/linux/in.h                      |  42 +-
 tools/include/uapi/linux/kvm.h                     |  11 +-
 tools/include/uapi/linux/mount.h                   |   3 +-
 tools/include/uapi/linux/prctl.h                   |  12 +-
 tools/include/uapi/sound/asound.h                  |   1 +
 tools/perf/.gitignore                              |   1 +
 tools/perf/Makefile.config                         |  47 +-
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |   2 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  12 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  14 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   3 +-
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/scripts/python/bin/stackcollapse-report |   2 +-
 tools/perf/tests/bpf.c                             |   2 +-
 tools/perf/trace/beauty/include/linux/socket.h     |   9 +-
 tools/perf/trace/beauty/move_mount_flags.sh        |   2 +-
 tools/perf/util/Build                              |   1 +
 tools/perf/util/amd-sample-raw.c                   | 289 ++++++++++++
 tools/perf/util/bpf-event.c                        |   8 +
 tools/perf/util/dso.c                              |  10 +
 tools/perf/util/env.c                              |  78 ++++
 tools/perf/util/env.h                              |   5 +
 tools/perf/util/evsel.c                            |  20 +-
 tools/perf/util/evsel.h                            |   3 +
 tools/perf/util/parse-events-hybrid.c              |  18 +-
 tools/perf/util/parse-events.c                     |  27 +-
 tools/perf/util/perf_event_attr_fprintf.c          |   5 +-
 tools/perf/util/sample-raw.c                       |   8 +
 tools/perf/util/sample-raw.h                       |   6 +-
 tools/perf/util/symbol.c                           |  20 +-
 36 files changed, 1147 insertions(+), 175 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/amd-ibs.h
 create mode 100644 tools/perf/util/amd-sample-raw.c
