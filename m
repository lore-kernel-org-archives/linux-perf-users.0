From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/6] perf probe: Add ustring support for perf probe command
Date: Sat,  1 Feb 2020 09:03:29 +0100
Message-ID: <20200201080330.13211-6-acme@kernel.org>
References: <20200201080330.13211-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200201080330.13211-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, sumanthk@linux.ibm.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Kernel commit 88903c464321 ("tracing/probe: Add ustring type for user-space string")
adds support for user-space strings when type 'ustring' is specified.

Here is an example using sysfs command line interface
for kprobes:

Function to probe:
  struct filename *
  getname_flags(const char __user *filename, int flags, int *empty)

Setup:
  # cd /sys/kernel/debug/tracing/
  # echo 'p:tmr1 getname_flags +0(%r2):ustring' > kprobe_events
  # cat events/kprobes/tmr1/format | fgrep print
  print fmt: "(%lx) arg1=\"%s\"", REC->__probe_ip, REC->arg1
  # echo 1 > events/kprobes/tmr1/enable
  # touch /tmp/111
  # echo 0 > events/kprobes/tmr1/enable
  # cat trace|fgrep /tmp/111
  touch-5846  [005] d..2 255520.717960: tmr1:\
	  (getname_flags+0x0/0x400) arg1="/tmp/111"

Doing the same with the perf tool fails.
Using type 'string' succeeds:
 # perf probe "vfs_getname=getname_flags:72 pathname=filename:string"
 Added new event:
   probe:vfs_getname (on getname_flags:72 with pathname=filename:string)
   ....
 # perf probe -d probe:vfs_getname
 Removed event: probe:vfs_getname

However using type 'ustring' fails (output before):
 # perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"
 Failed to write event: Invalid argument
   Error: Failed to add events.
 #

Fix this by adding type 'ustring' in function
convert_variable_type().

Using ustring succeeds (output after):
 # ./perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"
 Added new event:
   probe:vfs_getname (on getname_flags:72 with pathname=filename:ustring)

 You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

 #

Note: This issue also exists on x86, it is not s390 specific.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: sumanthk@linux.ibm.com
Link: http://lore.kernel.org/lkml/20200120132011.64698-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c470c49a804f..1c817add6ca4 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -303,7 +303,8 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	char prefix;
 
 	/* TODO: check all types */
-	if (cast && strcmp(cast, "string") != 0 && strcmp(cast, "x") != 0 &&
+	if (cast && strcmp(cast, "string") != 0 && strcmp(cast, "ustring") &&
+	    strcmp(cast, "x") != 0 &&
 	    strcmp(cast, "s") != 0 && strcmp(cast, "u") != 0) {
 		/* Non string type is OK */
 		/* and respect signedness/hexadecimal cast */
-- 
2.21.1
