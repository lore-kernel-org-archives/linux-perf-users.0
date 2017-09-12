From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/9] perf config: Check not only section->from_system_config but also item's
Date: Tue, 12 Sep 2017 16:24:36 -0300
Message-ID: <20170912192438.1334-8-acme@kernel.org>
References: <20170912192438.1334-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912192438.1334-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

Currently section->from_system_config is being checked multiple times.
item->from_system_config should be checked instead, when iterating thru
the items in a section. Fix it.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1504754325-9724-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 3ddcc6e2abeb..a1d82e33282c 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -59,7 +59,7 @@ static int set_config(struct perf_config_set *set, const char *file_name,
 		fprintf(fp, "[%s]\n", section->name);
 
 		perf_config_items__for_each_entry(&section->items, item) {
-			if (!use_system_config && section->from_system_config)
+			if (!use_system_config && item->from_system_config)
 				continue;
 			if (item->value)
 				fprintf(fp, "\t%s = %s\n",
-- 
2.13.5
