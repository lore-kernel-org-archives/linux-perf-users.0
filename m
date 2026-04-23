Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140893DB646
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916669; cv=none; b=rlLPePqyp8l9A8Vf1ako6iwteqhGpSxZ1XrS2cSe/1VyUoDjqzWj6BTOT/TE5JxWqCvfZWkMz5NQ/2tz4N5U53kWI5i/+IhKOBnEypdnLi96d2S+VSCdExDqt/dE23DXwni5uwuuddH1dxdmNDIR4eI7nM6aLxaA1i4pSYDMy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916669; c=relaxed/simple;
	bh=6HLu0q+Ode2aBeKTpvJrdQfLrCN5KwhMvetsXqcZQ/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MHpN7CYWvKdGy0496INuh6OVrXvhrFzVh7ANkXFKzMlQpRWDIzSjqLchv9NgEY4gxBulIsZ4fxsQcQlJbPQRNeK5CzsPQ3kqbmvEzMz4rfSbK8yC/MZrWKcj8uwA89Dx2ferwcoqcCwyWq8zpPW7qCqvoK+cbnCdm6ViYUNldwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mf91NBkp; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mf91NBkp"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso7755887eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916663; x=1777521463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzJhwJJbGMwLgraXuo1AC3xgKYXUNjZLM/wnBJRowp8=;
        b=Mf91NBkpxaeKbajVqyscv7YxHUutJdnIYCnmmDYfDHK+8Ot1DWECzXkiRpKv2LvOVA
         tRc732nSX+1sRtPbQxcl7D9EzU2P0azKnLgqjD9/ZfDgFiwpSSYZ7K+2vhhBV9/wpw4E
         kr+Tcuhrgzs+l2aHVpHdm2MAU7ZuVjpsu7z0FdOpHEYlvtGBNRUkiLOjVR3B9D8ukfdd
         0JTsmeLAwqvLbx3tzm9xcoYkY9+2otjin2e7MTwq0fvEElUN4gppd+tJCiDkiPICjU7+
         FrDzRkX9v2AHja64MvCXsxG/gOnxGv8p7U8tK8v/NE0fVM2ZiyRl1LAwbEe9+CyTmMp9
         ckXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916663; x=1777521463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzJhwJJbGMwLgraXuo1AC3xgKYXUNjZLM/wnBJRowp8=;
        b=YlRuNvpdDH0UEbsPjTm9rFFVzf+QEBpDXA5MIvMvtl/E6w6UeFcn0+G9OhPncLDDUq
         kSeZATITGc5/m95i+x+ETKqt1ouN/DDHpaDZwKYTra2z9da45eKuHcnZJPSvzaSfM4Zl
         oW9g0N9K5turjQECgvdBXF4tAPU8yGEeBkwcq0OlyzGFSvrZN6wLa25zJxaj02QYG4O6
         7E/y5YLL43tAYmSgPsOR/RPaIyL+WnzfoMcm+blMkvMCMpUJszBPkkGyIunQZgU3l1cc
         TmTaeGNcfTWL4uH3a8rvU2qUTWrqIj4yfIjpDOdMsW1OrRVwGZXWikraVXKMngyCj8Di
         BStA==
X-Forwarded-Encrypted: i=1; AFNElJ/uTS9KGiYREhOFFCXD7ohk4TXEoLu1O1KNmylUkocIrgRHlkwdaUrah0HPbT99+UAvYQ1lteAxNKP18Lfx7rlM@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPBbvs7LiEWjsHienuRa7s6jEFdkjXpugYFcj+yUyFnAYU0af
	HnKrBEgXXpQHnBOeE4ZMX6t9KSnw/Zipb8Sq12Ou9I7VbrqCp6hJaOaeHsZeqiZuupJreNjy0BD
	De/+2AYzgxw==
