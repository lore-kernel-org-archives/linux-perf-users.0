Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C022E64A;
	Thu, 14 Nov 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607026; cv=none; b=V66rL1A6bKBqDO9C1VlWGRyyJPRFOXe1igg1lVoFLfCkm+sU4HNwhH/lnrJAB2lRc9f4nuj08M8+uVlNRqHFFprSAzI66fsed5AP7uUlqoXWK1RMSWJjgVjohtaIVCsTMG9a5/2x2TH2y/AeFB6gKrschljyv/kilyknP3B13ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607026; c=relaxed/simple;
	bh=sVAV1WUFBQUvV6qnzb1SsvFG/Zw9vowxBGsBBChgEsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIBVFnEsmFk88Fdvou3QLlGcy/Zy1jE/eO15xd9uEiwoKEwZVUWkVRwfVQ04SGf1SmV4h5YXPQyj0tiPbXqt5vRst3z5oIJ83536oIYWb3ZnNHR6LALm3BsEcklVt0QKjUxHt8D8cKDDbyonehOdRz1d/eO4yuTCguVySCNZARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFkU2QCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFkU2QCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC1EC4CECD;
	Thu, 14 Nov 2024 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731607025;
	bh=sVAV1WUFBQUvV6qnzb1SsvFG/Zw9vowxBGsBBChgEsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFkU2QCUUtTErZlXihmA+u1S31hRPQS9DkRwAdV+S7wITRybN2cw19uUGnfy2ovaw
	 11d06sdoi2C6A4aqWWZCOa71qAul1YL7afGa8+l4HKH9XREqf7p5dGK7c7HejhOeXM
	 h3YJKf3mHY7++ExAi9L6nSP5xzwLCUdiUBkjIsD20kn1DnYlqUiplIBLtOxGhlir5E
	 L/vElX1l4PHESGMOuLlh6QqyvDJeehR0xZn4TjNKQIxpuMYNIdwa4TPNTtzNGUwFf3
	 em/1zD6y+8wB5uKQuP1mA/tKeeYy9/QC+tg9AzDlClNe+bfUFPojHRtThhLpL3Xx5/
	 Sf/NiwTGWJDZg==
Date: Thu, 14 Nov 2024 14:57:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com,
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf trace: Fix perf trace tracing itself, creating
 feedback loops
Message-ID: <ZzY57jorg1wScxq5@x1>
References: <20241030052431.2220130-1-howardchu95@gmail.com>
 <ZzOLU-9QkwGHsb3w@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzOLU-9QkwGHsb3w@x1>

On Tue, Nov 12, 2024 at 02:07:36PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 29, 2024 at 10:24:31PM -0700, Howard Chu wrote:
> > There exists a pids_filtered map in augmented_raw_syscalls.bpf.c that
> > ceases to provide functionality after the BPF skeleton migration:
> > commit 5e6da6be3082 ("perf trace: Migrate BPF augmentation to use a skeleton")
> 
> Thanks, applied to perf-tools-next,

There is a problem with this patch, I'm investigating it now:

root@number:~# perf trace -e syscalls:sys_enter_exit_group true
perf: Segmentation fault
Obtained 12 stack frames.
perf() [0x6229a1]
perf() [0x622a8b]
/lib64/libc.so.6(+0x40d00) [0x7f704364fd00]
perf() [0x4b5f2e]
perf() [0x4ba3e6]
perf() [0x4c03bc]
perf() [0x4c0663]
perf() [0x4c07bc]
perf() [0x4c0b05]
/lib64/libc.so.6(+0x2a088) [0x7f7043639088]
/lib64/libc.so.6(__libc_start_main+0x8b) [0x7f704363914b]
perf() [0x412265]
Segmentation fault (core dumped)
root@number:~#

(gdb) run trace -e syscalls:sys_enter_exit_group true
Starting program: /root/bin/perf trace -e syscalls:sys_enter_exit_group true

This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.fedoraproject.org/>
Enable debuginfod for this session? (y or [n]) y
Debuginfod has been enabled.
To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 1965197]

Program received signal SIGSEGV, Segmentation fault.
trace__run (trace=0x7fffffffa5e0, argc=1, argv=0x7fffffffde90) at builtin-trace.c:4330
4330		trace->filter_pids.map = trace->skel->maps.pids_filtered;
(gdb) bt
#0  trace__run (trace=0x7fffffffa5e0, argc=1, argv=0x7fffffffde90) at builtin-trace.c:4330
#1  0x00000000004ba3e6 in cmd_trace (argc=1, argv=0x7fffffffde90) at builtin-trace.c:5490
#2  0x00000000004c03bc in run_builtin (p=0xec4068 <commands+648>, argc=4, argv=0x7fffffffde90) at perf.c:351
#3  0x00000000004c0663 in handle_internal_command (argc=4, argv=0x7fffffffde90) at perf.c:404
#4  0x00000000004c07bc in run_argv (argcp=0x7fffffffdc7c, argv=0x7fffffffdc70) at perf.c:448
#5  0x00000000004c0b05 in main (argc=4, argv=0x7fffffffde90) at perf.c:560
(gdb) p trace->skel
$1 = (struct augmented_raw_syscalls_bpf *) 0x0
(gdb)

I.e. when we specify a syscall event tracepoint, we expect to use
augmentation, but are not setting it up.

So this is seems to be exposing a previous bug, I'll check.

- Arnaldo
