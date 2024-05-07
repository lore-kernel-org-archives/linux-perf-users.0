Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DE16EBE8
	for <linux-perf-users@vger.kernel.org>; Tue,  7 May 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106980; cv=none; b=WLjj9SnJPugbAhhi3C/digrirpgAua5dmFaEMRbg3pWrs8UySeEb6QodBmvjcskxVeU1f2awH7TM69MtnYc4cmwqxzcBWfSJrX30brEjPo6sDyGxAh9SOnkhE3Z4GV+b4Imu4AzGGqWmh1OrYW5BLqAJReG2BvLQHXJaaZIT1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106980; c=relaxed/simple;
	bh=gZJmDVMTmoK2/QwHo8/MRghD8LhtGoTrMfNAgjzgumw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=azk7WT/0gFfXaoynF3E/oQwmwVVE0twIodQp9FqQQ0B6dRFYNaQyaxbz/fHKr1jOz1lW9bWy+767cCL6Swqaw970zFkdkGJ2Vwxpmw+DnQpmAKgJczfcObPXSKPZpsU0g3L8uPlnDl7ee2YkBhf7PqxwGckbO0gTWNa96mvx9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjIRpbSd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjIRpbSd"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c1f7169so596617b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106978; x=1715711778; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mOLkDwQHg5DuUlszkofmEYevyYYNPUsj80iyE8YhBY=;
        b=NjIRpbSdR1s11QSCZ9OR03EPePUlWkLg0qSyMW/kzGzQQHLsXfiIc9xQt/aqopPf9Y
         A0oxZtYEaT2+O9wPAMua2pBZ5xm7FqlZ8S1Hy442wc2uJ8d9CgKB3DJdx6SaCfSs5Mhh
         sMrWXBod5CjnbcvVCczh3m56zxD4U7qAZ1d5/99OIX2JNtGGipDQa8yUXhtUUgTx2J5j
         o6Enc8PjMX6zFi7ilCbv4BVioao1c6oVHe8gBqgSadt+UMpA0mK0m9/Z0VbrsiV6Vksz
         ct+tvIgYsAM5JYG7aJ8ADqPNBovx5BIIqsmjrg8g09zZQo3mjUCci9EJimpC6ODlMTva
         lHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106978; x=1715711778;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mOLkDwQHg5DuUlszkofmEYevyYYNPUsj80iyE8YhBY=;
        b=ZFn+THbwlf8W/amK6ZfwSA51rJw6GByMvWh073pNdL2FKaDi11kIZrouCkCAgU4l91
         cdewIO/kzLIPuEdsdhnZbosVhL3qGdf8Nl2aTCCeXOzIfWxD5bh4XnZagsGQ1Vmla3xK
         GZj0nYXZ923YaVBJXRq5FL8SB1sfBQORVQC9pgH8TSNxNoj2aB0yVmVzRRHuT+tVDFUO
         EfxbMK5dumG24sJYHBkZCVok4ZCKXExzbTymmUb8x5NjLfW13J8Rl04aeMvQbxcXClJ4
         63DKUa9PWiiJr/CZ0U0niwudfEiIBXLTROVN2mfSgqsaFeJtTIyR2zUel/MtDkU5trYd
         HYUA==
X-Forwarded-Encrypted: i=1; AJvYcCWACkpFQ71ayX424jRCfaCtVi8poH3w5Yz06h2EsQjZ6LvWmBGITz2Za6XuV+9d1pgEmgY6c6l85ViYJsjwyWkO7u6D/1UV20rlOV7k9SxV7w==
X-Gm-Message-State: AOJu0Ywf5FKETUzeAYsmSU1P9qEu8MSJIYLySL18lRkVZ+OH8S6+X+Te
	jZ2k5QXXh06NVRpPyrBiroIfne1ipAdHAkJjtCLlGUToWCa4EwZHsAlrd6YbKx2AGIOTquN3x4l
	njDt88Q==
