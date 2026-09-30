Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EF3C2762
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751394; cv=none; b=YxcmP0ZIN3CNmBVbAwETEML3fN8BbUp65seEDIEcCqxPOkO2kHa/npmZEtSLYXwlxJO98TEr4pOZPA50YDTZaRmtyMnnyS8N8sGYzVyi8IxNa0TRqfj0P+awJwuLmnvGR3Zg5O5twV6bg4ORsi8YvsvPVuKz/W1JAKPyM36v9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751394; c=relaxed/simple;
	bh=G0F+W0Jc4SKKCsUVfVaiLiNUzV3Geyl+n8pm+oqeRiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JXgF7uYQDsmroQ/Wg+cJPRgeXnLqwizz1MpMGH5ks3Z7VA7MuvynFIrZN0Uq7FwGzxKUwyGhHaP++C8PcdcjTipxpATblr0k75OyEAc1VHTFKNaajVu5/knprVIkgRX96f4lRRd6W7Iut1AalbG6zGcDiz1nVV49Ix3LoRZCDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7SzIE+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7SzIE+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E3F1F000FF;
	Wed, 30 Sep 2026 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751386;
	bh=a/taHUy7S38tLGzCpkkxf0Myf7Ns62xk6iPNKZa9SvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7SzIE+ZJZWDqDND21LcddnyKBze6A+XkvYogDQgtpGXo1/iFVaohAs+d2MTI9mA7
	 16VTAaeXq/7fVeFnudolMFXpt3+dEyom/LYO6JuDY+VHn0faCr8vgC41r5flEN0Upg
	 2QcG1ymaidYBFWaqy3NWiqrKSP+/cZmgKeK5PPFS++K9jKuyADYLI8+6ALwHkNBF4q
	 xvanXG3xxXES7/6nu0u/VDtXY0YEFD1Nd8acfB/n3i6HvKWf8uVU7RmBY3T7ZVdBcy
	 rdr/NamT5Tvy36yLi7Hun033NJojQsIxDz1+0wouRpcofMN4D7cYn6JQg4TF6q0F7W
	 hK85tdtpXZJig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/8] riscv: Add software supported single stepping
 with mc/mc6 triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930063919.608911-7-himanshu.chauhan@oss.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
 <20260930063919.608911-7-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:56:26 +0000
Message-Id: <20260930065626.91E3F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] riscv/hw_breakpoint: Unprivileged user can arm HW breakpoints =
on kernel addresses (DoS)
- [High] riscv/hw_breakpoint: HW breakpoint permanently lost on control flo=
w divergence
- [High] riscv/hw_breakpoint: infinite trap loop if get_insn_safe fails
- [High] riscv/hw_breakpoint: setup_singlestep overrides synchronous event =
disablement
- [High] riscv/hw_breakpoint: CPU-wide breakpoints permanently lost on task=
 migration
- [Medium] riscv/hw_breakpoint: state machine corruption on install failure
- [Medium] riscv/hw_breakpoint: infinite loop when single-stepping sret
- [Low] riscv/hw_breakpoint: saved_tdata fields are completely unused
- [Low] riscv/hw_breakpoint: incorrect next_addr logged due to loop variabl=
e shadowing
- [Low] riscv/hw_breakpoint: redundant bit clearing on zero-initialized fie=
lds
--

commit 39e397c6cb04690cc3a8477d767b61ec32e69fda
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: riscv: Add software supported single stepping with mc/mc6 triggers

This commit adds software-supported single-stepping for mc/mc6 triggers on=
=20
RISC-V. It attempts to avoid loops by temporarily disabling the current=20
breakpoint, setting a new execute breakpoint at the next instruction's=20
address, and restoring the original breakpoint once the next instruction is=
 hit.

> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_bre=
akpoint.c
> index dd6f639539691..9597ed3625378 100644
> --- a/arch/riscv/kernel/hw_breakpoint.c
> +++ b/arch/riscv/kernel/hw_breakpoint.c
[ ... ]
> +static int setup_singlestep(struct perf_event *event, struct pt_regs *re=
gs)
> +{
> +	struct arch_hw_breakpoint *bp =3D counter_arch_bp(event);
> +	unsigned long insn, next_addr =3D 0;
> +	int ret;
> +	struct arch_hw_breakpoint tmp =3D {};
> +
> +	/*
> +	 * Save the original trigger configuration so we can restore it
> +	 * after the single-step fires.
> +	 */
> +	bp->saved_tdata1 =3D bp->tdata1;
> +	bp->saved_tdata2 =3D bp->tdata2;
> +	bp->saved_tdata3 =3D bp->tdata3;

[Severity: Low]
Are these saved values actually consumed? The restore logic in
hw_breakpoint_handler() seems to ignore them and completely recreates the
state from scratch via hw_breakpoint_arch_parse().

> +
> +	ret =3D get_insn_safe(regs, regs->epc, &insn);
> +	if (ret < 0)
> +		return ret;

[Severity: High]
What happens if get_insn_safe() fails (for example, if the user space
instruction page is swapped out, causing get_insn() to fail under
pagefault_disable())?

Since hw_breakpoint_handler() logs the error and returns NOTIFY_DONE without
advancing the PC or disabling the execute trigger, will the CPU immediately
re-trap on the exact same instruction upon resuming, leading to an infinite
loop?

> +
> +	next_addr =3D get_step_address(regs, insn);

[Severity: Medium]
When single-stepping an sret instruction, the underlying call to
get_next_insn_address_standard() calculates the step target to be the
current instruction itself. Since this configures an execute breakpoint
at the same address, does this cause an infinite loop where the CPU
repeatedly traps before executing the sret?

> +
> +	/*
> +	 * Software path: update the trigger in-place to an execute
> +	 * breakpoint at next_addr.  Build the tdata directly without
> +	 * calling hw_breakpoint_arch_parse() so that bp->len, bp->type
> +	 * and bp->address are not overwritten and remain valid for the
> +	 * handler's matching logic after restore.
> +	 */
> +	tmp.tdata1 =3D 0;
> +	tmp.tdata2 =3D next_addr;
> +	tmp.tdata3 =3D 0;
> +	switch (dbtr_type) {
> +	case RISCV_DBTR_TRIG_MCONTROL6:
> +		RISCV_DBTR_SET_MC6_EXEC_BIT(tmp.tdata1);
> +		tmp.tdata1 =3D RISCV_DBTR_SET_MC6_SIZE(tmp.tdata1, 0);
> +		tmp.tdata1 =3D RISCV_DBTR_SET_MC6_TYPE(tmp.tdata1,
> +						     RISCV_DBTR_TRIG_MCONTROL6);
> +		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_DMODE_BIT);
> +		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_TIMING_BIT);
> +		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_SELECT_BIT);
> +		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_ACTION_BIT);

