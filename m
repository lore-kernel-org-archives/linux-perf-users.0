From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/44] perf bpf: Extract logic to create program names from perf_event__synthesize_one_bpf_prog()
Date: Thu, 21 Mar 2019 15:51:41 -0300
Message-ID: <20190321185142.11441-44-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Stanislav Fomichev <sdf@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Extract logic to create program names to synthesize_bpf_prog_name(), so
that it can be reused in header.c:print_bpf_prog_info().

This commit doesn't change the behavior.

Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190319165454.1298742-2-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 62 +++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 2a8c245ca942..d5b041649f26 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -111,6 +111,38 @@ static int perf_env__fetch_btf(struct perf_env *env,
 	return 0;
 }
 
+static int synthesize_bpf_prog_name(char *buf, int size,
+				    struct bpf_prog_info *info,
+				    struct btf *btf,
+				    u32 sub_id)
+{
+	u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(uintptr_t)(info->prog_tags);
+	void *func_infos = (void *)(uintptr_t)(info->func_info);
+	u32 sub_prog_cnt = info->nr_jited_ksyms;
+	const struct bpf_func_info *finfo;
+	const char *short_name = NULL;
+	const struct btf_type *t;
+	int name_len;
+
+	name_len = snprintf(buf, size, "bpf_prog_");
+	name_len += snprintf_hex(buf + name_len, size - name_len,
+				 prog_tags[sub_id], BPF_TAG_SIZE);
+	if (btf) {
+		finfo = func_infos + sub_id * info->func_info_rec_size;
+		t = btf__type_by_id(btf, finfo->type_id);
+		short_name = btf__name_by_offset(btf, t->name_off);
+	} else if (sub_id == 0 && sub_prog_cnt == 1) {
+		/* no subprog */
+		if (info->name[0])
+			short_name = info->name;
+	} else
+		short_name = "F";
+	if (short_name)
+		name_len += snprintf(buf + name_len, size - name_len,
+				     "_%s", short_name);
+	return name_len;
+}
+
 /*
  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
@@ -135,7 +167,6 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	struct bpf_prog_info_node *info_node;
 	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
-	bool has_btf = false;
 	struct perf_env *env;
 	u32 sub_prog_cnt, i;
 	int err = 0;
@@ -189,19 +220,13 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 			btf = NULL;
 			goto out;
 		}
-		has_btf = true;
 		perf_env__fetch_btf(env, info->btf_id, btf);
 	}
 
 	/* Synthesize PERF_RECORD_KSYMBOL */
 	for (i = 0; i < sub_prog_cnt; i++) {
-		u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(uintptr_t)(info->prog_tags);
-		__u32 *prog_lens  = (__u32 *)(uintptr_t)(info->jited_func_lens);
+		__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
 		__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
-		void *func_infos  = (void *)(uintptr_t)(info->func_info);
-		const struct bpf_func_info *finfo;
-		const char *short_name = NULL;
-		const struct btf_type *t;
 		int name_len;
 
 		*ksymbol_event = (struct ksymbol_event){
@@ -214,26 +239,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 			.ksym_type = PERF_RECORD_KSYMBOL_TYPE_BPF,
 			.flags = 0,
 		};
-		name_len = snprintf(ksymbol_event->name, KSYM_NAME_LEN,
-				    "bpf_prog_");
-		name_len += snprintf_hex(ksymbol_event->name + name_len,
-					 KSYM_NAME_LEN - name_len,
-					 prog_tags[i], BPF_TAG_SIZE);
-		if (has_btf) {
-			finfo = func_infos + i * info->func_info_rec_size;
-			t = btf__type_by_id(btf, finfo->type_id);
-			short_name = btf__name_by_offset(btf, t->name_off);
-		} else if (i == 0 && sub_prog_cnt == 1) {
-			/* no subprog */
-			if (info->name[0])
-				short_name = info->name;
-		} else
-			short_name = "F";
-		if (short_name)
-			name_len += snprintf(ksymbol_event->name + name_len,
-					     KSYM_NAME_LEN - name_len,
-					     "_%s", short_name);
 
+		name_len = synthesize_bpf_prog_name(ksymbol_event->name,
+						    KSYM_NAME_LEN, info, btf, i);
 		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
 							 sizeof(u64));
 
-- 
2.20.1
