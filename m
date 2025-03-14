Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC72046A5;
	Fri, 14 Mar 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973204; cv=none; b=cBZQB52bmsCb6/KMfALyZeyBoF0VqOdOgx/jKIxnb9Y5tCD3F4eoHXvfi1OtKWoK8BlIV/lBs4t1tySOMblbAAFkp+Sq0s3dj9/uGmvBSrBtNLYnAH1tS687wtlrUYLdquTcboZSj498cWZRplP/0FFy1kEvkHFa395VH7vaPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973204; c=relaxed/simple;
	bh=KkiVUBJqS82/ZAZxfj0qf27tw7VtghnwZimo7bY835Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8+9a4kQxKE1yN1SwNCZWmBdU/fJhJiZ4slBNB+KSCsGl5muFv6mRpcFdVDO0N6GIBbmsri5MLEgbtSaVVL4WLbaER2oYBKHYFLB4O3GVXcnKWsD7B0ehctCWnzQqtt0FA14vYUq168M6Y9Y6m537RoAceeb2onLoxod5HvpLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMsNUN1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMsNUN1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2662C4CEEE;
	Fri, 14 Mar 2025 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741973204;
	bh=KkiVUBJqS82/ZAZxfj0qf27tw7VtghnwZimo7bY835Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMsNUN1xSLDSyBven2d76R+1AdL+jQP0MK50eptkf3aVcdtQKta9NJ8EbEk+isGge
	 MTD2FCEo7J6G1Kjca+jijbQWQKEabwqLxg2MC2HxFJgri2riKxWrj1mpGamjfKEVib
	 zFioHjdgXrG7GkbAE6V7F0J+jQvVe3bGpkNvuPK1KTEGYRgVrUN6MeaP58tj1120zr
	 qjxMja5IyRQDiFIAAARLh7wWOI7UJD9mllNnB1j3m72i66Ch7wPgghldbzlqurr99b
	 KwMCbHnuEKMAWfo9RAu1xBqH5ra02axDg8YAPcFarIjbI/v8UDWiAnpLIjdoxdgxou
	 nT4e2P2pKwefw==
Date: Fri, 14 Mar 2025 14:26:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	guoren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 00/11] perf: Support multiple system call tables in
 the build
Message-ID: <Z9Rm0W6YLpxKIcI1@x1>
References: <20250308003209.234114-1-irogers@google.com>
 <Z9KFLGpenwOP32q3@google.com>
 <Z9M24AJzui9lFbGo@x1>
 <Z9M9-YhDJg3NgiUy@x1>
 <Z9NEX3j_1RUvaFI0@x1>
 <Z9PCjQ8PhOadVGQ8@google.com>
 <Z9RjHpEJGWtj8PAM@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9RjHpEJGWtj8PAM@x1>

