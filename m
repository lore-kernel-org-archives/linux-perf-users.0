From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/12] perf python: Make clang_has_option() work on Python 3
Date: Mon,  8 Oct 2018 21:54:24 -0300
Message-ID: <20181009005427.6607-10-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Eduardo Habkost <ehabkost@redhat.com>

Use a bytes literal so it works with Python 3's version of Popen().
Note that the b"..." syntax requires Python 2.6+.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20181005204058.7966-2-ehabkost@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 1942f6dd24f6..261a55e7e1b2 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -5,7 +5,7 @@ from subprocess import Popen, PIPE
 from re import sub
 
 def clang_has_option(option):
-    return [o for o in Popen(['clang', option], stderr=PIPE).stderr.readlines() if "unknown argument" in o] == [ ]
+    return [o for o in Popen(['clang', option], stderr=PIPE).stderr.readlines() if b"unknown argument" in o] == [ ]
 
 cc = getenv("CC")
 if cc == "clang":
-- 
2.14.4
