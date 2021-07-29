Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F584C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCBA60F5C
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 16:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbhG2QAW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:00:22 -0400
Received: from foss.arm.com ([217.140.110.172]:51444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238455AbhG2P7T (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 11:59:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4530E113E;
        Thu, 29 Jul 2021 08:59:01 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0EB63F73D;
        Thu, 29 Jul 2021 08:58:58 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Cc:     leo.yan@linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 5/6] perf cs-etm: Improve Coresight zero timestamp warning
Date:   Thu, 29 Jul 2021 16:58:04 +0100
Message-Id: <20210729155805.2830-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210729155805.2830-1-james.clark@arm.com>
References: <20210729155805.2830-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Only show the warning if the user hasn't already set timeless mode and
improve the text because there was ambiguity around the meaning of '...'

Change the warning to a UI warning instead of printing straight to
stderr because this corrupts the UI when perf report TUI is used. The UI
warning function also handles printing to stderr when in perf script
mode.

Suggested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3e1a05bc82cc..5084bd2ca6eb 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -324,8 +324,11 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 		 * underflow.
 		 */
 		packet_queue->cs_timestamp = 0;
-		WARN_ONCE(true, "Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
-				". Decoding may be improved with --itrace=Z...\n", indx);
+		if (!cs_etm__etmq_is_timeless(etmq))
+			pr_warning_once("Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
+					". Decoding may be improved by prepending 'Z' to your current --itrace arguments.\n",
+					indx);
+
 	} else if (packet_queue->instr_count > elem->timestamp) {
 		/*
 		 * Sanity check that the elem->timestamp - packet_queue->instr_count would not
-- 
2.28.0

