From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/5] perf unwind: Do not look at globals
Date: Tue, 16 Jan 2018 15:26:50 -0300
Message-ID: <20180116182650.GE16107@kernel.org>
References: <20180116142438.19520-1-acme@kernel.org>
 <20180116142438.19520-3-acme@kernel.org>
 <20180116151915.GC17819@krava>
 <20180116153621.GC16107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbeAPS0x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Jan 2018 13:26:53 -0500
Content-Disposition: inline
In-Reply-To: <20180116153621.GC16107@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>

Em Tue, Jan 16, 2018 at 12:36:21PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jan 16, 2018 at 04:19:15PM +0100, Jiri Olsa escreveu:
> > it should get set in apply_config_terms which calls parse_callchain_record
 
> No, it should not set the global parameter, as this is just for a
> specific event, i.e. we can have something like:
 
> 	perf record -e cycles/call-graph=dwarf/ \
> 		    -e instructions/call-graph=lbr/
> 		    -e cache-misses/call-graph=fp
 
> And then get these samples for the same thread.

<SNIP>

> > once it detects some 'call-graph' term setup.. something's probably wrong
> > there?
 
> See above. The fix in this patch is the quickest, i.e. we make sure that
> if we ever find DWARF callchains, what we need will be there. We could
> introduce a new global variable that would be touched by
> apply_config_terms() now, and touch that, not the global config, that
> may be used by other code, that would think that hey, DWARF is globally
> configured, when it is just by some of the events.

So, look at the patch at the end of this message, better (for now),
replacing this one (2/5).

I retested everything, same results.
 
> But if we do that, we will waste some space anyway since not all threads
> will have DWARF callchains, e.g. in a system wide session.

- Arnaldo

commit 8a302012fabdb387ab45a0d0b283411a8fd05b32
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jan 15 16:48:46 2018 -0300

    perf unwind: Do not look just at the global callchain_param.record_mode
    
    When setting up DWARF callchains on specific events, without using
    'record' or 'trace' --call-graph, but instead doing it like:
    
            perf trace -e cycles/call-graph=dwarf/
    
    The unwind__prepare_access() call in thread__insert_map() when we
    process PERF_RECORD_MMAP(2) metadata events were not being performed,
    precluding us from using per-event DWARF callchains, handling them just
    when we asked for all events to be DWARF, using "--call-graph dwarf".
    
    We do it in the PERF_RECORD_MMAP because we have to look at one of the
    executable maps to figure out the executable type (64-bit, 32-bit) of
    the DSO laid out in that mmap. Also to look at the architecture where
    the perf.data file was recorded.
    
    All this probably should be deferred to when we process a sample for
    some thread that has callchains, so that we do this processing only for
    the threads with samples, not for all of them.
    
    For now, fix using DWARF on specific events.
    
    Before:
    
      # perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
      PING ::1(::1) 56 data bytes
      64 bytes from ::1: icmp_seq=1 ttl=64 time=0.048 ms
    
      --- ::1 ping statistics ---
      1 packets transmitted, 1 received, 0% packet loss, time 0ms
      rtt min/avg/max/mdev = 0.048/0.048/0.048/0.000 ms
         0.000 probe_libc:inet_pton:(7fe9597bb350))
      Problem processing probe_libc:inet_pton callchain, skipping...
      #
    
    After:
    
      # perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
      PING ::1(::1) 56 data bytes
      64 bytes from ::1: icmp_seq=1 ttl=64 time=0.060 ms
    
      --- ::1 ping statistics ---
      1 packets transmitted, 1 received, 0% packet loss, time 0ms
      rtt min/avg/max/mdev = 0.060/0.060/0.060/0.000 ms
           0.000 probe_libc:inet_pton:(7fd4aa930350))
                                             __inet_pton (inlined)
                                             gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                             __GI_getaddrinfo (inlined)
                                             [0xffffaa804e51af3f] (/usr/bin/ping)
                                             __libc_start_main (/usr/lib64/libc-2.26.so)
                                             [0xffffaa804e51b379] (/usr/bin/ping)
      #
      # perf trace --call-graph=dwarf --no-syscalls -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
      PING ::1(::1) 56 data bytes
      64 bytes from ::1: icmp_seq=1 ttl=64 time=0.057 ms
    
      --- ::1 ping statistics ---
      1 packets transmitted, 1 received, 0% packet loss, time 0ms
      rtt min/avg/max/mdev = 0.057/0.057/0.057/0.000 ms
           0.000 probe_libc:inet_pton:(7f9363b9e350))
                                             __inet_pton (inlined)
                                             gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                             __GI_getaddrinfo (inlined)
                                             [0xffffa9e8a14e0f3f] (/usr/bin/ping)
                                             __libc_start_main (/usr/lib64/libc-2.26.so)
                                             [0xffffa9e8a14e1379] (/usr/bin/ping)
      #
      # perf trace --call-graph=fp --no-syscalls -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
      PING ::1(::1) 56 data bytes
      64 bytes from ::1: icmp_seq=1 ttl=64 time=0.077 ms
    
      --- ::1 ping statistics ---
      1 packets transmitted, 1 received, 0% packet loss, time 0ms
      rtt min/avg/max/mdev = 0.077/0.077/0.077/0.000 ms
           0.000 probe_libc:inet_pton:(7f4947e1c350))
                                             __inet_pton (inlined)
                                             gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                             __GI_getaddrinfo (inlined)
                                             [0xffffaa716d88ef3f] (/usr/bin/ping)
                                             __libc_start_main (/usr/lib64/libc-2.26.so)
                                             [0xffffaa716d88f379] (/usr/bin/ping)
      #
      # perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=fp/ ping -6 -c 1 ::1
      PING ::1(::1) 56 data bytes
      64 bytes from ::1: icmp_seq=1 ttl=64 time=0.078 ms
    
      --- ::1 ping statistics ---
      1 packets transmitted, 1 received, 0% packet loss, time 0ms
      rtt min/avg/max/mdev = 0.078/0.078/0.078/0.000 ms
           0.000 probe_libc:inet_pton:(7fa157696350))
                                             __GI___inet_pton (/usr/lib64/libc-2.26.so)
                                             getaddrinfo (/usr/lib64/libc-2.26.so)
                                             [0xffffa9ba39c74f40] (/usr/bin/ping)
      #
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
    Cc: Wang Nan <wangnan0@huawei.com>
    Link: https://lkml.kernel.org/n/tip-kmuyp11wsfhjrz4427ayh97u@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c0debc3f79b6..c0815a37fdb5 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2390,9 +2390,10 @@ static int setup_callchain(struct perf_evlist *evlist)
 	enum perf_call_graph_mode mode = CALLCHAIN_NONE;
 
 	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
