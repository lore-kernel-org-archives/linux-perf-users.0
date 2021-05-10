Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D53C43461
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 14:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29236145F
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 14:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhEJOfk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 May 2021 10:35:40 -0400
Received: from foss.arm.com ([217.140.110.172]:59804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239110AbhEJOeJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 May 2021 10:34:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F4E71691;
        Mon, 10 May 2021 07:33:04 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.83.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF3063F719;
        Mon, 10 May 2021 07:32:59 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        acme@kernel.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] perf cs-etm: Set time on synthesised samples to preserve ordering
Date:   Mon, 10 May 2021 17:32:48 +0300
Message-Id: <20210510143248.27423-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210510143248.27423-1-james.clark@arm.com>
References: <20210510143248.27423-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The following attribute is set when synthesising samples in
timed decoding mode:

    attr.sample_type |= PERF_SAMPLE_TIME;

This results in new samples that appear to have timestamps but
because we don't assign any timestamps to the samples, when the
resulting inject file is opened again, the synthesised samples
will be on the wrong side of the MMAP or COMM events.

For example, this results in the samples being associated with
the perf binary, rather than the target of the record:

    perf record -e cs_etm/@tmc_etr0/u top
    perf inject -i perf.data -o perf.inject --itrace=i100il
    perf report -i perf.inject

Where 'Command' == perf should show as 'top':

    # Overhead  Command  Source Shared Object  Source Symbol           Target Symbol           Basic Block Cycles
    # ........  .......  ....................  ......................  ......................  ..................
    #
        31.08%  perf     [unknown]             [.] 0x000000000040c3f8  [.] 0x000000000040c3e8  -

If the perf.data file is opened directly with perf, without the
inject step, then this already works correctly because the
events are synthesised after the COMM and MMAP events and
no second sorting happens. Re-sorting only happens when opening
the perf.inject file for the second time so timestamps are
needed.

Using the timestamp from the AUX record mirrors the current
behaviour when opening directly with perf, because the events
are generated on the call to cs_etm__process_queues().

The ETM trace could optionally contain time stamps, but there is
no way to correlate this with the kernel time. So, the best available
time value is that of the AUX_RECORD header. This patch uses
the timestamp from the header for all the samples. The ordering of the
samples are implicit in the trace and thus is fine with respect to
relative ordering.

Acked-by: Suzuki K Poulos <suzuki.poulose@arm.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Co-developed-by: Al Grant <al.grant@arm.com>
Signed-off-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 533f6f2f0685..153fb8393e6e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -54,6 +54,7 @@ struct cs_etm_auxtrace {
 	u8 sample_instructions;
 
 	int num_cpu;
+	u64 latest_kernel_timestamp;
 	u32 auxtrace_type;
 	u64 branches_sample_type;
 	u64 branches_id;
@@ -1192,6 +1193,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
+	if (!etm->timeless_decoding)
+		sample.time = etm->latest_kernel_timestamp;
 	sample.ip = addr;
 	sample.pid = tidq->pid;
 	sample.tid = tidq->tid;
@@ -1248,6 +1251,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
+	if (!etm->timeless_decoding)
+		sample.time = etm->latest_kernel_timestamp;
 	sample.ip = ip;
 	sample.pid = tidq->pid;
 	sample.tid = tidq->tid;
@@ -2412,9 +2417,15 @@ static int cs_etm__process_event(struct perf_session *session,
 	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		return cs_etm__process_switch_cpu_wide(etm, event);
 
-	if (!etm->timeless_decoding &&
-	    event->header.type == PERF_RECORD_AUX)
+	if (!etm->timeless_decoding && event->header.type == PERF_RECORD_AUX) {
+		/*
+		 * Record the latest kernel timestamp available in the header
+		 * for samples so that synthesised samples occur from this point
+		 * onwards.
+		 */
+		etm->latest_kernel_timestamp = sample_kernel_timestamp;
 		return cs_etm__process_queues(etm);
+	}
 
 	return 0;
 }
-- 
2.28.0

