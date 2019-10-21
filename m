From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 55/57] libbeauty: Introduce strarray__strtoul_flags()
Date: Mon, 21 Oct 2019 10:38:32 -0300
Message-ID: <20191021133834.25998-56-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Counterpart of strarray__scnprintf_flags(), i.e. from a expression like:

   # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|FIXED|DENYWRITE"

I.e. that "flags==PRIVATE|FIXED|DENYWRITE", turn that into

   # perf trace -e syscalls:sys_enter_mmap --filter=0x812

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8xst3zrqqogax7fmfzwymvbl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 45 +++++++++++++++++++++++++++++++-
 tools/perf/trace/beauty/beauty.h |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 72ef3b395504..73c5c14b52eb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -586,6 +586,49 @@ bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret)
 	return false;
 }
 
+bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *ret)
+{
+	u64 val = 0;
+	char *tok = bf, *sep, *end;
+
+	*ret = 0;
+
+	while (size != 0) {
+		int toklen = size;
+
+		sep = memchr(tok, '|', size);
+		if (sep != NULL) {
+			size -= sep - tok + 1;
+
+			end = sep - 1;
+			while (end > tok && isspace(*end))
+				--end;
+
+			toklen = end - tok + 1;
+		}
+
+		while (isspace(*tok))
+			++tok;
+
+		if (isalpha(*tok) || *tok == '_') {
+			if (!strarray__strtoul(sa, tok, toklen, &val))
+				return false;
+		} else {
+			bool is_hexa = tok[0] == 0 && (tok[1] = 'x' || tok[1] == 'X');
+
+			val = strtoul(tok, NULL, is_hexa ? 16 : 0);
+		}
+
+		*ret |= (1 << (val - 1));
+
+		if (sep == NULL)
+			break;
+		tok = sep + 1;
+	}
+
+	return true;
+}
+
 bool strarrays__strtoul(struct strarrays *sas, char *bf, size_t size, u64 *ret)
 {
 	int i;
@@ -3676,7 +3719,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 			}
 
 		right_end = right + 1;
-		while (isalnum(*right_end) || *right_end == '_')
+		while (isalnum(*right_end) || *right_end == '_' || *right_end == '|')
 			++right_end;
 
 		if (isalpha(*right)) {
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 10801660a71f..e12b2228b892 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -32,6 +32,7 @@ size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, co
 size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, bool show_prefix, unsigned long flags);
 
 bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret);
+bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *ret);
 
 struct trace;
 struct thread;
-- 
2.21.0
