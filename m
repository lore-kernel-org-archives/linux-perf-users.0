From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/69] perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine
Date: Fri, 11 Oct 2019 17:04:52 -0300
Message-ID: <20191011200559.7156-3-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just read it so that later on the per arch init routine can use it,
e.g. x86__annotate_init().

When using a perf.data file this is obtained from a header that was put
there by 'perf record', and then it may be for another machine, another
arch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4t4n3o8l8s0tc2b1pq53hyr4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1f60124eb19b..611d03030abc 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1560,6 +1560,17 @@ int cmd_top(int argc, const char **argv)
 	status = perf_config(perf_top_config, &top);
 	if (status)
 		return status;
+	/*
+	 * Since the per arch annotation init routine may need the cpuid, read
+	 * it here, since we are not getting this from the perf.data header.
+	 */
+	status = perf_env__read_cpuid(&perf_env);
+	if (status) {
+		pr_err("Couldn't read the cpuid for this machine: %s\n",
+		       str_error_r(errno, errbuf, sizeof(errbuf)));
+		goto out_delete_evlist;
+	}
+	top.evlist->env = &perf_env;
 
 	argc = parse_options(argc, argv, options, top_usage, 0);
 	if (argc)
-- 
2.21.0
