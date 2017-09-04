From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/13] perf tools: Support new sample type for physical address
Date: Mon,  4 Sep 2017 11:00:38 -0300
Message-ID: <20170904140044.22912-8-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753628AbdIDOFC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2017 10:05:02 -0400
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Kan Liang <kan.liang@intel.com>

Support new sample type PERF_SAMPLE_PHYS_ADDR for physical address.

Add new option --phys-data to record sample physical address.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Tested-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Stephane Eranian <eranian@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1504026672-7304-2-git-send-email-kan.liang@intel.com
[ Added missing printing in evsel.c patch sent by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h    |  4 +++-
 tools/perf/Documentation/perf-record.txt |  5 ++++-
 tools/perf/builtin-record.c              |  2 ++
 tools/perf/perf.h                        |  1 +
 tools/perf/util/event.h                  |  1 +
 tools/perf/util/evsel.c                  | 19 ++++++++++++++++++-
 6 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 2a37ae925d85..140ae638cfd6 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -139,8 +139,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_IDENTIFIER			= 1U << 16,
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
+	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 
-	PERF_SAMPLE_MAX = 1U << 19,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
 };
 
 /*
@@ -814,6 +815,7 @@ enum perf_event_type {
 	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
+	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 9bdea047c5db..e397453e5a46 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -249,7 +249,10 @@ OPTIONS
 
 -d::
 --data::
-	Record the sample addresses.
+	Record the sample virtual addresses.
+
+--phys-data::
+	Record the sample physical addresses.
 
 -T::
 --timestamp::
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 36d7117a7562..56f8142ff97f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1604,6 +1604,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN('s', "stat", &record.opts.inherit_stat,
 		    "per thread counts"),
 	OPT_BOOLEAN('d', "data", &record.opts.sample_address, "Record the sample addresses"),
+	OPT_BOOLEAN(0, "phys-data", &record.opts.sample_phys_addr,
+		    "Record the sample physical addresses"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 2c010dd6a79d..dc442ba21bf6 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -43,6 +43,7 @@ struct record_opts {
 	bool	     no_samples;
 	bool	     raw_samples;
 	bool	     sample_address;
+	bool	     sample_phys_addr;
 	bool	     sample_weight;
 	bool	     sample_time;
 	bool	     sample_time_set;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 423ac82605f3..ee7bcc898d35 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -200,6 +200,7 @@ struct perf_sample {
 	u32 cpu;
 	u32 raw_size;
 	u64 data_src;
+	u64 phys_addr;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d9bd632ed7db..4bb89373eb52 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -955,6 +955,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	if (opts->sample_address)
 		perf_evsel__set_sample_bit(evsel, DATA_SRC);
 
+	if (opts->sample_phys_addr)
+		perf_evsel__set_sample_bit(evsel, PHYS_ADDR);
+
 	if (opts->no_buffering) {
 		attr->watermark = 0;
 		attr->wakeup_events = 1;
@@ -1464,7 +1467,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(PERIOD), bit_name(STREAM_ID), bit_name(RAW),
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
-		bit_name(WEIGHT),
+		bit_name(WEIGHT), bit_name(PHYS_ADDR),
 		{ .name = NULL, }
 	};
 #undef bit_name
@@ -2206,6 +2209,12 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		}
 	}
 
+	data->phys_addr = 0;
+	if (type & PERF_SAMPLE_PHYS_ADDR) {
+		data->phys_addr = *array;
+		array++;
+	}
+
 	return 0;
 }
 
@@ -2311,6 +2320,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		}
 	}
 
+	if (type & PERF_SAMPLE_PHYS_ADDR)
+		result += sizeof(u64);
+
 	return result;
 }
 
@@ -2500,6 +2512,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 		}
 	}
 
+	if (type & PERF_SAMPLE_PHYS_ADDR) {
+		*array = sample->phys_addr;
+		array++;
+	}
+
 	return 0;
 }
 
-- 
2.13.5
