Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B633A4F2A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841019; cv=pass; b=CgpAIsmAcTgWFIX3wLPqPBvhX1Y6RbDtSXu8Ax8Gol1d94W+IR972jH3OBB+yGPNFU84Ot/sK8zQDteie8SCQcBuFlL9Cb/onmhYrFi5mp29k0NgcSRqSWRA6UDPxbrtP1In9tViJU21u9DRq4w1eg+mHFsV2bXgpMQjO5t8V4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841019; c=relaxed/simple;
	bh=Lg+/TTx8BbBptFQfj20nBYIWu4lmvyGbKjwVgHlwojk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEE1yfvXNhCjiHR/u7zEcWP2WLySnqyLPm7wCBVl0eHnBGf0khJjaZ1eJEBvlcnJjvXavdKS0GDaLI30gTucQ8LrBb9NlTPwadCyf+nIV+xMwEkhGiMxX1zbKWBXQJB/FhhedgM8p2VC37Z2SZZYr0VIZXPPn2Ue2Ek5BglEziw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm4En3ff; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm4En3ff"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1141955166b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 06:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773841016; cv=none;
        d=google.com; s=arc-20240605;
        b=FfjDVymrFK3L5GIhmuBbz5mpy8HWxa5+c+FCkU2WD+zGHQGrndq3CUJp71VYCb+0YR
         abPPivsyCs3C0kVJQqcATA0ZNndJ5yS2YdCRXulyPnfDd+IQ6/AKeREu7G7d5S75f5qz
         eJF1Pba0BIc5kpRRaeScE5HWlU/QHWVlXEwNLbxPcmyLEjnOW3NyIvzYd+ndy6iFXjdQ
         OYPEHrX2R3jssQN91j0BHphPVfsEI7b3OllA+e7+k1qvXqqA95Yj4QqC/i4Fgf0BUojm
         MrH8OKYpKx1NgRYHbesxGd2dK569m1N3IOx4CrjsaMuViYC/DPAv9yJsFpuEuaFMnQL2
         zcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D6/bqSpW5+Oi9AxGrrozyndN6Q4jPcmDt6bbbs+htOc=;
        fh=RI0PmCCAJh6IIz2uW9aWLCBr0iCQXcSLdWei2yiKWK0=;
        b=dGKVRO/uIHEYxrpqG9Fq5Ess/g2Tolh+EJrkX8sGp37HPDgvl2ZnZcUSkX7HKqN5/c
         JlN0C5OawCAIu/B+uEkGdfVQhqtpKhjbQMarB/mFaLhPXEXpCvnoHQC4DrFw27J6muMZ
         Yw3MOZAIb4Bu1XqFZ48m8+gCRROzOAt4DEKIVqq6v2mOdpNlSLFvZNefKkBzo2G5WkYk
         rVZ0ov+TKq0rnYhAZw45gKQ5KNN7FhgSNng0liv8Su2b1hxQz9A/BoYiuvJt/ht0+x4g
         A2koTUZyrlqufl72f8O0GqDtWXElxLwOr63kuVjtIWFmw4MLY8dazl7GbM1WCpNk7WvM
         BS3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773841016; x=1774445816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6/bqSpW5+Oi9AxGrrozyndN6Q4jPcmDt6bbbs+htOc=;
        b=Vm4En3ffq61qLYqPd+VJ7/UpnQXy+fB5oP4WdzFA38DHdwBYQhL57BmQ+dLJGjd7ae
         Z2ExfYAz+/NwUIyDmREY/vxRpFQdc0A4KluTH3JNpCWi0DjSeKXEmlBz1HMMazxkO1lT
         P8CikPQOW0GcpxVQBKuvSS9Taz61pqvY+KL8sSvFjOWBWRvJawlm/7EovBOjLENQQzLn
         vbccolkJjmuGLRJTN/yXgFUesodZFImjxl5weP6u2X99d7zhF92tM5qEkHgISAKHKDb6
         rdGk09DWA2MjVtoCY/Oy+/myn351kWTp8GpJQyqQ7UISnYEaxHH9IrPLnIieb2VP9MJa
         vOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773841016; x=1774445816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6/bqSpW5+Oi9AxGrrozyndN6Q4jPcmDt6bbbs+htOc=;
        b=tJ52m0JaxTg+LGkRKN2lIzlilkPcKgSWrUXTbdesuIQK60/DdxBuB3wLnq/dMnc76y
         h9WTNv20e5TIq0FZcyUwi9kQtOsx82zqaa5QmQo6bgc4PqUlpJ+qcWlXTCL/lHYV+p4j
         8EI/aQB/z1aCBycjNhosDOHRZ5oOTxGVVi03PmGWIMcyVnYFDKZI+jHObFRyWNNtnqr7
         04dYQVcftdQgJERXFG/XkWUrTpwIZ5QVc4JWfsd232vriU7CwKC8gdOUJLshqH2xt+rU
         bQiLMQ9V6nAM3fE+a1MIVZ/qhwAo31zcwmhCBKosW4PTK+2yq2PkDe1fqdO69duk4fKN
         bICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU8hS/tjFHEA+Vi6SDwS7qHBA3JZNSmww7THAWu0aChi7ByFKBtswIKjCPTsNV5Y4efULDFSGmjqK789GhxZan@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+cbvfKlvWha+CosgNIcrolTiGzx68Zk/LRVPkDLaZey7OD5E
	ncC8P2AqBXMawiDckWW709X+3rrsE/Fy0gh+h5j+zqm2IB0H/+hJm0GqTrYn+dMmsa624Jk7dSR
	vbDs+4axXADBRVSRK1noBIO9nz+IN7Mc=
