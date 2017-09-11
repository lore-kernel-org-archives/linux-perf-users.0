From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf: support running perf binaries with a dash in their name
Date: Mon, 11 Sep 2017 13:14:22 +0200
Message-ID: <20170911111422.31903-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:57342 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdIKLO0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Sep 2017 07:14:26 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>

Previously the part behind "perf-" was interpreted as an internal
perf command. If the suffix could not be handled, the execution
was stopped. This makes it impossible to launch perf binaries that
got renamed to have the `perf-` prefix. This is e.g. the case for
appimages (e.g. "perf-x86_64.AppImage"), but would also apply to
all other scenarios where users symlink or rename perf themselves:

Status quo with the broken behavior:
~~~~~
$ ln -s ./perf ./perf-custom-suffix
$ ./perf-custom-suffix list
cannot handle custom-suffix internally$
~~~~~

Also note the missing newline at the end of the error message.
With this patch applied, the above works properly:

~~~~~
$ ./perf-custom-suffix list

List of pre-defined events (to be used in -e):
...
~~~~~

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/perf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index e0279babe0c0..7a3a39014446 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -467,15 +467,19 @@ int main(int argc, const char **argv)
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
+		// if the command is handled, the above function does not return
+		// undo changes and fall through in such a case
+		cmd -= 5;
+		argv[0] = cmd;
 	}
 	if (strstarts(cmd, "trace")) {
 #ifdef HAVE_LIBAUDIT_SUPPORT
-- 
2.14.1
