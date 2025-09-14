Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9842A96;
	Sun, 14 Sep 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757857979; cv=none; b=LD9NiuKCSsVa1DBcxAGZx2kz93m8jJzx+wFmeeZ6qvOX/cEqTvJ46T9E/0MzucHgLVRFi9A277aFuuOEVWka+s03yy5vMjct4RcwlM5wOfVrhu0BeTkJsKt5kiHEJmZKzl6rVJvVNyx7fgFRL7gcMvBUg7eSOvLgXavdeP6ezRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757857979; c=relaxed/simple;
	bh=37L/puyV0GzSe9BaFG26DDCjfs3MDxprvSq5MtRjnW0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pZ8WMnQNlGpFw1qoBdZ5+rvoWc+rpcNZ4JOkDsVnHVoYF7Q1uVClA3tat19yrD3Mxn6SX8GlK3WCD1PcEgfXm53foNEXZDAo+k+fAyxq6DOcwvoQFKDy8hZWe35UEaZjCysicg4rhuTYA13P79u8QEKCJLkCAE825NUnL33MRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bECoVG1z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bECoVG1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA19C4CEF0;
	Sun, 14 Sep 2025 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757857979;
	bh=37L/puyV0GzSe9BaFG26DDCjfs3MDxprvSq5MtRjnW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bECoVG1zEMs+vWcw9+n+EsirVXp9fVwqwBw8pr1cnMHuKwtnpguud39cSqncKvSlM
	 5P9AiNSsWL0BS2rssgcNDHMdNOGjVL8INd/wucFte+qZQ7R2QOJ60Vem2/J0HBJRJ2
	 5uTK5KpwKceGpShpNyBM7I/EnLOKtJ4xmivDiE02IDf0PulJ0Je+Cn55zNvLvbdq8m
	 hQPJym74sUDYZL9SHdiuuXHEpfjdiBB3h2M5apKhi/dFDQog4u9Z0B0UMfkxrPjpuo
	 PzYNu+Q6q9N1EXXBzeVSfXGGbGDe31fYxRBO6+PjM23P+lNTUjX9ZAkT3i6TqMCK0c
	 GtI8DNHL7jraw==
Date: Sun, 14 Sep 2025 22:52:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, Alexander
 Potapenko <glider@google.com>, Jonathan Corbet <corbet@lwn.net>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Sami Tolvanen <samitolvanen@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Rong Xu
 <xur@google.com>, Naveen N Rao <naveen@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Andrii Nakryiko <andrii@kernel.org>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, llvm@lists.linux.dev, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/21] x86/hw_breakpoint: Unify breakpoint
 install/uninstall
Message-Id: <20250914225242.b289de4a30557fec718b8cc8@kernel.org>
In-Reply-To: <20250912101145.465708-2-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
	<20250912101145.465708-2-wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 18:11:11 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> Consolidate breakpoint management to reduce code duplication.
