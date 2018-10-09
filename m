From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/12] perf python: More portable way to make CFLAGS work with clang
Date: Mon,  8 Oct 2018 21:54:25 -0300
Message-ID: <20181009005427.6607-11-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Eduardo Habkost <ehabkost@redhat.com>

The existing code that tries to make CFLAGS compatible with clang
doesn't work with Python 3.

Instead of trying to touch _sysconfigdata.build_time_vars directly,
change the dictionary returned by disutils.sysconfig.get_config_vars().
This works on both Python 2 and Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20181005204058.7966-3-ehabkost@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 261a55e7e1b2..63f758c655d5 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -9,12 +9,14 @@ def clang_has_option(option):
 
 cc = getenv("CC")
 if cc == "clang":
-    from _sysconfigdata import build_time_vars
-    build_time_vars["CFLAGS"] = sub("-specs=[^ ]+", "", build_time_vars["CFLAGS"])
-    if not clang_has_option("-mcet"):
-        build_time_vars["CFLAGS"] = sub("-mcet", "", build_time_vars["CFLAGS"])
-    if not clang_has_option("-fcf-protection"):
-        build_time_vars["CFLAGS"] = sub("-fcf-protection", "", build_time_vars["CFLAGS"])
+    from distutils.sysconfig import get_config_vars
+    vars = get_config_vars()
+    for var in ('CFLAGS', 'OPT'):
+        vars[var] = sub("-specs=[^ ]+", "", vars[var])
+        if not clang_has_option("-mcet"):
+            vars[var] = sub("-mcet", "", vars[var])
+        if not clang_has_option("-fcf-protection"):
+            vars[var] = sub("-fcf-protection", "", vars[var])
 
 from distutils.core import setup, Extension
 
-- 
2.14.4
