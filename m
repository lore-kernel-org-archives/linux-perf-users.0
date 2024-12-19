Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E77E575;
	Thu, 19 Dec 2024 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586658; cv=none; b=kb1UnBotq9mvuejmERxWBCUZAHw3mbHzc1731I1UEEFe/kR7DE1y0tYK7kz2lA8t3hx9bu2vlvrt5bJUnMa2rMMjIwmLsajtLdcc8bGw/rhWRcdmy2Tmd8tHRRHjEi5gygnkDK811Tlu3jtcIgOlILdxqMiXfkzvdpw+FBGscWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586658; c=relaxed/simple;
	bh=szH9WIfyZo30g7jGSysf+vDEiCJncoeqY5iBBOk1tls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVJXsJPfrpQnX5wiR9GN4J3tL1ry+A+fjVQ1Ejnhu497S3otUo9hlQcNJzovOgEU4Ehssw9OkBLRExqvi6b37ZqIXDVqUEl01ZN64JjRKQGCT72QUs7rNlSpJCXHdjYUM0EpLdNPylA/YO9RIcfQu/o20LTQuOpT4p7E2wAmW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNE+0PM9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNE+0PM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89E4C4CED7;
	Thu, 19 Dec 2024 05:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734586658;
	bh=szH9WIfyZo30g7jGSysf+vDEiCJncoeqY5iBBOk1tls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNE+0PM9behPV7XhLgLPwnKVJqrZrkPIpuJQKAeycQmw9SGN5siOyHZc67bkGiPMo
	 vEZDNnW1rcgLoigcTQJTdUhf4eux0mPV2Rke00ZAi+bU4D/vV8WP2sKG/PFQSJ42Cg
	 63oGCQtQRimZUHHwzTKUylWqSwJOywY1pAey5LG5YJmtN6pyHY+NZcIQSmDKhwu0AG
	 00Bb+1I3C9RKlVqEQkKP9U0+ty/3KNM+0p/61iMrCinOdakou3pJ5FUvmag0wt2KRF
	 lzFrYMMus1TX902RDI6Jlo08tpKz/2BMCVRHyySTQGpX9kZxGS22j/7zVHpkVl8sgh
	 dRTFpoI+xZ1dw==
Date: Wed, 18 Dec 2024 21:37:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC/PATCH] perf trace: Add --syscall-period option
Message-ID: <Z2OxIBW0t4kLBAFW@google.com>
References: <20241211222110.2430610-1-namhyung@kernel.org>
 <CAH0uvog3XkndPWvifVjhrV1GoM4O462e_3Xxr_=r9yCWhnKGmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvog3XkndPWvifVjhrV1GoM4O462e_3Xxr_=r9yCWhnKGmg@mail.gmail.com>

