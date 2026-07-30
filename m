Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D757D3C10B8
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441375; cv=pass; b=bq/YdOaR6ZuCd0Lpi4TrC1tWQsgQKiFwpBSPmj143ppP3TRCUjo+zvNUaH4PCXX2cv0ILdqNVYo8i0IUUWdoSBBxIgd9J/R7WfyGm+5KmhhUoqfV4HPkhFN1H0Ckrc16+JQM03WzsjgtlqJzoTJ2FRnXkmabO0jX/tphdgnmFXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441375; c=relaxed/simple;
	bh=16So5jmChyNE7HDynm5fgODKRjMME6U+0M/Ka4lYORI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soySVyHDavSKG32KpOux7f1wLmBlkBOJe0hNvUXswl8SSY9mJN8T+4vBgICuxW9HsvTl5pEEteMlDNdJJexR1FdfLqnWtzpDPuuwqRoR93jhDbG8j9+8zP6znHq2jcdfnBDSbsFMiOwt8n38eftSYLBQ7XpBLJnJVkOPD/KTeI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKqaVI3O; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKqaVI3O"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e507b079dso240311b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 12:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785441372; cv=none;
        d=google.com; s=arc-20260327;
        b=DVZ7T1RqxNIL6q3Z5C8yCz4hTD1rAvrS6zO76TOPBbRBkKrVDnLFthCjRWCVUNCBUs
         /i6fW2QbQ4bJK4yjVTgeorKjnsz0x6VNNY9C3ZeRDt/ksb+p8Fpm4ycYe2s9uHrqv0Pu
         7AHalwmX1BQrRpTkQNlVFEG3HmQipzZ28Lh2ujnmfNyjUAnQPjcGJUeJbGVOCzD/bcCX
         4qGSdr2PKYfYyyV15jktWvkZgEDFjJYDRMsRCxyE+w+iDSZyru1dJXNmfYO1mN+VHRZ2
         ywgtdDfIZF3BP9Bw3m7CEAj/rQQQUUvO38oictKpvrrcWPuIgW9RQ2XdGux2pxINDBcn
         hHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2YjraHLhNBdb828cMVG+VPWGUgCKy1lqxxb1/ukJ4gI=;
        fh=AtZm2OP1vcfwi+GY3T/2YXk9aMYn/PPjzBKo1I2/SxQ=;
        b=mp7PWrHo0LJuWzsaXWh0gbKsCm5yBLurGhsk3t6Ou0MXHM82tTmch49HsGGGhrVf5P
         dCHlaNiYk5+yK8qWTEwpcgjs6PbwRrDAPgZ3VABKHnkPLPQdsxrPYWHhcYbsfNqq8P6z
         MObp8qJt4LwCiVz7eng+mI2MSOde4Q85DrEqNnckNRrgYyDcqdkus+yANQorMVMjcY3w
         D2q2gV0cpF7cSHiv72r97Ukc4u8z9CiIWZ/o6/lxO+2Bv+fb0dSE/9AfaGF3BS27B3Ux
         YsnqsQvXkI6wtmi0yAR+hZm4kDIevcnmPcBKFUqx52HtOpEFBhmPBtF2cWyrNFe1k1qX
         h8Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785441372; x=1786046172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2YjraHLhNBdb828cMVG+VPWGUgCKy1lqxxb1/ukJ4gI=;
        b=JKqaVI3OAak7YJoiPoLrQ9ZOq4ykzYnuIBwQgCKJxwtijNuJIdJ2I6ycB3tB4PPJ+J
         FkI9N+Xo4CzmimRUlLu/zg3vcYuWcUL4nGxfccX2CmJjt7on6euGVNEXAaOX/mduo35+
         AeRms/EavO9HTBu/1DkAFosJa55lq6Yq5gDyS771lYWCf/ARK8eEfC+ZUag3WxBWe/2E
         nzQzdZov+T2Eb+xbvwcmd080T2kqS0cV0s7ij78hSs48CKoVfui3dPawX5W7/B2y4kYM
         WtSRKsq6MOZc5JrqvCCoVXQj91zDC+qPCN/hFvl1utfegq8baHjTkj3/pqifUFp8B4p3
         oB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441372; x=1786046172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YjraHLhNBdb828cMVG+VPWGUgCKy1lqxxb1/ukJ4gI=;
        b=nbfwpagvz9ubn5sxJ3Y9L2iI/KQuhe0cz1UB5bIs4TyjJohMcT1pxdq39guA3z0H9H
         X2K2jp4Y8ukBGsvg/OdzVvdLje4O5w0XfjnwuJhTERcK+yiuQsoC29amLZmDW8rl4ZnX
         a89nT3KG6i0o57acAUYVDjIHF0zd7w68goaYwGD+ew19nvqhqVAqO9+QDOYE/w4H8eDh
         0uA2goT8mewQTSRMYC5hbiWNF54kVEcGiPNmV5nYDr1HS5bOVmaej0xZhPT0+WJpkroE
         uwnLh+Mi/0SDLghXExkRbvwrN9EXuugZioeOggudhlDbWlw+ZH0z29Ji68fFyaot8Iqs
         MSuQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeZ6klAlK+Cj/7G+T86z01Kxu4vt8eeEXQu8DeLEAhjm1lF2z4awpIPFiGbRnAXCboLld4JddvV3thd46xo7nv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0lfbaBfXcQ/iFwylriLByl/zH8fsnzcGKe5acnTtMpn/+vu9y
	T8WS2NAfXdUSfIjJFmFybDi+rnE+QP7HD06rq8ODwYe5xZwlLfDh79/z4cbNspwBZEN+fQ3XJCq
	QpDKY/x011aOm+EZmwdcLitKzf9b9E0c=
