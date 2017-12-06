From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/36] tools headers: Follow the upstream UAPI header version 100% differ from the kernel
Date: Wed,  6 Dec 2017 11:40:40 -0300
Message-ID: <20171206144115.15097-2-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751570AbdLFOln (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Dec 2017 09:41:43 -0500
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

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
