Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EABEC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1B261373
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhKQOcE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:32:04 -0500
Received: from foss.arm.com ([217.140.110.172]:57818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235127AbhKQOcE (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 09:32:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 914751FB;
        Wed, 17 Nov 2021 06:29:05 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 635BC3F70D;
        Wed, 17 Nov 2021 06:29:03 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH 1/1] perf arm-spe: report all SPE records as "all" events
Date:   Wed, 17 Nov 2021 14:28:32 +0000
Message-Id: <20211117142833.226629-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: James Clark <james.clark@arm.com>

Currently perf-report and perf-inject are dropping a large number of SPE
records because they don't contain any of the existing events, but the
contextual information of the records is still useful to keep.

The synthesized event "all" is generated for every SPE record that is
processed, regardless of whether the record contains interesting events
or not. The event can be filtered with the flag "--itrace=o".

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/Documentation/itrace.txt |  2 +-
 tools/perf/util/arm-spe.c           | 36 +++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h          |  2 +-
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index c52755481..57dc12b83 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -6,7 +6,7 @@
 		w	synthesize ptwrite events
 		p	synthesize power events (incl. PSB events for Intel PT)
 		o	synthesize other events recorded due to the use
-			of aux-output (refer to perf record)
+			of aux-output (refer to perf record) (all events for Arm SPE)
 		e	synthesize error events
 		d	create a debug log
 		f	synthesize first level cache events
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index ce77abf90..6428351db 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -58,6 +58,7 @@ struct arm_spe {
 	u8				sample_branch;
 	u8				sample_remote_access;
 	u8				sample_memory;
+	u8				sample_other;
 
 	u64				l1d_miss_id;
 	u64				l1d_access_id;
@@ -68,6 +69,7 @@ struct arm_spe {
 	u64				branch_miss_id;
 	u64				remote_access_id;
 	u64				memory_id;
+	u64				all_id;
 
 	u64				kernel_start;
 
@@ -351,6 +353,23 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
+static int arm_spe__synth_other_sample(struct arm_spe_queue *speq,
+				       u64 spe_events_id)
+{
+	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record = &speq->decoder->record;
+	union perf_event *event = speq->event_buf;
+	struct perf_sample sample = { .ip = 0, };
+
+	arm_spe_prep_sample(spe, speq, event, &sample);
+
+	sample.id = spe_events_id;
+	sample.stream_id = spe_events_id;
+	sample.addr = record->to_ip;
+
+	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
+}
+
 #define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
 			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
 			 ARM_SPE_REMOTE_ACCESS)
@@ -480,6 +499,12 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 			return err;
 	}
 
+	if (spe->sample_other) {
+		err = arm_spe__synth_other_sample(speq, spe->all_id);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -1107,6 +1132,17 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 			return err;
 		spe->memory_id = id;
 		arm_spe_set_event_name(evlist, id, "memory");
+		id += 1;
+	}
+
+	if (spe->synth_opts.other_events) {
+		spe->sample_other = true;
+
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->all_id = id;
+		arm_spe_set_event_name(evlist, id, "all");
 	}
 
 	return 0;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index bbf0d78c6..efe1bdc06 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -74,7 +74,7 @@ enum itrace_period_type {
  * @ptwrites: whether to synthesize events for ptwrites
  * @pwr_events: whether to synthesize power events
  * @other_events: whether to synthesize other events recorded due to the use of
- *                aux_output
+ *                aux_output (all events for Arm SPE)
  * @errors: whether to synthesize decoder error events
  * @dont_decode: whether to skip decoding entirely
  * @log: write a decoding log
-- 
2.25.1

