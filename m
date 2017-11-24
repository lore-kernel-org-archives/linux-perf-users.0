From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/11] tools headers: Follow the upstream UAPI header version 100% differ from the kernel
Date: Fri, 24 Nov 2017 12:02:22 -0300
Message-ID: <20171124150232.18676-2-acme@kernel.org>
References: <20171124150232.18676-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171124150232.18676-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Remove this from check-headers.sh:

  opts="--ignore-blank-lines --ignore-space-change"

as the easiest policy is to just follow the upstream UAPI header version 100%.
Pure space-only changes are comparatively rare.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20171121084111.y6p5zwqso2cbms5s@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 77406d25e521..e66a8a7bcced 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -45,7 +45,6 @@ include/uapi/asm-generic/mman-common.h
 
 check () {
   file=$1
-  opts="--ignore-blank-lines --ignore-space-change"
 
   shift
   while [ -n "$*" ]; do
-- 
2.13.6
