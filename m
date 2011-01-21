From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] perf: Fix timechart idle box drawings
Date: Fri, 21 Jan 2011 15:30:08 +0100
Message-ID: <1295620209-13859-1-git-send-email-trenn@suse.de>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57113 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab1AUOaU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 21 Jan 2011 09:30:20 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: mingo@elte.hu
Cc: Thomas Renninger <trenn@suse.de>, arjan@infradead.org, linux-perf-users@vger.kernel.org

Without this patch eye of gnome and firfox will draw the
boxes black.
Compare with the other box declartions, looks
like some typos slipped in which get fixed with this
patch.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: arjan@infradead.org
CC: mingo@elte.hu
CC: linux-perf-users@vger.kernel.org
---
 tools/perf/util/svghelper.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index b3637db..8ee5d11 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -455,9 +455,9 @@ void svg_legenda(void)
 		return;
 
 	svg_legenda_box(0,	"Running", "sample");
-	svg_legenda_box(100,	"Idle","rect.c1");
-	svg_legenda_box(200,	"Deeper Idle", "rect.c3");
-	svg_legenda_box(350,	"Deepest Idle", "rect.c6");
+	svg_legenda_box(100,	"Idle","c1");
+	svg_legenda_box(200,	"Deeper Idle", "c3");
+	svg_legenda_box(350,	"Deepest Idle", "c6");
 	svg_legenda_box(550,	"Sleeping", "process2");
 	svg_legenda_box(650,	"Waiting for cpu", "waiting");
 	svg_legenda_box(800,	"Blocked on IO", "blocked");
-- 
1.7.3.4
