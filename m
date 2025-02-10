Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596D3596B;
	Mon, 10 Feb 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176623; cv=none; b=JOIOEFTWF2TJQ/NX+cdmtJfMwysrzHYsxx0zGoGUe5XjQFL+RzLgzsEioHapDcZhUFPQ4Zw4dnkdnn7hDgf/Uyz8bTETahoZnwFJZwzP7XbqiK0BVJkL3bgvi1hMKDx6URPzQ9z+HnsTorufGGfGPe1b3e0weYPZ5LnoRnXiT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176623; c=relaxed/simple;
	bh=2iwD3ZEvbdIO4qk4UTDAAEUBV4AoZEmQkboLmjxKyJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va5haDfiApJb4v0rI5C0cWVkY1PV/phMnmzuYEJ+8V5WkkWjvbynkW2QVUaOr0KsABg8DPg7SitFvHUTZPGvmT2vZad3zVxrM9yHcsldBf5KmhdaXh29UMWp1Sux6aSeUyLE7QUxbe67awNFqV5Zzn1LQ4ICumlK5dWAj65gCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LLKTJLeY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LLKTJLeY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WLKs6FvEA8ppT+vocSep98qzS2+vdvyoXITHWSECYPs=; b=LLKTJLeY1Uz779cRnvJcpJaRqj
	aMs8HpiDROFPOzQ1ZpYv4ImbeIrWRA+XxUnh934BgRKVMVoYLBIKjd0kDd3nXBBZBpCyUkuwxyzw1
	utRw43yDLj3yF5e5a/xfDAlNADu9uk9XQR0fhleSkWe7npw2pRFQutzXKvYe81aCocJnrGsuc4POK
	BU+6xBwcxAaB7BYOVIw5WLRgWnTcjTT1k7uiL9AlTLgepIOeZQ5pEkpInFGAITqaXVgzmxvqefMab
	MpPMhuJl7PI+SjAiLzgZlMYh4AsUUaHJpKxcnMd4Wc94b7O6xzB/fTbEYcYwvXon0o5DJ7AHIiAl2
	5tVe2OFw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thPHd-000000006I8-2z1h;
	Mon, 10 Feb 2025 08:36:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 91DB0300318; Mon, 10 Feb 2025 09:36:48 +0100 (CET)
Date: Mon, 10 Feb 2025 09:36:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	shuah@kernel.org
Subject: Re: [RFC PATCH] perf/core: Prevent dereferencing NULL pointer
Message-ID: <20250210083648.GB10324@noisy.programming.kicks-ass.net>
References: <20250205190608.93508-1-richard120310@gmail.com>
 <20250206080520.GG7145@noisy.programming.kicks-ass.net>
 <Z6mz1A804NXZpFm-@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6mz1A804NXZpFm-@vaxr-BM6660-BM6360>

On Mon, Feb 10, 2025 at 04:07:48PM +0800, I Hsin Cheng wrote:
> On Thu, Feb 06, 2025 at 09:05:20AM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 06, 2025 at 03:06:08AM +0800, I Hsin Cheng wrote:
> > > According to coverity scan check, there's possible cases where
> > > "ring_buffer_get()" returns a NULL in "perf_mmap_close".
> > 
> > That makes no sense. Having a mmap should pin the buffer.
> > 
> > > Use a "BUG_ON()" to check for NULL pointer existence, panic if it does
> > > exist, otherwise it's safe to dereference "rb" and access its members.
> > 
> > How the hell is a BUG_ON() any better than a NULL deref?
> > 
> 
> Hi Peter,
> 
> Thanks for the review ! I get it so I think this issue reported by
> coverity scan should be marked as false positive or disgard.
> 
> > That makes no sense. Having a mmap should pin the buffer.
> 
> I see, so if I understand correctly, the "event" in perf_mmap_close()
> is guaranteed to have available buffer and the buffer's refcount is 
> zero, so returning a NULL will never happen right?

Right, the vma / mapping has a refcount on the event, the event has a
refcount on the buffer, and event->mmap_count is incremented, which
makes sure event->rb isn't changd.

So yes, at the time of perf_mmap_close() it *should* be impossible for
ring_buffer_get() to return NULL.
