Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0D198E81;
	Thu, 31 Jul 2025 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938463; cv=none; b=cJXL8v2oKJvnfiO2I6AvYVXXdUA69WfEBss8cOlOkDNP5RK3yI6uLChRHFV4yk9Sx49MVs7cZkoSG4iMk+WX9YO2McYcsotEKdyd7vMmhiZSWbS6lhtCu8sWrzQWU+eVTohQfJ+oS/Xj0yidyZUpCz0Dw2f5A4idxxMTIiO/nS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938463; c=relaxed/simple;
	bh=J8XH8c+tisSXBhUoA5RBsq2Rept4gnon3SkIS0FdLGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfgTjsP3+s/f0ulmbo2U/JDS6oYPPN9vhhvOKPk6saMvnS/++1sHy+gmBshka6/QYhSPv3vyZS+9MgDgJvYn/LUy/Gj54tV5stL4Pix5g8yyzFQvcd50Xu6h9s8x1wEfLJyiik15cxpXBnuelpXxWYtBcEJVoaZTQ/+hb734qqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szWpnu6q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szWpnu6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14333C4CEEF;
	Thu, 31 Jul 2025 05:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753938462;
	bh=J8XH8c+tisSXBhUoA5RBsq2Rept4gnon3SkIS0FdLGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szWpnu6qY8RxzEOTkXNjkmAh0TaXV6dOhpYBC8SP9u4i+DuiPiwAD3cpM7F5q3+WF
	 yZK6V1IbuNsbLFlnVvwogfqwGN3LAvmKbRiFvSIgLwmTCVRZ555qI7PXTMPbegi4VA
	 PdtM029/OOokfbliiIC6/9NiVENw9ikVjeaMEDRmn+C/8Ah0sjINBHzc3Rgiwx16ms
	 AwjxJdiG+hzbnF5YrZT97oOQxKgbHH1PIDnEOHQiWf4MvlWW/5f5OWs3Ra6Gs4IQwU
	 3qZ+v/bK6fAk8eTLCepOnVqa79DjdSsoAH5Wyr5pN/iQIAN9vuDJ+QBsGng7hU1Lis
	 5nOMe3H0hp4vA==
Date: Wed, 30 Jul 2025 22:07:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yuzhuo Jing <yuzhuo@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 4/7] tools: Implement userspace per-cpu
Message-ID: <aIr6HEiqfYhgaec6@google.com>
References: <20250729022640.3134066-1-yuzhuo@google.com>
 <20250729022640.3134066-5-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729022640.3134066-5-yuzhuo@google.com>

On Mon, Jul 28, 2025 at 07:26:37PM -0700, Yuzhuo Jing wrote:
> Implement userspace per-cpu for imported kernel code.  Compared with
> simple thread-local definition, the kernel per-cpu provides 1) a
> guarantee of static lifetime even when thread exits, and 2) the ability
> to access other CPU's per-cpu data.
> 
> This patch adds an alternative implementation and interface for
> userspace per-cpu.  The kernel implementation uses special ELF sections
> and offset calculation.  For simplicity, this version defines a
> PERCPU_MAX length global array for each per-cpu data, and uses a
> thread-local cpu id for indexing.
> 
> Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
> ---
>  tools/include/linux/compiler_types.h  |   3 +
>  tools/include/linux/percpu-simulate.h | 128 ++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+)
>  create mode 100644 tools/include/linux/percpu-simulate.h
> 
> diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
> index 9a2a2f8d7b6c..46550c500b8c 100644
> --- a/tools/include/linux/compiler_types.h
> +++ b/tools/include/linux/compiler_types.h
> @@ -31,6 +31,9 @@
>  # define __cond_lock(x,c) (c)
>  #endif /* __CHECKER__ */
>  
> +/* Per-cpu checker flag does not use address space attribute in userspace */
> +#define __percpu
> +
>  /*
>   * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
>   *			       non-scalar types unchanged.
> diff --git a/tools/include/linux/percpu-simulate.h b/tools/include/linux/percpu-simulate.h
> new file mode 100644
> index 000000000000..a6af2f2211eb
> --- /dev/null
> +++ b/tools/include/linux/percpu-simulate.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Userspace implementation of per_cpu_ptr for adapted kernel code.
> + *
> + * Userspace code does not have and does not need a per-cpu concept, but
> + * instead can declare variables as thread-local.  However, the kernel per-cpu
> + * further provides 1) the guarantee of static lifetime when thread exits, and
> + * 2) the ability to access other CPU's per-cpu data.  This file provides a
> + * simple implementation of such functionality, but with slightly different
> + * APIs and without linker script changes.
> + *
> + * 2025  Yuzhuo Jing <yuzhuo@google.com>
> + */
> +#ifndef __PERCPU_SIMULATE_H__
> +#define __PERCPU_SIMULATE_H__
> +
> +#include <assert.h>
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
> +/*
> + * The maximum supported number of CPUs.  Per-cpu variables are defined as a
> + * PERCPU_MAX length array, indexed by a thread-local cpu id.
> + */
> +#define PERCPU_MAX 4096
> +
> +#ifdef ASSERT_PERCPU
> +#define __check_cpu_id(cpu)						\
> +({									\
> +	u32 cpuid = (cpu);						\
> +	assert(cpuid < PERCPU_MAX);					\
> +	cpuid;								\
> +})
> +#else
> +#define __check_cpu_id(cpu)	(cpu)
> +#endif
> +
> +/*
> + * Use weak symbol: only define __thread_per_cpu_id variable if any perf tool
> + * includes this header file.
> + */
> +_Thread_local u32 __thread_per_cpu_id __weak;

