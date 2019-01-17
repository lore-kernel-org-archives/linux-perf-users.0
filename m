From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
Date: Thu, 17 Jan 2019 10:30:01 +0100
Message-ID: <20190117093003.96287-2-tmricht@linux.ibm.com>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117093003.96287-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On s390 the event bc000 (also named CF_DIAG)
extracts the CPU Measurement Facility diagnostic counter sets
and displays them as counter number and counter value
pairs sorted by counter set number.

Output:
 [root@s35lp76 perf]# ./perf report -D --stdio

 [00000000] Counterset:0 Counters:6
   Counter:000 Value:0x000000000085ec36 Counter:001 Value:0x0000000000796c94
   Counter:002 Value:0x0000000000005ada Counter:003 Value:0x0000000000092460
   Counter:004 Value:0x0000000000006073 Counter:005 Value:0x00000000001a9a73
 [0x000038] Counterset:1 Counters:2
   Counter:000 Value:0x000000000007c59f Counter:001 Value:0x000000000002fad6
 [0x000050] Counterset:2 Counters:16
   Counter:000 Value:000000000000000000 Counter:001 Value:000000000000000000
   Counter:002 Value:000000000000000000 Counter:003 Value:000000000000000000
   Counter:004 Value:000000000000000000 Counter:005 Value:000000000000000000
   Counter:006 Value:000000000000000000 Counter:007 Value:000000000000000000
   Counter:008 Value:000000000000000000 Counter:009 Value:000000000000000000
   Counter:010 Value:000000000000000000 Counter:011 Value:000000000000000000
   Counter:012 Value:000000000000000000 Counter:013 Value:000000000000000000
   Counter:014 Value:000000000000000000 Counter:015 Value:000000000000000000
 [0x0000d8] Counterset:3 Counters:128
   Counter:000 Value:0x000000000000020f Counter:001 Value:0x00000000000001d8
   Counter:002 Value:0x000000000000d7fa Counter:003 Value:0x000000000000008b
   ...

The number in brackets is the offset into the raw data field
of the sample.

New functions trace_event_sample_raw() and s390_sample_raw() are
introduced in the code path to enable interpretation on non s390
platforms. This event bc000 attached raw data is generated only
on s390 platform. Correct display on other platforms requires
correct endianness handling.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/util/Build                    |   2 +
 tools/perf/util/s390-cpumcf-kernel.h     |  62 +++++++++++
 tools/perf/util/s390-sample-raw.c        | 172 +++++++++++++++++++++++++++++++
 tools/perf/util/session.c                |   2 +
 tools/perf/util/session.h                |   5 +
 tools/perf/util/trace-event-sample-raw.c |  30 ++++++
 6 files changed, 273 insertions(+)
 create mode 100644 tools/perf/util/s390-cpumcf-kernel.h
 create mode 100644 tools/perf/util/s390-sample-raw.c
 create mode 100644 tools/perf/util/trace-event-sample-raw.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index af72be7f5b3b..d6a11099919c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -44,6 +44,8 @@ libperf-y += machine.o
 libperf-y += map.o
 libperf-y += pstack.o
 libperf-y += session.o
+libperf-y += trace-event-sample-raw.o
+libperf-y += s390-sample-raw.o
 libperf-$(CONFIG_TRACE) += syscalltbl.o
 libperf-y += ordered-events.o
 libperf-y += namespaces.o
diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
new file mode 100644
index 000000000000..d4356030b504
--- /dev/null
+++ b/tools/perf/util/s390-cpumcf-kernel.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Support for s390 CPU measurement counter set diagnostic facility
+ *
+ * Copyright IBM Corp. 2019
+   Author(s): Hendrik Brueckner <brueckner@linux.ibm.com>
+ *		Thomas Richter <tmricht@linux.ibm.com>
+ */
+#ifndef S390_CPUMCF_KERNEL_H
+#define S390_CPUMCF_KERNEL_H
+
+#define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
+#define	PERF_EVENT_CPUM_CF_DIAG	0xBC000	/* Event: Counter sets */
+
+struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
+	unsigned int def:16;	/* 0-15  Data Entry Format */
+	unsigned int set:16;	/* 16-23 Counter set identifier */
+	unsigned int ctr:16;	/* 24-39 Number of stored counters */
+	unsigned int res1:16;	/* 40-63 Reserved */
+};
+
+struct cf_trailer_entry {	/* CPU-M CF trailer for raw traces (64 byte) */
+	/* 0 - 7 */
+	union {
+		struct {
+			unsigned int clock_base:1;	/* TOD clock base */
+			unsigned int speed:1;		/* CPU speed */
+			/* Measurement alerts */
+			unsigned int mtda:1;	/* Loss of MT ctr. data alert */
+			unsigned int caca:1;	/* Counter auth. change alert */
+			unsigned int lcda:1;	/* Loss of counter data alert */
+		};
+		unsigned long flags;		/* 0-63    All indicators */
+	};
+	/* 8 - 15 */
+	unsigned int cfvn:16;			/* 64-79   Ctr First Version */
+	unsigned int csvn:16;			/* 80-95   Ctr Second Version */
+	unsigned int cpu_speed:32;		/* 96-127  CPU speed */
+	/* 16 - 23 */
+	unsigned long timestamp;		/* 128-191 Timestamp (TOD) */
+	/* 24 - 55 */
+	union {
+		struct {
+			unsigned long progusage1;
+			unsigned long progusage2;
+			unsigned long progusage3;
+			unsigned long tod_base;
+		};
+		unsigned long progusage[4];
+	};
+	/* 56 - 63 */
+	unsigned int mach_type:16;		/* Machine type */
+	unsigned int res1:16;			/* Reserved */
+	unsigned int res2:32;			/* Reserved */
+};
+
+#define	CPUMF_CTR_SET_BASIC	0	/* Basic Counter Set */
+#define	CPUMF_CTR_SET_USER	1	/* Problem-State Counter Set */
+#define	CPUMF_CTR_SET_CRYPTO	2	/* Crypto-Activity Counter Set */
+#define	CPUMF_CTR_SET_EXT	3	/* Extended Counter Set */
+#define	CPUMF_CTR_SET_MT_DIAG	4	/* MT-diagnostic Counter Set */
+#endif
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
new file mode 100644
index 000000000000..ae16c38ce296
--- /dev/null
+++ b/tools/perf/util/s390-sample-raw.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2019
+ * Author(s): Thomas Richter <tmricht@linux.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Architecture specific trace_event function. Save event's bc000 raw data
+ * to file. File name is aux.ctr.## where ## stands for the CPU number the
+ * sample was taken from.
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include <sys/stat.h>
+#include <asm/byteorder.h>
+
+#include "debug.h"
+#include "util.h"
+#include "auxtrace.h"
+#include "session.h"
+#include "evlist.h"
+#include "config.h"
+#include "color.h"
+#include "s390-cpumcf-kernel.h"
+
+static size_t ctrset_size(struct cf_ctrset_entry *set)
+{
+	return sizeof(*set) + set->ctr * sizeof(u64);
+}
+
+static bool ctrset_valid(struct cf_ctrset_entry *set)
+{
+	return set->def == S390_CPUMCF_DIAG_DEF;
+}
+
+/* CPU Measurement Counter Facility raw data is a byte stream. It is 8 byte
+ * aligned and might have trailing padding bytes.
+ * Display the raw data on screen.
+ */
+static bool s390_cpumcfdg_testctr(struct perf_sample *sample)
+{
+	size_t len = sample->raw_size, offset = 0;
+	unsigned char *buf = sample->raw_data;
+	struct cf_trailer_entry *te;
+	struct cf_ctrset_entry *cep, ce;
+
+	if (!len)
+		return false;
+	while (offset < len) {
+		cep = (struct cf_ctrset_entry *)(buf + offset);
+		ce.def = be16_to_cpu(cep->def);
+		ce.set = be16_to_cpu(cep->set);
+		ce.ctr = be16_to_cpu(cep->ctr);
+		ce.res1 = be16_to_cpu(cep->res1);
+
+		if (!ctrset_valid(&ce) || offset + ctrset_size(&ce) > len) {
+			/* Raw data for counter sets are always multiple of 8
+			 * bytes. Prepending a 4 bytes size field to the
+			 * raw data block in the sample causes the perf tool
+			 * to append 4 padding bytes to make the raw data part
+			 * of the sample a multiple of eight bytes again.
+			 *
+			 * If the last entry (trailer) is 4 bytes off the raw
+			 * area data end, all is good.
+			 */
+			if (len - offset - sizeof(*te) == 4)
+				break;
+			pr_err("Invalid counter set entry at %#"  PRIx64 "\n",
+			       offset);
+			return false;
+		}
+		offset += ctrset_size(&ce);
+	}
+	return true;
+}
+
+/* Dump event bc000 on screen, already tested on correctness. */
+static void s390_cpumcfdg_dumptrail(const char *color, size_t offset,
+				    struct cf_trailer_entry *tep)
+{
+	struct cf_trailer_entry  te;
+
+	te.flags = be64_to_cpu(tep->flags);
+	te.cfvn = be16_to_cpu(tep->cfvn);
+	te.csvn = be16_to_cpu(tep->csvn);
+	te.cpu_speed = be32_to_cpu(tep->cpu_speed);
+	te.timestamp = be64_to_cpu(tep->timestamp);
+	te.progusage1 = be64_to_cpu(tep->progusage1);
+	te.progusage2 = be64_to_cpu(tep->progusage2);
+	te.progusage3 = be64_to_cpu(tep->progusage3);
+	te.tod_base = be64_to_cpu(tep->tod_base);
+	te.mach_type = be16_to_cpu(tep->mach_type);
+	te.res1 = be16_to_cpu(tep->res1);
+	te.res2 = be32_to_cpu(tep->res2);
+
+	color_fprintf(stdout, color, "    [%#08zx] Trailer:%c%c%c%c%c"
+		      " Cfvn:%d Csvn:%d Speed:%d TOD:%#llx\n",
+		      offset, te.clock_base ? 'T' : ' ',
+		      te.speed ? 'S' : ' ', te.mtda ? 'M' : ' ',
+		      te.caca ? 'C' : ' ', te.lcda ? 'L' : ' ',
+		      te.cfvn, te.csvn, te.cpu_speed, te.timestamp);
+	color_fprintf(stdout, color, "\t\t1:%lx 2:%lx 3:%lx TOD-Base:%#llx"
+		      " Type:%x\n\n",
+		      te.progusage1, te.progusage2, te.progusage3,
+		      te.tod_base, te.mach_type);
+}
+
+static void s390_cpumcfdg_dump(struct perf_sample *sample)
+{
+	size_t i, len = sample->raw_size, offset = 0;
+	unsigned char *buf = sample->raw_data;
+	const char *color = PERF_COLOR_BLUE;
+	struct cf_ctrset_entry *cep, ce;
+	u64 *p;
+
+	while (offset < len) {
+		cep = (struct cf_ctrset_entry *)(buf + offset);
+
+		ce.def = be16_to_cpu(cep->def);
+		ce.set = be16_to_cpu(cep->set);
+		ce.ctr = be16_to_cpu(cep->ctr);
+		ce.res1 = be16_to_cpu(cep->res1);
+
+		if (!ctrset_valid(&ce)) {	/* Print trailer */
+			s390_cpumcfdg_dumptrail(color, offset,
+						(struct cf_trailer_entry *)cep);
+			return;
+		}
+
+		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
+			      " Counters:%d\n", offset, ce.set, ce.ctr);
+		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; i += 2, p += 2)
+			color_fprintf(stdout, color,
+				      "\tCounter:%03d Value:%#018lx"
+				      " Counter:%03d Value:%#018lx\n",
+				      i, be64_to_cpu(*p),
+				      i + 1, be64_to_cpu(*(p + 1)));
+		offset += ctrset_size(&ce);
+	}
+}
+
+/* S390 specific trace event function. Check for PERF_RECORD_SAMPLE events
+ * and if the event was triggered by a counter set diagnostic event display
+ * its raw data.
+ * The function is only invoked when the dump flag -D is set.
+ */
+void s390_sample_raw(struct perf_evlist *evlist, union perf_event *event,
+		     struct perf_sample *sample)
+{
+	struct perf_evsel *ev_bc000;
+
+	if (event->header.type != PERF_RECORD_SAMPLE)
+		return;
+
+	ev_bc000 = perf_evlist__event2evsel(evlist, event);
+	if (ev_bc000 == NULL ||
+	    ev_bc000->attr.config != PERF_EVENT_CPUM_CF_DIAG)
+		return;
+
+	/* Display raw data on screen */
+	if (!s390_cpumcfdg_testctr(sample)) {
+		pr_err("Invalid counter set data encountered\n");
+		return;
+	}
+	s390_cpumcfdg_dump(sample);
+}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5456c84c7dd1..f0c71c6f670a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1065,6 +1065,8 @@ static void dump_event(struct perf_evlist *evlist, union perf_event *event,
 	       file_offset, event->header.size, event->header.type);
 
 	trace_event(event);
