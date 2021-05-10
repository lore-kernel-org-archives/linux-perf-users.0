Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1A0C433B4
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 14:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5D261483
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 14:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhEJOff (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 May 2021 10:35:35 -0400
Received: from foss.arm.com ([217.140.110.172]:59766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhEJOd7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 May 2021 10:33:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 282EC31B;
        Mon, 10 May 2021 07:32:54 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.83.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B37163F719;
        Mon, 10 May 2021 07:32:49 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        acme@kernel.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] perf cs-etm: Set time on synthesised samples to preserve ordering
Date:   Mon, 10 May 2021 17:32:46 +0300
Message-Id: <20210510143248.27423-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v2:
  * Collect acked and reviewed-by tags from v1 that were
    missed in v2
  * Add comment and commit message suggestions from Suzuki
  * Rebase onto next-20210510 (also applies to perf/core)

Thanks
James


James Clark (2):
  perf cs-etm: Refactor timestamp variable names
  perf cs-etm: Set time on synthesised samples to preserve ordering

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++---
 tools/perf/util/cs-etm.c                      | 57 +++++++++++--------
 tools/perf/util/cs-etm.h                      |  4 +-
 3 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.28.0

