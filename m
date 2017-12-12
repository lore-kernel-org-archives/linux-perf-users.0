From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 1/2] perf test shell: Fix check open filename arg using
 'perf trace'
Date: Tue, 12 Dec 2017 11:22:03 -0500 (EST)
Message-ID: <1275675985.12835754.1513095723265.JavaMail.zimbra@redhat.com>
References: <3481dc9fd2a192afb457b7782494e9b68b9f2ca3.1513095505.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbdLLQWD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Dec 2017 11:22:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C91E4ACCA
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2017 16:22:03 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5472551C97
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2017 16:22:03 +0000 (UTC)
In-Reply-To: <3481dc9fd2a192afb457b7782494e9b68b9f2ca3.1513095505.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@redhat.com

The following commit added an exception for s390x to use openat()
instead of open() in the test:

  commit f231af789b11a2f1a3795acc3228a3e178a80c21
  Author: Thomas Richter <tmricht@linux.vnet.ibm.com>
  Date:   Tue Nov 14 08:18:46 2017 +0100

Since the problem is not s390x-specific, this patch makes it more
generic, so the test handles both open() and openat() no matter
which architecture it is running on.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 2a9ef08..55ad979 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -17,10 +17,9 @@ skip_if_no_perf_probe || exit 2
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
 trace_open_vfs_getname() {
-	test "$(uname -m)" = s390x && { svc="openat"; txt="dfd: +CWD, +"; }
-
-	perf trace -e ${svc:-open} touch $file 2>&1 | \
-	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ ${svc:-open}\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
+	evts=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
+	perf trace -e $evts touch $file 2>&1 | \
+	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
 
-- 
1.8.3.1
