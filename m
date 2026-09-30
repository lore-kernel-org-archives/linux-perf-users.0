Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDF44AB65
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751368; cv=none; b=skI75/ej27OUoPn706VA0Wh1Hum1ABFCJMlY9ksVlw40ApDNpSu18CaODoF7SaYnikCVoV5Bks1v+gh4CNFBxH9qz2GsbZVkQ4NjRe8PeMV9FjittdFLrk+mtwRBgPr7oizuKKO2M5QzZdcCvlhbqacqdB2Eq+HqrGreJWHWnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751368; c=relaxed/simple;
	bh=ABkB+nnE15aJYPbWBGnr0zozEoWZq7uJquGyr3n0PAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R0pZJbGNHLB48cDiOx+Fg/rLJJva0XR/vPI5IKt7n42v4X/R2KCTjQFLAPIkn33hIJlpXwhLEi+bM8YarSmDrggU7neQzm+t40t3uZi/Wrhqzo6slIwRODgPkPIYMP4IRb1cwex1gQ27pIy/lbA6/HtxrsqsCFe7GYfkS5MzWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFl66oW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFl66oW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AC71F00898;
	Wed, 30 Sep 2026 06:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751361;
	bh=Yv2GpjGnkL6pwuOeDCaEs/3YshlVooBbfICcFXitaQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFl66oW9AK/IeZtotIODxBDkZvuBtt/aC+yIpgan89dlkoIWZjoQ0P6TwvGtGcJo6
	 EnjgRh6ygUGly9+o9jaHEKJ2hNsoLI2u8747y8gW4/Vf0tSgXc/qjnspFxaVqxUb+w
	 xURosRyo/11ofoAqvdyRwe0aoSzWOtmFRwCUdQxbbdNl0MZvhxdihLHEmef97rx3m/
	 GDUGk1h4thqkWxfQ5A3TxVnUFtBf4AtIWcdLHOS8c+Rq640MXSYSc8SQqtjkyHwtQD
	 oU4WDR1lnC6un7y9OVoHiYme0NMkZzjBJYgX48cQfopmo/lHdW8JRKJcspQC+eaRFB
	 FcqeorH9PYZTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/8] riscv: ptrace support for hardware
 break/watchpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930063919.608911-4-himanshu.chauhan@oss.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
 <20260930063919.608911-4-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:56:00 +0000
Message-Id: <20260930065600.D7AC71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] riscv/ptrace: HW breakpoints leaked across execve() via PTRACE_SET=
HBPREGS
- [High] riscv/ptrace: PTRACE_GETREGSET fails with -EINVAL when triggers > =
16
- [High] riscv/ptrace: kernel stack leak via uninitialized memory in riscv_=
hw_break_set
- [Medium] riscv/ptrace: missing hardware breakpoint support for compat pro=
cesses
- [Medium] riscv/ptrace: SETHBPREGS and SETREGSET operate on disjoint break=
point arrays
- [Medium] riscv/ptrace: missing array_index_nospec in riscv_ptrace_bp_get/=
set
--

commit 62c2c75a3fb752fd74e38e9ad58187d943832421
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

riscv: ptrace support for hardware break/watchpoints

This commit adds ptrace support for hardware breakpoints and watchpoints
on RISC-V. It introduces NT_RISCV_HW_BREAK/WATCH for GETREGSET/SETREGSET
and a convenience request pair PTRACE_GETHBPREGS/SETHBPREGS.

> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index f336a183667eb..2d4ee51e68597 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c

[ ... ]

