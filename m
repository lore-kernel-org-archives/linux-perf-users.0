Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1922E409;
	Thu, 16 Jan 2025 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056617; cv=none; b=Gp+7kxEK9oSdzdkxuWgfzuEIo7DgzEwcT2rz9kKAllocn3XpnSP2n/CKSn24FYishOxF7aOZG6tLGLPDz8VhYzhLswRHNgcxIR2xytQEVSFSyY8hhFgmM9bO8452PX/vojTCgorm6y8PIEJb+1gg9HeUsrAP/eFlE/BPYo4PN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056617; c=relaxed/simple;
	bh=VWszO4jc3ociyTuzq36Fz0y6UZPA4c8P9ihEQ1kFQVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMjAB/ImG2BhxlWR3IqhMLelq2Ug/ZybyZK9hngq+94xZwb9u23ogZ7wbDCIZFH7Lwy84BU9Wqfih6lvfCR/agtjUB1f6tn2w9nrrFrHxoxzg9UchhPqNoTAagJpJ20uWLUOQZ0kS39QnIPf/y8664oLqpGkI70sqFOjASlDZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32ABC4CED6;
	Thu, 16 Jan 2025 19:43:35 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:43:41 -0500
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
Message-ID: <20250116144341.7e883931@gandalf.local.home>
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

> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -9,6 +9,8 @@
>  #include <linux/tracepoint.h>
>  #include <trace/events/mmflags.h>
>  
> +TRACE_DEFINE_GFP_FLAGS

I also tested this only with the above define in mmflags.h and just added
it to kmem.h before sending out. It appears there's a bug in the
TRACE_EVENT_ENUM define that doesn't translate the TRACE_SYSTEM properly
and it created the same variable used for both kmem.h and mmflags.h and the
build failed.

So v2 will also include a fix to TRACE_DEFINE_ENUM().

-- Steve


> +
>  TRACE_EVENT(kmem_cache_alloc,
>  
>  	TP_PROTO(unsigned long call_site,
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index bb8a59c6caa2..522bbe3a5fe1 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -15,6 +15,8 @@
>  
>  #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
>  
> +TRACE_DEFINE_GFP_FLAGS
> +
>  #define __def_gfpflag_names			\
>  	gfpflag_string(GFP_TRANSHUGE),		\
>  	gfpflag_string(GFP_TRANSHUGE_LIGHT),	\
> -- 
