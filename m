Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB81DDC19;
	Wed, 11 Dec 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938034; cv=none; b=c1zN0b15E3/j0sX3qLw8JobMDm+GFGKAlPyAzJSbmUo1UvJqv4+S0BqdqBi4BvP5LyinVBsn4W+efGuMNqvE6gkaQ2sJUCE2aydDx9J3sKSwtomdlvzncx9SL0FG9tqoT7qH6IwTU8sraB8ymws5bEeBRmIztc8MNL6wwfraIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938034; c=relaxed/simple;
	bh=1Dq89mUoAyecauYn1vRBUl6V2ZG+L0xgVwuUvqtLUjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayHjHwntUlENK1QUXTcGuHB0odRmwmjTOH1n9vUA2ED9IATYgKMApMtbMgi91uf1ELT61IknL3GobMUqz+7SYXIU+AqqiSY+gTqtgPl6/hF/cvTMttSGsfVECLnfZWRgkZ2EvKtRofZTVezizs5/RxmMM2SFPX2WqPABT7ax+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddn5fk6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddn5fk6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CDDC4CED2;
	Wed, 11 Dec 2024 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733938034;
	bh=1Dq89mUoAyecauYn1vRBUl6V2ZG+L0xgVwuUvqtLUjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddn5fk6uaOqUOUqUTMjUfslZibV/i9Vj09od4R1LRDQPuCIEnBE/eWg51/bRDGk7t
	 5PuLtngLj+87SvX47riZpXeGNHqslk4xj9/B38o71QHMIShFIlecPebxmXQu3cqoX+
	 J1Yi6atvIFb3V8fU3o0ACSOIDbmwAebtvDc5E+X6pgHOGwsYbvCMzcGvgNZC2mHhqf
	 jQ3yUa4fVYAsVKtLIR3Gc8WSE8BXfMKBWx6VhmKoFlOpcG5tWM2VSlPAqH9ezHqUWL
	 g7sqRCWQCOG1e57Dar0TEkN2aGGTywTmhoMMB8fNjL3gdidjUwt9MfqvMOr4GuNV17
	 22MFpAFY4EJNw==
Date: Wed, 11 Dec 2024 09:27:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Mingwei Zhang <mizhang@google.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [linus:master] [perf tools]  af954f76ee:
 perf-sanity-tests.Test_data_symbol.fail
Message-ID: <Z1nLcMDTFAFuX809@google.com>
References: <202411301431.799e5531-lkp@intel.com>
 <Z04ZUHaGdsBapIEL@google.com>
 <Z1BhfpYWpUQ0p+qR@xsang-OptiPlex-9020>
 <Z1DNJpDzCIBFrIZT@google.com>
 <Z1DV0lN8qHSysX7f@google.com>
 <Z1HHClaOwjJnR5gr@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1HHClaOwjJnR5gr@x1>

