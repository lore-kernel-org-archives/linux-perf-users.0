Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD117B421;
	Wed,  2 Oct 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877104; cv=none; b=sXROzgG7/QsX7ckqHgoLja6TXSCMvNFdC/MH5qwUEZxNQpGS0BbjzA+e3WTn+QFOb07eN+csKvC+U4KJRe7pBgm+BH7o32JBH/kHdslmrBuVG0Efvu9ZcpIf/+qkQnNBL9xTk5l3PJx08ab5NYRL1H12E0pX32SYzThfJ4HlbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877104; c=relaxed/simple;
	bh=iYZ51yo4oP4WIWkH3LDpV0Hr+cmnsGVtUfu3EXBQxGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+zNzoUIdoGy5c6TGURuD+ScFc/9zhfb6SU1CMK1XR17x0iMIhxBPXzSPSVPXI0pwe2Py0IiDZSHpUzRAabl069SjrZ4r+OIUy16tSwLrzTGktVkxtMW1k5ViUuhQKMoamTtmOrWVN29wo3saCPYqdjWcBEjHoKPMfAoP/B8XGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7ylJifx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7ylJifx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8981FC4CECE;
	Wed,  2 Oct 2024 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727877103;
	bh=iYZ51yo4oP4WIWkH3LDpV0Hr+cmnsGVtUfu3EXBQxGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7ylJifx7YTEnD2KxxbU3EmlGuDYee9JWuGoQzpH9tVp9vyn8/fNY9+KSYqAwdshV
	 jh+gj7FJ+RGF0MJTkC9rInOEBEGQb4K/O8xPOPHDCkMZo5xk7OA5J5e0JQo65vOoaz
	 1xoxeMI6muRR8Dp23qfGT1rNbDs8U65XL4yBp+TtodzJXDYwkOEFDIOXGTzUFgHEW3
	 k69jtcYDiKOAEzNr7uuvugBMxcZJhw/pH+HjuZjN7U6y9bqmEJNLHWiQxnofbGy+sS
	 vVRx0+JN7zhc+LNiG6e5PWAkki1LTAU56SUmenW4/uXOLaPclIqTOjzeuKfMxnFgX1
	 D9pOHhfiN6Z9w==
Date: Wed, 2 Oct 2024 15:51:41 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] perf: Fix event leak upon exec and file release
Message-ID: <Zv1P7UzPWvFjOupc@localhost.localdomain>
References: <5cc313bc-c44d-4f6c-80ee-5a9fe9356f43@stanley.mountain>
 <ZtYyXG4fYbUdoBpk@pavilion.home>
 <20240930090439.3IgzQVzB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930090439.3IgzQVzB@linutronix.de>

Le Mon, Sep 30, 2024 at 11:04:39AM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-09-02 23:47:08 [+0200], Frederic Weisbecker wrote:
> > Ah right.
> > 
> > So one possible fix is to possibly let the task work do the last reference
> > decrement. This would mean that freeing children events can't be always assumed
> > by the parent.
> > 
> > The below (only built tested) would do it?
> 
> This looks nice based on diffstat. I didn't look closed nor did any
> testing so far. Do we like it and wait for Dan here or?

No eventually I think the issues reported by Dan can't happen because:

pl330_free_chan_resources() <- disables preempt
-> pl330_release_channel()
   -> _free_event()
      -> perf_pending_task_sync()

That's another _free_event that is not related to perf.

Two and three:
perf_remove_from_context() <- disables preempt
__perf_event_exit_context() <- disables preempt
-> __perf_remove_from_context()
   -> perf_group_detach()
      -> perf_put_aux_event()
         -> put_event()
            -> _free_event()
               -> perf_pending_task_sync()

Four:
perf_free_event() <- disables preempt
-> perf_group_detach()
   -> perf_put_aux_event()
      -> put_event()
         -> _free_event()
            -> perf_pending_task_sync()


The put_event() calls here and above can't be the last ones. Because
if an event is attached to an aux event, detaching from it means that
aux event itself hasn't even gone through perf_event_remove_from_context().

Similarly an exiting aux event detaching the events from it means those attached
events haven't gone through perf_event_remove_from_context().

So this should be fine (famous last words). There is a might_sleep() call in
irq_work_sync() that should tell us about it.

Thanks.
