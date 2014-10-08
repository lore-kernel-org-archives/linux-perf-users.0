From: William Cohen <wcohen@redhat.com>
Subject: [PATCH 1/2] The ARM dwarf unwinder is missing some needed includes
Date: Wed,  8 Oct 2014 12:45:04 -0400
Message-ID: <1412786705-19994-1-git-send-email-wcohen@redhat.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:8610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673AbaJHQpK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 8 Oct 2014 12:45:10 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s98GjA7F000689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-perf-users@vger.kernel.org>; Wed, 8 Oct 2014 12:45:10 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: William Cohen <wcohen@redhat.com>

When the libunwind is available perf does not build on ARM machines
because debug.h is not included in a couple files.  The debug.h provides
some needed defines.

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c    | 1 +
 tools/perf/arch/arm/util/unwind-libunwind.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index 9f870d2..62eff84 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -3,6 +3,7 @@
 #include "thread.h"
 #include "map.h"
 #include "event.h"
+#include "debug.h"
 #include "tests/tests.h"
 
 #define STACK_SIZE 8192
diff --git a/tools/perf/arch/arm/util/unwind-libunwind.c b/tools/perf/arch/arm/util/unwind-libunwind.c
index 729ed69..62c397e 100644
--- a/tools/perf/arch/arm/util/unwind-libunwind.c
+++ b/tools/perf/arch/arm/util/unwind-libunwind.c
@@ -3,6 +3,7 @@
 #include <libunwind.h>
 #include "perf_regs.h"
 #include "../../util/unwind.h"
+#include "../../util/debug.h"
 
 int libunwind__arch_reg_id(int regnum)
 {
-- 
1.9.3
