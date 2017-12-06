From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/5] perf-probe: Add warning message if there is unexpected event name
Date: Wed,  6 Dec 2017 12:06:50 +0900
Message-ID: <151252961042.12861.5722227511177610862.stgit@devbox>
References: <151252958056.12861.954203514347167563.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <151252958056.12861.954203514347167563.stgit@devbox>
Sender: linux-rt-users-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>, linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This improve the error message so that user can know
event-name error before writing new events to
kprobe-events interface.

E.g.
   ======
   #./perf probe -x /lib64/libc-2.25.so malloc_get_state*
   Internal error: "malloc_get_state@GLIBC_2" is wrong event name.
     Error: Failed to add events.
   ======

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b7aaf9b2294d..c0067950e56f 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2625,6 +2625,14 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 
 out:
 	free(nbase);
+
+	/* Final validation */
+	if (ret >= 0 && !is_c_func_name(buf)) {
+		pr_warning("Internal error: \"%s\" is wrong event name.\n",
+			   buf);
+		ret = -EINVAL;
+	}
+
 	return ret;
 }
 