[Severity: Low]
Since tmp.tdata1 is explicitly initialized to 0 above, are these
CLEAR_DBTR_BIT operations necessary?=20

Also, does clearing the ACTION_BIT this way correctly handle the multi-bit
nature of this field, or does it only clear the lowest bit?

> +		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_CHAIN_BIT);
> +		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_MATCH_BIT);
> +		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_M_BIT);
> +		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_VS_BIT);
> +		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_VU_BIT);
> +		SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_S_BIT);
> +		SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_U_BIT);

[Severity: Critical]
Does this allow an unprivileged user to arm hardware breakpoints on kernel
addresses?=20

Since this unconditionally sets both the Supervisor and User bits and
bypasses arch_check_bp_in_kernelspace(), could a user place a user-space
breakpoint on a jalr instruction and set the target register to a critical
kernel address (like the stvec trap vector)? If the hardware trigger fires
in Supervisor mode, could this instantly lock up the CPU in a recursive
breakpoint exception loop?

[ ... ]
> +	arch_update_hw_breakpoint(event);
> +
> +	bp->in_callback =3D true;
> +	bp->next_addr =3D next_addr;
> +	return 0;
> +}

[Severity: High]
How does this interact with CPU-wide hardware breakpoints (such as
perf record -a)?=20

If the currently running task migrates to another CPU before reaching
next_addr, does the original CPU get permanently stuck waiting for an
instruction it will never execute, effectively losing the CPU-wide
breakpoint?

[ ... ]
>  static int hw_breakpoint_handler(struct die_args *args)
>  {
[ ... ]
> +		if (bp->in_callback) {
> +			expecting_callback =3D true;
> +			if (args->regs->epc !=3D bp->next_addr)
> +				continue;

[Severity: High]
If execution diverges before next_addr is reached (for instance, due to an
interrupt, a signal handler, or task migration), args->regs->epc will not
match next_addr. Since the handler just bails out here, is the original
breakpoint permanently lost? Is there a fallback mechanism to recover the
lost trigger?

> +
> +			arch_uninstall_hw_breakpoint(event);
> +
> +			/* Restore original breakpoint */
> +			if (hw_breakpoint_arch_parse(NULL, &event->attr, bp))
> +				goto exit;
> +
> +			if (arch_install_hw_breakpoint(event))
> +				goto exit;

[Severity: Medium]
If arch_install_hw_breakpoint() fails here, we jump to exit without clearing
bp->in_callback =3D false. Will this leave the perf event alive in the soft=
ware
state but corrupted for any future re-enabling?

> +
> +			bp->in_callback =3D false;
> +			bp_ret =3D NOTIFY_STOP;
> +			goto exit;
> +		}
> +
> +		switch (event->attr.bp_type) {
> +		/* Breakpoint */
> +		case HW_BREAKPOINT_X:
> +			{
> +				bool hit =3D bp->address =3D=3D args->regs->epc;
> +
> +				if (!hit && dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONTROL6)
> +					hit =3D mc6_read_and_clear_hit(i) !=3D RISCV_DBTR_MC6_HIT_FALSE;
> +
> +				if (hit) {
> +					perf_bp_event(event, args->regs);
> +					ret =3D setup_singlestep(event, args->regs);

[Severity: High]
Can setup_singlestep() override a synchronous event disablement?

If perf_bp_event() triggers the perf PMU to synchronously disable the event
(e.g., if a sample limit is reached), setup_singlestep() executes immediate=
ly
afterwards. Since it unconditionally sets the enable bits and calls
arch_update_hw_breakpoint(), does this forcefully re-enable the breakpoint =
in
hardware in single-step mode, overriding the request to disable it?

[ ... ]
>  	}
> =20
> -	return ret;
> +	if (expecting_callback) {
> +		pr_err("in_callback set but epc (%lx) not at next_addr (%lx).\n",
> +		       args->regs->epc, bp->next_addr);
> +	}

[Severity: Low]
At this point outside the loop, doesn't 'bp' hold the value of the last
event processed in the array, rather than the event that actually had
in_callback =3D=3D true? Will this output an unrelated next_addr value in t=
he
error log?

> +exit:
> +	return bp_ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930063919.6089=
11-1-himanshu.chauhan@oss.qualcomm.com?part=3D6
