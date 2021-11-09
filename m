Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F0FC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9059F61104
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 14:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhKIOZC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 09:25:02 -0500
Received: from foss.arm.com ([217.140.110.172]:34372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237582AbhKIOZA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 09:25:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14442101E;
        Tue,  9 Nov 2021 06:22:14 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 702D93F800;
        Tue,  9 Nov 2021 06:22:11 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: [PATCH v2 1/2] perf cs-etm: Print size using consistent format
Date:   Tue,  9 Nov 2021 14:21:52 +0000
Message-Id: <20211109142153.56546-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109142153.56546-1-german.gomez@arm.com>
References: <20211109142153.56546-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Andrew Kilroy <andrew.kilroy@arm.com>

Since the size is already printed earlier in hex, print the same data
using the same format, in hex.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f323adb1a..4f672f7d0 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -537,7 +537,7 @@ static void cs_etm__dump_event(struct cs_etm_queue *etmq,
 
 	fprintf(stdout, "\n");
 	color_fprintf(stdout, color,
-		     ". ... CoreSight %s Trace data: size %zu bytes\n",
+		     ". ... CoreSight %s Trace data: size %#zx bytes\n",
 		     cs_etm_decoder__get_name(etmq->decoder), buffer->size);
 
 	do {
-- 
2.25.1

