Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318F3A6EEB
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403768; cv=none; b=NktcbibAT0mr1I6OyzvC1pIaY/Eglk4wxO+tpfjx0n+Ny0TpUKlEfS3Lg1+fSeC7jTCivu2D+2nOMt5ouC9fYMpiot1np8u+ramtmqW51DdwLuFKGXHTIQIoLBWUx4tVW9CGyyorY8p/h/p69aL9axsfVjrymiVnv2vVA2s0oJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403768; c=relaxed/simple;
	bh=iVJHEz8LiWp325AxCug3IWzBdbwk5bw/+qdugK2ZgfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8S3H2K2VRVgI1e0Sjz/e9ykqNSIGJvYouXV+jxjstFWPuAnkVnrhdwVIj74zPXw3Hh+/k3Lxx3sC8EsphJH85pmTy0O97zDbY3Nf+b/3gfqoEdf/CkgC01bqe12egs9ah1dt85w1lxuHHPnX6pggSx1gBD5npabdQLSR6f3ZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UFX6iJYG; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFX6iJYG"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34316295d86so650979eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403758; x=1791008558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pVuyf2LruG+SRn6zyS9rxI7nbqKHqCpwUBX968FcFrg=;
        b=UFX6iJYGBWca2vq9PPtsY1oLGTOzDvqe/c9yI0+L6kH7yvtz7TI50Z1a1y/L0aNlK3
         9NCY8SotvlIVIWNiCJtJ8rP6BVCCCSCWSz/9rtNEsT9BfX0MSiJ6zOkmOSC9UU4JvRaB
         7eXYDQkHPBSAC8zdQCWw+CNOedVaquXBQO74Q5bptf29ulFLbd8MijIoA6MBHf7kcKNB
         c9K77+wGFQoXBlB2VugMD581pjeffcJ1Ewy6KlhZGEk+DoDnma87kScJYo0bGXcesoi7
         No+LvNFZ31TRSSDhwFuKiICD4WvRC1/0ge0qwG7UIZkx7qwOuJa/NGTdRSyi5q4WU+P0
         B4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403758; x=1791008558;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVuyf2LruG+SRn6zyS9rxI7nbqKHqCpwUBX968FcFrg=;
        b=JnndUyupOSuaHKvutb/PGMKAQTawlElBi3fbGWMt1oHU4Ew8T/tsfuCShGAbNFYFv7
         H1V6iZK3LI+ibzFdiTwFb9bXjn19EdR553Mc8DwNf80JmamPc9nwYQ0XMj3So+DclNzi
         ZZaI4rMWWzlqU+krPjfUav9GTgfmX/AaLg5lyN1p9dIkwsqNj0j0qmBdmhMjPNjyru87
         FXMF6dA2xWJ6YoOsBd6UPukJ+L5em8ndl/JtwdMVb+EyJUcDkUn4EMNl25jQjXgyfpbO
         cinGw/G+d21bfUjy9vbRyjwMym5jBrEXCGMPYDPaq9VrRin2p6LnHCtGFPUCtdbNYnq7
         baiw==
X-Forwarded-Encrypted: i=1; AKwUvBxUvSUCfwW2RZv+1DlD6DZnGeqeCTDCYsys8YjaAVjwKlC7bJ7A5hj3xffiIvATN8EST+Ry5S4ETEetFM7ZRm1B@vger.kernel.org
X-Gm-Message-State: AFuF++mX88Afz1hvfGMNru+DxUR/1rZmGCiqma3RSPeAXTmGE0V+re/H
	E+E7CwYEERMcs9G2O24xMO8w6FHkCgjTNoxt98Kpue+xLpacWEx2dIdSI4RwdWCcux1uG3geOOk
	yoBYhrHb4bw==