X-Received: from dlbsn12.prod.google.com ([2002:a05:7022:b90c:b0:12d:b26a:1571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:513:b0:128:bf5f:7073
 with SMTP id a92af1059eb24-12c73f975ebmr13571823c88.24.1776916662798; Wed, 22
 Apr 2026 20:57:42 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:24 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-58-irogers@google.com>
Subject: [PATCH v2 57/58] perf Documentation: Update for standalone Python
 scripts and remove obsolete data
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"

- Remove documentation for -g and -s options in perf-script.txt.
- Remove links to perf-script-perl in perf-script.txt.
- Rewrite perf-script-python.txt to describe the new standalone script
  usage with perf module.
- Remove obsolete perf-script-perl.txt.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-script-perl.txt | 216 ------
 .../perf/Documentation/perf-script-python.txt | 702 +++---------------
 tools/perf/Documentation/perf-script.txt      |  70 +-
 3 files changed, 95 insertions(+), 893 deletions(-)
 delete mode 100644 tools/perf/Documentation/perf-script-perl.txt

diff --git a/tools/perf/Documentation/perf-script-perl.txt b/tools/perf/Documentation/perf-script-perl.txt
deleted file mode 100644
index 5b479f5e62ff..000000000000
--- a/tools/perf/Documentation/perf-script-perl.txt
+++ /dev/null
@@ -1,216 +0,0 @@
-perf-script-perl(1)
-===================
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
-       $comm, $pid, $prio, $success, $target_cpu) = @_;
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
-        $common_nsecs, $common_pid, $common_comm) = @_;
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
-  flag_str($event_name, $field_name, $field_value) - returns the string representation corresponding to $field_value for the flag field $field_name of event $event_name
-  symbol_str($event_name, $field_name, $field_value) - returns the string representation corresponding to $field_value for the symbolic field $field_name of event $event_name
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
- common_lock_depth($context) - returns common_lock_depth for the current event
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
-  avg($total, $n) - returns average given a sum and a total number of values
-
-SEE ALSO
---------
-linkperf:perf-script[1]
diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 27a1cac6fe76..9293057cee8e 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -3,676 +3,152 @@ perf-script-python(1)
 
 NAME
 ----
-perf-script-python - Process trace data with a Python script
+perf-script-python - Process trace data with a Python script using perf module
 
 SYNOPSIS
 --------
 [verse]
-'perf script' [-s [Python]:script[.py] ]
+'perf script' <script>.py
 
 DESCRIPTION
 -----------
 
-This perf script option is used to process perf script data using perf's
-built-in Python interpreter.  It reads and processes the input file and
-displays the results of the trace analysis implemented in the given
-Python script, if any.
+This document describes how to use the `perf` Python module to process
+trace data recorded by `perf record`.
+
+With the removal of embedded Python interpreter from `perf`, scripts
+are now run as standalone Python programs that import the `perf`
+module to access trace data.
 
 A QUICK EXAMPLE
 ---------------
 
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
+This section shows how to create a simple Python script that reads a
+`perf.data` file and prints event information.
 
-The syscall-counts script is a simple script, but demonstrates all the
-basic ideas necessary to create a useful script.  Here's an example
-of its output (syscall names are not yet supported, they will appear
-as numbers):
+Create a file named `print_events.py` with the following content:
 
 ----
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
+#!/usr/bin/env python3
+import perf
 
-- we could enable every event under the tracing/events/syscalls
-  directory, but this is over 600 syscalls, well beyond the number
-  allowable by perf.  These individual syscall events will however be
-  useful if we want to later use the guidance we get from the
-  general-purpose scripts to drill down and get more detail about
-  individual syscalls of interest.
+def process_event(sample):
+    print(f"Event: {sample.evsel} on CPU {sample.sample_cpu} at {sample.sample_time}")
 
-- we can enable the sys_enter and/or sys_exit syscalls found under
-  tracing/events/raw_syscalls.  These are called for all syscalls; the
-  'id' field can be used to distinguish between individual syscall
-  numbers.
-
-For this script, we only need to know that a syscall was entered; we
-don't care how it exited, so we'll use 'perf record' to record only
-the sys_enter events:
+# Open the session with perf.data file
+session = perf.session(perf.data("perf.data"), sample=process_event)
 
+# Process all events
+session.process_events()
 ----
-# perf record -a -e raw_syscalls:sys_enter
 
-^C[ perf record: Woken up 1 times to write data ]
-[ perf record: Captured and wrote 56.545 MB perf.data (~2470503 samples) ]
+Make the script executable:
 ----
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
+$ chmod +x print_events.py
 ----
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
-# See the perf-script-python Documentation for the list of available functions.
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
-		print "id=%d, args=%s\n" % \
-		(id, args),
-
-def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
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
 
+Record some data:
 ----