X-Google-Smtp-Source: AGHT+IF7k6jfETAJRSfgXlCZKlwdpqG4TxcA438HTqYJw87OxWXq9iQeEZvbcppPqSViLuxdyxbo/HFfOGBt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a81:d203:0:b0:618:2ad1:a46f with SMTP id
 00721157ae682-62076555c52mr8613587b3.2.1715106977741; Tue, 07 May 2024
 11:36:17 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:43 -0700
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>
Message-Id: <20240507183545.1236093-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 6/8] perf mem-info: Move mem-info out of mem-events and symbol
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move mem-info to its own header rather than having it split between
mem-events and symbol.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c                      |  1 +
 tools/perf/builtin-report.c                   |  1 +
 tools/perf/builtin-script.c                   |  1 +
 tools/perf/tests/mem.c                        |  1 +
 tools/perf/util/Build                         |  1 +
 tools/perf/util/hist.c                        |  1 +
 tools/perf/util/machine.c                     |  1 +
 tools/perf/util/mem-events.c                  | 16 +++++-----
 tools/perf/util/mem-events.h                  | 29 +++++++------------
 tools/perf/util/mem-info.c                    | 28 ++++++++++++++++++
 tools/perf/util/mem-info.h                    | 28 ++++++++++++++++++
 .../scripting-engines/trace-event-python.c    |  1 +
 tools/perf/util/sort.c                        |  1 +
 tools/perf/util/symbol.c                      | 26 +----------------
 tools/perf/util/symbol.h                      | 12 --------
 15 files changed, 85 insertions(+), 63 deletions(-)
 create mode 100644 tools/perf/util/mem-info.c
 create mode 100644 tools/perf/util/mem-info.h

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 1f1d17df9b9a..c624414b2285 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -38,6 +38,7 @@
 #include "ui/browsers/hists.h"
 #include "thread.h"
 #include "mem2node.h"
+#include "mem-info.h"
 #include "symbol.h"
 #include "ui/ui.h"
 #include "ui/progress.h"
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b5525f4f7090..6eb1d90b589f 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -31,6 +31,7 @@
 #include "util/evsel.h"
 #include "util/evswitch.h"
 #include "util/header.h"
+#include "util/mem-info.h"
 #include "util/session.h"
 #include "util/srcline.h"
 #include "util/tool.h"
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f7c3c3868c3c..58af4f3aa592 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -32,6 +32,7 @@
 #include "util/time-utils.h"
 #include "util/path.h"
 #include "util/event.h"
+#include "util/mem-info.h"
 #include "ui/ui.h"
 #include "print_binary.h"
 #include "print_insn.h"
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
index 56014ec7d49d..f694a60d8a73 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/map_symbol.h"
 #include "util/mem-events.h"
+#include "util/mem-info.h"
 #include "util/symbol.h"
 #include "linux/perf_event.h"
 #include "util/debug.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 292170a99ab6..da64efd8718f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -141,6 +141,7 @@ perf-y += term.o
 perf-y += help-unknown-cmd.o
 perf-y += dlfilter.o
 perf-y += mem-events.o
+perf-y += mem-info.o
 perf-y += vsprintf.o
 perf-y += units.o
 perf-y += time-utils.o
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b8a508cd0b14..56453a02cdf4 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -9,6 +9,7 @@
 #include "map_symbol.h"
 #include "branch.h"
 #include "mem-events.h"
+#include "mem-info.h"
 #include "session.h"
 #include "namespaces.h"
 #include "cgroup.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a3ff2ab154bd..d5a01ef92668 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -16,6 +16,7 @@
 #include "map_symbol.h"
 #include "branch.h"
 #include "mem-events.h"
+#include "mem-info.h"
 #include "path.h"
 #include "srcline.h"
 #include "symbol.h"
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 637cbd4a7bfb..f618a5ccc7af 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -10,7 +10,9 @@
 #include <linux/kernel.h>
 #include "map_symbol.h"
 #include "mem-events.h"
