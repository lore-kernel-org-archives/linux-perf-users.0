Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB2155730;
	Mon, 16 Sep 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487183; cv=none; b=JlNQ+10oM7iE3EssjMUsVq6F9XhK7VRyJImNKW1E6oU/ESiAfVN1/Rb06V2DdEkx5sKj+4hgFOV7LVpEsn65gWWawUVLxlRy+gu3n+oWDc1es8/7WImINjUZRbsRD41nEKbKyrFYpU5+Hb0P54TLDmq2iHys/4gRW2GKHq0x3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487183; c=relaxed/simple;
	bh=sbwdwScUl1nDLrZ9f694UQMrrF3aVUrjfPSsNDjH6Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNcpMuV3I+CdNiAPuHrsxsnzMiV7hfzGIoRTaH/bmxCXnhuViELGgj1jHjthdOgzIq98QhvJaVwEEXoWP1z6mgvDbd13L6j9jY025ByzNPGnMWMzj37l4SxTne7id7thAON07bcpvA3k6REyOycl34tSSy9hzZByFzRMzBb4Hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ma5yb2gK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ma5yb2gK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=klhQKcXhmr+bixiRVjZjeBgikGPAXkhkBwFZl+Bvows=; b=ma5yb2gKWPFI+bVTDTUgLK3evw
	jUvBOfFup1b+Xq/Trv8zE3/RVN0a+M/NSahcIFNCf9+PLuOnuRQH5zdUGsWlDlmR5K/UYHz/FU770
	kF0H4FZ/504T+KC5JNcHeiKi4goFY4Le7UeCGcG9VKxMJNrYc8Q+hi9VmxcWC0QSud4PdqNxqn87F
	G5fV33bsE1sywTmQCpBaT4KmW2peYWwfBPLTUWGWAmLp18zYybQNW8AYM3z0CVK39Xfz2UwTPILtC
	zYrc0b8Y8uP6uJNHtdRd9mIGZ5BcmdtJcraA9ysCfqbPBfgvjpSMeJHLQKQ9kLpf2fCv8ZHtGNyOi
	sLjZtpMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sqABC-00000000Ni0-1z1g;
	Mon, 16 Sep 2024 11:46:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B87FE30049D; Mon, 16 Sep 2024 13:46:05 +0200 (CEST)
Date: Mon, 16 Sep 2024 13:46:05 +0200
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
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 02/11] unwind/x86: Add HAVE_USER_UNWIND
Message-ID: <20240916114605.GA4723@noisy.programming.kicks-ass.net>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <82ef19a767cb75e76a985ecc0d47a39400b4fdf5.1726268190.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ef19a767cb75e76a985ecc0d47a39400b4fdf5.1726268190.git.jpoimboe@kernel.org>

On Sat, Sep 14, 2024 at 01:02:04AM +0200, Josh Poimboeuf wrote:
> Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
> on x86, and enable HAVE_USER_UNWIND accordinlgy so the user unwind
> interfaces can be used.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/Kconfig                   |  1 +
>  arch/x86/include/asm/user_unwind.h | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 arch/x86/include/asm/user_unwind.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 007bab9f2a0e..266edff59058 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -286,6 +286,7 @@ config X86
>  	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
>  	select HAVE_UNSTABLE_SCHED_CLOCK
>  	select HAVE_USER_RETURN_NOTIFIER
> +	select HAVE_USER_UNWIND
>  	select HAVE_GENERIC_VDSO
>  	select VDSO_GETRANDOM			if X86_64
>  	select HOTPLUG_PARALLEL			if SMP && X86_64
> diff --git a/arch/x86/include/asm/user_unwind.h b/arch/x86/include/asm/user_unwind.h
> new file mode 100644
> index 000000000000..8c509c65cfb5
> --- /dev/null
> +++ b/arch/x86/include/asm/user_unwind.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_USER_UNWIND_H
> +#define _ASM_X86_USER_UNWIND_H
> +
> +#define ARCH_INIT_USER_FP_FRAME							\
> +	.ra_off		= (s32)sizeof(long) * -1,				\
> +	.cfa_off	= (s32)sizeof(long) * 2,				\
> +	.fp_off		= (s32)sizeof(long) * -2,				\
> +	.use_fp		= true,

What about compat crap?
