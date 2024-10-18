Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6666204F63
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280344; cv=none; b=h/7a4bLoyQKcssBOyNFzktggnLvvQwR4bu47JchBJZXSDAGdCN573C07BRGCYQPSpvqQYR6cDJbXdp1DKnQUHsnbC2famGZx5e+QU9k6FDFkpIHIO9/ylg2MsUEVcWvbM610anD/t/9SXJlhZDyXB7Qjrj2l4BNH+k1ddNfQ3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280344; c=relaxed/simple;
	bh=2PKDJhlB3QPDNbsr3o5S9FVspq5upY+vv4l/wlI8dNw=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=CY73IgUeFggL+9S5++cmeI+gIrRxhM48plgovf+3JmgP64+1onmzqCnOI4SOwh+M1etvk3Zvx6qOIkfDtCn34Yt4fa37U+AhwXvKndO7OBcq0e8NzlbZQMWYqrAQPbqPkBJ7FmkwLBYbyP4UU0DsGzX6UfVjpUd0exPmgzKmrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Jg5bfSxG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Jg5bfSxG"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e4fa3ea7cso2035468b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729280341; x=1729885141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiT5fWlA/ERvmoNoGd6vO/wEcabREvD5vErT274A8nM=;
        b=Jg5bfSxGro8EbfG6Kvt9K9FinUyeYrKsxiUiQPob53bLQ0zmnnsYugVtMZUDpIIxaG
         UOvcDaBzpRTZ8Dc945CoV0FHBqkbptdaIBxh6n2b3gHvRJy22LYUbItP/wih8iWZPEaj
         cnWblg4isC+5hmpw2R000A8vkez3tFjhj6SVrsRG1YjKzfjdQk1KyWRnkZLmLoLRQ+wT
         O2T0vSaDjSbrdpDYWNqtSQOIxx0CVfrY9GbEyqKkwJLV/oXl1c7S6qDNssvpaFnEXUsu
         i1ThdpebocB7k3lSmKhqi29xgjOyCFtAZlBy38kve4RxG2lAjbK/XIMcDlqd2HGpyzmV
         BMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729280341; x=1729885141;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiT5fWlA/ERvmoNoGd6vO/wEcabREvD5vErT274A8nM=;
        b=CtTGZ5KxBOdoHodcI4LAD1MjvCLVuMMaSEl8YAY1fA7m+byQYc899ECOptoEM/dq6S
         FPOlMAyaFK/nZiV6cndMPnBOrBs4bJrtKueIJfB0lHuOXoba8ldyKmNi2MZsKb8LSU+S
         0rYTChhZnvkzy8IKUMXss1UFDaAKVPsvWHgR1rInGafA8oXSmSh5WAuiZva6eOkwVgRR
         20t5qZew4RWJbzXHFtPO/wdbriRRp2uerL5GEJvkMd8z+Sn14Rs8jZz/lR2zwlZrSHtw
         6LA45vyd9Qzja5q2hw6V6GYi9xR+glDyKKZ/N4UjnqyJ0ocXqCjNMQyj211DKKgyZS3m
         +p5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBzarSSfRi/szmxdlmYRP9VNgdtwGhlgAcXIYXbSO+pIMY9D2e4yseYTasEqDYCGX1975qL1DdJ4omP/yomqbj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Jfw+Lyan8EzQsjwZk3UyiD0yLqbK/GUWbhTqjUVKLYcqMfz3
	fUkTcCq6kMiizD/+qhYSb5xqfbPzoLhZDIxb/R4BsAQeXJIESQlL76ClP4g6zxg=
X-Google-Smtp-Source: AGHT+IEaz8xK2W5RjSu2Q9b6C4y0O26xQFCdJyP2lVmFbBHXT7gzr62PkAtdtybkW4AY+Kl/19589g==
X-Received: by 2002:a05:6a00:1989:b0:70d:14d1:1bb7 with SMTP id d2e1a72fcca58-71ea331c750mr4761453b3a.28.1729280340869;
        Fri, 18 Oct 2024 12:39:00 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea33663e1sm1837071b3a.89.2024.10.18.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 12:39:00 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:39:00 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2024 12:38:57 PDT (-0700)
Subject:     Re: [PATCH v3 14/20] perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
In-Reply-To: <20241017002520.59124-15-irogers@google.com>
CC: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
  Mark Rutland <mark.rutland@arm.com>, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
  adrian.hunter@intel.com, kan.liang@linux.intel.com, john.g.garry@oracle.com,
  Will Deacon <will@kernel.org>, james.clark@linaro.org, mike.leach@linaro.org, leo.yan@linux.dev,
  guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  terrelln@fb.com, mhiramat@kernel.org, changbin.du@huawei.com, amadio@gentoo.org,
  yangjihong@bytedance.com, adityag@linux.ibm.com, atrajeev@linux.vnet.ibm.com, masahiroy@kernel.org,
  maobibo@loongson.cn, chenhuacai@kernel.org, kjain@linux.ibm.com, Atish Patra <atishp@rivosinc.com>,
  liangshenlin@eswincomputing.com, anup@brainfault.org, oliver.upton@linux.dev, sesse@google.com,
  linux@treblig.org, cp0613@linux.alibaba.com, dima@secretsauce.net, przemyslaw.kitszel@intel.com,
  davem@davemloft.net, aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
  linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
  linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: irogers@google.com
