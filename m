Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4A6C00528
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Aug 2023 21:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjHCVpd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Aug 2023 17:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjHCVpc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Aug 2023 17:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE43581;
        Thu,  3 Aug 2023 14:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44DF461ECB;
        Thu,  3 Aug 2023 21:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357CAC433C7;
        Thu,  3 Aug 2023 21:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691099121;
        bh=qvvdfwgWPZujmXX4thz1ZyE8vJWDROlDJz4/nG3UGYQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UYA5zCZJ1tMRSNsOYyP0jQ3xWS/5ZMi743E75+DUcUbsVgb7qo2efSoy9/pWoO5RI
         B7rz5SouqaQxNh6HMLkOIQB5kqE53+AaEWfTV2bxwzr42Z/ujvXOMT8C1ivh2Uw4Fx
         43baM6/aZlSHQdgbdZuwI6n3hcAUiwHhBCPVnc5xK/wXVTAnGKa5GEln5OcNb3Sjga
         sN0nHQc2M+OTWmy/s11KDHrahM6aX3ZzAlP421RoK1LkkiCc+5AUEGcLSSdRMTg9iG
         ufpMyMy/8SnNGDnDmA+QNUT/nXpeCIrXYa/FlJaXmPkvVOChGZRwKmxN00er0VU5cV
         ayKiQ08/20oTA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.5: 2nd batch
Date:   Thu,  3 Aug 2023 18:45:02 -0300
Message-ID: <20230803214502.19504-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
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


The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.5-2-2023-08-03

for you to fetch changes up to 07d2b820fd75b96f550c93503f19c8cfcbc577cf:

  perf test parse-events: Test complex name has required event format (2023-08-01 00:32:00 -0300)

----------------------------------------------------------------
perf tools fixes for 6.5: 2nd batch

- Fix segfault in the powerpc specific arch_skip_callchain_idx function.
  The patch doing the reference count init/exit that went into 6.5 missed
  this function.

- Fix regression reading the arm64 PMU cpu slots in sysfs, a patch removing
  some code duplication ended up duplicating the /sysfs prefix for these files.

- Fix grouping of events related to topdown, addressing a regression on the CSV
  output produced by 'perf stat' noticed on the downstream tool toplev.

- Fix the uprobe_from_different_cu 'perf test' entry, it is failing when
  gcc isn't available, so we need to check that and skip the test if it
  is not installed.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Athira Rajeev (1):
      perf callchain powerpc: Fix addr location init during arch_skip_callchain_idx function

Georg Müller (1):
      perf test uprobe_from_different_cu: Skip if there is no gcc

Haixin Yu (1):
      perf pmu arm64: Fix reading the PMU cpu slots in sysfs

Ian Rogers (5):
      perf parse-events: Extra care around force grouped events
      perf parse-events: When fixing group leaders always set the leader
      perf parse-events: Only move force grouped evsels when sorting
      perf pmus: Create placholder regardless of scanning core_only
      perf test parse-events: Test complex name has required event format

 tools/perf/arch/arm64/util/pmu.c                   |  7 +--
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |  4 ++
 tools/perf/tests/parse-events.c                    | 12 ++++-
 .../tests/shell/test_uprobe_from_different_cu.sh   |  8 ++-
 tools/perf/util/parse-events.c                     | 58 ++++++++++++++--------
 tools/perf/util/pmu.c                              | 11 ++++
 tools/perf/util/pmu.h                              |  1 +
 tools/perf/util/pmus.c                             | 16 +++---
 8 files changed, 81 insertions(+), 36 deletions(-)
