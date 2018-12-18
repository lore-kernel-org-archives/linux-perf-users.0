From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/63] perf trace beauty: Print O_RDONLY when (flags & O_ACCMODE) == 0
Date: Tue, 18 Dec 2018 19:07:16 -0300
Message-ID: <20181218220733.15839-47-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And there are more flags, to match strace's output.

 openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3

Also to help with regression tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ofovpmvdli3bwch30936xn7t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/open_flags.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index 6da48893a1bb..78f6566ef110 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -27,8 +27,10 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool sh
 	const char *prefix = "O_";
 	int printed = 0;
 
+	if ((flags & O_ACCMODE) == O_RDONLY)
+		printed = scnprintf(bf, size, "%s%s", show_prefix ? prefix : "", "RDONLY");
 	if (flags == 0)
-		return scnprintf(bf, size, "%s%s", show_prefix ? prefix : "", "RDONLY");
+		return printed;
 #define	P_FLAG(n) \
 	if (flags & O_##n) { \
 		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
-- 
2.19.2
