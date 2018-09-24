From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/27] perf db-export: Add trace begin / end branch type variants
Date: Mon, 24 Sep 2018 12:02:37 -0300
Message-ID: <20180924150242.14235-23-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add branch types to cover different combinations with "trace begin" or
"trace end".

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a
trace ends with a call. Before remedying that, prepare the database
export to export branch types with more combinations that include trace
begin / end.  In those cases extend the descriptions to include 'trace
begin' and 'trace end' separately.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 7123746edcf4..69fbb0a72d0c 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -463,6 +463,28 @@ int db_export__branch_types(struct db_export *dbe)
 		if (err)
 			break;
 	}
+
+	/* Add trace begin / end variants */
+	for (i = 0; branch_types[i].name ; i++) {
+		const char *name = branch_types[i].name;
+		u32 type = branch_types[i].branch_type;
+		char buf[64];
+
+		if (type == PERF_IP_FLAG_BRANCH ||
+		    (type & (PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END)))
+			continue;
+
+		snprintf(buf, sizeof(buf), "trace begin / %s", name);
+		err = db_export__branch_type(dbe, type | PERF_IP_FLAG_TRACE_BEGIN, buf);
+		if (err)
+			break;
+
+		snprintf(buf, sizeof(buf), "%s / trace end", name);
+		err = db_export__branch_type(dbe, type | PERF_IP_FLAG_TRACE_END, buf);
+		if (err)
+			break;
+	}
+
 	return err;
 }
 
-- 
2.14.4