Message-ID: <mhng-77fefb3c-c270-471c-b71b-ef3ab65d8b79@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 17:25:14 PDT (-0700), irogers@google.com wrote:
> The file just provides the function get_arch_regstr, however, if in
> the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case,
> and the register table is provided in a header file, the function can
> never be called. So remove as dead code. Tidy up the EM_NONE cases for
> riscv in dwarf-regs.c.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../dwarf-regs-table.h}                       | 32 ++++---------------
>  tools/perf/arch/riscv/util/Build              |  1 -
>  tools/perf/util/dwarf-regs.c                  |  7 ++--
>  tools/perf/util/include/dwarf-regs.h          |  2 +-
>  4 files changed, 12 insertions(+), 30 deletions(-)
>  rename tools/perf/arch/riscv/{util/dwarf-regs.c => include/dwarf-regs-table.h} (56%)
>
> diff --git a/tools/perf/arch/riscv/util/dwarf-regs.c b/tools/perf/arch/riscv/include/dwarf-regs-table.h
> similarity index 56%
> rename from tools/perf/arch/riscv/util/dwarf-regs.c
> rename to tools/perf/arch/riscv/include/dwarf-regs-table.h
> index a9c4402ae57e..a45b63a6d5a8 100644
> --- a/tools/perf/arch/riscv/util/dwarf-regs.c
> +++ b/tools/perf/arch/riscv/include/dwarf-regs-table.h
> @@ -1,23 +1,10 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> - * Mapping of DWARF debug register numbers into register names.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifdef DEFINE_DWARF_REGSTR_TABLE
> +/* This is included in perf/util/dwarf-regs.c */
>
> -#include <stddef.h>
> -#include <errno.h> /* for EINVAL */
> -#include <string.h> /* for strcmp */
> -#include <dwarf-regs.h>
> +#define REG_DWARFNUM_NAME(reg, idx)	[idx] = "%" #reg
>
> -struct regs_dwarfnum {
> -	const char *name;
> -	unsigned int dwarfnum;
> -};
> -
> -#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
> -#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
> -
> -struct regs_dwarfnum riscv_dwarf_regs_table[] = {
> +static const char * const riscv_regstr_tbl[] = {
>  	REG_DWARFNUM_NAME("%zero", 0),
>  	REG_DWARFNUM_NAME("%ra", 1),
>  	REG_DWARFNUM_NAME("%sp", 2),
> @@ -50,13 +37,6 @@ struct regs_dwarfnum riscv_dwarf_regs_table[] = {
>  	REG_DWARFNUM_NAME("%t4", 29),
>  	REG_DWARFNUM_NAME("%t5", 30),
>  	REG_DWARFNUM_NAME("%t6", 31),
> -	REG_DWARFNUM_END,
>  };
>
> -#define RISCV_MAX_REGS ((sizeof(riscv_dwarf_regs_table) / \
> -		 sizeof(riscv_dwarf_regs_table[0])) - 1)
> -
> -const char *get_arch_regstr(unsigned int n)
> -{
> -	return (n < RISCV_MAX_REGS) ? riscv_dwarf_regs_table[n].name : NULL;
> -}
> +#endif
> diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
> index 8f93091b8345..58a672246024 100644
> --- a/tools/perf/arch/riscv/util/Build
> +++ b/tools/perf/arch/riscv/util/Build
> @@ -2,5 +2,4 @@ perf-util-y += perf_regs.o
>  perf-util-y += header.o
>
>  perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
> -perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
>  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index 3d98c2bf6035..2c6b197556dd 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -20,6 +20,7 @@
>  #include "../arch/arm64/include/dwarf-regs-table.h"
>  #include "../arch/sh/include/dwarf-regs-table.h"
>  #include "../arch/powerpc/include/dwarf-regs-table.h"
> +#include "../arch/riscv/include/dwarf-regs-table.h"
>  #include "../arch/s390/include/dwarf-regs-table.h"
>  #include "../arch/sparc/include/dwarf-regs-table.h"
>  #include "../arch/xtensa/include/dwarf-regs-table.h"
> @@ -33,7 +34,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
>  {
>  #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
>      || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
> -    || EM_HOST == EM_PPC64
> +    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV
>  	if (machine == EM_NONE) {
>  		/* Generic arch - use host arch */
>  		machine = EM_HOST;
> @@ -42,7 +43,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
>  	switch (machine) {
>  #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
>      && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
> -    && EM_HOST != EM_PPC64
> +    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV
>  	case EM_NONE:	/* Generic arch - use host arch */
>  		return get_arch_regstr(n);
>  #endif
> @@ -63,6 +64,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
>  	case EM_PPC:
>  	case EM_PPC64:
>  		return __get_dwarf_regstr(powerpc_regstr_tbl, n);
> +	case EM_RISCV:
> +		return __get_dwarf_regstr(riscv_regstr_tbl, n);
>  	case EM_SPARC:
>  	case EM_SPARCV9:
>  		return __get_dwarf_regstr(sparc_regstr_tbl, n);
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
> index 1763280855ce..35f4f33205da 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -81,7 +81,7 @@
>  #ifdef HAVE_LIBDW_SUPPORT
>  #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
>      && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
> -    && !defined(__powerpc64__)
> +    && !defined(__powerpc64__) && !defined(__riscv__)
>  const char *get_arch_regstr(unsigned int n);
>  #endif

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
