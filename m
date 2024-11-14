Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6671FE117;
	Thu, 14 Nov 2024 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579465; cv=none; b=G1YiHMLF5szIUrNh0T/NMs2kFpaXVBQ0Rs4wzuAuZUfc9iWLMcDAwWb0ovfMzFm+aj9fNSZvmS3Dw0ZNo/kQZHnQKRX0tv91xKJXD/umTWDZqsVs4ujmm8FOe17FRjQNgOkQ9hGhnwNgTMUSb6Q02ieZVjlXuFbVV+SIPRJ+pF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579465; c=relaxed/simple;
	bh=CNC4Qu4W7jk8/r3gBPZqjjI8XDWlS8w03Hcg6IhAZ+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBhIVESiaoXqWRqSbiulIZ2D8H0UfzzqvoVBXGUxZYfRuk6cYuM5N023zVACahRxvQRyovL/PqyWYEXzymbAGxjgaj1SnfKOGWhu39KQrd0rerHZr3GPjNUjSH7EKnkY4y6dZ7JCxn+qZ2N0QQoRSG4MkbTuz1DWwfB1KWVa8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZ7DXCjp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZ7DXCjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731579465; x=1763115465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNC4Qu4W7jk8/r3gBPZqjjI8XDWlS8w03Hcg6IhAZ+8=;
  b=lZ7DXCjpsYhJt9xrv2gJnJMpMeU3xYrTpq35s/EjMV10szAxYZGKlDGe
   Y4E09ibpw8yJj5srRYp4x1N4GWRIlg+KOUfCD3/qYa2DQKWPv2yr1jUXf
   KGuK4LZyoLwZX3PHDiBo21WlmU/RGzul+HgTmDzvxNRSgNmFm3CNNDJ6n
   lwVSNRDx8FSt0OWQ86FflFmwu7yyyb5KqLx3HPLqKIoAWfe6H3ZuFYbFM
   8KnaDy8dgqxM9xa3tflfZ0qCQyQqc0r/mbojigT3wFQSgzdBLikbfxzjC
   sfIvxl4QiVDXKC56IsBuB+oqt0kpncLlQS7j0Br3Mlvd6YXHXsWFsRof1
   A==;
X-CSE-ConnectionGUID: 31kTJQ3MRO6bgvytV7VBiQ==
X-CSE-MsgGUID: vwmUkzFVTi2Gw/zH86OVJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31290552"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31290552"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 02:17:45 -0800
X-CSE-ConnectionGUID: 0O2iuMq9RsexTpSnYF6PXA==
X-CSE-MsgGUID: 7FobATgTTB2VvhhzCAGX2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88588035"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.99.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 02:17:41 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V15 6/7] perf intel-pt: Add documentation for pause / resume
Date: Thu, 14 Nov 2024 12:17:09 +0200
Message-ID: <20241114101711.34987-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114101711.34987-1-adrian.hunter@intel.com>
References: <20241114101711.34987-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Document the use of aux-action config term and provide a simple example.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---


Changes in V5:
	Added more examples


 tools/perf/Documentation/perf-intel-pt.txt | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index ad39bf20f862..cc0f37f0fa5a 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -555,6 +555,9 @@ Support for this feature is indicated by:
 which contains "1" if the feature is supported and
 "0" otherwise.
 
+*aux-action=start-paused*::
+Start tracing paused, refer to the section <<_pause_or_resume_tracing,Pause or Resume Tracing>>
+
 
 config terms on other events
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -570,6 +573,9 @@ and PEBS-via-PT.  In those cases, the other events can have config terms below:
 		Used to select PEBS-via-PT, refer to the
 		section <<_pebs_via_intel_pt,PEBS via Intel PT>>
 
+*aux-action*::
+		Used to pause or resume tracing, refer to the section
+		<<_pause_or_resume_tracing,Pause or Resume Tracing>>
 
 AUX area sampling option
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -1915,6 +1921,108 @@ For pipe mode, the order of events and timestamps can presumably
 be messed up.
 
 
