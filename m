Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF82C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E9860F42
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 16:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhG2QAV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:00:21 -0400
Received: from foss.arm.com ([217.140.110.172]:51442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238454AbhG2P7T (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 11:59:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A08911D4;
        Thu, 29 Jul 2021 08:59:04 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30FA73F73D;
        Thu, 29 Jul 2021 08:59:02 -0700 (PDT)
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
Subject: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
Date:   Thu, 29 Jul 2021 16:58:05 +0100
Message-Id: <20210729155805.2830-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210729155805.2830-1-james.clark@arm.com>
References: <20210729155805.2830-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently decode will silently fail if no binary data is available for
the decode. This is made worse if only partial data is available because
the decode will appear to work, but any trace from that missing DSO will
silently not be generated.

Add a UI popup once if there is any data missing, and then warn in the
bottom left for each individual DSO that's missing.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 32ad92d3e454..e6851260d059 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -746,8 +746,16 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 
 	len = dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
 
-	if (len <= 0)
+	if (len <= 0) {
+		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n");
+		if (!al.map->dso->auxtrace_warned) {
+			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
+				    address,
+				    al.map->dso->long_name ? al.map->dso->long_name : "Unknown");
+			al.map->dso->auxtrace_warned = true;
+		}
 		return 0;
+	}
 
 	return len;
 }
-- 
2.28.0