+#include "mem-info.h"
 #include "debug.h"
+#include "evsel.h"
 #include "symbol.h"
 #include "pmu.h"
 #include "pmus.h"
@@ -281,7 +283,7 @@ static const char * const tlb_access[] = {
 	"Fault",
 };
 
-int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+int perf_mem__tlb_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
 	size_t l = 0, i;
 	u64 m = PERF_MEM_TLB_NA;
@@ -359,7 +361,7 @@ static const char * const mem_hops[] = {
 	"board",
 };
 
-static int perf_mem__op_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+static int perf_mem__op_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
 	u64 op = PERF_MEM_LOCK_NA;
 	int l;
@@ -383,7 +385,7 @@ static int perf_mem__op_scnprintf(char *out, size_t sz, struct mem_info *mem_inf
 	return l;
 }
 
-int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
 	union perf_mem_data_src data_src;
 	int printed = 0;
@@ -465,7 +467,7 @@ static const char * const snoopx_access[] = {
 	"Peer",
 };
 
-int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+int perf_mem__snp_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
 	size_t i, l = 0;
 	u64 m = PERF_MEM_SNOOP_NA;
@@ -507,7 +509,7 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	return l;
 }
 
-int perf_mem__lck_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+int perf_mem__lck_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
 	u64 mask = PERF_MEM_LOCK_NA;
 	int l;
@@ -525,7 +527,7 @@ int perf_mem__lck_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	return l;
 }
 
-int perf_mem__blk_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
 	size_t l = 0;
 	u64 mask = PERF_MEM_BLK_NA;
@@ -548,7 +550,7 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	return l;
 }
 
-int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
 	int i = 0;
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 15d5f0320d27..ca31014d7934 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -3,13 +3,7 @@
 #define __PERF_MEM_EVENTS_H
 
 #include <stdbool.h>
-#include <stdint.h>
-#include <stdio.h>
 #include <linux/types.h>
