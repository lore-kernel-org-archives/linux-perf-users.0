From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 44/75] perf trace: We need to consider "nr" if "__syscall_nr" is not there
Date: Thu,  6 Dec 2018 18:25:31 -0300
Message-ID: <20181206212602.20474-45-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Taeung Song <treeze.taeung@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To cope with older kernels that don't have this patch backported:

  026842d148b9 ("tracing/syscalls: Rename "/format" tracepoint field name "nr" to "__syscall_nr:")

This makes 'perf trace' work again in RHEL7 kernels.

Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6h1syw2isegnhb1bjmtr9x9k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2a347ed7bdf4..98aff12af9e6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -258,7 +258,8 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
 	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
 
 	if (evsel->priv != NULL) {
-		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr"))
+		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr") &&
+		    perf_evsel__init_tp_uint_field(evsel, &sc->id, "nr"))
 			goto out_delete;
 		return 0;
 	}
-- 
2.19.2
