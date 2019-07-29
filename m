From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/12] tools headers UAPI: Sync if_link.h with the kernel
Date: Mon, 29 Jul 2019 18:14:55 -0300
Message-ID: <20190729211456.6380-9-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, "David S . Miller" <davem@davemloft.net>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Vincent Bernat <vincent@bernat.ch>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes in:

  07a4ddec3ce9 ("bonding: add an option to specify a delay between peer notifications")

And silence this build warning:

  Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vincent Bernat <vincent@bernat.ch>
Link: https://lkml.kernel.org/n/tip-3liw4exxh8goc0rq9xryl2kv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 7d113a9602f0..4a8c02cafa9a 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -695,6 +695,7 @@ enum {
 	IFLA_VF_IB_NODE_GUID,	/* VF Infiniband node GUID */
 	IFLA_VF_IB_PORT_GUID,	/* VF Infiniband port GUID */
 	IFLA_VF_VLAN_LIST,	/* nested list of vlans, option for QinQ */
+	IFLA_VF_BROADCAST,	/* VF broadcast */
 	__IFLA_VF_MAX,
 };
 
@@ -705,6 +706,10 @@ struct ifla_vf_mac {
 	__u8 mac[32]; /* MAX_ADDR_LEN */
 };
 
+struct ifla_vf_broadcast {
+	__u8 broadcast[32];
+};
+
 struct ifla_vf_vlan {
 	__u32 vf;
 	__u32 vlan; /* 0 - 4095, 0 disables VLAN filter */
-- 
2.21.0
