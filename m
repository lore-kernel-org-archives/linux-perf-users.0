Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE15C433DB
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Jan 2021 21:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676272247F
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Jan 2021 21:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbhAQVKS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 17 Jan 2021 16:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbhAQVKJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 17 Jan 2021 16:10:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D089C2247F;
        Sun, 17 Jan 2021 21:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610917769;
        bh=kIjdvp+ADgQ6Kr/fbUx7Jyl4hLbCnO317WqMdyCKTL8=;
        h=From:To:Cc:Subject:Date:From;
        b=uhypB+G66uE2ciBdF97/opsrzwyfWmfL+3/uJiFHfGOn/9It9MafV+LIRqpHallR+
         6t69CaxxFYhZUW93ROb6EBk5knF+kNI5xcx9/Fmz+tIERJjLCIL1NkJwfRp/prPDbN
         z21ej5i4GmZ/jpE3UuxJCKnjgqIkqPggoYZ/oQKL2gkIbpDRGJ/pvlNN/8JRqrH38r
         ivpd26Tq8CZyOMS632n7ka9ugSpiUibAKlx2NMoI738iWPZgRDkPB0I605VZYJMPNT
         EL4bVBQFHUDcAH+888FjxAYYJpd2jDTPAlJKKxWUEyfRIN4Jt6b6YZH065bz0yr8en
         J501du8THxDdA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <al.grant@foss.arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Denis Nikitin <denik@chromium.org>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.11
Date:   Sun, 17 Jan 2021 18:09:08 -0300
Message-Id: <20210117210908.13730-1-acme@kernel.org>
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

The following changes since commit f4e087c666f54559cb4e530af1fbfc9967e14a15:

  Merge tag 'acpi-5.11-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2021-01-15 10:55:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2021-01-17

for you to fetch changes up to 648b054a4647cd62e13ba79f398b8b97a7c82b19:

  perf inject: Correct event attribute sizes (2021-01-15 17:28:28 -0300)

----------------------------------------------------------------
perf tools fixes for 5.11:

- Fix 'CPU too large' error in Intel PT.

- Correct event attribute sizes in 'perf inject'.

- Sync build_bug.h and kvm.h kernel copies.

- Fix bpf.h header include directive in 5sec.c 'perf trace' bpf example.

- libbpf tests fixes.

- Fix shadow stat 'perf test' for non-bash shells.

- Take cgroups into account for shadow stats in 'perf stat'.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results in the signed tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-fixes-2021-01-17

----------------------------------------------------------------
Adrian Hunter (1):
      perf intel-pt: Fix 'CPU too large' error

Al Grant (1):
      perf inject: Correct event attribute sizes

Arnaldo Carvalho de Melo (3):
      perf bpf examples: Fix bpf.h header include directive in 5sec.c example
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      tools headers: Syncronize linux/build_bug.h with the kernel sources

Ian Rogers (3):
      libperf tests: Avoid uninitialized variable warning
      libperf tests: If a test fails return non-zero
      libperf tests: Fail when failing to get a tracepoint id

Namhyung Kim (3):
      perf test: Fix shadow stat test for non-bash shells
      perf stat: Introduce struct runtime_stat_data
      perf stat: Take cgroups into account for shadow stats

 tools/include/linux/build_bug.h            |   5 -
 tools/include/uapi/linux/kvm.h             |   2 +
 tools/lib/perf/tests/test-cpumap.c         |   2 +-
 tools/lib/perf/tests/test-evlist.c         |   7 +-
 tools/lib/perf/tests/test-evsel.c          |   2 +-
 tools/lib/perf/tests/test-threadmap.c      |   2 +-
 tools/perf/examples/bpf/5sec.c             |   2 +-
 tools/perf/tests/shell/stat+shadow_stat.sh |  30 ++-
 tools/perf/util/header.c                   |   8 +
 tools/perf/util/machine.c                  |   4 +-
 tools/perf/util/session.c                  |   2 +-
 tools/perf/util/stat-shadow.c              | 366 +++++++++++++++--------------
 12 files changed, 224 insertions(+), 208 deletions(-)
