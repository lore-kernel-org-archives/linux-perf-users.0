Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD41BE49;
	Tue, 29 Oct 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207603; cv=none; b=H7dBeS4wgO/xstlIHEmf5xUA7zjrvF0T6kZ6TiJFZMNfBdZ2qzJG3VoNNdmYr8SbzVMfXNlnPlHNEzo31riXLOPw01JbNUiv+347rD0HtUALzpRUpefQuBDMFghwI6pr1B1Bq2vldeQmI9Va/GHI1iCThfzs2qbuuSPBBItZcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207603; c=relaxed/simple;
	bh=VAOZl2p8vMNlMi4Pu5eS5ZMUXsJHugRoTSXwRKJbPRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGM9ghluy1B1Dt7nhBAmv3kAlKV6uP+iTszBwlhAIgJtzpOAFW7Vq1GkaaapagbMayR6VM7dIUtoxsoSTw8Tl055Ma9FT/HIXO3ZPZqNGpkFD3vhrU6lUjj7eyqG5DwYXBEJ9qFjhfULvGRkC7cn628aMskW0JcU6Tnme6aEf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T60wDNHx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T60wDNHx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QSJoGwZEmbJZFq/ahM82qF8XpggSzckC2poVXBygGts=; b=T60wDNHxmT1RkNP6qiOQpscOVK
	Vnz1mrZYdiIL0ebv2VjzWPyJZJaQC4KHIboYY5VoVXspqp3wnNQHnbZSAXi1HzJozglJl/XQSLMAy
	689hCa3pcca9KSX1xFYXXYj3ty/JSgl3rYUPVHNShSYenJOfLUgKlaLhiWnBXy2KGbc8c7V25T+Ap
	t7alJeoEScKzwA/yTxAwZZ0yuNe5KhIq9USWs4IqEAM23G/5JASgLRgsexN4DRKzzntkZTrLLHEI2
	4PxVD+AdH3Dqmd1t/l5/1xloEcg9am8vQ28FUJLUsshUB21+6Ym0xOm9cvzfPi5GzHJR8dekWZaNs
	PhqBXDyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5m1v-00000009u5R-36Wp;
	Tue, 29 Oct 2024 13:13:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5F0A630073F; Tue, 29 Oct 2024 14:13:03 +0100 (CET)
Date: Tue, 29 Oct 2024 14:13:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 08/19] unwind/x86: Enable CONFIG_HAVE_UNWIND_USER_FP
Message-ID: <20241029131303.GW14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <2354d43022bd336c390e1e77f7cee68126d5f8c8.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2354d43022bd336c390e1e77f7cee68126d5f8c8.1730150953.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 02:47:35PM -0700, Josh Poimboeuf wrote:
> Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
> on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
> unwind_user interfaces can be used.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/Kconfig                   |  1 +
>  arch/x86/include/asm/unwind_user.h | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 arch/x86/include/asm/unwind_user.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0bdb7a394f59..f91098d6f535 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -289,6 +289,7 @@ config X86
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
>  	select HAVE_UNSTABLE_SCHED_CLOCK
> +	select HAVE_UNWIND_USER_FP		if X86_64
>  	select HAVE_USER_RETURN_NOTIFIER
>  	select HAVE_GENERIC_VDSO
>  	select VDSO_GETRANDOM			if X86_64
> diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
> new file mode 100644
> index 000000000000..19df26a65132
> --- /dev/null
> +++ b/arch/x86/include/asm/unwind_user.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_UNWIND_USER_H
> +#define _ASM_X86_UNWIND_USER_H
> +
> +#define ARCH_INIT_USER_FP_FRAME							\
> +	.ra_off		= (s32)sizeof(long) * -1,				\
> +	.cfa_off	= (s32)sizeof(long) * 2,				\
> +	.fp_off		= (s32)sizeof(long) * -2,				\
> +	.use_fp		= true,
> +
> +#endif /* _ASM_X86_UNWIND_USER_H */

What about compat / 32bit userspace?