+Pause or Resume Tracing
+-----------------------
+
+With newer Kernels, it is possible to use other selected events to pause
+or resume Intel PT tracing.  This is configured by using the "aux-action"
+config term:
+
+"aux-action=pause" is used with events that are to pause Intel PT tracing.
+
+"aux-action=resume" is used with events that are to resume Intel PT tracing.
+
+"aux-action=start-paused" is used with the Intel PT event to start in a
+paused state.
+
+For example, to trace only the uname system call (sys_newuname) when running the
+command line utility uname:
+
+ $ perf record --kcore -e intel_pt/aux-action=start-paused/k,syscalls:sys_enter_newuname/aux-action=resume/,syscalls:sys_exit_newuname/aux-action=pause/ uname
+ Linux
+ [ perf record: Woken up 1 times to write data ]
+ [ perf record: Captured and wrote 0.043 MB perf.data ]
+ $ perf script --call-trace
+ uname   30805 [000] 24001.058782799: name: 0x7ffc9c1865b0
+ uname   30805 [000] 24001.058784424:  psb offs: 0
+ uname   30805 [000] 24001.058784424:  cbr: 39 freq: 3904 MHz (139%)
+ uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        debug_smp_processor_id
+ uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        __x64_sys_newuname
+ uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            down_read
+ uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                __cond_resched
+ uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
+ uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                    in_lock_functions
+ uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_sub
+ uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            up_read
+ uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
+ uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    in_lock_functions
+ uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                preempt_count_sub
+ uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            _copy_to_user
+ uname   30805 [000] 24001.058784838: ([kernel.kallsyms])        syscall_exit_to_user_mode
+ uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            syscall_exit_work
+ uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                perf_syscall_exit
+ uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    debug_smp_processor_id
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_trace_buf_alloc
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_get_recursion_context
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            debug_smp_processor_id
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        debug_smp_processor_id
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_tp_event
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_trace_buf_update
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            tracing_gen_ctx_irq_test
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_event
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            __perf_event_account_interrupt
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                __this_cpu_preempt_check
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            perf_event_output_forward
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                perf_event_aux_pause
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                    ring_buffer_get
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_lock
+ uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_unlock
+ uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                    pt_event_stop
+ uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
+ uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
+ uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        native_write_msr
+ uname   30805 [000] 24001.058785463: ([kernel.kallsyms])                                        native_write_msr
+ uname   30805 [000] 24001.058785639: 0x0
+
+The example above uses tracepoints, but any kind of sampled event can be used.
+
+For example:
+
+ Tracing between arch_cpu_idle_enter() and arch_cpu_idle_exit() using breakpoint events:
+
+ $ sudo cat /proc/kallsyms | sort | grep ' arch_cpu_idle_enter\| arch_cpu_idle_exit'
+ ffffffffb605bf60 T arch_cpu_idle_enter
+ ffffffffb614d8a0 W arch_cpu_idle_exit
+ $ sudo perf record --kcore -a -e intel_pt/aux-action=start-paused/k -e mem:0xffffffffb605bf60:x/aux-action=resume/ -e mem:0xffffffffb614d8a0:x/aux-action=pause/ -- sleep 1
+ [ perf record: Woken up 1 times to write data ]
+ [ perf record: Captured and wrote 1.387 MB perf.data ]
+
+ Tracing __alloc_pages() using kprobes:
+
+ $ sudo perf probe --add '__alloc_pages order'
+ Added new event:  probe:__alloc_pages  (on __alloc_pages with order)
+ $ sudo perf probe --add __alloc_pages%return
+ Added new event:  probe:__alloc_pages__return (on __alloc_pages%return)
+ $ sudo perf record --kcore -aR -e intel_pt/aux-action=start-paused/k -e probe:__alloc_pages/aux-action=resume/ -e probe:__alloc_pages__return/aux-action=pause/ -- sleep 1
+ [ perf record: Woken up 1 times to write data ]
+ [ perf record: Captured and wrote 1.490 MB perf.data ]
+
+ Tracing starting at main() using a uprobe event:
+
+ $ sudo perf probe -x /usr/bin/uname main
+ Added new event:  probe_uname:main     (on main in /usr/bin/uname)
+ $ sudo perf record -e intel_pt/-aux-action=start-paused/u -e probe_uname:main/aux-action=resume/ -- uname
+ Linux
+ [ perf record: Woken up 1 times to write data ]
+ [ perf record: Captured and wrote 0.031 MB perf.data ]
+
+ Tracing occasionally using cycles events with different periods:
+
+ $ perf record --kcore -a -m,64M -e intel_pt/aux-action=start-paused/k -e cycles/aux-action=pause,period=1000000/Pk -e cycles/aux-action=resume,period=10500000/Pk -- firefox
+ [ perf record: Woken up 19 times to write data ]
+ [ perf record: Captured and wrote 16.561 MB perf.data ]
+
+
 EXAMPLE
 -------
 
-- 
2.43.0

