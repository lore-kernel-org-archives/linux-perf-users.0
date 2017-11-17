From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/83] perf test shell: Fix test case probe libc's inet_pton on s390x
Date: Fri, 17 Nov 2017 17:15:37 -0300
Message-ID: <20171117201601.24110-60-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759254AbdKQUT2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:28 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

The 'perf test' case "probe libc's inet_pton & backtrace it with ping"
fails on s390x. The reason is the 'realpath /lib64/ld*.so.* | uniq' line
which returns 2 libraries:

        root@s35lp76 shell]# realpath /lib64/ld*.so.* | uniq
        /usr/lib64/ld-2.26.so
        /usr/lib64/ld_pre_smc.so.1.0.1
        [root@s35lp76 shell]

This output makes the "perf probe" command lines invalid.

Use ldd tool to find out the libraries required by "bash" and check if
symbol "inet_pton" is part of the "libc" library.  Some distros do not
have a /lib64 directory.

I have also added a check for the existence of an IPv6 network interface
before it is being used.

Committer changes:

We can't really use ldd for libc, as in some systems, such as x86_64, it
has hardlinks and then ldd sees one and the kernel the other, so grep
for libc in /proc/self/maps to get the one we'll receive from
PERF_RECORD_MMAP.

Thomas checked this change and acked it.

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Suggested-by: Hendrik Brückner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brückner <brueckner@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20171114133409.GN8836@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 7a84d73324e3..8b3da21a08f1 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -10,8 +10,8 @@
 
 . $(dirname $0)/lib/probe.sh
 
-ld=$(realpath /lib64/ld*.so.* | uniq)
-libc=$(echo $ld | sed 's/ld/libc/g')
+libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
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
2.13.6
