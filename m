From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/86] perf trace: Remove F_ from some of the fcntl command strings
Date: Wed, 19 Jul 2017 10:55:54 -0300
Message-ID: <20170719135717.1285-4-acme@kernel.org>
References: <20170719135717.1285-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719135717.1285-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The initial ones already had that "F_" prefix stripped to make things
shorter, some hadn't, do it now.

We do this to make the 'perf trace' output more compact. At some point
perhaps the best thing to do is to have the tool do this stripping
automatically, letting the user also decide if this is to be done or
not. For now, be consistent.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-2iot106xkl8rgb0hb8zm3gq5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4b2a5d298197..cfe1858ed074 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -407,9 +407,9 @@ static DEFINE_STRARRAY(whences);
 
 static const char *fcntl_cmds[] = {
 	"DUPFD", "GETFD", "SETFD", "GETFL", "SETFL", "GETLK", "SETLK",
-	"SETLKW", "SETOWN", "GETOWN", "SETSIG", "GETSIG", "F_GETLK64",
-	"F_SETLK64", "F_SETLKW64", "F_SETOWN_EX", "F_GETOWN_EX",
-	"F_GETOWNER_UIDS",
+	"SETLKW", "SETOWN", "GETOWN", "SETSIG", "GETSIG", "GETLK64",
+	"SETLK64", "SETLKW64", "SETOWN_EX", "GETOWN_EX",
+	"GETOWNER_UIDS",
 };
 static DEFINE_STRARRAY(fcntl_cmds);
 
-- 
2.9.4