Is there any overhead (or some indirection) when using the thread local
variable?

> +
> +static inline u32 get_this_cpu_id(void)
> +{
> +	return __thread_per_cpu_id;
> +}
> +
> +/*
> + * The user code must call this function inside of each thread that uses
> + * per-cpu data structures.  The user code can choose an id of their choice,
> + * but must ensure each thread uses a different id.
> + *
> + * Safety: asserts CPU id smaller than PERCPU_MAX if ASSERT_PERCPU is defined.
> + */
> +static inline void set_this_cpu_id(u32 id)
> +{
> +	__thread_per_cpu_id = __check_cpu_id(id);
> +}
> +
> +/*
> + * Declare a per-cpu data structure.  This only declares the data type and
> + * array length. Different per-cpu data are differentiated by a key (identifer).
> + *
> + * Different from the kernel version, this API must be called before the actual
> + * definition (i.e. DEFINE_PER_CPU_ALIGNED).
> + *
> + * Note that this implementation does not support prepending static qualifier,
> + * or appending assignment expressions.
> + */
> +#define DECLARE_PER_CPU_ALIGNED(key, type, data) \
> +	extern struct __percpu_type_##key { \
> +		type data; \
> +	} __percpu_data_##key[PERCPU_MAX]
> +
> +/*
> + * Define the per-cpu data storage for a given key.  This uses a previously
> + * defined data type in DECLARE_PER_CPU_ALIGNED.
> + *
> + * Different from the kernel version, this API only accepts a key name.
> + */
> +#define DEFINE_PER_CPU_ALIGNED(key) \
> +	struct __percpu_type_##key __percpu_data_##key[PERCPU_MAX]

How do these APIs guarantee the alignment?

Thanks,
Namhyung

> +
> +#define __raw_per_cpu_value(key, field, cpu) \
> +	(__percpu_data_##key[cpu].field)
> +
> +/*
> + * Get a pointer of per-cpu data for a given key.
> + *
> + * Different from the kernel version, users of this API don't need to pass the
> + * address of the base variable (through `&varname').
> + *
> + * Safety: asserts CPU id smaller than PERCPU_MAX if ASSERT_PERCPU is defined.
> + */
> +#define per_cpu_ptr(key, field, cpu) (&per_cpu_value(key, field, cpu))
> +#define this_cpu_ptr(key, field) (&this_cpu_value(key, field))
> +
> +/*
> + * Additional APIs for direct value access.  Effectively, `*per_cpu_ptr(...)'.
> + *
> + * Safety: asserts CPU id smaller than PERCPU_MAX if ASSERT_PERCPU is defined.
> + */
> +#define per_cpu_value(key, field, cpu) \
> +	(__raw_per_cpu_value(key, field, __check_cpu_id(cpu)))
> +#define this_cpu_value(key, field) \
> +	(__raw_per_cpu_value(key, field, __thread_per_cpu_id))
> +
> +/*
> + * Helper functions of simple per-cpu operations.
> + *
> + * The kernel version differentiates __this_cpu_* from this_cpu_* for
> + * preemption/interrupt-safe contexts, but the userspace version defines them
> + * as the same.
> + */
> +
> +#define __this_cpu_add(key, field, val)	(this_cpu_value(key, field) += (val))
> +#define __this_cpu_sub(key, field, val)	(this_cpu_value(key, field) -= (val))
> +#define __this_cpu_inc(key, field)	(++this_cpu_value(key, field))
> +#define __this_cpu_dec(key, field)	(--this_cpu_value(key, field))
> +
> +#define this_cpu_add	__this_cpu_add
> +#define this_cpu_sub	__this_cpu_sub
> +#define this_cpu_inc	__this_cpu_inc
> +#define this_cpu_dec	__this_cpu_dec
> +
> +#endif /* __PERCPU_SIMULATE_H__ */
> -- 
> 2.50.1.487.gc89ff58d15-goog
> 
