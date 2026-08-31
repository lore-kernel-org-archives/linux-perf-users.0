Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBA36F917;
	Mon, 31 Aug 2026 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214310; cv=none; b=aS21KoQWpQYMSq8jfy3rHwnvwl+Vqmy4qdtuAXn2RnAe46RFJiXdxNa2YOk6NXbPJHlx/VDcnWLJaA6TSjYb93q99OSO+TeIdmDufK8l6nQ78sjsRssZHdMFJ4os3L3OdPrCL1X7Ypu3iY+WNMb+FaNSke1sqFPvubC3DGsdu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214310; c=relaxed/simple;
	bh=DVG+MNpzWKf+1XCRF11lgi+JI7uj2/QQObp9LBq220A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FrlN6v1dZjv+sTGoSN2hK2fbnWpZXg5Q116BmTp6wg0J8nFXdtR5Hlmb272AKCN0wPb/TCe/e5wgjpYKwXozZ6o9IkEdb/oxFbp3bgTLLnehZHIG/i6Tz5souAuYPmhCB39arTm/lN3K+JOhnIZ5NzuZMOzrOBdrTLoz7TgLOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJGf/Evf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJGf/Evf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897A81F000E9;
	Mon, 31 Aug 2026 22:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214309;
	bh=RS4glFFdY1gLGmE8+lSVip51TLlerbXRaRrB/4BAIgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZJGf/EvfojHyDhwXYFae+AFZRYPW5j/Q01dFJb4IzmTRaXRz3UEwmocQ+/I6APThm
	 qyPi6GhYG15KgtHn3W7OKu+coyTjdWHqkCCxrEt/Ro0gbaiwHiPKyAs3PsZiGechN7
	 pkTDn4qVkWoX5DfyReCeHPUjoiO1L6B8/9nbv7JRvniqLKs1CkGg31Hc5UD/cnjuUP
	 QY/l0zp0KsTauUegIM5AwrZIPwohJ1VnmHzblDAs0QfELba5Kq04mdxDLsduO1AzJS
	 tFNiNUaEhTkpxMpUEFJKMNsB5DbFKmZAVDMzw3WZ/yrxxwqsqYILqWAQq60k5CeGxZ
	 X0cu8mIHq0Dww==
Date: Tue, 1 Sep 2026 07:11:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing/probes: Fix anon_stack check for unnamed
 bitfields in btf_find_struct_member
Message-Id: <20260901071142.9fac09b9553bcf8eedca6404@kernel.org>
In-Reply-To: <20260831130133.3018b81a@gandalf.local.home>
References: <178818875393.104360.1469039168635349344.stgit@devnote2>
	<178818876548.104360.13229872396750615226.stgit@devnote2>
	<20260831130133.3018b81a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 13:01:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  1 Sep 2026 00:06:05 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > btf_find_struct_member() traverses into nested anonymous structures
> > and unions by pushing members with !member->name_off onto anon_stack.
> > However, it does not consider the unnamed bitfields (e.g. `int : 5`
> > or `unsigned int : 0`) which also have member->name_off == 0.
> > 
> > If such an unnamed bitfield is pushed to anon_stack, the
> > btf_find_struct_member() return an error even if there are other
> > valid entries in anon_stack.
> > 
> > To fix this, only push unnamed struct/union members to anon_stack.
> > Also move the btf_type_is_struct() check to the entry of this function
> > because now it is sure only struct/union are pushed to anon_stack.
> > 
> 
> Should we add Reported-by and a link to the Sashiko report?

Ah, good point! Let me add it (and I forgot Cc: stable)

> 
> > Fixes: 302db0f5b3d8 ("tracing/probes: Add a function to search a member of a struct/union")
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
