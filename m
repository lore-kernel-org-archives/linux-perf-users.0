From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 47/83] perf tools: Document some missing perf.data headers
Date: Fri, 17 Nov 2017 17:15:25 -0300
Message-ID: <20171117201601.24110-48-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758724AbdKQUSv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:51 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Andi Kleen <ak@linux.intel.com>

Document STAT and CACHE header entries.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171109145528.23371-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index e90c59c6d815..15e8b48077ba 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -238,6 +238,29 @@ struct auxtrace_index {
 	struct auxtrace_index_entry entries[PERF_AUXTRACE_INDEX_ENTRY_COUNT];
 };
 
+	HEADER_STAT = 19,
+
+This is merely a flag signifying that the data section contains data
+recorded from perf stat record.
+
+	HEADER_CACHE = 20,
+
+Description of the cache hierarchy. Based on the Linux sysfs format
+in /sys/devices/system/cpu/cpu*/cache/
+
+	u32 version	Currently always 1
+	u32 number_of_cache_levels
+
+struct {
+	u32	level;
+	u32	line_size;
+	u32	sets;
+	u32	ways;
+	struct perf_header_string type;
+	struct perf_header_string size;
+	struct perf_header_string map;
+}[number_of_cache_levels];
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
-- 
2.13.6
