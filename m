From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/8] tools headers uapi: Sync linux/in.h copy from the kernel sources
Date: Tue,  5 Feb 2019 12:07:04 -0300
Message-ID: <20190205150708.9012-5-acme@kernel.org>
References: <20190205150708.9012-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, "David S . Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in this cset:

  f275ee0fa3a0 ("IN_BADCLASS: fix macro to actually work")

The macros changed in this cset are not used in tools/, so this is just
to silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xbk34kwamn8bw8ywpuxetct9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index f6052e70bf40..a55cb8b10165 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -268,7 +268,7 @@ struct sockaddr_in {
 #define	IN_MULTICAST(a)		IN_CLASSD(a)
 #define	IN_MULTICAST_NET	0xe0000000
 
-#define	IN_BADCLASS(a)		((((long int) (a) ) == 0xffffffff)
+#define	IN_BADCLASS(a)		(((long int) (a) ) == (long int)0xffffffff)
 #define	IN_EXPERIMENTAL(a)	IN_BADCLASS((a))
 
 #define	IN_CLASSE(a)		((((long int) (a)) & 0xf0000000) == 0xf0000000)
-- 
2.20.1
