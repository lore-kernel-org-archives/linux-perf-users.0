Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB5C433ED
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 10:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BF9610CE
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 10:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhDPK5G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 06:57:06 -0400
Received: from foss.arm.com ([217.140.110.172]:38740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDPK5F (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Apr 2021 06:57:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72ADB106F;
        Fri, 16 Apr 2021 03:56:40 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB6ED3F85F;
        Fri, 16 Apr 2021 03:56:37 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        acme@kernel.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, James Clark <james.clark@arm.com>,
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
Subject: [PATCH v2 0/2] perf cs-etm: Set time on synthesised samples to preserve ordering
Date:   Fri, 16 Apr 2021 13:56:30 +0300
Message-Id: <20210416105632.8771-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v1:
 * Improved variable name from etm_timestamp -> cs_timestamp
 * Fixed ordering of Signed-off-by

James Clark (2):
  perf cs-etm: Refactor timestamp variable names
  perf cs-etm: Set time on synthesised samples to preserve ordering

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++----
 tools/perf/util/cs-etm.c                      | 52 ++++++++++---------
 tools/perf/util/cs-etm.h                      |  4 +-
 3 files changed, 39 insertions(+), 35 deletions(-)

-- 
2.28.0

