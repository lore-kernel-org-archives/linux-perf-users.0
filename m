From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/28] perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}
Date: Wed, 31 Oct 2018 13:44:54 -0300
Message-ID: <20181031164508.4784-15-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Souvik Banerjee <souvik1997@gmail.com>, Wang Nan <wangnan0@huawei.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

When processing using 'perf report -g caller', which is the default, we
ended up reverting the callchain entries received from the kernel, but
simply reverting throws away the information that tells that from a
point onwards the addresses are for userspace, kernel, guest kernel,
guest user, hypervisor.

The idea is that if we are walking backwards, for each cluster of
non-cpumode entries we have to first scan backwards for the next one and
use that for the cluster.

This seems silly and more expensive than it needs to be but it is enough
for a initial fix.

The code here is really complicated because it is intimately intertwined
with the lbr and branch handling, as well as this callchain order,
further fixes will be needed to properly take into account the cpumode
in those cases.

Another problem with ORDER_CALLER is that the NULL "0" IP that is at the
end of most callchains shows up at the top of the histogram because
every callchain contains it and with ORDER_CALLER it is the first entry.

Signed-off-by: David S. Miller <davem@davemloft.net>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Souvik Banerjee <souvik1997@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org # 4.19
Link: https://lkml.kernel.org/n/tip-2wt3ayp6j2y2f2xowixa8y6y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..8ee8ab39d8ac 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2140,6 +2140,27 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	return 0;
 }
 
+static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
+			     struct callchain_cursor *cursor,
+			     struct symbol **parent,
+			     struct addr_location *root_al,
+			     u8 *cpumode, int ent)
+{
+	int err = 0;
+
+	while (--ent >= 0) {
+		u64 ip = chain->ips[ent];
+
+		if (ip >= PERF_CONTEXT_MAX) {
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, cpumode, ip,
+					       false, NULL, NULL, 0);
+			break;
+		}
+	}
+	return err;
+}
+
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct perf_evsel *evsel,
@@ -2246,6 +2267,12 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	}
 
 check_calls:
+	if (callchain_param.order != ORDER_CALLEE) {
+		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
+					&cpumode, chain->nr - first_call);
+		if (err)
+			return (err < 0) ? err : 0;
+	}
 	for (i = first_call, nr_entries = 0;
 	     i < chain_nr && nr_entries < max_stack; i++) {
 		u64 ip;
@@ -2260,9 +2287,15 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 #endif
 		ip = chain->ips[j];
-
 		if (ip < PERF_CONTEXT_MAX)
                        ++nr_entries;
+		else if (callchain_param.order != ORDER_CALLEE) {
+			err = find_prev_cpumode(chain, thread, cursor, parent,
+						root_al, &cpumode, j);
+			if (err)
+				return (err < 0) ? err : 0;
+			continue;
+		}
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-- 
2.14.4