-#include <linux/refcount.h>
-#include <linux/perf_event.h>
-#include "stat.h"
-#include "evsel.h"
 
 struct perf_mem_event {
 	bool		record;
@@ -21,13 +15,6 @@ struct perf_mem_event {
 	const char	*event_name;
 };
 
-struct mem_info {
-	struct addr_map_symbol	iaddr;
-	struct addr_map_symbol	daddr;
-	union perf_mem_data_src	data_src;
-	refcount_t		refcnt;
-};
-
 enum {
 	PERF_MEM_EVENTS__LOAD,
 	PERF_MEM_EVENTS__STORE,
@@ -35,6 +22,10 @@ enum {
 	PERF_MEM_EVENTS__MAX,
 };
 
+struct evsel;
+struct mem_info;
+struct perf_pmu;
+
 extern unsigned int perf_mem_events__loads_ldlat;
 extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
 
@@ -49,13 +40,13 @@ bool is_mem_loads_aux_event(struct evsel *leader);
 void perf_pmu__mem_events_list(struct perf_pmu *pmu);
 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr);
 
-int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
-int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
-int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
-int perf_mem__lck_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
-int perf_mem__blk_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
+int perf_mem__tlb_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
+int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
+int perf_mem__snp_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
+int perf_mem__lck_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
+int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
 
-int perf_script__meminfo_scnprintf(char *bf, size_t size, struct mem_info *mem_info);
+int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct mem_info *mem_info);
 
 struct c2c_stats {
 	u32	nr_entries;
diff --git a/tools/perf/util/mem-info.c b/tools/perf/util/mem-info.c
new file mode 100644
index 000000000000..ff0dfdb5369a
--- /dev/null
+++ b/tools/perf/util/mem-info.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/zalloc.h>
+#include "mem-info.h"
+
+struct mem_info *mem_info__get(struct mem_info *mi)
+{
+	if (mi)
+		refcount_inc(&mi->refcnt);
+	return mi;
+}
+
+void mem_info__put(struct mem_info *mi)
+{
+	if (mi && refcount_dec_and_test(&mi->refcnt)) {
+		addr_map_symbol__exit(&mi->iaddr);
+		addr_map_symbol__exit(&mi->daddr);
+		free(mi);
+	}
+}
+
+struct mem_info *mem_info__new(void)
+{
+	struct mem_info *mi = zalloc(sizeof(*mi));
+
+	if (mi)
+		refcount_set(&mi->refcnt, 1);
+	return mi;
+}
diff --git a/tools/perf/util/mem-info.h b/tools/perf/util/mem-info.h
new file mode 100644
index 000000000000..bb7d8375d73c
--- /dev/null
+++ b/tools/perf/util/mem-info.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_MEM_INFO_H
+#define __PERF_MEM_INFO_H
+
+#include <linux/refcount.h>
+#include <linux/perf_event.h>
+#include "map_symbol.h"
+
+struct mem_info {
+	struct addr_map_symbol	iaddr;
+	struct addr_map_symbol	daddr;
+	union perf_mem_data_src	data_src;
+	refcount_t		refcnt;
+};
+
+struct mem_info *mem_info__new(void);
+struct mem_info *mem_info__get(struct mem_info *mi);
+void   mem_info__put(struct mem_info *mi);
+
+static inline void __mem_info__zput(struct mem_info **mi)
+{
+	mem_info__put(*mi);
+	*mi = NULL;
+}
+
+#define mem_info__zput(mi) __mem_info__zput(&mi)
+
+#endif /* __PERF_MEM_INFO_H */
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c2caa5720299..c77fe08a0545 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -45,6 +45,7 @@
 #include "../thread.h"
 #include "../comm.h"
 #include "../machine.h"
+#include "../mem-info.h"
 #include "../db-export.h"
 #include "../thread-stack.h"
 #include "../trace-event.h"
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 704664e5b4ea..711ef69306f3 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -23,6 +23,7 @@
 #include "strlist.h"
 #include "strbuf.h"
 #include "mem-events.h"
+#include "mem-info.h"
 #include "annotate.h"
 #include "annotate-data.h"
 #include "event.h"
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7772a4d3e66c..eb3319baa1b5 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -27,6 +27,7 @@
 #include "symbol.h"
 #include "map_symbol.h"
 #include "mem-events.h"
+#include "mem-info.h"
 #include "symsrc.h"
 #include "strlist.h"
 #include "intlist.h"
@@ -2570,31 +2571,6 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 	return 0;
 }
 
-struct mem_info *mem_info__get(struct mem_info *mi)
-{
-	if (mi)
-		refcount_inc(&mi->refcnt);
-	return mi;
-}
-
-void mem_info__put(struct mem_info *mi)
-{
-	if (mi && refcount_dec_and_test(&mi->refcnt)) {
-		addr_map_symbol__exit(&mi->iaddr);
-		addr_map_symbol__exit(&mi->daddr);
-		free(mi);
-	}
-}
-
-struct mem_info *mem_info__new(void)
-{
-	struct mem_info *mi = zalloc(sizeof(*mi));
-
-	if (mi)
-		refcount_set(&mi->refcnt, 1);
-	return mi;
-}
-
 /*
  * Checks that user supplied symbol kernel files are accessible because
  * the default mechanism for accessing elf files fails silently. i.e. if
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 071837ddce2a..3fb5d146d9b1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -268,18 +268,6 @@ enum {
 	SDT_NOTE_IDX_REFCTR,
 };
 
-struct mem_info *mem_info__new(void);
-struct mem_info *mem_info__get(struct mem_info *mi);
-void   mem_info__put(struct mem_info *mi);
-
-static inline void __mem_info__zput(struct mem_info **mi)
-{
-	mem_info__put(*mi);
-	*mi = NULL;
-}
-
-#define mem_info__zput(mi) __mem_info__zput(&mi)
-
 int symbol__validate_sym_arguments(void);
 
 #endif /* __PERF_SYMBOL */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

