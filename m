Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369626A0A4;
	Thu, 13 Mar 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885791; cv=none; b=PCGkN0zNpYkUhTKjS0SR1gpTr74DCjxbmXFnVFJnD1+6Rffj96TRnuisFZyzhpXFvv82AVZqwIDu2orA08DcmxoVgirhUkPQp/Qjqbaj87T+mec4BjSrgkCTAn9v3iVAPIWi6GRrPRax7i1jT/EEFwomKKcsNmPak4+IvrwkHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885791; c=relaxed/simple;
	bh=sAqPeaaP78JXfLlIvaZj0VRL43aWerSGG4s5j0yVKS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2a1+DuHExHGr9bsRCzlBg00/WIqlVoRs48FvhHT2I+z6o/OwX07ek4WvNyZ3RG9g65N7umIX9bq7nuXgAxN2zfVUJIgKps05v3wSdZgFDHgqXUZITmJy/EGKBiNZ2Y/4xUUjn5vCD2IovGShFzb3h9mFm8XZDRGirv7DAlEGvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIddFRKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIddFRKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE2FC4CEE9;
	Thu, 13 Mar 2025 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885791;
	bh=sAqPeaaP78JXfLlIvaZj0VRL43aWerSGG4s5j0yVKS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIddFRKel0caC56WFEnasFaM9S0AIIOHInn/ADrJkrwLPYgTZbsw/OqYsyeiGzFf6
	 6V+bNm3J/6bFtFhjWoyAZWr4NgYFLJmG3hZXrUqvoNho1by8oLb2j+8PmWfu1k9zBI
	 jsC14SepH+lVbpztAqfuDXSGITQOa+xqyydCsoPm6ovRNN1Hb438gZM5fzA5kny7Q4
	 hGmRXlJHQgOc/+wdFnZ4gZ+9nzZfUJrGhyHnYy7T647jFNIB/Ap80rTXqGFtWwg4EK
	 JtjUHFKWtLVRJkfOBpytGx5maa9pJAv4UGJgStpIRknBTvHWW2FkVC1fVR/CF9bLi2
	 8/4jFFBS30gfQ==
Date: Thu, 13 Mar 2025 18:09:45 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] perf/ring_buffer: Add EPOLLRDNORM flag for
 poll
Message-ID: <Z9MRWT5PWtPaY-pl@gmail.com>
References: <20250313051047.2436098-1-chen.dylane@linux.dev>
 <Z9Kt57aAC7XET7Na@gmail.com>
 <87b67a79-d97e-4f81-9bf2-aa34d613b5bf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87b67a79-d97e-4f81-9bf2-aa34d613b5bf@linux.dev>


* Tao Chen <chen.dylane@linux.dev> wrote:

> 在 2025/3/13 18:05, Ingo Molnar 写道:
> > 
> > * Tao Chen <chen.dylane@linux.dev> wrote:
> > 
> > > The poll man page says POLLRDNORM is equivalent to POLLIN,
> > > so add EPOLLRDNORM here.
> > > 
> > > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > ---
> > >   kernel/events/ring_buffer.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > > index 59a52b1a1..5130b119d 100644
> > > --- a/kernel/events/ring_buffer.c
> > > +++ b/kernel/events/ring_buffer.c
> > > @@ -19,7 +19,7 @@
> > >   static void perf_output_wakeup(struct perf_output_handle *handle)
> > >   {
> > > -	atomic_set(&handle->rb->poll, EPOLLIN);
> > > +	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
> > 
> > So what does EPOLLRDNORM mean to begin with? There doesn't seem to be
> > separate/specific handling of it anywhere in the kernel that I can
> > see...
> > 
> 
> It seems that if user set pollfd with POLLRDNORM, perf_poll will not return
> until timeout even if perf_output_wakeup called, whereas POLLIN returns.

Mind adding this to the changelog, and explain that this patch fixes 
this particular poll() functionality and semantics for userspace?

Thanks,

	Ingo
