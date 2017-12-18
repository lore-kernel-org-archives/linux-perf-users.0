From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/2] perf-probe: Skip searching debuginfo if we know no debuginfo
Date: Mon, 18 Dec 2017 16:29:31 +0900
Message-ID: <151358217136.25261.3482350938716300995.stgit@devbox>
References: <151358211494.25261.16134489192749792799.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151358211494.25261.16134489192749792799.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Skip searching debuginfo if we have already searched and
there is no debuginfo for given file.
This also reduce debuginfo mismatch warnings for listing
events on same binary.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 5bb71e056b21..cafc3e5b9863 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -119,6 +119,8 @@ enum dso_binary_type distro_dwarf_types[] = {
 
 struct debuginfo *debuginfo__new(const char *path)
 {
+	static struct strlist *no_debuginfo_files;
+
 	u8 bid[BUILD_ID_SIZE], bid2[BUILD_ID_SIZE];
 	enum dso_binary_type *type;
 	char buf[PATH_MAX], nil = '\0';
@@ -126,6 +128,12 @@ struct debuginfo *debuginfo__new(const char *path)
 	bool have_build_id = false;
 	struct debuginfo *dinfo = NULL;
 
+	/* Skip if we already know it has no debuginfo */
+	if (!no_debuginfo_files)
+		no_debuginfo_files = strlist__new(NULL, NULL);
+	else if (strlist__find(no_debuginfo_files, path))
+		return NULL;
+
 	/* Try to open distro debuginfo files */
 	dso = dso__new(path);
 	if (!dso)
@@ -159,7 +167,13 @@ struct debuginfo *debuginfo__new(const char *path)
 
 out:
 	/* if failed to open all distro debuginfo, open given binary */
-	return dinfo ? : __debuginfo__new(path);
+	if (!dinfo) {
+		dinfo = __debuginfo__new(path);
+		if (!dinfo)
+			strlist__add(no_debuginfo_files, path);
+	}
+
+	return dinfo;
 }
 
 void debuginfo__delete(struct debuginfo *dbg)
