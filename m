Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46063C49EA5
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 16:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CC7613D8
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 16:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhFXQpc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Jun 2021 12:45:32 -0400
Received: from foss.arm.com ([217.140.110.172]:33952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhFXQpb (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Jun 2021 12:45:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41003ED1;
        Thu, 24 Jun 2021 09:43:12 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.13.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A7203F719;
        Thu, 24 Jun 2021 09:43:09 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] perf cs-etm: Split Coresight decode by aux records
Date:   Thu, 24 Jun 2021 17:43:01 +0100
Message-Id: <20210624164303.28632-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Change applies to perf/core (45237f9898fc)

Changes since v6:
 * Fix for snapshot mode where buffers are wrapped. This fix was done by clamping the aux record
   size to the size of the buffer (see comment).
 * Added an extra debugging printout.
 * Typo/formatting fixes.
 * Add the change for --dump-raw-trace as a second commit. I planned to do this later, but have now
   finished it so I'll submit it at the same time.
 * Did some more thorough testing around the different snapshot scenarios.

Decoding snapshot files with duplicate data is improved by this patchset because of the reason
mentioned at the end of the testing section. Coincidentally, the same issue is also fixed in
"[PATCH v1 0/3] coresight: Fix for snapshot mode" but by not saving duplicates, rather than not
decoding them.

James Clark (2):
  perf cs-etm: Split Coresight decode by aux records
  perf cs-etm: Split --dump-raw-trace by AUX records

 tools/perf/util/cs-etm.c | 188 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 3 deletions(-)

-- 
2.28.0