+	if (event->header.type == PERF_RECORD_SAMPLE)
+		trace_event_sample_raw(evlist, event, sample);
 
 	if (sample)
 		perf_evlist__print_tstamp(evlist, event, sample);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index d96eccd7d27f..dbd7256c82f6 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -128,4 +128,9 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
 				    struct perf_evlist *evlist,
 				    struct machine *machine);
 
+void trace_event_sample_raw(struct perf_evlist *evlist __maybe_unused,
+			    union perf_event *event __maybe_unused,
+			    struct perf_sample *sample __maybe_unused);
+void s390_sample_raw(struct perf_evlist *evlist, union perf_event *event,
+		     struct perf_sample *sample);
 #endif /* __PERF_SESSION_H */
diff --git a/tools/perf/util/trace-event-sample-raw.c b/tools/perf/util/trace-event-sample-raw.c
new file mode 100644
index 000000000000..622471a02267
--- /dev/null
+++ b/tools/perf/util/trace-event-sample-raw.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2019
+ * Author(s): Thomas Richter <tmricht@linux.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Architecture specific trace_event function. Save event's bc000 raw data
+ * to file. File name is aux.ctr.## where ## stands for the CPU number the
+ * sample was taken from.
+ */
+
+#include <string.h>
+
+#include "session.h"
+#include "evlist.h"
+
+/* Check platform the perf data file was created on and perform platform
+ * specific interpretation.
+ */
+void trace_event_sample_raw(struct perf_evlist *evlist, union perf_event *event,
+			    struct perf_sample *sample)
+{
+	const char *arch_pf = perf_env__arch(evlist->env);
+
+	if (arch_pf && !strcmp("s390", arch_pf))
+		s390_sample_raw(evlist, event, sample);
+}
-- 
2.14.3
