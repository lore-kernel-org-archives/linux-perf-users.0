From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/57] libbeauty: Add a strarray__scnprintf_suffix() method
Date: Mon, 21 Oct 2019 10:38:03 -0300
Message-ID: <20191021133834.25998-27-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In some cases, like with x86 IRQ vectors, the common part in names is at
the end, so a suffix, add a scnprintf function for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-agxbj6es2ke3rehwt4gkdw23@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 14 ++++++++++++++
 tools/perf/trace/beauty/beauty.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 907eaf316f5b..58bbe85d4166 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -423,6 +423,20 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	({ struct syscall_tp *fields = evsel->priv; \
 	   fields->name.pointer(&fields->name, sample); })
 
+size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_suffix, int val)
+{
+	int idx = val - sa->offset;
+
+	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL) {
+		size_t printed = scnprintf(bf, size, intfmt, val);
+		if (show_suffix)
+			printed += scnprintf(bf + printed, size - printed, " /* %s??? */", sa->prefix);
+		return printed;
+	}
+
+	return scnprintf(bf, size, "%s%s", sa->entries[idx], show_suffix ? sa->prefix : "");
+}
+
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
 	int idx = val - sa->offset;
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 0dee0cf4fda8..165f56b456be 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -28,6 +28,7 @@ struct strarray {
 }
 
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_prefix, int val);
+size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_suffix, int val);
 size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, bool show_prefix, unsigned long flags);
 
 bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret);
-- 
2.21.0