> @@ -372,6 +378,397 @@ static int riscv_cfi_set(struct task_struct *target,
> +void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
> +{
> +	int i;
> +	struct thread_struct *t =3D &tsk->thread;
> +
> +	for (i =3D 0; i < RISCV_MAX_BP; i++) {
> +		if (t->debug.hbp_break[i]) {
> +			unregister_hw_breakpoint(t->debug.hbp_break[i]);
> +			t->debug.hbp_break[i] =3D NULL;
> +		}
> +	}

[Severity: High]
Does this code leak hardware breakpoints across execve()?

PTRACE_SETHBPREGS stores hardware breakpoints in child->thread.ptrace_bps,
but this function only unregisters breakpoints in debug.hbp_break and
completely ignores ptrace_bps. If the tracee executes a SUID binary, do the
hardware breakpoints remain active in the privileged context?

[ ... ]

> +static int ptrace_hbp_set_event(unsigned int note_type,
> +				struct task_struct *tsk,
> +				unsigned long idx,
> +				struct perf_event *bp)
> +{
> +	int err =3D -EINVAL;
> +
> +	switch (note_type) {
> +	case NT_RISCV_HW_BREAK:
> +		if (idx >=3D RISCV_MAX_BP)
> +			goto out;
> +		idx =3D array_index_nospec(idx, RISCV_MAX_BP);
> +		tsk->thread.debug.hbp_break[idx] =3D bp;

[Severity: Medium]
Are PTRACE_SETHBPREGS and PTRACE_SETREGSET operating on completely disjoint
memory locations?

PTRACE_SETREGSET populates tsk->thread.debug.hbp_break, while PTRACE_SETHBP=
REGS
populates tsk->thread.ptrace_bps. Can a debugger using both APIs independen=
tly
allocate up to 16 breakpoints in each array, potentially consuming the enti=
re
hardware trigger pool and observing disconnected states?

[ ... ]

> +static int ptrace_hbp_get_resource_info(unsigned int note_type, u32 *inf=
o)
> +{
> +	u8 num;
> +
> +	switch (note_type) {
> +	case NT_RISCV_HW_BREAK:
> +		num =3D hw_breakpoint_slots(TYPE_INST);
> +		break;

[Severity: High]
Can hw_breakpoint_slots() return a value larger than 16 (RISCV_MAX_BP)?

If a platform has more than 16 triggers, riscv_hw_break_get() and
riscv_hw_break_set() will iterate up to that number. However, the accessor
ptrace_hbp_get_event() contains a hardcoded bounds check returning -EINVAL
if idx >=3D RISCV_MAX_BP.

Would this cause the entire PTRACE_GETREGSET/SETREGSET syscall to abort with
-EINVAL when hitting index 16 on such platforms?

[ ... ]

> +static int riscv_hw_break_set(struct task_struct *target,
> +			const struct user_regset *regset,
> +			unsigned int pos, unsigned int count,
> +			const void *kbuf, const void __user *ubuf)
> +{
> +	unsigned int note_type =3D regset->core_note_type;
> +	int ret, idx =3D 0, offset, limit;
> +	u32 ctrl;

[Severity: High]
Is ctrl properly initialized before use?

user_regset_copyin() allows partial copies if count is smaller than the tar=
get
size. If a tracer supplies an iov_len of 9 or 17, user_regset_copyin() will
copy only 1 byte into ctrl, leaving the remaining 3 bytes containing
uninitialized kernel stack data.

When this partially initialized ctrl is passed to ptrace_hbp_set_ctrl() and
later read out via PTRACE_GETREGSET, could it successfully leak uninitializ=
ed
kernel stack memory to userspace?

[ ... ]

> +static int riscv_ptrace_bp_get(struct task_struct *child, unsigned long =
idx,
> +			  struct __riscv_hwdebug_state *state)
> +{
> +	struct perf_event *bp;
> +
> +	if (idx >=3D RISCV_HW_BP_NUM_MAX)
> +		return -EINVAL;
> +
> +	bp =3D child->thread.ptrace_bps[idx];

[Severity: Medium]
Might an array_index_nospec() mitigation be needed here to prevent speculat=
ive
out-of-bounds reads?

The user-supplied index idx is bounds-checked, but without array_index_nosp=
ec(),
speculative execution can bypass the bounds check and read out-of-bounds fr=
om
the ptrace_bps array. The resulting pointer is immediately dereferenced, wh=
ich
could provide an arbitrary speculative load gadget.

[ ... ]

Since compat_riscv_user_regset and compat_arch_ptrace() were not modified in
this patch:

arch/riscv/kernel/ptrace.c:compat_riscv_user_regset[] =3D {
...
arch/riscv/kernel/ptrace.c:compat_arch_ptrace() {

[Severity: Medium]
Will 32-bit processes running on a 64-bit kernel be able to use hardware
breakpoints?

These additions were omitted from compat_riscv_user_regset and
compat_arch_ptrace(), which seems to break feature parity for compat tracin=
g.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930063919.6089=
11-1-himanshu.chauhan@oss.qualcomm.com?part=3D3