X-Received: from dlbpu5.prod.google.com ([2002:a05:7022:e885:b0:144:f4b8:ee5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4314:b0:144:c90f:256a
 with SMTP id a92af1059eb24-146cdebd363mr2068741c88.5.1790403757881; Fri, 25
 Sep 2026 23:22:37 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:20:16 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-50-irogers@google.com>
Subject: [PATCH v4 49/49] perf Documentation: Update for standalone Python scripts
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update perf-script documentation to reflect standalone Python script
execution and the removal of embedded Python and Perl scripting:
- Remove documentation for the removed -g and -s options and legacy
  record/report script wrapper modes in perf-script.txt.
- Remove references to perf-script-perl and delete obsolete
  perf-script-perl.txt.
- Rewrite perf-script-python.txt to document writing and running
  standalone Python scripts using the perf module.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/db-export.txt        |  16 +-
 tools/perf/Documentation/perf-script-perl.txt | 216 -----
 .../perf/Documentation/perf-script-python.txt | 798 ++++--------------
 tools/perf/Documentation/perf-script.txt      |  82 +-
 tools/perf/Documentation/tips.txt             |   1 -
 5 files changed, 163 insertions(+), 950 deletions(-)
 delete mode 100644 tools/perf/Documentation/perf-script-perl.txt

diff --git a/tools/perf/Documentation/db-export.txt b/tools/perf/Documentat=
ion/db-export.txt
index 20024e1f9164..a736be3b6e84 100644
--- a/tools/perf/Documentation/db-export.txt
+++ b/tools/perf/Documentation/db-export.txt
@@ -1,11 +1,11 @@
 Database Export
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-perf tool's python scripting engine:
+perf tool's python module:
=20
-	tools/perf/util/scripting-engines/trace-event-python.c
+	tools/perf/util/python.c
=20
-supports scripts:
+supports standalone scripts:
=20
 	tools/perf/python/export-to-sqlite.py
 	tools/perf/python/export-to-postgresql.py
@@ -31,11 +31,5 @@ backward compatibility by testing for the presence of ne=
w tables and columns
 before using them. e.g. function IsSelectable() in exported-sql-viewer.py
=20
 4. The export scripts themselves maintain forward compatibility (i.e. an e=
xisting
-script will continue to work with new versions of perf) by accepting a var=
iable
-number of arguments (e.g. def call_return_table(*x)) i.e. perf can pass mo=
re
-arguments which old scripts will ignore.
-
-5. The scripting engine tests for the existence of script handler function=
s
-before calling them.  The scripting engine can also test for the support o=
f new
-or optional features by checking for the existence and value of script glo=
bal
-variables.
+script will continue to work with new versions of perf) by querying event =
and
+sample attributes dynamically from the perf Python module.
diff --git a/tools/perf/Documentation/perf-script-perl.txt b/tools/perf/Doc=
umentation/perf-script-perl.txt
deleted file mode 100644
index 5b479f5e62ff..000000000000
--- a/tools/perf/Documentation/perf-script-perl.txt
+++ /dev/null
@@ -1,216 +0,0 @@
-perf-script-perl(1)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-NAME
-----
-perf-script-perl - Process trace data with a Perl script
-
-SYNOPSIS
---------
-[verse]
-'perf script' [-s [Perl]:script[.pl] ]
-
-DESCRIPTION
------------
-
-This perf script option is used to process perf script data using perf's
-built-in Perl interpreter.  It reads and processes the input file and
-displays the results of the trace analysis implemented in the given
-Perl script, if any.
-
-STARTER SCRIPTS
----------------
-
-You can avoid reading the rest of this document by running 'perf script
--g perl' in the same directory as an existing perf.data trace file.
-That will generate a starter script containing a handler for each of
-the event types in the trace file; it simply prints every available
-field for each event in the trace file.
-
-You can also look at the existing scripts in
-~/libexec/perf-core/scripts/perl for typical examples showing how to
-do basic things like aggregate event data, print results, etc.  Also,
-the check-perf-script.pl script, while not interesting for its results,
-attempts to exercise all of the main scripting features.
-
-EVENT HANDLERS
---------------
-
-When perf script is invoked using a trace script, a user-defined
-'handler function' is called for each event in the trace.  If there's
-no handler function defined for a given event type, the event is
-ignored (or passed to a 'trace_unhandled' function, see below) and the
-next event is processed.
-
-Most of the event's field values are passed as arguments to the
-handler function; some of the less common ones aren't - those are
-available as calls back into the perf executable (see below).
-
-As an example, the following perf record command can be used to record
-all sched_wakeup events in the system:
-
- # perf record -a -e sched:sched_wakeup
-
-Traces meant to be processed using a script should be recorded with
-the above option: -a to enable system-wide collection.
-
-The format file for the sched_wakeup event defines the following fields
-(see /sys/kernel/tracing/events/sched/sched_wakeup/format):
-
-----
- format:
-        field:unsigned short common_type;
-        field:unsigned char common_flags;
-        field:unsigned char common_preempt_count;
-        field:int common_pid;
-
-        field:char comm[TASK_COMM_LEN];
-        field:pid_t pid;
-        field:int prio;
-        field:int success;
-        field:int target_cpu;
-----
-
-The handler function for this event would be defined as:
-
-----
-sub sched::sched_wakeup
-{
-   my ($event_name, $context, $common_cpu, $common_secs,
-       $common_nsecs, $common_pid, $common_comm,
-       $comm, $pid, $prio, $success, $target_cpu) =3D @_;
-}
-----
-
-The handler function takes the form subsystem::event_name.
-
-The $common_* arguments in the handler's argument list are the set of
-arguments passed to all event handlers; some of the fields correspond
-to the common_* fields in the format file, but some are synthesized,
-and some of the common_* fields aren't common enough to to be passed
-to every event as arguments but are available as library functions.
-
-Here's a brief description of each of the invariant event args:
-
- $event_name 	  	    the name of the event as text
- $context		    an opaque 'cookie' used in calls back into perf
- $common_cpu		    the cpu the event occurred on
- $common_secs		    the secs portion of the event timestamp
- $common_nsecs		    the nsecs portion of the event timestamp
- $common_pid		    the pid of the current task
- $common_comm		    the name of the current process
-
-All of the remaining fields in the event's format file have
-counterparts as handler function arguments of the same name, as can be
-seen in the example above.
-
-The above provides the basics needed to directly access every field of
-every event in a trace, which covers 90% of what you need to know to
-write a useful trace script.  The sections below cover the rest.
-
-SCRIPT LAYOUT
--------------
-
-Every perf script Perl script should start by setting up a Perl module
-search path and 'use'ing a few support modules (see module
-descriptions below):
-
-----
- use lib "$ENV{'PERF_EXEC_PATH'}/scripts/perl/Perf-Trace-Util/lib";
- use lib "./Perf-Trace-Util/lib";
- use Perf::Trace::Core;
- use Perf::Trace::Context;
- use Perf::Trace::Util;
-----
-
-The rest of the script can contain handler functions and support
-functions in any order.
-
-Aside from the event handler functions discussed above, every script
-can implement a set of optional functions:
-
-*trace_begin*, if defined, is called before any event is processed and
-gives scripts a chance to do setup tasks:
-
-----
- sub trace_begin
- {
- }
-----
-
-*trace_end*, if defined, is called after all events have been
- processed and gives scripts a chance to do end-of-script tasks, such
- as display results:
-
-----
-sub trace_end
-{
-}
-----
-
-*trace_unhandled*, if defined, is called after for any event that
- doesn't have a handler explicitly defined for it.  The standard set
- of common arguments are passed into it:
-
-----
-sub trace_unhandled
-{
-    my ($event_name, $context, $common_cpu, $common_secs,
-        $common_nsecs, $common_pid, $common_comm) =3D @_;
-}
-----
-
-The remaining sections provide descriptions of each of the available
-built-in perf script Perl modules and their associated functions.
-
-AVAILABLE MODULES AND FUNCTIONS
--------------------------------
-
-The following sections describe the functions and variables available
-via the various Perf::Trace::* Perl modules.  To use the functions and
-variables from the given module, add the corresponding 'use
-Perf::Trace::XXX' line to your perf script script.
-
-Perf::Trace::Core Module
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-These functions provide some essential functions to user scripts.
-
-The *flag_str* and *symbol_str* functions provide human-readable
-strings for flag and symbolic fields.  These correspond to the strings
-and values parsed from the 'print fmt' fields of the event format
-files:
-
-  flag_str($event_name, $field_name, $field_value) - returns the string re=
presentation corresponding to $field_value for the flag field $field_name o=
f event $event_name
-  symbol_str($event_name, $field_name, $field_value) - returns the string =
representation corresponding to $field_value for the symbolic field $field_=
name of event $event_name
-
-Perf::Trace::Context Module
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Some of the 'common' fields in the event format file aren't all that
-common, but need to be made accessible to user scripts nonetheless.
-
-Perf::Trace::Context defines a set of functions that can be used to
-access this data in the context of the current event.  Each of these
-functions expects a $context variable, which is the same as the
-$context variable passed into every event handler as the second
-argument.
-
- common_pc($context) - returns common_preempt count for the current event
- common_flags($context) - returns common_flags for the current event
- common_lock_depth($context) - returns common_lock_depth for the current e=
vent
-
-Perf::Trace::Util Module
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-Various utility functions for use with perf script:
-
-  nsecs($secs, $nsecs) - returns total nsecs given secs/nsecs pair
-  nsecs_secs($nsecs) - returns whole secs portion given nsecs
-  nsecs_nsecs($nsecs) - returns nsecs remainder given nsecs
-  nsecs_str($nsecs) - returns printable string in the form secs.nsecs
-  avg($total, $n) - returns average given a sum and a total number of valu=
es
-
-SEE ALSO
---------
-linkperf:perf-script[1]
diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/D=
ocumentation/perf-script-python.txt
index 27a1cac6fe76..cbf50b3e5f06 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -3,676 +3,182 @@ perf-script-python(1)
=20
 NAME
 ----
-perf-script-python - Process trace data with a Python script
+perf-script-python - Process trace data with a Python script using perf mo=
dule
=20
 SYNOPSIS
 --------
 [verse]
-'perf script' [-s [Python]:script[.py] ]
+'perf script' <script>.py
=20
 DESCRIPTION
 -----------
=20
-This perf script option is used to process perf script data using perf's
-built-in Python interpreter.  It reads and processes the input file and
-displays the results of the trace analysis implemented in the given
-Python script, if any.
+This document describes how to use the `perf` Python module to process
+trace data recorded by `perf record`.
+
+With the removal of embedded Python interpreter from `perf`, scripts
+are now run as standalone Python programs that import the `perf`
+module to access trace data. Symbol configuration options (`--vmlinux`,
+`--kallsyms`, and `--symfs`) and `--itrace` options passed to `perf script=
`
+are forwarded via `PERF_SYMBOL_*` and `PERF_ITRACE` environment variables
+to `perf.session`, and can also be passed directly to `perf.session`.
+Trace filtering command-line
+options (`-C`, `-c`, `--pid`, `--tid`, `--time`, `--dlfilter`, `--dlarg`) =
passed
+to `perf script` are not applied to standalone scripts.
=20
 A QUICK EXAMPLE
 ---------------
=20
-This section shows the process, start to finish, of creating a working
-Python script that aggregates and extracts useful information from a
-raw perf script stream.  You can avoid reading the rest of this
-document if an example is enough for you; the rest of the document
-provides more details on each step and lists the library functions
-available to script writers.
-
-This example actually details the steps that were used to create the
-'syscall-counts' script you see when you list the available perf script
-scripts via 'perf script -l'.  As such, this script also shows how to
-integrate your script into the list of general-purpose 'perf script'
-scripts listed by that command.
-
-The syscall-counts script is a simple script, but demonstrates all the
-basic ideas necessary to create a useful script.  Here's an example
-of its output (syscall names are not yet supported, they will appear
-as numbers):
-
-----
-syscall events:
-
-event                                          count
-----------------------------------------  -----------
-sys_write                                     455067
-sys_getdents                                    4072
-sys_close                                       3037
-sys_swapoff                                     1769
-sys_read                                         923
-sys_sched_setparam                               826
-sys_open                                         331
-sys_newfstat                                     326
-sys_mmap                                         217
-sys_munmap                                       216
-sys_futex                                        141
-sys_select                                       102
-sys_poll                                          84
-sys_setitimer                                     12
-sys_writev                                         8
-15                                                 8
-sys_lseek                                          7
-sys_rt_sigprocmask                                 6
-sys_wait4                                          3
-sys_ioctl                                          3
-sys_set_robust_list                                1
-sys_exit                                           1
-56                                                 1
-sys_access                                         1
-----
-
-Basically our task is to keep a per-syscall tally that gets updated
-every time a system call occurs in the system.  Our script will do
-that, but first we need to record the data that will be processed by
-that script.  Theoretically, there are a couple of ways we could do
-that:
-
-- we could enable every event under the tracing/events/syscalls
-  directory, but this is over 600 syscalls, well beyond the number
-  allowable by perf.  These individual syscall events will however be
-  useful if we want to later use the guidance we get from the
-  general-purpose scripts to drill down and get more detail about
-  individual syscalls of interest.
-
-- we can enable the sys_enter and/or sys_exit syscalls found under
-  tracing/events/raw_syscalls.  These are called for all syscalls; the
-  'id' field can be used to distinguish between individual syscall
-  numbers.
-
-For this script, we only need to know that a syscall was entered; we
-don't care how it exited, so we'll use 'perf record' to record only
-the sys_enter events:
-
-----
-# perf record -a -e raw_syscalls:sys_enter
-
-^C[ perf record: Woken up 1 times to write data ]
-[ perf record: Captured and wrote 56.545 MB perf.data (~2470503 samples) ]
-----
-
-The options basically say to collect data for every syscall event
-system-wide and multiplex the per-cpu output into a single stream.
-That single stream will be recorded in a file in the current directory
-called perf.data.
-
-Once we have a perf.data file containing our data, we can use the -g
-'perf script' option to generate a Python script that will contain a
-callback handler for each event type found in the perf.data trace
-stream (for more details, see the STARTER SCRIPTS section).
-
-----
-# perf script -g python
-generated Python script: perf-script.py
-
-The output file created also in the current directory is named
-perf-script.py.  Here's the file in its entirety:
-
-# perf script event handlers, generated by perf script -g python
-# Licensed under the terms of the GNU GPL License version 2
-
-# The common_* event handler fields are the most useful fields common to
-# all events.  They don't necessarily correspond to the 'common_*' fields
-# in the format files.  Those fields not available as handler params can
-# be retrieved using Python functions of the form common_*(context).
-# See the perf-script-python Documentation for the list of available funct=
ions.
-
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-
-def trace_begin():
-	print "in trace_begin"
-
-def trace_end():
-	print "in trace_end"
-
-def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
-		print_header(event_name, common_cpu, common_secs, common_nsecs,
-			common_pid, common_comm)
-
-		print "id=3D%d, args=3D%s\n" % \
-		(id, args),
-
-def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=3D%s'%(k,str(v))for k,v in sorted(event_fields_dict.=
items())])
-
-def print_header(event_name, cpu, secs, nsecs, pid, comm):
-	print "%-20s %5u %05u.%09u %8u %-20s " % \
-	(event_name, cpu, secs, nsecs, pid, comm),
-----
-
-At the top is a comment block followed by some import statements and a
-path append which every perf script script should include.
-
-Following that are a couple generated functions, trace_begin() and
-trace_end(), which are called at the beginning and the end of the
-script respectively (for more details, see the SCRIPT_LAYOUT section
-below).
-
-Following those are the 'event handler' functions generated one for
-every event in the 'perf record' output.  The handler functions take
-the form subsystem\__event_name, and contain named parameters, one for
-each field in the event; in this case, there's only one event,
-raw_syscalls__sys_enter().  (see the EVENT HANDLERS section below for
-more info on event handlers).
-
-The final couple of functions are, like the begin and end functions,
-generated for every script.  The first, trace_unhandled(), is called
-every time the script finds an event in the perf.data file that
-doesn't correspond to any event handler in the script.  This could
-mean either that the record step recorded event types that it wasn't
-really interested in, or the script was run against a trace file that
-doesn't correspond to the script.
-
-The script generated by -g option simply prints a line for each
-event found in the trace stream i.e. it basically just dumps the event
-and its parameter values to stdout.  The print_header() function is
-simply a utility function used for that purpose.  Let's rename the
-script and run it to see the default output:
-
-----
-# mv perf-script.py syscall-counts.py
-# perf script -s syscall-counts.py
-
-raw_syscalls__sys_enter     1 00840.847582083     7506 perf               =
   id=3D1, args=3D
