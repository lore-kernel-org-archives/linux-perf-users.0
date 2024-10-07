Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE24188703;
	Mon,  7 Oct 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289194; cv=none; b=lfS0OEjVSR3E08V8IDJpm9NkFwnQCbJ4krrOy4F/RVso1H05tDeGu2QwdGQBy0rvQdqSuh/yYv9ZDLMtcP8Tphao0eP3zvzYfM0WTPUi/7qPmH3LTColLAC6uJ74+o9364+3cM81mNk5jo6mvKQ6DEVb7UQWCpv+h2FfKVaLfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289194; c=relaxed/simple;
	bh=p7fnPdg9GXFJITuQrseQDNuIaX+4R+NIr2XuOdnxTOg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q0twgBG8Xhd5W905Fz4W+nwrhBaYyirCB7Z0LEQZG6ayAJNzgNDsWD7N43fTF11FyYte77Q5QPPEugPtZnD9c/Hk3gwGFcjvTjBRvVOa5DkHENRh6aFTzXnQefzwm07iozSSfwkNRUsqS64V343adgpOUEBGpqAEp2OJsP3BDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on0X8S+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on0X8S+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0EBC4CEC6;
	Mon,  7 Oct 2024 08:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728289193;
	bh=p7fnPdg9GXFJITuQrseQDNuIaX+4R+NIr2XuOdnxTOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=on0X8S+1tuhId3VGYt/LSW/vWZbtRu4Y0aAQW8QemIGTVE/BdqBPjbVf5qr/sVgrV
	 qEdd2OyD6z9TcgrMmY+8Oh7g2d+1vNz1XqHjtvgqVMrJRT93O3sfn4SRuiX7MeZIyN
	 oB4RDp1mbFMnnskliJcMyp9o6WSW/8hvbpVcvMg31JDfURhR0DNt9+x/2tK/+KbI48
	 1blKwBDXXHuRTLpJc03VfTGnPuqY6j34ToTWoxjjhHN1tP5wKC95lPFzGiYf6Yydjm
	 zr+iik+uEgMQJDBUkplHIdEc4ElZ8TzU9C7pGLb16/zTWSZbzxehCxXdDKA2+A1d91
	 DEzwPUTTfYNqw==
Date: Mon, 7 Oct 2024 17:19:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, Will
 Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren
 <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nick
 Terrell <terrelln@fb.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner
 <dwagner@suse.de>, Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Kajol Jain <kjain@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Bibo
 Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>,
 Oliver Upton <oliver.upton@linux.dev>, "Steinar H. Gunderson"
 <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Chen Pei
 <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, Yury Norov
 <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 19/31] perf arm64: Remove dwarf-regs.c
Message-Id: <20241007171942.e96d5c520e065bbe4cf8ae5f@kernel.org>
In-Reply-To: <20241005195541.380070-20-irogers@google.com>
References: <20241005195541.380070-1-irogers@google.com>
	<20241005195541.380070-20-irogers@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Oct 2024 12:55:29 -0700
Ian Rogers <irogers@google.com> wrote:

> The file just provides the function get_arch_regstr, however, if in
> the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case
> the function can never be called. So remove as dead code. Tidy up the
> EM_NONE cases for arm64 in dwarf-regs.c.

