From: Milian Wolff <mail@milianw.de>
Subject: [PATCH 001/001] perf: let trace write to stderr by default
Date: Tue, 04 Aug 2015 18:39:16 +0200
Message-ID: <3305230.aOMPB1fPqd@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4745065.VgfM65dfcy"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:52191 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbbHDQjS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 12:39:18 -0400
Received: from milian-kdab2.localnet (unknown [185.28.184.2])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id A225A6280966
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2015 18:39:16 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart4745065.VgfM65dfcy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

See attached trivial patch which brings trace a bit closer to strace.

I've never published a patch to the Kernel yet, I hope it's OK as-is. I can 
amend it at will if you have any requests to the style.

Cheers
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart4745065.VgfM65dfcy
Content-Disposition: attachment; filename="0001-Write-trace-output-to-stderr-by-default-just-like-st.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-Write-trace-output-to-stderr-by-default-just-like-st.patch"

From 188476d65bab17ad99f5bdf65294160ef2d5f49b Mon Sep 17 00:00:00 2001
From: Milian Wolff <milian.wolff@kdab.com>
Date: Tue, 4 Aug 2015 18:30:52 +0200
Subject: [PATCH] perf: let trace write to stderr by default

Without this patch, it is cumbersome to read the trace output
but ignoring the normal, potentially verbose, output of the debuggee.
One common example is doing something like the following:

perf trace -s find /tmp > /dev/null

Without this patch, the trace summary will be lost. Now, it will
still be printed at the end. This behavior is also applied by strace.
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 39ad4d0..d183d88 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2778,7 +2778,7 @@ int cmd_trace(int argc, const char **argv, const char *prefix __maybe_unused)
 			.mmap_pages    = UINT_MAX,
 			.proc_map_timeout  = 500,
 		},
-		.output = stdout,
+		.output = stderr,
 		.show_comm = true,
 		.trace_syscalls = true,
 	};
-- 
2.5.0


--nextPart4745065.VgfM65dfcy--
