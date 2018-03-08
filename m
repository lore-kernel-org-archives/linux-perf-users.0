From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/54] perf cgroup: Remove misplaced __maybe_unused
Date: Thu,  8 Mar 2018 16:49:36 -0300
Message-ID: <20180308195029.14991-2-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'opt' parameter in parse_cgroups() _is_ used. The original patch
used '__used' that was even more confusing :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 023695d96ee0 ("perf tool: Add cgroup support")
Link: https://lkml.kernel.org/n/tip-4jo2puz0empkoou6bbq460tl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 5dd9b5ea314d..2e2aa6c86107 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -153,7 +153,7 @@ void close_cgroup(struct cgroup_sel *cgrp)
 	}
 }
 
-int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
+int parse_cgroups(const struct option *opt, const char *str,
 		  int unset __maybe_unused)
 {
 	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
-- 
2.14.3
