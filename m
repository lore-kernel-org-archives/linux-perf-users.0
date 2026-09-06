Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67731355B;
	Sun,  6 Sep 2026 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788699807; cv=none; b=DU2yRHAhv75hXAfhO/ppbczMHKxnamdAIzdha7MHiA1iOqolz2ctz8tC13VOIp2OatWwUBKULG+7AsFy1y4jS/iIWgH8atvwW5FWK8cPi9vTH1d/i3QzS2PLiXGdhbmHAvjubH36E41AvgqmreWJ2y4W0EiVCiNcxKB+hto7IYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788699807; c=relaxed/simple;
	bh=AOHshmq757rovW6nizQDM3mlfccaqdkN+Obm1sG9e9w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DhBbV3SRChu3p0tFmaF8GgyuVfl5Mcbsxiai36IlQP3Fq+DzgFD8/PzsswK4wkxH9PvJ8CJQrdfu1xixhgvygsiq3Zb4QMGbHTBnjDFBkwueQLk0C1ebCtITfeaAVbDzHUpDkoIS5Pvh5ZqanPHTreHRvg8BgRGoFZFHOFLWnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2PLDsdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2PLDsdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B851F00A3A;
	Sun,  6 Sep 2026 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788699805;
	bh=lfwXdUEBhA4p7kgiuvjkzX+edkew4c2koaS4Cks8Mcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M2PLDsdmgNmMeLzinbvFuxNqAf24D3IDOy4soCcvSGceIMuo5vR6bhEAytlpCY65P
	 VH/8NqESaRaSxCPH+9IQBHbRex7KF3o+gDslHnKMQKOh9cjXB0XrtQajQ27+C1S6we
	 vbOi+plTRPwL6E3Eqq68DvkyVrfGPHug90X78fPxwBlLDlIoVgoPZCTWy8jGtta42P
	 WbA2gFs9QsRUMAaWZBWSoQRfUoDhzDExFsj4MtMD9+uidSrJxqQhcFnDvcRP2Y/UVJ
	 83sgBoL900OcwaVgMBb81RDabMEgdMt9pWfzJQsCLmnXwN28SC0W6mssGJDekJ+zWA
	 fp9nuKLMRPHmA==
Date: Sun, 6 Sep 2026 22:03:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v14 01/14] x86/mce: Fix hardware debug register
 corruption on task migration
Message-Id: <20260906220320.9d19131a69f3227fdd07e026@kernel.org>
In-Reply-To: <20260830144005.C28ED1F000E9@smtp.kernel.org>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
	<178810002334.64882.15357388305843450280.stgit@devnote2>
	<20260830144005.C28ED1F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 14:40:05 +0000
sashiko-bot@kernel.org wrote:

> >  static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
> >  {
> >  	irqentry_state_t irq_state;
> > +	unsigned long dr7;
> >  
> >  	WARN_ON_ONCE(user_mode(regs));
> >  
> > @@ -2118,18 +2119,24 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
> >  	if (mca_cfg.initialized && mce_check_crashing_cpu())
> >  		return;
> >  
> > +	dr7 = local_db_save();
> 
> [Severity: High]
> Does moving local_db_save() below the early checks in
> exc_machine_check_kernel() expose this early #MC entry code to hardware
> breakpoints?
> 
> If a privileged user sets a hardware data breakpoint on a kernel variable
> accessed here, such as mca_cfg.initialized or variables inside
> mce_check_crashing_cpu(), a #DB exception could fire in kernel mode.

Ah, good catch! This can happen if we introduce wprobe.

> 
> If a Machine Check Exception (#MC) then occurs and preempts the #DB handler,
> it switches to the #MC IST stack. Because local_db_save() is not called
> until after these variable accesses, the code could trigger a nested #DB
> exception.
> 
> Since x86 uses a fixed-size Interrupt Stack Table (IST) for #DB exceptions
> that unconditionally resets the stack pointer to the top of the #DB IST
> stack, wouldn't the nested #DB overwrite the active stack frame of the
> interrupted #DB handler, leading to a fatal crash when it attempts to
> return?
> 
> Could local_db_save() be called at the very beginning of
> exc_machine_check_kernel() to prevent this IST stack corruption?

Yes, I will fix it.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
