From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 22/22] perf: Fix write_numa_topology to put
 cpu_map instead of free
Date: Wed, 09 Dec 2015 11:11:35 +0900
Message-ID: <20151209021135.10245.79046.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Fix write_numa_topology to put cpu_map instead of free because
cpu_map is managed based on refcnt.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/header.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4383800..5ac7bdb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -724,7 +724,7 @@ static int write_numa_topology(int fd, struct perf_header *h __maybe_unused,
 done:
 	free(buf);
 	fclose(fp);
-	free(node_map);
+	cpu_map__put(node_map);
 	return ret;
 }
 
