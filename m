Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697535F189
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110698; cv=none; b=YN/Bj9UP/0eRgJ0ZJmemtbbSsr9nLljmaSho9UWTezVr2twFnHx6DgiZ15aE2Rh7bAj4u1To/Qb9CUsl5xNsfgisv0rbhfQYb+B574OJ0JzHikrOw1JBloUo+SdtErvqN8C7HIYKKJobBgwCH8rT5VBWtOgyvBcm+o8F1H5wscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110698; c=relaxed/simple;
	bh=LICWX8VvjMCF3+yTM/KcPxOo2+T8+d57s8x2WoNszEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtrH9PP7hUVg07DcX9paC9sc3c3PEy5ILL9lHZ2J/DigdmML0gBGh4jIXDOo318h+xGtyWtUxndn36tq2QZO+JpZKDNBXC/JJdTcK4MtVhwwAkzeYm0vh0fAp7sET2e3qGtX/Q69mD6KUGZvRiLqxBvMFkk1ArfWgvgkuXJuNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1HVsc1E; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1HVsc1E"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30c001b21feso3579839eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Jun 2026 23:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782110696; x=1782715496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O89IWiz4+jst6WssmkXWLaT7xtJNIW5Q681+XiS4VbI=;
        b=m1HVsc1E4wIKgMg29rGxveKTUS27NfVFBN+VQX6jBuCN/A+BJupQZlO9Lgm7EGZsYG
         SLsYu/TgkheqyNBDF/pYbSVsJ9Wl3HhJrdwa+IMjnMIsRjeWNNnmhKAy7OUQGEEyyhk/
         a97jpRmY6/71+ksG1JMX5LITN3/xNXga8OS5g8Za4S0nFvM6s2tBVZDSRo3zB4d+dajW
         wg90cNCsK8brnojnzfx12wcXNJ0zWezmXJAvdc1Y2nwKimpueu3zJxMME11QWwHz1YJj
         yUMc25I7kZJW2jdVLBgE5BLE9BucOJYupbRARYZBoH1P2mp/+tS4k3u5Tv9b6RsZbyuL
         Gkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782110696; x=1782715496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O89IWiz4+jst6WssmkXWLaT7xtJNIW5Q681+XiS4VbI=;
        b=FgC9aDabBa34mO4qKX/tt4Nb1VEmRM9h4GZMaCZrFKFnR4ghRlS4HD0UZ4aDWmGX9q
         z6eSI3qiGALqgPrC9jS6RxW6WGfFeayEzDjzhUoT4GwMCtDjsOdOnXHTQAoo3HlEywTm
         WXI/6VanjpEL/8QhmKaXU0i7pb8K8rSSzljoYIA4RO0dR5cfYh4v7sH703dgI473BIOE
         O9uq382xhFe80Lz1Apg0413hCKORQG46NWDzIXKMdrfH5UaKHz+P7U/ajyx77SvD+TjU
         5ppwZq9F852+Qz/0GlHQgotWMK05hsAtls226Ahk59wnt7XUCoHi4iLGboSAmnnHGJ+u
         OvyQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTa+s+zZEx8qKedHVPKvnHMeE5+6LIkk3volm++YPPA1RpRpADtYbeLTw7DqoN90rh6qekBj21vC5qo+MxzBaK@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjE/VXiNSxdwZArg4mN6HgjqB7hTPvuFWpX8FTqhLHYSLVNvc
	d1L3N0ibaz7CCjvaxra1uC1TquVVCWBx2Wz64ihUQ2QzEH1kzMHSEWQh
X-Gm-Gg: AfdE7clzhvjZ7XKwGCHSHytju6n+2DlXSrNc8GdsIiQHRGRXHHuLwjpgiKyFHTr2L0F
	Lgp3HpoX+yji1YVK82w3IrQFA8A4Zbg9O3MoJPcvsK1eM8uQv+UkmNEOmlQAZHP7N6GWngnJul7
	buSGT7lqUt3zcW5ct2Rri6TGRUzlT2XwPjJ4hCmeHtCpbhDAXSpWCDOwNyH0fDUxIoIt/mqcuAP
	gwejMef0F/DLeod1SwiQC3BzHEyfBprjn0eZx6VmvqhKOGdPcSybXmvntZ0yQsW3eiRvsi0V/Wk
	JGkmQ6vwpqY7RHiESyAZDq9KIotnpqDyQ+blYsrjWn9R3kp3KFmRT0mYan3zKcYkmTfWl/ATh/f
	7C7W6HCaXwnOWNuUS47JS+5Qr1guYmKNm/3AB+8+Hl7E0efKy7LnpwZOVemoltSoOW9b//hvWye
	hh
X-Received: by 2002:a05:7300:dc10:b0:304:df8b:71ee with SMTP id 5a478bee46e88-30c06ffd9e8mr7952599eec.7.1782110696380;
        Sun, 21 Jun 2026 23:44:56 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d78esm8370076eec.18.2026.06.21.23.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:44:55 -0700 (PDT)
