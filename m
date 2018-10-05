From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/5] perf script python: Fix export-to-sqlite.py sample columns
Date: Fri,  5 Oct 2018 13:10:09 -0300
Message-ID: <20181005161012.18475-3-acme@kernel.org>
References: <20181005161012.18475-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005161012.18475-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

With the "branches" export option, not all sample columns are exported.
However the unwanted columns are not at the end of the tuple, as assumed
by the code. Fix by taking the first 15 and last 3 values, instead of
the first 18.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180911114504.28516-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index f827bf77e9d2..e4bb82c8aba9 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -440,7 +440,11 @@ def branch_type_table(*x):
 
 def sample_table(*x):
 	if branches:
-		bind_exec(sample_query, 18, x)
+		for xx in x[0:15]:
+			sample_query.addBindValue(str(xx))
+		for xx in x[19:22]:
+			sample_query.addBindValue(str(xx))
+		do_query_(sample_query)
 	else:
 		bind_exec(sample_query, 22, x)
 
-- 
2.14.4
