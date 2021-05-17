Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0885C43460
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 May 2021 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8339961241
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 May 2021 13:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhEQNTM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 May 2021 09:19:12 -0400
Received: from foss.arm.com ([217.140.110.172]:51134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235337AbhEQNTM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 May 2021 09:19:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305F212FC;
        Mon, 17 May 2021 06:17:56 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.3.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49F3C3F73B;
        Mon, 17 May 2021 06:17:53 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] perf cs-etm: Handle valid-but-zero timestamps
Date:   Mon, 17 May 2021 16:17:38 +0300
Message-Id: <20210517131741.3027-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v2:

 * Fix typo in last commit message
 * Add reviewed-by tags from Leo Yan

This patchset applies on top of "[PATCH v3 0/2] perf cs-etm: Set
time on synthesised samples to preserve ordering"

James Clark (3):
  perf cs-etm: Move synth_opts initialisation
  perf cs-etm: Start reading 'Z' --itrace option
  perf cs-etm: Prevent and warn on underflows during timestamp
    calculation.

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 45 ++++++++++++++-----
 tools/perf/util/cs-etm.c                      | 20 +++++----
 2 files changed, 46 insertions(+), 19 deletions(-)

-- 
2.28.0

