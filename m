From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/28] tools headers uapi: Update linux/if_link.h header copy
Date: Wed, 31 Oct 2018 13:45:04 -0300
Message-ID: <20181031164508.4784-25-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Leblond <eric@regit.org>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  9163a0fc1f0c ("net: bridge: add support for per-port vlan stats")

And silence this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Leblond <eric@regit.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Link: https://lkml.kernel.org/n/tip-7p53ghippywz7fqkwo3nkzet@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 58faab897201..1debfa42cba1 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -287,6 +287,7 @@ enum {
 	IFLA_BR_MCAST_STATS_ENABLED,
 	IFLA_BR_MCAST_IGMP_VERSION,
 	IFLA_BR_MCAST_MLD_VERSION,
+	IFLA_BR_VLAN_STATS_PER_PORT,
 	__IFLA_BR_MAX,
 };
 
-- 
2.14.4
