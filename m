Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E2EC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 10:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE34A6120A
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 10:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhKEKoV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 06:44:21 -0400
Received: from foss.arm.com ([217.140.110.172]:58128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhKEKoU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 06:44:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57B811042;
        Fri,  5 Nov 2021 03:41:41 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81E943F7B4;
        Fri,  5 Nov 2021 03:41:39 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] perf arm-spe: Inject SPE samples in perf-inject
Date:   Fri,  5 Nov 2021 10:41:30 +0000
Message-Id: <20211105104130.28186-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211105104130.28186-1-german.gomez@arm.com>
References: <20211105104130.28186-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Inject synthesized SPE samples during perf-inject run.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/arm-spe.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 58b7069c5..7054f2315 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -51,6 +51,7 @@ struct arm_spe {
 	u8				timeless_decoding;
 	u8				data_queued;
 
+	u64				sample_type;
 	u8				sample_flc;
 	u8				sample_llc;
 	u8				sample_tlb;
@@ -248,6 +249,12 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	event->sample.header.size = sizeof(struct perf_event_header);
 }
 
+static int arm_spe__inject_event(union perf_event *event, struct perf_sample *sample, u64 type)
+{
+	event->header.size = perf_event__sample_event_size(sample, type, 0);
+	return perf_event__synthesize_sample(event, type, 0, sample);
+}
+
 static inline int
 arm_spe_deliver_synth_event(struct arm_spe *spe,
 			    struct arm_spe_queue *speq __maybe_unused,
@@ -256,6 +263,12 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 {
 	int ret;
 
+	if (spe->synth_opts.inject) {
+		ret = arm_spe__inject_event(event, sample, spe->sample_type);
+		if (ret)
+			return ret;
+	}
+
 	ret = perf_session__deliver_synth_event(spe->session, event, sample);
 	if (ret)
 		pr_err("ARM SPE: failed to deliver event, error %d\n", ret);
@@ -920,6 +933,8 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	else
 		attr.sample_type |= PERF_SAMPLE_TIME;
 
+	spe->sample_type = attr.sample_type;
+
 	attr.exclude_user = evsel->core.attr.exclude_user;
 	attr.exclude_kernel = evsel->core.attr.exclude_kernel;
 	attr.exclude_hv = evsel->core.attr.exclude_hv;
-- 
2.25.1

