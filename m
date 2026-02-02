Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D3026A0B9;
	Mon,  2 Feb 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040749; cv=none; b=KVh1rkJ4cbRFggHeopKmZxTZBZnliGV01FmCO+6E/yDMXn7fnyJWrOsppu1F37J8Lb5X37lbmEtegsW/TxcQfC65IS/lkvDlx+5Cz/L4nRctR7lyMW/yO1UdP29m5muuAWnbFlh9M02Ws5bGaH9Nfep2SGfTEI0UaqRELcBMLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040749; c=relaxed/simple;
	bh=7Mt7SC+/PMbTIxgFiOzf3zgpAnpRJnl4exxO/EnT2M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t31H+PQxBiHSrZpl7VuXz9MWoAr9dg+7GkzXKs8zgwVJf00QDYi36HBEmOXEL5vKEU/UiYG8E/EabRc0nmbnWU0IFW2xS7erB5vE6TmTlMo4Em3v9fA66qJ89MCbRqNleHxAF0aWt7jHZ4Y/OdeQdQwZIFPgDHmHCKi+5kEvymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A8hyHRat; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A8hyHRat"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ccPhIxLV9jWcvieuPnHzHl1ZIVAfSDTpiz2OGy9VMOc=; b=A8hyHRatY7NNakGgQrJnJgJWGd
	bWBOpw0aaddHG1jdvu0YnOqvQTKEwY8ExNcMrUrnk4JoFxVPU4JMYr3acWC555Nc4o5Xtn3OC6bnF
	K+iBy9s8p424qgb2Q12BWtBhHLRQIU3PJilXSYiL0oSEQIpTT4IguWnOxMRnt7rCPyKW3MMctnQwx
	RInvvWBEvQnlTuzI2r02BUZskeOLPlMpuGfQYm++uIHgGHtzxI5ywqx/sdIgL9GksuROHWLbf2l4x
	ymmo21K3gZWZdub/1+vcDvjHsiupELoz8+arUBbDAKS362N/MoJWL1ueVL1xxe5uxZXIgzsQxI4Gx
	G6RlIDXg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmuSD-0000000EYU6-1Ndv;
	Mon, 02 Feb 2026 13:59:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AACC63008E2; Mon, 02 Feb 2026 14:58:59 +0100 (CET)
Date: Mon, 2 Feb 2026 14:58:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Haocheng Yu <yuhaocheng035@gmail.com>
Cc: acme@kernel.org, security@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <20260202135859.GH1395266@noisy.programming.kicks-ass.net>
References: <2026020157-crayfish-distract-7da1@gregkh>
 <20260202075120.4005-1-yuhaocheng035@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202075120.4005-1-yuhaocheng035@gmail.com>

On Mon, Feb 02, 2026 at 03:44:35PM +0800, Haocheng Yu wrote:
> Syzkaller reported a refcount_t: addition on 0; use-after-free warning
> in perf_mmap.
> 
> The issue is caused by a race condition between mmap() and event
> teardown. In perf_mmap(), the ring_buffer (rb) is accessed via
> map_range() after the mmap_mutex is released. If another thread
> closes the event or detaches the buffer during this window, the
> reference count of rb can drop to zero, leading to a UAF or
> refcount saturation when map_range() or subsequent logic attempts
> to use it.

So you're saying this is something like:

	Thread-1		Thread-2

	mmap(fd)
				close(fd) / ioctl(fd, IOC_SET_OUTPUT)


I don't think close() is possible, because mmap() should have a
reference on the struct file from fget(), no?

That leaves the ioctl(), let me go have a peek.
