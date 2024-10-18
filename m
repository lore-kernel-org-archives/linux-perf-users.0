Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C47205AA3
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281330; cv=none; b=axsBo3uVE5v1SAQ4K58hZImmXlOWNBTEsWq9j5qPCcd2WvE9l+snpXSmpL/t6icSKlikxhHDSpuQtvapFaDJfTWPCNOHU/dq1idVAHtd66zGm6MutvEvTz4iggysROkqxYP39eA8ah0tQpGmgPr5j/ZPC9DqvhnpYuM3ZEsqvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281330; c=relaxed/simple;
	bh=RmylGS6Qr0WvETJPAnY4axDK5fjypcsmHzFNSYzPXwI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=OMhsVWYcc5A7dV8LgWhLIc1Z3gXwPfLQ5rE4HbGXaaaNb/jvhiNBXfh0xaWEX8D76zrsScrUNOzTEH4BrwiocyPmsgS5LXgDU2TauD9enEjDUzlwsWdnMZd5/M+VjnoMUTdgHe43TxY2j8A6v9oGt13mEtkn5pJVY6H9At6yCvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=o5OkhPZT; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="o5OkhPZT"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-28854674160so1181222fac.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729281326; x=1729886126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7oEArfVPSnqpsijZaXynZDVD27FkpdWWYcqDGTZCjw=;
        b=o5OkhPZTZVX9QIbbxwdcFBp9AstGQ2SXYC+eJMtL11/6HiRMNwEaYwQybKmRBKRJSi
         zF7D4xwyHLasBXhJcpoc+wByEV/zxfmToOZONXtF8NxTynZcqlseWkMi400hkNYAdYce
         9Wp0HFhz7xvQpKJZrH5ohUp6fnxmEOW5HfpHnAPwlnSpRmL/20vL4tdU6LB3RhfReWBL
         Ls9ZcWX6ig2QIymlCB3lGhUkpC/Yq7mbmsa5cVtGWGTcTmDHqEq2EOnvIxVDCr+0H9eJ
         F7cBRInIWzlwQli9cSvDNZywnVCIrS1r8OwHqnebgL8SWEWQsoVRySoJXMdADDU62d0O
         NznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281326; x=1729886126;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7oEArfVPSnqpsijZaXynZDVD27FkpdWWYcqDGTZCjw=;
        b=U+ybYX9SCJVPiT5eyx41WiU/nUvBsY0fT202legx/ZL92NYGQpMjLEebxFHrUTaCjT
         CKyOAInBGkZ5cE8Fji2yrMJch89rjC+WTrmLwrQ3v6ATVdBWFIJREVzpWLkMtthFEddY
         KLze/3dqR9WiLJy91vaJxvrTJizhlrtCbdGv1S8K8rKPYAriTXCldgwLNZBvH99CJKb8
         4m9uFSTKoiODFF8G8FyBnzjm5Goakc9cbXa6XNK6JTb5DXkQ8wpg+ZJkjGTdHUtK6s6w
         EWgbBqte0+5I/xVPWDhxoaQIHDPfalcTPJt53fjZSpxigQsbW+GAot5I9kfszQjypkwv
         /3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOErBNKvgAF7aTqyIJ4N2HEBmuL11XmgOzFuKzZpEIP9B0wwIIR0qqje/dcxQX+htTmyoqfDqkjlY7GA9X+Snc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5BQAV4qRRYuhGF1S+CmNOq4bgFFPZGJIj7/Vjc9VuXNDdF0Qr
	LyY4Qb4vEdFQ/KdYvQSRQ0vTQDbqp0A225QXnn1TXlD/o0btaxENx4fBHM8oTlM=
X-Google-Smtp-Source: AGHT+IGY1tzB8tvAIhD1Nhz0GdPFPRb4Y+29JKXvh/Pt6G+JZiqk0pPm8ialvF1A0Tuv6DdzKtllhw==
X-Received: by 2002:a05:6870:82a0:b0:277:d360:8971 with SMTP id 586e51a60fabf-2892c549c2amr3875076fac.43.1729281325632;
        Fri, 18 Oct 2024 12:55:25 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc226816sm1742765a12.24.2024.10.18.12.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 12:55:25 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:55:25 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2024 12:55:21 PDT (-0700)
Subject:     Re: [PATCH v5 1/2] riscv: perf: add guest vs host distinction
In-Reply-To: <a67d527dc1b11493fe11f7f53584772fdd983744.1728980031.git.zhouquan@iscas.ac.cn>
CC: anup@brainfault.org, ajones@ventanamicro.com, atishp@atishpatra.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Mark Rutland <mark.rutland@arm.com>,
  alexander.shishkin@linux.intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
  linux-perf-users@vger.kernel.org, zhouquan@iscas.ac.cn
From: Palmer Dabbelt <palmer@dabbelt.com>
To: zhouquan@iscas.ac.cn, Marc Zyngier <maz@kernel.org>
Message-ID: <mhng-c9ba919e-b4a4-4bb9-bdba-f4d3295a930b@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 01:42:50 PDT (-0700), zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> Introduce basic guest support in perf, enabling it to distinguish
> between PMU interrupts in the host or guest, and collect
> fundamental information.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/perf_event.h |  6 +++++
>  arch/riscv/kernel/perf_callchain.c  | 38 +++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index 665bbc9b2f84..38926b4a902d 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -8,7 +8,11 @@
>  #ifndef _ASM_RISCV_PERF_EVENT_H
>  #define _ASM_RISCV_PERF_EVENT_H
>
> +#ifdef CONFIG_PERF_EVENTS
>  #include <linux/perf_event.h>
> +extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
> +extern unsigned long perf_misc_flags(struct pt_regs *regs);
> +#define perf_misc_flags(regs) perf_misc_flags(regs)
>  #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
>
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \
> @@ -17,4 +21,6 @@
>  	(regs)->sp = current_stack_pointer; \
>  	(regs)->status = SR_PP; \
>  }
> +#endif
> +
>  #endif /* _ASM_RISCV_PERF_EVENT_H */
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index c7468af77c66..c2c81a80f816 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -28,11 +28,49 @@ static bool fill_callchain(void *entry, unsigned long pc)
>  void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  			 struct pt_regs *regs)
>  {
> +	if (perf_guest_state()) {
> +		/* TODO: We don't support guest os callchain now */
> +		return;

That seems kind of weird, but it looks like almost exactly the same 
thing Marc did in 75e424620a4f ("arm64: perf: add guest vs host 
discrimination").  I think it's safe, as we'll basically just silently 
display no backtrace and we can always just fail to backtrace.

That said: I don't understand why we can't backtrace inside a guest?  If 
we can get the registers and memory it seems like we should be able to.  
Maybe I'm missing something?

> +	}
> +
>  	arch_stack_walk_user(fill_callchain, entry, regs);
>  }
>
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
> +	unsigned long misc = 0;
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
