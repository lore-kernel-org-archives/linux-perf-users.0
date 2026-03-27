Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BFD78F4A;
	Fri, 27 Mar 2026 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614889; cv=none; b=TdDD7UcKPGThztRR6SgGQ1VaoG4UvRAjtegxYxkC5Yu/H6vUEYq2uICt247rgBaxCZXd6VBoeee+qv6uHX7B9uDNU3babaSax6ytujaEjnwWPRbzgqnsL2TInJEP/bDl3aq4hcLdui2BkhbdAuR7Fak1XGLe5XqstjXoL2L8oss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614889; c=relaxed/simple;
	bh=aNNPy9X6dHBmISyOMOWSmuY9wFdTR0/EvdWNKW8sBhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgJP0zRfSvaoyNaqSN/E1APTIJw9ILd300C6L/RQ+prNsQS2RCgDCI0wn2l849ldq6NlBzBU/Ljs2RTn0CgQix6eJmABFsLROLbElIc/BzWmgXtFppOD2AeWskP110CgKUvA+BYTQ6xmPwmeWbg9sGUG4b2AWk67v8SPsGhA0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jhi0IN5E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jhi0IN5E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V172qmXyMxUqiTmEpAP70Gu2MrSFMLYazv+QR9yfPUQ=; b=jhi0IN5EpHw3fHDXIgm1YBKjJa
	ZfmbbKyd8znWnRAkcr5d6dT7qkbWfF2FLsaYppm7mPxL9K47WekuVtuU7XzIGPTl4fb0/CBybA5AN
	i3dV2FCHyUpX0jNaI33aqSb1hWyR+4IHW/9GLD6IagbbNFT7uFitUFOXa6hDwHfNAzi+NGKei4Wms
	u2jyfaAsd9+2PDyrCu5nhBNigriI4awwtVB+VNrj4gWcfOSXpo+scX8I4HTEOZ1QUdoJtK0wKXt6y
	7XR68xv5qcaQMyh7Hks7RrVxBSa7QsYzoMiUjqspIn3Y/khO0qnDWmqLeEwSBVGW2qKrpAcx0RJKn
	eWGjohcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w66Ob-00000001nlO-1z2k;
	Fri, 27 Mar 2026 12:34:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB666300E56; Fri, 27 Mar 2026 13:34:35 +0100 (CET)
Date: Fri, 27 Mar 2026 13:34:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: yuhaocheng035@gmail.com
Cc: Qing Wang <wangqing7171@gmail.com>, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <20260327123435.GS2872@noisy.programming.kicks-ass.net>
References: <20260326112821.GK3738786@noisy.programming.kicks-ass.net>
 <20260327122953.64466-1-yuhaocheng035@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327122953.64466-1-yuhaocheng035@gmail.com>

On Fri, Mar 27, 2026 at 08:29:52PM +0800, yuhaocheng035@gmail.com wrote:
> From: Haocheng Yu <yuhaocheng035@gmail.com>
> 
> Syzkaller reported a refcount_t: addition on 0; use-after-free warning
> in perf_mmap.
> 
> The issue is caused by a race condition between a failing mmap() setup
> and a concurrent mmap() on a dependent event (e.g., using output
> redirection).
> 
> In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
> event->rb with the mmap_mutex held. The mutex is then released to
> perform map_range().
> 
> If map_range() fails, perf_mmap_close() is called to clean up.
> However, since the mutex was dropped, another thread attaching to
> this event (via inherited events or output redirection) can acquire
> the mutex, observe the valid event->rb pointer, and attempt to
> increment its reference count. If the cleanup path has already
> dropped the reference count to zero, this results in a
> use-after-free or refcount saturation warning.
> 
> Fix this by extending the scope of mmap_mutex to cover the
> map_range() call. This ensures that the ring buffer initialization
> and mapping (or cleanup on failure) happens atomically effectively,
> preventing other threads from accessing a half-initialized or
> dying ring buffer.
> 
> v2:
> Because expanding the guarded region would cause the event->mmap_mutex
> to be acquired repeatedly in the perf_mmap_close function, potentially
> leading to a self deadlock, the original logic of perf_mmap_close was
> retained, and the mutex-holding logic was modified to obtain the
> perf_mmap_close_locked function.
> 
> v3:
> The fix is made smaller by passing the parameter "holds_event_mmap_mutex"
> to perf_mmap_close.
> 
> v4:
> This problem is solved in a smarter way.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>

You can't claim this as your patch. I was the one who wrote it --
yesterday.
