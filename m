Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378217F36D;
	Wed, 29 May 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008250; cv=none; b=nO3xVxMqCa64b+Ra+sK//DJQc8QEKl5khFsGFI+4TJNiSqHBYmEJWzq703VJ3eM81wW2Rq2FFqlA1+FZzk6torWkENZOk96jFsO+5PmWoSp1LMBIfaRYGkpC3uy1rMT8LEuWcAp16lBGEQ9g7UXx293m6Ml1+09V2vnGMaPYQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008250; c=relaxed/simple;
	bh=XV8bZo5tv4utERnmEJ1qxcCK/d2WUG8notNvjYH5IjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgNJBNDMl8ELgcE7L7ltjsI6Zo260mzTyPeKl2nI3374H2mYqdaAE6SiG++4L3IGd/5ccnVNSTxpeOWSPYNheNrWEBDdMb66GxA25FlIWuAysWEITV3ynwlRh/Vl869dPKVw6o7caIhRVeZSFagAfcfcq56EX186dvW0c1rKjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRBCc1od; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRBCc1od"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F211DC113CC;
	Wed, 29 May 2024 18:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717008249;
	bh=XV8bZo5tv4utERnmEJ1qxcCK/d2WUG8notNvjYH5IjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRBCc1odlaN7rkUuIkqAYRBDQd9GLxjVMa4MlzY9yxJ5/Cq47eboQ3kgKhHAUu3vg
	 ruRk/SMmuk5X3rFF+jKAJJoiOUWtMFk2ftbit7Af+uAkIkAb29y2e4MNqBDoOZbMqE
	 0v3NL6A/vuwe9ofhhVpBfGuD371wKdZlFXJwl+oWoD/wkgjma/MsV4YmgJ2bxBOgPD
	 XMBa95QuTVc0BSImQj7PvbbO6Pm6q+3x8tKO2BwPEdbqdBWVszTUJs7fv8lABqAmlf
	 fvHcJ516Huh83IZsnYcAF5jq1zXWVR8ijCIBp+zh222IG8IekbuKfbeRsR5Cr6bWI/
	 lTYUaB56lBeeg==
Date: Wed, 29 May 2024 15:44:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core
 PMUs
Message-ID: <Zld3dlJHjFMFG02v@x1>
References: <20240525152927.665498-1-irogers@google.com>
 <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev>
 <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1>
 <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com>

On Wed, May 29, 2024 at 03:50:53PM +0100, James Clark wrote:
> Is the problem you are referring to that there are multiple PMUs with
> 'cycles' events? Surely that's only a problem in the context of the new
> proposed behavior, otherwise it's not really a problem. It's just
> something that happens to exist.
 
> Because the user could always use the defaults (no argument) or -e
> cycles and historically Perf correctly picked the one that could be

See below to see if mixing up "cycles" for efficiency and performance
cores is something sane or if I am missing something.

> opened. Or if they want the DSU one they could specify it. That can all
> still work _and_ we can support "prefer sysfs/JSON" as long as we don't
> prefer it when opening the event doesn't work.

Yeah, getting all the events in all the PMUs that match a string (after
it is normalized to cover historical artifacts, as in the case of
"cycles", "cpu_cycles" and "cpu-cycles", all of which should mean
"cycles" the special, default event) and that can sample if that is what
is being asked seems to be a sane outcome from this discussion.

But lemme do try to show the differences from my Lenovo Intel Hybrid
system (13th gen) and a Libre Computer Rockchip ARM64 hybrid system:

There are some differences on how ARM64 supports hybrid that we may find
interesting to fix or at least to (better) document, for instance:

root@roc-rk3399-pc:~# dmidecode -H 1
# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.0 present.
7 structures occupying 283 bytes.
Table at 0xEAE7A020.

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: libre-computer
	Product Name: roc-rk3399-pc
	Version: Not Specified
	Serial Number: b03c01a7179278b7
	UUID: 63333062-3130-3761-3137-393237386237
	Wake-up Type: Reserved
	SKU Number: Not Specified
	Family: Not Specified

root@roc-rk3399-pc:~#

This is a hybrid architecture:

root@roc-rk3399-pc:~# ls -la /sys/devices/*/events/cpu_cycles
-r--r--r-- 1 root root 4096 May 29 16:27 /sys/devices/armv8_cortex_a53/events/cpu_cycles
-r--r--r-- 1 root root 4096 May 29 16:27 /sys/devices/armv8_cortex_a72/events/cpu_cycles
root@roc-rk3399-pc:~#

In an intel hybrid system we instead have:

