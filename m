From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/24] perf tools: Do not check ABI headers in a detached tarball build
Date: Mon, 23 Oct 2017 20:47:29 -0300
Message-ID: <20171023234736.5335-18-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we use one of:

  [acme@jouet linux]$ make help | grep perf
    perf-tar-src-pkg    - Build perf-4.14.0-rc3.tar source tarball
    perf-targz-src-pkg  - Build perf-4.14.0-rc3.tar.gz source tarball
    perf-tarbz2-src-pkg - Build perf-4.14.0-rc3.tar.bz2 source tarball
    perf-tarxz-src-pkg  - Build perf-4.14.0-rc3.tar.xz source tarball
  [acme@jouet linux]$

I.e. when we create a detached tarball to build perf outside outside the
enveloping kernel sources (from a kernel tarball or a checked out
linux.git directory) we by definition can't check for differences among
the tools/{include,arch}, etc files we originally copied from the
kernel, so bail out in that case, to avoid warnings when doing the
detached builds.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-vbrga0mhplv7niwxr3ghjyxv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 932fda54b8a6..322629423b49 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -57,6 +57,11 @@ check () {
 }
 
 
+# Check if we have the kernel headers (tools/perf/../../include), else
+# we're probably on a detached tarball, so no point in trying to check
+# differences.
+test -d ../../include || exit 0
+
 # simple diff check
 for i in $HEADERS; do
   check $i -B
-- 
2.13.6
