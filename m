From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/30] perf script: Add array bound checking to list_scripts
Date: Mon, 11 Mar 2019 23:02:02 -0300
Message-ID: <20190312020204.22092-29-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Don't overflow array when the scripts directory is too large, or the
script file name is too long.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-11-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c      | 8 ++++++--
 tools/perf/builtin.h             | 3 ++-
 tools/perf/ui/browsers/scripts.c | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b695b20ffc8a..2f93d60c5a17 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2982,7 +2982,8 @@ static int check_ev_match(char *dir_name, char *scriptname,
  * will list all statically runnable scripts, select one, execute it and
  * show the output in a perf browser.
  */
-int find_scripts(char **scripts_array, char **scripts_path_array)
+int find_scripts(char **scripts_array, char **scripts_path_array, int num,
+		 int pathlen)
 {
 	struct dirent *script_dirent, *lang_dirent;
 	char scripts_path[MAXPATHLEN], lang_path[MAXPATHLEN];
@@ -3027,7 +3028,10 @@ int find_scripts(char **scripts_array, char **scripts_path_array)
 			/* Skip those real time scripts: xxxtop.p[yl] */
 			if (strstr(script_dirent->d_name, "top."))
 				continue;
-			sprintf(scripts_path_array[i], "%s/%s", lang_path,
+			if (i >= num)
+				break;
+			snprintf(scripts_path_array[i], pathlen, "%s/%s",
+				lang_path,
 				script_dirent->d_name);
 			temp = strchr(script_dirent->d_name, '.');
 			snprintf(scripts_array[i],
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 05745f3ce912..999fe9170122 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -40,5 +40,6 @@ int cmd_mem(int argc, const char **argv);
 int cmd_data(int argc, const char **argv);
 int cmd_ftrace(int argc, const char **argv);
 
-int find_scripts(char **scripts_array, char **scripts_path_array);
+int find_scripts(char **scripts_array, char **scripts_path_array, int num,
+		 int pathlen);
 #endif
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index cdba58447b85..96e5cd3b0eee 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -97,7 +97,8 @@ static int list_scripts(char *script_name, bool *custom,
 		paths[i] = names[i] + SCRIPT_NAMELEN;
 	}
 
-	num = find_scripts(names + max_std, paths + max_std);
+	num = find_scripts(names + max_std, paths + max_std, SCRIPT_MAX_NO - max_std,
+			SCRIPT_FULLPATH_LEN);
 	if (num < 0)
 		num = 0;
 	choice = ui__popup_menu(num + max_std, (char * const *)names);
-- 
2.20.1
