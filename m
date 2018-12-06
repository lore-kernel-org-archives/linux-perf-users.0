From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/75] perf bpf-loader: Fix debugging message typo
Date: Thu,  6 Dec 2018 18:25:27 -0300
Message-ID: <20181206212602.20474-41-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

This one has information that is presented to the user, albeit in debug
mode.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 9a280647d829..2f3eb6d293ee 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -99,7 +99,7 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 			if (err)
 				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
 		} else
-			pr_debug("bpf: successfull builtin compilation\n");
+			pr_debug("bpf: successful builtin compilation\n");
 		obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
 
 		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
-- 
2.19.2
