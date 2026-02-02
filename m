Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EEA1E9B35;
	Mon,  2 Feb 2026 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042981; cv=none; b=iLb/vrln/P9RMxQjBa9y46lKmBtZoiUopFn9j3xX/PGHzkHoL/+a3lVnmR+0rLJ232tSjDIZ/hlb2WcPGQW+o6oeJppMoPW3nUUPlWpTtjLcERgQ+Yuftm39A3A5o2NBKxhveI5/eBPAooLGBzZUeD7SQwquv45fts/nVQABPU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042981; c=relaxed/simple;
	bh=0f30wbCfuB0Qm9WAe6h4ADmYD6K4Pfzb4tPU6KUt9sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVbTWrTXOH3g3yKrDG5LKLyVdv+PWkhno2vKS1LsdI90g+0sHJhSB8hPXukzrdpT2tEjMFFfzf+JXFzLQs+HfNMqcRW2CTzC5eLm5QwJqvJcBBkyCHad3AOtdnm2jhzjX05fOY+FuHQBMtD+nnPkQVj1bhYfLeooUzJeSkI7c60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O/QJSxtY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/QJSxtY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G1CnxeO+mlHu0BUWJZtrI1k8fHfgl+N4V+vbd791xBo=; b=O/QJSxtYeAMgx/fiahT/4oZh+7
	uUMa1muNm4MqT+4La4uSIRSfsKm0re+cajO+RnR55CNjEWbLatC/P/TS+g3zwW6pSL4ng+dk7Ci6Z
	h9tZMn2GE7naWZESdercB1X71XLYEplUtk3rzHjJLXNo08ojNfpW+G9XPmhZf50Opj5zXC/5+7vwN
	UXE5LCc3lquI6PmNoawN3w7J1ngfOeQfEzwGbzokKh9PRzXBTpy+fz7dF45VaVZPU/NTsgDAw1WyJ
	ATqupkZwlRljAHgEZyoYetcQKN0EJqudZ66lqVNQJpJcfrBadpre5WyxAOJ6K+jTi0AW0/PRRtxQC
	wMg/V2IA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmv2H-0000000EcDM-07hG;
	Mon, 02 Feb 2026 14:36:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC4743008E2; Mon, 02 Feb 2026 15:36:15 +0100 (CET)
Date: Mon, 2 Feb 2026 15:36:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Haocheng Yu <yuhaocheng035@gmail.com>
Cc: acme@kernel.org, security@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <20260202143615.GC1395416@noisy.programming.kicks-ass.net>
References: <2026020157-crayfish-distract-7da1@gregkh>
 <20260202075120.4005-1-yuhaocheng035@gmail.com>
 <20260202135859.GH1395266@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202135859.GH1395266@noisy.programming.kicks-ass.net>

On Mon, Feb 02, 2026 at 02:58:59PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 03:44:35PM +0800, Haocheng Yu wrote:
> > Syzkaller reported a refcount_t: addition on 0; use-after-free warning
> > in perf_mmap.
> > 
> > The issue is caused by a race condition between mmap() and event
> > teardown. In perf_mmap(), the ring_buffer (rb) is accessed via
> > map_range() after the mmap_mutex is released. If another thread
> > closes the event or detaches the buffer during this window, the
> > reference count of rb can drop to zero, leading to a UAF or
> > refcount saturation when map_range() or subsequent logic attempts
> > to use it.
> 
> So you're saying this is something like:
> 
> 	Thread-1		Thread-2
> 
> 	mmap(fd)
> 				close(fd) / ioctl(fd, IOC_SET_OUTPUT)
> 
> 
> I don't think close() is possible, because mmap() should have a
> reference on the struct file from fget(), no?
> 
> That leaves the ioctl(), let me go have a peek.

I'm not seeing it; once perf_mmap_rb() completes, we should have
event->mmap_count != 0, and this the IOC_SET_OUTPUT will fail.

Please provide a better explanation.
