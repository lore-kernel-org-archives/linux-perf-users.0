Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F11DED42;
	Mon, 14 Sep 2026 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789363516; cv=none; b=TKh7XjBd120YLI3Iv3XYsHL4Xf8S4ZRyOcjNzxr01fbRZFKWfULx1omUozkGlC4R0C2Rb79tXn9GahTcwrrWWmfpgBlijUhmZbaJloeqyVrVitka42pExoUhT4wlT6f84cOaehopEd40T73iEnWiS5/969vHV8FgYHVEn2RoREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789363516; c=relaxed/simple;
	bh=r4kWyzgvFwIeVgCg37+kX+AH8VTAFyeQJt7wUmrPusg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J4FLTInpF274KgY32i5d5gUoeMJjd4QxiO6PAcSE2YZgK7Sf9kHN8OTz8Z9cPrm3D0z9xk14rqL4AY1XqIyVU/a0t8bHg6ueTKlNf49kUBzqELMZT35nJR9HeHxwoYznGrwsmwmhF6zU/N4GbF4amed6NkpTz5l1oJS5wvLEmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT2U/VtG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT2U/VtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822A01F000FF;
	Mon, 14 Sep 2026 05:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789363514;
	bh=hqan0NVWc1HQxdNwE3P314UxIWRFhHCzTru45muAuIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KT2U/VtGlsE1S+EZSAUPnwTN+Uqcraag6+k5RtOICkdkXL2Rt5vx4QqnmRU55ABN3
	 Wz1hYTf51/mI2GrHV8+dlgSsg0RXOXCmsKvLkMQe1nd4U547zyji9Y6jT7CKPFhZ17
	 ZrgbEnrWOqdqWFgowDCfrHNYVTfg2cqDCE4bihC/VVYdyFD6ycY5JKersR91A0r/Ur
	 C9rFotDsTSqFVoZFhu2jRUyi73BVGNiEJEhBj30cx4zDwqGj8unzT6jt73X+aho/EF
	 oCwz9EX3IlEDaoTGGQXtMShVa/58w85oKxM2pYO+fqm3IJ+Rw5X6yUfHwq7qQf/BQe
	 lR7mbN/vbKM1g==
Date: Mon, 14 Sep 2026 14:25:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v15 05/12] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Message-Id: <20260914142511.e8c56e55f2f35c8becfb679d@kernel.org>
In-Reply-To: <20260907041503.A6DB71F00A3A@smtp.kernel.org>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
	<178875283469.93794.8082169522481243792.stgit@devnote2>
	<20260907041503.A6DB71F00A3A@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 07 Sep 2026 04:15:03 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The `readme_msg` in `trace.c` instructs users to write to `wprobe_events`, but this file is never created.
> --
> 
> commit 5c44f59e0b2737617a0b5934e625357ecffcc63d
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/wprobe: Add wprobe (watchpoint probe) trace event support
> 
> This commit introduces hardware-breakpoint-based dynamic trace event support
> (wprobe). It creates dynamic events on data read/write accesses using
> hardware breakpoints and logs the access context and fetchargs.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index a946e0183fd1e..40c3e1543f6e3 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4294,8 +4294,12 @@ static const char readme_msg[] =
> >  	"  uprobe_events\t\t- Create/append/remove/show the userspace dynamic events\n"
> >  	"\t\t\t  Write into this file to define/undefine new trace events.\n"
> >  #endif
> > +#ifdef CONFIG_WPROBE_EVENTS
> > +	"  wprobe_events\t\t- Create/append/remove/show the hardware breakpoint dynamic events\n"
> > +	"\t\t\t  Write into this file to define/undefine new trace events.\n"
> 
> [Severity: Low]
> Does this advertise a non-existent interface file to the user?
> 
> The readme_msg instructs users to write to wprobe_events, but it appears
> this file is never created by this patch.

Ah, indeed. this is for dynamic_events interface.

Thanks,

> 
> > +#endif
> >  #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS) || \
> > -    defined(CONFIG_FPROBE_EVENTS)
> > +	defined(CONFIG_FPROBE_EVENTS) || defined(CONFIG_WPROBE_EVENTS)
> >  	"\t  accepts: event-definitions (one definition per line)\n"
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178875277830.93794.14247844688761142429.stgit@devnote2?part=5


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
