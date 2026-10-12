Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928A3E6DF4;
	Mon, 12 Oct 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801747; cv=none; b=K+3oDY8km+KpO2PvFo6eYQ8BcHWyPzuSh0jOv0wQaTZQV2pJDWm/irNrAvgAI8Kr1miS9Vp5JEcwUre6jCb7WztwT/QOhtlM0CAO6f4gPMKQxCLemWI1/4BME08WD2uxhc8AWeejQgFQNZ3AAP2JABl+B6Gr0TYYK3yKaiQaGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801747; c=relaxed/simple;
	bh=g17MXktF2GmX0zJd05Qf+GdkiWrqsJ8LPSoQLvkRA98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvrAjTA5T3W+o4kcYEsTEHj+Xp18f80a/b2aLKlYFBLE7fDxKHX6mtXBfyrB7OEwfNMw5YrigX+Qk144Er7fovBxjccM3TDvdz1lrfFJN8R2ILCwgh8y37bREvFkFRVPz5W7S4mI1g13tlRz/f209lxvJWEv53DItWzwRM0aIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vMGFuu61; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vMGFuu61"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d6ADhB5BJ6rgYWInDuDWi+047e4zYVau+QWZM7M+Y50=; b=vMGFuu614SZZfq5TH+UQelPyIf
	hh7EWQHdaWai5c1I9lUD7tDzd4TUCw8ipNXDfB8XZ2xkvNhrUllHvZPVr0QdB3Qw1XjDztwE7IB1k
	4UZmz3aiNjExhvStzLNE1ykTkBBrOVTeSTpbrCKcTBDSly7/wMJHWfTWR+iV6U8dpYK2kQu1mvSWM
	RQl/IiOAi3WnFbJOzdafRRjcuPe1MjJrwNXSTIh9Mgrq3V+xjSn9hrVzDuThCMhXCK0u7O0ocOVRD
	pOcDNAAtH9/jqwplmjDX20mbsvc+WMeP+fJcbnhpL6od48Ubr5nq4eAhHurUmrGuRdHb9D+CA0TUg
	1V4iSong==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGDTt-00000004NDI-3XU4;
	Mon, 12 Oct 2026 10:42:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C58A430063F; Mon, 12 Oct 2026 12:42:08 +0200 (CEST)
Date: Mon, 12 Oct 2026 12:42:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, sj@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, akpm@linux-foundation.org,
	lianux.mm@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/5] perf/core: add AUX buffer ownership for kernel
 events
Message-ID: <20261012104208.GQ4121339@noisy.programming.kicks-ass.net>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
 <20261009160010.1829642-2-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009160010.1829642-2-kunwu.chan@gmail.com>

On Fri, Oct 09, 2026 at 11:59:48PM +0800, Kunwu Chan wrote:
> Add an in-kernel AUX owner reference and setup/release helpers for
> kernel-created perf events that need an AUX buffer without a userspace
> mmap.  The setup path validates that the event is a kernel event with
> no parent, rejects non-power-of-two page counts and negative watermark
> values, allocates the perf buffer and AUX pages, records the kernel
> owner, and attaches the buffer under the same lock.
> 
> perf_event_release_aux() stops AUX writers, frees AUX storage, and
> detaches the buffer, in that order, matching the AUX teardown ordering
> of perf_mmap_close(): perf_pmu_output_stop() walks event->rb->event_list
> and rb_free_aux() must run while the buffer is still referenced by the
> event.  The single event->rb reference is dropped by
> ring_buffer_attach(event, NULL) itself, so the release path does not
> put it again.
> 
> Both functions run under event->mmap_mutex, the lock that already
> serialises ring-buffer attach/detach transitions for an event:
> perf_mmap(), perf_mmap_close(), _perf_event_set_output() and
> _free_event() all hold it around ring_buffer_attach().  Concurrent
> perf_event_release_aux() callers therefore go through the same
> serialisation point, and a second release call, or a release of a
> buffer this API does not own, is a no-op.
> 
> Keep aux_mmap_count dedicated to userspace mappings.
> perf_aux_output_begin() accepts a writer while either a userspace or kernel
> owner remains, preserving the existing teardown ordering.
> 

> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index c03c4f2eea57..760b7659ad87 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -48,6 +48,12 @@ struct perf_buffer {
>  	int				aux_nr_pages;
>  	int				aux_overwrite;
>  	refcount_t			aux_mmap_count;
> +	/*
> +	 * In-kernel AUX owner reference, set by perf_event_setup_aux():
> +	 * admits writers and ties the AUX teardown to
> +	 * perf_event_release_aux() when no userspace mmap holds the buffer.
> +	 */
> +	refcount_t			aux_kernel_count;
>  	unsigned long			aux_mmap_locked;
>  	void				(*free_aux)(void *);
>  	refcount_t			aux_refcount;

This doesn't make sense to me. If the even is a kernel event, then there
cannot be mmap users, so adding another refcount is just for giggles?
