Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EF3128A6;
	Wed, 29 Oct 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726013; cv=none; b=qk95LacpAE7P6Euu97cBVx/nJ3uFJAQQHvA057C2mpA7aF8BrZRbEw4BaJXKzG+eiZ3CV36vKItNnzrYzzt5Mw+ngG6Avtbyptlp97zvxH6JLxWEfJC25LISONrriLqRA7LOCAkjhwD1VcSeh7vCtXbDdgVIiOr+NndPjPb4q/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726013; c=relaxed/simple;
	bh=2KtQfpwXxBgRt5H6xF9pV7eRjqbrJ70Ux995ibkvkWI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cqbMweYympypwE760PzejCdjrE27LKhCuTcsrxR91Ku3bI5YD4nA5mn6xfv5SrXsQcJ1/i6P/0QViMPFKM2C3J535ErvsQftziuR+iCx/b59KSK5/1nmjqr0JURHdtkCoRIt+ItiCnB0knJENDzU+JssjJVR5P+H1/LOrHVih8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzzWL/h0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzzWL/h0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629B0C4CEF7;
	Wed, 29 Oct 2025 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761726011;
	bh=2KtQfpwXxBgRt5H6xF9pV7eRjqbrJ70Ux995ibkvkWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QzzWL/h0ApZ2tjPgLdIF2nyFUg5JHfMCUSLlS6lKzOcpR26PScHzwympwMCN0jO6x
	 EwuMCtMNmiP0X1hjllNwTmVPgsM6kSDrIQcRTbkx9EsSN45Pscam7mMNXA94ykKBsd
	 D4lGQYtee13ZjrBFr42AWF3CngaOnvEObnKLIav8/AUImxRYO8ov+XYpzYxXd74dO+
	 Sg7nsxp2Uv++lx+nVgsb8SHyz641ddSSFPe4jRP608YnhnBRrMPVHcsGfRvFq0fJRN
	 +J0jfXg2eNnqHW9g3B3CK/3Lh88dJrs7e2K6XvbQU0UFbtAopv2eBBDAfg/j7U1XMl
	 J7JqyDxHnNjYg==
Date: Wed, 29 Oct 2025 17:20:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mark Brown <broonie@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, x86@kernel.org, Jinchao Wang
 <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/8] selftests: tracing: Add a basic testcase for
 wprobe
Message-Id: <20251029172004.a0aca144735f20a6a59d2aa6@kernel.org>
In-Reply-To: <20251029114317.167b7d908533385c1c9e6782@kernel.org>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
	<175859026716.374439.14852239332989324292.stgit@devnote2>
	<aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
	<20251027224347.4c887cc956df63602f377550@kernel.org>
	<20251028084222.a3c1ae97d125d9bd88fc565b@kernel.org>
	<20251028105549.ae94e8eeb42f4efc183d2807@kernel.org>
	<20251029004219.dc9cda0eb56ae46c55855844@kernel.org>
	<20251029114317.167b7d908533385c1c9e6782@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 11:43:17 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Hmm, it seems that jiffies related things are updated frequently
> > and it may cause interrupt storm or infinit recursive call.
> 
> I added another trace_printk() in el1_watchpt(). It seems el1_watchpt()
> takes too long and there is no time to do any other things.
> (Note the interval shown below is only within the el1_watchpt function,
>  and in reality various processes (save/restore registers etc) for
>  exception handling will be inserted before and after.)

Forget about this. I found the root cause. The x86 watchpoint exception
happens after the instruction is executed, the arm64 happens before.

Thus what we need is to emulate or do single step the hooked instruction
and restart from the next instruction from the watchpoint exception on
arm64. I thought hw_breakpoint does that, but doesn't. Should we do this
in do_watchpoint() or in user_handler?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
