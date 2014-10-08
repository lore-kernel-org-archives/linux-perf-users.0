From: William Cohen <wcohen@redhat.com>
Subject: [PATCH 2/2] The arm64 dwarf unwinder is missing a needed include
Date: Wed,  8 Oct 2014 12:45:05 -0400
Message-ID: <1412786705-19994-2-git-send-email-wcohen@redhat.com>
References: <1412786705-19994-1-git-send-email-wcohen@redhat.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673AbaJHQpR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 8 Oct 2014 12:45:17 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s98GjGeK009433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-perf-users@vger.kernel.org>; Wed, 8 Oct 2014 12:45:17 -0400
In-Reply-To: <1412786705-19994-1-git-send-email-wcohen@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: William Cohen <wcohen@redhat.com>

When the libunwind is available perf does not build on arm64 machines
because debug.h is not included.  The debug.h provides some needed
defines.

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 tools/perf/arch/arm64/util/unwind-libunwind.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm64/util/unwind-libunwind.c b/tools/perf/arch/arm64/util/unwind-libunwind.c
index 436ee43..a87afa9 100644
--- a/tools/perf/arch/arm64/util/unwind-libunwind.c
+++ b/tools/perf/arch/arm64/util/unwind-libunwind.c
@@ -3,6 +3,7 @@
 #include <libunwind.h>
 #include "perf_regs.h"
 #include "../../util/unwind.h"
+#include "../../util/debug.h"
 
 int libunwind__arch_reg_id(int regnum)
 {
-- 
1.9.3
