Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC911BF3F;
	Sat,  4 May 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714845886; cv=none; b=oVKjkTOLvwaZ3Le0wFcpvAEGHagt+zUqrlHFDlENKf76Dwp+vxG3Xj/YQdn5kJV9m9P9ikrqfinYZ8l+C6f9ti8HVVS1AvsPftRF01CcgLCcY0DGe2hC7IMWR34XSDyKVECDsgSAXwavrygMp6bC4iGMe2OSdFGi41ONEboDpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714845886; c=relaxed/simple;
	bh=+wyVW1UwYsK6Li/Fvim5+zqgGIr55z3YDX9h+nt3OM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY0f/Dyzj/UzlqxdKZ6NOylqINZKcom1ok3qSXc2+53Ma51eJezoT4hrsMuxZH2OUc8yeL1B4A0BtYG7TZ3pSZXyNKAKgYYgK7xSgdyEfzaZvQ80+fwPi6G2AmByzWekJsvjsrY8ylfuxXjn7CBsR3RYzlfdzrVORmGxyxbOiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihkPoQ16; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihkPoQ16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9712AC072AA;
	Sat,  4 May 2024 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714845886;
	bh=+wyVW1UwYsK6Li/Fvim5+zqgGIr55z3YDX9h+nt3OM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihkPoQ1617Me500B5H4SIVvRBXEDTeNbrQJ6KQwuczx5q5l7R99FLxE6nJnUGShQT
	 Ba65lNUeP985i3xi8t2BdEI3aB7IJ+q4bXQuShlktXY78+2n3pQ8Ixx1c1IBYAh3Em
	 S8tYhGavdjoN55An4T/a7Yw94OpOebK+9/cuL7s6cIFM6byuXtCQfLXm90u3cmx06n
	 H4U0He3+o6HzXwLleOyZoyW7LAHV9V+LYzQI6ZO4uDgs+W0GogvPY+hwku7ynY8tLq
	 Mz6jzkV+sHzzUfw921LBM50p+E8jZieXL9dX1gOxgg5vs/qs0Qs5jQfWiKOrOTSQaK
	 jW34U4w6x4Gjw==
Date: Sat, 4 May 2024 15:04:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Disable syscall augmentation with record
Message-ID: <ZjZ4u3EG1uhTHcCK@x1>
References: <20240216172357.65037-1-irogers@google.com>
 <Zc-dYrNMt3Wsinax@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc-dYrNMt3Wsinax@x1>

On Fri, Feb 16, 2024 at 02:37:38PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Feb 16, 2024 at 09:23:57AM -0800, Ian Rogers wrote:
> > Syscall augmentation is causing samples not to be written to the
> > perf.data file with "perf trace record". Disabling augmentation is
> > sub-optimal, but it beats having a totally broken perf trace record.
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

I thought Namhyung had collected this one, doing it now.

- Arnaldo
 
