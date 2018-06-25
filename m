From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/19] tools include uapi: Update if_link.h to pick IFLA_{BRPORT_ISOLATED,VXLAN_TTL_INHERIT}
Date: Mon, 25 Jun 2018 14:40:36 -0300
Message-ID: <20180625174045.25765-11-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Leblond <eric@regit.org>, Hangbin Liu <liuhangbin@gmail.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The IFLA_BRPORT_ISOLATED and IFLA_VXLAN_TTL_INHERIT defines were added in:

  7d850abd5f4e ("net: bridge: add support for port isolation")
  72f6d71e491e ("vxlan: add ttl inherit support")

Pick them, silencing this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Leblond <eric@regit.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Link: https://lkml.kernel.org/n/tip-ezi5u0mmdqm0wfm0y2y8176r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 68699f654118..cf01b6824244 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -333,6 +333,7 @@ enum {
 	IFLA_BRPORT_BCAST_FLOOD,
 	IFLA_BRPORT_GROUP_FWD_MASK,
 	IFLA_BRPORT_NEIGH_SUPPRESS,
+	IFLA_BRPORT_ISOLATED,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
@@ -516,6 +517,7 @@ enum {
 	IFLA_VXLAN_COLLECT_METADATA,
 	IFLA_VXLAN_LABEL,
 	IFLA_VXLAN_GPE,
+	IFLA_VXLAN_TTL_INHERIT,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
-- 
2.14.3