root@number:~# ls -la /sys/devices/*/events/cpu-cycles
-r--r--r--. 1 root root 4096 May 29 13:59 /sys/devices/cpu_atom/events/cpu-cycles
-r--r--r--. 1 root root 4096 May 29 14:00 /sys/devices/cpu_core/events/cpu-cycles
root@number:~#

Small difference, a - versus a _, but then both hybrid, efficiency
cores (armv8_cortex_a53 vs cpu_atom) and performance ones
(armv8_cortex_a72 vs cpu_core).

On the Intel Hybrid system:

root@number:~# perf record -e cycles -a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.709 MB perf.data (46911 samples) ]
root@number:~# perf evlist
cpu_atom/cycles/
cpu_core/cycles/
dummy:u
root@number:~#

root@number:~# perf evlist -v
cpu_atom/cycles/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0xa00000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
cpu_core/cycles/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@number:~#

So it is recording CPU cycles in all the CPUs in the system, performance
and efficiency ones and that gets clear on a per-sample base:

root@number:~# perf script
            perf 2465078 [000] 73716.379947:          1 cpu_core/cycles/:  ffffffffb40a55fa native_write_msr+0xa ([kernel.kallsyms])
            perf 2465078 [001] 73716.379966:          1 cpu_core/cycles/:  ffffffffb40a55fa native_write_msr+0xa ([kernel.kallsyms])
<SNIP more cpu_core/cycles/ samples>
     gnome-shell    2608 [018] 73716.380704:    6721618 cpu_atom/cycles/:  ffffffffc0b8419c fw_domains_get_with_fallback+0xfc ([kernel.kallsyms])
          podman  688107 [017] 73716.380706:    6695621 cpu_atom/cycles/:      564fc6110da0 [unknown] (/usr/bin/podman)
          podman  687246 [000] 73716.380842:    8844997 cpu_core/cycles/:  ffffffffb515150c _raw_spin_lock_irqsave+0xc ([kernel.kallsyms])
          podman  688108 [016] 73716.380913:    6737580 cpu_atom/cycles/:  ffffffffb515205c native_queued_spin_lock_slowpath+0x28c ([kernel.kallsyms])
         swapper       0 [004] 73716.380932:    2090132 cpu_core/cycles/:  ffffffffb513ad49 poll_idle+0x59 ([kernel.kallsyms])
<SNIP>

But on the ARM hybrid system, without Ian's patch, i.e. with what is in
torvalds/master right now (plus some header copies updates I'm working
on that are unrelated):

root@roc-rk3399-pc:~# perf record -e cycles -a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.135 MB perf.data (359 samples) ]
root@roc-rk3399-pc:~# perf evlist
cycles
dummy:u
root@roc-rk3399-pc:~#

It records just one "event" even tho it is recording for all CPUs, both
efficiency and performance:

root@number:~# perf script
<SNIP>
 kworker/2:1-eve   10124 [002]  9687.302790:      60674  cycles:  ffffc4c65bdd7380 vmap_small_pages_range_noflush+0x190 ([kernel.kallsyms])
 kworker/2:1-eve   10124 [002]  9687.302957:      66040  cycles:  ffffc4c65bdd7438 vmap_small_pages_range_noflush+0x248 ([kernel.kallsyms])
 kworker/2:1-eve   10124 [002]  9687.303139:      71011  cycles:  ffffc4c65cde0210 ww_mutex_lock+0x60 ([kernel.kallsyms])
         swapper       0 [002]  9687.303342:      75390  cycles:  ffffc4c65bbc31c8 update_blocked_averages+0x188 ([kernel.kallsyms])
         swapper       0 [000]  9687.309276:      45496  cycles:  ffffc4c65ca38978 cpuidle_enter_state+0xc8 ([kernel.kallsyms])
<SNIP>

Everything appears as "cycles" but we're getting samples for all CPUs,
again, performance and efficiency ones, different kinds of processors,
right?

root@roc-rk3399-pc:~# perf report --stdio --sort cpu
# To display the perf.data header info, please use --header/--header-only options.
#
# Total Lost Samples: 0
#
# Samples: 359  of event 'cycles'
# Event count (approx.): 23873034
#
# Overhead  CPU
# ........  ...
#
    31.34%  003
    22.44%  004
    19.30%  000
    12.94%  002
     9.14%  001
     4.84%  005

root@roc-rk3399-pc:~#

If we try, instead with cpu-cycles:

root@roc-rk3399-pc:~# perf record -e cpu-cycles -a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.135 MB perf.data (346 samples) ]
root@roc-rk3399-pc:~# perf evlist
cpu-cycles
dummy:u
root@roc-rk3399-pc:~#
root@roc-rk3399-pc:~# perf evlist -v
cpu-cycles: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@roc-rk3399-pc:~# 

