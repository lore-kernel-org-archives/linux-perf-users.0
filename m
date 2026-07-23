Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA1399360;
	Thu, 23 Jul 2026 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831674; cv=none; b=HNQZ5+UqZwRe1Vp7yj1bUnblScTKjAbhSBG2z90dX9iH1GxeB9KOk35DdrDhhys14ttl51chwqvCKPYsI9E9CUHirNyp6to0kHSQIEXvRg8+S06SjIS2cBLBx5VeGIoDJTrNDA2oEjzIdR03AOJarDv/rxrnwhoMqoNCEDF7+ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831674; c=relaxed/simple;
	bh=L8rxxAoyzpo5rDtnuFxZSy622jwcI3Gd8MoKcvqqayo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VamRbftD/lEYrveWw44ffSH6mOkL9nJXJHbYCx01bgnhjIygmpHUZjRYZAjWcJKqewirmD1HvC+YUZQsY3QnZFA+Yn/2aymdNYyLs/XpQlG69NmYUaR6xI52d/aJmgczPcf76cql56Fv9jQmBqAxRqf10SaT4rJ1h5VHzELACBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A24511A0155;
	Thu, 23 Jul 2026 18:34:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 5936E20026;
	Thu, 23 Jul 2026 18:34:24 +0000 (UTC)
Date: Thu, 23 Jul 2026 14:34:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v10 02/11] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Message-ID: <20260723143447.0f4c765a@gandalf.local.home>
In-Reply-To: <178476137184.26117.2239692963036759209.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
	<178476137184.26117.2239692963036759209.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: s71tn6hwen31oog911q4zk3r49kk348s
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 5936E20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+TXBPlhzXPwil3xxef2eVFP9RiAzl8Da0=
X-HE-Tag: 1784831664-507099
X-HE-Meta: U2FsdGVkX1+oAkzTWu3SNLn9lwimicljXyBTSeRQzDEmpgUxvtTLNJdGxXMIsrZv4ufG56N0sG+W3Y/dtsUZWFKUsTxcqtOths+gXx3gmq123HdubgGS4JjBMdGFWXBiRbDM9M7kzY0zuTvIsmVpFbOjzOvKliUpnosRxngJjicYOOiRROuLIyZH1XDkNN6SFWyTFqSCR4P6qyyfnPQjJumdcSD22NoyE3e4BuqLKAaKUavUJaYXb87T3/WlhfH5oRqf1MF/LFGVmW4rM3Pu0IJnYobr2xk6hdkTUscXeGAo0Iboc5EsSfaNV2DX9znKF3tQXD2vk08+HZSKE87vsQ39Zeq+4/lo

On Thu, 23 Jul 2026 08:02:51 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index b58c2565024f..d9b6fa5c35d9 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -866,6 +866,7 @@ config WPROBE_EVENTS
>  	bool "Enable wprobe-based dynamic events"
>  	depends on TRACING
>  	depends on HAVE_HW_BREAKPOINT
> +	depends on HAVE_POST_BREAKPOINT_HOOK
>  	select PROBE_EVENTS
>  	select DYNAMIC_EVENTS
>  	help

Is this really needed as a hard dependency?

Is it just because you want to guarantee it happens after the breakpoint?
What's wrong if it happens just before it changes? We should probably have
a way to note it's before. But isn't it still useful to know *where* it was
changed?

-- Steve
