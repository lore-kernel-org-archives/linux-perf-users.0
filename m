Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5401953A2;
	Fri, 14 Mar 2025 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941546; cv=none; b=Hh32QyN6rQC7eXedhSYaDRO2mRcAET5oANRCrAxRQXIlCWVJUDVqQ3Q9yZt1ZM6RYBypM1+kB8h/gos/tBlyUVDbS1i6QTLr/s3NHKx1AWLvb/pZ3ygkxxkAZle/1G8svX4i5WRemRBZ7DDHck+wNA7kRsPBik9kZ3p/DRm0lBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941546; c=relaxed/simple;
	bh=JiGYGlFRMjz25k0U6B4LZbec1CkLkM/Na0aVV6Dtx3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlzR+X5ABR2cCA9Nxa8Y0y/9TI2nh1pBnx7jv2IoHqyJkWX/UgI31x3APFg8tiHdGCQfch3Krt91hZgvZvggDvdjh4bgmxuWGL++z5DfLvznvsEgqR6LYB2KPC7JontS4gBxRSKc3vHdhzXtDQ2uYK31xu5WpIISBD/I+DYPUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oemqRxxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oemqRxxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8DBC4CEE3;
	Fri, 14 Mar 2025 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741941546;
	bh=JiGYGlFRMjz25k0U6B4LZbec1CkLkM/Na0aVV6Dtx3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oemqRxxLwaMf+VZr4HX0s9mVGFYBEaelPDtxNN2uuLxdIOZaxTP3SPKQz010uKWrR
	 Oxu1pHNvmkdMqvgT74GIMe6Fu5FxWihsYT0MZ6i0i6wIo2iRa2aj4qU2g231c4Eyfl
	 TZyQzhdQVpWxEzpvuRbOp7nDSOFMSDopiAtRn0D0ipYO2GbN8GLIWpRtqkyOgLjY9A
	 pk3NzpA9wzaLpJeGw8EcnSQyoh/4OLMetSpI3oneP0e9YRcFmNWacKuIREV8EgPQpj
	 OO+BMRH/VxyCTltELcCPatLND7ESBnhtt8TFEF3Bl9O4h4UlQF98rurYKDxP9JftUK
	 EyTA7UQ9eOilQ==
Date: Fri, 14 Mar 2025 09:39:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Tao Chen <chen.dylane@linux.dev>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] perf/ring_buffer: Add EPOLLRDNORM flag for
 poll
Message-ID: <Z9PrJGbBYcMrvLWY@gmail.com>
References: <20250313051047.2436098-1-chen.dylane@linux.dev>
 <Z9Kt57aAC7XET7Na@gmail.com>
 <87b67a79-d97e-4f81-9bf2-aa34d613b5bf@linux.dev>
 <Z9MRWT5PWtPaY-pl@gmail.com>
 <Z9OVBCryv9Che8zJ@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9OVBCryv9Che8zJ@google.com>


* Namhyung Kim <namhyung@kernel.org> wrote:

> Hello,
> 
> On Thu, Mar 13, 2025 at 06:09:45PM +0100, Ingo Molnar wrote:
> > 
> > * Tao Chen <chen.dylane@linux.dev> wrote:
> > 
> > > 在 2025/3/13 18:05, Ingo Molnar 写道:
> > > > 
> > > > * Tao Chen <chen.dylane@linux.dev> wrote:
> > > > 
> > > > > The poll man page says POLLRDNORM is equivalent to POLLIN,
> > > > > so add EPOLLRDNORM here.
> > > > > 
> > > > > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > > > ---
> > > > >   kernel/events/ring_buffer.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > > > > index 59a52b1a1..5130b119d 100644
> > > > > --- a/kernel/events/ring_buffer.c
> > > > > +++ b/kernel/events/ring_buffer.c
> > > > > @@ -19,7 +19,7 @@
> > > > >   static void perf_output_wakeup(struct perf_output_handle *handle)
> > > > >   {
> > > > > -	atomic_set(&handle->rb->poll, EPOLLIN);
> > > > > +	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
> > > > 
> > > > So what does EPOLLRDNORM mean to begin with? There doesn't seem to be
> > > > separate/specific handling of it anywhere in the kernel that I can
> > > > see...
> > > > 
> > > 
> > > It seems that if user set pollfd with POLLRDNORM, perf_poll will not return
> > > until timeout even if perf_output_wakeup called, whereas POLLIN returns.
> > 
> > Mind adding this to the changelog, and explain that this patch fixes 
> > this particular poll() functionality and semantics for userspace?
> 
> Off topic, but I think it should return something (either POLLHUP or
> POLLERR) when the event goes to an error state like pinned events are
> not scheduled.

Mind sending a patch for that?

Thanks,

	Ingo
