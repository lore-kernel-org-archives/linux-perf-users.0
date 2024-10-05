Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A04145B1B
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728126373; cv=none; b=LvcXqSA+qNJZn38vGbeVoVDmHskFSwrOODM31YRJR8Ls9ZXlH+dC2uExct/uR3cVoLwTNPzYxlxVcwE8IDcxcHfa/GOODiMU+lBx+O37duSa/C15L+ds9ITvC8YwwxEsMQkxHCvraJQ1cvVV1IotkV1C0ym+EncvKZvJNfOu8XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728126373; c=relaxed/simple;
	bh=uXiTfY3y+BJR8a90QLbfSdRdnPQTLfltrJeRGRuWPkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq+5p1E+zGBqN9g4tEqUp7E7R2Ve+5JReIcrLO0B7ByKX51P06xqUtzF1dErKNtTgTt9trETq549IJ7Du2F95nxj27jDcHX/LdrTAOG+GKRvrGF7WV2bW4gi6Evqe5hyJGWh7Nt+X1Ze63HVtH1LIx5pA5yWcQKzYCvM//vfU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=hMIKoFSu; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="hMIKoFSu"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8323b555ae2so133374139f.2
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 04:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1728126371; x=1728731171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2sNCOQO6fYkDcP0biMmkbIV7L7GOfZWzCv2us5J0fI=;
        b=hMIKoFSux4k9csTLNGajomIcU7Gy/fI5vgzlNEs2irgOjO9LdweyymF+EmwDTdUmIh
         jW38ZcOz/q92CN4zSwsMrYeZkQgNL92rXhwxfz0q7/VK6GulI+4/UriIwKTi/R2d9+9Q
         sU1iKOZL0iVdHy6CkaTWOwjlhZ9h1sJqqrJjt5qOPdHWtHDIt5vCrC3I8MsWrhejIe7d
         kHA+PTtxII0oRJdPhprI/hDE5+vtnwUA3lJL9M4x0HqqvYFj2ApLjDLsYENPNc/GJSKp
         Xg1Xemly77q/+dXNbSHg07E2cNg88unZySj7MWNYkYqjI2cJMNYvjoK6H3NnpgqSzSkx
         dZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728126371; x=1728731171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2sNCOQO6fYkDcP0biMmkbIV7L7GOfZWzCv2us5J0fI=;
        b=os1ByYoyqZV3s5YqZmVLH4JLdzlxf+A6hsMh/QvIhFOcWIJOJWj10CEYixhsh3ODM5
         iG20xdM9nSo3txde3uZF+aMPKOipt8EQ//jJGRvFTfVJjG4+4ZLokmFCRIxwKks0FjEI
         jEYzUxAPI/iOSIMC5IfyJYsa6N5bIVlXcQ2z8t9iErBvZSKtLhnCmZN5+5BmLa1wvnV6
         MJczT6eSPVr9k37bkFoixYOBglKAdCXC/Q3DxthxRJQZa0LzkoVK/2c9nv/SpeoAEv5r
         nIRtXp8fA+57guphOGRfvUcpvF0PHabO75UOFdCGaQH7zUcI2snKg7skWHzhdQC/79fr
         aVHw==
X-Forwarded-Encrypted: i=1; AJvYcCVlewFgmq9Wor+cL0q1Q09kbV2sLV73UPowvHBtY7sXu1tcVfNA7XSJ0QJri2pU1tOhPC2R6gX7n8omzgFXH6m2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7+i+piK2TMcWlBnjy4CRQIi3QJOVHsSHOkFOkobPVfDdMocd
	L2yjZPQDa4I5G9ntEk4EDt1DOrBlmQdKXIna5I/aSbU8939gvr0mgiLQH1YqIJfzBcf3OK75e9F
	JmlD0ElltfVGp2Ea/r3waYol6mzRmsQd3kZjh8A==
