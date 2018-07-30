From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/5] tools headers uapi: Refresh linux/bpf.h copy
Date: Mon, 30 Jul 2018 17:50:29 -0300
Message-ID: <20180730205031.12853-4-acme@kernel.org>
References: <20180730205031.12853-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  4c79579b44b1 ("bpf: Change bpf_fib_lookup to return lookup status")

That do not entail changes in tools/perf/ use of it, elliminating the
following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yei494y6b3mn6bjzz9g0ws12@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 59b19b6a40d7..b7db3261c62d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1857,7 +1857,8 @@ union bpf_attr {
  *		is resolved), the nexthop address is returned in ipv4_dst
  *		or ipv6_dst based on family, smac is set to mac address of
  *		egress device, dmac is set to nexthop mac address, rt_metric
- *		is set to metric from route (IPv4/IPv6 only).
+ *		is set to metric from route (IPv4/IPv6 only), and ifindex
+ *		is set to the device index of the nexthop from the FIB lookup.
  *
  *             *plen* argument is the size of the passed in struct.
  *             *flags* argument can be a combination of one or more of the
@@ -1873,9 +1874,10 @@ union bpf_attr {
  *             *ctx* is either **struct xdp_md** for XDP programs or
  *             **struct sk_buff** tc cls_act programs.
  *     Return
- *             Egress device index on success, 0 if packet needs to continue
- *             up the stack for further processing or a negative error in case
- *             of failure.
+ *		* < 0 if any input argument is invalid
+ *		*   0 on success (packet is forwarded, nexthop neighbor exists)
+ *		* > 0 one of **BPF_FIB_LKUP_RET_** codes explaining why the
+ *		*     packet is not forwarded or needs assist from full stack
  *
  * int bpf_sock_hash_update(struct bpf_sock_ops_kern *skops, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -2612,6 +2614,18 @@ struct bpf_raw_tracepoint_args {
 #define BPF_FIB_LOOKUP_DIRECT  BIT(0)
 #define BPF_FIB_LOOKUP_OUTPUT  BIT(1)
 
+enum {
+	BPF_FIB_LKUP_RET_SUCCESS,      /* lookup successful */
+	BPF_FIB_LKUP_RET_BLACKHOLE,    /* dest is blackholed; can be dropped */
+	BPF_FIB_LKUP_RET_UNREACHABLE,  /* dest is unreachable; can be dropped */
+	BPF_FIB_LKUP_RET_PROHIBIT,     /* dest not allowed; can be dropped */
+	BPF_FIB_LKUP_RET_NOT_FWDED,    /* packet is not forwarded */
+	BPF_FIB_LKUP_RET_FWD_DISABLED, /* fwding is not enabled on ingress */
+	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
+	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
+	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+};
+
 struct bpf_fib_lookup {
 	/* input:  network family for lookup (AF_INET, AF_INET6)
 	 * output: network family of egress nexthop
@@ -2625,7 +2639,11 @@ struct bpf_fib_lookup {
 
 	/* total length of packet from network header - used for MTU check */
 	__u16	tot_len;
-	__u32	ifindex;  /* L3 device index for lookup */
+
+	/* input: L3 device index for lookup
+	 * output: device index from FIB lookup
+	 */
+	__u32	ifindex;
 
 	union {
 		/* inputs to lookup */
-- 
2.14.4
