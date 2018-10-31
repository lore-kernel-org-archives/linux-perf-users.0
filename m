From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/28] tools headers uapi: Update linux/netlink.h header copy
Date: Wed, 31 Oct 2018 13:45:03 -0300
Message-ID: <20181031164508.4784-24-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexei Starovoitov <ast@kernel.org>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric Leblond <eric@regit.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Picking the changes from:

  89d35528d17d ("netlink: Add new socket option to enable strict checking on dumps")

To silence this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differs from latest version at 'include/uapi/linux/netlink.h'

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Leblond <eric@regit.org>
Link: https://lkml.kernel.org/n/tip-1xymkfjpmhxfzrs46t8z8mjw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/netlink.h b/tools/include/uapi/linux/netlink.h
index 776bc92e9118..486ed1f0c0bc 100644
--- a/tools/include/uapi/linux/netlink.h
+++ b/tools/include/uapi/linux/netlink.h
@@ -155,6 +155,7 @@ enum nlmsgerr_attrs {
 #define NETLINK_LIST_MEMBERSHIPS	9
 #define NETLINK_CAP_ACK			10
 #define NETLINK_EXT_ACK			11
+#define NETLINK_DUMP_STRICT_CHK		12
 
 struct nl_pktinfo {
 	__u32	group;
-- 
2.14.4
