Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291222E3364;
	Fri, 14 Mar 2025 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741919496; cv=none; b=l5weY1VjNp2PKaWdjtaVyo4y+zxbkycZXg87bAO9KdqCGdrmJgvpPAwYgXnEWmj3ef9bkgfrvhYG8iQgydC0wtFjD2s9znWgOaWIAqfXs9ND14kMwrcYy5XbSQcIgmPkLIjteay1TNlrfDXAu4Qvty0On7PdBkNNXqApf+/Lyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741919496; c=relaxed/simple;
	bh=YFKY0xWZlUGNFe2as1LwPSewqDllYxJVBjjLUfKTjfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQY4kOc6gmCMIJdU9BCGe+raehWZjcSffvY5pZUznmjNr0V2DY6DsGXWJPNIEF5dlHais0X2jhRyOCu4Ep3NQiYR/OnTCWAukIAqk6Fpm0Q4U2WAh/F5OM3e4acDZ7o4At0li3A/lqY54gsTaO5qTq0UOpfNukDzQFfjTVc9XdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYyRj/Hj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYyRj/Hj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB62C4CEDD;
	Fri, 14 Mar 2025 02:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741919494;
	bh=YFKY0xWZlUGNFe2as1LwPSewqDllYxJVBjjLUfKTjfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYyRj/Hjk8cO8UrRrhi2Rq/2C5xl/2UovL7BPZIav8qXhF5kBxaJNFXppDmWFgz79
	 phBDiy/Ro4rJMUf3aHzvyu36PfEL1PjoiHSyvdkWlm7/kL2hdeJOvO+CNq4bjZatrc
	 QpNaHAoWh6XuEDal/jr4zKuuiu4b81+cmy6zu8EuRN0Ss/+Ke7TVRoQ3hBOLjGymMx
	 g1/vIxtvOySeFlebenx1oxEenxSGOZugLI9NBkCh9lMoIpN9BAFdEI9B0aX8VvL7yl
	 bCW/GniGMO5bE0p3MV6ffBo8J72qD/yar3at5TbGFfZHnfHWZxzSD3kO+aXrXv/kqF
	 dNVRp3O0ZLSUg==
Date: Thu, 13 Mar 2025 19:31:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Tao Chen <chen.dylane@linux.dev>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] perf/ring_buffer: Add EPOLLRDNORM flag for
 poll
Message-ID: <Z9OVBCryv9Che8zJ@google.com>
References: <20250313051047.2436098-1-chen.dylane@linux.dev>
 <Z9Kt57aAC7XET7Na@gmail.com>
 <87b67a79-d97e-4f81-9bf2-aa34d613b5bf@linux.dev>
 <Z9MRWT5PWtPaY-pl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9MRWT5PWtPaY-pl@gmail.com>

Hello,

On Thu, Mar 13, 2025 at 06:09:45PM +0100, Ingo Molnar wrote:
> 
> * Tao Chen <chen.dylane@linux.dev> wrote:
> 
> > 在 2025/3/13 18:05, Ingo Molnar 写道:
> > > 
> > > * Tao Chen <chen.dylane@linux.dev> wrote:
> > > 
> > > > The poll man page says POLLRDNORM is equivalent to POLLIN,
> > > > so add EPOLLRDNORM here.
> > > > 
> > > > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > > ---
> > > >   kernel/events/ring_buffer.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > > > index 59a52b1a1..5130b119d 100644
> > > > --- a/kernel/events/ring_buffer.c
> > > > +++ b/kernel/events/ring_buffer.c
> > > > @@ -19,7 +19,7 @@
> > > >   static void perf_output_wakeup(struct perf_output_handle *handle)
> > > >   {
> > > > -	atomic_set(&handle->rb->poll, EPOLLIN);
> > > > +	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
> > > 
> > > So what does EPOLLRDNORM mean to begin with? There doesn't seem to be
> > > separate/specific handling of it anywhere in the kernel that I can
> > > see...
> > > 
> > 
> > It seems that if user set pollfd with POLLRDNORM, perf_poll will not return
> > until timeout even if perf_output_wakeup called, whereas POLLIN returns.
> 
> Mind adding this to the changelog, and explain that this patch fixes 
> this particular poll() functionality and semantics for userspace?

Off topic, but I think it should return something (either POLLHUP or
POLLERR) when the event goes to an error state like pinned events are
not scheduled.

Thanks,
Namhyung

