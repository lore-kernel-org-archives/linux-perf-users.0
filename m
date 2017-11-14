From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf test: fix test case probe libc's inet_pton on s390x
Date: Tue, 14 Nov 2017 08:18:47 +0100
Message-ID: <20171114071847.2381-2-tmricht@linux.vnet.ibm.com>
References: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752510AbdKNHS7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 02:18:59 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAE7FJao031853
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 02:18:59 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e7tcycagh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 02:18:58 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 14 Nov 2017 07:18:56 -0000
In-Reply-To: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

Perf test case probe libc's inet_pton & backtrace it with ping
fails on s390x. The reason is the 'realpath /lib64/ld*.so.* | uniq'
line which returns 2 libraries:

        root@s35lp76 shell]# realpath /lib64/ld*.so.* | uniq
        /usr/lib64/ld-2.26.so
        /usr/lib64/ld_pre_smc.so.1.0.1
        [root@s35lp76 shell]

This output makes the perf probe command lines invalid.

Use tool ldd to find out the libraries required by the bash and
check if symbol inet_pton is part of the libc library.
Some distros do not have a /lib64 directory.

I have also added a check for the existence of an IPv6
network interface before it is being used.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Suggested-by: Hendrik Brückner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brückner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 7a84d73324e3..b9c913f1a360 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -10,8 +10,8 @@
 
 . $(dirname $0)/lib/probe.sh
 
-ld=$(realpath /lib64/ld*.so.* | uniq)
-libc=$(echo $ld | sed 's/ld/libc/g')
+libc=$(ldd $(which bash) 2>/dev/null | fgrep libc | awk '{ print $3 }')
+nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
 trace_libc_inet_pton_backtrace() {
 	idx=0
@@ -37,6 +37,9 @@ trace_libc_inet_pton_backtrace() {
 	done
 }
 
+# Check for IPv6 interface existence
+ip a sh lo | fgrep -q inet6 || exit 2
+
 skip_if_no_perf_probe && \
 perf probe -q $libc inet_pton && \
 trace_libc_inet_pton_backtrace
-- 
2.13.4
