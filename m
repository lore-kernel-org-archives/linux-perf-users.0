From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] perf: Fix time function double declaration with glibc
Date: Fri, 21 Jan 2011 15:30:09 +0100
Message-ID: <1295620209-13859-2-git-send-email-trenn@suse.de>
References: <1295620209-13859-1-git-send-email-trenn@suse.de>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57114 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941Ab1AUOaU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 21 Jan 2011 09:30:20 -0500
In-Reply-To: <1295620209-13859-1-git-send-email-trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: mingo@elte.hu
Cc: Thomas Renninger <trenn@suse.de>, arjan@infradead.org, linux-perf-users@vger.kernel.org

It's enough to include the local "debug.h" file to
trigger it.
man time reveals this is already declared in glibc:
time - get time in seconds
#include <time.h>
-> rename the variable.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: arjan@infradead.org
CC: mingo@elte.hu
CC: linux-perf-users@vger.kernel.org
---
 tools/perf/util/svghelper.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 8ee5d11..e40a00d 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -43,11 +43,11 @@ static double cpu2y(int cpu)
 	return cpu2slot(cpu) * SLOT_MULT;
 }
 
-static double time2pixels(u64 time)
+static double time2pixels(u64 __time)
 {
 	double X;
 
-	X = 1.0 * svg_page_width * (time - first_time) / (last_time - first_time);
+	X = 1.0 * svg_page_width * (__time - first_time) / (last_time - first_time);
 	return X;
 }
 
-- 
1.7.3.4