Date: Sun, 21 Jun 2026 23:44:52 -0700
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
Subject: Re: [PATCH v6 17/21] RISC-V: perf: Add Qemu virt machine events
Message-ID: <ajjZ5NljehUXERN1@blinky>
References: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
 <20260608-counter_delegation-v6-17-285b72ed65a9@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-counter_delegation-v6-17-285b72ed65a9@meta.com>

On Mon, Jun 08, 2026 at 11:01:31PM -0700, Atish Patra wrote:
> From: Atish Patra <atishp@rivosinc.com>
> 
> Qemu virt machine supports a very minimal set of legacy perf events.
> Add them to the vendor table so that users can use them when
> counter delegation is enabled.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/vendorid_list.h |  4 ++++
>  drivers/perf/riscv_pmu_sbi.c           | 36 ++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
> index 7f5030ee1fcf..603aa2b21c0b 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -11,4 +11,8 @@
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
>  
> +#define QEMU_VIRT_VENDOR_ID		0x000
> +#define QEMU_VIRT_IMPL_ID		0x000
> +#define QEMU_VIRT_ARCH_ID		0x000

Palmer proposed a change to this a while ago to set the archid for qemu
as 42 but it looks like it was never merged in qemu, but it was merged
into the riscv spec.

Here is the spec PR: https://github.com/riscv/riscv-isa-manual/pull/1213
Here is the current spec: https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
Here is the QEMU patch: https://lore.kernel.org/all/20240131182430.20174-1-palmer@rivosinc.com/

Should we follow up with this/maybe this should be accounted for here as
an alternate id?

- Charlie

> +
>  #endif
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 00b84b28117a..74acac54328e 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -26,6 +26,7 @@
>  #include <asm/sbi.h>
>  #include <asm/cpufeature.h>
>  #include <asm/vendor_extensions.h>
> +#include <asm/vendorid_list.h>
>  #include <asm/vendor_extensions/andes.h>
>  #include <asm/hwcap.h>
>  #include <asm/csr_ind.h>
> @@ -453,7 +454,42 @@ struct riscv_vendor_pmu_events {
>  	  .hw_event_map = _hw_event_map, .cache_event_map = _cache_event_map, \
>  	  .attrs_events = _attrs },
>  
> +/* QEMU virt PMU events */
> +static const struct riscv_pmu_event qemu_virt_hw_event_map[PERF_COUNT_HW_MAX] = {
> +	PERF_MAP_ALL_UNSUPPORTED,
> +	[PERF_COUNT_HW_CPU_CYCLES]		= {0x01, 0xFFFFFFF8},
> +	[PERF_COUNT_HW_INSTRUCTIONS]		= {0x02, 0xFFFFFFF8}
> +};
> +
> +static const struct riscv_pmu_event qemu_virt_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
> +						[PERF_COUNT_HW_CACHE_OP_MAX]
> +						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> +	PERF_CACHE_MAP_ALL_UNSUPPORTED,
> +	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= {0x10019, 0xFFFFFFF8},
> +	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= {0x1001B, 0xFFFFFFF8},
> +
> +	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= {0x10021, 0xFFFFFFF8},
> +};
> +
> +RVPMU_EVENT_CMASK_ATTR(cycles, cycles, 0x01, 0xFFFFFFF8);
> +RVPMU_EVENT_CMASK_ATTR(instructions, instructions, 0x02, 0xFFFFFFF8);
> +RVPMU_EVENT_CMASK_ATTR(dTLB-load-misses, dTLB_load_miss, 0x10019, 0xFFFFFFF8);
> +RVPMU_EVENT_CMASK_ATTR(dTLB-store-misses, dTLB_store_miss, 0x1001B, 0xFFFFFFF8);
> +RVPMU_EVENT_CMASK_ATTR(iTLB-load-misses, iTLB_load_miss, 0x10021, 0xFFFFFFF8);
> +
> +static struct attribute *qemu_virt_event_group[] = {
> +	RVPMU_EVENT_ATTR_PTR(cycles),
> +	RVPMU_EVENT_ATTR_PTR(instructions),
> +	RVPMU_EVENT_ATTR_PTR(dTLB_load_miss),
> +	RVPMU_EVENT_ATTR_PTR(dTLB_store_miss),
> +	RVPMU_EVENT_ATTR_PTR(iTLB_load_miss),
> +	NULL,
> +};
> +
>  static struct riscv_vendor_pmu_events pmu_vendor_events_table[] = {
> +	RISCV_VENDOR_PMU_EVENTS(QEMU_VIRT_VENDOR_ID, QEMU_VIRT_ARCH_ID, QEMU_VIRT_IMPL_ID,
> +				qemu_virt_hw_event_map, qemu_virt_cache_event_map,
> +				qemu_virt_event_group)
>  };
>  
>  static const struct riscv_pmu_event *current_pmu_hw_event_map;
> 
> -- 
> 2.53.0-Meta
> 
> 