X-Google-Smtp-Source: AGHT+IFIIioNr2vvhjdbCgrc3o7eBnHz0oNs3B1WaQBAfHIbbho0MDeqlCPz0d0DawzwWuXN/8QwenpSoNrh09r4Aac=
X-Received: by 2002:a05:6e02:148c:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a375a9ac5emr49651255ab.15.1728126370968; Sat, 05 Oct 2024
 04:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726126795.git.zhouquan@iscas.ac.cn>
In-Reply-To: <cover.1726126795.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 5 Oct 2024 16:36:00 +0530
Message-ID: <CAAhSdy0tEpgmC1VgMn_Km5SxwanOii5LzL-5oTJWbN+1vLjWug@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] riscv: Add perf support to collect KVM guest
 statistics from host side
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 1:30=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> Add basic guest support to RISC-V perf, enabling it to distinguish
> whether PMU interrupts occur in the host or the guest, and then
> collect some basic guest information from the host side
> (guest os callchain is not supported for now).
>
> Based on the x86/arm implementation, tested with kvm-riscv.
> test env:
> - host: qemu-9.0.0
> - guest: qemu-9.0.0 --enable-kvm (only start one guest and run top)
>
> -----------------------------------------
> 1) perf kvm top
> ./perf kvm --host --guest \
>   --guestkallsyms=3D/root/repo/shared/kallsyms \
>   --guestmodules=3D/root/repo/shared/modules top
>
> PerfTop:      41 irqs/sec  kernel:97.6% us: 0.0% guest kernel: 0.0% guest=
 us: 0.0% exact:  0.0% [250Hz cycles:P],  (all, 4 CPUs)
