From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/7] perf bpf: Fix NULL return handling in bpf__prepare_load()
Date: Thu, 31 May 2018 07:32:16 -0300
Message-ID: <20180531103220.24684-4-acme@kernel.org>
References: <20180531103220.24684-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180531103220.24684-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

bpf_object__open()/bpf_object__open_buffer can return error pointer or
NULL, check the return values with IS_ERR_OR_NULL() in bpf__prepare_load
and bpf__prepare_load_buffer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: netdev@vger.kernel.org
Link: https://lkml.kernel.org/n/tip-psf4xwc09n62al2cb9s33v9h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index af7ad814b2c3..cee658733e2c 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -66,7 +66,7 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
 	}
 
 	obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, name);
-	if (IS_ERR(obj)) {
+	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load buffer\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -102,14 +102,14 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 			pr_debug("bpf: successfull builtin compilation\n");
 		obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
 
-		if (!IS_ERR(obj) && llvm_param.dump_obj)
+		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
 			llvm__dump_obj(filename, obj_buf, obj_buf_sz);
 
 		free(obj_buf);
 	} else
 		obj = bpf_object__open(filename);
 
-	if (IS_ERR(obj)) {
+	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load %s\n", filename);
 		return obj;
 	}
-- 
2.14.3
