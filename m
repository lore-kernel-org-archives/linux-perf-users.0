Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F96221DAD;
	Wed, 15 Oct 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549740; cv=none; b=eXBw3QZDQI9Lpo+NB7tpBSPLHFT9r+sq+TomqxWmNuYygnS6of9QZUJgEYjiagF5o7MGCAh8fZpujFudMvqw5tX+oTejYjvrBK71FPM2f0GEuKTpVnz6MVabOKsvs2tZopZbSva1oEMu8xzO4ulYS99JAD35JY6yJX2L1Yl1cPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549740; c=relaxed/simple;
	bh=qfx41YB9T3o7PD3L98qTAStSf6+JXp7lI57F7Kpmibg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=r5dl+giZYu1noWHCeqFZ/iRoym30Z43U0cy4ePZQ5WpD/Lbl5wwzE9mHAp+fO53h599Cq/CFb0RUGpsXY3PdeQOQg6I2BJDB2L3Zg76FmkltniaOAZY9HN1bbzjf8L2qP0eYGojccbKqZAo5R5mjTSg5fFsfkHnLK+TGJ6/CUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhn9g1gL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhn9g1gL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC066C4CEFB;
	Wed, 15 Oct 2025 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760549740;
	bh=qfx41YB9T3o7PD3L98qTAStSf6+JXp7lI57F7Kpmibg=;
	h=Date:From:To:Cc:Subject:From;
	b=Hhn9g1gLXr9IeqSAtLbuBAeMEBeMTudsICeSbizLOQQuGMvib/fUiZ1EOEpFx4aOp
	 AITgxED3uw76yIXZxGateMQHfDElWj9dSod1uONDJEExN1Oc+rJJ6MzKWEx3+FWUDS
	 vRtCKuU3eWLH2OZyePhZz7Twrm8esI9Xg4JOxicKo3U+hbrrYc8s0M2jL7vr8IZBZB
	 9yO29WL0I1xDMs9N1+3VT3nT1iMDymWa950rP4chTquxZzA7SNW6is69mhLmuzWPsC
	 XHBy6bqdCdmNIosTDq64o2mUhJqJ5Zk1iq+gB+8CTasjg1y+UaeSYxoqB5KUDZWpj+
	 thkqrdofl6SSw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v95Pg-000000011uz-0lVY;
	Wed, 15 Oct 2025 13:35:48 -0400
Message-ID: <20251015173214.760495866@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 15 Oct 2025 13:32:14 -0400
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
Subject: [PATCH v3 00/13] tracing: Show contents of syscall trace event user space fields
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

Changes since v2: https://lore.kernel.org/linux-trace-kernel/20250923130457.901085554@kernel.org

- Now that trace_marker uses the per CPU read method for reading user
  space, make that code generic so that the system call logic can
  use it as well.

- Update perf system calls to read user space as well.

- Make openat() show what the flags are. Instead of a number, use the
  actual flag names.

- Show printable characters in the data dumps (like the write system call).

- Allow persistent ring buffer to parse system calls appropriately.

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
 kernel/trace/trace.c           | 312 ++++++++++++---
 kernel/trace/trace.h           |  20 +
 kernel/trace/trace_output.c    |  27 +-
 kernel/trace/trace_syscalls.c  | 886 ++++++++++++++++++++++++++++++++++++++---
 9 files changed, 1188 insertions(+), 117 deletions(-)