> -------------------------------------------------------------------------=
------
>
>     64.57%  [kernel]        [k] default_idle_call
>      3.12%  [kernel]        [k] _raw_spin_unlock_irqrestore
>      3.03%  [guest.kernel]  [g] mem_serial_out
>      2.61%  [kernel]        [k] handle_softirqs
>      2.32%  [kernel]        [k] do_trap_ecall_u
>      1.71%  [kernel]        [k] _raw_spin_unlock_irq
>      1.26%  [guest.kernel]  [g] do_raw_spin_lock
>      1.25%  [kernel]        [k] finish_task_switch.isra.0
>      1.16%  [kernel]        [k] do_idle
>      0.77%  libc.so.6       [.] ioctl
>      0.76%  [kernel]        [k] queue_work_on
>      0.69%  [kernel]        [k] __local_bh_enable_ip
>      0.67%  [guest.kernel]  [g] __noinstr_text_start
>      0.64%  [guest.kernel]  [g] mem_serial_in
>      0.41%  libc.so.6       [.] pthread_sigmask
>      0.39%  [kernel]        [k] mem_cgroup_uncharge_skmem
>      0.39%  [kernel]        [k] __might_resched
>      0.39%  [guest.kernel]  [g] _nohz_idle_balance.isra.0
>      0.37%  [kernel]        [k] sched_balance_update_blocked_averages
>      0.34%  [kernel]        [k] sched_balance_rq
>
> 2) perf kvm record
> ./perf kvm --host --guest \
>   --guestkallsyms=3D/root/repo/shared/kallsyms \
>   --guestmodules=3D/root/repo/shared/modules record -a sleep 60
>
> [ perf record: Woken up 3 times to write data ]
> [ perf record: Captured and wrote 1.292 MB perf.data.kvm (17990 samples) =
]
>
> 3) perf kvm report (the data shown here is not complete)
> ./perf kvm --host --guest \
>   --guestkallsyms=3D/root/repo/shared/kallsyms \
>   --guestmodules=3D/root/repo/shared/modules report -i perf.data.kvm
>
> # Total Lost Samples: 0
> #
> # Samples: 17K of event 'cycles:P'
> # Event count (approx.): 269968947184
> #
> # Overhead  Command          Shared Object            Symbol
> # ........  ...............  .......................  ...................=
...........................
> #
>     61.86%  swapper          [kernel.kallsyms]        [k] default_idle_ca=
ll
>      2.93%  :6463            [guest.kernel.kallsyms]  [g] do_raw_spin_loc=
k
>      2.82%  :6462            [guest.kernel.kallsyms]  [g] mem_serial_out
>      2.11%  sshd             [kernel.kallsyms]        [k] _raw_spin_unloc=
k_irqrestore
>      1.78%  :6462            [guest.kernel.kallsyms]  [g] do_raw_spin_loc=
k
>      1.37%  swapper          [kernel.kallsyms]        [k] handle_softirqs
>      1.36%  swapper          [kernel.kallsyms]        [k] do_idle
>      1.21%  sshd             [kernel.kallsyms]        [k] do_trap_ecall_u
>      1.21%  sshd             [kernel.kallsyms]        [k] _raw_spin_unloc=
k_irq
>      1.11%  qemu-system-ris  [kernel.kallsyms]        [k] do_trap_ecall_u
>      0.93%  qemu-system-ris  libc.so.6                [.] ioctl
>      0.89%  sshd             [kernel.kallsyms]        [k] __local_bh_enab=
le_ip
>      0.77%  qemu-system-ris  [kernel.kallsyms]        [k] _raw_spin_unloc=
k_irqrestore
>      0.68%  qemu-system-ris  [kernel.kallsyms]        [k] queue_work_on
>      0.65%  sshd             [kernel.kallsyms]        [k] handle_softirqs
>      0.44%  :6462            [guest.kernel.kallsyms]  [g] mem_serial_in
>      0.42%  sshd             libc.so.6                [.] pthread_sigmask
>      0.34%  :6462            [guest.kernel.kallsyms]  [g] serial8250_tx_c=
hars
>      0.30%  swapper          [kernel.kallsyms]        [k] finish_task_swi=
tch.isra.0
>      0.29%  swapper          [kernel.kallsyms]        [k] sched_balance_r=
q
>      0.29%  sshd             [kernel.kallsyms]        [k] __might_resched
>      0.26%  swapper          [kernel.kallsyms]        [k] tick_nohz_idle_=
exit
>      0.26%  swapper          [kernel.kallsyms]        [k] sched_balance_u=
pdate_blocked_averages
>      0.26%  swapper          [kernel.kallsyms]        [k] _nohz_idle_bala=
nce.isra.0
>      0.24%  qemu-system-ris  [kernel.kallsyms]        [k] finish_task_swi=
tch.isra.0
>      0.23%  :6462            [guest.kernel.kallsyms]  [g] __noinstr_text_=
start
>
> ---
> Change since v2:
> - Rebased on v6.11-rc7
> - Keep the misc type consistent with other architectures
>   as `unsigned long` (Andrew)
> - Add the same comment for `kvm_arch_pmi_in_guest`
>   as in arm64. (Andrew)
>
> Change since v1:
> - Rebased on v6.11-rc3
> - Fix incorrect misc type (Andrew)
>
> ---
> v1 link:
> https://lore.kernel.org/all/cover.1721271251.git.zhouquan@iscas.ac.cn/
> v2 link:
> https://lore.kernel.org/all/cover.1723518282.git.zhouquan@iscas.ac.cn/
>
> Quan Zhou (2):
>   riscv: perf: add guest vs host distinction
>   riscv: KVM: add basic support for host vs guest profiling

Please rebase this series upon Linux-6.12-rcX and send another version.

Regards,
Anup

>
>  arch/riscv/include/asm/kvm_host.h   | 10 ++++++++
>  arch/riscv/include/asm/perf_event.h |  7 ++++++
>  arch/riscv/kernel/perf_callchain.c  | 38 +++++++++++++++++++++++++++++
>  arch/riscv/kvm/Kconfig              |  1 +
>  arch/riscv/kvm/main.c               | 12 +++++++--
>  arch/riscv/kvm/vcpu.c               |  7 ++++++
>  6 files changed, 73 insertions(+), 2 deletions(-)
>
>
> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> --
> 2.34.1
>
