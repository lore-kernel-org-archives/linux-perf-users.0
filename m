From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/22] perf map: Remove needless struct forward declarations
Date: Thu, 28 Nov 2019 10:40:08 -0300
Message-ID: <20191128134027.23726-4-acme@kernel.org>
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

At some point we may have needed that, not anymore.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hnao13231bsl7xml5wn8h4iu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c0dffa9ecfe3..aafaea22737c 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -12,11 +12,8 @@
 #include <linux/types.h>
 
 struct dso;
-struct ip_callchain;
-struct ref_reloc_sym;
 struct map_groups;
 struct machine;
-struct evsel;
 
 struct map {
 	union {
-- 
2.21.0
