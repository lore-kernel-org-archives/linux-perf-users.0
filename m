From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/7] perf header: Fix lock/unlock imbalances when processing BPF/BTF info
Date: Fri, 12 Apr 2019 11:22:46 -0300
Message-ID: <20190412142250.20595-4-acme@kernel.org>
References: <20190412142250.20595-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412142250.20595-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Song Liu <songliubraving@fb.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Fix lock/unlock imbalances by refactoring the code a bit and adding
calls to up_write() before return.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Addresses-Coverity-ID: 1444315 ("Missing unlock")
Addresses-Coverity-ID: 1444316 ("Missing unlock")
Fixes: a70a1123174a ("perf bpf: Save BTF information as headers to perf.data")
Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
Link: http://lkml.kernel.org/r/20190408173355.GA10501@embeddedor
[ Simplified the exit path to have just one up_write() + return ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b9e693825873..2d2af2ac2b1e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		perf_env__insert_bpf_prog_info(env, info_node);
 	}
 
+	up_write(&env->bpf_progs.lock);
 	return 0;
 out:
 	free(info_linear);
@@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_env *env = &ff->ph->env;
+	struct btf_node *node = NULL;
 	u32 count, i;
+	int err = -1;
 
 	if (ff->ph->needs_swap) {
 		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
@@ -2636,31 +2639,32 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 	down_write(&env->bpf_progs.lock);
 
 	for (i = 0; i < count; ++i) {
-		struct btf_node *node;
 		u32 id, data_size;
 
 		if (do_read_u32(ff, &id))
-			return -1;
+			goto out;
 		if (do_read_u32(ff, &data_size))
-			return -1;
+			goto out;
 
 		node = malloc(sizeof(struct btf_node) + data_size);
 		if (!node)
-			return -1;
+			goto out;
 
 		node->id = id;
 		node->data_size = data_size;
 
-		if (__do_read(ff, node->data, data_size)) {
-			free(node);
-			return -1;
-		}
+		if (__do_read(ff, node->data, data_size))
+			goto out;
 
 		perf_env__insert_btf(env, node);
+		node = NULL;
 	}
 
+	err = 0;
+out:
 	up_write(&env->bpf_progs.lock);
-	return 0;
+	free(node);
+	return err;
 }
 
 struct feature_ops {
-- 
2.20.1
