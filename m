Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EE3D76;
	Sat, 30 May 2026 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099664; cv=none; b=lYwVC08UhtNOMBc6K8MwaQkHPIP+563Mk1z+4Qr5LETuddllnVsQHeyTlk41Y7SoIK+eJ/aOFv0uoGe5iE95MSAhXxUTY0EDBuCds/Z1niIp5Zi1MaM6WX3YQz2srpl8ZXDyeSs0Wh0RmoHSz8JKbLhFXy8oVMFdQeRQ9nptH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099664; c=relaxed/simple;
	bh=Umdk9r2IMwHE4FQTiKFbwajkMjAYbDKDNZvKvzSO3Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9CWYbyuv1f1o52dLIEtxAOPS0w8NZRtubBQGN2l8twMVugpGNNvQCOkifvRwWzR3OCTFNERGj93rSU5u7yvzd6Z/AOLBzmAGvUa9pFyfjEnaQSDEi8ZIibYBDo37iowwtaRW5OiXKEUdZhWTXb8Hm1yQyYCNP6niaDHqjynnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9nOUbNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9nOUbNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FB01F00893;
	Sat, 30 May 2026 00:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780099663;
	bh=mJGI6HLh+yBdHlkNKIk1Z7EMEvjqYx2VHkukbIfxzKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d9nOUbNXr0jOIM7Cde0bqVomJnF20EGT3P6X0kOFoQhz+cxeDEGfY/SZ/cZC37PSl
	 BgJ7I2zHWktyj4e8IhGveGkIgCJjIJ77yDx1t1YBnaBQDxTZcj8QX2+IAcxbYlDPSd
	 7qfWPD+xyWEaIZUYqukKM+tjVdnz77d0d/5OIf6KFBERvUw4j1HrywLfGI2VbIfB5y
	 K3O9FOUhrvR6ZE2dhF876UFuieZNK96K8UQGk3SiYDOoqpORzBj8hmn2LU3QTVwcsj
	 Xrd0Y1vCxySSycEKRnW+dJZ57R5k6YtNh8XJ0mq0EbpIT+x1gIevJPYTwKvCkbZRY4
	 iAgoMxFfx7AKA==
Date: Fri, 29 May 2026 21:07:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
Message-ID: <ahoqS-hZDkAluO5a@x1>
References: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
 <20260507234959.EEC5BC2BCB8@smtp.kernel.org>
 <agAqESWvLdIJBErN@google.com>
 <agZgPBrlKZ655KdO@x1>
 <agq3PCt_FhxIYgQ8@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agq3PCt_FhxIYgQ8@google.com>

On Sun, May 17, 2026 at 11:52:44PM -0700, Namhyung Kim wrote:
> On Thu, May 14, 2026 at 08:52:28PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sat, May 09, 2026 at 11:47:45PM -0700, Namhyung Kim wrote:
> > > Hi Arnaldo,
> > > 
> > > On Thu, May 07, 2026 at 11:49:59PM +0000, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > - [High] Adding `-mcpu=v3` to `CLANG_OPTIONS` forces all BPF skeletons to use the BPF v3 ISA, breaking backward compatibility for perf tools designed to run on older kernels.
> > > > --
> > > > 
> > > > commit 2e8791aeccf694e1ae9ed9fda46e3a6f73332838
> > > > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > > 
> > > > perf build: compile BPF skeletons with -mcpu=v3
> > > > 
> > > > This commit adds -mcpu=v3 to CLANG_OPTIONS to support the atomic
> > > > cmpxchg instruction required by the lock_contention BPF program.
> > > > This forces Clang to emit BPF ISA v3 instructions during skeleton
> > > > compilation.
> > > > 
> > > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > > index cee19c923c060..a9a8c84b6b006 100644
> > > > > --- a/tools/perf/Makefile.perf
> > > > > +++ b/tools/perf/Makefile.perf
> > > > 
> > > > [ ... ]
> > > > 
> > > > > @@ -1195,7 +1195,7 @@ ifneq ($(CROSS_COMPILE),)
> > > > >  CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
> > > > >  endif
> > > > >  
> > > > > -CLANG_OPTIONS = -Wall
> > > > > +CLANG_OPTIONS = -Wall -mcpu=v3
> > > > 
> > > > Does this change break backward compatibility for other perf tools running
> > > > on older kernels?
> > > > 
> > > > Since CLANG_OPTIONS is used in the pattern rule for compiling all BPF
> > > > skeletons, this forces every BPF program in perf (such as
> > > > augmented_raw_syscalls.bpf.c and off_cpu.bpf.c) to target the BPF ISA v3.
> > > > 
> > > > Kernels older than 5.1 do not support v3 instructions and will reject
> > > > these programs during the verifier load phase.
> > > 
> > > I think it's old enough and we can move on to ensure v3 instructions.
> > 
> > Can I take this as an Reviewed-by or Acked-by?
> 
> Yep,
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

So this got refactored, Suchit, can you take a look at perf-tools-next
to see what is needed to have this in place after Ian's changes?

Thanks in advance,

- Arnaldo