OK, this seems just a redundant information in 
tools/perf/arch/arm64/include/dwarf-regs-table.h (there is alredy
register number -> name mapping table.)

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm64/util/Build        |  1 -
>  tools/perf/arch/arm64/util/dwarf-regs.c | 80 -------------------------
>  tools/perf/util/dwarf-regs.c            |  4 +-
>  tools/perf/util/include/dwarf-regs.h    |  2 +-
>  4 files changed, 3 insertions(+), 84 deletions(-)
>  delete mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
> 
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 4387a6d6a6c3..a74521b79eaa 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -4,7 +4,6 @@ perf-util-y += perf_regs.o
>  perf-util-y += tsc.o
>  perf-util-y += pmu.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
> -perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>  
> diff --git a/tools/perf/arch/arm64/util/dwarf-regs.c b/tools/perf/arch/arm64/util/dwarf-regs.c
> deleted file mode 100644
> index 343a62fa4199..000000000000
> --- a/tools/perf/arch/arm64/util/dwarf-regs.c
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Mapping of DWARF debug register numbers into register names.
> - *
> - * Copyright (C) 2010 Will Deacon, ARM Ltd.
> - */
> -
> -#include <errno.h>
> -#include <stddef.h>
> -#include <string.h>
> -#include <dwarf-regs.h>
> -#include <linux/stringify.h>
> -
> -struct regs_dwarfnum {
> -	const char *name;
> -	unsigned int dwarfnum;
> -};
> -
> -#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
> -#define GPR_DWARFNUM_NAME(num) \
> -	{.name = __stringify(%x##num), .dwarfnum = num}
> -#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
> -
> -/*
> - * Reference:
> - * http://infocenter.arm.com/help/topic/com.arm.doc.ihi0057b/IHI0057B_aadwarf64.pdf
> - */
> -static const struct regs_dwarfnum regdwarfnum_table[] = {
> -	GPR_DWARFNUM_NAME(0),
> -	GPR_DWARFNUM_NAME(1),
> -	GPR_DWARFNUM_NAME(2),
> -	GPR_DWARFNUM_NAME(3),
> -	GPR_DWARFNUM_NAME(4),
> -	GPR_DWARFNUM_NAME(5),
> -	GPR_DWARFNUM_NAME(6),
> -	GPR_DWARFNUM_NAME(7),
> -	GPR_DWARFNUM_NAME(8),
> -	GPR_DWARFNUM_NAME(9),
> -	GPR_DWARFNUM_NAME(10),
> -	GPR_DWARFNUM_NAME(11),
> -	GPR_DWARFNUM_NAME(12),
> -	GPR_DWARFNUM_NAME(13),
> -	GPR_DWARFNUM_NAME(14),
> -	GPR_DWARFNUM_NAME(15),
> -	GPR_DWARFNUM_NAME(16),
> -	GPR_DWARFNUM_NAME(17),
> -	GPR_DWARFNUM_NAME(18),
> -	GPR_DWARFNUM_NAME(19),
> -	GPR_DWARFNUM_NAME(20),
> -	GPR_DWARFNUM_NAME(21),
> -	GPR_DWARFNUM_NAME(22),
> -	GPR_DWARFNUM_NAME(23),
> -	GPR_DWARFNUM_NAME(24),
> -	GPR_DWARFNUM_NAME(25),
> -	GPR_DWARFNUM_NAME(26),
> -	GPR_DWARFNUM_NAME(27),
> -	GPR_DWARFNUM_NAME(28),
> -	GPR_DWARFNUM_NAME(29),
> -	REG_DWARFNUM_NAME("%lr", 30),
> -	REG_DWARFNUM_NAME("%sp", 31),
> -	REG_DWARFNUM_END,
> -};
> -
> -/**
> - * get_arch_regstr() - lookup register name from it's DWARF register number
> - * @n:	the DWARF register number
> - *
> - * get_arch_regstr() returns the name of the register in struct
> - * regdwarfnum_table from it's DWARF register number. If the register is not
> - * found in the table, this returns NULL;
> - */
> -const char *get_arch_regstr(unsigned int n)
> -{
> -	const struct regs_dwarfnum *roff;
> -
> -	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
> -		if (roff->dwarfnum == n)
> -			return roff->name;
> -	return NULL;
> -}
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index eac99a246737..18e916c8e993 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -32,14 +32,14 @@
>  const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
>  			     unsigned int flags __maybe_unused)
>  {
> -#if EM_HOST == EM_X86_64 || EM_HOST == EM_386
> +#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64
>  	if (machine == EM_NONE) {
>  		/* Generic arch - use host arch */
>  		machine = EM_HOST;
>  	}
>  #endif
>  	switch (machine) {
> -#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
> +#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64
>  	case EM_NONE:	/* Generic arch - use host arch */
>  		return get_arch_regstr(n);
>  #endif
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
> index 062623aefd5a..e640657f69c8 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -79,7 +79,7 @@
>  #define DWARF_REG_FB  0xd3affb /* random number */
>  
>  #ifdef HAVE_LIBDW_SUPPORT
> -#if !defined(__x86_64__) && !defined(__i386__)
> +#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__)
>  const char *get_arch_regstr(unsigned int n);
>  #endif
>  
> -- 
> 2.47.0.rc0.187.ge670bccf7e-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