X-Gm-Gg: ATEYQzznjArklpkrhcZOtviyLzRZjJq18Ot7BgUKgFkYIl2gMgc9fD/CMXLV4wtsmqL
	bhx/Z7riOIi+jEt0RPrv3lfHnR2bhpZzePJ5aRropGo3If9bNWANMS4pqc1kSvHR5/+sG9/YaQJ
	ipMUNyuGP5NSrr/q8c3ApeXD24lNCdSTJ5SDT8lbU1J3DezwT5UX9fJ5Tc5sSokstfAZ6aDNFHF
	6rcEghUlQqACrLXyVPilIeP6j9Y14YdfC9EM/uu/P/6i9YKxH8WUby17wjaK6s/x2ST5EAoo2GZ
	E/NLY54W3xCBKAEE5XHKwmU=
X-Received: by 2002:a17:907:3f19:b0:b98:5d8:4fcb with SMTP id
 a640c23a62f3a-b9805d85532mr115473766b.33.1773841015811; Wed, 18 Mar 2026
 06:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313180352.3800358-1-puranjay@kernel.org>
In-Reply-To: <20260313180352.3800358-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 18 Mar 2026 13:36:44 +0000
X-Gm-Features: AaiRm500ICMe5FjGPFHKAmejEpH_zDzyFcFIWkH-r90t0VjGj-E8ZcJxEcK1X7c
Message-ID: <CANk7y0jmnraKP7k4Rzapq5jio4GGZwFadT0X12bTc-LoKBkzCg@mail.gmail.com>
Subject: Re: [PATCH bpf 0/3] arm64: Add BRBE support for bpf_get_branch_snapshot()
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will send v2 of this patch with minor changes that I discovered are
needed, will remove the bpf tag and send it based off the arm64 tree
as that is the correct place for this set to go.

