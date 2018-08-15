From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/35] perf python: Remove -mcet and -fcf-protection when building with clang
Date: Wed, 15 Aug 2018 12:06:07 -0300
Message-ID: <20180815150611.32080-32-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

These options are not present in older clang versions, so when we build
for a distro that has a gcc new enough to have these options and that
the distro python build config settings use them but clang doesn't
support, b00m.

This is the case with fedora 28 and rawhide, so check if clang has the
options and remove the missing ones from CFLAGS.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-7asds7yn6gzg6ns1lw17ukul@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 001be4f9d3b9..97efbcad076e 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,12 +1,20 @@
 #!/usr/bin/python
 
 from os import getenv
+from subprocess import Popen, PIPE
+from re import sub
+
+def clang_has_option(option):
+    return [o for o in Popen(['clang', option], stderr=PIPE).stderr.readlines() if "unknown argument" in o] == [ ]
 
 cc = getenv("CC")
 if cc == "clang":
     from _sysconfigdata import build_time_vars
-    from re import sub
     build_time_vars["CFLAGS"] = sub("-specs=[^ ]+", "", build_time_vars["CFLAGS"])
+    if not clang_has_option("-mcet"):
+        build_time_vars["CFLAGS"] = sub("-mcet", "", build_time_vars["CFLAGS"])
+    if not clang_has_option("-fcf-protection"):
+        build_time_vars["CFLAGS"] = sub("-fcf-protection", "", build_time_vars["CFLAGS"])
 
 from distutils.core import setup, Extension
 
-- 
2.14.4
