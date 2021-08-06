Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF02C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8D26113C
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbhHFNmI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:42:08 -0400
Received: from foss.arm.com ([217.140.110.172]:33164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344186AbhHFNmH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 09:42:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B75B631B;
        Fri,  6 Aug 2021 06:41:51 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E31843F40C;
        Fri,  6 Aug 2021 06:41:48 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org
Cc:     acme@kernel.org, suzuki.poulose@arm.com,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic number
Date:   Fri,  6 Aug 2021 14:41:09 +0100
Message-Id: <20210806134109.1182235-10-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210806134109.1182235-1-james.clark@arm.com>
References: <20210806134109.1182235-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently perf reports "Cannot allocate memory" which isn't very helpful
for a potentially user facing issue. If we add a new magic number in
the future, perf will be able to report unrecognised magic numbers.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 788ad5a099f6..5b276bdb96a6 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2973,6 +2973,11 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 			/* ETE shares first part of metadata with ETMv4 */
 			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
+		} else {
+			ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". File could be from a newer version of perf.\n",
+				  ptr[i]);
+			err = -EINVAL;
+			goto err_free_metadata;
 		}
 
 		if (!metadata[j]) {
-- 
2.28.0

