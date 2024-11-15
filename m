Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC631B21B6
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672684; cv=none; b=j2XbwLTYqDQEv9zF9wYq5TGZbXL+p4uumdgWX33FOJwwK0cX2SeZPtYaIxm9+slAGXhe6am7wwC08WYFrJWhS1jr1XTDUIYfCEHi9r7Fe101NqChM8UhKOLBoAorxYvCdOJKaha4GGHH9GBEjpLaBBJQc9D7HOmQqyW6k+cYu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672684; c=relaxed/simple;
	bh=FaSLZA5wMvzyJDHBkqPnRryv+JsqVtjFtEN9K1XiMn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8W5UgKtkwcUxfRkbhECiZ3gsPJKHqCD1I54RaYqXRHlWAFtnm/XglKAj3efRAAWu0+7fqkB3h2n7/rvCKIC4QpmGKhwkVV+IdJq7z1vzf8pDzccNopy950e8Ap7+KCWQUNCG0AFv1ogSZMUyQCEvqel7Be0uhQRAwkSKxr0ZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BdbMhenO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BdbMhenO"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f2b95775so2529744e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 04:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731672680; x=1732277480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ+AdD1yknk1kRQgfBx7Kwn6AzJEYVnpkDhWcnwpCyw=;
        b=BdbMhenOPPQueifMq8F4CjeKN+NoUIOIIjWz04dqAMF68yWBQv//o0MWyn7F93+ted
         x1SiMakKlghKvYVVXxg3+QXo9PJQ4fFiBzeWYFoRDSRwREmFqafYegT/CbaWsc55J1Vq
         Ysty57mT/etTcS2dphxYegvs7oowqtOV+KVKcbhzmJbT461dk0uynVUdZC2G5E4KZJyD
         RBTYPNGju64q+BNFE5UQM7N+IAy2BqjlBMDkqRFCwvoIsbXxyIH9XoIIchUJyqcGmHUM
         jSnQxMe3LS5uFo7BsjF3TgEMx2VtnGzewbHfYXyt7g9Gor3AGzun1a4O5AqfeViKC/r6
         9wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731672680; x=1732277480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQ+AdD1yknk1kRQgfBx7Kwn6AzJEYVnpkDhWcnwpCyw=;
        b=LZD4QZEIphYI4hmdxnFFdadPXkXwnCPeQNT8kAxI9LJ0bHnxQFJ9Eb9BYvVMdP1zBC
         X6JhnG/bg57m7V4WMGtpDdfuMw7rd7vA5wZIjGYzNPpEvftn+WuvdGkhuueR0WXK05UY
         B5+KojMyXix3m4oJpqfp9TVq8jeKHTKiDEKleKZTm0ag8zHgUhPGlG1P1DlLEoBoUB2r
         2tmXTaxrw/eUJ7giYk4lXQjLYmi9A2rnl/WDimAwZeuR0nblqRhK8MKibM29Fma56dce
         SNCSb6WhOdQ93kpY9DN2CUQwZ5hZgZZqCfXzI32m+tFN7GfCWzHwvVgr/qNUAekM/g+T
         9Gzw==
X-Forwarded-Encrypted: i=1; AJvYcCXOoSFs7hvA/pW6ic2OYuP+ov1WhO1L0AJlv3t1nY77OyVAgxt4y1c8V1xX7Oiklu0UJyCCy7iTaxOuJKI+taPR@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoS0X2JnL+ZcykRXgu2HJhqv/Ss0TOChzbQUzNG8BTvdgUe1+
	dUITb3/bqTayAa9twqtZFqYbp4G8+SyDoATb8rFjuS1G9/mFk5cEzp6FiqbVWJI=
X-Google-Smtp-Source: AGHT+IEumWSW2u3xlYJBaOGTCxOD92+UWLxyLa8a3IDnjbv/tYMlWpFgTL/S3Vntc2APqXqwBNhTaA==
X-Received: by 2002:a05:6512:1294:b0:53b:1fd1:df34 with SMTP id 2adb3069b0e04-53dab3b16c1mr2002910e87.45.1731672679939;
        Fri, 15 Nov 2024 04:11:19 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df1c53asm173250366b.15.2024.11.15.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:11:19 -0800 (PST)
Date: Fri, 15 Nov 2024 13:11:18 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Kan Liang <kan.liang@linux.intel.com>, 
	Colton Lewis <coltonlewis@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH] riscv: perf: Drop defining `perf_instruction_pointer()`
 and `perf_misc_flags()`
Message-ID: <20241115-829a0b75f783dad6dac037a5@orel>
References: <20241115111345.17750-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115111345.17750-1-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 15, 2024 at 11:13:45AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> With commit 2c47e7a74f44 ("perf/core: Correct perf sampling with guest
> VMs"), the perf core now handles the functionality previously requiring
> arch-specific definitions of `perf_instruction_pointer()` and
> `perf_misc_flags()`. As these definitions are no longer necessary for
> RISC-V, this patch removes their implementation and declarations.
> 
> This cleanup aligns the RISC-V architecture with the updated perf core
> mechanism, reducing code redundancy and improving maintainability.
> 
> Fixes: 2c47e7a74f44 ("perf/core: Correct perf sampling with guest VMs")
> Reported-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/riscv/include/asm/perf_event.h |  3 ---
>  arch/riscv/kernel/perf_callchain.c  | 28 ----------------------------
>  2 files changed, 31 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index 38926b4a902d..bcc928fd3785 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -10,9 +10,6 @@
>  
>  #ifdef CONFIG_PERF_EVENTS
>  #include <linux/perf_event.h>
> -extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
> -extern unsigned long perf_misc_flags(struct pt_regs *regs);
> -#define perf_misc_flags(regs) perf_misc_flags(regs)
>  #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
>  
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index c2c81a80f816..b465bc9eb870 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -46,31 +46,3 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
>  
>  	walk_stackframe(NULL, regs, fill_callchain, entry);
>  }
> -
> -unsigned long perf_instruction_pointer(struct pt_regs *regs)
> -{
> -	if (perf_guest_state())
> -		return perf_guest_get_ip();
> -
> -	return instruction_pointer(regs);
> -}
> -
> -unsigned long perf_misc_flags(struct pt_regs *regs)
> -{
> -	unsigned int guest_state = perf_guest_state();
> -	unsigned long misc = 0;
> -
> -	if (guest_state) {
> -		if (guest_state & PERF_GUEST_USER)
> -			misc |= PERF_RECORD_MISC_GUEST_USER;
> -		else
> -			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
> -	} else {
> -		if (user_mode(regs))
> -			misc |= PERF_RECORD_MISC_USER;
> -		else
> -			misc |= PERF_RECORD_MISC_KERNEL;
> -	}
> -
> -	return misc;
> -}
> -- 
> 2.25.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
