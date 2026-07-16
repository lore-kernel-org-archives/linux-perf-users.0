Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5B279907;
	Thu, 16 Jul 2026 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161500; cv=none; b=YhvhfBqS4UkDOxRdf/7bhMMqNPb+JCQpdOBGsgnQMbWeI1mfVrf6prMrs0ukOgY5XqfxD21HUZC/7WJiRtGFCY/vYPaXbEKumorFU1Yw4OqxfHNW/q3nZ3XOkkoTSoojxXAy+ca1Btie/yNcUm8pbE4mo4m3YaQ8ALU66Jc552E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161500; c=relaxed/simple;
	bh=vFhzWOa8IwJMFMWct1x4naiw61ngcZA5BK6SlAuLKio=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UY9MUpczS3GXzYj27ZeOJnX5sL7IBz0EUr8DM3aqqjF2pT6QHfDE690R/OxufMm0Hf+dq0bW9mA//o04g7l8zWVEzm7UZBzTKbGMNaYCFSp2MCiIoFxyCO7B/UHeHRHhDUyJTlbO3QH3ff9N+XxawqxfDBHO6h4mki5lZv5UvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwXt+3kH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwXt+3kH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9161F000E9;
	Thu, 16 Jul 2026 00:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161498;
	bh=OJu0HhHU10rHHooJBRLXkyxM4deBEcJfoZDMqS4tCi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WwXt+3kHqgUO8MMxSPTEibi1OYrssxLNgUMSPdsl/pWIsESaIydWxT0k6LHratWaf
	 HNzGSlNNFV/8nHfopXJLODXPAFFcFYBc4ONZxOceitE/UbhXScrDMY+HInPsM+cQ8S
	 oKWKFxUE3PefSWT+nNEPS6dYf9v/4EyUDtvF//0TDoEhS1VrTIByRhcIcrAWdflLVC
	 4NwaMS636hlHBcELSq13OG1gZhx6G/f3CsIFU2/CYhYTUlc6V5OsTjb6oGYyQOWTEe
	 F+MadzwHymlV+/ycbd+Gyo5tNpOCnPkIaHfDElxuPS/IVbG4MftJtvj5WrWZxQrvbA
	 vv7bsC+f5GoLQ==
Date: Thu, 16 Jul 2026 09:24:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 05/10] tracing: wprobe: Use a new
 seq_print_ip_sym_offset() wrapper
Message-Id: <20260716092452.e46ebf990962138e3b4c58f7@kernel.org>
In-Reply-To: <178407989708.95826.17630423823637072384.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
	<178407989708.95826.17630423823637072384.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Oops, I missed to fold this in the 1st patch...
(the seq_print_ip_sym_offset() part is already folded)

Thanks,

On Wed, 15 Jul 2026 10:44:57 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use a new seq_print_ip_sym_offset() wrapper function instead of
> using TRACE_ITER(SYM_OFFSET) mask directly.
> 
> Link: https://lore.kernel.org/all/176226550596.59499.18020648957674458755.stgit@devnote2/
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_wprobe.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index b52f3eac719f..dd310a87b333 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
> @@ -20,6 +20,7 @@
>  #include <asm/ptrace.h>
>  
>  #include "trace_dynevent.h"
> +#include "trace_output.h"
>  #include "trace_probe.h"
>  #include "trace_probe_kernel.h"
>  #include "trace_probe_tmpl.h"
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
