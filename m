From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/21] perf beauty: Add a generator for IPPROTO_ socket's protocol constants
Date: Wed,  1 Aug 2018 18:36:32 -0300
Message-ID: <20180801213648.4814-6-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It'll use tools/include copy of linux/in.h to generate a table to be
used by tools, initially by the 'socket' and 'socketpair' beautifiers in
'perf trace', but that could also be used to translate from a string
constant to the integer value to be used in a eBPF or tracefs tracepoint
filter.

When used without any args it produces:

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
Link: https://lkml.kernel.org/n/tip-v9rafqh3qn6b9kp9vfvj9f8s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/socket_ipproto.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100755 tools/perf/trace/beauty/socket_ipproto.sh

diff --git a/tools/perf/trace/beauty/socket_ipproto.sh b/tools/perf/trace/beauty/socket_ipproto.sh
new file mode 100755
index 000000000000..a3cc24633bec
--- /dev/null
+++ b/tools/perf/trace/beauty/socket_ipproto.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *socket_ipproto[] = {\n"
+regex='^[[:space:]]+IPPROTO_(\w+)[[:space:]]+=[[:space:]]+([[:digit:]]+),.*'
+
+egrep $regex ${header_dir}/in.h | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
-- 
2.14.4
