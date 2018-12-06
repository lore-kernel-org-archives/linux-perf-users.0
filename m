From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 70/75] perf config: Modify size factor of snprintf
Date: Thu,  6 Dec 2018 18:25:57 -0300
Message-ID: <20181206212602.20474-71-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sihyeon Jang <uneedsihyeon@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sihyeon Jang <uneedsihyeon@gmail.com>

According to definition of snprintf, it gets size factor including
null('\0') byte.  So '-1' is not neccessary. Also it will be helpful
unfied style with other cases. (eg. builtin-script.c)

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201154603.10093-1-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 3beb4cf44c31..1ea8f898f1a1 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -815,14 +815,14 @@ int config_error_nonbool(const char *var)
 void set_buildid_dir(const char *dir)
 {
 	if (dir)
-		scnprintf(buildid_dir, MAXPATHLEN-1, "%s", dir);
+		scnprintf(buildid_dir, MAXPATHLEN, "%s", dir);
 
 	/* default to $HOME/.debug */
 	if (buildid_dir[0] == '\0') {
 		char *home = getenv("HOME");
 
 		if (home) {
-			snprintf(buildid_dir, MAXPATHLEN-1, "%s/%s",
+			snprintf(buildid_dir, MAXPATHLEN, "%s/%s",
 				 home, DEBUG_CACHE_DIR);
 		} else {
 			strncpy(buildid_dir, DEBUG_CACHE_DIR, MAXPATHLEN-1);
-- 
2.19.2
