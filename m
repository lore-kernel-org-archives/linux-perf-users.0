From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/11] perf annotate: Fix multiple memory and file descriptor leaks
Date: Thu, 17 Oct 2019 13:02:54 -0300
Message-ID: <20191017160301.20888-5-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Store SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF in variable *ret*, instead
of returning in the middle of the function and leaking multiple
resources: prog_linfo, btf, s and bfdf.

Addresses-Coverity-ID: 1454832 ("Structurally dead code")
Fixes: 11aad897f6d1 ("perf annotate: Don't return -1 for error when doing BPF disassembly")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191014171047.GA30850@embeddedor
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4036c7f7b0fb..e42bf572358c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1758,7 +1758,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
 						 dso->bpf_prog.id);
 	if (!info_node) {
-		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 		goto out;
 	}
 	info_linear = info_node->info_linear;
-- 
2.21.0
