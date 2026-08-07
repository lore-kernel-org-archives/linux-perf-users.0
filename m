Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97299318ECD
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118284; cv=none; b=ea1BiPJM6GR1mNQM0X6vBrHMyaVB+0kM5RwWMCP7VqKvGjkyPAAPpK9d48vxXnTZhlwKyX4uOxG4SouJsJf8WrT5uAMo48wkRclrxtsZpxJSYDIsFBE2qbh6mVuK31kraHigJAtOwvKkaWu7fEqIITU1a82JnRiHU5Ut/cDHDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118284; c=relaxed/simple;
	bh=SsPFLj6Z7/GVVlC29m3IxuqlggrMFR6OTguiD/CL/Nk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=us06WTwO4WAvHOq1fXRSHHZqpTt5UMAJv8n6s74evNEZOvfgpGNfBXxBp8qzall7K7kuk7U06lRL8zPjLgcukdootyaUQsHxOAS05q0Mj8CuXqQAmEdiTy3d91RstpmK/HBjq6OXZslJrdTUBJaoRrG7iSlOnfzbkr/DCV6OUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJX7tNvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJX7tNvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06041F000E9;
	Fri,  7 Aug 2026 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118283;
	bh=D4dNnFxWGFwt67McuvkqxhljlKkA4O/6PCtSHM76/ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJX7tNvXENXUH4rrNL/fH1ioQ2n9nmQbP6+czZetYIPXlqCHY6kD6mL0X+lUaoKr3
	 n1vbqrU5uaR7tpiCo7osPlq9PeT7jf8BIrjZU0tRLNQxNwF2YQtbeAVNyryYx+8ACK
	 wZAInciQqkykrv9J/Z0AQn/bP84YgLCQAxc7ram8GRynXPQZS0kQC5/SXg/olWq9To
	 V+wK14DsNqkAMsAzVgQyzTmIFDwXrQ/XOpYd9LcG13Djp0nKm9WJRsUpeFdfYoQNWj
	 3DWrdpp4ci4vxpEXdQVdIk+ZoLOjg8djJgbaucE13PSv0aB9tV2hFvLc/E1vmoDe4c
	 fjt/eQRAFDXcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/11] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178611683120.237811.15904891776099424430.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
 <178611683120.237811.15904891776099424430.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:58:01 +0000
Message-Id: <20260807155802.F06041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Modifying hardware debug address registers (DR0-DR3) while they ar=
e still enabled in DR7 violates the x86 architectural guidelines and can ca=
use unpredictable hardware behavior.
- [Medium] Temporary invalid software state in `bp->attr.bp_addr` before va=
lidation causes incorrect perf samples if interrupted by an NMI.

Pre-existing issues:
- [High] Lockless traversal of `kprobe_blacklist` can lead to Use-After-Fre=
e during module unload.
--

--- Patch [3]: [PATCH v12 03/11] HWBP: Add modify_local_hw_breakpoint_addr(=
) API ---
commit 894126e474a8f66ca7e12e6c727a417646ec68a9
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

HWBP: Add modify_local_hw_breakpoint_addr() API

This adds modify_local_hw_breakpoint_addr() to update the watched address
of an installed hardware breakpoint on the local CPU without releasing and
reserving its hardware slot. It is available when architectures select
HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.

Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf92.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 789add0c185a0..7d3a7bc050a40 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c

[ ... ]

> @@ -888,6 +888,46 @@ void unregister_wide_hw_breakpoint(struct perf_event=
 * __percpu *cpu_events)
>  }
>  EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
> =20
> +/**
> + * modify_local_hw_breakpoint_addr - update a local breakpoint address
> + * @bp: the hwbp perf event for this CPU
> + * @addr: the new address for @bp
> + *
> + * Update only the address of an installed breakpoint on the local CPU w=
ithout
> + * releasing and reserving its hardware slot. The caller must update oth=
er CPUs.
> + * Return 0, or -EOPNOTSUPP if the architecture does not support this op=
eration.
> + */
> +#ifdef CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
> +int modify_local_hw_breakpoint_addr(struct perf_event *bp,
> +				    unsigned long addr)
> +{
> +	unsigned long old_addr;
> +	int ret;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	old_addr =3D bp->attr.bp_addr;
> +	counter_arch_bp(bp)->address =3D addr;
> +	bp->attr.bp_addr =3D addr;

[Severity: Medium]
Could this early update of bp->attr.bp_addr lead to incorrect perf samples?

If an NMI triggers the hardware breakpoint on the old address before the
hardware registers are updated and validated, the NMI handler might lockles=
sly
read the temporarily overwritten bp->attr.bp_addr. Would this attribute the
sample to the new, potentially invalid address instead of the old one?

> +
> +	ret =3D arch_modify_local_hw_breakpoint_addr(bp, addr);

[Severity: High]
Does modifying the hardware debug address register without clearing the DR7
enable bits violate x86 architectural guidelines?

When arch_modify_local_hw_breakpoint_addr() is called for x86:

arch/x86/kernel/hw_breakpoint.c:arch_modify_local_hw_breakpoint_addr() {
    ...
    do {
        seq =3D this_cpu_inc_return(cpu_dr7_seq);
        this_cpu_write(cpu_debugreg[i], addr);
        barrier();
        set_debugreg(addr, i);
    } while (seq !=3D this_cpu_read(cpu_dr7_seq));
    ...
}

Could this cause unpredictable hardware behavior since the Intel manual
dictates that DR0-DR3 should only be modified when their corresponding
enable bits in DR7 are clear?

[Severity: High]
This is a pre-existing issue, but can the lockless traversal in the
blacklist check lead to a use-after-free during module unload?

When parsing the breakpoint, the call chain goes through:
arch_modify_local_hw_breakpoint_addr() -> hw_breakpoint_arch_parse() ->
arch_build_bp_info() -> within_kprobe_blacklist()

kernel/kprobes.c:__within_kprobe_blacklist() {
    ...
    list_for_each_entry(ent, &kprobe_blacklist, list) {
        if (addr >=3D ent->start_addr && addr < ent->end_addr)
            return true;
    }
    ...
}

If a module is unloaded concurrently, kprobe_remove_area_blacklist() deletes
entries and immediately frees them with kfree(). Would a concurrent hardware
breakpoint modification dereference freed memory here since kprobe_mutex
is not held and RCU protection is not used?

> +	if (ret) {
> +		counter_arch_bp(bp)->address =3D old_addr;
> +		bp->attr.bp_addr =3D old_addr;
> +		return ret;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178611679753.237811=
.10190793347982785419.stgit@devnote2?part=3D3