-# mv perf-script.py syscall-counts.py
-# perf script -s syscall-counts.py
-
-raw_syscalls__sys_enter     1 00840.847582083     7506 perf                  id=1, args=
-raw_syscalls__sys_enter     1 00840.847595764     7506 perf                  id=1, args=
-raw_syscalls__sys_enter     1 00840.847620860     7506 perf                  id=1, args=
-raw_syscalls__sys_enter     1 00840.847710478     6533 npviewer.bin          id=78, args=
-raw_syscalls__sys_enter     1 00840.847719204     6533 npviewer.bin          id=142, args=
-raw_syscalls__sys_enter     1 00840.847755445     6533 npviewer.bin          id=3, args=
-raw_syscalls__sys_enter     1 00840.847775601     6533 npviewer.bin          id=3, args=
-raw_syscalls__sys_enter     1 00840.847781820     6533 npviewer.bin          id=3, args=
-.
-.
-.
+$ perf record -a sleep 1
 ----
 
-Of course, for this script, we're not interested in printing every
-trace event, but rather aggregating it in a useful way.  So we'll get
-rid of everything to do with printing as well as the trace_begin() and
-trace_unhandled() functions, which we won't be using.  That leaves us
-with this minimalistic skeleton:
-
+Run the script:
 ----
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-
-def trace_end():
-	print "in trace_end"
-
-def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
+$ perf script print_events.py
 ----
 
-In trace_end(), we'll simply print the results, but first we need to
-generate some results to print.  To do that we need to have our
-sys_enter() handler do the necessary tallying until all events have
-been counted.  A hash table indexed by syscall id is a good way to
-store that information; every time the sys_enter() handler is called,
-we simply increment a count associated with that hash entry indexed by
-that syscall id:
-
+Or run it directly with Python, ensuring `perf.so` is in your `PYTHONPATH`:
 ----
-  syscalls = autodict()
-
-  try:
-    syscalls[id] += 1
-  except TypeError:
-    syscalls[id] = 1
+$ PYTHONPATH=/path/to/perf/python python3 print_events.py
 ----
 
-The syscalls 'autodict' object is a special kind of Python dictionary
-(implemented in Core.py) that implements Perl's 'autovivifying' hashes
-in Python i.e. with autovivifying hashes, you can assign nested hash
-values without having to go to the trouble of creating intermediate
-levels if they don't exist e.g syscalls[comm][pid][id] = 1 will create
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
-syscalls = autodict()
-
-def trace_end():
-	print_syscall_totals()
-
-def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
-	try:
-		syscalls[id] += 1
-	except TypeError:
-		syscalls[id] = 1
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
-    for id, val in sorted(syscalls.iteritems(), key = lambda(k, v): (v, k), \
-				  reverse = True):
-	    print "%-40s  %10d\n" % (syscall_name(id), val),
-----
-
-The script can be run just as before:
-
-  # perf script -s syscall-counts.py
-
-So those are the essential steps in writing and running a script.  The
-process can be generalized to any tracepoint or set of tracepoints
-you're interested in - basically find the tracepoint(s) you're
-interested in by looking at the list of available events shown by
-'perf list' and/or look in /sys/kernel/tracing/events/ for
-detailed event and field info, record the corresponding trace data
-using 'perf record', passing it the list of interesting events,
-generate a skeleton script using 'perf script -g python' and modify the
-code to aggregate and display it for your particular needs.
-
-After you've done that you may end up with a general-purpose script
-that you want to keep around and have available for future use.  By
-writing a couple of very simple shell scripts and putting them in the
-right place, you can have your script listed alongside the other
-scripts listed by the 'perf script -l' command e.g.:
-
-----
-# perf script -l
-List of available trace scripts:
-  wakeup-latency                       system-wide min/max/avg wakeup latency
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
-
-----
-# cat kernel-source/tools/perf/scripts/python/bin/syscall-counts-record
-
-#!/bin/bash
-perf record -a -e raw_syscalls:sys_enter
-----
-
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
-  wakeup-latency                       system-wide min/max/avg wakeup latency
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
-def context_switch(ts, cpu, pid, tid, np_pid, np_tid, machine_pid, out, out_preempt, *x):
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
+The `perf` module provides several classes and functions to interact
+with trace data.
 
-These functions provide some essential functions to user scripts.
+### Module Functions
 
