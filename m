Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1ECC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D966162E
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhKKNjh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 08:39:37 -0500
Received: from foss.arm.com ([217.140.110.172]:39882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232203AbhKKNjf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 08:39:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2039F13A1;
        Thu, 11 Nov 2021 05:36:46 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DFFD3F70D;
        Thu, 11 Nov 2021 05:36:43 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Namhyung Kim <namhyung@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] perf arm-spe: Track task context switch for cpu-mode events
Date:   Thu, 11 Nov 2021 13:36:22 +0000
Message-Id: <20211111133625.193568-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211111133625.193568-1-german.gomez@arm.com>
References: <20211111133625.193568-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

When perf report synthesize events from ARM SPE data, it refers to
current cpu, pid and tid in the machine.  But there's no place to set
them in the ARM SPE decoder.  I'm seeing all pid/tid is set to -1 and
user symbols are not resolved in the output.

  # perf record -a -e arm_spe_0/ts_enable=1/ sleep 1

  # perf report -q | head
     8.77%     8.77%  :-1      [kernel.kallsyms]  [k] format_decode
     7.02%     7.02%  :-1      [kernel.kallsyms]  [k] seq_printf
     7.02%     7.02%  :-1      [unknown]          [.] 0x0000ffff9f687c34
     5.26%     5.26%  :-1      [kernel.kallsyms]  [k] vsnprintf
     3.51%     3.51%  :-1      [kernel.kallsyms]  [k] string
     3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f66ae20
     3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f670b3c
     3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f67c040
     1.75%     1.75%  :-1      [kernel.kallsyms]  [k] ___cache_free
     1.75%     1.75%  :-1      [kernel.kallsyms]  [k]
__count_memcg_events

Like Intel PT, add context switch records to track task info.  As ARM
SPE support was added later than PERF_RECORD_SWITCH_CPU_WIDE, I think
we can safely set the attr.context_switch bit and use it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: German Gomez <german.gomez@arm.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c |  6 +++++-
 tools/perf/util/arm-spe.c            | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index a4420d4df..58ba8d15c 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -166,8 +166,12 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	tracking_evsel->core.attr.sample_period = 1;
 
 	/* In per-cpu case, always need the time of mmap events etc */
-	if (!perf_cpu_map__empty(cpus))
+	if (!perf_cpu_map__empty(cpus)) {
 		evsel__set_sample_bit(tracking_evsel, TIME);
+		evsel__set_sample_bit(tracking_evsel, CPU);
+		/* also track task context switch */
+		tracking_evsel->core.attr.context_switch = 1;
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 58b7069c5..230bc7ab2 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -681,6 +681,25 @@ static int arm_spe_process_timeless_queues(struct arm_spe *spe, pid_t tid,
 	return 0;
 }
 
+static int arm_spe_context_switch(struct arm_spe *spe, union perf_event *event,
+				  struct perf_sample *sample)
+{
+	pid_t pid, tid;
+	int cpu;
+
+	if (!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT))
+		return 0;
+
+	pid = event->context_switch.next_prev_pid;
+	tid = event->context_switch.next_prev_tid;
+	cpu = sample->cpu;
+
+	if (tid == -1)
+		pr_warning("context_switch event has no tid\n");
+
+	return machine__set_current_tid(spe->machine, cpu, pid, tid);
+}
+
 static int arm_spe_process_event(struct perf_session *session,
 				 union perf_event *event,
 				 struct perf_sample *sample,
@@ -718,6 +737,12 @@ static int arm_spe_process_event(struct perf_session *session,
 		}
 	} else if (timestamp) {
 		err = arm_spe_process_queues(spe, timestamp);
+		if (err)
+			return err;
+
+		if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
+		    event->header.type == PERF_RECORD_SWITCH)
+			err = arm_spe_context_switch(spe, event, sample);
 	}
 
 	return err;
-- 
2.25.1

