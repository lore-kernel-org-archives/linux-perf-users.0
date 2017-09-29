From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/7] perf evsel: Fix attr.exclude_kernel setting for default cycles:p
Date: Fri, 29 Sep 2017 13:00:13 -0300
Message-ID: <20170929160017.29335-4-acme@kernel.org>
References: <20170929160017.29335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929160017.29335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andy Lutomirski <luto@kernel.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Yet another fix for probing the max attr.precise_ip setting: it is not
enough settting attr.exclude_kernel for !root users, as they _can_
profile the kernel if the kernel.perf_event_paranoid sysctl is set to
-1, so check that as well.

Testing it:

As non root:

  $ sysctl kernel.perf_event_paranoid
  kernel.perf_event_paranoid = 2
  $ perf record sleep 1
  $ perf evlist -v
  cycles:uppp: ..., exclude_kernel: 1, ... precise_ip: 3, ...

Now as non-root, but with kernel.perf_event_paranoid set set to the
most permissive value, -1:

  $ sysctl kernel.perf_event_paranoid
  kernel.perf_event_paranoid = -1
  $ perf record sleep 1
  $ perf evlist -v
  cycles:ppp: ..., exclude_kernel: 0, ... precise_ip: 3, ...
  $

I.e. non-root, default kernel.perf_event_paranoid: :uppp modifier = not allowed to sample the kernel,
     non-root, most permissible kernel.perf_event_paranoid: :ppp = allowed to sample the kernel.

In both cases, use the highest available precision: attr.precise_ip = 3.

Reported-and-Tested-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: d37a36979077 ("perf evsel: Fix attr.exclude_kernel setting for default cycles:p")
Link: http://lkml.kernel.org/n/tip-nj2qkf75xsd6pw6hhjzfqqdx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4bb89373eb52..0dccdb89572c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -271,12 +271,17 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 	return evsel;
 }
 
+static bool perf_event_can_profile_kernel(void)
+{
+	return geteuid() == 0 || perf_event_paranoid() == -1;
+}
+
 struct perf_evsel *perf_evsel__new_cycles(bool precise)
 {
 	struct perf_event_attr attr = {
 		.type	= PERF_TYPE_HARDWARE,
 		.config	= PERF_COUNT_HW_CPU_CYCLES,
-		.exclude_kernel	= geteuid() != 0,
+		.exclude_kernel	= !perf_event_can_profile_kernel(),
 	};
 	struct perf_evsel *evsel;
 
-- 
2.13.5
