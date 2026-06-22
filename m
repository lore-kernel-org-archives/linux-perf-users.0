Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D735E93E
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110540; cv=none; b=mbnoKNyp5NbJ30QAfUdVpJDOE62Vaah44fmCbEyY7xUIf1gVt4EugsFfNhICFNcKUi3yYszE4fTn6BHLDRRZJEYaw+V0ojOgMi61nQEHmuQNwa9UfYxycbd4E2I27vr1hnWdRkSW9BWcW/s8ALQ06yWF6DMsjLK0nItykUQyfcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110540; c=relaxed/simple;
	bh=jfaeXI52jaMlrghTpkWWyKtuS2w1+ywG7Sm/7gz7yk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSRxkv3pto5AL2oDDi5+XS+5XpPFnsu4u8ziAcR7IblYKxYYc68psaI/WUHdbZZTklu0qR/5ebL3YOHwmyG8Vqc+SUl/9Rf8NesNSUOLpxsX3klohTtFzVn5zhK3/ZIDbJWeB28SM35lKQJoLNkdImvjheMs9hyg12TjXrP7Puk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCFp6NX1; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCFp6NX1"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1384ebe7a10so2326912c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Jun 2026 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782110539; x=1782715339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QILN8DTARoWh3OJ/o4dcikoIv6aHuZ0kwC7cM2/BMRM=;
        b=RCFp6NX1Mpj9gN56Px2KTtzCCvvW27QjESJnJA0XpuZs0+N0roJWYFIJL3C2jyvsa+
         cIuA29eqtB9CMnu4ze31Y96/DFz2Fk3fR9z2+gkw2VovMpU9aqqOauoSN4bxNu4mLrIV
         fRAFSbHl8Ax5dnauVKm6Lw3cG6EnEkL6MywPox1UllIc7Iqt54uzvfni8XmAXLEbCo02
         vMN4WPk9reRfBXPBHTEu5gy2DdyqTJN/px907loEkNTBE2UywZdMoM+yyPXWGYQHchNp
         qyvRiPKCdooN7yQnH+FZPSNazUAnCRbjxDklTX++4iTN9GB+Yq2L4FPHK2xipyk4Zuyt
         7H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782110539; x=1782715339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QILN8DTARoWh3OJ/o4dcikoIv6aHuZ0kwC7cM2/BMRM=;
        b=dvEsHc+KVV/4DtCIOn1OpEakOuxwBI3CHZywX3KzcOlOz/BMElipMeSMaDzbjrxORZ
         vE/2MJzg4qyG211Y20cxHMkfPJvgm0ehTRW4layUCphyXPqx2U/FpIq48xphvOCS/HSp
         zX4krlu751S+sNYCcVy9XRQX+6NWfcH5c6japVraxiEVs+RD/fPS3XSmodqrDmrbBlGK
         Fwvzw3fJq89rmaq1FQgcXxMdfZaoRFfepDoUijC1xbcdqUV7+GmfEttJpe5C6QGU2n2S
         VTWqS5nmTeJiJ85/u5M020Dl8UHinrZ3dod45H84ADKX0pmCtIIVDPS3HE7iK7PpGBbF
         NDWg==
X-Forwarded-Encrypted: i=1; AFNElJ+txZ3pCfmSZS2L6k9cMe7N9nxR5YbGwhVANVDjgwCu2oxA9m8Lj9rtxTfdj6OpmIorwDE5Qt/5VdFluEoVsk5J@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DNE5P43vS60yQubG8wVWLHiAX6uCoyR3+Urc8RPAXcqywNaO
	wKDUTlz22SSx0W7fx/kN1/Vyy6yJQkIZU0x4aGRRqOCHQsxi2QP+8Hz2