On Tue, Dec 17, 2024 at 09:40:21PM -0800, Howard Chu wrote:
> Hello Namhyung,
> 
> Thanks for the patch.
> 
> On Wed, Dec 11, 2024 at 2:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > This option is to implement the event sampling for system calls.
> > The period is given in msec as it shows the time in msec.
> >
> >   # perf trace -C 0 --syscall-period 100 sleep 1
> >            ? (         ): fleetspeakd/1828559  ... [continued]: futex())                                            = -1 ETIMEDOUT (Connection timed out)
> >        0.050 (100.247 ms): gnome-shell/572531 recvmsg(fd: 10<socket:[3355761]>, msg: 0x7ffef8b39d20)                = 40
> >      100.357 (100.149 ms): pipewire-pulse/572245 read(fd: 5<anon_inode:[eventfd]>, buf: 0x7ffc0b9dc8f0, count: 8)      = 8
> >      200.553 (100.268 ms): NetworkManager/3424 epoll_wait(epfd: 19<anon_inode:[eventpoll]>, events: 0x5607b85bb880, maxevents: 6) = 0
> >      300.876 (         ): mon/4932 poll(ufds: 0x7fa392784df0, nfds: 1, timeout_msecs: 100)            ...
> >      400.901 ( 0.025 ms): TaskCon~ller #/620145 futex(uaddr: 0x7f3fc596fa00, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> >      300.876 (100.123 ms): mon/4932  ... [continued]: poll())                                             = 0 (Timeout)
> >      500.901 ( 0.012 ms): evdefer/2/2335122 futex(uaddr: 0x5640baac5198, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> >      602.701 ( 0.017 ms): Compositor/1992200 futex(uaddr: 0x7f1a51dfdd40, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> >      705.589 ( 0.017 ms): JS Watchdog/947933 futex(uaddr: 0x7f4cac1d4240, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> >      812.667 ( 0.027 ms): fix/1985151 futex(uaddr: 0xc0008f7148, op: WAKE|PRIVATE_FLAG, val: 1)             = 1
> >      912.807 ( 0.017 ms): Xorg/572315 setitimer(value: 0x7ffc375d6ba0)                                      = 0
> >
> > The timestamp is kept in a per-cpu array and the allowed task is saved
> > in a hash map.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-trace.txt       |  6 ++
> >  tools/perf/builtin-trace.c                    |  5 ++
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 67 ++++++++++++++++++-
> >  3 files changed, 76 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> > index 6e0cc50bbc13fc7f..9f338a8c5357a67e 100644
> > --- a/tools/perf/Documentation/perf-trace.txt
> > +++ b/tools/perf/Documentation/perf-trace.txt
> > @@ -241,6 +241,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
> >         printing using the existing 'perf trace' syscall arg beautifiers to map integer
> >         arguments to strings (pid to comm, syscall id to syscall name, etc).
> >
> > +--syscall-period::
> > +       Trace a system call in the given period (in msec).  This implements
> > +       sampling for syscalls in order to reduce the monitoring overhead.
> > +       For example, setting the sysall period to 100 (msec) means it will
> > +       sample a syscall and next one after 100 msec.
> > +
> >
> >  PAGEFAULTS
> >  ----------
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 3c46de1a8d79bfe6..789eb0ffd5f90b61 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -185,6 +185,7 @@ struct trace {
> >         } stats;
> >         unsigned int            max_stack;
> >         unsigned int            min_stack;
> > +       unsigned long           sample_period_ms;
> >         int                     raw_augmented_syscalls_args_size;
> >         bool                    raw_augmented_syscalls;
> >         bool                    fd_path_disabled;
> > @@ -5219,6 +5220,7 @@ int cmd_trace(int argc, const char **argv)
> >                      "start"),
> >         OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
> >                        "to customized ones"),
> > +       OPT_ULONG(0, "syscall-period", &trace.sample_period_ms, "syscall sampling period in ms"),
> >         OPTS_EVSWITCH(&trace.evswitch),
> >         OPT_END()
> >         };
> > @@ -5326,6 +5328,9 @@ int cmd_trace(int argc, const char **argv)
> >                                 bpf_program__set_autoattach(prog, /*autoattach=*/false);
> >                 }
> >
> > +               if (trace.sample_period_ms)
> > +                       trace.skel->rodata->sample_period = trace.sample_period_ms * NSEC_PER_MSEC;
> > +
> >                 err = augmented_raw_syscalls_bpf__load(trace.skel);
> >
> >                 if (err < 0) {
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 4a62ed593e84edf8..12272620dcd73700 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -113,6 +113,22 @@ struct pids_filtered {
> >         __uint(max_entries, 64);
> >  } pids_filtered SEC(".maps");
> >
> > +struct sample_timestamp {
> > +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > +       __type(key, int);
> > +       __type(value, __u64);
> > +       __uint(max_entries, 1);
> > +} sample_timestamp SEC(".maps");
> > +
> > +struct sample_filtered {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __type(key, pid_t);
> > +       __type(value, bool);
> > +       __uint(max_entries, MAX_CPUS);
> > +} sample_filtered SEC(".maps");
> 
> Do you think MAX_CPUS provides enough entries? If there are MAX_CPUS
> syscalls that have entered but haven't exited, new syscalls cannot
> write to the map, which results in the new syscall's sys_exit not
> being collected. This can lead to trace logs like the following:
> 
> 210.947 (         ): tmux: server/4399 poll(ufds: 0x579c819eac40,
> nfds: 51, timeout_msecs: 9)
> 
> which doesn't have a duration, because perf trace doesn't know when it
> exits. For example, a poll system call can take a long time to exit,
> if there are MAX_CPUS number of polls, they will occupy all the space
> in the sample_filtered map.
> 
> > +       if (prev_ts) {
> > +               if ((*prev_ts + sample_period) > timestamp)
> > +                       return false;
> > +               *prev_ts = timestamp;
> > +       } else {
> > +               bpf_map_update_elem(&sample_timestamp, &idx, &timestamp, BPF_ANY);
> > +       }
> > +
> > +       bpf_map_update_elem(&sample_filtered, &pid, &ok, BPF_ANY);
> 
> and during polling, when a new syscall enters, this
> bpf_map_update_elem() will return an error and fail to insert, and in
> sys_exit(), this:
> 
> > +       if (!bpf_map_lookup_elem(&sample_filtered, &pid))
> > +               return false;
> 
> returns false, and creates a sample with no duration.
> 
> In order to eliminate samples with no duration, there should be no
> more than MAX_CPUS simultaneous syscalls, but I haven't yet created a
> scenario where there are MAX_CPUS polls at the same time. (such
> creation needs some tricks, because --syscall-period=1 allows maximum
> <number-of-cpus> number of syscalls every millisecond)
> 
> That said, I agree that MAX_CPUS (4096) is generally sufficient for
> the sample_filtered map in most situations.

Right, usually the number of CPUs is far less than that, but I remember
there's a system with more than 2K CPUs.  I can add a command line
option to control the number of entries or change the default using the
actual number of CPUs in the system.

> 
> Aside from this edge case, this patch looks good to me, I tested it with:
> 
> perf trace --syscall-period=500
> 
>    544.863 ( 0.008 ms): sshd/869528 rt_sigprocmask(how: UNBLOCK, nset:
> 0x7fffef5f71f0, oset: 0x7fffef5f7270, sigsetsize: 8) = 0
>    545.034 ( 0.007 ms): tmux: server/4399 ioctl(fd: 54</dev/ptmx>,
> cmd: FIONREAD, arg: 0x7ffe020ec758)          = 0
>    593.054 (100.214 ms): gnome-shell/2419 poll(ufds: 0x6236d31eb850,
> nfds: 15, timeout_msecs: 100)              = 0 (Timeout)
>   1073.251 ( 0.059 ms): gmain/38955 inotify_add_watch(fd:
> 4<anon_inode:inotify>, pathname:
> "/var/lib/fwupd/metadata/lvfs-testing", mask: 16789454) = -1 ENOENT
> (No such file or directory)
>   1073.641 ( 0.014 ms): tmux: server/4399 ioctl(fd: 54</dev/ptmx>,
> cmd: FIONREAD, arg: 0x7ffe020ec758)          = 0
>   1074.588 ( 0.013 ms): sshd/869528 rt_sigprocmask(how: UNBLOCK, nset:
> 0x7fffef5f71f0, oset: 0x7fffef5f7270, sigsetsize: 8) = 0
>   1094.651 (100.370 ms): gnome-shell/2419 poll(ufds: 0x6236d31eb850,
> nfds: 15, timeout_msecs: 100)              = 0 (Timeout)
>   1596.817 (100.363 ms): gnome-shell/2419 poll(ufds: 0x6236d31eb850,
> nfds: 15, timeout_msecs: 100)
> 
> The timestamp makes sense for the 500 ms period.

Thanks for the review and test!
Namhyung

