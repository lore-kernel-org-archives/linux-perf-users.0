Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA8ECAAD1
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 17:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiHaRum (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiHaRuQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 13:50:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6BC1005
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 10:50:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33f8988daecso200849097b3.12
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=DV+gDUOPXsEDpKSEUMrteZ0JJtXsJvhmDLffo2hWpR8=;
        b=HBb+XvmRItArfa2t5gRHf8PcZ1GxONOZ475mZIhqV15S9MNKFUVIiybXVFMVncm9hy
         SamFWQCwqiU70VJ2JltGjOim0xPwkz80VlPOKbJAxiQ1WVYrNm6SXSGOJ4XQ6vHDEd/R
         po8Y0+m643ma3R85P6d41Ax67a11/2yjBmJuaVO/M6knVwv5motiuEctD+MzCmjkaDPO
         d1g+2EVSAsBC1KQ09LRFYCZ1K28n15tqvhg1nQbN2w+C5uyHSeG59ajSer2ytjROK8NY
         OyZ3oRgpsAyEZApj2PM4+z6L2nmCk1h3WxB1ApSxzcHd1AcV4p5bNnWSkV/V8eM9mqFW
         iC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=DV+gDUOPXsEDpKSEUMrteZ0JJtXsJvhmDLffo2hWpR8=;
        b=09+sF7h1vWx82VfowX6oSwnQZZGXSy1u8fDy0aLvk9wdAv9qHlRHxX+5anTPtUk0xG
         wld8mqWc3U4R+selOCNfxDbGn1webMUJRgRHBnthAO30vzAfRHvGyzIQtVNyfl4IO0N0
         MpRQYAh0BItpgoq/xuTLWJs6MYJnkLCledhqU+FgpclEYfVBXCsO0ZyoCtNKgz9Y+OOb
         xRWUHOWv851q+PdlZIfR5rpItHgER4R4gODE0Zs1ksLqJIjf6QNrpZ01fbbQMEEEuJjV
         l7y3dpbyDUBbeU0R3Fe00ZgcFw2jyvnqvOIrdXzqaXlB41Hy5tpCbz8/e772LIpCs9PY
         Aywg==
X-Gm-Message-State: ACgBeo0nTvSPAMOwj4IiBD7Xnl/DKyfqGosZM42xMtMLOo+CA17fydF6
        KIhd1DBUn3k/6COxWRxTPO5vEh28UAE3
X-Google-Smtp-Source: AA6agR7KHG0Q/Eku109go1TslC6JmYdAv6tQ1sws4sdXYpB85CQ5uLYs8ghrj+5NvhzsJTTbeRyiDeP2FiMq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8e4:a3e5:9d09:d3d4])
 (user=irogers job=sendgmr) by 2002:a25:cf8b:0:b0:695:79fa:14c2 with SMTP id
 f133-20020a25cf8b000000b0069579fa14c2mr16824533ybg.636.1661968213868; Wed, 31
 Aug 2022 10:50:13 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:23 -0700
In-Reply-To: <20220831174926.579643-1-irogers@google.com>
Message-Id: <20220831174926.579643-5-irogers@google.com>
Mime-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2 4/7] perf topology: Add core_wide
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It is possible to optimize metrics when all SMT threads (CPUs) on a
core are measuring events in system wide mode. For example, TMA
metrics defines CORE_CLKS for Sandybrdige as:

if SMT is disabled:
  CPU_CLK_UNHALTED.THREAD
if SMT is enabled and recording on all SMT threads:
  CPU_CLK_UNHALTED.THREAD_ANY / 2
if SMT is enabled and not recording on all SMT threads:
  (CPU_CLK_UNHALTED.THREAD/2)*
  (1+CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE/CPU_CLK_UNHALTED.REF_XCLK )

That is two more events are necessary when not gathering counts on all
SMT threads. To distinguish all SMT threads on a core vs system wide
(all CPUs) call the new property core wide.  Add a core wide test that
determines the property from user requested CPUs, the topology and
system wide. System wide is required as other processes running on a
SMT thread will change the counts.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cputopo.c | 46 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h |  3 +++
 tools/perf/util/smt.c     | 14 ++++++++++++
 tools/perf/util/smt.h     |  7 ++++++
 4 files changed, 70 insertions(+)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 511002e52714..1a3ff6449158 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -172,6 +172,52 @@ bool cpu_topology__smt_on(const struct cpu_topology *topology)
 	return false;
 }
 
