From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/29] perf trace: Use correct SECCOMP prefix spelling, "SECOMP_*" -> "SECCOMP_*"
Date: Thu,  3 Jan 2019 09:45:45 -0300
Message-ID: <20190103124609.29672-6-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, kernel-janitors@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The spelling of the SECCOMP is incorrect, fix these.

Signed-off-by: Colin King <colin.king@canonical.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
Link: http://lkml.kernel.org/r/20181221084809.6108-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/seccomp.c b/tools/perf/trace/beauty/seccomp.c
index 4600c28a3cfe..637722e2796b 100644
--- a/tools/perf/trace/beauty/seccomp.c
+++ b/tools/perf/trace/beauty/seccomp.c
@@ -9,7 +9,7 @@
 static size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "SECOMP_SET_MODE_";
+	const char *prefix = "SECCOMP_SET_MODE_";
 	int op = arg->val;
 	size_t printed = 0;
 
@@ -34,7 +34,7 @@ static size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size,
 						   struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "SECOMP_FILTER_FLAG_";
+	const char *prefix = "SECCOMP_FILTER_FLAG_";
 	int printed = 0, flags = arg->val;
 
 #define	P_FLAG(n) \
-- 
2.19.2
