From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/7] perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf()
Date: Fri, 19 Apr 2019 09:30:29 -0300
Message-ID: <20190419123029.11328-8-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We don't return NULL when we don't find the bpf_prog_info_node, fix
that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Song Liu <songliubraving@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 3792cb2ff43b ("perf bpf: Save BTF in a rbtree in perf_env")
Link: http://lkml.kernel.org/r/20190417145539.11669-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 34a363f2e71b..9494f9dc61ec 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -111,10 +111,12 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 		else if (btf_id > node->id)
 			n = n->rb_right;
 		else
-			break;
+			goto out;
 	}
+	node = NULL;
 
 	up_read(&env->bpf_progs.lock);
+out:
 	return node;
 }
 
-- 
2.20.1
