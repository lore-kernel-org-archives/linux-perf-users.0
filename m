Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A43BE17E;
	Thu,  4 Jun 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581547; cv=none; b=WiibDqHvpBEVwfxAYh6cQ/f2AEGea7m53WG4jkzX8Hrh7J4W926zMSMj6tRMMTZGDy9enVSaiXRdzKMgby6nC1QsEyBw6YLztmZjbXYfMyl/92+S41aWafyv9JqNspwO3qDoRNvBIjlyRwjxEFJ9j34v8N+TyjKsjc9kayY3mVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581547; c=relaxed/simple;
	bh=OQjeZPVGaa14TyddUWrKH2DldOli6OAqfCeH8J0z0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyEPNegX6zyoyw15QwJiuiFcdB+lostwOInqZkAfbaEztL9ew7hgZRwxEL9JXD94h64KWXGlDVMuwLr3XOXSwNhA1mHO6rrtGyyGwAJDvVG9OJBGg9ZpJN8qMJxpk3M5BTXRXZH7EoNuXwpAvqMorvgBwx+Uz0AYVrFzWwKLraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMl7Q62J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMl7Q62J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E5F1F00893;
	Thu,  4 Jun 2026 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581546;
	bh=/29v7E8UbIPxlUQxNEOzBP2pbp0TDe815vF1g7XvBwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aMl7Q62JgY+FW07j9TZ0+FnxvzSdAPb2L4t1EsR8I2ZefqFEpSEbyo83z/Nm2+Yv0
	 H9WbI6I1YNZsTK75vfi07TJlqPpAYzHX3ZMXXUsJRQlMNr/07cd920y5wGjHPdbr+B
	 ubBUtUe6YlzkMz362kgBb2R2FGK4gPVHBOAzwiG/VYBXogcPNK7tmEoA6F278DlIQk
	 q4fkAB3ydnDT94c9briiIfGlAy1ibd0rhxf5bHgNpqr9b8QVPXrC1pw3C6vyb/VPlZ
	 HOOoDaA+T6GPIC34+gy17HQCOYjnB27pZuUcd5FUfUaWYwv7DA4jTcix4lo65woMNH
	 2Zyrwer3AxFDg==
Date: Thu, 4 Jun 2026 10:59:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
Message-ID: <aiGEp_oR2yMj88Ra@x1>
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

Thanks, added to the patch, that is in perf-tools-next, for v7.2.

- Arnaldo
