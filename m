From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/30] tools headers uapi: Update linux/in.h copy
Date: Mon, 11 Mar 2019 23:01:55 -0300
Message-ID: <20190312020204.22092-22-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, "David S . Miller" <davem@davemloft.net>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  4effd28c1245 ("bridge: join all-snoopers multicast address")

That do not generate any changes in tools/ use of this file.

Silences this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Lüssing <linus.luessing@c0d3.blue>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ifpl634035266ho6wxuqgo81@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index a55cb8b10165..e7ad9d350a28 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -292,10 +292,11 @@ struct sockaddr_in {
 #define	IN_LOOPBACK(a)		((((long int) (a)) & 0xff000000) == 0x7f000000)
 
 /* Defines for Multicast INADDR */
-#define INADDR_UNSPEC_GROUP   	0xe0000000U	/* 224.0.0.0   */
-#define INADDR_ALLHOSTS_GROUP 	0xe0000001U	/* 224.0.0.1   */
-#define INADDR_ALLRTRS_GROUP    0xe0000002U	/* 224.0.0.2 */
-#define INADDR_MAX_LOCAL_GROUP  0xe00000ffU	/* 224.0.0.255 */
+#define INADDR_UNSPEC_GROUP		0xe0000000U	/* 224.0.0.0   */
+#define INADDR_ALLHOSTS_GROUP		0xe0000001U	/* 224.0.0.1   */
+#define INADDR_ALLRTRS_GROUP		0xe0000002U	/* 224.0.0.2 */
+#define INADDR_ALLSNOOPERS_GROUP	0xe000006aU	/* 224.0.0.106 */
+#define INADDR_MAX_LOCAL_GROUP		0xe00000ffU	/* 224.0.0.255 */
 #endif
 
 /* <asm/byteorder.h> contains the htonl type stuff.. */
-- 
2.20.1