On Fri, Mar 14, 2025 at 02:10:57PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Mar 13, 2025 at 10:45:49PM -0700, Namhyung Kim wrote:
> > On Thu, Mar 13, 2025 at 05:47:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Mar 13, 2025 at 05:20:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Still building, but noticed this on x86_64:
> > > > 
> > > > 105: perf trace enum augmentation tests                              : FAILED!
> > > > 106: perf trace BTF general tests                                    : FAILED!
> > > > 107: perf trace exit race                                            : Ok
> > > > 108: perf trace record and replay                                    : FAILED!
> > > > 
> > > > 
> > > > The first doesn´t help that much with verbose mode, haven't checked if
> > > > before this series it was failing :-\
> > > > 
> > > > root@x1:~# perf test -vvv 105
> > > > 105: perf trace enum augmentation tests:
> > > > --- start ---
> > > > test child forked, pid 19411
> > > > Checking if vmlinux exists
> > > > Tracing syscall landlock_add_rule
> > > > ---- end(-1) ----
> > > > 105: perf trace enum augmentation tests                              : FAILED!
> > > > root@x1:~#
> > > 
> > > So:
> > > 
> > > root@x1:~# perf trace -e landlock_add_rule perf test -w landlock
> > > root@x1:~# 
> > > 
> > > But:
> > > 
> > > root@x1:~# perf trace perf test -w landlock |& grep landlock_add_rule
> > >     26.120 ( 0.002 ms): perf/19791 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffde75e2680, flags: 45) = -1 EINVAL (Invalid argument)
> > >     26.124 ( 0.001 ms): perf/19791 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffde75e2690, flags: 45) = -1 EINVAL (Invalid argument)
> > > root@x1:~# 
> > > 
> > > -e is having some trouble, when no event is specified, then it works.
> > > 
> > > Something in the changes made to:
> > > 
> > > static int trace__parse_events_option(const struct option *opt, const char *str,
> > >                                       int unset __maybe_unused)
> > 
> > Thanks for the test, I think this should fix it:
> > 
> 
> Well, not really:
> 
> root@number:~# perf trace -e landlock_add_rule perf test -w landlock
> perf: Segmentation fault
> Obtained 10 stack frames.
> perf() [0x5be761]
> perf() [0x5be7f9]
> /lib64/libc.so.6(+0x40fd0) [0x7fe005c4efd0]
> perf() [0x491bc1]
> perf() [0x497090]
> perf() [0x4973ab]
> perf() [0x413483]
> /lib64/libc.so.6(+0x2a088) [0x7fe005c38088]
> /lib64/libc.so.6(__libc_start_main+0x8b) [0x7fe005c3814b]
> perf() [0x413ad5]
> Segmentation fault (core dumped)
> root@number:~#
> 
> Time for me to test another patch from Ian, the one symbolizing the
> above backtrace...
> 
> Worked, but didn't help as much, with gdb:
> 
> (gdb) run trace -e landlock_add_rule perf test -w landlock
> Starting program: /root/bin/perf trace -e landlock_add_rule perf test -w landlock
> 
> This GDB supports auto-downloading debuginfo from the following URLs:
>   <https://debuginfod.fedoraproject.org/>
> Enable debuginfod for this session? (y or [n]) y
> Debuginfod has been enabled.
> To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
> Downloading 53.88 K separate debug info for system-supplied DSO at 0x7ffff7fc6000
> Downloading 458.26 K separate debug info for /lib64/libtracefs.so.1                                                                                                                            
> [Thread debugging using libthread_db enabled]                                                                                                                                                  
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [Detaching after fork from child process 39141]
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000000004d0e56 in trace__find_usable_bpf_prog_entry (trace=0x7fffffffa510, sc=0x10fb7b0) at builtin-trace.c:3882
> 3882				bool is_pointer = field->flags & TEP_FIELD_IS_POINTER,
> (gdb) p field
> $1 = (struct tep_format_field *) 0x64656e6769736e75
> (gdb) bt
> #0  0x00000000004d0e56 in trace__find_usable_bpf_prog_entry (trace=0x7fffffffa510, sc=0x10fb7b0) at builtin-trace.c:3882
> #1  0x00000000004cf3de in trace__init_syscalls_bpf_prog_array_maps (trace=0x7fffffffa510, e_machine=62) at builtin-trace.c:4040
> #2  0x00000000004bf626 in trace__run (trace=0x7fffffffa510, argc=4, argv=0x7fffffffde40) at builtin-trace.c:4473
> #3  0x00000000004bb7a9 in cmd_trace (argc=4, argv=0x7fffffffde40) at builtin-trace.c:5741
> #4  0x00000000004d873f in run_builtin (p=0xf83d48 <commands+648>, argc=7, argv=0x7fffffffde40) at perf.c:351
> #5  0x00000000004d7df3 in handle_internal_command (argc=7, argv=0x7fffffffde40) at perf.c:404
> #6  0x00000000004d860f in run_argv (argcp=0x7fffffffdc7c, argv=0x7fffffffdc70) at perf.c:448
> #7  0x00000000004d7a4f in main (argc=7, argv=0x7fffffffde40) at perf.c:556
> (gdb) list -10
> 3867		return NULL;
> 3868	
> 3869	try_to_find_pair:
> 3870		for (int i = 0, num_idx = syscalltbl__num_idx(sc->e_machine); i < num_idx; ++i) {
> 3871			int id = syscalltbl__id_at_idx(sc->e_machine, i);
> 3872			struct syscall *pair = trace__syscall_info(trace, NULL, sc->e_machine, id);
> 3873			struct bpf_program *pair_prog;
> 3874			bool is_candidate = false;
> 3875	
> 3876			if (pair == NULL || pair == sc ||
> (gdb)

Humm

(gdb) p i
$1 = 147
(gdb) p num_idx
$2 = 379
(gdb) p id
$3 = 192
(gdb) p pair
$4 = (struct syscall *) 0x10fe8f0
(gdb) p *pair
$5 = {e_machine = 62, id = 192, tp_format = 0x10f6c00, nr_args = 3, args_size = 48, bpf_prog = {sys_enter = 0x0, sys_exit = 0x0}, is_exit = false, is_open = false, nonexistent = false, 
  use_btf = false, args = 0x10f9480, name = 0x814406 "lgetxattr", fmt = 0x0, arg_fmt = 0x10fa0a0}
(gdb) p sc
$6 = (struct syscall *) 0x10fb7b0
(gdb) p sc->args
$7 = (struct tep_format_field *) 0x64656e6769736e75
(gdb) p *pair
$8 = {e_machine = 62, id = 192, tp_format = 0x10f6c00, nr_args = 3, args_size = 48, bpf_prog = {sys_enter = 0x0, sys_exit = 0x0}, is_exit = false, is_open = false, nonexistent = false, 
  use_btf = false, args = 0x10f9480, name = 0x814406 "lgetxattr", fmt = 0x0, arg_fmt = 0x10fa0a0}
(gdb)

it finds the pair, but then its sc->args has a bogus pointer... I'll see
where this isn't being initialized...

- Arnaldo