X-Gm-Gg: AfdE7clxXoeVL7pSNHJBu/ComvVL3KXNMA1AkM3Z96OHHdbPNCPPK2R80Q6Z/yWbPFL
	wbJdbY3DjjGZdZWp7ehwRaONQk3E9MyETCo/C1JeeyrZVngzHUvkQQNCYFocMK+WegfwxQIqxhm
	K7o7i5cxQ//PsGTEqLQz/fWy1p8N4t5iL0E177HQX74pVVf+mXUo1mdi6eTjlTdwpSO9S3ik1fu
	8FZu4l7Z3XKCobI8kZhVv4SVR1kOqpgz98mJ/K65Uvztc4Rr/hNEridlw1UKGbO1jKUQzS4HEf5
	4fiw2bLLoUbvATB8tBKn9dM4BKiW5h/NjO7B7klyLuISTRIdQd/rpev27ZDstwPDv5TC7ub789E
	hrmKK8SHipLvYdsZIJFbqNBGTV1yr5nRjkOEJdAl/pDxOqrpqZprXlqdB93oiPOYglvsf3twa7D
	r2
X-Received: by 2002:a05:7022:6890:b0:138:4023:8c1 with SMTP id a92af1059eb24-139a4eca6f2mr7435550c88.11.1782110538606;
        Sun, 21 Jun 2026 23:42:18 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adc0fdb6sm6363664c88.0.2026.06.21.23.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:42:18 -0700 (PDT)
Date: Sun, 21 Jun 2026 23:42:15 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anup Patel <anup@brainfault.org>,
	Namhyung Kim <namhyung@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 04/21] RISC-V: Define indirect CSR access helpers
Message-ID: <ajjZR-R11yPYWuDp@blinky>
References: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
 <20260608-counter_delegation-v6-4-285b72ed65a9@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-counter_delegation-v6-4-285b72ed65a9@meta.com>

On Mon, Jun 08, 2026 at 11:01:18PM -0700, Atish Patra wrote:
> From: Atish Patra <atishp@rivosinc.com>
> 
> The indriect CSR requires multiple instructions to read/write CSR.

indirect

> Add a few helper functions for ease of usage.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr_ind.h | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/csr_ind.h b/arch/riscv/include/asm/csr_ind.h
> new file mode 100644
> index 000000000000..6fd7d44dc640
> --- /dev/null
> +++ b/arch/riscv/include/asm/csr_ind.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Rivos Inc.

I don't think it makes sense to introduce this copyright in new commits.

- Charlie

> + */
> +
> +#ifndef _ASM_RISCV_CSR_IND_H
> +#define _ASM_RISCV_CSR_IND_H
> +
> +#include <linux/irqflags.h>
> +
> +#include <asm/csr.h>
> +
> +#define csr_ind_read(iregcsr, iselbase, iseloff) ({		\
> +	unsigned long __value = 0;				\
> +	unsigned long __flags;					\
> +	local_irq_save(__flags);				\
> +	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
> +	__value = csr_read(iregcsr);				\
> +	local_irq_restore(__flags);				\
> +	__value;						\
> +})
> +
> +#define csr_ind_write(iregcsr, iselbase, iseloff, value) ({	\
> +	unsigned long __flags;					\
> +	local_irq_save(__flags);				\
> +	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
> +	csr_write(iregcsr, (value));				\
> +	local_irq_restore(__flags);				\
> +})
> +
> +#define csr_ind_warl(iregcsr, iselbase, iseloff, warl_val) ({	\
> +	unsigned long __old_val = 0, __value = 0;		\
> +	unsigned long __flags;					\
> +	local_irq_save(__flags);				\
> +	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
> +	__old_val = csr_read(iregcsr);				\
> +	csr_write(iregcsr, (warl_val));				\
> +	__value = csr_read(iregcsr);				\
> +	csr_write(iregcsr, __old_val);				\
> +	local_irq_restore(__flags);				\
> +	__value;						\
> +})
> +
> +#endif
> 
> -- 
> 2.53.0-Meta
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
