Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5D42F6FA;
	Fri, 14 Aug 2026 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699253; cv=none; b=UqJ5SAmK1UDFHaSyfwEjGDSY+H2uf1JuJs/0uq4AF2sclDe+HWXlPi6q/pNtu1lyq97KS0P/POY75G9u9Q2cqRdOHBXS9xrQILS/uRk/rzpGavsq7rqxwA48gZW3qBL8hD1SRec+H8WtuJt37KYG2e2hFPXgYqmcDaDmRHYgSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699253; c=relaxed/simple;
	bh=1KhXvLEDkEAicVP5moGfyxxsylfCzN/Ap/dIUreDcBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPAkhnZOU0WZmgXpS+OTyGAMIu4Lg67v7dqipQgfpoLZDPfKjlKE5uJ/xq1nQhubJX20pBUESxJgge3Rr2xjiY/1rU0MUKCcK9vkLUUgwapfxtEZw+uVJkCoWcnv4aqc9LPP0xC73yReVyJkTiDN6wjav3+zmOJ8Dpa0D3EwkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6jfXMFF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hz3xYgGZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6jfXMFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hz3xYgGZ"
Date: Fri, 14 Aug 2026 11:20:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786699250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMg+8hkApl7/3tTo/irXs19wXzhS0ibwiO7UcbWOpxA=;
	b=S6jfXMFFGQPoQAtV8USjz/Ngb8NIfhbP8rPrrUfo0/jgkHW1G9HQ2DkAx3uK43DfMIBauZ
	lF0chHwYusow8/B3EhjYSbJapGAm+rApi+umNyxbbVq05RA4N0nJ9dvtwP/1vcJgDI9g0K
	himUp9Lq4xGjXO8GkCID9GlWQdvz3rxKC/R6m5DpvT4ClCiLRq6mmnR4EvN6lyUfK5/SLe
	1Qk75LftRysUmjXrTpTPphNHaU7RtPbb7az/CwOJM+WR8cn/VjEDtuI6kl054FseWQ42vw
	xmB13i8TvjjGFpSuiiBDBUlDFjfIQaAupHxH0nCOJfZwOBm45Y+7ZuoOIkKtIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786699250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMg+8hkApl7/3tTo/irXs19wXzhS0ibwiO7UcbWOpxA=;
	b=hz3xYgGZdECixFiiEAInQQgdc3jbXWIsQsC4+jkGisBPU5nnJBp+HZ824wUXNq/4hgNa6z
	QkBjgL2NBBWt+xDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <20260814092049.EHIf1eeX@linutronix.de>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260814090304.558901F0155A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814090304.558901F0155A@smtp.kernel.org>

On 2026-08-14 09:03:03 [+0000], sashiko-bot@kernel.org wrote:
> > +	if (xchg_relaxed(&bp->hw.arch_hw_notif_busy, 1) ||
> > +	    WARN_ON_ONCE(task_work_add(current, &bp->hw.arch_hw_notif, TWA_RESUME)))
> [Severity: High]
> Will using TWA_RESUME here cause a hang if a hardware watchpoint is triggered
> during a blocking syscall like futex() or read()?
> 
> When a blocking syscall accesses watched memory (e.g., via get_user()), the
> watchpoint synchronously triggers and queues the SIGTRAP task work via
> task_work_add(). Since TWA_RESUME only sets TIF_NOTIFY_RESUME, and
> signal_pending() ignores TIF_NOTIFY_RESUME, the syscall wait loop will not
> abort. 
> 
> Does this need to use TWA_SIGNAL instead so that TIF_NOTIFY_SIGNAL is set and
> the interruptible sleep correctly aborts to deliver the pending task work?

Well, this only means that the signal will be delivered once the syscall
handling is complete. I don't see a reason why the syscall should be
interrupted just to deliver the signal right away. The logic should not
be affected by delivering the signal immediately.

> > +		put_event(bp);
> > +}
> > +#endif

Sebastian
