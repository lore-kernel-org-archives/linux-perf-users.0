Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1D337687;
	Wed, 15 Oct 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549742; cv=none; b=restv5afDZ4f+R5dNBMIZL7Cq54CihTs3hDqjqERrOtWS4WEteRGi8Cts1chDEmT5YcfIzBT7b8Vpnh6/5t+Z16StlOiUdL7soAJks+tS6UqGy/Mmbqe8UWktUbGdq+V5eSLnRn5a+aF7fiZkhM35FqTXwMIcPagHizuHNji/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549742; c=relaxed/simple;
	bh=xiWFwAZEHY2QTgVSRRfGKK+7fV849RiNQ1FQt5jsg0g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KVWKY4T+dkDj0ksVNR/OpAWqwyAmV50jnhwrUpymLcGNQZW2tI1vV2U0jYTfmPx43rVLAYuqI77U6JnHLUegQMgxRm8kw0uOrDu3cflqHNnEGgvp5DaSOEOj1B3CtPT63H3vxnBklOmnrWUbFLFTj3YDG+pBptHGTvZuzjMZxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaopE/IF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaopE/IF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9630C113D0;
	Wed, 15 Oct 2025 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760549741;
	bh=xiWFwAZEHY2QTgVSRRfGKK+7fV849RiNQ1FQt5jsg0g=;
	h=Date:From:To:Cc:Subject:References:From;
	b=OaopE/IFnbuawZIb7rAMWcNReEpstDzwgL/+vQ/cFyrnbhY2pDMXHLSFv6XCzMQm6
	 GAc5+0E9Tolzc3eqspzCvMU5u5bcFU3T5SL5eF4htj1NAmbZEsQnMcrpQDSGGPKBrg
	 6OAgQLMs7UEE7f2zM6m8UanWwvb3MnLMyELAnJppIq57jWYo3tdyhl2wz7xXRpmeDa
	 wABzgxxwlwtwXgz+S4hwwpHzAbTbDT1MLJHhLhkk7C8659PtaQL0u3H4udw50yh+0a
	 4jfldp+GksgkizxBbC8mU/sN50XiH7C/cipB3EcWPRGNd759BUuMKx5LP6RqMVmWZX
	 hCaeSvwMlrUqA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v95Pi-0000000121Q-1ZyE;
	Wed, 15 Oct 2025 13:35:50 -0400
Message-ID: <20251015173550.225723717@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 15 Oct 2025 13:32:27 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 13/13] tracing: Have persistent ring buffer print syscalls normally
References: <20251015173214.760495866@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The persistent ring buffer from a previous boot has to be careful printing
events as the print formats of random events can have pointers to strings
and such that are not available.

Ftrace static events (like the function tracer event) are stable and are
printed normally.

System call event formats are also stable. Allow them to be printed
normally as well:

