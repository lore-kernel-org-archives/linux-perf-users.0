Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C33B14B0
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664573; cv=pass; b=KfZ7sfb8QmleLiOLyK98gEiAWX1btGjtrnbegYA65U0FrAWm4L3Az5W8ew4qS5jr6pWSuwvUUJ+TLlnkyzxRKk5l/fiosqSGfemvuqtG9WGNX4vyXC6cJbzvcsbZYevemnk2/Y9HA52/rDm+usDZGc+nulxGwWh9rNcEFp4J7Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664573; c=relaxed/simple;
	bh=7Rcc7KyE8tbm7ygtfwDBDBxyxnCeiVQgltB9GabYmQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHPmhxVHSoirOUhHBQXrvKUsR3BD5ikbXhPY3+rjvYvp1DkU2vFfXp3ELqugGsqU/nlMQd7hedrcDXhUV4dVIOC1FixbE/Jjmdibqu9tfk3wUZvHRJMeo/ZDqKAst4lxtYgCYLTg2ZoLJfxJMBBZChBdKk/dDl+Cqg4NQCTRHSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoIBAj+4; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoIBAj+4"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-beb1bee8c16so249626466b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 06:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780664570; cv=none;
        d=google.com; s=arc-20240605;
        b=aVbguD7E4YPzOju5snhQA3m4PbX0gzgQchqD9y6PBqe6XGMUoop+9vcVwTF7a9CSTO
         es2+f2iNy9nYjrTRHhE4nQslr4I3JK37qUB8+vNfaz+pDhcdt06TYhFasoRi2O4jxx01
         nlgNl2CGRxOs2RtL+/h7/EL6tI+tD0eArhyoPDQ+ZQPBf/TZaOBTAcwrLz5qPERDqiVI
         9LBQdaGMYkY7IyJFfQPSZwLcmChKj2Zo8hmF0/hvz0/HK23lg1wJ8C57RHg3Y4LEA7jm
         x1evjKkwtdKFJoebpjFjpNTtn2hyju9acdtv1xboT16L0t62tmIQQCtjNpVyhswS75h/
         LDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JU4GN0vpsrLuN8vab5FiAWTdMHvX9GAwzjPoC+upVCk=;
        fh=fKFscFodFaAWNFLDTfVMZUrUj/GSSxI8+FYa6vdhUtk=;
        b=DuFGKRGW4LC8nu8+2lpIHqeRDYkVrhEUDPogT59pMkVd5fy7GPInSeYKb6QltRbrqn
         +pQE0Hnq30gMJZSexHU6+f0XKqVfZVv60nGZWnL+KcIgHJ/3mOo8DEeYZMMZECGa1fNc
         cLFszKkpj4kSxUbRos5eNrZQ7PusI00V/O6XiA4hH4QjYLZyn8DC/kEcNIeILXAZw6f2
         DKbt5c5aF3kcHzVOm9S2clsYHMY5ba5f3z3k3QoWAcR3WCENvnA2CoRrjKGnFqGL/EDO
         Lk58C4yR1adgJD1wih/0ypambues56OslpteJGVnlbOgRwFZHIfSzXe3a8/I2PE6QHNp
         w4WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780664570; x=1781269370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU4GN0vpsrLuN8vab5FiAWTdMHvX9GAwzjPoC+upVCk=;
        b=XoIBAj+4p9JGtPC19hq8k3ePKDaUIvj6c5EZ6j8Qpfu6j91uQKIZkTruZMKTKDk1Ga
         jLvYfPIiFQ9O151yApr0lcm9hZ4RhnZnkY08EhSJTw0wumUnIlFCm1NrtWStxvcvq2q9
         owO8fDiyBOGoBYF0o+3X7jLHFJTp8NxEMQNDZcnvE6BWfPMphWhaBCHdk1pw+BdWWCoX
         SeMgjqFyEX8wq/ztbRNSE5j9PTMv47PSSOPh6FJTvNP41Zl9aG4cjsSDbxAboV5oCxNQ
         b8ipNvHrS5uNWLjbsq1XIhkquInKLRMYghOINA9Aht3Nhfouvxayb4JpbZWaMA3oe1vJ
         /c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664570; x=1781269370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JU4GN0vpsrLuN8vab5FiAWTdMHvX9GAwzjPoC+upVCk=;
        b=FWCS6zJ55xI/eBX5NMUU9pZvU5Nl+7qPI8wOsSBRTyzcGNyKHKlZuF90RkryTSn53v
         SiQusSsNpd8EkXz/hJluN3+nsp5oqaJ0xUbQ+k8FyfupDnAQI4qVGvfBBbPJInS+4csC
         Nor9/6RPVzeKPKuo9XGWh+w/wUX+90I7q/aTERLlskdRJ3paLlH7FrXQlVeAe65SMSKx
         rRJ3KvpaYs/4xOMtF0CVaTBXdRsNQgGpgGJ+Cjli8eGTdTXT4NoycnWvt7h7YKOd90l5
         Kn/kAkaY3Mulwt4LvIy/jS+1lI+r/jeBYBOPNzWaQpapzw96KN4WrA2w9tvaz1B0iYXj
         n1/g==