On Thu, Dec 05, 2024 at 12:30:18PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Dec 04, 2024 at 02:21:06PM -0800, Namhyung Kim wrote:
> > On Wed, Dec 04, 2024 at 01:44:06PM -0800, Namhyung Kim wrote:
> > [SNIP]
> > >   perf_event_attr:
> > >     type                             4 (cpu)
> > >     size                             136
> > >     config                           0x1cd (mem-loads)
> > >     { sample_period, sample_freq }   4000
> > >     sample_type                      IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT
> > >     read_format                      ID|LOST
> > >     freq                             1
> > >     precise_ip                       3
> > >     sample_id_all                    1
> > >     { bp_addr, config1 }             0x1f
> > >   ------------------------------------------------------------
> > >   sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
> > >   sys_perf_event_open failed, error -22
> > >   Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
> > >   Error:
> > >   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu/mem-loads,ldlat=30/).
> > >   "dmesg | grep -i perf" may provide additional information.
> > > 
> > > There's an issue with fallback on the inherit bit with the sample read.
> > > I'll take a look.
> > 
> > Hmm, no.  It doesn't have neight SAMPLE_READ nor inherit.  So the error
> > message was misleading.  Maybe it should be printed when it actually
> > clears the bits.
> > 
> > Anyway, I've tested with the old code and realzed that it might be due
> > to precise_ip being 3.  I expected it'd return EOPNOTSUPP for the case
> > but it seems to return EINVAL sometimes.  Then it should check it after
> > the missing features like below.  Can you please test?
> 
> Before:
> 
> root@number:/tmp# perf mem record -a sleep 1s
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_core/mem-loads,ldlat=30/).
> "dmesg | grep -i perf" may provide additional information.
> 
> root@number:/tmp# 
> 
> With your patch:
> 
> root@number:/tmp# perf mem record -a sleep 1s
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 11.211 MB perf.data (14616 samples) ]
> root@number:/tmp# perf evlist
> cpu_atom/mem-loads,ldlat=30/P
> cpu_atom/mem-stores/P
> cpu_core/mem-loads-aux/
> cpu_core/mem-loads,ldlat=30/
> cpu_core/mem-stores/P
> dummy:u
> # Tip: use 'perf evlist -g' to show group information
> root@number:/tmp# perf evlist -v
> cpu_atom/mem-loads,ldlat=30/P: type: 10 (cpu_atom), size: 136, config: 0x5d0 (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
> cpu_atom/mem-stores/P: type: 10 (cpu_atom), size: 136, config: 0x6d0 (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1
> cpu_core/mem-loads-aux/: type: 4 (cpu_core), size: 136, config: 0x8203 (mem-loads-aux), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1
> cpu_core/mem-loads,ldlat=30/: type: 4 (cpu_core), size: 136, config: 0x1cd (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, freq: 1, precise_ip: 2, sample_id_all: 1, { bp_addr, config1 }: 0x1f
> cpu_core/mem-stores/P: type: 4 (cpu_core), size: 136, config: 0x2cd (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1
> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|CPU|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> # Tip: use 'perf evlist -g' to show group information
> root@number:/tmp#
> 
> But there is something strange, 'cpu_core/mem-loads-aux/' doesn't have
> /P, i.e. shouldn't try to set precise_ip to 3, but according to 'perf
> evlist -v' it is setting it to 3.
> 
> I thought maybe it could be related to groups, but:
> 
> root@number:/tmp# perf evlist -g
> cpu_atom/mem-loads,ldlat=30/P
> cpu_atom/mem-stores/P
> {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}
> cpu_core/mem-stores/P
> dummy:u
> root@number:/tmp# 
> 
> But then, in tools/perf/arch/x86/util/mem-events.c
> 
> struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
>         E("ldlat-loads",        "%s/mem-loads,ldlat=%u/P",      "mem-loads",    true,   0),
>         E("ldlat-stores",       "%s/mem-stores/P",              "mem-stores",   false,  0),
>         E(NULL,                 NULL,                           NULL,           false,  0),
> };
> 
> struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] = {
>         E("ldlat-loads",        "{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P", "mem-loads",    true,   MEM_LOADS_AUX),
>         E("ldlat-stores",       "%s/mem-stores/P",              "mem-stores",   false,  0),
>         E(NULL,                 NULL,                           NULL,           false,  0),
> };
> 
> It has the :P for that group, maybe that is going to fallback?
> 
> I tried:
> 
> Breakpoint 1, evsel__precise_ip_fallback (evsel=0xf4a260) at util/evsel.c:1969
> 1969	{
> (gdb) bt
> #0  evsel__precise_ip_fallback (evsel=0xf4a260) at util/evsel.c:1969
> #1  0x00000000005dfb09 in evsel__open_cpu (evsel=0xf4a260, cpus=0xf53840, threads=0xf5bfa0, start_cpu_map_idx=0, end_cpu_map_idx=16) at util/evsel.c:2577
> #2  0x00000000005dfc54 in evsel__open (evsel=0xf4a260, cpus=0xf53840, threads=0xf5bfa0) at util/evsel.c:2603
> #3  0x000000000042cbea in record__open (rec=0xec2ce0 <record>) at builtin-record.c:1370
> #4  0x00000000004304a1 in __cmd_record (rec=0xec2ce0 <record>, argc=2, argv=0xf58180) at builtin-record.c:2489
> #5  0x0000000000434840 in cmd_record (argc=2, argv=0xf58180) at builtin-record.c:4260
> #6  0x0000000000469e93 in __cmd_record (argc=3, argv=0x7fffffffde20, mem=0x7fffffffd260, options=0x7fffffffd080) at builtin-mem.c:170
> #7  0x000000000046b2f3 in cmd_mem (argc=4, argv=0x7fffffffde20) at builtin-mem.c:538
> #8  0x00000000004c0414 in run_builtin (p=0xec6098 <commands+696>, argc=5, argv=0x7fffffffde20) at perf.c:351
> #9  0x00000000004c06bb in handle_internal_command (argc=5, argv=0x7fffffffde20) at perf.c:404
> #10 0x00000000004c0814 in run_argv (argcp=0x7fffffffdc0c, argv=0x7fffffffdc00) at perf.c:448
> #11 0x00000000004c0b5d in main (argc=5, argv=0x7fffffffde20) at perf.c:560
> (gdb) print evsel__name(evsel)
> $1 = 0xf529b0 "cpu_core/mem-loads,ldlat=30/"
> (gdb) p evsel->core.attr.precise_ip 
> $2 = 3
> (gdb) p evsel->precise_max
> $3 = true
> (gdb)
> 
> And it fell back to precise_ip=2, the previous attempt at opening with 3
> resulted in EINVAL.
> 
> It should have that precise level reflected in the evsel name :-\
> 
> Ran out of time, hope the above helps.
> 
> Apart from that, from a purely regression fix, your patch gets the
> previous behaviour, from this isolated test I made, so:
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Applied to perf-tools, thanks!

Best regards,
Namhyung

