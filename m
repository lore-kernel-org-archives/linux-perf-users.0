Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22F22DC43;
	Thu, 16 Jan 2025 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056959; cv=none; b=Q8YKEXGbLA+cOWoS24qw12YRqXJWSCqp8sblYEnIKnsmJMj3RT9A2pzBsQgvg46DI2XYvG1PrvSP7BcSdgkvdFyfDAa63UmU/oGI/hEqqEguOkbbwmSDyeOUwn4XKcNTPTBYPLNOJhSkoV+Up8C0a2xFlVKWNfzvOpSaLkrXz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056959; c=relaxed/simple;
	bh=BWdxef5Vjb4w2vbz2p7Uo0bd0P/bK/JdtvzdW/cXoUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGozBexVCJYahWknJrO0Kfe7/Az5eab2Hj22qbNBwCKdmUNZB8XqmQQvMia2BYuGBfoeSNfjV7fGtS/AP5uq+Dj36KUiFQTGricCpsq+h3GR8+me8wrh8SlWgclezJSe2KRhCOvFt+f7WfQQAj92wkprRQgovVAkXlYrTmSHz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF67FC4CED6;
	Thu, 16 Jan 2025 19:49:17 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:49:23 -0500
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
Message-ID: <20250116144923.6b8cda97@gandalf.local.home>
In-Reply-To: <20250116144341.7e883931@gandalf.local.home>
References: <20250116132359.1f20cdec@gandalf.local.home>
	<20250116144341.7e883931@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 14:43:41 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I also tested this only with the above define in mmflags.h and just added
> it to kmem.h before sending out. It appears there's a bug in the
> TRACE_EVENT_ENUM define that doesn't translate the TRACE_SYSTEM properly
> and it created the same variable used for both kmem.h and mmflags.h and the
> build failed.
> 
> So v2 will also include a fix to TRACE_DEFINE_ENUM().

Never mind. It appears that the kmem.h includes mmflags.h :-p

Well, the TRACE_DEFINE_ENUM() still needs to be fixed, but that could wait
for the next merge window.

-- Steve
