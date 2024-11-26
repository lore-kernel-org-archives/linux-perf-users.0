Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC128F5;
	Tue, 26 Nov 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632448; cv=none; b=QgqfthHvpYUyV+fZW7PeU+Z+zEw5PfPyNthJbL172f59sKOx+RAyewjeTBDESAx9vR69WDmEcuQIy5dypDU4aZAW6u4/BXqxgvIeJNwW5hckR0Y6rEzrPbnuocbLzvwXHzo/Pna8caTExlvTFdchWRZKOsq5EeEX4MSSEgxaG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632448; c=relaxed/simple;
	bh=OP49O2loUwXBT7xVhkKSFp18B+LQzxJZ2hFgzKgjogY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JFe7pq0VbdQw/UbedVhcKAj89LvPSQd6Za7gGTZ4wcc6+ynyHtgAQPtZl6K256hqIFi24TdtN2i5VsPDALrOK/KNLFIvcfWZ5q4OrihoLCBiAVzPqZlPqZ4AaiuGPvTev5iemI7FN49NwEgB0XrWeACQQodAlEWYkZENJXCLj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e42HrBFj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e42HrBFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EA7C4CECF;
	Tue, 26 Nov 2024 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732632448;
	bh=OP49O2loUwXBT7xVhkKSFp18B+LQzxJZ2hFgzKgjogY=;
	h=Date:From:To:Cc:Subject:From;
	b=e42HrBFje+zQCmbVVJuVJsCnMWxjuwRRuSU1b9KE2FROg3GGbSdB3hgmJCo9glHQ9
	 sXdFLTq1B65jjG4BkJslLIiumNtxHLm7sylwmqiz7de0F4HHQBOTO+Gv2AZKnL6/zk
	 K4kNVaCmGW9qZkVgKjSuf0kdLa/4VX3tSHjUIg5B2Yx3qTkfuuB98yUoHCGlPJPVIi
	 7XXnszqXUUn8900SASdqvIiAoLDCpu3dE3kQshn9AZdmFo3BMn6Wy3KQNONmyil6y8
	 oB2cDR/LdWvHtNT16OcWIsJ9lvU8Z9lHAKQPpVOHLVt/dgYu9HjioEyjyGp2aAMrRU
	 ayxHXLyz23S0w==
Date: Tue, 26 Nov 2024 11:47:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Veronika Molnarova <vmolnaro@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 perf-tools] perf machine: Initialize machine->env to
 address a segfault
Message-ID: <Z0XffUgNSv_9OjOi@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Its used from trace__run(), for the 'perf trace' live mode, i.e. its
strace-like, non-perf.data file processing mode, the most common one.

The trace__run() function will set trace->host using machine__new_host()
that is supposed to give a machine instance representing the running
machine, and since we'll use perf_env__arch_strerrno() to get the right
errno -> string table, we need to use machine->env, so initialize it in
machine__new_host().

Before the patch:

  (gdb) run trace --errno-summary -a sleep 1
  <SNIP>
   Summary of events:

   gvfs-afc-volume (3187), 2 events, 0.0%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     pselect6               1      0     0.000     0.000     0.000     0.000      0.00%

   GUsbEventThread (3519), 2 events, 0.0%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     poll                   1      0     0.000     0.000     0.000     0.000      0.00%
  <SNIP>
  Program received signal SIGSEGV, Segmentation fault.
  0x00000000005caba0 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:478
  478		if (env->arch_strerrno == NULL)
  (gdb) bt
  #0  0x00000000005caba0 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:478
  #1  0x00000000004b75d2 in thread__dump_stats (ttrace=0x14f58f0, trace=0x7fffffffa5b0, fp=0x7ffff6ff74e0 <_IO_2_1_stderr_>) at builtin-trace.c:4673
  #2  0x00000000004b78bf in trace__fprintf_thread (fp=0x7ffff6ff74e0 <_IO_2_1_stderr_>, thread=0x10fa0b0, trace=0x7fffffffa5b0) at builtin-trace.c:4708
  #3  0x00000000004b7ad9 in trace__fprintf_thread_summary (trace=0x7fffffffa5b0, fp=0x7ffff6ff74e0 <_IO_2_1_stderr_>) at builtin-trace.c:4747
  #4  0x00000000004b656e in trace__run (trace=0x7fffffffa5b0, argc=2, argv=0x7fffffffde60) at builtin-trace.c:4456
  #5  0x00000000004ba43e in cmd_trace (argc=2, argv=0x7fffffffde60) at builtin-trace.c:5487
  #6  0x00000000004c0414 in run_builtin (p=0xec3068 <commands+648>, argc=5, argv=0x7fffffffde60) at perf.c:351
  #7  0x00000000004c06bb in handle_internal_command (argc=5, argv=0x7fffffffde60) at perf.c:404
  #8  0x00000000004c0814 in run_argv (argcp=0x7fffffffdc4c, argv=0x7fffffffdc40) at perf.c:448
  #9  0x00000000004c0b5d in main (argc=5, argv=0x7fffffffde60) at perf.c:560
  (gdb)

After:

  root@number:~# perf trace -a --errno-summary sleep 1
  <SNIP>
     pw-data-loop (2685), 1410 events, 16.0%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     epoll_wait           188      0   983.428     0.000     5.231    15.595      8.68%
     ioctl                 94      0     0.811     0.004     0.009     0.016      2.82%
     read                 188      0     0.322     0.001     0.002     0.006      5.15%
     write                141      0     0.280     0.001     0.002     0.018      8.39%
     timerfd_settime       94      0     0.138     0.001     0.001     0.007      6.47%

   gnome-control-c (179406), 1848 events, 20.9%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     poll                 222      0   959.577     0.000     4.322    21.414     11.40%
     recvmsg              150      0     0.539     0.001     0.004     0.013      5.12%
     write                300      0     0.442     0.001     0.001     0.007      3.29%
     read                 150      0     0.183     0.001     0.001     0.009      5.53%
     getpid               102      0     0.101     0.000     0.001     0.008      7.82%

  root@number:~#

Fixes: 54373b5d53c1f6aa ("perf env: Introduce perf_env__arch_strerrno()")
Reported-by: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4f0ac998b0ccfd7a..27d5345d2b307a97 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -134,6 +134,8 @@ struct machine *machine__new_host(void)
 
 		if (machine__create_kernel_maps(machine) < 0)
 			goto out_delete;
+
+		machine->env = &perf_env;
 	}
 
 	return machine;
-- 
2.47.0

