From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/18] tools lib api: The tracing_mnt variable doesn't need to be global
Date: Sat, 19 May 2018 07:54:51 -0300
Message-ID: <20180519105507.16450-3-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its only used in the file it is defined, so just make it static.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p5x29u6mq2ml3mtnbg9844ad@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/tracing_path.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 7b7fd0b18551..4f8ec7d476b8 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -13,8 +13,7 @@
 
 #include "tracing_path.h"
 
-
-char tracing_mnt[PATH_MAX]         = "/sys/kernel/debug";
+static char tracing_mnt[PATH_MAX]  = "/sys/kernel/debug";
 char tracing_path[PATH_MAX]        = "/sys/kernel/debug/tracing";
 char tracing_events_path[PATH_MAX] = "/sys/kernel/debug/tracing/events";
 
@@ -129,7 +128,7 @@ int tracing_path__strerror_open_tp(int err, char *buf, size_t size,
 		snprintf(buf, size,
 			 "Error:\tNo permissions to read %s/%s\n"
 			 "Hint:\tTry 'sudo mount -o remount,mode=755 %s'\n",
-			 tracing_events_path, filename, tracing_mnt);
+			 tracing_events_path, filename, tracing_path_mount());
 	}
 		break;
 	default:
-- 
2.14.3
