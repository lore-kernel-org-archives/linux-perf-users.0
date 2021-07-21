Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1118FC636CE
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E151B61287
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbhGUOWi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:22:38 -0400
Received: from foss.arm.com ([217.140.110.172]:56922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239517AbhGUOVs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 10:21:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F4A012FC;
        Wed, 21 Jul 2021 08:02:23 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.39.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E07363F73D;
        Wed, 21 Jul 2021 08:02:20 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.org, al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] perf cs-etm: Suppress printing when resetting decoder
Date:   Wed, 21 Jul 2021 16:02:00 +0100
Message-Id: <20210721150202.32065-5-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721150202.32065-1-james.clark@arm.com>
References: <20210721150202.32065-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The decoder is quite noisy when being reset. In a future commit,
dump-raw-trace will use a code path that resets the decoder rather than
creating a new one, so printing has to be suppressed to not flood the
output.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3e1a05bc82cc..ed1f0326f859 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -35,6 +35,7 @@
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
+	bool suppress_printing;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
@@ -74,9 +75,10 @@ int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
 	ocsd_datapath_resp_t dp_ret;
 
 	decoder->prev_return = OCSD_RESP_CONT;
-
+	decoder->suppress_printing = true;
 	dp_ret = ocsd_dt_process_data(decoder->dcd_tree, OCSD_OP_RESET,
 				      0, 0, NULL, NULL);
+	decoder->suppress_printing = false;
 	if (OCSD_DATA_RESP_IS_FATAL(dp_ret))
 		return -1;
 
@@ -146,8 +148,10 @@ static void cs_etm_decoder__print_str_cb(const void *p_context,
 					 const char *msg,
 					 const int str_len)
 {
-	if (p_context && str_len)
-		((struct cs_etm_decoder *)p_context)->packet_printer(msg);
+	const struct cs_etm_decoder *decoder = p_context;
+
+	if (p_context && str_len && !decoder->suppress_printing)
+		decoder->packet_printer(msg);
 }
 
 static int
-- 
2.28.0