Instead of:

  <...>-1       [005] ...1.    57.240405: sys_enter_waitid: __syscall_nr=0xf7 (247) which=0x1 (1) upid=0x499 (1177) infop=0x7ffd5294d690 (140725988939408) options=0x5 (5) ru=0x0 (0)
  <...>-1       [005] ...1.    57.240433: sys_exit_waitid: __syscall_nr=0xf7 (247) ret=0x0 (0)
  <...>-1       [005] ...1.    57.240437: sys_enter_rt_sigprocmask: __syscall_nr=0xe (14) how=0x2 (2) nset=0x7ffd5294d7c0 (140725988939712) oset=0x0 (0) sigsetsize=0x8 (8)
  <...>-1       [005] ...1.    57.240438: sys_exit_rt_sigprocmask: __syscall_nr=0xe (14) ret=0x0 (0)
  <...>-1       [005] ...1.    57.240442: sys_enter_close: __syscall_nr=0x3 (3) fd=0x4 (4)
  <...>-1       [005] ...1.    57.240463: sys_exit_close: __syscall_nr=0x3 (3) ret=0x0 (0)
  <...>-1       [005] ...1.    57.240485: sys_enter_openat: __syscall_nr=0x101 (257) dfd=0xffffffffffdfff9c (-2097252) filename=(0xffff8b81639ca01c) flags=0x80000 (524288) mode=0x0 (0) __filename_val=/run/systemd/reboot-param
  <...>-1       [005] ...1.    57.240555: sys_exit_openat: __syscall_nr=0x101 (257) ret=0xffffffffffdffffe (-2097154)
  <...>-1       [005] ...1.    57.240571: sys_enter_openat: __syscall_nr=0x101 (257) dfd=0xffffffffffdfff9c (-2097252) filename=(0xffff8b81639ca01c) flags=0x80000 (524288) mode=0x0 (0) __filename_val=/run/systemd/reboot-param
  <...>-1       [005] ...1.    57.240620: sys_exit_openat: __syscall_nr=0x101 (257) ret=0xffffffffffdffffe (-2097154)
  <...>-1       [005] ...1.    57.240629: sys_enter_writev: __syscall_nr=0x14 (20) fd=0x3 (3) vec=0x7ffd5294ce50 (140725988937296) vlen=0x7 (7)
  <...>-1       [005] ...1.    57.242281: sys_exit_writev: __syscall_nr=0x14 (20) ret=0x24 (36)
  <...>-1       [005] ...1.    57.242286: sys_enter_reboot: __syscall_nr=0xa9 (169) magic1=0xfee1dead (4276215469) magic2=0x28121969 (672274793) cmd=0x1234567 (19088743) arg=0x0 (0)

Have:

  <...>-1       [000] ...1.    91.446011: sys_waitid(which: 1, upid: 0x4d2, infop: 0x7ffdccdadfd0, options: 5, ru: 0)
  <...>-1       [000] ...1.    91.446042: sys_waitid -> 0x0
  <...>-1       [000] ...1.    91.446045: sys_rt_sigprocmask(how: 2, nset: 0x7ffdccdae100, oset: 0, sigsetsize: 8)
  <...>-1       [000] ...1.    91.446047: sys_rt_sigprocmask -> 0x0
  <...>-1       [000] ...1.    91.446051: sys_close(fd: 4)
  <...>-1       [000] ...1.    91.446073: sys_close -> 0x0
  <...>-1       [000] ...1.    91.446095: sys_openat(dfd: 18446744073709551516, filename: 139732544945794 "/run/systemd/reboot-param", flags: O_RDONLY|O_CLOEXEC)
  <...>-1       [000] ...1.    91.446165: sys_openat -> 0xfffffffffffffffe
  <...>-1       [000] ...1.    91.446182: sys_openat(dfd: 18446744073709551516, filename: 139732544945794 "/run/systemd/reboot-param", flags: O_RDONLY|O_CLOEXEC)
  <...>-1       [000] ...1.    91.446233: sys_openat -> 0xfffffffffffffffe
  <...>-1       [000] ...1.    91.446242: sys_writev(fd: 3, vec: 0x7ffdccdad790, vlen: 7)
  <...>-1       [000] ...1.    91.447877: sys_writev -> 0x24
  <...>-1       [000] ...1.    91.447883: sys_reboot(magic1: 0xfee1dead, magic2: 0x28121969, cmd: 0x1234567, arg: 0)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2aee9a3088f4..98d8a33d03ff 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -20,6 +20,7 @@
 #include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/irqflags.h>
+#include <linux/syscalls.h>
 #include <linux/debugfs.h>
 #include <linux/tracefs.h>
 #include <linux/pagemap.h>
@@ -4251,10 +4252,13 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
 		 * safe to use if the array has delta offsets
 		 * Force printing via the fields.
 		 */
-		if ((tr->text_delta) &&
-		    event->type > __TRACE_LAST_TYPE)
+		if ((tr->text_delta)) {
+			/* ftrace and system call events are still OK */
+			if ((event->type > __TRACE_LAST_TYPE) &&
+			    (event->funcs != &enter_syscall_print_funcs) &&
+			    (event->funcs != &exit_syscall_print_funcs))
 			return print_event_fields(iter, event);
-
+		}
 		return event->funcs->trace(iter, sym_flags, event);
 	}
 
-- 
2.51.0