> The diffstat was misleading, so the stripped code size is compared instead.
> After refactoring, it is reduced from 11976 bytes to 11448 bytes on my
> x86_64 system built with clang.
> 
> This also makes it easier to introduce arch_reinstall_hw_breakpoint().
> 
> In addition, including linux/types.h to fix a missing build dependency.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  arch/x86/include/asm/hw_breakpoint.h |   6 ++
>  arch/x86/kernel/hw_breakpoint.c      | 141 +++++++++++++++------------
>  2 files changed, 84 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> index 0bc931cd0698..aa6adac6c3a2 100644
> --- a/arch/x86/include/asm/hw_breakpoint.h
> +++ b/arch/x86/include/asm/hw_breakpoint.h
> @@ -5,6 +5,7 @@
>  #include <uapi/asm/hw_breakpoint.h>
>  
>  #define	__ARCH_HW_BREAKPOINT_H
> +#include <linux/types.h>
>  
>  /*
>   * The name should probably be something dealt in
> @@ -18,6 +19,11 @@ struct arch_hw_breakpoint {
>  	u8		type;
>  };
>  
> +enum bp_slot_action {
> +	BP_SLOT_ACTION_INSTALL,
> +	BP_SLOT_ACTION_UNINSTALL,
> +};
> +
>  #include <linux/kdebug.h>
>  #include <linux/percpu.h>
>  #include <linux/list.h>
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index b01644c949b2..3658ace4bd8d 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -48,7 +48,6 @@ static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
>   */
>  static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
>  
> -
>  static inline unsigned long
>  __encode_dr7(int drnum, unsigned int len, unsigned int type)
>  {
> @@ -85,96 +84,112 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
>  }
>  
>  /*
> - * Install a perf counter breakpoint.
> - *
> - * We seek a free debug address register and use it for this
> - * breakpoint. Eventually we enable it in the debug control register.
> - *
> - * Atomic: we hold the counter->ctx->lock and we only handle variables
> - * and registers local to this cpu.
> + * We seek a slot and change it or keep it based on the action.
> + * Returns slot number on success, negative error on failure.
> + * Must be called with IRQs disabled.
>   */
> -int arch_install_hw_breakpoint(struct perf_event *bp)
> +static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
>  {
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> -	unsigned long *dr7;
> -	int i;
> -
> -	lockdep_assert_irqs_disabled();
> +	struct perf_event *old_bp;
> +	struct perf_event *new_bp;
> +	int slot;
> +
> +	switch (action) {
> +	case BP_SLOT_ACTION_INSTALL:
> +		old_bp = NULL;
> +		new_bp = bp;
> +		break;
> +	case BP_SLOT_ACTION_UNINSTALL:
> +		old_bp = bp;
> +		new_bp = NULL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
> -	for (i = 0; i < HBP_NUM; i++) {
> -		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> +	for (slot = 0; slot < HBP_NUM; slot++) {
> +		struct perf_event **curr = this_cpu_ptr(&bp_per_reg[slot]);
>  
> -		if (!*slot) {
> -			*slot = bp;
> -			break;
> +		if (*curr == old_bp) {
> +			*curr = new_bp;
> +			return slot;
>  		}
>  	}
>  
> -	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
> -		return -EBUSY;
> +	if (old_bp) {
> +		WARN_ONCE(1, "Can't find matching breakpoint slot");
> +		return -EINVAL;
> +	}
> +
> +	WARN_ONCE(1, "No free breakpoint slots");
> +	return -EBUSY;
> +}
> +
> +static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
> +{
> +	unsigned long dr7;
>  
> -	set_debugreg(info->address, i);
> -	__this_cpu_write(cpu_debugreg[i], info->address);
> +	set_debugreg(info->address, slot);
> +	__this_cpu_write(cpu_debugreg[slot], info->address);
>  
> -	dr7 = this_cpu_ptr(&cpu_dr7);
> -	*dr7 |= encode_dr7(i, info->len, info->type);
> +	dr7 = this_cpu_read(cpu_dr7);
> +	if (enable)
> +		dr7 |= encode_dr7(slot, info->len, info->type);
> +	else
> +		dr7 &= ~__encode_dr7(slot, info->len, info->type);
>  
>  	/*
> -	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 * Enabling:
> +	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
> +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
>  	 */
> +	if (enable)
> +		this_cpu_write(cpu_dr7, dr7);
> +
>  	barrier();
>  
> -	set_debugreg(*dr7, 7);
> +	set_debugreg(dr7, 7);
> +
>  	if (info->mask)
> -		amd_set_dr_addr_mask(info->mask, i);
> +		amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
>  
> -	return 0;
> +	/*
> +	 * Disabling:
> +	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
> +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	if (!enable)
> +		this_cpu_write(cpu_dr7, dr7);
>  }
>  
>  /*
> - * Uninstall the breakpoint contained in the given counter.
> - *
> - * First we search the debug address register it uses and then we disable
> - * it.
> - *
> - * Atomic: we hold the counter->ctx->lock and we only handle variables
> - * and registers local to this cpu.
> + * find suitable breakpoint slot and set it up based on the action
>   */
> -void arch_uninstall_hw_breakpoint(struct perf_event *bp)
> +static int arch_manage_bp(struct perf_event *bp, enum bp_slot_action action)
>  {
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> -	unsigned long dr7;
> -	int i;
> +	struct arch_hw_breakpoint *info;
> +	int slot;
>  
>  	lockdep_assert_irqs_disabled();
>  
> -	for (i = 0; i < HBP_NUM; i++) {
> -		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> -
> -		if (*slot == bp) {
> -			*slot = NULL;
> -			break;
> -		}
> -	}
> -
> -	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
> -		return;
> +	slot = manage_bp_slot(bp, action);
> +	if (slot < 0)
> +		return slot;
>  
> -	dr7 = this_cpu_read(cpu_dr7);
> -	dr7 &= ~__encode_dr7(i, info->len, info->type);
> +	info = counter_arch_bp(bp);
> +	setup_hwbp(info, slot, action != BP_SLOT_ACTION_UNINSTALL);
>  
> -	set_debugreg(dr7, 7);
> -	if (info->mask)
> -		amd_set_dr_addr_mask(0, i);
> +	return 0;
> +}
>  
> -	/*
> -	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
> -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> -	 */
> -	barrier();
> +int arch_install_hw_breakpoint(struct perf_event *bp)
> +{
> +	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
> +}
>  
> -	this_cpu_write(cpu_dr7, dr7);
> +void arch_uninstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
>  }
>  
>  static int arch_bp_generic_len(int x86_len)
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
