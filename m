From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/21] perf trace beauty: Do not print NULL strarray entries
Date: Wed,  1 Aug 2018 18:36:33 -0300
Message-ID: <20180801213648.4814-7-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We may have string tables where not all slots have values, in those
cases its better to print the numeric value, for instance:

In the table below we would show "protocol: (null)" for

      socket_ipproto[3]

Where it would be better to show "protocol: 3".

      $ tools/perf/trace/beauty/socket_ipproto.sh
      static const char *socket_ipproto[] = {
            [0] = "IP",
            [103] = "PIM",
            [108] = "COMP",
            [12] = "PUP",
            [132] = "SCTP",
            [136] = "UDPLITE",
            [137] = "MPLS",
            [17] = "UDP",
            [1] = "ICMP",
            [22] = "IDP",
            [255] = "RAW",
            [29] = "TP",
            [2] = "IGMP",
            [33] = "DCCP",
            [41] = "IPV6",
            [46] = "RSVP",
            [47] = "GRE",
            [4] = "IPIP",
            [50] = "ESP",
            [51] = "AH",
            [6] = "TCP",
            [8] = "EGP",
            [92] = "MTP",
            [94] = "BEETPH",
            [98] = "ENCAP",
      };
      $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-7djfak94eb3b9ltr79cpn3ti@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a748eca2edb..632ef5f8f060 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -291,7 +291,7 @@ size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const cha
 {
 	int idx = val - sa->offset;
 
-	if (idx < 0 || idx >= sa->nr_entries)
+	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL)
 		return scnprintf(bf, size, intfmt, val);
 
 	return scnprintf(bf, size, "%s", sa->entries[idx]);
-- 
2.14.4
