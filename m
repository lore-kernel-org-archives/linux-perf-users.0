Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB5C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Oct 2022 09:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJRJly (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJRJlw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2022 05:41:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0610DAE872;
        Tue, 18 Oct 2022 02:41:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D30113E;
        Tue, 18 Oct 2022 02:41:57 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9EF903F7D8;
        Tue, 18 Oct 2022 02:41:48 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2 0/2] perf: Fix "kernel lock contention analysis" test by not printing warnings in quiet mode
Date:   Tue, 18 Oct 2022 10:41:34 +0100
Message-Id: <20221018094137.783081-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is V2, but the previous patch was titled 'perf: Fix "Track with
sched_switch" test by not printing warnings in quiet mode'

Changes since V1:

  * Add a commit to make the behavior consistent between tools and
    update the docs
  * Fix the incorrect test name in the commit message

James Clark (2):
  perf: Fix "kernel lock contention analysis" test by not printing
    warnings in quiet mode
  perf: Make quiet mode consistent between tools

 tools/perf/Documentation/perf-annotate.txt | 2 +-
 tools/perf/Documentation/perf-diff.txt     | 2 +-
 tools/perf/Documentation/perf-lock.txt     | 2 +-
 tools/perf/Documentation/perf-probe.txt    | 2 +-
 tools/perf/Documentation/perf-record.txt   | 2 +-
 tools/perf/Documentation/perf-report.txt   | 2 +-
 tools/perf/Documentation/perf-stat.txt     | 4 ++--
 tools/perf/bench/numa.c                    | 9 +++++----
 tools/perf/builtin-annotate.c              | 2 +-
 tools/perf/builtin-diff.c                  | 2 +-
 tools/perf/builtin-lock.c                  | 2 +-
 tools/perf/builtin-probe.c                 | 7 +++----
 tools/perf/builtin-record.c                | 2 +-
 tools/perf/builtin-report.c                | 2 +-
 tools/perf/builtin-stat.c                  | 8 ++++----
 tools/perf/ui/util.c                       | 5 +++++
 tools/perf/util/stat.h                     | 1 -
 17 files changed, 30 insertions(+), 26 deletions(-)

-- 
2.28.0

