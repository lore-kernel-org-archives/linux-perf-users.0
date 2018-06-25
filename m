From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/19] tools include uapi: Synchronize bpf.h with the kernel
Date: Mon, 25 Jun 2018 14:40:37 -0300
Message-ID: <20180625174045.25765-12-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the rename in:

  bd3a08aaa9a3 ("bpf: flowlabel in bpf_fib_lookup should be flowinfo")

Silencing this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zd1sgtbybtjrrt7bqdybu0s0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e0b06784f227..59b19b6a40d7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2630,7 +2630,7 @@ struct bpf_fib_lookup {
 	union {
 		/* inputs to lookup */
 		__u8	tos;		/* AF_INET  */
-		__be32	flowlabel;	/* AF_INET6 */
+		__be32	flowinfo;	/* AF_INET6, flow_label + priority */
 
 		/* output: metric of fib result (IPv4/IPv6 only) */
 		__u32	rt_metric;
-- 
2.14.3
