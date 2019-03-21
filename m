From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/44] perf symbols: Introduce DSO_BINARY_TYPE__BPF_PROG_INFO
Date: Thu, 21 Mar 2019 15:51:35 -0300
Message-ID: <20190321185142.11441-38-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Stanislav Fomichev <sdf@google.com>, kernel-team@fb.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Introduce a new dso type DSO_BINARY_TYPE__BPF_PROG_INFO for BPF programs. In
symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso will call into a new
function symbol__disassemble_bpf() in an upcoming patch, where annotation line
information is filled based bpf_prog_info and btf saved in given perf_env.

Committer notes:

Removed the unnamed union with 'bpf_prog' and 'cache' in 'struct dso',
to fix this bug when exiting 'perf top':

  # perf top
  perf: Segmentation fault
  -------- backtrace --------
  perf[0x5a785a]
  /lib64/libc.so.6(+0x385bf)[0x7fd68443c5bf]
  perf(rb_first+0x2b)[0x4d6eeb]
  perf(dso__delete+0xb7)[0x4dffb7]
  perf[0x4f9e37]
  perf(perf_session__delete+0x64)[0x504df4]
  perf(cmd_top+0x1957)[0x454467]
  perf[0x4aad18]
  perf(main+0x61c)[0x42ec7c]
  /lib64/libc.so.6(__libc_start_main+0xf2)[0x7fd684428412]
  perf(_start+0x2d)[0x42eead]
  #
  # addr2line -fe ~/bin/perf 0x4dffb7
  dso_cache__free
  /home/acme/git/perf/tools/perf/util/dso.c:713

That is trying to access the dso->data.cache, and that is not used with
BPF programs, so we end up accessing what is in bpf_prog.first_member,
b00m.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190312053051.2690567-13-songliubraving@fb.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c    | 1 +
 tools/perf/util/dso.h    | 8 ++++++++
 tools/perf/util/symbol.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ab8a455d2283..e059976d9d93 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -184,6 +184,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__KALLSYMS:
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bb417c54c25a..6e3f63781e51 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -14,6 +14,7 @@
 
 struct machine;
 struct map;
+struct perf_env;
 
 enum dso_binary_type {
 	DSO_BINARY_TYPE__KALLSYMS = 0,
@@ -35,6 +36,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__KCORE,
 	DSO_BINARY_TYPE__GUEST_KCORE,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+	DSO_BINARY_TYPE__BPF_PROG_INFO,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
@@ -189,6 +191,12 @@ struct dso {
 		u64		 debug_frame_offset;
 		u64		 eh_frame_hdr_offset;
 	} data;
+	/* bpf prog information */
+	struct {
+		u32		id;
+		u32		sub_id;
+		struct perf_env	*env;
+	} bpf_prog;
 
 	union { /* Tool specific area */
 		void	 *priv;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 58442ca5e3c4..5cbad55cd99d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1455,6 +1455,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
 		return true;
 
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 		return false;
-- 
2.20.1
