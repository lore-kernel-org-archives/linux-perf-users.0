Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE362391AA;
	Wed,  4 Dec 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340258; cv=none; b=h6h4N19HG/5NH6ZwWm0xYjLD3xG4ruwn8iR7GItEzKxnKepzfF+onrVTlzoK/DBPeTgIFSU2ZU7UZipkI/FrWchGlp2J6sVZ2JTW81w3ppKVYphC0MwViaoer7uKZpAc5PTsSqXKlUZJZNk75EwF53isBic2pWYCU2FZnV7+hdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340258; c=relaxed/simple;
	bh=7Nz7Fmk1v8MZPUXucg959qe8Vj0xy0XnrVAGLmjOadM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN4MImQxAKlFaGPPqnlRhNB+EhQdAFotDrkwKOEQ1mmSuNUi1kX335/APwG6pdPMS4Yd0KArr3FdTB4ZRSMCi7fDvztj4IGG0CDSBs19b0YxeT0W7ZF55EL77qB/JysfIFNwIPBIDEd3zhcoTj9eeteiouvgWV0MzghYoR5sWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jilvUodB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jilvUodB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E47C4CECD;
	Wed,  4 Dec 2024 19:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733340257;
	bh=7Nz7Fmk1v8MZPUXucg959qe8Vj0xy0XnrVAGLmjOadM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jilvUodBBXvpy7uZs90jylcs939jMLElAtL5N2rCxsdXZL+ruqpViv3Qs9G1zoBu5
	 pYc7AYinwE68/JBySCEmCwHnJOJZVIqQo8KMmROLNbt4AUREUEdYpJISGfRm3OscIo
	 dVPg6NY3tt4hVLTZogUofA2q6m/qGC1wbc/P9swbbFADyO4/tLcgosoS6lEXtcZGHc
	 rvuvc0YFyX80RtU7BAK6jiwH6PYVwcxroNHCpCogZbHfnm5cQZFMCMEdodmThCv+hu
	 lzjY6br9ijStQR8jT+GIt+AsfcrS8zFFvJopV+SwTruREJXQgLE7Cz+V3303aCihD2
	 L2jnITPmmC85Q==
Date: Wed, 4 Dec 2024 11:24:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Atish Patra <atishp@atishpatra.org>,
	Mingwei Zhang <mizhang@google.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [REGRESSION] 'perf mem record' on a Intel hybrid system broken
Message-ID: <Z1CsX3n5U_q5ehRp@google.com>
References: <Z1CVTJ5jzIyNiB1R@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1CVTJ5jzIyNiB1R@x1>

Hi Arnaldo,

On Wed, Dec 04, 2024 at 02:45:48PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi Namhyung,
> 
> root@number:/tmp# perf mem record -a sleep 1s
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_core/mem-loads,ldlat=30/).
> "dmesg | grep -i perf" may provide additional information.
> 
> root@number:/tmp# dmesg | tail
> [18865.729882] ixgbe 0000:05:00.0 enp5s0: NIC Link is Up 10 Gbps, Flow Control: RX/TX
> [18865.848172] mlx5_core 0000:01:00.0 enp1s0f0np0: Link down
> [18866.057990] mlx5_core 0000:01:00.1 enp1s0f1np1: Link down
> [19066.396215] input: JBL RACE TWS (AVRCP) as /devices/virtual/input/input27
> [19078.378477] usb 2-3: current rate 16000 is different from the runtime rate 48000
> [21158.375680] usb 2-3: current rate 16000 is different from the runtime rate 48000
> [31386.186675] input: JBL RACE TWS (AVRCP) as /devices/virtual/input/input28
> [31409.098352] usb 2-3: current rate 16000 is different from the runtime rate 48000
> [36409.737615] sysrq: Emergency Sync
> [36409.742619] Emergency Sync complete
> root@number:/tmp#
> 
> 	That I bisected down to:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git bisect good 
> af954f76eea56453713ae657f6812d4063f9bc57 is the first bad commit
> commit af954f76eea56453713ae657f6812d4063f9bc57
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Tue Oct 15 23:23:57 2024 -0700
> 
>     perf tools: Check fallback error and order
>     
>     The perf_event_open might fail due to various reasons, so blindly
>     reducing precise_ip level might not be the best way to deal with it.
>     
>     It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
>     given precise level.  Let's try again with the correct error code.
>     
>     This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
>     user events with exclude_kernel=1 cannot make progress.  Let's add the
>     evsel__handle_error_quirks() to this case specially.  I plan to work on
>     the kernel side to improve this situation but it'd still need some
>     special handling for IBS.
>     
>     Reviewed-by: James Clark <james.clark@linaro.org>
>     Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>     Acked-by: Kan Liang <kan.liang@linux.intel.com>
>     Cc: James Clark <james.clark@arm.com>
>     Cc: Atish Patra <atishp@atishpatra.org>
>     Cc: Mingwei Zhang <mizhang@google.com>
>     Cc: Kajol Jain <kjain@linux.ibm.com>
>     Cc: Thomas Richter <tmricht@linux.ibm.com>
>     Cc: Palmer Dabbelt <palmer@rivosinc.com>
>     Link: https://lore.kernel.org/r/20241016062359.264929-8-namhyung@kernel.org
>     Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> If I revert that patch:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git log --oneline -5
> 9a9f2d6da1ea5ef5 (HEAD -> perf-tools-next) Revert "perf tools: Check fallback error and order"
> d12d4cfc5033cd8c perf script python: Improve physical mem type resolution
> 3f79d822e331022f perf disasm: Return a proper error when not determining the file type
> 1a5b914261f0ebee tools features: Don't check for libunwind devel files by default
> 40384c840ea1944d (tag: v6.13-rc1, perf-tools/perf-tools) Linux 6.13-rc1
> ⬢ [acme@toolbox perf-tools-next]$
> 
> And rebuild, it works again:
> 
> root@number:/tmp# perf mem record -a sleep 1s
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 13.014 MB perf.data (10316 samples) ]
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
> root@number:/tmp# perf evlist -g
> cpu_atom/mem-loads,ldlat=30/P
> cpu_atom/mem-stores/P
> {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}
> cpu_core/mem-stores/P
> dummy:u
> root@number:/tmp#
> 
> Now trying to investigate this,

I think I got a related report from the kernel test robot but it was a
Sapphire Rapids machine.  I don't have a Intel hybrid machine in hand.
I'll try to take a look at it on Sapphire Rapids.

Thanks,
Namhyung

