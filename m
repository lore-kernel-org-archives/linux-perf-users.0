From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/63] perf trace: Enclose strings with double quotes
Date: Tue, 18 Dec 2018 19:07:13 -0300
Message-ID: <20181218220733.15839-44-acme@kernel.org>
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

To match 'strace' output, helping with upcoming regression tests
comparing both outputs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jab52t1dcuh6vlztqle9g7u9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2d8fd48a4727..dc8cadeb3fa5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1149,7 +1149,7 @@ static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, c
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
 
-	return scnprintf(bf, size, "%.*s", augmented_arg->size, augmented_arg->value);
+	return scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
 }
 
 static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
-- 
2.19.2
