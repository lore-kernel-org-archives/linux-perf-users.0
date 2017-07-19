From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/86] perf trace beauty: Export the strarrays scnprintf method
Date: Wed, 19 Jul 2017 11:28:30 -0300
Message-ID: <20170719142950.3747-7-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As we'll call it from the fcntl cmd scnprintf method, that needs to look
at the cmd to mask the next fcntl argument when it is ignored.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-fzlvkhew5vbxefneuciihgbc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 6 ++----
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 431ef70067ed..ef1b1d4ea007 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -331,8 +331,8 @@ struct strarrays {
 	.entries = array, \
 }
 
-static size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
-					       struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
+					struct syscall_arg *arg)
 {
 	struct strarrays *sas = arg->parm;
 	int i;
@@ -351,8 +351,6 @@ static size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
 	return scnprintf(bf, size, "%d", arg->val);
 }
 
-#define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
-
 #if defined(__i386__) || defined(__x86_64__)
 /*
  * FIXME: Make this available to all arches as soon as the ioctl beautifier
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index cf50be3f17a4..a6348073a6e9 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -15,6 +15,9 @@ struct syscall_arg {
 	u8	      mask;
 };
 
+size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
+
 size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_FLAGS syscall_arg__scnprintf_statx_flags
 
-- 
2.9.4
