Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A0BEB64D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 16:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjFZQLL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFZQLK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 12:11:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE3601B7;
        Mon, 26 Jun 2023 09:11:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 730552F4;
        Mon, 26 Jun 2023 09:11:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E144F3F663;
        Mon, 26 Jun 2023 09:11:05 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] perf cs-etm: Track exception level fixups
Date:   Mon, 26 Jun 2023 17:10:56 +0100
Message-Id: <20230626161059.324046-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A couple of changes related to edge cases since commit 8d3031d39fe8
("perf cs-etm: Track exception level").

I think the second one is low risk seeing as any path requiring a thread
leading up to adding to the histogram would already have been crashing.
Maybe the thread check could also be added to hist_entry_iter__add()
although other users of it don't seem to have the same issue, and there
is another use of al.thread above in builtin-report.c so it's probably
ok where I've added it.

Applies to perf-tools-next/perf-tools-next (929ff679b69)

James Clark (2):
  perf cs-etm: Handle per-thread mode on EL1 host kernel case
  perf report: Don't add to histogram when there is no thread found

 tools/perf/builtin-report.c |  3 +++
 tools/perf/util/cs-etm.c    | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)


base-commit: 929ff679b694f0f9656aec38b3a7d5c440c5ca24
-- 
2.34.1