Both 'cycles' and 'cpu-cycles' end up the same as type: 0
(PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES).

But if we use something equivalent but with that - replaced with a _ we
get a behaviour that is closer to the Intel one:

root@roc-rk3399-pc:~# perf record -e cpu_cycles -a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.137 MB perf.data (390 samples) ]
root@roc-rk3399-pc:~# 
root@roc-rk3399-pc:~# perf evlist 
armv8_cortex_a53/cpu_cycles/
armv8_cortex_a72/cpu_cycles/
dummy:u
root@roc-rk3399-pc:~#

root@roc-rk3399-pc:~# perf evlist -v
armv8_cortex_a53/cpu_cycles/: type: 7 (armv8_cortex_a53), size: 136, config: 0x11 (cpu_cycles), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
armv8_cortex_a72/cpu_cycles/: type: 8 (armv8_cortex_a72), size: 136, config: 0x11 (cpu_cycles), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@roc-rk3399-pc:~# 

That doesn't mixes up CPU cycles for different CPU types:

root@roc-rk3399-pc:~# perf script
<SNIP>
            perf   16726 [005] 12632.206216:       3798 armv8_cortex_a72/cpu_cycles/:  ffffc4c65be618d8 do_vfs_ioctl+0x424 ([kernel.kallsyms])
         swapper       0 [000] 12632.206235:      78413 armv8_cortex_a53/cpu_cycles/:  ffffc4c65ca38978 cpuidle_enter_state+0xc8 ([kernel.kallsyms])
            perf   16726 [005] 12632.206272:      20279 armv8_cortex_a72/cpu_cycles/:  ffffc4c65be113b4 kmem_cache_alloc+0x44 ([kernel.kallsyms])
         sugov:4     166 [004] 12632.206409:      52979 armv8_cortex_a72/cpu_cycles/:  ffffc4c65cde5de8 _raw_spin_unlock_irqrestore+0x14 ([kernel.kallsyms])
            perf   16726 [005] 12632.206443:      67123 armv8_cortex_a72/cpu_cycles/:  ffffc4c65be26bbc arch_local_irq_restore+0x8 ([kernel.kallsyms])
            perf   16726 [005] 12632.206690:      96987 armv8_cortex_a72/cpu_cycles/:  ffffc4c65bdb4a84 fault_in_readable+0xe4 ([kernel.kallsyms])
       perf-exec   16727 [004] 12632.206836:      84199 armv8_cortex_a72/cpu_cycles/:  ffffc4c65bd6c3b4 next_uptodate_page+0x264 ([kernel.kallsyms])
            perf   16726 [005] 12632.206950:     102567 armv8_cortex_a72/cpu_cycles/:  ffffc4c65bbe2aa4 up_write+0xa4 ([kernel.kallsyms])
         swapper       0 [000] 12632.207030:      78413 armv8_cortex_a53/cpu_cycles/:  ffffc4c65ca38978 cpuidle_enter_state+0xc8 ([kernel.kallsyms])
       perf-exec   16727 [004] 12632.207037:      79507 armv8_cortex_a72/cpu_cycles/:  ffffc4c65c48b89c strnlen_user+0x16c ([kernel.kallsyms])
<SNIP>

So from the point of view of the user its important to differentiate
samples for each type of CPU, so grouping everything into the same
basket as ARM did in its big.LITTLE seems strange/"wrong".

The way that in Intel when it "does the right thing" (I think no quotes
are needed here, but I may be missing something) and at the tool level
translates the special event name "cycles" into what the Intel PMU
kernel drivers advertises to the world via sysfs as
/sys/devices/cpu_{atom,core}/events/cpu-cycles (with that -) and ARM
advertises as /sys/devices/armv8_cortex_a{53,72}/events/cpu_cycles (note
the _) but gets translated in terms of 'struct perf_event_attr' as

Intel:

cpu_atom/cycles/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0xa00000000
cpu_core/cycles/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000000

Versus ARM as:

armv8_cortex_a53/cpu_cycles/: type: 7 (armv8_cortex_a53), size: 136, config: 0x11 (cpu_cycles)
armv8_cortex_a72/cpu_cycles/: type: 8 (armv8_cortex_a72), size: 136, config: 0x11 (cpu_cycles)

can possibly be made more consistent in a way that doesn't break any
user experience using the perf command line.

I would propose that 'cycles' explicitely asked or as the default,
translates into armv8_cortex_a{53,72}/cpu_cycles/ on ARM and on
/sys/devices/cpu_{atom,core}/events/cpu-cycles on Intel, and that
whatever other architecture that comes to this party tries to learn from
this botched experience.

- Arnaldo
