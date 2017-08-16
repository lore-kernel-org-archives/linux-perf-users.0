From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/10] perf scripts python: Fix missing call_path_id in export-to-postgresql script
Date: Wed, 16 Aug 2017 17:20:44 -0300
Message-ID: <20170816202050.8865-5-acme@kernel.org>
References: <20170816202050.8865-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816202050.8865-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The export does not work if only branches are exported because of a
missing column in the samples table.  Fix by adding the missing
call_path_id.

Fixes: 3521f3bc9dae ("perf script: Update export-to-postgresql to support callchain export")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/1501749090-20357-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 7656ff8aa066..f57811443beb 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -340,7 +340,8 @@ if branches:
 		'to_sym_offset	bigint,'
 		'to_ip		bigint,'
 		'branch_type	integer,'
-		'in_tx		boolean)')
+		'in_tx		boolean,'
+		'call_path_id	bigint)')
 else:
 	do_query(query, 'CREATE TABLE samples ('
 		'id		bigint		NOT NULL,'
-- 
2.13.5
