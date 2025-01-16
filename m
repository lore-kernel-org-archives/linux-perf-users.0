Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15E15530B;
	Thu, 16 Jan 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053603; cv=none; b=iIdDGYbZs8VDFRHQq0ZbXt2Ifj/ROU4O7597WV118k2lIIICIgnVvQe3Kd7nNYMf/1MXaqbzFdwAijcOxQn8zPUcQxJplZRNexiUtjyELyzWGc1HYBE0fY7E4Ecj8/8fWX720G3d1zKEGryarLzazsIbbiuPUp+lXnlY70krOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053603; c=relaxed/simple;
	bh=+UimJFUSWVsAkLvg+TPivrauh13RMBYrcTcugluNouI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fW/lHi6DxGguDTfYiuLk9wiOe9e90N8g9xnZ7hoXRzhMSotIGCuaZtiU3uk69wU+90XNVxJcOhkV+WrHYD86oLb/kDgYdyPiU1+R60SZioCIzQVjtkiF43zfUUUSiFCEwt4dg1VD4mfqazk/yvHZwVtjU8pnihuBb72o0oLUNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF729C4CED6;
	Thu, 16 Jan 2025 18:53:21 +0000 (UTC)
Date: Thu, 16 Jan 2025 13:53:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michael Petlan <mpetlan@redhat.com>, Veronika
 Molnarova <vmolnaro@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tracing: gfp: Fix the GFP enum values shown for user
 space tracing tools
Message-ID: <20250116135327.64264109@gandalf.local.home>
In-Reply-To: <20250116132359.1f20cdec@gandalf.local.home>
References: <20250116132359.1f20cdec@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 13:23:59 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> +#define TRACE_DEFINE_GFP_FLAGS_GENERAL			\
> +	TRACE_DEFINE_ENUM(___GFP_DMA_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_HIGHMEM_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_DMA32_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_MOVABLE_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_RECLAIMABLE_BIT);	\
> +	TRACE_DEFINE_ENUM(___GFP_HIGH_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_IO_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_FS_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_ZERO_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_UNUSED_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_DIRECT_RECLAIM_BIT);	\
> +	TRACE_DEFINE_ENUM(___GFP_KSWAPD_RECLAIM_BIT);	\
> +	TRACE_DEFINE_ENUM(___GFP_WRITE_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_NOWARN_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_RETRY_MAYFAIL_BIT);	\
> +	TRACE_DEFINE_ENUM(___GFP_NOFAIL_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_NORETRY_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_MEMALLOC_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_COMP_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_NOMEMALLOC_BIT);	\
> +	TRACE_DEFINE_ENUM(___GFP_HARDWALL_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_THISNODE_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_ACCOUNT_BIT);		\
> +	TRACE_DEFINE_ENUM(___GFP_ZEROTAGS_BIT);		\

> +	TRACE_DEFINE_ENUM(___GFP_LAST_BIT);

Hmm, I don't think I need to include the LAST_BIT.

> +
> +#ifdef CONFIG_KASAN_HW_TAGS
> +# define TRACE_DEFINE_GFP_FLAGS_KASAN			\
> +	TRACE_DEFINE_ENUM(___GFP_SKIP_ZERO_BIT);	\
> +	TRACE_DEFINE_ENUM(___GFP_SKIP_KASAN_BIT);
> +#else
> +# define TRACE_DEFINE_GFP_FLAGS_KASAN
> +#endif
> +#ifdef CONFIG_LOCKDEP
> +# define TRACE_DEFINE_GFP_FLAGS_LOCKDEP			\
> +	TRACE_DEFINE_ENUM(___GFP_NOLOCKDEP_BIT);
> +#else
> +# define TRACE_DEFINE_GFP_FLAGS_LOCKDEP
> +#endif

I also missed adding CONFIG_SLAB_OBJ_EXT.

I'll send a v2 shortly.

-- Steve

> +
> +#define TRACE_DEFINE_GFP_FLAGS			\
> +	TRACE_DEFINE_GFP_FLAGS_GENERAL		\
> +	TRACE_DEFINE_GFP_FLAGS_KASAN		\
> +	TRACE_DEFINE_GFP_FLAGS_LOCKDEP
> +
>  /*
