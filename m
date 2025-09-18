Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21321171B;
	Thu, 18 Sep 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203770; cv=none; b=Tm2xSEHsmTNR1CR858hm1SuaaKuDWLjNWCiF8L4jQ8pELoYxlpGFTlo67W39WeY9P0HvfRJ2Ef6BzpFIgMoZiaFAGx0j6X+KkUtyX8PusqZZKBgpQuh/CQ55A9KrvoRdzrP/R5VXAyM5bnqnOmyX2ZFzgG7XilYaDWdbPu1BkyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203770; c=relaxed/simple;
	bh=n/4EokD9hrq6wOwGpjCNBcaGHdWSqutIjrYBe9DGy5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL6hVS15d4cJSrgwj6Mfiq940F3YA6EoFmLKkDCumjAOuT6H8/YAr63XgYePbw21hi6NNVVZMjBdvojRx+Fd9bsQ9+q3TMX3E6VSeiqxDbNQDhuVPb6xCCWfTP46E94gijj8a5U5F3PpRHjSbWiTBy/ryyZOPh5oLf9EEkSrwOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unr1a0dI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unr1a0dI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D32C4CEEB;
	Thu, 18 Sep 2025 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758203770;
	bh=n/4EokD9hrq6wOwGpjCNBcaGHdWSqutIjrYBe9DGy5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unr1a0dI1XkUERZibvwh6MxKlgZtzWd455FU9er7iRjsh3Z0Vnz0IQ5ajQ7JTUg9b
	 vpLK8rQBv461QBDHifL1zyqv1a3dn7+/2S5BqYsdCqMISdsQnL+rTkDHyty5zt2Hj9
	 3ZwzqlKLMVxd69EUCyg9hy+TT1fvsrTPHbRKp4uSgReEsEbk05XOwR39/YF8GM4HBY
	 U0SW7EK8yXupqzla7pHSxG5TmeIhuB+krj7klezhj5f/rgBnLE3Exk8yIzO4AKxRIa
	 TTVZFl2spd43W15AHyvct+8CdBQhTtPYRalR0oyiv9DbpPJMEyvLTM1y9cSQ4ap/wo
	 NxVy/FfopCT8A==
Date: Thu, 18 Sep 2025 14:56:03 +0100
From: Will Deacon <will@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] arm64: probes: Add GCS support to bl/blr/ret
Message-ID: <aMwPc8AK3J_IJgPG@willie-the-truck>
References: <20250825033421.463669-1-jeremy.linton@arm.com>
 <20250825033421.463669-5-jeremy.linton@arm.com>
 <90c78c6d-2e73-44a6-b933-779477d15745@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c78c6d-2e73-44a6-b933-779477d15745@arm.com>

On Thu, Sep 18, 2025 at 07:54:12AM -0500, Jeremy Linton wrote:
> On 8/24/25 10:34 PM, Jeremy Linton wrote:
> > The arm64 probe simulation doesn't currently have logic in place
> > to deal with GCS and this results in core dumps if probes are inserted
> > at control flow locations. Fix-up bl, blr and ret to manipulate the
> > shadow stack as needed.
> > 
> > While we manipulate and validate the shadow stack correctly, the
> > hardware provides additional security by only allowing GCS operations
> > against pages which are marked to support GCS. For writing there is
> > gcssttr() which enforces this, but there isn't an equivalent for
> > reading. This means that uprobe users should be aware that probing on
> > control flow instructions which require reading the shadow stack (ex:
> > ret) offers lower security guarantees than what is achieved without
> > the uprobe active.
> > 
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >   arch/arm64/kernel/probes/simulate-insn.c | 44 +++++++++++++++++++-----
> >   1 file changed, 35 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> > index 09a0b36122d0..97ed4db75417 100644
> > --- a/arch/arm64/kernel/probes/simulate-insn.c
> > +++ b/arch/arm64/kernel/probes/simulate-insn.c
> > @@ -13,6 +13,7 @@
> >   #include <asm/traps.h>
> >   #include "simulate-insn.h"
> > +#include "asm/gcs.h"
> >   #define bbl_displacement(insn)		\
> >   	sign_extend32(((insn) & 0x3ffffff) << 2, 27)
> > @@ -49,6 +50,21 @@ static inline u32 get_w_reg(struct pt_regs *regs, int reg)
> >   	return lower_32_bits(pt_regs_read_reg(regs, reg));
> >   }
> > +static inline int update_lr(struct pt_regs *regs, long addr)
> > +{
> > +	int err = 0;
> > +
> > +	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
> > +		push_user_gcs(addr, &err);
> > +		if (err) {
> > +			force_sig(SIGSEGV);
> > +			return err;
> > +		}
> > +	}
> > +	procedure_link_pointer_set(regs, addr);
> > +	return err;
> > +}
> > +
> >   static bool __kprobes check_cbz(u32 opcode, struct pt_regs *regs)
> >   {
> >   	int xn = opcode & 0x1f;
> > @@ -107,9 +123,9 @@ simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
> >   {
> >   	int disp = bbl_displacement(opcode);
> > -	/* Link register is x30 */
> >   	if (opcode & (1 << 31))
> > -		set_x_reg(regs, 30, addr + 4);
> > +		if (update_lr(regs, addr + 4))
> > +			return;
> >   	instruction_pointer_set(regs, addr + disp);
> >   }
> > @@ -129,21 +145,31 @@ void __kprobes
> >   simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs)
> >   {
> >   	int xn = (opcode >> 5) & 0x1f;
> > +	int b_target = get_x_reg(regs, xn);
> 
> Ugh, I was staring at this set and realized that this type is wrong, it
> should be 'long'. I will send a patch once I sanity check it on something
> that isn't a model.

Thanks. I'm happy to add fixes on top of what I've already queued, so
please fire away.

Will
