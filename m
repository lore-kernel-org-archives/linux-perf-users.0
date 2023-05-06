Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5014C77B75
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjEFV2O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFV2O (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 17:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5681155E;
        Sat,  6 May 2023 14:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8788E60F08;
        Sat,  6 May 2023 21:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49B5C433D2;
        Sat,  6 May 2023 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683408491;
        bh=RFhHQs458u3Qp1xbSCl1n0jO2N9ZgZ97gT8J33I1Nmg=;
        h=From:To:Cc:Subject:Date:From;
        b=AQtxcUktNQBisfpphnbxb4MoQtZFau70RrpVnPWa7onAXoTZK6Z+81oX5t/QkLxkm
         IGE613r6Gn0dG6J5GhRaIGFAeCuIrvNKy8xH2dOCW/E/EkkESFOyjVcgM9TGeMXafE
         RA09ZW5YyjyRZuUoJ8tbUiNmj9SHzE/ls64qMwaIyqSRMwSxv2vHayG78ExAn4IM6G
         UAjgvg08D2soxV2uh9ERk/OioqgsssGxGfoMDDLZXc9Q+2ZapxtMyY72upwM60FXNi
         6otnSVwYzVeVR7odlxwx0IRhykFZMBeFRHhmcUD59ZFzZzfvP1f3uf8dv9vb4Zmae1
         nEjDKaJG2DwrA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [GIT PULL 0/2] perf tools changes for v6.4: Disable BPF based features in the default build
Date:   Sat,  6 May 2023 18:27:58 -0300
Message-Id: <20230506212758.1201184-1-acme@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Linus,

	I did further tests and realised I made a mistake in trying to
make this the default now, we need to polish it further before this
becomes acceptable for a default build.

	This is on top of the previous two requests.

	I apologize for wasting your time,

- Arnaldo

The following changes since commit 6c73f819b6b6d6f052e8dbe3f66f0693554ddf48:

  perf metrics: Fix SEGV with --for-each-cgroup (2023-05-05 19:18:55 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-3-2023-05-06

for you to fetch changes up to 9a2d5178b9d51e1c5f9e08989ff97fc8d4893f31:

  Revert "perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL" (2023-05-06 18:07:37 -0300)

----------------------------------------------------------------
Disable building BPF based features by default for v6.4.

We need to better polish building with BPF skels, so revert back to
making it an experimental feature that has to be explicitely enabled
using BUILD_BPF_SKEL=1.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (2):
      Revert "perf build: Warn for BPF skeletons if endian mismatches"
      Revert "perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL"

 tools/perf/Makefile.config              | 14 +++-----------
 tools/perf/Makefile.perf                |  8 ++++----
 tools/perf/builtin-lock.c               |  2 +-
 tools/perf/builtin-record.c             |  2 +-
 tools/perf/builtin-version.c            |  1 -
 tools/perf/tests/shell/record_offcpu.sh |  2 +-
 6 files changed, 10 insertions(+), 19 deletions(-)
