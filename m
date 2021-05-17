Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14B2C433B4
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 May 2021 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9EC0610E9
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 May 2021 13:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhEQNTQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 May 2021 09:19:16 -0400
Received: from foss.arm.com ([217.140.110.172]:51154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235337AbhEQNTQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 May 2021 09:19:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C9BF13D5;
        Mon, 17 May 2021 06:17:59 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.3.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B050D3F73B;
        Mon, 17 May 2021 06:17:56 -0700 (PDT)
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
Subject: [PATCH v3 1/3] perf cs-etm: Move synth_opts initialisation
Date:   Mon, 17 May 2021 16:17:39 +0300
Message-Id: <20210517131741.3027-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210517131741.3027-1-james.clark@arm.com>
References: <20210517131741.3027-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move initialisation of synth_opts earlier in the function
so that synth_opts can be used at an earlier stage in a
later commit.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 153fb8393e6e..a752fe06f170 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2819,6 +2819,14 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_free_etm;
 
+	if (session->itrace_synth_opts->set) {
+		etm->synth_opts = *session->itrace_synth_opts;
+	} else {
+		itrace_synth_opts__set_default(&etm->synth_opts,
+				session->itrace_synth_opts->default_no_sample);
+		etm->synth_opts.callchain = false;
+	}
+
 	etm->session = session;
 	etm->machine = &session->machines.host;
 
@@ -2863,14 +2871,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		return 0;
 	}
 
-	if (session->itrace_synth_opts->set) {
-		etm->synth_opts = *session->itrace_synth_opts;
-	} else {
-		itrace_synth_opts__set_default(&etm->synth_opts,
-				session->itrace_synth_opts->default_no_sample);
-		etm->synth_opts.callchain = false;
-	}
-
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.28.0

