Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027CFC433B4
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 May 2021 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA93B610E9
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 May 2021 13:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbhEQNTU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 May 2021 09:19:20 -0400
Received: from foss.arm.com ([217.140.110.172]:51182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237326AbhEQNTT (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 May 2021 09:19:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFE0A139F;
        Mon, 17 May 2021 06:18:02 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.3.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 132943F73B;
        Mon, 17 May 2021 06:17:59 -0700 (PDT)
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
Subject: [PATCH v3 2/3] perf cs-etm: Start reading 'Z' --itrace option
Date:   Mon, 17 May 2021 16:17:40 +0300
Message-Id: <20210517131741.3027-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210517131741.3027-1-james.clark@arm.com>
References: <20210517131741.3027-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Recently the 'Z' --itrace option was added to override detection
of timeless decoding. This is also useful in Coresight to work around
issues with invalid timestamps on some hardware.

When the 'Z' option is provided, the existing timeless decoding mode
will be used, even if timestamps were recorded.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a752fe06f170..64536a6ed10a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2473,6 +2473,10 @@ static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
 	struct evlist *evlist = etm->session->evlist;
 	bool timeless_decoding = true;
 
+	/* Override timeless mode with user input from --itrace=Z */
+	if (etm->synth_opts.timeless_decoding)
+		return true;
+
 	/*
 	 * Circle through the list of event and complain if we find one
 	 * with the time bit set.
-- 
2.28.0

