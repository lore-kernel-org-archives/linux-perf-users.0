Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C443793D0
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762763; cv=none; b=DXI4Cu4XmIC221z1LGzrCt6GssQpMOvjADppAbTBkBQsbr7KD9cktcieXOLD0e380vpvPujssJHVhP6B/nA7rkDL/8pfHbSJvKvhxigK+40gnH7qGVrbL3ZNrcaqxMV6GlyHeq0Pkf+6K7GnN7qTa7NxY1TPtBePK1MnbPPnnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762763; c=relaxed/simple;
	bh=AqZC8SozR/PqfDgdfZtoONmHrk5+WCzTOGKJyDIQmOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P2WeHXdUJjdYis9lVyCbSUrPOmOTt8byts3DisLo+GKLiNR0CCmiMz9hvehOzIjUUHyYRml91JBU+nrW+6ptHprazkmMAyVZYEkP5aI+WAhxcWhe3Ph/t16W4mgZUzDz+wlNEx+9ISjKyvV9IcNJjtKIbo980oiYQohY7mvJW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU8WR4mU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU8WR4mU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D366D1F000E9;
	Wed, 22 Jul 2026 23:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762762;
	bh=B05SjCvPhDt7ZcsdCwgGIeWa7jKysag9WrgLv6jwaCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iU8WR4mUXV1EPNn6iLwYmhNjdwiPzMHwT6TVVOLSx7k5v642GwFAQuDQfH4jYQgcf
	 nORTjupIf+0hajm+RJa7XVg4JstXOVucQNf/DuZ9VJgrvES5uDBtGkmSJecyShZq6q
	 /9zN44ZcyCYRMpbzabRWgqlkBeKtikenRHClPPGa+wcpb9IvRchknqYgt6wgha8U0r
	 5KK/Cgr7taHZzt4O5n7tOFyVFvareNUgbg0pomz53mmggypop1L0EAUt1bvKUBFQq+
	 01LJjpU84VHY4bPozRRgJTbl1TplA4ZS+mraL8CdogHlhAcUCG7F1OuGZkaESJLYJs
	 3MNMqzB5uJHlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/11] x86/hw_breakpoint: Unify breakpoint
 install/uninstall
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178476140665.26117.10482752209138090031.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
 <178476140665.26117.10482752209138090031.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:26:01 +0000
Message-Id: <20260722232601.D366D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Spurious debug exceptions due to modifying DR0-DR3 while enabled i=
n DR7.

Pre-existing issues:
- [High] NMI race condition during breakpoint uninstallation leaves the har=
dware breakpoint permanently enabled.
--

--- Patch [5]: [PATCH v10 05/11] x86/hw_breakpoint: Unify breakpoint instal=
l/uninstall ---
commit 68cc4a145838d44957bc67ccfa580a6107987aa3
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoint: Unify breakpoint install/uninstall

Consolidate breakpoint management to reduce code duplication.
The diffstat was misleading, so the stripped code size is compared instead.
After refactoring, it is reduced from 11976 bytes to 11448 bytes on my
x86_64 system built with clang.

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index f846c15f21ca1..c323c2aab2af9 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> +static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool e=
nable)
> +{
> +	unsigned long dr7;
> +
> +	set_debugreg(info->address, slot);
> +	__this_cpu_write(cpu_debugreg[slot], info->address);

[Severity: High]
Does this code introduce a spurious debug exception when uninstalling a
breakpoint?

When uninstalling (enable =3D=3D false), the debug address register is modi=
fied
here, but its corresponding enable bit in the hardware DR7 register is still
active. According to the Intel SDM Volume 3 (Section 17.2.4), modifying
DR0-DR3 without first clearing the corresponding enable bits in DR7 is
forbidden. The old implementation bypassed modifying DR0-DR3 on uninstall,
which avoided this issue.

> +
> +	dr7 =3D this_cpu_read(cpu_dr7);
> +	dr7 &=3D ~(__encode_dr7(slot, 0xc, 0x3) |
> +		 (DR_LOCAL_ENABLE << (slot * DR_ENABLE_SIZE)));
> +	if (enable)
> +		dr7 |=3D encode_dr7(slot, info->len, info->type);
> +
> +	/*
> +	 * Enabling:
> +	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
> +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	if (enable)
> +		this_cpu_write(cpu_dr7, dr7);
> +
> +	barrier();
> +
> +	set_debugreg(dr7, 7);
> +
> +	amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
> +
> +	barrier();
> +
> +	/*
> +	 * Disabling:
> +	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
> +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	if (!enable)
> +		this_cpu_write(cpu_dr7, dr7);

[Severity: High]
This is a pre-existing issue, but does this sequence create an NMI race
condition that could leave the hardware breakpoint permanently enabled?

When uninstalling, this code writes to the hardware DR7 register first
(set_debugreg(dr7, 7)), issues a barrier, and then updates the per-CPU
tracking variable (this_cpu_write(cpu_dr7, dr7)).

If an NMI (like SysRq-G for KGDB) fires in the window between these writes,
the NMI handler (such as kgdb_correct_hw_break()) will call
hw_breakpoint_restore(). This reads the stale cpu_dr7 (which still has the
slot enabled) and writes it back to hardware DR7, re-enabling the
breakpoint.

When the NMI returns, setup_hwbp() continues and writes the disabled state
to cpu_dr7 in memory, but the hardware DR7 is left enabled. If the
breakpoint triggers later, hw_breakpoint_handler() will see a NULL
bp_per_reg and could enter an infinite #DB loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178476134787.26117.=
10094977293012760490.stgit@devnote2?part=3D5
