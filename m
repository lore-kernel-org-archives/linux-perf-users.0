From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 2/2] perf test shell: Fix pathname arg in
 probe_vfs_getname.sh
Date: Tue, 12 Dec 2017 11:22:32 -0500 (EST)
Message-ID: <1645592263.12835937.1513095752603.JavaMail.zimbra@redhat.com>
References: <b6d31ae26f8615d6bd020f4392980950d4c70c96.1513095505.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbdLLQWc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Dec 2017 11:22:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3F02C060215
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2017 16:22:32 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC301600D3
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2017 16:22:32 +0000 (UTC)
In-Reply-To: <b6d31ae26f8615d6bd020f4392980950d4c70c96.1513095505.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@redhat.com

Having 'filename' variable there seems to be more stable, since
'result->name' has recently changed to 'result->uptr'.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 30a950c..3759582 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,7 +13,7 @@ add_probe_vfs_getname() {
 	local verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
 		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
-		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
+		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
 	fi
 }
 
-- 
1.8.3.1
