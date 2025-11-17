Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40141189F20;
	Mon, 17 Nov 2025 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763347591; cv=none; b=EGf5eogcRY8BAQOQQgf8joHv30i7+ckMSpjjC9kzbDt9wWmkMzRBWeymQ1AbFCgUDXFDJPbaQq3OnZFMzL6DPcPzueLSXwFHd5vZBD0G2VF+gDQnp24Zx5PdIjjkD4NWegZlZ4i7MNCToWK7Cqp2EWtLjzFhS2MSJGtd70yjSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763347591; c=relaxed/simple;
	bh=WckId20dWoL3Sm2pBxpsSPNRW6RlT7Dsm6IF/ZnMV/g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NoWCBOEYVNFnfQ21NE6NbKf5v7hoWRRvN/9px9Y/DzK/clQHl502YC2PDUI805lU/qAY+E/ggFwux6ljJpeefx4LOKdUKtCTE6qZi35QwPliZ+7zus6CcScAnS9/vh3SmR66G8WM9ktaoQoil3gX9ZapiMFOAAwWVk468MKBHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv4IAyaO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv4IAyaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A73C4CEF5;
	Mon, 17 Nov 2025 02:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763347590;
	bh=WckId20dWoL3Sm2pBxpsSPNRW6RlT7Dsm6IF/ZnMV/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jv4IAyaOD4AVcvfTrSXXHEBQWq8KCAZsS3yOCC2ZnSa5zb9dGp0KP5yw9+FkNhSXf
	 Apxz61+p14sURJhwVI6iUiRc69h5MBTw5i3wWuyKrzbLN4uTEMYFBwVGt9ZDrXMmBi
	 SOlUmJ3/3vhGqX0zd3OTjVJUj1eh8QAHYTlwh7xypVKk7iHspdR4kdfLvYbnsp4uoO
	 edfQ44DEBLWhjcTRBMH8cJNNQA0o5WFGgn8/SdAfWOUFoNU60L+dBGgXjYpWjCpbL6
	 qf4fG0tQVBbmRJMWv+kTiO0SluBlkGhXpgd2qghlM1dcPcACURQ5U4Hp2qELemiAzO
	 yey6qXzWDSfXg==
Date: Mon, 17 Nov 2025 11:46:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] tracing/wprobe: Fix to avoid inifinite watchpoint
 exception on arm64
Message-Id: <20251117114624.5fc972e65edac5bb91caa4b2@kernel.org>
In-Reply-To: <aRdWAshGkWjgXW3L@willie-the-truck>
References: <176179481538.959775.12326313742393696258.stgit@devnote2>
	<20251104223735.4164f224790ea0aea267dff1@kernel.org>
	<aRdWAshGkWjgXW3L@willie-the-truck>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 16:17:06 +0000
Will Deacon <will@kernel.org> wrote:

> On Tue, Nov 04, 2025 at 10:37:35PM +0900, Masami Hiramatsu wrote:
> > Gently ping.
> > 
> > There is a bugfix (or strange behavior) on arm64 hw breakpoint but
> > to fix it cleanly, it should change the perf itself (but I'm not
> > sure why arm64 changes the behavior only for the default overflow
> > handlers.) Anyone knows it?
> 
> It's because GDB expects to handle the stepping itself when using the
> ptrace interface (with a custom overflow handler to deliver SIGTRAP).

Hmm, would you mean GDB for user program?
If so, it expects hw breakpoint is used by:
 - user-space ptrace (for GDB)
 - kernel-space perf (must be default overflow handler)

And not expects to be used by 

 - kernel-space custom overflow handler

This series is to handle the third use case.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
