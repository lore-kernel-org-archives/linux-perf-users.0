From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/22] perf map: Ditch leftover map__reloc_vmlinux() prototype
Date: Thu, 28 Nov 2019 10:40:07 -0300
Message-ID: <20191128134027.23726-3-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In 39b12f781271 ("perf tools: Make it possible to read object code from vmlinux")
the actual function was removed, but we forgot to remove the prototype,
fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-35yy50cgpcx8cjorluwd5j53@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 1f110b53b5f3..c0dffa9ecfe3 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -144,8 +144,6 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
 void map__fixup_start(struct map *map);
 void map__fixup_end(struct map *map);
 
-void map__reloc_vmlinux(struct map *map);
-
 int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 				    u64 addr);
 
-- 
2.21.0
