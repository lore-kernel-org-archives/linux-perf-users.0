Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6CA1FC0EA;
	Tue, 21 Oct 2025 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007932; cv=none; b=mFfIkIDkfbC9+ixix4nnLKyF8+XlMd0S2+cmLSA7KaL3AtX8nVPN8Xsltau3R3Rxph2pPVMNxJAzkwreN2DSR5sgIl0A+nJ4fkc0/iPab/cZq40/37J2gVLvoHSUOarFNE6s2bDjtmYmdzNsYEeJEo4QK5jo3/7SSBgSclrHgXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007932; c=relaxed/simple;
	bh=e5asY7baWe5PVxV32+BYLvVjBFohkNDQL6ZMD0InnS8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ak85F41f7aBMHzdjffKvKw8DfqVbpuxMhaRuEPmti2jAWcD7uCriOEdcZntXDdXN3M/wuk6EUf7PyN7IRhKWVzew2d1Emlofb1d5GH3jZNVgN0q3kipAhK1nTUO34JACys048LXCiAFXKupyja8hneOBJkNXxecvxj+UDYC0YnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my9dcMmQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my9dcMmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71EFC113D0;
	Tue, 21 Oct 2025 00:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007931;
	bh=e5asY7baWe5PVxV32+BYLvVjBFohkNDQL6ZMD0InnS8=;
	h=Date:From:To:Cc:Subject:From;
	b=my9dcMmQyH42P/oIHBmdDtsHrq8DcV0a/K3pcsWC029gJuKT+lWnCtls4XMfOtERX
	 UUdBhOmqXMLvUtnIR4L8lF1QeLjiXPkKj4pgbYIV6St9QVlaF2gBSMgE96AsM4Bw4O
	 Eg/xZCe4vxK38oBeRYs2Y8aS37ssN9GZN7IIgJHDNbUqsYRX2bomheJOPXf93Hr8XF
	 CCX3C3litLUhewntakKVQYOunJqkULKX0jbEHNht6anKYkPaad9P/e5GhBiOZ04+SW
	 T57z6Rvcf/I2hRbQ8mdyR1Zq2Wj2zvRdUfHCbw1xRM4d9qFm2RYga8xla6j5b2RJS/
	 4jNP5iMUyhFVA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vB0c4-0000000204u-1hA7;
	Mon, 20 Oct 2025 20:52:32 -0400
Message-ID: <20251021005155.705735078@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 20 Oct 2025 20:51:55 -0400
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
Subject: [PATCH v4 00/13] tracing: Show contents of syscall trace event user space fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

As of commit 654ced4a1377 ("tracing: Introduce tracepoint_is_faultable()")
system call trace events allow faulting in user space memory. Have some of
the system call trace events take advantage of this.

Also, commit 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to
read user space") added the method to use per CPU buffers to read data from
user space in critical sections. Instead of recreating that code, make that
code generic so that the system calls can utilize it as well.

Update the system call trace events to read user space for various system
calls (like openat, execve, etc).

A new file is created in the tracefs directory (and also per instance) that
allows the user to shorten the amount copied from user space. It can be
completely disabled if set to zero (it will only display "" or (, ...)
but no copying from user space will be performed). The max size to copy is
hard coded to 165, which should be enough for this purpose. The default
size is 63 bytes.

This allows the output to look like this:

 sys_access(filename: 0x7f8c55368470 "/etc/ld.so.preload", mode: 4)
 sys_execve(filename: 0x564ebcf5a6b8 "/usr/bin/emacs", argv: 0x7fff357c0300, envp: 0x564ebc4a4820)
 sys_write(fd: 1, buf: 0x56430f353be0 (2f:72:6f:6f:74:0a) "/root.", count: 6)
 sys_sethostname(name: 0x5584310eb2a0 "debian", len: 6)
 sys_renameat2(olddfd: 0xffffff9c, oldname: 0x7ffe02facdff "/tmp/x", newdfd: 0xffffff9c, newname: 0x7ffe02face06 "/tmp/y", flags: 1)

Perf system call logic is also updated to take advantage of this work.

The openat system call was updated to show the flags as well:

  sys_openat(dfd: 18446744073709551516, filename: 140733603151330 "/tmp/x", flags: O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, mode: 0666)

Changes since v3: https://lore.kernel.org/linux-trace-kernel/20251015173214.760495866@kernel.org/

    - Fixed return value of perf_sysenter_enable() and perf_sysexit_enable()
      to not return undefined value (kernel test robot)

    - Fix use of ret in perf_sysenter_enable. (kernel test robot)

    - Fixed up the code to determine if it's a syscall event or not
      when CONFIG_FTRACE_SYSCALLS is not defined (kernel test robot)


Steven Rostedt (13):
      tracing: Make trace_user_fault_read() exposed to rest of tracing
      tracing: Have syscall trace events read user space string
      perf: tracing: Simplify perf_sysenter_enable/disable() with guards
      perf: tracing: Have perf system calls read user space
      tracing: Have system call events record user array data
      tracing: Display some syscall arrays as strings
      tracing: Allow syscall trace events to read more than one user parameter
      tracing: Add a config and syscall_user_buf_size file to limit amount written
      tracing: Show printable characters in syscall arrays
      tracing: Add trace_seq_pop() and seq_buf_pop()
      tracing: Add parsing of flags to the sys_enter_openat trace event
      tracing: Check for printable characters when printing field dyn strings
      tracing: Have persistent ring buffer print syscalls normally

----
 Documentation/trace/ftrace.rst |   8 +
 include/linux/seq_buf.h        |  17 +
 include/linux/trace_seq.h      |  13 +
 include/trace/syscall.h        |   8 +-
 kernel/trace/Kconfig           |  14 +
 kernel/trace/trace.c           | 327 ++++++++++++---
 kernel/trace/trace.h           |  20 +
 kernel/trace/trace_output.c    |  27 +-
 kernel/trace/trace_syscalls.c  | 889 ++++++++++++++++++++++++++++++++++++++---
 9 files changed, 1204 insertions(+), 119 deletions(-)
