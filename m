Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBE6C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Sat, 19 Jun 2021 16:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BE8610A2
	for <linux-perf-users@archiver.kernel.org>; Sat, 19 Jun 2021 16:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhFSQ4k (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 19 Jun 2021 12:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234800AbhFSQ4i (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 19 Jun 2021 12:56:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 156FD61002;
        Sat, 19 Jun 2021 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624121667;
        bh=/c0MjA9qCgiipSBFS+d1fptRbka4uIyU5IAVrlf53V4=;
        h=From:To:Cc:Subject:Date:From;
        b=Rp3AeNW1qYtYwdt6cZi+FX0bpTucS4R3Ex6XjzdGn18De/29P8h/rTCTnzTqbg5cW
         yrCwybJT35RuqBaP8Lxk5VJ9Jr8cbWY/C8/+5o37nfY48g+ek5qrC0SPhzXGjV9R6U
         4FkJV8dEw4R+oPpCmfgNPGUpk+d+rND/o2qShSDHGpvczkxcE3187+lYONvmMl6Eis
         l2bmH8nu/abn217FyBEKHcPA92bOxqa8w9vnIHQjuRXEGNMOK4aSvB38tkiQ5iP5Qc
         P6Kplrh6l7ZBFt+W/NTj/iGM5/hjpKSNmvWNCYTKog2OO+p7mJgNRz32MBTmqC/Imi
         bF1Myeku3QDew==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.13: 6th batch
Date:   Sat, 19 Jun 2021 13:54:17 -0300
Message-Id: <20210619165417.871997-1-acme@kernel.org>
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


The following changes since commit 9ed13a17e38e0537e24d9b507645002bf8d0201f:

  Merge tag 'net-5.13-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2021-06-18 18:55:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-06-19

for you to fetch changes up to 1792a59eab9593de2eae36c40c5a22d70f52c026:

  tools headers UAPI: Sync linux/in.h copy with the kernel sources (2021-06-19 10:15:22 -0300)

----------------------------------------------------------------
perf tools fixes for v5.13: 6th batch

- Fix refcount usage when processing PERF_RECORD_KSYMBOL.

- 'perf stat' metric group fixes.

- Fix 'perf test' non-bash issue with stat bpf counters.

- Update unistd, in.h and socket.h with the kernel sources, silencing
  perf build warnings.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (3):
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools headers UAPI: Sync asm-generic/unistd.h with the kernel original
      tools headers UAPI: Sync linux/in.h copy with the kernel sources

Ian Rogers (1):
      perf test: Fix non-bash issue with stat bpf counters

John Garry (2):
      perf metricgroup: Fix find_evsel_group() event selector
      perf metricgroup: Return error code from metricgroup__add_metric_sys_event_iter()

Riccardo Mancini (1):
      perf machine: Fix refcount usage when processing PERF_RECORD_KSYMBOL

 tools/include/uapi/asm-generic/unistd.h        |  3 +--
 tools/include/uapi/linux/in.h                  |  3 +++
 tools/perf/tests/shell/stat_bpf_counters.sh    |  4 ++--
 tools/perf/trace/beauty/include/linux/socket.h |  2 --
 tools/perf/util/machine.c                      |  3 ++-
 tools/perf/util/metricgroup.c                  | 14 ++++++++------
 6 files changed, 16 insertions(+), 13 deletions(-)
