From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/23] perf scripting perl: Add common_callchain to fix argument order
Date: Tue, 17 Mar 2020 18:32:54 -0300
Message-ID: <20200317213259.15494-19-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Benjamin Salon <bsalon@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

Since common_callchain has been added to the argument array, we need to
reflect it in perl-based scripts, because otherwise the following args
would be shifted and thus incorrect. E.g. rw-by-pid and calculation of
read and written bytes:

Before:

  read counts by pid:
     pid                  comm     # reads  bytes_requested  bytes_read
  ------  --------------------  -----------  ----------  ----------
   19301  dd                             4  424510450039736           0

After:

  read counts by pid:
     pid                  comm     # reads  bytes_requested  bytes_read
  ------  --------------------  -----------  ----------  ----------
   19301  dd                             4        9536             4341

Committer testing:

To see before after first do:

  # perf script record rw-by-pid
  ^C

Now you'll have a perf.data file to report on, then do before and after
using:

  # perf script report rw-by-pid

Anbd notice the bytes_request/bytes_read, as above.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Benjamin Salon <bsalon@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
LPU-Reference: 20200311132836.12693-1-mpetlan@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/perl/check-perf-trace.pl |  6 +++---
 tools/perf/scripts/perl/failed-syscalls.pl  |  2 +-
 tools/perf/scripts/perl/rw-by-file.pl       |  6 +++---
 tools/perf/scripts/perl/rw-by-pid.pl        | 10 +++++-----
 tools/perf/scripts/perl/rwtop.pl            | 10 +++++-----
 tools/perf/scripts/perl/wakeup-latency.pl   |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/scripts/perl/check-perf-trace.pl b/tools/perf/scripts/perl/check-perf-trace.pl
index 4e7076c20616..d307ce8fd6ed 100644
--- a/tools/perf/scripts/perl/check-perf-trace.pl
+++ b/tools/perf/scripts/perl/check-perf-trace.pl
@@ -28,7 +28,7 @@ sub trace_end
 sub irq::softirq_entry
 {
 	my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	    $common_pid, $common_comm,
+	    $common_pid, $common_comm, $common_callchain,
 	    $vec) = @_;
 
 	print_header($event_name, $common_cpu, $common_secs, $common_nsecs,
@@ -43,7 +43,7 @@ sub irq::softirq_entry
 sub kmem::kmalloc
 {
 	my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	    $common_pid, $common_comm,
+	    $common_pid, $common_comm, $common_callchain,
 	    $call_site, $ptr, $bytes_req, $bytes_alloc,
 	    $gfp_flags) = @_;
 
@@ -92,7 +92,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
diff --git a/tools/perf/scripts/perl/failed-syscalls.pl b/tools/perf/scripts/perl/failed-syscalls.pl
index 55e7ae4c5c88..05954a8f363a 100644
--- a/tools/perf/scripts/perl/failed-syscalls.pl
+++ b/tools/perf/scripts/perl/failed-syscalls.pl
@@ -18,7 +18,7 @@ my %failed_syscalls;
 sub raw_syscalls::sys_exit
 {
 	my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	    $common_pid, $common_comm,
+	    $common_pid, $common_comm, $common_callchain,
 	    $id, $ret) = @_;
 
 	if ($ret < 0) {
diff --git a/tools/perf/scripts/perl/rw-by-file.pl b/tools/perf/scripts/perl/rw-by-file.pl
index 168fa5e94b44..92a750b8552b 100644
--- a/tools/perf/scripts/perl/rw-by-file.pl
+++ b/tools/perf/scripts/perl/rw-by-file.pl
@@ -28,7 +28,7 @@ my %writes;
 sub syscalls::sys_enter_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $nr, $fd, $buf, $count) = @_;
+	$common_pid, $common_comm, $common_callchain, $nr, $fd, $buf, $count) = @_;
 
     if ($common_comm eq $for_comm) {
 	$reads{$fd}{bytes_requested} += $count;
@@ -39,7 +39,7 @@ sub syscalls::sys_enter_read
 sub syscalls::sys_enter_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $nr, $fd, $buf, $count) = @_;
+	$common_pid, $common_comm, $common_callchain, $nr, $fd, $buf, $count) = @_;
 
     if ($common_comm eq $for_comm) {
 	$writes{$fd}{bytes_written} += $count;
@@ -98,7 +98,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
diff --git a/tools/perf/scripts/perl/rw-by-pid.pl b/tools/perf/scripts/perl/rw-by-pid.pl
index 495698250b2f..d789fe39caab 100644
--- a/tools/perf/scripts/perl/rw-by-pid.pl
+++ b/tools/perf/scripts/perl/rw-by-pid.pl
@@ -24,7 +24,7 @@ my %writes;
 sub syscalls::sys_exit_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $ret) = @_;
 
     if ($ret > 0) {
@@ -40,7 +40,7 @@ sub syscalls::sys_exit_read
 sub syscalls::sys_enter_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $fd, $buf, $count) = @_;
 
     $reads{$common_pid}{bytes_requested} += $count;
@@ -51,7 +51,7 @@ sub syscalls::sys_enter_read
 sub syscalls::sys_exit_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $ret) = @_;
 
     if ($ret <= 0) {
@@ -62,7 +62,7 @@ sub syscalls::sys_exit_write
 sub syscalls::sys_enter_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $fd, $buf, $count) = @_;
 
     $writes{$common_pid}{bytes_written} += $count;
@@ -178,7 +178,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
diff --git a/tools/perf/scripts/perl/rwtop.pl b/tools/perf/scripts/perl/rwtop.pl
index 6473442568a2..eba4df67af6b 100644
--- a/tools/perf/scripts/perl/rwtop.pl
+++ b/tools/perf/scripts/perl/rwtop.pl
@@ -35,7 +35,7 @@ if (!$interval) {
 sub syscalls::sys_exit_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $ret) = @_;
 
     print_check();
@@ -53,7 +53,7 @@ sub syscalls::sys_exit_read
 sub syscalls::sys_enter_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $fd, $buf, $count) = @_;
 
     print_check();
@@ -66,7 +66,7 @@ sub syscalls::sys_enter_read
 sub syscalls::sys_exit_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $ret) = @_;
 
     print_check();
@@ -79,7 +79,7 @@ sub syscalls::sys_exit_write
 sub syscalls::sys_enter_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $fd, $buf, $count) = @_;
 
     print_check();
@@ -197,7 +197,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
diff --git a/tools/perf/scripts/perl/wakeup-latency.pl b/tools/perf/scripts/perl/wakeup-latency.pl
index efcfec5e347a..53444ff4ec7f 100644
--- a/tools/perf/scripts/perl/wakeup-latency.pl
+++ b/tools/perf/scripts/perl/wakeup-latency.pl
@@ -28,7 +28,7 @@ my $total_wakeups = 0;
 sub sched::sched_switch
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$prev_comm, $prev_pid, $prev_prio, $prev_state, $next_comm, $next_pid,
 	$next_prio) = @_;
 
@@ -51,7 +51,7 @@ sub sched::sched_switch
 sub sched::sched_wakeup
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$comm, $pid, $prio, $success, $target_cpu) = @_;
 
     $last_wakeup{$target_cpu}{ts} = nsecs($common_secs, $common_nsecs);
@@ -101,7 +101,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
-- 
2.21.1
