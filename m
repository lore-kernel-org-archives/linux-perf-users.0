From: Adrien BAK <adrien.bak@metascale.org>
Subject: [PATCH] Error reporting improvement
Date: Wed, 16 Apr 2014 16:32:37 +0900
Message-ID: <534E3215.2060306@metascale.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:43979 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755372AbaDPLLF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Apr 2014 07:11:05 -0400
Received: from mail624.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id C27EAFF9460
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Apr 2014 09:32:46 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, a.p.zijlstra@chello.nl, paulus@samba.org, mingo@redhat.com, acme@ghostprotocols.net
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org

In the current version, when using perf record, if something goes wrong in
tools/perf/builtin-record.c:375  session = perf_session__new(file, 
false, NULL);
The error message:
"Not enough memory for reading per file header"
is issued. This error message seems to be outdated and is not very helpful.
This patch propose to replace this error message by
"Perf session creation failed"

I believe this issue has been brought to lkml :
https://lkml.org/lkml/2014/2/24/458
although this patch only tackle a (small) part of the issue.

Additionnaly, this patch improves error reporting in
tools/perf/util/data.c open_file_write
Currently, if the call to open fails, the user is unaware of it.
This patch logs the error, before returning the error code to the caller.

Signed-off-by: Adrien BAK <adrien.bak@metascale.org>

---
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index eb524f9..8ce62ef 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -374,7 +374,7 @@ static int __cmd_record(struct record *rec, int 
argc, const char **argv)

      session = perf_session__new(file, false, NULL);
      if (session == NULL) {
-        pr_err("Not enough memory for reading perf file header\n");
+        pr_err("Perf session creation failed.\n");
          return -1;
      }

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 1fbcd8b..ff2ced7 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -86,10 +86,16 @@ static int open_file_read(struct perf_data_file *file)

  static int open_file_write(struct perf_data_file *file)
  {
+    int fd;
      if (check_backup(file))
          return -1;

-    return open(file->path, O_CREAT|O_RDWR|O_TRUNC, S_IRUSR|S_IWUSR);
+    fd = open(file->path, O_CREAT|O_RDWR|O_TRUNC, S_IRUSR|S_IWUSR);
+
+    if (fd < 0)
+        pr_err("failed to open %s : %s\n", file->path, strerror(errno));
+
+    return fd;
  }

  static int open_file(struct perf_data_file *file)
