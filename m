Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA429E10B
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935629; cv=none; b=GoT25I2azZq4N8EcLV7wwubJfpPDDG7g+sUTxB2q/UVxrh1g8Abq6wHVcJkixxZ1TnMHzbcl+YlV5IQOadZ10QlQAh020Aiq1HuZ7iNFfvkVcpqpHdY00hc4h1uGtPCh+VaOd6KfQazjBqjqyY+vddmtdspGqOPzxDOK3L04I5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935629; c=relaxed/simple;
	bh=UJpM2EBBy09iW0VKqVgTYIBbH+2X32aMG408yDCSGyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+0k7jXIbRLGr4+M7wO737M2+j4UsYiV8izeYBsLNUJlA/I91g14RPNLmlSq9OEr7Qerg/aA9f9Nb0tNe3odHK79iVj5padWhvFV4d3wjvWullIsRyUl5GHdPy8CDSn0CihVCZsO1UsthEeB9ZJy0LOcT1ao2/Xkq2ygfVepduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG8hcZeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG8hcZeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1A61F000E9;
	Fri, 28 Aug 2026 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787935627;
	bh=hpVTo1zHttp89dIFmHc94B4OfvhxA8UA8rOKAaoYQKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BG8hcZeYD3Wo1uY4xjRScNKWycOau9K6yGkajjA/02qCuORkNq+z5lzaAsN9tZKjV
	 2/59qlL2Y2uzsdw7r8ktHcxnPdffpTa0wLQs9wbZr4yF5eVhO3pxE/qBEzEXh0gqMQ
	 CHHbAmOPK49XYX5wNGhIZlmEJFSb7TskxZsfIoLp34ga8fbMb3WeXUFjq/mQzW2xLH
	 DfNy0hQaV0s0ezzCGm8Y/bDpMk2UEd22bseQ4U516bEbtbt6Rohg06Sm/3hyHXOksM
	 D+VgiTn7C6RsGWT8dldIv6mPthDog3YTizz3ImvItvus+w6pE9Jtcv7igXm3RwOXdg
	 oKtgXCCzUzBBA==
Date: Fri, 28 Aug 2026 09:47:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Gennady Kupava <gennady.kupava@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
Message-ID: <apG7ifoxTzqJIjix@google.com>
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apCyQ93c48Dy4H-S@google.com>

On Thu, Aug 27, 2026 at 02:55:15PM -0700, Namhyung Kim wrote:
> Hello,
> 
> Thanks a lot for your detailed report!  It's good but let me jump into
> the action items directly.
> 
> On Fri, Aug 21, 2026 at 10:49:59PM +0100, Gennady Kupava wrote:
> [SNIP]
> > Suggestions and questions
> > =========================
> > 
> > 1. Kernel: the fix that was applied to the kernel-side call chain -
> >    passing iregs rather than the modified regs - looks like it applies
> >    verbatim to PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER.  Should
> >    those be derived from iregs too when the event requests a user stack
> >    dump?  If the precise IP is worth keeping in the sample regardless,
> >    should such samples carry a flag, so that userspace knows the IP and the
> >    stack do not belong together?  Today nothing distinguishes them.
> 
> As Ravi said, you can check the misc field if the IP is from precise
> events.
> 
> And there's PERF_SAMPLE_REGS_INTR which I believe captures registers
> from the interrupt handler.  I don't remember why we have both REGS_USER
> and REGS_INTR but it seems REGS_INTR would work for callchains.

Of course, it won't work when the interrupt was in kernel mode. :(

Thanks,
Namhyung