-	    (sample_type & PERF_SAMPLE_STACK_USER))
+	    (sample_type & PERF_SAMPLE_STACK_USER)) {
 		mode = CALLCHAIN_DWARF;
-	else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+		dwarf_callchain_users = true;
+	} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
 		mode = CALLCHAIN_LBR;
 	else if (sample_type & PERF_SAMPLE_CALLCHAIN)
 		mode = CALLCHAIN_FP;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dd4df9a5cd06..6593779224d5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -338,9 +338,10 @@ static int report__setup_sample_type(struct report *rep)
 
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		    (sample_type & PERF_SAMPLE_STACK_USER))
+		    (sample_type & PERF_SAMPLE_STACK_USER)) {
 			callchain_param.record_mode = CALLCHAIN_DWARF;
-		else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+			dwarf_callchain_users = true;
+		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
 			callchain_param.record_mode = CALLCHAIN_LBR;
 		else
 			callchain_param.record_mode = CALLCHAIN_FP;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c1cce474c0f1..08bc818f371b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2919,9 +2919,10 @@ static void script__setup_sample_type(struct perf_script *script)
 
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		    (sample_type & PERF_SAMPLE_STACK_USER))
+		    (sample_type & PERF_SAMPLE_STACK_USER)) {
 			callchain_param.record_mode = CALLCHAIN_DWARF;
-		else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+			dwarf_callchain_users = true;
+		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
 			callchain_param.record_mode = CALLCHAIN_LBR;
 		else
 			callchain_param.record_mode = CALLCHAIN_FP;
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index ac40e05bcab4..260418969120 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -173,6 +173,7 @@ int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unu
 	}
 
 	callchain_param.record_mode = CALLCHAIN_DWARF;
+	dwarf_callchain_users = true;
 
 	if (init_live_machine(machine)) {
 		pr_err("Could not init machine\n");
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 082505d08d72..32ef7bdca1cf 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -37,6 +37,15 @@ struct callchain_param callchain_param = {
 	CALLCHAIN_PARAM_DEFAULT
 };
 
+/*
+ * Are there any events usind DWARF callchains?
+ *
+ * I.e.
+ *
+ * -e cycles/call-graph=dwarf/
+ */
+bool dwarf_callchain_users;
+
 struct callchain_param callchain_param_default = {
 	CALLCHAIN_PARAM_DEFAULT
 };
@@ -265,6 +274,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 			ret = 0;
 			param->record_mode = CALLCHAIN_DWARF;
 			param->dump_size = default_stack_dump_size;
+			dwarf_callchain_users = true;
 
 			tok = strtok_r(NULL, ",", &saveptr);
 			if (tok) {
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index b79ef2478a57..154560b1eb65 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -89,6 +89,8 @@ enum chain_value {
 	CCVAL_COUNT,
 };
 
+extern bool dwarf_callchain_users;
+
 struct callchain_param {
 	bool			enabled;
 	enum perf_call_graph_mode record_mode;
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 7a42f703e858..af873044d33a 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -631,9 +631,8 @@ static unw_accessors_t accessors = {
 
 static int _unwind__prepare_access(struct thread *thread)
 {
-	if (callchain_param.record_mode != CALLCHAIN_DWARF)
+	if (!dwarf_callchain_users)
 		return 0;
-
 	thread->addr_space = unw_create_addr_space(&accessors, 0);
 	if (!thread->addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
@@ -646,17 +645,15 @@ static int _unwind__prepare_access(struct thread *thread)
 
 static void _unwind__flush_access(struct thread *thread)
 {
-	if (callchain_param.record_mode != CALLCHAIN_DWARF)
+	if (!dwarf_callchain_users)
 		return;
-
 	unw_flush_cache(thread->addr_space, 0, 0);
 }
 
 static void _unwind__finish_access(struct thread *thread)
 {
-	if (callchain_param.record_mode != CALLCHAIN_DWARF)
+	if (!dwarf_callchain_users)
 		return;
-
 	unw_destroy_addr_space(thread->addr_space);
 }
 
