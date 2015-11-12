From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: /tmp/perf-PID.map ownership
Date: Thu, 12 Nov 2015 10:27:26 -0800
Message-ID: <CAE40pdctG6CUcmangzqSKmd7GkSv1oz7jP5hR-=GFSTTeQ-2sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35040 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbbKLS14 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 13:27:56 -0500
Received: by ioc74 with SMTP id 74so73690974ioc.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 10:27:55 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day,

# perf record -F 99 -a -g -- sleep 30
[...]
# perf report -n --stdio
File /tmp/perf-25958.map not owned by current user or root, ignoring it.

Can root bypass this test? I'm root, and profiling apps from different
user-IDs, and the current workaround is to "chown root
/tmp/perf*.map". Shouldn't root be able to read these map files? Could
we:

--- linux-perf/tools/perf/util/symbol.c    2015-11-03 20:08:40.829320940 +0000
+++ linux-perf-edited/tools/perf/util/symbol.c    2015-11-12
18:21:35.487077872 +0000
@@ -1433,14 +1433,17 @@
     dso->adjust_symbols = 0;

     if (strncmp(dso->name, "/tmp/perf-", 10) == 0) {
+        uint_t euid;
         struct stat st;

         if (lstat(dso->name, &st) < 0)
             goto out;

-        if (st.st_uid && (st.st_uid != geteuid())) {
-            pr_warning("File %s not owned by current user or root, "
-                "ignoring it.\n", dso->name);
+        euid = geteuid();
+        if (euid && st.st_uid && (st.st_uid != euid)) {
+            pr_warning("File %s not owned by current user, and "
+                "current user is not root. Ignoring it.\n",
+                dso->name);
             goto out;
         }

Brendan
