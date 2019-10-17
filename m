From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/11] perf c2c: Fix memory leak in build_cl_output()
Date: Thu, 17 Oct 2019 13:02:56 -0300
Message-ID: <20191017160301.20888-7-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yunfeng Ye <yeyunfeng@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Feilong Lin <linfeilong@huawei.com>, Hu Shiyuan <hushiyuan@huawei.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

There is a memory leak problem in the failure paths of
build_cl_output(), so fix it.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/4d3c0178-5482-c313-98e1-f82090d2d456@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3542b6ab9813..e69f44941aad 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2635,6 +2635,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	bool add_sym   = false;
 	bool add_dso   = false;
 	bool add_src   = false;
+	int ret = 0;
 
 	if (!buf)
 		return -ENOMEM;
@@ -2653,7 +2654,8 @@ static int build_cl_output(char *cl_sort, bool no_source)
 			add_dso = true;
 		} else if (strcmp(tok, "offset")) {
 			pr_err("unrecognized sort token: %s\n", tok);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 	}
 
@@ -2676,13 +2678,15 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		add_sym ? "symbol," : "",
 		add_dso ? "dso," : "",
 		add_src ? "cl_srcline," : "",
-		"node") < 0)
-		return -ENOMEM;
+		"node") < 0) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	c2c.show_src = add_src;
-
+err:
 	free(buf);
-	return 0;
+	return ret;
 }
 
 static int setup_coalesce(const char *coalesce, bool no_source)
-- 
2.21.0
