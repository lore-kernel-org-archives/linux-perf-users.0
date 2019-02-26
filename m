From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v2 07/11] perf tools: Add perf_exe() helper to find perf binary
Date: Mon, 25 Feb 2019 19:04:08 -0800
Message-ID: <20190226030412.23485-8-andi@firstfloor.org>
References: <20190226030412.23485-1-andi@firstfloor.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226030412.23485-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Also convert one existing user.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/header.c | 12 +++---------
 tools/perf/util/util.c   | 10 ++++++++++
 tools/perf/util/util.h   |  2 ++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 61ce197c5362..2f290a0343d4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -526,17 +526,11 @@ static int write_event_desc(struct feat_fd *ff,
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
index 320b0fef249a..dd693e018aef 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -507,3 +507,13 @@ const char *perf_tip(const char *dirpath)
 
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
index ece040b799f6..dc2a99ad5c96 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -76,6 +76,8 @@ extern bool perf_singlethreaded;
 void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
+char *perf_exe(char *buf, int len);
+
 #ifndef O_CLOEXEC
 #ifdef __sparc__
 #define O_CLOEXEC      0x400000
-- 
2.17.2
