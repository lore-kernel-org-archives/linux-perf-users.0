From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/43] perf trace: Filter out gnome-terminal* parent
Date: Thu, 14 Feb 2019 21:45:14 -0300
Message-ID: <20190215004539.23571-19-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like it does with 'sshd', to reduce the feedback loop when doing
system wide tracing on on a gnome GUI.

Need to figure out how to auto-filter the calls to other UI components
tho.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-rjopq5y92itgokppdhe8sc6z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a9b51f59ab54..68a01e624ad3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2771,7 +2771,8 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 		if (parent == NULL)
 			break;
 
-		if (!strcmp(thread__comm_str(parent), "sshd")) {
+		if (!strcmp(thread__comm_str(parent), "sshd") ||
+		    strstarts(thread__comm_str(parent), "gnome-terminal")) {
 			pids[nr++] = parent->tid;
 			break;
 		}
-- 
2.19.1
