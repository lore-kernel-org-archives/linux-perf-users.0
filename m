From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/85] perf data: Add description of header HEADER_BPF_PROG_INFO and HEADER_BPF_BTF
Date: Tue, 11 Jun 2019 15:57:47 -0300
Message-ID: <20190611185911.11645-2-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This patch addes description of HEADER_BPF_PROG_INFO and HEADER_BPF_BTF to
perf.data-file-format.txt.

Requested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
Link: http://lkml.kernel.org/r/20190521064406.2498925-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/Documentation/perf.data-file-format.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 6967e9b02be5..022bb8b1c84a 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -272,6 +272,22 @@ struct {
 
 Two uint64_t for the time of first sample and the time of last sample.
 
+        HEADER_BPF_PROG_INFO = 25,
+
+struct bpf_prog_info_linear, which contains detailed information about
+a BPF program, including type, id, tag, jited/xlated instructions, etc.
+
+        HEADER_BPF_BTF = 26,
+
+Contains BPF Type Format (BTF). For more information about BTF, please
+refer to Documentation/bpf/btf.rst.
+
+struct {
+	u32	id;
+	u32	data_size;
+	char	data[];
+};
+
         HEADER_COMPRESSED = 27,
 
 struct {
-- 
2.20.1
