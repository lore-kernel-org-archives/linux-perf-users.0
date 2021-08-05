Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8E0C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 12:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CA260720
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 12:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbhHEM5n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 08:57:43 -0400
Received: from foss.arm.com ([217.140.110.172]:44926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241557AbhHEM5n (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Aug 2021 08:57:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 134F411FB;
        Thu,  5 Aug 2021 05:57:29 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3F4D3F719;
        Thu,  5 Aug 2021 05:57:26 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] perf cs-etm: Add warnings for missing DSOs
Date:   Thu,  5 Aug 2021 13:56:34 +0100
Message-Id: <20210805125634.873368-2-james.clark@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210805125634.873368-1-james.clark@arm.com>
References: <20210805125634.873368-1-james.clark@arm.com>
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
 tools/perf/util/cs-etm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f4b2bff533f3..b59d234e437d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -716,8 +716,17 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 
 	len = dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
 
-	if (len <= 0)
+	if (len <= 0) {
+		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' or debuginfod to export data from the traced system.\n"
+				 "              Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols.\n");
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
2.23.0

