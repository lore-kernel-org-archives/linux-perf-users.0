From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/41] perf tools: Support running perf binaries with a dash in their name
Date: Tue, 12 Sep 2017 12:10:17 -0300
Message-ID: <20170912151029.6612-30-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

Previously the part behind "perf-" was interpreted as an internal perf
command. If the suffix could not be handled, the execution was stopped.
This makes it impossible to launch perf binaries that got renamed to
have the `perf-` prefix. This is e.g. the case for appimages (e.g.
"perf-x86_64.AppImage"), but would also apply to all other scenarios
where users symlink or rename perf themselves:

Status quo with the broken behavior:

  $ ln -s ./perf ./perf-custom-suffix
  $ ./perf-custom-suffix list
  cannot handle custom-suffix internally$

Also note the missing newline at the end of the error message.

With this patch applied, the above works properly:

  $ ./perf-custom-suffix list

  List of pre-defined events (to be used in -e):
  ...

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: David Ahern <dsahern@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20170911111422.31903-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index e0279babe0c0..2f19e03c5c40 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -467,15 +467,21 @@ int main(int argc, const char **argv)
 	 *  - cannot execute it externally (since it would just do
 	 *    the same thing over again)
 	 *
-	 * So we just directly call the internal command handler, and
-	 * die if that one cannot handle it.
+	 * So we just directly call the internal command handler. If that one
+	 * fails to handle this, then maybe we just run a renamed perf binary
+	 * that contains a dash in its name. To handle this scenario, we just
+	 * fall through and ignore the "xxxx" part of the command string.
 	 */
 	if (strstarts(cmd, "perf-")) {
 		cmd += 5;
 		argv[0] = cmd;
 		handle_internal_command(argc, argv);
-		fprintf(stderr, "cannot handle %s internally", cmd);
-		goto out;
+		/*
+		 * If the command is handled, the above function does not
+		 * return undo changes and fall through in such a case.
+		 */
+		cmd -= 5;
+		argv[0] = cmd;
 	}
 	if (strstarts(cmd, "trace")) {
 #ifdef HAVE_LIBAUDIT_SUPPORT
-- 
2.13.5
