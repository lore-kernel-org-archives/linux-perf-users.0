Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511876;
	b=kKvHoF8YCHah/vqmJuPyutmfXAVmbCMxeBZqvlqmcWp56+sjp9mjzQxKuC1iHJbp52yj
	 WGwhAFcppmPfVa1m8+QINZBr9PmEm7iUOuB3RxwiXiDo7LCGUN9t3FZsIYX3AoG40Iy3I
	 it12VHkGzX7rxL2nLOarZIKoBAGFfw04RetIWJesP+0Es2LPpojZPsp2QZs3CuviW+rVJ
	 GWx3acAGsXUDhpVXRQn7QBXRw5yEmZCelLz0QxaiflQzm2fcSq61zC/jf4ZM1MaYM2qxm
	 VEJbXSjFRPD9LfNUovG6N4iSYn5CeEduANSC5/asrdt5IFmsrxOo7YAbEcumI7RmisQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2NGO1LnVW3xlbqQkICEqXPMwGziTnOLxnmBBrlAkGVM=;
	b=nVVuacXk5mzly6UeXmc/V0VoyZTePAAcSBg0jlPPnA1xEr66kKNBajef/PPBDJj/iucZ
	 495HM96vqv6jgZ3ZitI9O7vG8HWuQ3rVGHiJSKSbET6MYYp06gEjczkCoMGS/IKOXJ9w6
	 1T35DM6GjH0vW+t119xmqgNPzkndF4UuaGE+ucB2dkaIIONNohhd1T2dqAY+LfVYDHLJj
	 if+Vfk/g/tmJ4j2qUTUYRJvH2oSXpl1EdBwNha7/dNsMlLqCBl3KCV48s/irVKl5y5eWt
	 8HQDdNLC8MBKftZwrAHphfBEhs6uR6+PZW6Vp7ArrHG/hqCJuA/njX2OqV7OjassPAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZR6dDKK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5761606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZR6dDKK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF4C1F000C6;
	Thu, 12 Nov 2026 19:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511875;
	bh=2NGO1LnVW3xlbqQkICEqXPMwGziTnOLxnmBBrlAkGVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZR6dDKKPAfyMj5SIUDsb7Bh3flfVFsk/nsZu+Vwsrt04xe9dolllif0U3QBah0bR
	 0ztKsw6vrL57mTnGxyd9gBe7w0kz3RKKZDANUqIhyhqdnRI8IYnJEraqQyBxUZqqRU
	 MP9+fCbqOuVVWzXGdTJQk4YDybf4wzh8iLP0zbM+0N18wtEX4cciLDVqC+NMR9dq3f
	 Bp1zaZoiSVrRT7wQxLDJ6RNdRNgIpVCwHA6HJE39hnBQlISxYIYr8WzfbksC2aGffp
	 uXAMePxrmnflhYJag+CmJy3Kz4dD+0poTpLWK6LY+6/c480xiUiz4C/EU5IJfPjqkd
	 NEReXIdJelkkw==
Message-ID: <sashiko-outbox-211767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] MIPS: perf: Add SB1 userspace callchain unwinding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261112190916.3725141-3-f.fainelli@gmail.com>
References: <20261112190916.3725141-1-f.fainelli@gmail.com>
 <20261112190916.3725141-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 19:31:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] MIPS: perf: perf_callchain_user() clobbers
  current->thread.cp0_baduaddr
--

commit d44d716d25b2c4b55ac95b94fe0bbc43afc39a94
Author: Florian Fainelli <f.fainelli@gmail.com>

MIPS: perf: Add SB1 userspace callchain unwinding

This commit adds in-kernel userspace callchain unwinding for SB1 and SB1A
CPUs by scanning function prologues prior to the sampled PC.

> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
> index 5d7a9c03903b5..811ac8f03cabd 100644
> --- a/arch/mips/kernel/perf_event.c
> +++ b/arch/mips/kernel/perf_event.c
> @@ -13,15 +13,113 @@

[ ... ]

> +/* Best-effort prologue unwinding, as provided by the former MIPS OProfi=
le. */
> +static bool sb1_unwind_user(struct sb1_user_frame *frame)
> +{
> +	unsigned long pc =3D frame->pc, caller =3D frame->ra;
> +	unsigned int frame_size =3D 0, ra_size =3D 0, ra_offset =3D 0, n;
> +	union mips_instruction insn;
> +
> +	/* SB1 has neither MIPS16 nor microMIPS instructions. */
> +	if ((pc & 3) || (frame->sp & 3))
> +		return false;
> +
> +	for (n =3D 0; n < 128 && pc >=3D sizeof(insn); n++) {
> +		pc -=3D sizeof(insn);
> +		if (copy_from_user_nofault(&insn, (void __user *)pc, sizeof(insn)))
> +			break;

[ ... ]

> +void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
> +			 struct pt_regs *regs)
> +{
> +	struct sb1_user_frame frame =3D {
> +		.pc =3D sb1_user_address(regs->cp0_epc),
> +		.sp =3D sb1_user_address(regs->regs[29]),
> +		.ra =3D sb1_user_address(regs->regs[31]),
> +	};
> +
> +	if (current_cpu_type() !=3D CPU_SB1 && current_cpu_type() !=3D CPU_SB1A)
> +		return;
> +	do {
> +		if (perf_callchain_store(entry, frame.pc))
> +			break;
> +	} while (sb1_unwind_user(&frame));
> +}

[Severity: Medium]
Can perf_callchain_user() clobber current->thread.cp0_baduaddr while an
interrupted process-context usercopy is recovering from a fault?

On MIPS, raw_copy_from_user(), raw_copy_to_user() and __clear_user() run
with hardware interrupts enabled.  When a kernel-mode user access faults,
__do_page_fault() (or do_ade()) runs fixup_exception() and stores the
faulting address in current->thread.cp0_baduaddr:

arch/mips/mm/fault.c:__do_page_fault() {
    ...
no_context:
	/* Are we prepared to handle this kernel fault?  */
	if (fixup_exception(regs)) {
		current->thread.cp0_baduaddr =3D address;
		return;
	}
    ...
}

If a perf interrupt fires before the usercopy fixup handler reads
THREAD_BUADDR (current->thread.cp0_baduaddr) and get_perf_callchain()
walks the user stack of the interrupted user task, a fault in
copy_from_user_nofault() inside sb1_unwind_user() overwrites
cp0_baduaddr:

raw_copy_from_user()
  <page fault on user address>
  __do_page_fault()
    fixup_exception(regs)
    current->thread.cp0_baduaddr =3D address;
  <hardirq>
    ...
      get_perf_callchain()
        perf_callchain_user()
          sb1_unwind_user()
            copy_from_user_nofault()
              <page fault on unmapped user page>
              __do_page_fault()
                fixup_exception(regs)
                current->thread.cp0_baduaddr =3D address;
  .Ll_exc:
    LOADK t0, THREAD_BUADDR(t0)  <-- reads clobbered cp0_baduaddr
    SUB len, AT, t0

In _inline_copy_from_user(), the bogus residual byte count returned by
raw_copy_from_user() is then passed to memset(to + (n - res), 0, res),
corrupting kernel memory out of bounds or leaving uncopied bytes
unzeroed.

Saving and restoring current->thread.cp0_baduaddr across
perf_callchain_user() would avoid corrupting an in-flight usercopy fixup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112190916.3725=
141-1-f.fainelli@gmail.com?part=3D2
