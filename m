From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/16] tools headers uapi: Sync linux/in.h copy from the kernel sources
Date: Fri,  4 Jan 2019 15:33:29 -0300
Message-ID: <20190104183337.12771-9-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Dave Taht <dave.taht@gmail.com>, "David S . Miller" <davem@davemloft.net>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in this cset:

  65cab850f0ee ("net: Allow class-e address assignment via ifconfig ioctl")

The macros changed in this cset are not used in tools/, so this is just
to silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: Dave Taht <dave.taht@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-smghvyxb3budqd1e70i0ylw1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 48e8a225b985..f6052e70bf40 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -266,10 +266,14 @@ struct sockaddr_in {
 
 #define	IN_CLASSD(a)		((((long int) (a)) & 0xf0000000) == 0xe0000000)
 #define	IN_MULTICAST(a)		IN_CLASSD(a)
-#define IN_MULTICAST_NET	0xF0000000
+#define	IN_MULTICAST_NET	0xe0000000
 
-#define	IN_EXPERIMENTAL(a)	((((long int) (a)) & 0xf0000000) == 0xf0000000)
-#define	IN_BADCLASS(a)		IN_EXPERIMENTAL((a))
+#define	IN_BADCLASS(a)		((((long int) (a) ) == 0xffffffff)
+#define	IN_EXPERIMENTAL(a)	IN_BADCLASS((a))
+
+#define	IN_CLASSE(a)		((((long int) (a)) & 0xf0000000) == 0xf0000000)
+#define	IN_CLASSE_NET		0xffffffff
+#define	IN_CLASSE_NSHIFT	0
 
 /* Address to accept any incoming messages. */
 #define	INADDR_ANY		((unsigned long int) 0x00000000)
-- 
2.20.1
