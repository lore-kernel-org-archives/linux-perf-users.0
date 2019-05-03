From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/11] perf bpf: Return value with unlocking in perf_env__find_btf()
Date: Thu,  2 May 2019 20:25:23 -0400
Message-ID: <20190503002533.29359-2-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Bo YU <tsu.yubo@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Bo YU <tsu.yubo@gmail.com>

In perf_env__find_btf(), we're returning without unlocking
"env->bpf_progs.lock". There may be cause lockdep issue.

Detected by CoversityScan, CID# 1444762:(program hangs(LOCK))

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Fixes: 2db7b1e0bd49d: (perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf())
Link: http://lkml.kernel.org/r/20190422080138.10088-1-tsu.yubo@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 9494f9dc61ec..6a3eaf7d9353 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -115,8 +115,8 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 	}
 	node = NULL;
 
-	up_read(&env->bpf_progs.lock);
 out:
+	up_read(&env->bpf_progs.lock);
 	return node;
 }
 
-- 
2.20.1
