From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/37] perf tools: Add perf_exe() helper to find perf binary
Date: Mon, 25 Feb 2019 18:20:25 -0300
Message-ID: <20190225212035.24781-28-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Also convert one existing user.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224153722.27020-9-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 12 +++---------
 tools/perf/util/util.c   | 10 ++++++++++
 tools/perf/util/util.h   |  2 ++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a2323d777dae..01b324c275b9 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -527,17 +527,11 @@ static int write_event_desc(struct feat_fd *ff,
 static int write_cmdline(struct feat_fd *ff,
 			 struct perf_evlist *evlist __maybe_unused)
 {
-	char buf[MAXPATHLEN];
-	u32 n;
-	int i, ret;
+	char pbuf[MAXPATHLEN], *buf;
+	int i, ret, n;
 
 	/* actual path to perf binary */
-	ret = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
-	if (ret <= 0)
-		return -1;
-
-	/* readlink() does not add null termination */
-	buf[ret] = '\0';
+	buf = perf_exe(pbuf, MAXPATHLEN);
 
 	/* account for binary path */
 	n = perf_env.nr_cmdline + 1;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 706818693086..d388f80d8703 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -568,3 +568,13 @@ const char *perf_tip(const char *dirpath)
 
 	return tip;
 }
+
+char *perf_exe(char *buf, int len)
+{
+	int n = readlink("/proc/self/exe", buf, len);
+	if (n > 0) {
+		buf[n] = 0;
+		return buf;
+	}
+	return strcpy(buf, "perf");
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 01c538027c6f..09c1b0f91f65 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -77,6 +77,8 @@ extern bool perf_singlethreaded;
 void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
+char *perf_exe(char *buf, int len);
+
 #ifndef O_CLOEXEC
 #ifdef __sparc__
 #define O_CLOEXEC      0x400000
-- 
2.20.1