> 'perf trace record' needs to be more tested, we need to have a shell
> 'perf test' for it, maybe Michael has something on his test suite?
> 
> Testing your patch:
> 
> root@number:~# perf trace record ls
> anaconda-ks.cfg  bin  perf.all-number-20231219-104854.tar.bz2  perfconfig.off  perf.data  perf.data.baseline  perf.data.old
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.050 MB perf.data (170 samples) ]
> root@number:~# perf evlist -v
> raw_syscalls:sys_enter: type: 2 (PERF_TYPE_TRACEPOINT), size: 136, config: 0x168 (raw_syscalls:sys_enter), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> raw_syscalls:sys_exit: type: 2 (PERF_TYPE_TRACEPOINT), size: 136, config: 0x167 (raw_syscalls:sys_exit), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> dummy:u: type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
> root@number:~# perf script | head -5
>               ls  145954 [021] 64113.916047:  raw_syscalls:sys_exit: NR 59 = 0
>               ls  145954 [021] 64113.916065: raw_syscalls:sys_enter: NR 12 (0, 528, 0, 0, 0, 27)
>               ls  145954 [021] 64113.916065:  raw_syscalls:sys_exit: NR 12 = 94098335809536
>               ls  145954 [021] 64113.916077: raw_syscalls:sys_enter: NR 158 (3001, 7fff9bc13790, 7f4bd6f4b4c0, 1, 3, 800)
>               ls  145954 [021] 64113.916078:  raw_syscalls:sys_exit: NR 158 = -22
> root@number:~# perf trace -i perf.data |& head 
>          ? (         ): ls/145954  ... [continued]: execve())                                           = 0
>      0.018 ( 0.000 ms): ls/145954 brk()                                                                 = 0x5594f9e14000
>      0.030 ( 0.000 ms): ls/145954 arch_prctl(option: 0x3001, arg2: 0x7fff9bc13790)                      = -1 EINVAL (Invalid argument)
>      0.045 ( 0.002 ms): ls/145954 access(filename: 0xd6f5b2c0, mode: R)                                 = -1 ENOENT (No such file or directory)
>      0.050 ( 0.003 ms): ls/145954 openat(dfd: CWD, filename: 0xd6f5a144, flags: RDONLY|CLOEXEC)         = 3
>      0.053 ( 0.001 ms): ls/145954 newfstatat(dfd: 3, filename: 0xd6f5ace8, statbuf: 0x7fff9bc129a0, flag: 4096) = 0
>      0.055 ( 0.004 ms): ls/145954 mmap(len: 78087, prot: READ, flags: PRIVATE, fd: 3)                   = 0x7f4bd6f1c000
>      0.059 ( 0.000 ms): ls/145954 close(fd: 3)                                                          = 0
>      0.066 ( 0.003 ms): ls/145954 openat(dfd: CWD, filename: 0xd6f65fa0, flags: RDONLY|CLOEXEC)         = 3
>      0.068 ( 0.001 ms): ls/145954 read(fd: 3, buf: 0x7fff9bc12b08, count: 832)                          = 832
> root@number:~#
> 
> root@number:~# perf trace -v record ls
> Syscall augmentation fails with record, disabling augmentationUsing CPUID GenuineIntel-6-B7-1
> DEBUGINFOD_URLS=
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> mmap size 4198400B
> Control descriptor is not initialized
> mmap size 528384B
> anaconda-ks.cfg  bin  perf.all-number-20231219-104854.tar.bz2  perfconfig.off  perf.data  perf.data.baseline  perf.data.old
> [ perf record: Woken up 1 times to write data ]
> failed to write feature CPU_PMU_CAPS
> [ perf record: Captured and wrote 0.050 MB perf.data (170 samples) ]
> root@number:~#
> 
> There is a missing newline and we can avoid repeating a term, and I also
> added some extra explanation about "augmentation":
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 192721261098832e..3f77dd3eb70dc37a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4865,7 +4865,7 @@ int cmd_trace(int argc, const char **argv)
>  		goto skip_augmentation;
>  
>  	if ((argc >= 1) && (strcmp(argv[0], "record") == 0)) {
> -		pr_debug("Syscall augmentation fails with record, disabling augmentation");
> +		pr_debug("Syscall augmentation (reading pointer args using BPF) fails with record, disabling it.\n");
>  		goto skip_augmentation;
>  	}
>  
> I'll see if I come up with the test and a fix that allows augmentation
> to work with 'perf trace record'.
> 
> - Arnaldo
> 
>  
> > Closes: https://lore.kernel.org/lkml/CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-trace.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 109b8e64fe69..192721261098 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4864,6 +4864,11 @@ int cmd_trace(int argc, const char **argv)
> >  	if (!trace.trace_syscalls)
> >  		goto skip_augmentation;
> >  
> > +	if ((argc >= 1) && (strcmp(argv[0], "record") == 0)) {
> > +		pr_debug("Syscall augmentation fails with record, disabling augmentation");
> > +		goto skip_augmentation;
> > +	}
> > +
> >  	trace.skel = augmented_raw_syscalls_bpf__open();
> >  	if (!trace.skel) {
> >  		pr_debug("Failed to open augmented syscalls BPF skeleton");
> > -- 
> > 2.44.0.rc0.258.g7320e95886-goog
> > 
