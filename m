Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4C421EE0
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011943; cv=none; b=dnT/BxigePZYd1bqi1wNtyYwt2xcod8Ul35+Lm9iRnKgIKGYDbnIzYL0QSpoRlpbPSbT9dLETQCWiQVAX6irECH+CzFVKl8mGc5KTypnc2CchbxLFWQgJv3/pfJz2aA50iBgU3AOh7hbqvnTvEtC/mvB65YmSQtoemybhPL0WXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011943; c=relaxed/simple;
	bh=iOL4xBRTPVd4VefDrUVOe2DxJ7KfQyBDLwKNuN1+3IU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YrIj06GNoiiEbWPgsGurkz0nf5qFY7gOfBZLhjZkgs75fDv2GQ/nxd7nY9G3uCs4ApbIr5mVoisbgss7PfVbeGxbqdNAxfU38Lc3N1UyWaLLll88PAZbUeiqD+Klf5EJWMau5BdDBT2QGeN3EckaTe+1SDO+vC54t2pR7QSweJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLQgeKDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLQgeKDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595021F00893;
	Tue,  9 Jun 2026 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781011941;
	bh=76uL6pA3+wZNTY6VTp6fnAlbldAi2FwWnB4oO/B+rr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLQgeKDl0MwZk+OzjqLzZlKLsQjPWe6GWDLZF9q1pl2sdM3l3R12D94c6KsrNqATq
	 cKNYD4kTu0kpiY7mTBNP4Xy+cN6yyRhJcTLO8AEY9/igBbednjulshA3UAu3h0uGbG
	 aTzcv+mwIs5pDjxVuIQUSRC44I3KHM9iHOjZkM9lQA055tmxZjPK+/XXvb2bvl0u/y
	 qFy5nYHQuFVze5t5HATXlJrUQqeJXBAoOflFzqiSSVrRhdPdhSa4d6j4fI4njr3rLc
	 F26Z0VqPMwgjo70up7Tf3IEx+38dxJQtuJi5mC7z22OfOa9+TUgMUAtArGhRt6a7nG
	 h2hiJ9xR6oQRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] arm64/hw_breakpoint: reject unaligned watchpoints
 that would truncate BAS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-arm64_bas-v2-1-9f34dbbded88@debian.org>
References: <20260609-arm64_bas-v2-1-9f34dbbded88@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 13:32:20 +0000
Message-Id: <20260609133221.595021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] User-space watchpoints with MTE-tagged addresses incorrectly fail =
validation checks and exact-match detection because tag bits are not stripp=
ed.
- [High] System register writes to debug registers are not immediately sync=
hronized, violating architectural context synchronization rules.
- [High] Unaligned execution breakpoints bypass length validation and are p=
rogrammed into hardware with invalid BAS constraints, corrupting RES0 bits.
--

commit 53ef92756387d64bcb01ab3be39ec7396912b68e
Author: Breno Leitao <leitao@debian.org>

arm64/hw_breakpoint: reject unaligned watchpoints that would truncate BAS

This patch addresses an issue where unaligned non-compat AArch64 watchpoints
could silently truncate the BAS bit pattern when the offset shifted the len=
gth
past 8 bits. The kernel now correctly rejects these unrepresentable length
and offset combinations with -EINVAL, preventing the hardware from watching
fewer bytes than requested.

> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_bre=
akpoint.c
> index ab76b36dce820..73cce8ac83681 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -559,6 +559,15 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>  		else
>  			alignment_mask =3D 0x7;
>  		offset =3D hw->address & alignment_mask;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that MTE-tagged
addresses might not be handled correctly here.

When perf_event_open() is called with an MTE-tagged user-space address,
arch_build_bp_info() saves the address into hw->address without untagging i=
t.

Since hw->address retains the tag, could this cause the bounds check
(va >=3D TASK_SIZE) in arch_check_bp_in_kernelspace() to evaluate to true d=
ue
to the high-order tag bits? This would erroneously classify the user
watchpoint as a kernel watchpoint and reject it.

Additionally, in get_distance_from_watchpoint(), the tagged address
retrieved from the hardware register is used to calculate wp_low, which is
then mathematically compared against the explicitly untagged fault address:

arch/arm64/kernel/hw_breakpoint.c:get_distance_from_watchpoint() {
    addr =3D untagged_addr(addr);
    ...
    wp_low =3D val + lens;
    wp_high =3D val + lene;
    if (addr < wp_low)
    ...
}

Might this cause the distance calculation to silently fail the exact-match
watchpoint heuristic?

> +
> +		/*
> +		 * BAS is an 8-bit field in WCR/BCR; the shift below would
> +		 * silently drop the high bits of ctrl.len when offset + len
> +		 * exceeds 8, programming hardware to watch fewer bytes than
> +		 * the user requested.
> +		 */
> +		if (((u32)hw->ctrl.len << offset) > ARM_BREAKPOINT_LEN_8)
> +			return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does this new check allow unaligned
execution breakpoints to bypass length validation?

For AArch64 execution breakpoints, hw->ctrl.len is fixed at 0xF (4 bits).
If an unaligned address is provided (e.g., offset 1, 2, or 3), the shifted
length becomes 0x1E, 0x3C, or 0x78. Since these are less than 0xFF
(ARM_BREAKPOINT_LEN_8), they bypass this validation check.

When encode_ctrl_reg() executes (ctrl.len << 5), wouldn't these invalid
lengths overflow out of the 4-bit BAS field (bits [8:5] in DBGBCR_EL1)
and overwrite the RES0 bits [11:9]?=20

This would also fail to program the architecturally mandated BAS value of
0b1111, leading to CONSTRAINED UNPREDICTABLE hardware behavior.

>  	}
> =20
>  	hw->address &=3D ~alignment_mask;

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with system
register synchronization in write_wb_reg():

arch/arm64/kernel/hw_breakpoint.c:write_wb_reg() {
...
#define WRITE_WB_REG_CASE(OFF, N, REG, VAL) \
	case (OFF + N): \
		AARCH64_DBG_WRITE(N, REG, VAL); \
		break
...
	switch (reg + n) {
	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_BVR, AARCH64_DBG_REG_NAME_BVR, val);
	...
	}
	isb();
}

According to ARM64 architectural rules, every write to a control-plane syst=
em
register must be followed by an isb() as the very next instruction.

Will the break statement in WRITE_WB_REG_CASE introduce an intervening bran=
ch
between the system register write and the isb() at the end of the switch
block?

Executing an intervening branch before the Context Synchronization Event (C=
SE)
means the branch observes an architecturally undefined pipeline state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-arm64_bas-=
v2-1-9f34dbbded88@debian.org?part=3D1
