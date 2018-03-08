From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/54] perf cgroup: Add evlist__add_default_cgroup()
Date: Thu,  8 Mar 2018 16:49:47 -0300
Message-ID: <20180308195029.14991-13-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that tools like 'perf trace' can allow the user to set a cgroup
to be used for all the evsels still without a crgroup setup by
parse_cgroups(), such as the one to use for the syscalls, vfs_getname
and other events involved in strace like syscall tracing.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zf9jjsbj661r3lk6qb7g8j70@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 14 ++++++++++++++
 tools/perf/util/cgroup.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 6fd33ffc2488..d8cd0e601c56 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -182,6 +182,20 @@ struct cgroup *cgroup__get(struct cgroup *cgroup)
        return cgroup;
 }
 
+static void evsel__set_default_cgroup(struct perf_evsel *evsel, struct cgroup *cgroup)
+{
+	if (evsel->cgrp == NULL)
+		evsel->cgrp = cgroup__get(cgroup);
+}
+
+void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgroup)
+{
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__set_default_cgroup(evsel, cgroup);
+}
+
 int parse_cgroups(const struct option *opt, const char *str,
 		  int unset __maybe_unused)
 {
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 0e377e6340dd..b213f5e9a3ed 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -22,6 +22,8 @@ struct perf_evlist;
 
 struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, char *name);
 
+void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgroup);
+
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
 #endif /* __CGROUP_H__ */
-- 
2.14.3