-The *flag_str* and *symbol_str* functions provide human-readable
-strings for flag and symbolic fields.  These correspond to the strings
-and values parsed from the 'print fmt' fields of the event format
-files:
+- `config_get(name)`: Get a perf config value.
+- `metrics()`: Returns a list of metrics represented as string values in dictionaries.
+- `tracepoint(subsystem, name)`: Get tracepoint config.
+- `parse_events(string)`: Parse a string of events and return an `evlist`.
+- `parse_metrics(string, pmu=None)`: Parse a string of metrics or metric groups and return an `evlist`.
+- `pmus()`: Returns a sequence of PMUs.
+- `syscall_name(num)`: Turns a syscall number to a string.
+- `syscall_id(name)`: Turns a syscall name to a number.
 
-  flag_str(event_name, field_name, field_value) - returns the string representation corresponding to field_value for the flag field field_name of event event_name
-  symbol_str(event_name, field_name, field_value) - returns the string representation corresponding to field_value for the symbolic field field_name of event event_name
+### `perf.pmu`
 
-The *autodict* function returns a special kind of Python
-dictionary that implements Perl's 'autovivifying' hashes in Python
-i.e. with autovivifying hashes, you can assign nested hash values
-without having to go to the trouble of creating intermediate levels if
-they don't exist.
+Represents a Performance Monitoring Unit.
 
-  autodict() - returns an autovivifying dictionary instance
+- `events()`: Returns a sequence of events encoded as dictionaries.
+- `name()`: Name of the PMU including suffixes.
 
+### `perf.evlist`
 
-perf_trace_context Module
-~~~~~~~~~~~~~~~~~~~~~~~~~
+Represents a list of event selectors.
 
-Some of the 'common' fields in the event format file aren't all that
-common, but need to be made accessible to user scripts nonetheless.
+- `all_cpus()`: CPU map union of all evsel CPU maps.
+- `metrics()`: List of metric names within the evlist.
+- `compute_metric(name, cpu, thread)`: Compute metric for given name, cpu and thread.
+- `mmap()`: mmap the file descriptor table.
+- `open()`: open the file descriptors.
+- `close()`: close the file descriptors.
+- `poll()`: poll the file descriptor table.
+- `get_pollfd()`: get the poll file descriptor table.
+- `add(evsel)`: adds an event selector to the list.
+- `read_on_cpu(cpu)`: reads an event.
+- `config()`: Apply default record options to the evlist.
+- `disable()`: Disable the evsels in the evlist.
+- `enable()`: Enable the evsels in the evlist.
 
-perf_trace_context defines a set of functions that can be used to
-access this data in the context of the current event.  Each of these
-functions expects a context variable, which is the same as the
-context variable passed into every tracepoint event handler as the second
-argument. For non-tracepoint events, the context variable is also present
-as perf_trace_context.perf_script_context .
+### `perf.evsel`
 
- common_pc(context) - returns common_preempt count for the current event
- common_flags(context) - returns common_flags for the current event
- common_lock_depth(context) - returns common_lock_depth for the current event
- perf_sample_insn(context) - returns the machine code instruction
- perf_set_itrace_options(context, itrace_options) - set --itrace options if they have not been set already
- perf_sample_srcline(context) - returns source_file_name, line_number
- perf_sample_srccode(context) - returns source_file_name, line_number, source_line
- perf_config_get(config_name) - returns the value of the named config item, or None if unset
+Represents an event selector.
 
-Util.py Module
-~~~~~~~~~~~~~~
+- `open()`: open the event selector file descriptor table.
+- `cpus()`: CPUs the event is to be used with.
+- `threads()`: threads the event is to be used with.
+- `read(cpu, thread)`: read counters. Returns a count object with `val`, `ena`, and `run` attributes.
 
-Various utility functions for use with perf script:
+### `perf.session`
 
-  nsecs(secs, nsecs) - returns total nsecs given secs/nsecs pair
-  nsecs_secs(nsecs) - returns whole secs portion given nsecs
-  nsecs_nsecs(nsecs) - returns nsecs remainder given nsecs
-  nsecs_str(nsecs) - returns printable string in the form secs.nsecs
-  avg(total, n) - returns average given a sum and a total number of values
+Manages a trace session.
 
