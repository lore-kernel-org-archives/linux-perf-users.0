Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CEE2F877
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321634; cv=none; b=XKFCaAWosWo6bRCYBojos6t/pGr0Uq6sG+43TDSaTf1R37V5mCWoQEazoG8K63APcJFAuZQ6UXh1KfeQuUpyeU2r7q8tQRSs5I7AAOvgamUgKAO5y9Myiqoai7DnsH2Icd05d+47hJGvpMafbiScPmb/Xi73Mr0/CsvydeStn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321634; c=relaxed/simple;
	bh=vInHxOUpkqrGYsaG/py3NaAKtWS74DcT2BcOxRpawGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRB+oqOlINUziAgDh2YmBDqfoxcX7pmlswMbacQmDIQ0W+nQ8HEBrYlvsvUG5b9IluZ8eZho5y/H4rf4ZwQZ1brGsX6bwekDkbA7qKjhr9VlS2JV2K/YJEM9RS+5CfVj4ZsYaXE4MlPj8fGbFtSu98QoPWcpIfIdjziRDMJ0rro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fH9Q7jub; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fH9Q7jub"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8076ebb7ba1so38911239f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721321631; x=1721926431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9zJZZ9bWEPMAlkC/QkLHGli62aQv2OdpuoT4H3F0l2Y=;
        b=fH9Q7jubu9pttrJr3gDgLWdMqd6B4/r0CfLDqSy2C++4NAYUnaWi94IyNeWwJ41S/l
         /ZQX7iTAHlm0DvA3b2P4WKQ5Po6A7QdLJyoaxOSeLnfPgS/+bP6nIFGqb9Jguh+atylp
         ZBF8RG8N4LUx0+et8Hrsl+jtI3Ddo6b7YHq7CNti9Evq+8PfCTOeFaI0doLq5DvI7gkL
         62EdfKH+L3sVP0NNJRKPMKx19smiu//FpQzjHdlpb5Y82ZqqC4xf8J5WvG97/XP/Vcfh
         jiWAqnIMasX9veo7y6uA7mU86M/Bw8OOfFQWLjkIeg2DLDfjM0W6gqpzdhyuW0XQIkuX
         FQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321631; x=1721926431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zJZZ9bWEPMAlkC/QkLHGli62aQv2OdpuoT4H3F0l2Y=;
        b=f4tWPfuNnNzx5mGrs/AkuDPwOWF20VrrWgTM6wXdkW6Yrf4LZKKDAkxd/5OQySVcb1
         BvYEGj13p3ZJddke91+y0X/2Sr2kkhqP+31PYM/QrlkoTfFYqMjRqpXxt12H+lBrUmis
         K3Rd11BTD2tYDeuHWYSacJ91eiQiEuNyYcD8OYQb2V2mX+x1RbZWJKspdKS96sC3NQn/
         4gwXoOWFI0UxfjTx6d+gbzJ1QSgKrcQSuhcMefvqHYDCQ8Zp8OnjA7c6a/THI4VsnZBz
         K5LbnRzVvUaRQ2ghwnsZUHLGERXSB7hfSkNIiP/OPGZw3rx7izYtus0eLYWO2b9y3pYM
         jSdw==
X-Forwarded-Encrypted: i=1; AJvYcCXK2vFNDizAWyUvZ9QlyGTFqIH6zXzubVkFljKjbwnrY8SPAgYHoyc1wa5nGlcpcOA6Md8QYnYnCR0RDipM/uEau+B7il68wkram7bAkybkZA==
X-Gm-Message-State: AOJu0YwmNja4o0/SGHBbXqLb1l0igKF+hWLSM3IgmIG9ob8vCIUSIMDj
	i+HxRQbIOGFyEOVT8BJwVSUkoplnvf/2UQtwO9ll0Qos56uLWgUoQpfoWBz9gNs=
X-Google-Smtp-Source: AGHT+IFngzTW8EHtTFvx7omE0v/qG3WhmjLl/7uA05MsoNd2N82RVXCmEyfoWoRu19pmQ31JPxhJiA==
X-Received: by 2002:a05:6602:1605:b0:7f9:beb8:7952 with SMTP id ca18e2360f4ac-81711e19b10mr820491439f.13.1721321630783;
        Thu, 18 Jul 2024 09:53:50 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210f24b6fsm1606088173.94.2024.07.18.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 09:53:50 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:53:49 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org
Subject: Re: [PATCH 1/2] riscv: perf: add guest vs host distinction
Message-ID: <20240718-e689be134be5b958b1eec65a@orel>
References: <cover.1721271251.git.zhouquan@iscas.ac.cn>
 <8e2d2f60fc30d64b6c69b38184a1b640c7b30003.1721271251.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e2d2f60fc30d64b6c69b38184a1b640c7b30003.1721271251.git.zhouquan@iscas.ac.cn>

On Thu, Jul 18, 2024 at 07:23:41PM GMT, zhouquan@iscas.ac.cn wrote:
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
> index 665bbc9b2f84..5866d028aee5 100644
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
> +extern unsigned long perf_misc_flags(struct pt_regs *regs);
> +#define perf_misc_flags(regs) perf_misc_flags(regs)
> +
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \

Arm has this outside the #ifdef CONFIG_PERF_EVENTS, but it doesn't
look like it should be.

>  	(regs)->epc = (__ip); \
>  	(regs)->s0 = (unsigned long) __builtin_frame_address(0); \
>  	(regs)->sp = current_stack_pointer; \
>  	(regs)->status = SR_PP; \
>  }
> +#endif
> +
>  #endif /* _ASM_RISCV_PERF_EVENT_H */
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index 3348a61de7d9..c673dc6d9bd2 100644
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
> +unsigned long perf_misc_flags(struct pt_regs *regs)
> +{
> +	unsigned int guest_state = perf_guest_state();
> +	int misc = 0;

Should use unsigned long for misc.

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
