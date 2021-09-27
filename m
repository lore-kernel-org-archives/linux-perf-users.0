Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D810AC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 18:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13D660FD7
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 18:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhI0SwO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236117AbhI0SwN (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 14:52:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDAB160FF2;
        Mon, 27 Sep 2021 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632768635;
        bh=goQSY8O6WwjLpatYeD7syHqVZf6rcbhBVkwQxb/GOFA=;
        h=From:To:Cc:Subject:Date:From;
        b=c9lqGhAkSmH00JlvAF3PFFwdZWMQMKoPKhVH850nfPctivpWpuUSN286gR0ZKe6hw
         McK4sOpnIqVD/LyRGqT2FAvDNg9g6RMi/HyuAZ5TH2K8hywNBhpyCRdgm4oqv0c4ci
         z/4IGKJmp1iGftiNPKOHt9jU7pzK/bWnoU+ZdIxTLUKipU6xSWIMM5JWmmgh+Mc4El
         xckJigqr9dfpNk9u7OrWBZR4jvtBzq3bCZpQ5PHZu6Ji4kYsclH1J2042teM8Jduid
         qCZvM7MBGfYqA4IKj+QiO6CXF9fC9Pohsb8LkKJuiWVMHmjmJliYJF39axpkMBAUbg
         iKbEauYrK5Opw==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Like Xu <likexu@tencent.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.15: 2nd batch
Date:   Mon, 27 Sep 2021 15:50:26 -0300
Message-Id: <20210927185026.389135-1-acme@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo


The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.15-2021-09-27

for you to fetch changes up to 4da8b121884d84476f3d50d46a471471af1aa9df:

  perf iostat: Fix Segmentation fault from NULL 'struct perf_counts_values *' (2021-09-27 09:41:07 -0300)

----------------------------------------------------------------
perf tools fixes for v5.15: 2nd batch

- Fix 'perf test' DWARF unwind for optimized builds.

- Fix 'perf test' 'Object code reading' when dealing with samples in @plt
  symbols.

- Fix off-by-one directory paths in the ARM support code.

- Fix error message to eliminate confusion in 'perf config' when first creating
  a config file.

- 'perf iostat' fix for system wide operation.

- Fix printing of metrics when 'perf iostat' is used with one or more
  iio_root_ports and unconnected cpus (using -C).

- Fix several typos in the documentation files.

- Fix spelling mistake "icach" -> "icache" in the power8 JSON vendor files.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Colin Ian King (1):
      perf vendor events powerpc: Fix spelling mistake "icach" -> "icache"

Ian Rogers (2):
      perf test: Fix DWARF unwind for optimized builds.
      perf arm: Fix off-by-one directory paths.

James Clark (1):
      perf tests: Fix flaky test 'Object code reading'

Like Xu (4):
      perf doc: Fix typos all over the place
      perf config: Refine error message to eliminate confusion
      perf iostat: Use system-wide mode if the target cpu_list is unspecified
      perf iostat: Fix Segmentation fault from NULL 'struct perf_counts_values *'

 tools/perf/Documentation/jitdump-specification.txt |  2 +-
 tools/perf/Documentation/perf-c2c.txt              |  2 +-
 tools/perf/Documentation/perf-intel-pt.txt         |  2 +-
 tools/perf/Documentation/perf-lock.txt             |  2 +-
 tools/perf/Documentation/perf-script-perl.txt      |  2 +-
 tools/perf/Documentation/perf-script-python.txt    |  2 +-
 tools/perf/Documentation/perf-stat.txt             |  2 +-
 tools/perf/Documentation/topdown.txt               |  2 +-
 tools/perf/arch/arm/util/auxtrace.c                |  8 ++---
 tools/perf/arch/arm/util/cs-etm.c                  | 24 ++++++-------
 tools/perf/arch/arm/util/perf_regs.c               |  2 +-
 tools/perf/arch/arm/util/pmu.c                     |  2 +-
 tools/perf/arch/arm/util/unwind-libdw.c            |  6 ++--
 tools/perf/arch/arm/util/unwind-libunwind.c        |  4 +--
 tools/perf/arch/x86/util/iostat.c                  |  2 +-
 tools/perf/builtin-stat.c                          |  2 ++
 .../perf/pmu-events/arch/powerpc/power8/other.json |  2 +-
 tools/perf/tests/code-reading.c                    |  4 +--
 tools/perf/tests/dwarf-unwind.c                    | 39 ++++++++++++++++++----
 tools/perf/util/config.c                           |  2 +-
 20 files changed, 70 insertions(+), 43 deletions(-)