On Fri, Mar 13, 2026 at 6:04=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> RFC: https://lore.kernel.org/all/20260102214043.1410242-1-puranjay@kernel=
.org/
> Changes from RFC:
>  - Fix pre-existing NULL pointer dereference in armv8pmu_sched_task()
>    found by Leo Yan during testing (patch 1)
>  - Pause BRBE before local_daif_save() to avoid branch pollution from
>    trace_hardirqs_off()
>  - Use local_daif_save() to prevent pNMI race from counter overflow
>    (Mark Rutland)
>  - Reuse perf_entry_from_brbe_regset() instead of duplicating register
>    read logic, by making it accept NULL event (Mark Rutland)
>  - Invalidate BRBE after reading to maintain record contiguity for
>    other consumers (Mark Rutland)
>  - Adjust selftest wasted_entries threshold for ARM64 (patch 3)
>  - Tested on ARM FVP with BRBE enabled
>
> This series enables the bpf_get_branch_snapshot() BPF helper on ARM64
> by implementing the perf_snapshot_branch_stack static call for ARM's
> Branch Record Buffer Extension (BRBE).
>
> bpf_get_branch_snapshot() [1] allows BPF programs to capture hardware
> branch records on-demand from any BPF tracing context. This was
> previously only available on x86 (Intel LBR) since v5.16. With BRBE
> available on ARMv9, this series closes the gap for ARM64.
>
> Usage model
> -----------
>
> The helper works in conjunction with perf events. The userspace
> component of the BPF application opens a perf event with
> PERF_SAMPLE_BRANCH_STACK on each CPU, which configures the hardware
> to continuously record branches into BRBE (on ARM64) or LBR (on x86).
> A BPF program attached to a tracepoint, kprobe, or fentry hook can
> then call bpf_get_branch_snapshot() to snapshot the branch buffer at
> any point. Without an active perf event, BRBE is not recording and
> the buffer is empty.
>
> On-demand branch snapshots from BPF are useful for diagnosing which
> specific code path was taken inside a function. Stack traces only show
> function boundaries, but branch records reveal the exact sequence of
> jumps, calls, and returns within a function -- making it possible to
> identify which specific error check triggered a failure, or which
> callback implementation was invoked through a function pointer.
>
> For example, retsnoop [2] is a BPF-based tool for non-intrusive
> mass-tracing of kernel internals. Its LBR mode (--lbr) creates per-CPU
> perf events with PERF_SAMPLE_BRANCH_STACK and then uses
> bpf_get_branch_snapshot() in its fentry/fexit BPF programs to capture
> branch records whenever a traced function returns an error.
>
> Consider debugging a bpf() syscall that returns -EINVAL when creating
> a BPF map with invalid parameters. Running retsnoop on an ARM64 FVP
> with BRBE to trace the bpf() syscall and array_map_alloc_check():
>
>   $ retsnoop -e '*sys_bpf' -a 'array_map_alloc_check' --lbr=3Dany \
>              -F -k vmlinux --debug full-lbr
>   $ simfail bpf-bad-map-max-entries-array  # in another terminal
>
> Output of retsnoop:
>
>   --- fentry BPF program (entries #63-#17) ---
>
>   [#63-#59] __htab_map_lookup_elem: hash table walk with memcmp        (h=
ashtab.c)
>   [#58] __htab_map_lookup_elem+0x98  -> dump_bpf_prog+0xc850           (h=
ashtab.c:750)
>   [#57-#55] ... dump_bpf_prog internal branches ...
>   [#54] dump_bpf_prog+0xcab8        -> bpf_get_current_pid_tgid+0x0    (h=
elpers.c:225)
>   [#53] bpf_get_current_pid_tgid+0x1c -> dump_bpf_prog+0xcabc          (h=
elpers.c:225)
>   [#52-#51] ... dump_bpf_prog -> __htab_map_lookup_elem ...
>   [#50-#47] __htab_map_lookup_elem: htab_map_hash (jhash2), select_bucket
>   [#46-#42] lookup_nulls_elem_raw: hash chain walk with memcmp         (h=
ashtab.c:717)
>   [#41] __htab_map_lookup_elem+0x98  -> dump_bpf_prog+0xcaf8           (h=
ashtab.c:750)
>   [#40-#37] ... dump_bpf_prog -> bpf_ktime_get_ns ...
>   [#36] bpf_ktime_get_ns+0x10       -> ktime_get_mono_fast_ns+0x0      (h=
elpers.c:178)
>   [#35-#32] ktime_get_mono_fast_ns: tk_clock_read -> arch_counter_get_cnt=
pct
>   [#31] ktime_get_mono_fast_ns+0x9c -> bpf_ktime_get_ns+0x14           (t=
imekeeping.c:493)
>   [#30] bpf_ktime_get_ns+0x18       -> dump_bpf_prog+0xcd50            (h=
elpers.c:178)
>   [#29-#25] ... dump_bpf_prog internal branches ...
>   [#24] dump_bpf_prog+0x11b28       -> __bpf_prog_exit_recur+0x0       (t=
rampoline.c:1190)
>   [#23-#17] __bpf_prog_exit_recur: rcu_read_unlock, migrate_enable     (t=
rampoline.c:1195)
>
>   --- array_map_alloc_check (entries #16-#12) ---
>
>   [#16] dump_bpf_prog+0x11b38       -> array_map_alloc_check+0x8       (a=
rraymap.c:55)
>   [#15] array_map_alloc_check+0x18  -> array_map_alloc_check+0xb8      (a=
rraymap.c:56)
>         . bpf_map_attr_numa_node       . bpf_map_attr_numa_node
>   [#14] array_map_alloc_check+0xbc  -> array_map_alloc_check+0x20      (a=
rraymap.c:59)
>         . bpf_map_attr_numa_node
>   [#13] array_map_alloc_check+0x24  -> array_map_alloc_check+0x94      (a=
rraymap.c:64)
>   [#12] array_map_alloc_check+0x98  -> dump_bpf_prog+0x11b3c           (a=
rraymap.c:82)
>
>   --- fexit trampoline overhead (entries #11-#00) ---
>
>   [#11] dump_bpf_prog+0x11b5c       -> __bpf_prog_enter_recur+0x0      (t=
rampoline.c:1145)
>   [#10-#03] __bpf_prog_enter_recur: rcu_read_lock, migrate_disable     (t=
rampoline.c:1146)
>   [#02] __bpf_prog_enter_recur+0x114 -> dump_bpf_prog+0x11b60          (t=
rampoline.c:1157)
>   [#01] dump_bpf_prog+0x11b6c       -> dump_bpf_prog+0xd230
>   [#00] dump_bpf_prog+0xd340        -> arm_brbe_snapshot_branch_stack+0x0=
 (arm_brbe.c:814)
>
>                    el0t_64_sync+0x168
>                    el0t_64_sync_handler+0x98
>                    el0_svc+0x28
>                    do_el0_svc+0x4c
>                    invoke_syscall.constprop.0+0x54
>     373us [-EINVAL] __arm64_sys_bpf+0x8
>                     __sys_bpf+0x87c
>                     map_create+0x120
>      95us [-EINVAL] array_map_alloc_check+0x8
>
> The FVP's BRBE buffer has 64 entries (BRBE supports 8, 16, 32, or
> 64). Of these, entries #63-#17 (47) are consumed by the fentry BPF
> trampoline that ran before the function, and entries #11-#00 (12)
> are consumed by the fexit trampoline that runs after. Entry #00
> shows the very last branch recorded before BRBE is paused: the call
> into arm_brbe_snapshot_branch_stack().
>
> The 5 useful entries (#16-#12) show the exact path taken inside
> array_map_alloc_check(). Record #14 shows a jump from line 56
> (bpf_map_attr_numa_node) to line 59 (the if-condition), and #13
> shows an immediate jump from line 59 (attr->max_entries =3D=3D 0) to
> line 64 (return -EINVAL), skipping lines 60-63. This pinpoints
> max_entries=3D=3D0 as the cause -- a diagnosis impossible with stack
> traces alone.
>
> [1] 856c02dbce4f ("bpf: Introduce helper bpf_get_branch_snapshot")
> [2] https://github.com/anakryiko/retsnoop
>
> Puranjay Mohan (3):
>   perf/arm_pmuv3: Fix NULL pointer dereference in armv8pmu_sched_task()
>   perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
>   selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
>
>  drivers/perf/arm_brbe.c                       | 70 ++++++++++++++++++-
>  drivers/perf/arm_brbe.h                       |  9 +++
>  drivers/perf/arm_pmuv3.c                      | 16 ++++-
>  .../bpf/prog_tests/get_branch_snapshot.c      |  9 +--
>  4 files changed, 95 insertions(+), 9 deletions(-)
>
>
> base-commit: ca0f39a369c5f927c3d004e63a5a778b08a9df94
> --
> 2.52.0
>
