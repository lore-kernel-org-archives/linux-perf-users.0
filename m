Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAA1FA3740
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Oct 2022 11:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJYLHP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Oct 2022 07:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJYLHN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Oct 2022 07:07:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A3E188AAE
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Oct 2022 04:07:12 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxTYD4w8jzVhys;
        Tue, 25 Oct 2022 19:02:24 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:07:10 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        <linux-perf-users@vger.kernel.org>
CC:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <liuqi6124@gmail.com>, <jonathan.cameron@huawei.com>,
        <alexander.shishkin@linux.intel.com>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH 2/2] perf auxtrace: Make auxtrace->flush_events() optional
Date:   Tue, 25 Oct 2022 19:06:34 +0800
Message-ID: <20221025110634.45405-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221025110634.45405-1-yangyicong@huawei.com>
References: <20221025110634.45405-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

The auxtrace->flush_events() is optional to some PMUs like hisi-ptt and
s390-cpumsf and they only define an empty callback. Make it optional and
handled by auxtrace framework.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/util/auxtrace.c    | 2 +-
 tools/perf/util/auxtrace.h    | 2 +-
 tools/perf/util/hisi-ptt.c    | 7 -------
 tools/perf/util/s390-cpumsf.c | 7 -------
 4 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 60d8beb662aa..c90c733e3d56 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2819,7 +2819,7 @@ void auxtrace__dump_auxtrace_sample(struct perf_session *session,
 
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool)
 {
-	if (!session->auxtrace)
+	if (!session->auxtrace || !session->auxtrace->flush_events)
 		return 0;
 
 	return session->auxtrace->flush_events(session, tool);
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6a0f9b98f059..1cb409892633 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -194,7 +194,7 @@ struct auxtrace_index {
  * @queue_data: queue an AUX sample or PERF_RECORD_AUXTRACE event for later
  *              processing
  * @dump_auxtrace_sample: dump AUX area sample data
- * @flush_events: process any remaining data
+ * @flush_events: process any remaining data (optional)
  * @free_events: free resources associated with event processing
  * @free: free resources associated with the session
  */
diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index 45b614bb73bf..f69b120a8e52 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -124,12 +124,6 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
-static int hisi_ptt_flush(struct perf_session *session __maybe_unused,
-			  struct perf_tool *tool __maybe_unused)
-{
-	return 0;
-}
-
 static void hisi_ptt_free_events(struct perf_session *session __maybe_unused)
 {
 }
@@ -180,7 +174,6 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 
 	ptt->auxtrace.process_event = hisi_ptt_process_event;
 	ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
-	ptt->auxtrace.flush_events = hisi_ptt_flush;
 	ptt->auxtrace.free_events = hisi_ptt_free_events;
 	ptt->auxtrace.free = hisi_ptt_free;
 	ptt->auxtrace.evsel_is_auxtrace = hisi_ptt_evsel_is_auxtrace;
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index f3fdad28a852..d961033942c6 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1001,12 +1001,6 @@ static void s390_cpumsf_free_events(struct perf_session *session __maybe_unused)
 {
 }
 
-static int s390_cpumsf_flush(struct perf_session *session __maybe_unused,
-			     struct perf_tool *tool __maybe_unused)
-{
-	return 0;
-}
-
 static void s390_cpumsf_free_queues(struct perf_session *session)
 {
 	struct s390_cpumsf *sf = container_of(session->auxtrace,
@@ -1148,7 +1142,6 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 
 	sf->auxtrace.process_event = s390_cpumsf_process_event;
 	sf->auxtrace.process_auxtrace_event = s390_cpumsf_process_auxtrace_event;
-	sf->auxtrace.flush_events = s390_cpumsf_flush;
 	sf->auxtrace.free_events = s390_cpumsf_free_events;
 	sf->auxtrace.free = s390_cpumsf_free;
 	sf->auxtrace.evsel_is_auxtrace = s390_cpumsf_evsel_is_auxtrace;
-- 
2.24.0

