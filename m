From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core ] [BUGFIX] perf probe: Fix a segfault when
 removing uprobe events
Date: Wed, 16 Sep 2015 21:52:42 +0900
Message-ID: <20150916125241.4446.44805.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>
List-Id: linux-perf-users.vger.kernel.org

Fix a segfault bug and a small mistake in perf probe -d.

Since the "ulist" in perf_del_probe_events is never initialized,
strlist__add(ulist, *) always causes a segfault when removing
uprobe events by perf probe -d.

Also, the "str" local variable is never released if fail to
allocate the "klist". This fixes it too.

This has been introduced by the commit e607f1426b58 ("perf probe:
Print deleted events in cmd_probe()").

Reported-by: Milian Wolff <milian.wolff@kdab.com>
Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/builtin-probe.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 94385ee..f7882ae 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -380,8 +380,11 @@ static int perf_del_probe_events(struct strfilter *filter)
 		goto out;
 
 	klist = strlist__new(NULL, NULL);
-	if (!klist)
-		return -ENOMEM;
+	ulist = strlist__new(NULL, NULL);
+	if (!klist || !ulist) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	ret = probe_file__get_events(kfd, filter, klist);
 	if (ret == 0) {
