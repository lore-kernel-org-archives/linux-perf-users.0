From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 47/63] perf symbols: Remove needless checks for map->groups->machine
Date: Thu,  7 Nov 2019 15:59:55 -0300
Message-ID: <20191107190011.23924-48-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its sufficient to check if map->groups is NULL before using it to get
->machine value.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-utiepyiv8b1tf8f79ok9d6j8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a4bd61cbc2a0..4ad39cc6368d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1617,7 +1617,7 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	if (map->groups && map->groups->machine)
+	if (map->groups)
 		machine = map->groups->machine;
 	else
 		machine = NULL;
-- 
2.21.0
