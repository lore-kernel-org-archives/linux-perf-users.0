From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/24] perf python: Remove -fstack-clash-protection when building with some clang versions
Date: Mon, 21 Jan 2019 20:57:05 -0300
Message-ID: <20190121235706.20005-24-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Thiago Macieira <thiago.macieira@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

These options are not present in some (all?) clang versions, so when we
build for a distro that has a gcc new enough to have these options and
that the distro python build config settings use them but clang doesn't
support, b00m.

This is the case with fedora rawhide (now gearing towards f30), so check
if clang has the  and remove the missing ones from CFLAGS.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thiago Macieira <thiago.macieira@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5q50q9w458yawgxf9ez54jbp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 63f758c655d5..64d1f36dee99 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -17,6 +17,8 @@ if cc == "clang":
             vars[var] = sub("-mcet", "", vars[var])
         if not clang_has_option("-fcf-protection"):
             vars[var] = sub("-fcf-protection", "", vars[var])
+        if not clang_has_option("-fstack-clash-protection"):
+            vars[var] = sub("-fstack-clash-protection", "", vars[var])
 
 from distutils.core import setup, Extension
 
-- 
2.20.1