X-Gm-Gg: AR+sD11bhVyrEQ+7JOhpRU5DHfYib+sUJ44jrz6XYjQUwc3fVWEc7R9z2rFLSnyte4w
	CNTUd31NCNz+ZHzPhaTnlPb1UIWF9UIdAEz9xoSbJd7gX79SCVMOC5uePP/5UTv4Y9PhUO1RRGl
	JfEZs0FrMar/IJ3NdWIMw1uSLQREwvly5bm0QKTRjtCwP7yH/wKn7JtnuM2yUQ117lWtVqcjgMW
	XdMu9/dYPh729tQNFPVqINZUp+bQh4vuWV5Be4VCBEWKB0i24RqQXn1zGVNIL3Pg9Oi2Df4ABw2
	TbqkTs7+1IL5dTim5shPbnzpXMGBa2pdViSMaiuDmvnbl/fSu93cBaZ95ct0mz+WJihZdvcE/zd
	0lc2KGJgjLGMzajphdnXTXIU5puG5RuS/7Qb5UDYJcg==
X-Received: by 2002:a05:6a00:4288:b0:847:86d8:5937 with SMTP id
 d2e1a72fcca58-84ebc3dd035mr3596449b3a.50.1785441371789; Thu, 30 Jul 2026
 12:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-1-puranjay@kernel.org> <CANk7y0j0j9GH7GpN6ahjiUwab_884csZcecrVsfBHupUANMgNw@mail.gmail.com>
 <CANk7y0jv7dYpmts0RpoZT305rXvFQicfEXRsJ4f2_PR2Y4WYxA@mail.gmail.com>
In-Reply-To: <CANk7y0jv7dYpmts0RpoZT305rXvFQicfEXRsJ4f2_PR2Y4WYxA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 12:55:53 -0700
X-Gm-Features: AUfX_mwVbIbtgblYhrHztASTo7jrz3farcuMtpBnrZcCQ0GajeGyagnZb4WnEMQ
Message-ID: <CAEf4BzZD+r63Q0OEkC6bGgvdP=RzoW=Gg8ab4jAJjk-vZNqwew@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] arm64: Add BRBE support for bpf_get_branch_snapshot()
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Stephane Eranian <eranian@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:38=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Gentle ping for this.
>
> I have been waiting for feedback for 7 months now. Please let me know
> how I can make this patchset better.
>
> Thanks,
> Puranjay
>
> On Wed, Jul 15, 2026 at 2:24=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > Hi Mark and Will,
> >
> > Could you please have a look at this patchset when you get a chance?
> >
> > It has been reviewed by Rob.
> >

Hi,

Mostly question to ARM maintainers/reviews. What's the status of this
patch set from your POV? Puranjay implemented an important
functionality that debugging tooling (e.g., retsnoop, but I believe
now more tools rely on this LBR-like data) uses. We already are
getting real CPUs that support BRBE functionality, so it would be
great to get this landed soon  (if it looks ok, if not, please advise
how to fix) and start rolling out to the fleet in new kernels.

Please help getting is in, thank you!