X-Forwarded-Encrypted: i=1; AFNElJ8I4ay8BylqHyCsgVG/bM2fWsyhamkCgxtznBYVjbm6Rp/E49tZf24Nn+3/PXIqfzwMwb8kfjCcJ9Ho9yKSXHr6@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHDWs8mogvFW5HusFiWRuqRkPGt7b1ZV9U3VsXH7LdG5AF7qQ
	1ANOgr8RiiwN1lnXeac0X9UweblEJEUtsB3z6UoxHvrNj9Sd/Smmti69aih+xHfRcXtpGVAInV4
	187PIJ1armhhel4h75ncFavZvHQkm1cA=
X-Gm-Gg: Acq92OF3VCp0wcdla9IvLr0HZpO1Wc5RNQ9ufF4FL8Gj6/+X59nsYZ5EAjYhGiGNGwT
	sRvTG8vfXG6Wv5okhgHKQYrw7IsGDMDs3OEN+dIsygXimrtT/rknqh4YwDDlSYQKz2hllVCxnkc
	q0n/BV7I3SBJw9zQHIneYhvil7uTt7bm7Cs19ntnW6pFlYKCqKZRM8IVZNn3C6q4/lBDjW3sM4T
	sZbjPd7T2bUdyl2mz8nOIk7cdIhL9brhmcv3fb9+VrtmIwuPutlfNrNTmpOWQbh83yPqTIhzJfd
	19lZvjkzUE2aGHfoxgNhuV6cWqURb+XoNg==
X-Received: by 2002:a17:907:972a:b0:bdb:5c26:d499 with SMTP id
 a640c23a62f3a-bf3a8a06e97mr124263866b.22.1780664569563; Fri, 05 Jun 2026
 06:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527121207.2312181-1-puranjay@kernel.org>
In-Reply-To: <20260527121207.2312181-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 5 Jun 2026 14:02:35 +0100
X-Gm-Features: AVVi8CdZLIwoo8jb7IFSIVOMgYaUMKtB5fOz9Xl1a8POCFsNfhfSvAxdUH1qdvk
Message-ID: <CANk7y0jnUebhpw5ORp9TPY7jqfp-5gEF8wkjpUJJd7mLJje7vw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] arm64: Add BRBE support for bpf_get_branch_snapshot()
To: Rob Herring <robh@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Stephane Eranian <eranian@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Could you please have a look at this patchset when you get a chance?

Thanks,
Puranjay

On Wed, May 27, 2026 at 1:12=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> v3: https://lore.kernel.org/all/20260413185740.3286146-1-puranjay@kernel.=
org/
> Changes in v4:
> - Fix leaking branch records when scheduled task has an unrelated perf ev=
ent (Sashiko)
> - Update tools/include/uapi/linux/perf_event.h as well for patch 2
> - Introduce cpu_has_brbe() and use it in
>   arm_brbe_snapshot_branch_stack(0 to make sure we don't run on a CPU
>   without BRBE.
> - Add explicit isb() after after writing to SYS_BRBFCR_EL1.
> - Rebase on latest arm64 tree.
>
> v2: https://lore.kernel.org/all/20260318171706.2840512-1-puranjay@kernel.=
org/
> Changes in v3:
> - Move NULL pmu_ctx fix from arm_pmuv3.c to perf core (Leo Yan)
> - Use union to clear branch entry bitfields instead of per-field
>   zeroing (Leo Yan)
> - Remove per-CPU brbe_active flag; check BRBCR_EL1 =3D=3D 0 instead (Rob
>   Herring)
> - Remove redundant valid_brbidr() check in snapshot path (Rob Herring)
> - Introduce for_each_brbe_entry() iterator to deduplicate bank
>   iteration (Rob Herring)
> - Include perf core maintainers (Leo Yan, Rob Herring)
>
> v1: https://lore.kernel.org/all/20260313180352.3800358-1-puranjay@kernel.=
org/
> Changes in v2:
> - Rebased on arm64/for-next/core
> - Add per-CPU brbe_active flag to guard against UNDEFINED sysreg access
>   on non-BRBE CPUs in heterogeneous big.LITTLE systems.
> - Fix pre-existing bug in perf_clear_branch_entry_bitfields() that missed
>   zeroing new_type and priv bitfields, added as a separate patch with
>   Fixes tags (new patch 2).
> - Use architecture-specific selftest threshold (#if defined(__aarch64__))
>   instead of raising the global threshold, to preserve x86 regression
>   detection.
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
> Puranjay Mohan (4):
>   perf/core: Fix sched_task callbacks for CPU-wide branch stack events
>   perf: Use a union to clear branch entry bitfields
>   perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
>   selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
>
>  drivers/perf/arm_brbe.c                       | 127 +++++++++++++++---
>  drivers/perf/arm_brbe.h                       |   9 ++
>  drivers/perf/arm_pmuv3.c                      |   5 +-
>  include/linux/perf_event.h                    |   9 +-
>  include/uapi/linux/perf_event.h               |  25 ++--
>  kernel/events/core.c                          |  17 ++-
>  tools/include/uapi/linux/perf_event.h         |  25 ++--
>  .../bpf/prog_tests/get_branch_snapshot.c      |  13 +-
>  8 files changed, 172 insertions(+), 58 deletions(-)
>
>
> base-commit: c754aa6b881ade764510b8539a6a313326501e3d
> --
> 2.53.0-Meta
>
