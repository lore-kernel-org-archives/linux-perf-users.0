From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/35] perf auxtrace: Improve address filter error message when there is no DSO
Date: Thu,  7 Mar 2019 14:44:04 -0300
Message-ID: <20190307174433.28819-7-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The message does not indicate the possibility that the symbol is not
found because the file does not exist.

Before:

  $ perf record -e intel_pt//u --filter 'filter strcmp / strcpy @ foo ' ls
  Symbol 'strcmp' not found.
  Note that symbols must be functions.
  Failed to parse address filter: 'filter strcmp / strcpy @ foo '
  Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
  Where multiple filters are separated by space or comma.

After:

  $ perf record -e intel_pt//u --filter 'filter strcmp / strcpy @ foo ' ls
  File 'foo' not found or has no symbols.
  Symbol 'strcmp' not found.
  Note that symbols must be functions.
  Failed to parse address filter: 'filter strcmp / strcpy @ foo '
  Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
  Where multiple filters are separated by space or comma.

Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-dvngzxd0jkplzw1ary69dilb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 267e54df511b..fb76b6b232d4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1918,7 +1918,8 @@ static struct dso *load_dso(const char *name)
 	if (!map)
 		return NULL;
 
-	map__load(map);
+	if (map__load(map) < 0)
+		pr_err("File '%s' not found or has no symbols.\n", name);
 
 	dso = dso__get(map->dso);
 
-- 
2.20.1