-raw_syscalls__sys_enter     1 00840.847595764     7506 perf               =
   id=3D1, args=3D
-raw_syscalls__sys_enter     1 00840.847620860     7506 perf               =
   id=3D1, args=3D
-raw_syscalls__sys_enter     1 00840.847710478     6533 npviewer.bin       =
   id=3D78, args=3D
-raw_syscalls__sys_enter     1 00840.847719204     6533 npviewer.bin       =
   id=3D142, args=3D
-raw_syscalls__sys_enter     1 00840.847755445     6533 npviewer.bin       =
   id=3D3, args=3D
-raw_syscalls__sys_enter     1 00840.847775601     6533 npviewer.bin       =
   id=3D3, args=3D
-raw_syscalls__sys_enter     1 00840.847781820     6533 npviewer.bin       =
   id=3D3, args=3D
-.
-.
-.
-----
-
-Of course, for this script, we're not interested in printing every
-trace event, but rather aggregating it in a useful way.  So we'll get
-rid of everything to do with printing as well as the trace_begin() and
-trace_unhandled() functions, which we won't be using.  That leaves us
-with this minimalistic skeleton:
-
-----
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+This section shows how to create a simple Python script that reads a
+`perf.data` file and prints event information.
=20
-from perf_trace_context import *
-from Core import *
+Create a file named `print_events.py` with the following content:
=20
-def trace_end():
-	print "in trace_end"
+    #!/usr/bin/env python3
+    import perf
=20
-def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
-----
-
-In trace_end(), we'll simply print the results, but first we need to
-generate some results to print.  To do that we need to have our
-sys_enter() handler do the necessary tallying until all events have
-been counted.  A hash table indexed by syscall id is a good way to
-store that information; every time the sys_enter() handler is called,
-we simply increment a count associated with that hash entry indexed by
-that syscall id:
-
-----
-  syscalls =3D autodict()
-
-  try:
-    syscalls[id] +=3D 1
-  except TypeError:
-    syscalls[id] =3D 1
-----
-
-The syscalls 'autodict' object is a special kind of Python dictionary
-(implemented in Core.py) that implements Perl's 'autovivifying' hashes
-in Python i.e. with autovivifying hashes, you can assign nested hash
-values without having to go to the trouble of creating intermediate
-levels if they don't exist e.g syscalls[comm][pid][id] =3D 1 will create
-the intermediate hash levels and finally assign the value 1 to the
-hash entry for 'id' (because the value being assigned isn't a hash
-object itself, the initial value is assigned in the TypeError
-exception.  Well, there may be a better way to do this in Python but
-that's what works for now).
-
-Putting that code into the raw_syscalls__sys_enter() handler, we
-effectively end up with a single-level dictionary keyed on syscall id
-and having the counts we've tallied as values.
-
-The print_syscall_totals() function iterates over the entries in the
-dictionary and displays a line for each entry containing the syscall
-name (the dictionary keys contain the syscall ids, which are passed to
-the Util function syscall_name(), which translates the raw syscall
-numbers to the corresponding syscall name strings).  The output is
-displayed after all the events in the trace have been processed, by
-calling the print_syscall_totals() function from the trace_end()
-handler called at the end of script processing.
-
-The final script producing the output shown above is shown in its
-entirety below (syscall_name() helper is not yet available, you can
-only deal with id's for now):
-
-----
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from Util import *
-
-syscalls =3D autodict()
-
-def trace_end():
-	print_syscall_totals()
-
-def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
-	try:
-		syscalls[id] +=3D 1
-	except TypeError:
-		syscalls[id] =3D 1
-
-def print_syscall_totals():
-    if for_comm is not None:
-	    print "\nsyscall events for %s:\n\n" % (for_comm),
-    else:
-	    print "\nsyscall events:\n\n",
-
-    print "%-40s  %10s\n" % ("event", "count"),
-    print "%-40s  %10s\n" % ("----------------------------------------", \
-                                 "-----------"),
-
-    for id, val in sorted(syscalls.iteritems(), key =3D lambda(k, v): (v, =
k), \
-				  reverse =3D True):
-	    print "%-40s  %10d\n" % (syscall_name(id), val),
-----
+    def process_event(sample):
+        print(f"Event: {sample.evsel} on CPU {sample.sample_cpu} at {sampl=
e.sample_time}")
=20
-The script can be run just as before:
+    # Open the session with perf.data file
+    session =3D perf.session(perf.data("perf.data"), sample=3Dprocess_even=
t)
=20
-  # perf script -s syscall-counts.py
+    # Process all events
+    session.process_events()
=20
-So those are the essential steps in writing and running a script.  The
-process can be generalized to any tracepoint or set of tracepoints
-you're interested in - basically find the tracepoint(s) you're
-interested in by looking at the list of available events shown by
-'perf list' and/or look in /sys/kernel/tracing/events/ for
-detailed event and field info, record the corresponding trace data
-using 'perf record', passing it the list of interesting events,
-generate a skeleton script using 'perf script -g python' and modify the
-code to aggregate and display it for your particular needs.
+Make the script executable:
+    $ chmod +x print_events.py
=20
-After you've done that you may end up with a general-purpose script
-that you want to keep around and have available for future use.  By
-writing a couple of very simple shell scripts and putting them in the
-right place, you can have your script listed alongside the other
-scripts listed by the 'perf script -l' command e.g.:
+Record some data:
+    $ perf record -a sleep 1
=20
-----
-# perf script -l
-List of available trace scripts:
-  wakeup-latency                       system-wide min/max/avg wakeup late=
ncy
-  rw-by-file <comm>                    r/w activity for a program, by file
-  rw-by-pid                            system-wide r/w activity
-----
-
-A nice side effect of doing this is that you also then capture the
-probably lengthy 'perf record' command needed to record the events for
-the script.
-
-To have the script appear as a 'built-in' script, you write two simple
-scripts, one for recording and one for 'reporting'.
-
-The 'record' script is a shell script with the same base name as your
-script, but with -record appended.  The shell script should be put
-into the perf/scripts/python/bin directory in the kernel source tree.
-In that script, you write the 'perf record' command-line needed for
-your script:
+Run the script:
+    $ perf script print_events.py
=20
-----
-# cat kernel-source/tools/perf/scripts/python/bin/syscall-counts-record
-
-#!/bin/bash
-perf record -a -e raw_syscalls:sys_enter
-----
+Or run it directly with Python, ensuring `perf.so` is in your `PYTHONPATH`=
:
+    $ PYTHONPATH=3D/path/to/perf/python python3 print_events.py
=20
-The 'report' script is also a shell script with the same base name as
-your script, but with -report appended.  It should also be located in
-the perf/scripts/python/bin directory.  In that script, you write the
-'perf script -s' command-line needed for running your script:
-
-----
-# cat kernel-source/tools/perf/scripts/python/bin/syscall-counts-report
-
-#!/bin/bash
-# description: system-wide syscall counts
-perf script -s ~/libexec/perf-core/scripts/python/syscall-counts.py
-----
-
-Note that the location of the Python script given in the shell script
-is in the libexec/perf-core/scripts/python directory - this is where
-the script will be copied by 'make install' when you install perf.
-For the installation to install your script there, your script needs
-to be located in the perf/scripts/python directory in the kernel
-source tree:
-
-----
-# ls -al kernel-source/tools/perf/scripts/python
-total 32
-drwxr-xr-x 4 trz trz 4096 2010-01-26 22:30 .
-drwxr-xr-x 4 trz trz 4096 2010-01-26 22:29 ..
-drwxr-xr-x 2 trz trz 4096 2010-01-26 22:29 bin
--rw-r--r-- 1 trz trz 2548 2010-01-26 22:29 check-perf-script.py
-drwxr-xr-x 3 trz trz 4096 2010-01-26 22:49 Perf-Trace-Util
--rw-r--r-- 1 trz trz 1462 2010-01-26 22:30 syscall-counts.py
-----
-
-Once you've done that (don't forget to do a new 'make install',
-otherwise your script won't show up at run-time), 'perf script -l'
-should show a new entry for your script:
-
-----
-# perf script -l
-List of available trace scripts:
-  wakeup-latency                       system-wide min/max/avg wakeup late=
ncy
-  rw-by-file <comm>                    r/w activity for a program, by file
-  rw-by-pid                            system-wide r/w activity
-  syscall-counts                       system-wide syscall counts
-----
-
-You can now perform the record step via 'perf script record':
-
-  # perf script record syscall-counts
-
-and display the output using 'perf script report':
-
-  # perf script report syscall-counts
-
-STARTER SCRIPTS
+THE PERF MODULE
 ---------------
=20
-You can quickly get started writing a script for a particular set of
-trace data by generating a skeleton script using 'perf script -g
-python' in the same directory as an existing perf.data trace file.
-That will generate a starter script containing a handler for each of
-the event types in the trace file; it simply prints every available
-field for each event in the trace file.
-
-You can also look at the existing scripts in
-~/libexec/perf-core/scripts/python for typical examples showing how to
-do basic things like aggregate event data, print results, etc.  Also,
-the check-perf-script.py script, while not interesting for its results,
-attempts to exercise all of the main scripting features.
-
-EVENT HANDLERS
---------------
-
-When perf script is invoked using a trace script, a user-defined
-'handler function' is called for each event in the trace.  If there's
-no handler function defined for a given event type, the event is
-ignored (or passed to a 'trace_unhandled' function, see below) and the
-next event is processed.
-
-Most of the event's field values are passed as arguments to the
-handler function; some of the less common ones aren't - those are
-available as calls back into the perf executable (see below).
-
-As an example, the following perf record command can be used to record
-all sched_wakeup events in the system:
-
- # perf record -a -e sched:sched_wakeup
-
-Traces meant to be processed using a script should be recorded with
-the above option: -a to enable system-wide collection.
-
-The format file for the sched_wakeup event defines the following fields
-(see /sys/kernel/tracing/events/sched/sched_wakeup/format):
-
-----
- format:
-        field:unsigned short common_type;
-        field:unsigned char common_flags;
-        field:unsigned char common_preempt_count;
-        field:int common_pid;
-
-        field:char comm[TASK_COMM_LEN];
-        field:pid_t pid;
-        field:int prio;
-        field:int success;
-        field:int target_cpu;
-----
-
-The handler function for this event would be defined as:
-
-----
-def sched__sched_wakeup(event_name, context, common_cpu, common_secs,
-       common_nsecs, common_pid, common_comm,
-       comm, pid, prio, success, target_cpu):
-       pass
-----
-
-The handler function takes the form subsystem__event_name.
-
-The common_* arguments in the handler's argument list are the set of
-arguments passed to all event handlers; some of the fields correspond
-to the common_* fields in the format file, but some are synthesized,
-and some of the common_* fields aren't common enough to to be passed
-to every event as arguments but are available as library functions.
-
-Here's a brief description of each of the invariant event args:
-
- event_name 	  	    the name of the event as text
- context		    an opaque 'cookie' used in calls back into perf
- common_cpu		    the cpu the event occurred on
- common_secs		    the secs portion of the event timestamp
- common_nsecs		    the nsecs portion of the event timestamp
- common_pid		    the pid of the current task
- common_comm		    the name of the current process
-
-All of the remaining fields in the event's format file have
-counterparts as handler function arguments of the same name, as can be
-seen in the example above.
-
-The above provides the basics needed to directly access every field of
-every event in a trace, which covers 90% of what you need to know to
-write a useful trace script.  The sections below cover the rest.
-
-SCRIPT LAYOUT
--------------
-
-Every perf script Python script should start by setting up a Python
-module search path and 'import'ing a few support modules (see module
-descriptions below):
-
-----
- import os
- import sys
-
- sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	      '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
- from perf_trace_context import *
- from Core import *
-----
-
-The rest of the script can contain handler functions and support
-functions in any order.
-
-Aside from the event handler functions discussed above, every script
-can implement a set of optional functions:
-
-*trace_begin*, if defined, is called before any event is processed and
-gives scripts a chance to do setup tasks:
-
-----
-def trace_begin():
-    pass
-----
-
-*trace_end*, if defined, is called after all events have been
- processed and gives scripts a chance to do end-of-script tasks, such
- as display results:
-
-----
-def trace_end():
-    pass
-----
-
-*trace_unhandled*, if defined, is called after for any event that
- doesn't have a handler explicitly defined for it.  The standard set
- of common arguments are passed into it:
-
-----
-def trace_unhandled(event_name, context, event_fields_dict):
-    pass
-----
-
-*process_event*, if defined, is called for any non-tracepoint event
-
-----
-def process_event(param_dict):
-    pass
-----
-
-*context_switch*, if defined, is called for any context switch
-
-----
-def context_switch(ts, cpu, pid, tid, np_pid, np_tid, machine_pid, out, ou=
t_preempt, *x):
-    pass
-----
-
-*auxtrace_error*, if defined, is called for any AUX area tracing error
-
-----
-def auxtrace_error(typ, code, cpu, pid, tid, ip, ts, msg, cpumode, *x):
-    pass
-----
-
-The remaining sections provide descriptions of each of the available
-built-in perf script Python modules and their associated functions.
-
-AVAILABLE MODULES AND FUNCTIONS
--------------------------------
-
-The following sections describe the functions and variables available
-via the various perf script Python modules.  To use the functions and
-variables from the given module, add the corresponding 'from XXXX
-import' line to your perf script script.
-
-Core.py Module
-~~~~~~~~~~~~~~
-
-These functions provide some essential functions to user scripts.
-
-The *flag_str* and *symbol_str* functions provide human-readable
-strings for flag and symbolic fields.  These correspond to the strings
-and values parsed from the 'print fmt' fields of the event format
-files:
-
-  flag_str(event_name, field_name, field_value) - returns the string repre=
sentation corresponding to field_value for the flag field field_name of eve=
nt event_name
-  symbol_str(event_name, field_name, field_value) - returns the string rep=
resentation corresponding to field_value for the symbolic field field_name =
of event event_name
-
-The *autodict* function returns a special kind of Python
-dictionary that implements Perl's 'autovivifying' hashes in Python
-i.e. with autovivifying hashes, you can assign nested hash values
-without having to go to the trouble of creating intermediate levels if
-they don't exist.
-
-  autodict() - returns an autovivifying dictionary instance
-
-
-perf_trace_context Module
-~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Some of the 'common' fields in the event format file aren't all that
-common, but need to be made accessible to user scripts nonetheless.
-
-perf_trace_context defines a set of functions that can be used to
-access this data in the context of the current event.  Each of these
-functions expects a context variable, which is the same as the
-context variable passed into every tracepoint event handler as the second
-argument. For non-tracepoint events, the context variable is also present
-as perf_trace_context.perf_script_context .
-
- common_pc(context) - returns common_preempt count for the current event
- common_flags(context) - returns common_flags for the current event
- common_lock_depth(context) - returns common_lock_depth for the current ev=
ent
- perf_sample_insn(context) - returns the machine code instruction
- perf_set_itrace_options(context, itrace_options) - set --itrace options i=
f they have not been set already
- perf_sample_srcline(context) - returns source_file_name, line_number
- perf_sample_srccode(context) - returns source_file_name, line_number, sou=
rce_line
- perf_config_get(config_name) - returns the value of the named config item=
, or None if unset
-
-Util.py Module
-~~~~~~~~~~~~~~
-
-Various utility functions for use with perf script:
-
-  nsecs(secs, nsecs) - returns total nsecs given secs/nsecs pair
-  nsecs_secs(nsecs) - returns whole secs portion given nsecs
-  nsecs_nsecs(nsecs) - returns nsecs remainder given nsecs
-  nsecs_str(nsecs) - returns printable string in the form secs.nsecs
-  avg(total, n) - returns average given a sum and a total number of values
-
-SUPPORTED FIELDS
-----------------
-
-Currently supported fields:
-
-ev_name, comm, id, stream_id, pid, tid, cpu, ip, time, period, phys_addr,
-addr, symbol, symoff, dso, time_enabled, time_running, values, callchain,
-brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
-weight, transaction, raw_buf, attr, cpumode.
-
-Fields that may also be present:
-
- flags - sample flags
- flags_disp - sample flags display
- insn_cnt - instruction count for determining instructions-per-cycle (IPC)
- cyc_cnt - cycle count for determining IPC
- addr_correlates_sym - addr can correlate to a symbol
- addr_dso - addr dso
- addr_symbol - addr symbol
- addr_symoff - addr symbol offset
-
-Some fields have sub items:
-
-brstack:
-    from, to, from_dsoname, to_dsoname, mispred,
-    predicted, in_tx, abort, cycles.
-
-brstacksym:
-    items: from, to, pred, in_tx, abort (converted string)
-
-For example,
-We can use this code to print brstack "from", "to", "cycles".
-
-if 'brstack' in dict:
-	for entry in dict['brstack']:
-		print "from %s, to %s, cycles %s" % (entry["from"], entry["to"], entry["=
cycles"])
+The `perf` module provides several classes and functions to interact
+with trace data.
+
+Module Functions
+~~~~~~~~~~~~~~~~
+
+- `config_get(name)`: Get a perf config value.
+- `metrics()`: Returns a list of metrics represented as string values in d=
ictionaries.
+- `tracepoint(sys, name)`: Get the tracepoint ID for a given subsystem and=
 event name.
+- `parse_events(evlist_str, cpus=3DNone, threads=3DNone)`: Parse a string =
of events and return an `evlist`.
+- `parse_metrics(metrics_str, pmu=3DNone, cpus=3DNone, threads=3DNone)`: P=
arse a string of metrics or metric groups and return an `evlist`.
+- `pmus()`: Returns a sequence of PMUs.
+- `syscall_name(id, elf_machine=3D0)`: Convert a syscall number to its nam=
e.
+- `syscall_id(name, elf_machine=3D0)`: Convert a syscall name to its numbe=
r.
+
+perf.pmu
+~~~~~~~~
+
+Represents a Performance Monitoring Unit.
+
+- `events()`: Returns a sequence of events encoded as dictionaries.
+- `name()`: Name of the PMU including suffixes.
+
+perf.evlist
+~~~~~~~~~~~
+
+Represents a list of event selectors.
+
+- `all_cpus()`: CPU map union of all evsel CPU maps.
+- `metrics()`: List of metric names within the evlist.
+- `compute_metric(name, cpu, thread)`: Compute metric for given name, cpu =
and thread.
+- `mmap(pages=3D128, overwrite=3DFalse)`: mmap the file descriptor table.
+- `open()`: open the file descriptors.
+- `close()`: close the file descriptors.
+- `poll(timeout=3D-1)`: poll the file descriptor table.
+- `get_pollfd()`: get the poll file descriptor table.
+- `add(evsel)`: adds an event selector to the list.
+- `read_on_cpu(cpu, sample_id_all=3DTrue)`: reads an event from the specif=
ied CPU ring buffer.
+- `config()`: Apply default record options to the evlist.
+- `disable()`: Disable the evsels in the evlist.
+- `enable()`: Enable the evsels in the evlist.
+
+perf.evsel
+~~~~~~~~~~
+
+Represents an event selector.
+
+- `open()`: open the event selector file descriptor table.
+- `cpus()`: CPUs the event is to be used with.
+- `threads()`: threads the event is to be used with.
+- `read(cpu, thread)`: read counters. Returns a count object with `val`, `=
ena`, and `run` attributes.
+
+perf.session
+~~~~~~~~~~~~
+
+Manages a trace session.
+
+- `__init__(data, sample=3DNone, stat=3DNone, context_switch=3DNone, call_=
return=3DNone, itrace=3DNone, vmlinux=3DNone, kallsyms=3DNone, symfs=3DNone=
)`: Creates a new session. `data` is a `perf.data` object. `sample` is a ca=
llback function called for each sample event. `vmlinux`, `kallsyms`, and `s=
ymfs` configure symbol resolution paths.
+- `process_events()`: Reads the trace data and calls the sample callback f=
or each event.
+- `find_thread(pid, tid=3D-1)`: Returns the thread associated with a PID/T=
ID.
+- `e_machine`: ELF machine architecture ID (`EM_*`) of the session.
+- `is_64_bit`: Boolean indicating whether the traced session is 64-bit.
+
+perf.data
+~~~~~~~~~
+
+Represents a trace file.
+
+- `__init__(path=3DNone, fd=3D-1)`: Opens a trace file.
+
+Sample Object
+~~~~~~~~~~~~~
+
+Passed to the `sample` callback function in `perf.session` (or returned by=
 `evlist.read_on_cpu()`).
+
+- `evsel`: The event selector (`perf.evsel` object; `str(sample.evsel)` gi=
ves the event name).
+- `sample_cpu`: The CPU on which the event occurred.
+- `sample_time`: The timestamp of the event in nanoseconds.
+- `sample_pid`: The PID of the process.
+- `sample_tid`: The TID of the thread.
+- `sample_ip`: The sampled instruction pointer.
+- `sample_addr`: The sampled target/data address.
+- `sample_period`: The sample period.
+- `machine_pid`: The guest VM machine PID (`0` for host).
+- `vcpu`: The virtual CPU number for guest events.
+- `raw_buf`: Raw buffer (`bytes`) containing event-specific data.
+- `dso`: Short name of the resolved DSO for `sample_ip`.
+- `dso_long_name`: Full path/long name of the resolved DSO for `sample_ip`=
.
+- `dso_bid`: Build ID of the resolved DSO.
+- `symbol`: Resolved symbol name for `sample_ip`.
+- `sym_start`: Start address of the resolved symbol.
+- `sym_end`: End address of the resolved symbol.
+- `sym_offset`: Offset of `sample_ip` within the resolved symbol (or `None=
` if unresolved).
+- `addr_dso`: Resolved DSO name for `sample_addr` (or `None`).
+- `addr_symbol`: Resolved symbol name for `sample_addr` (or `None`).
+- `addr_sym_offset`: Offset of `sample_addr` within `addr_symbol` (or `Non=
e`).
+- `branch_type`: Branch type flags (`PERF_IP_FLAG_*` masked with `PERF_BRA=
NCH_MASK`).
+- `in_tx`: `1` if the sample occurred inside a hardware transaction, else =
`0`.
+- `flags`: Raw sample flags (`PERF_IP_FLAG_*`).
+- `transaction`: Transaction abort/status code.
+- `brstack`: Sequence of branch stack entries (`from_ip`, `to_ip`, `mispre=
d`, `predicted`, `in_tx`, `abort`, `cycles`, `type`), or `None`.
+- `callchain`: Sequence of callchain nodes (`ip`, `symbol`, `dso`), or `No=
ne`.
+- `srccode(addr=3Dsample_ip)`: Returns a `(filename, line_number, srcline)=
` tuple for `addr` (defaults to `sample_ip`), or `None`.
+- `insn()`: Returns the raw instruction `bytes` for the sample, or `None`.
+- Dynamic tracepoint fields: For tracepoint events (`PERF_TYPE_TRACEPOINT`=
), tracepoint format fields can be accessed directly as attributes on the s=
ample object (e.g. `sample.prev_pid`, `sample.id`, `sample.common_flags`).
+
+COUNTER AND METRIC APIS
+-----------------------
+
+The following APIs are used in `tools/perf/python/ilist.py` for
+interactive listing and reading of counters and metrics:
+
+- `perf.pmus()`: Used to get all available PMUs.
+- `pmu.events()`: Used to get all events for a specific PMU.
+- `perf.metrics()`: Used to get all available metrics.
+- `perf.parse_metrics(metric_name, pmu)`: Used to parse a metric and get a=
n `evlist`.
+- `evlist.compute_metric(metric_name, cpu, thread)`: Used to compute a met=
ric value for a specific CPU and thread.
+- `evsel.read(cpu, thread)`: Used to read raw counter values.
=20
 SEE ALSO
 --------
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Document=
ation/perf-script.txt
index 200ea25891d8..f0228e784ced 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -9,10 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'perf script' [<options>]
-'perf script' [<options>] record <script> [<record-options>] <command>
-'perf script' [<options>] report <script> [script-args]
-'perf script' [<options>] <script> <required-script-args> [<record-options=
>] <command>
-'perf script' [<options>] <top-script> [script-args]
+'perf script' [<options>] <script> [script-args]
=20
 DESCRIPTION
 -----------
@@ -23,58 +20,12 @@ There are several variants of perf script:
   'perf script' to see a detailed trace of the workload that was
   recorded.
=20
-  You can also run a set of pre-canned scripts that aggregate and
-  summarize the raw trace data in various ways (the list of scripts is
-  available via 'perf script -l').  The following variants allow you to
-  record and run those scripts:
-
-  'perf script record <script> <command>' to record the events required
-  for 'perf script report'.  <script> is the name displayed in the
-  output of 'perf script --list' i.e. the actual script name minus any
-  language extension.  If <command> is not specified, the events are
-  recorded using the -a (system-wide) 'perf record' option.
-
-  'perf script report <script> [args]' to run and display the results
-  of <script>.  <script> is the name displayed in the output of 'perf
-  script --list' i.e. the actual script name minus any language
-  extension.  The perf.data output from a previous run of 'perf script
-  record <script>' is used and should be present for this command to
-  succeed.  [args] refers to the (mainly optional) args expected by
-  the script.
-
-  'perf script <script> <required-script-args> <command>' to both
-  record the events required for <script> and to run the <script>
-  using 'live-mode' i.e. without writing anything to disk.  <script>
-  is the name displayed in the output of 'perf script --list' i.e. the
-  actual script name minus any language extension.  If <command> is
-  not specified, the events are recorded using the -a (system-wide)
-  'perf record' option.  If <script> has any required args, they
-  should be specified before <command>.  This mode doesn't allow for
-  optional script args to be specified; if optional script args are
-  desired, they can be specified using separate 'perf script record'
-  and 'perf script report' commands, with the stdout of the record step
-  piped to the stdin of the report script, using the '-o -' and '-i -'
-  options of the corresponding commands.
-
-  'perf script <top-script>' to both record the events required for
-  <top-script> and to run the <top-script> using 'live-mode'
-  i.e. without writing anything to disk.  <top-script> is the name
-  displayed in the output of 'perf script --list' i.e. the actual
-  script name minus any language extension; a <top-script> is defined
-  as any script name ending with the string 'top'.
-
-  [<record-options>] can be passed to the record steps of 'perf script
-  record' and 'live-mode' variants; this isn't possible however for
-  <top-script> 'live-mode' or 'perf script report' variants.
-
-  See the 'SEE ALSO' section for links to language-specific
-  information on how to write and run your own trace scripts.
+  You can also run standalone scripts that aggregate and summarize the
+  raw trace data in various ways (the list of scripts is available via
+  'perf script -l').
=20
 OPTIONS
 -------
-<command>...::
-	Any command you can specify in a shell.
-
 -D::
 --dump-raw-trace=3D::
         Display verbose dump of the trace data.
@@ -90,19 +41,6 @@ OPTIONS
 --list=3D::
         Display a list of available trace scripts.
=20
--s ['lang']::
---script=3D::
-        Process trace data with the given script ([lang]:script[.ext]).
-	If the string 'lang' is specified in place of a script name, a
-        list of supported languages will be displayed instead.
-
--g::
---gen-script=3D::
-	Generate a starter script. If a language is given then the
-        script is named perf-script.[ext] according to the
-        language. If a file path is given then python is used for
-        files ending '.py' and perl used for files ending '.pl'.
-
 --dlfilter=3D<file>::
 	Filter sample events using the given shared object file.
 	Refer linkperf:perf-dlfilter[1]
@@ -115,12 +53,6 @@ OPTIONS
         Display a list of available dlfilters. Use with option -v (must co=
me
         before option --list-dlfilters) to show long descriptions.
=20
--a::
-        Force system-wide collection.  Scripts run without a <command>
-        normally use -a by default, while scripts run with a <command>
-        normally don't - this option allows the latter to be run in
-        system-wide mode.
-
 -i::
 --input=3D::
         Input file name. (default: perf.data unless stdin is a fifo)
@@ -342,7 +274,6 @@ OPTIONS
 	Display extended information about the perf.data file. This adds
 	information which may be very large and thus may clutter the display.
 	It currently includes: cpu and numa topology of the host system.
-	It can only be used with the perf script report mode.
=20
 --show-kernel-path::
 	Try to resolve the path of [kernel.kallsyms]
@@ -543,6 +474,5 @@ include::guest-files.txt[]
=20
 SEE ALSO
 --------
-linkperf:perf-record[1], linkperf:perf-script-perl[1],
-linkperf:perf-script-python[1], linkperf:perf-intel-pt[1],
-linkperf:perf-dlfilter[1]
+linkperf:perf-record[1], linkperf:perf-script-python[1],
+linkperf:perf-intel-pt[1], linkperf:perf-dlfilter[1]
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/t=
ips.txt
index eb6d56d4d8ba..28953179f59d 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -4,7 +4,6 @@ Compare performance results with: perf diff [<old file> <ne=
w file>]
 Boolean options have negative forms, e.g.: perf report --no-children
 To not accumulate CPU time of children symbols add --no-children
 Customize output of perf script with: perf script -F event,ip,sym
-Generate a script for your data: perf script -g <lang>
 Save output of perf stat using: perf stat record <target workload>
 Create an archive with symtabs to analyse on other machine: perf archive
 Search options using a keyword: perf report -h <keyword>
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

