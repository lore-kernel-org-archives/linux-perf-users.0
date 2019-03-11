From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v1 06/10] perf, tools, report: Print better message for JITed code
Date: Mon, 11 Mar 2019 13:24:42 -0700
Message-ID: <20190311202446.10210-7-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The message about missing /tmp/perf-* for JITed code is quite confusing
to users. Add a better error message, but only print it once.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/map.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fbeb0c6efaa6..d476b76abc6a 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -316,6 +316,15 @@ int map__load(struct map *map)
 
 	nr = dso__load(map->dso, map);
 	if (nr < 0) {
+		if (!strncmp(map->dso->name, "/tmp/perf-", 10)) {
+			static bool warned;
+			if (!warned) {
+				pr_err("Cannot find executable, JITed code present? May need agent.\n");
+				warned = true;
+			}
+			return -1;
+		}
+
 		if (map->dso->has_build_id) {
 			char sbuild_id[SBUILD_ID_SIZE];
 
-- 
2.20.1