-SUPPORTED FIELDS
-----------------
+- `__init__(data, sample=None)`: Creates a new session. `data` is a `perf.data` object. `sample` is a callback function called for each sample event.
+- `process_events()`: Reads the trace data and calls the sample callback for each event.
 
-Currently supported fields:
+### `perf.data`
 
-ev_name, comm, id, stream_id, pid, tid, cpu, ip, time, period, phys_addr,
-addr, symbol, symoff, dso, time_enabled, time_running, values, callchain,
-brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
-weight, transaction, raw_buf, attr, cpumode.
+Represents a trace file.
 
-Fields that may also be present:
+- `__init__(filename, mode=perf.DATA_MODE_READ)`: Opens a trace file.
 
- flags - sample flags
- flags_disp - sample flags display
- insn_cnt - instruction count for determining instructions-per-cycle (IPC)
- cyc_cnt - cycle count for determining IPC
- addr_correlates_sym - addr can correlate to a symbol
- addr_dso - addr dso
- addr_symbol - addr symbol
- addr_symoff - addr symbol offset
+### Sample Object
 
-Some fields have sub items:
+Passed to the callback function in `perf.session`.
 
-brstack:
-    from, to, from_dsoname, to_dsoname, mispred,
-    predicted, in_tx, abort, cycles.
+- `evsel`: The event selector (name of the event).
+- `sample_cpu`: The CPU on which the event occurred.
+- `sample_time`: The timestamp of the event.
+- `sample_pid`: The PID of the process.
+- `sample_tid`: The TID of the thread.
+- `raw_buf`: Raw buffer containing event specific data.
 
-brstacksym:
-    items: from, to, pred, in_tx, abort (converted string)
+COUNTER AND METRIC APIS
+-----------------------
 
-For example,
-We can use this code to print brstack "from", "to", "cycles".
+The following APIs are used in `tools/perf/python/ilist.py` for
+interactive listing and reading of counters and metrics:
 
-if 'brstack' in dict:
-	for entry in dict['brstack']:
-		print "from %s, to %s, cycles %s" % (entry["from"], entry["to"], entry["cycles"])
+- `perf.pmus()`: Used to get all available PMUs.
+- `pmu.events()`: Used to get all events for a specific PMU.
+- `perf.metrics()`: Used to get all available metrics.
+- `perf.parse_metrics(metric_name, pmu)`: Used to parse a metric and get an `evlist`.
+- `evlist.compute_metric(metric_name, cpu, thread)`: Used to compute a metric value for a specific CPU and thread.
+- `evsel.read(cpu, thread)`: Used to read raw counter values.
 
 SEE ALSO
 --------
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 200ea25891d8..93ed1ea704c9 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -9,10 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'perf script' [<options>]
-'perf script' [<options>] record <script> [<record-options>] <command>
-'perf script' [<options>] report <script> [script-args]
-'perf script' [<options>] <script> <required-script-args> [<record-options>] <command>
-'perf script' [<options>] <top-script> [script-args]
+'perf script' [<options>] <script> [script-args]
 
 DESCRIPTION
 -----------
@@ -23,52 +20,9 @@ There are several variants of perf script:
   'perf script' to see a detailed trace of the workload that was
   recorded.
 
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
 
 OPTIONS
 -------
@@ -90,18 +44,7 @@ OPTIONS
 --list=::
         Display a list of available trace scripts.
 
--s ['lang']::
---script=::
-        Process trace data with the given script ([lang]:script[.ext]).
-	If the string 'lang' is specified in place of a script name, a
-        list of supported languages will be displayed instead.
 
--g::
---gen-script=::
-	Generate a starter script. If a language is given then the
-        script is named perf-script.[ext] according to the
-        language. If a file path is given then python is used for
-        files ending '.py' and perl used for files ending '.pl'.
 
 --dlfilter=<file>::
 	Filter sample events using the given shared object file.
@@ -543,6 +486,5 @@ include::guest-files.txt[]
 
 SEE ALSO
 --------
-linkperf:perf-record[1], linkperf:perf-script-perl[1],
-linkperf:perf-script-python[1], linkperf:perf-intel-pt[1],
-linkperf:perf-dlfilter[1]
+linkperf:perf-record[1], linkperf:perf-script-python[1],
+linkperf:perf-intel-pt[1], linkperf:perf-dlfilter[1]
-- 
2.54.0.rc2.533.g4f5dca5207-goog

