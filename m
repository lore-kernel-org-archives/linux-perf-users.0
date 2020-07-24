From: Wang ShaoBo <bobo.shaobowang@huawei.com>
Subject: [PATCH -next] tools build: Check return value of fwrite_unlocked in jvmti_agent.c
Date: Fri, 24 Jul 2020 18:07:06 +0800
Message-ID: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: cj.chengjian@huawei.com, huawei.libin@huawei.com, jolsa@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Function jvmti_write_code called by compiled_method_load_cb may return
error in using fwrite_unlocked, this failure should be captured and
warned.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 tools/perf/jvmti/jvmti_agent.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 88108598d6e9..a1fe6aa16b6d 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
 	struct jr_code_load rec;
 	size_t sym_len;
 	FILE *fp = agent;
-	int ret = -1;
+	int ret;
 
 	/* don't care about 0 length function, no samples */
 	if (size == 0)
@@ -401,16 +401,23 @@ jvmti_write_code(void *agent, char const *sym,
 	rec.code_index = code_generation++;
 
 	ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
-	fwrite_unlocked(sym, sym_len, 1, fp);
+	if (ret)
+		goto error;
+	ret = fwrite_unlocked(sym, sym_len, 1, fp);
+	if (ret)
+		goto error;
 
-	if (code)
-		fwrite_unlocked(code, size, 1, fp);
+	if (code) {
+		ret = fwrite_unlocked(code, size, 1, fp);
+		if (ret)
+			goto error;
+	}
 
 	funlockfile(fp);
-
-	ret = 0;
-
-	return ret;
+	return 0;
+error:
+	funlockfile(fp);
+	return -1;
 }
 
 int
-- 
2.17.1
