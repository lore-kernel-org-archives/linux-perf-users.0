From: Alexis Berlemont <alexis.berlemont@gmail.com>
Subject: Minor fix
Date: Mon, 25 Jun 2012 00:33:43 +0200
Message-ID: <CAMesUR4=wH-NSJ+ovoPFHgcQcGcr7Vw2OE5p_vXOqWbbwNqBBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:63063 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab2FXWdp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 24 Jun 2012 18:33:45 -0400
Received: by wibhq12 with SMTP id hq12so2196389wib.1
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Jun 2012 15:33:43 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Has anyway try to compile perf at the latest tag (v3.5-rc4) or on
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git ?

I did not manage to do it without this little fix.

Did I miss something obvious?

Alexis.


From d2f83b6f0a7a3805f640e722f2c6ccfcdbbd91fc Mon Sep 17 00:00:00 2001
From: Alexis Berlemont <alexis.berlemont@gmail.com>
Date: Mon, 25 Jun 2012 00:26:08 +0200
Subject: [PATCH] perf: minor compilation fix (wrong include path)

---
 tools/perf/util/evsel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9f6cebd..d5491f1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -15,7 +15,7 @@
 #include "cpumap.h"
 #include "thread_map.h"
 #include "target.h"
-#include "../../include/linux/perf_event.h"
+#include "../../../include/linux/perf_event.h"

 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 #define GROUP_FD(group_fd, cpu) (*(int *)xyarray__entry(group_fd, cpu, 0))
-- 
1.7.10