> > Thanks,
> > Puranjay
> >
> > On Tue, Jun 16, 2026 at 4:57=E2=80=AFPM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> > >
> > > Changelog:
> > >
> > > v4: https://lore.kernel.org/all/20260527121207.2312181-1-puranjay@ker=
nel.org/
> > > Changes in v5:
> > > - Rework patch 2: drop the UAPI union. Instead rename the helper to p=
erf_clear_branch_entry() and
> > >   clear the entry with a single
> > >         *br =3D (struct perf_branch_entry){ }.
> > >   This stays kernel-internal, with no changes to the uapi/ or tools/ =
headers (James Clark).
> > > - Add an isb() to the BRBCR_EL1 =3D=3D 0 early-exit in the snapshot, =
for consistency with the other
> > >   two exit paths (bpf-ci).
> > > - Add Rob Herring's Reviewed-by to patch 3
> > >
> > > v3: https://lore.kernel.org/all/20260413185740.3286146-1-puranjay@ker=
nel.org/
> > > Changes in v4:
> > > - Fix leaking branch records when scheduled task has an unrelated per=
f event (Sashiko)
> > > - Update tools/include/uapi/linux/perf_event.h as well for patch 2
> > > - Introduce cpu_has_brbe() and use it in
> > >   arm_brbe_snapshot_branch_stack(0 to make sure we don't run on a CPU
> > >   without BRBE.
> > > - Add explicit isb() after after writing to SYS_BRBFCR_EL1.
> > > - Rebase on latest arm64 tree.
> > >
> > > v2: https://lore.kernel.org/all/20260318171706.2840512-1-puranjay@ker=
nel.org/
> > > Changes in v3:
> > > - Move NULL pmu_ctx fix from arm_pmuv3.c to perf core (Leo Yan)
> > > - Use union to clear branch entry bitfields instead of per-field
> > >   zeroing (Leo Yan)
> > > - Remove per-CPU brbe_active flag; check BRBCR_EL1 =3D=3D 0 instead (=
Rob
> > >   Herring)
> > > - Remove redundant valid_brbidr() check in snapshot path (Rob Herring=
)
> > > - Introduce for_each_brbe_entry() iterator to deduplicate bank
> > >   iteration (Rob Herring)
> > > - Include perf core maintainers (Leo Yan, Rob Herring)
> > >
> > > v1: https://lore.kernel.org/all/20260313180352.3800358-1-puranjay@ker=
nel.org/
> > > Changes in v2:
> > > - Rebased on arm64/for-next/core
> > > - Add per-CPU brbe_active flag to guard against UNDEFINED sysreg acce=
ss
> > >   on non-BRBE CPUs in heterogeneous big.LITTLE systems.
> > > - Fix pre-existing bug in perf_clear_branch_entry_bitfields() that mi=
ssed
> > >   zeroing new_type and priv bitfields, added as a separate patch with
> > >   Fixes tags (new patch 2).
> > > - Use architecture-specific selftest threshold (#if defined(__aarch64=
__))
> > >   instead of raising the global threshold, to preserve x86 regression
> > >   detection.
> > >
> > > RFC: https://lore.kernel.org/all/20260102214043.1410242-1-puranjay@ke=
rnel.org/
> > > Changes from RFC:
> > >  - Fix pre-existing NULL pointer dereference in armv8pmu_sched_task()
> > >    found by Leo Yan during testing (patch 1)
> > >  - Pause BRBE before local_daif_save() to avoid branch pollution from
> > >    trace_hardirqs_off()
> > >  - Use local_daif_save() to prevent pNMI race from counter overflow
> > >    (Mark Rutland)
> > >  - Reuse perf_entry_from_brbe_regset() instead of duplicating registe=
r
> > >    read logic, by making it accept NULL event (Mark Rutland)
> > >  - Invalidate BRBE after reading to maintain record contiguity for
> > >    other consumers (Mark Rutland)
> > >  - Adjust selftest wasted_entries threshold for ARM64 (patch 3)
> > >  - Tested on ARM FVP with BRBE enabled
> > >
> > > This series enables the bpf_get_branch_snapshot() BPF helper on ARM64
> > > by implementing the perf_snapshot_branch_stack static call for ARM's
> > > Branch Record Buffer Extension (BRBE).
> > >
> > > bpf_get_branch_snapshot() [1] allows BPF programs to capture hardware
> > > branch records on-demand from any BPF tracing context. This was
> > > previously only available on x86 (Intel LBR) since v5.16. With BRBE
> > > available on ARMv9, this series closes the gap for ARM64.
> > >
> > > Usage model
> > > -----------
> > >
> > > The helper works in conjunction with perf events. The userspace
> > > component of the BPF application opens a perf event with
> > > PERF_SAMPLE_BRANCH_STACK on each CPU, which configures the hardware
> > > to continuously record branches into BRBE (on ARM64) or LBR (on x86).
> > > A BPF program attached to a tracepoint, kprobe, or fentry hook can
> > > then call bpf_get_branch_snapshot() to snapshot the branch buffer at
> > > any point. Without an active perf event, BRBE is not recording and
> > > the buffer is empty.
> > >
> > > On-demand branch snapshots from BPF are useful for diagnosing which
> > > specific code path was taken inside a function. Stack traces only sho=
w
> > > function boundaries, but branch records reveal the exact sequence of
> > > jumps, calls, and returns within a function -- making it possible to
> > > identify which specific error check triggered a failure, or which
> > > callback implementation was invoked through a function pointer.
> > >
> > > For example, retsnoop [2] is a BPF-based tool for non-intrusive
> > > mass-tracing of kernel internals. Its LBR mode (--lbr) creates per-CP=
U
> > > perf events with PERF_SAMPLE_BRANCH_STACK and then uses
> > > bpf_get_branch_snapshot() in its fentry/fexit BPF programs to capture
> > > branch records whenever a traced function returns an error.
> > >
> > > Consider debugging a bpf() syscall that returns -EINVAL when creating
> > > a BPF map with invalid parameters. Running retsnoop on an ARM64 FVP
> > > with BRBE to trace the bpf() syscall and array_map_alloc_check():
> > >
> > >   $ retsnoop -e '*sys_bpf' -a 'array_map_alloc_check' --lbr=3Dany \
> > >              -F -k vmlinux --debug full-lbr
> > >   $ simfail bpf-bad-map-max-entries-array  # in another terminal
> > >
> > > Output of retsnoop:
> > >
> > >   --- fentry BPF program (entries #63-#17) ---
> > >
> > >   [#63-#59] __htab_map_lookup_elem: hash table walk with memcmp      =
  (hashtab.c)
> > >   [#58] __htab_map_lookup_elem+0x98  -> dump_bpf_prog+0xc850         =
  (hashtab.c:750)
> > >   [#57-#55] ... dump_bpf_prog internal branches ...
> > >   [#54] dump_bpf_prog+0xcab8        -> bpf_get_current_pid_tgid+0x0  =
  (helpers.c:225)
> > >   [#53] bpf_get_current_pid_tgid+0x1c -> dump_bpf_prog+0xcabc        =
  (helpers.c:225)
> > >   [#52-#51] ... dump_bpf_prog -> __htab_map_lookup_elem ...
> > >   [#50-#47] __htab_map_lookup_elem: htab_map_hash (jhash2), select_bu=
cket
> > >   [#46-#42] lookup_nulls_elem_raw: hash chain walk with memcmp       =
  (hashtab.c:717)
> > >   [#41] __htab_map_lookup_elem+0x98  -> dump_bpf_prog+0xcaf8         =
  (hashtab.c:750)
> > >   [#40-#37] ... dump_bpf_prog -> bpf_ktime_get_ns ...
> > >   [#36] bpf_ktime_get_ns+0x10       -> ktime_get_mono_fast_ns+0x0    =
  (helpers.c:178)
> > >   [#35-#32] ktime_get_mono_fast_ns: tk_clock_read -> arch_counter_get=
_cntpct
> > >   [#31] ktime_get_mono_fast_ns+0x9c -> bpf_ktime_get_ns+0x14         =
  (timekeeping.c:493)
> > >   [#30] bpf_ktime_get_ns+0x18       -> dump_bpf_prog+0xcd50          =
  (helpers.c:178)
> > >   [#29-#25] ... dump_bpf_prog internal branches ...
> > >   [#24] dump_bpf_prog+0x11b28       -> __bpf_prog_exit_recur+0x0     =
  (trampoline.c:1190)
> > >   [#23-#17] __bpf_prog_exit_recur: rcu_read_unlock, migrate_enable   =
  (trampoline.c:1195)
> > >
> > >   --- array_map_alloc_check (entries #16-#12) ---
> > >
> > >   [#16] dump_bpf_prog+0x11b38       -> array_map_alloc_check+0x8     =
  (arraymap.c:55)
> > >   [#15] array_map_alloc_check+0x18  -> array_map_alloc_check+0xb8    =
  (arraymap.c:56)
> > >         . bpf_map_attr_numa_node       . bpf_map_attr_numa_node
> > >   [#14] array_map_alloc_check+0xbc  -> array_map_alloc_check+0x20    =
  (arraymap.c:59)
> > >         . bpf_map_attr_numa_node
> > >   [#13] array_map_alloc_check+0x24  -> array_map_alloc_check+0x94    =
  (arraymap.c:64)
> > >   [#12] array_map_alloc_check+0x98  -> dump_bpf_prog+0x11b3c         =
  (arraymap.c:82)
> > >
> > >   --- fexit trampoline overhead (entries #11-#00) ---
> > >
> > >   [#11] dump_bpf_prog+0x11b5c       -> __bpf_prog_enter_recur+0x0    =
  (trampoline.c:1145)
> > >   [#10-#03] __bpf_prog_enter_recur: rcu_read_lock, migrate_disable   =
  (trampoline.c:1146)
> > >   [#02] __bpf_prog_enter_recur+0x114 -> dump_bpf_prog+0x11b60        =
  (trampoline.c:1157)
> > >   [#01] dump_bpf_prog+0x11b6c       -> dump_bpf_prog+0xd230
> > >   [#00] dump_bpf_prog+0xd340        -> arm_brbe_snapshot_branch_stack=
+0x0 (arm_brbe.c:814)
> > >
> > >                    el0t_64_sync+0x168
> > >                    el0t_64_sync_handler+0x98
> > >                    el0_svc+0x28
> > >                    do_el0_svc+0x4c
> > >                    invoke_syscall.constprop.0+0x54
> > >     373us [-EINVAL] __arm64_sys_bpf+0x8
> > >                     __sys_bpf+0x87c
> > >                     map_create+0x120
> > >      95us [-EINVAL] array_map_alloc_check+0x8
> > >
> > > The FVP's BRBE buffer has 64 entries (BRBE supports 8, 16, 32, or
> > > 64). Of these, entries #63-#17 (47) are consumed by the fentry BPF
> > > trampoline that ran before the function, and entries #11-#00 (12)
> > > are consumed by the fexit trampoline that runs after. Entry #00
> > > shows the very last branch recorded before BRBE is paused: the call
> > > into arm_brbe_snapshot_branch_stack().
> > >
> > > The 5 useful entries (#16-#12) show the exact path taken inside
> > > array_map_alloc_check(). Record #14 shows a jump from line 56
> > > (bpf_map_attr_numa_node) to line 59 (the if-condition), and #13
> > > shows an immediate jump from line 59 (attr->max_entries =3D=3D 0) to
> > > line 64 (return -EINVAL), skipping lines 60-63. This pinpoints
> > > max_entries=3D=3D0 as the cause -- a diagnosis impossible with stack
> > > traces alone.
> > >
> > > [1] 856c02dbce4f ("bpf: Introduce helper bpf_get_branch_snapshot")
> > > [2] https://github.com/anakryiko/retsnoop
> > >
> > > Puranjay Mohan (4):
> > >   perf/core: Fix sched_task callbacks for CPU-wide branch stack event=
s
> > >   perf/core: Clear the whole branch entry in perf_clear_branch_entry(=
)
> > >   perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
> > >   selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
> > >
> > >  arch/x86/events/amd/brs.c                     |   2 +-
> > >  arch/x86/events/amd/lbr.c                     |   2 +-
> > >  arch/x86/events/intel/lbr.c                   |   6 +-
> > >  drivers/perf/arm_brbe.c                       | 130 +++++++++++++++-=
--
> > >  drivers/perf/arm_brbe.h                       |   9 ++
> > >  drivers/perf/arm_pmuv3.c                      |   5 +-
> > >  include/linux/perf_event.h                    |  16 +--
> > >  kernel/events/core.c                          |  17 ++-
> > >  .../bpf/prog_tests/get_branch_snapshot.c      |  13 +-
> > >  9 files changed, 150 insertions(+), 50 deletions(-)
> > >
> > >
> > > base-commit: 61c19a9feb1d87156e46e38d7759f3ad23710e24
> > > --
> > > 2.53.0-Meta
> > >