+bool cpu_topology__core_wide(const struct cpu_topology *topology,
+			     const char *user_requested_cpu_list)
+{
+	struct perf_cpu_map *user_requested_cpus;
+
+	/*
+	 * If user_requested_cpu_list is empty then all CPUs are recorded and so
+	 * core_wide is true.
+	 */
+	if (!user_requested_cpu_list)
+		return true;
+
+	user_requested_cpus = perf_cpu_map__new(user_requested_cpu_list);
+	/* Check that every user requested CPU is the complete set of SMT threads on a core. */
+	for (u32 i = 0; i < topology->core_cpus_lists; i++) {
+		const char *core_cpu_list = topology->core_cpus_list[i];
+		struct perf_cpu_map *core_cpus = perf_cpu_map__new(core_cpu_list);
+		struct perf_cpu cpu;
+		int idx;
+		bool has_first, first = true;
+
+		perf_cpu_map__for_each_cpu(cpu, idx, core_cpus) {
+			if (first) {
+				has_first = perf_cpu_map__has(user_requested_cpus, cpu);
+				first = false;
+			} else {
+				/*
+				 * If the first core CPU is user requested then
+				 * all subsequent CPUs in the core must be user
+				 * requested too. If the first CPU isn't user
+				 * requested then none of the others must be
+				 * too.
+				 */
+				if (perf_cpu_map__has(user_requested_cpus, cpu) != has_first) {
+					perf_cpu_map__put(core_cpus);
+					perf_cpu_map__put(user_requested_cpus);
+					return false;
+				}
+			}
+		}
+		perf_cpu_map__put(core_cpus);
+	}
+	perf_cpu_map__put(user_requested_cpus);
+	return true;
+}
+
 static bool has_die_topology(void)
 {
 	char filename[MAXPATHLEN];
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 469db775a13c..969e5920a00e 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -60,6 +60,9 @@ struct cpu_topology *cpu_topology__new(void);
 void cpu_topology__delete(struct cpu_topology *tp);
 /* Determine from the core list whether SMT was enabled. */
 bool cpu_topology__smt_on(const struct cpu_topology *topology);
+/* Are the sets of SMT siblings all enabled or all disabled in user_requested_cpus. */
+bool cpu_topology__core_wide(const struct cpu_topology *topology,
+			     const char *user_requested_cpu_list);
 
 struct numa_topology *numa_topology__new(void);
 void numa_topology__delete(struct numa_topology *tp);
diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index ce90c4ee4138..994e9e418227 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -21,3 +21,17 @@ bool smt_on(const struct cpu_topology *topology)
 	cached = true;
 	return cached_result;
 }
+
+bool core_wide(bool system_wide, const char *user_requested_cpu_list,
+	       const struct cpu_topology *topology)
+{
+	/* If not everything running on a core is being recorded then we can't use core_wide. */
+	if (!system_wide)
+		return false;
+
+	/* Cheap case that SMT is disabled and therefore we're inherently core_wide. */
+	if (!smt_on(topology))
+		return true;
+
+	return cpu_topology__core_wide(topology, user_requested_cpu_list);
+}
diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
index e26999c6b8d4..ae9095f2c38c 100644
--- a/tools/perf/util/smt.h
+++ b/tools/perf/util/smt.h
@@ -7,4 +7,11 @@ struct cpu_topology;
 /* Returns true if SMT (aka hyperthreading) is enabled. */
 bool smt_on(const struct cpu_topology *topology);
 
+/*
+ * Returns true when system wide and all SMT threads for a core are in the
+ * user_requested_cpus map.
+ */
+bool core_wide(bool system_wide, const char *user_requested_cpu_list,
+	       const struct cpu_topology *topology);
+
 #endif /* __SMT_H */
-- 
2.37.2.672.g94769d06f0-goog

