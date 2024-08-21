Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F891531F4
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Aug 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244495; cv=none; b=t5j9rcYVUcniOwLbHLcfo2pgLOPfUPtEHabrcBArH2tKeNwslTgat6FVq772Bm9/BbFHJ5Li6sYJkvHrNiW5QUFV862OBfHVLuY+Txe5XfPrgoTY3HAN6Db1xebB7MXEcAWwtpIhnj0B1kKpFIni3tiPHagK9cPMdhgeIQDGl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244495; c=relaxed/simple;
	bh=NZ1G9QalOD4q3lb9VPf4Bnu2xhhNbO2CqFkeuFlGODE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN8pD58UVOkR8Qv3uNuT1hLfHanT0BSVEUDa6EjbmDZyEPB7lAmdq5s/3pgw2JWPbpr2dOQAapULXCWZggQUZh2JEhMYYdx8txeoabiGnECrfjZ6hmtcl1AmoC0IcEa9sJXuBts9CTeNA9kXxabR1FsI6NLww3czSquv7Kk4bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fmFZKt4+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fmFZKt4+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bef4d9e7f8so4569555a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Aug 2024 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724244492; x=1724849292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=owctU5UF/MrOqJiKH/wjLFTDxdDZZM8Or/kAuo7tn/8=;
        b=fmFZKt4+Qe2zrlQ78EPEHtw4+LNl0jGtLwxC1fRFSYjbLlGiQYy7Ov1kgXh0v1wg3I
         9Wd5dFG8cm9pieAnqIpk2hMi447YX9ukGvM+qxnlyiRXxZE/whESXAsIxmpB+8epoil+
         mebb9OeVklrCTYLLi/V/QRPIyDxycjZaPqkHW2YgL6ukFCzDdn95FjuRtzv29VZh72S6
         WgbGu2/sMSsrb6dHPHIoozavjlQWE3VwthvDh+c8z2fQ5DNrYQgBkXGeK0zZsRumDDFT
         s9JpTI3U81NOZWNcTXHyNtE/NydCXRGbqOCsFJcpeluDJ5+/sE9qLnWfXVPOmM5G/JKA
         IxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244492; x=1724849292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owctU5UF/MrOqJiKH/wjLFTDxdDZZM8Or/kAuo7tn/8=;
        b=ZYxwhYPY8gecGftDuHWKtMOoXE/bf/cVrYt+pOG9uMpf9bV54PCECBCAal2MElq0Aa
         rIe+ej5F84fk7typgoiNapoJTD5v2JTd+4/t6psdbcjFr23HCKDIxefnCbs0RN6vNwyO
         jQ55DgdqtrMjtS5MiGVvl4JzGAyMYMiZhIZ2Omnl5/XDrk9fIr8Hr2xrHRoCRr6ITWsc
         urRyWTEbkJGZuHGVzlJUzu/O+fF9sEAyrVM8ZedUFzRs0MiZ2i92il2oMXuLOqt2hycB
         5bXOooV9T3t3LgeV+V78RKcrUItQORz8NK6CjP8b6q/glFhZCPvpLJ6vv7RNzmk+YaAL
         5EHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVatYJq0VLOjoqPfIU8/B/vNFm6FdnPgHURqkXBwKpJsyn+FZmbSN6wUjtErrdvixSfbtxy5NhyIe1ZepIm0n9Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwGaAsGc6kILdkABlIK2jnwSTVZmDwWMef8vbLm7nZCR5p2iA1N
	siSAqY+UkwfkyGty1bHCclDPpgWpJZoicwcXLbB30xq3vkArzjqxowcBWUM78a9OLB1LDn5+ALH
	qxiM=
X-Google-Smtp-Source: AGHT+IEBHJpECbZj9IKLd7v7eqsKAcU06neT/8vBwwygqFiwFCmvnkErVfPeY9IwiKfaKQItm4XXxw==
X-Received: by 2002:a17:907:a41:b0:a7d:3de1:4ab2 with SMTP id a640c23a62f3a-a866f3616a2mr165794866b.27.1724244491373;
        Wed, 21 Aug 2024 05:48:11 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c69easm901792366b.40.2024.08.21.05.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:48:10 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:48:10 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: perf: add guest vs host distinction
Message-ID: <20240821-f5e1d6afb0d2230c1256a75b@orel>
References: <cover.1723518282.git.zhouquan@iscas.ac.cn>
 <3729354b59658535c4370d3c1c7e2f162433807b.1723518282.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3729354b59658535c4370d3c1c7e2f162433807b.1723518282.git.zhouquan@iscas.ac.cn>

On Tue, Aug 13, 2024 at 09:23:54PM GMT, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Introduce basic guest support in perf, enabling it to distinguish
> between PMU interrupts in the host or guest, and collect
> fundamental information.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/perf_event.h |  7 ++++++
>  arch/riscv/kernel/perf_callchain.c  | 38 +++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index 665bbc9b2f84..c2b73c3aefe4 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -8,13 +8,20 @@
>  #ifndef _ASM_RISCV_PERF_EVENT_H
>  #define _ASM_RISCV_PERF_EVENT_H
>  
> +#ifdef CONFIG_PERF_EVENTS
>  #include <linux/perf_event.h>
>  #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
>  
> +extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
> +extern unsigned short perf_misc_flags(struct pt_regs *regs);
> +#define perf_misc_flags(regs) perf_misc_flags(regs)
> +
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \
>  	(regs)->epc = (__ip); \
>  	(regs)->s0 = (unsigned long) __builtin_frame_address(0); \
>  	(regs)->sp = current_stack_pointer; \
>  	(regs)->status = SR_PP; \
>  }
> +#endif
> +
>  #endif /* _ASM_RISCV_PERF_EVENT_H */
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index 3348a61de7d9..7af90a3bb373 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -58,6 +58,11 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  {
>  	unsigned long fp = 0;
>  
> +	if (perf_guest_state()) {
> +		/* TODO: We don't support guest os callchain now */
> +		return;
> +	}
> +
>  	fp = regs->s0;
>  	perf_callchain_store(entry, regs->epc);
>  
> @@ -74,5 +79,38 @@ static bool fill_callchain(void *entry, unsigned long pc)
>  void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
>  			   struct pt_regs *regs)
>  {
> +	if (perf_guest_state()) {
> +		/* TODO: We don't support guest os callchain now */
> +		return;
> +	}
> +
>  	walk_stackframe(NULL, regs, fill_callchain, entry);
>  }
> +
> +unsigned long perf_instruction_pointer(struct pt_regs *regs)
> +{
> +	if (perf_guest_state())
> +		return perf_guest_get_ip();
> +
> +	return instruction_pointer(regs);
> +}
> +
> +unsigned short perf_misc_flags(struct pt_regs *regs)

I see that the consumer of perf_misc_flags is only a u16, but all other
architectures define this function as returning an unsigned long, and
your last version did as well. My comment in the last version was that
we should use an unsigned long for the 'misc' variable to match the
return type of the function. I still think we should do that instead
since the function should be consistent with the other architectures.

> +{
> +	unsigned int guest_state = perf_guest_state();
> +	unsigned short misc = 0;
> +
> +	if (guest_state) {
> +		if (guest_state & PERF_GUEST_USER)
> +			misc |= PERF_RECORD_MISC_GUEST_USER;
> +		else
> +			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
> +	} else {
> +		if (user_mode(regs))
> +			misc |= PERF_RECORD_MISC_USER;
> +		else
> +			misc |= PERF_RECORD_MISC_KERNEL;
> +	}
> +
> +	return misc;
> +}
> -- 
> 2.34.1
>

Thanks,
drew
