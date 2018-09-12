From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/7] tools headers uapi: Update tools's copy of linux/if_link.h
Date: Wed, 12 Sep 2018 15:55:08 -0300
Message-ID: <20180912185509.32187-7-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <jakub.kicinski@netronome.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Steffen Klassert <steffen.klassert@secunet.com>, Stephen Hemminger <stephen@networkplumber.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

	3e7a50ceb11e ("net: report min and max mtu network device settings")
	2756f68c3149 ("net: bridge: add support for backup port")
	a25717d2b604 ("xdp: support simultaneous driver and hw XDP attachment")
	4f91da26c811 ("xdp: add per mode attributes for attached programs")
	f203b76d7809 ("xfrm: Add virtual xfrm interfaces")

Silencing this libbpf build warning:

	Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xd9ztioa894zemv8ag8kg64u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index cf01b6824244..43391e2d1153 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -164,6 +164,8 @@ enum {
 	IFLA_CARRIER_UP_COUNT,
 	IFLA_CARRIER_DOWN_COUNT,
 	IFLA_NEW_IFINDEX,
+	IFLA_MIN_MTU,
+	IFLA_MAX_MTU,
 	__IFLA_MAX
 };
 
@@ -334,6 +336,7 @@ enum {
 	IFLA_BRPORT_GROUP_FWD_MASK,
 	IFLA_BRPORT_NEIGH_SUPPRESS,
 	IFLA_BRPORT_ISOLATED,
+	IFLA_BRPORT_BACKUP_PORT,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
@@ -459,6 +462,16 @@ enum {
 
 #define IFLA_MACSEC_MAX (__IFLA_MACSEC_MAX - 1)
 
+/* XFRM section */
+enum {
+	IFLA_XFRM_UNSPEC,
+	IFLA_XFRM_LINK,
+	IFLA_XFRM_IF_ID,
+	__IFLA_XFRM_MAX
+};
+
+#define IFLA_XFRM_MAX (__IFLA_XFRM_MAX - 1)
+
 enum macsec_validation_type {
 	MACSEC_VALIDATE_DISABLED = 0,
 	MACSEC_VALIDATE_CHECK = 1,
@@ -920,6 +933,7 @@ enum {
 	XDP_ATTACHED_DRV,
 	XDP_ATTACHED_SKB,
 	XDP_ATTACHED_HW,
+	XDP_ATTACHED_MULTI,
 };
 
 enum {
@@ -928,6 +942,9 @@ enum {
 	IFLA_XDP_ATTACHED,
 	IFLA_XDP_FLAGS,
 	IFLA_XDP_PROG_ID,
+	IFLA_XDP_DRV_PROG_ID,
+	IFLA_XDP_SKB_PROG_ID,
+	IFLA_XDP_HW_PROG_ID,
 	__IFLA_XDP_MAX,
 };
 
-- 
2.14.4
