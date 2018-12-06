From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/75] perf top: Allow passing a kallsyms file
Date: Thu,  6 Dec 2018 18:25:02 -0300
Message-ID: <20181206212602.20474-16-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This basically replicates what was done for 'perf report' in:

   b226a5a72901 ("perf report: Allow user to specify path to kallsyms file")

This should help with resolving eBPF symbols, that are in kallsyms but,
of course, not in vmlinux.

Reported-by: Ivan Babrou <ibobrik@gmail.com>
Tested-by: Ivan Babrou <ibobrik@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x52mx1ybq8128rtg9hjrj5qk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 3 +++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 808b664343c9..44d89fb9c788 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -70,6 +70,9 @@ Default is to monitor all CPUS.
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--kallsyms=<file>::
+	kallsyms pathname
+
 -m <pages>::
 --mmap-pages=<pages>::
 	Number of mmap data pages (must be a power of two) or size
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index aa0c73e57924..1252d1759064 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1289,6 +1289,8 @@ int cmd_top(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
 		    "don't load vmlinux even if found"),
+	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
+		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
 		    "hide kernel symbols"),
 	OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",
-- 
2.19.2
