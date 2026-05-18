Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4530AD1A;
	Mon, 18 May 2026 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087166; cv=none; b=dDiBfDyHVl+6YEsJMRiEmhYUyMWsjecL0FvkPX0XiC6hbnKqjrQeFV4Z7YmvdlTsU0Js7SnMmfO2va5eloO00Yy5NKHPA6LvF/FmBnmRLQwk2vnGbQxvOdkNxWEObH5vRoZxKMSwLssZ+Tp6mEPLQPgOMbRG22EY9PzPtSOKyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087166; c=relaxed/simple;
	bh=vJSeAGlhmmhPXLo+X/Jt1tXtqIGN05TsKjlPQaA2O9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlk3KxgFxIHXpaqN+jklcC5Si92RXdppUoxsTtPY6oz6u41/m5KNpl/C7JEFJfbF6gzBoNwfp+NpvCC6hH715MJYnik3juYzQIMa2+5hoa1f30y1kcoDJMQBafVufeRvX4to1vzJePy7Pw3YM2vwLMWsIQiYQVR12WJNnTLeoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vbk3plrz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vbk3plrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF29C2BCC6;
	Mon, 18 May 2026 06:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087166;
	bh=vJSeAGlhmmhPXLo+X/Jt1tXtqIGN05TsKjlPQaA2O9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vbk3plrztF4TrpI+RCLFYof3xWhztONDqfoUu/f4MD+AbkYUIErTq92jgdkl1VMtS
	 ZR2bkWQV7dvVNXCDkzhTqeIat+/HpblQPrSnfwc7jjUPfkaYkyO+RmHOq4vmO4kxDS
	 z5oWN6KzaZFFyL8+C4b256LKnMDDTEcBbos4t9qrz/tjHc2uANxo5A8gTEboro1VEZ
	 42lBZ0AGXpft2cxg5wfB8cHe3Cj+OBA2eQLBiIFaqzJSi75P57UuCby+hDB7ztGgoK
	 jK05+jSa/yTWjKPNgvr7yV7uoAvEQ5htwKoBSpIWU+gJVe41f7UnSGH0jSHxRA9Gn/
	 NKdeQLVFEpqAQ==
Date: Sun, 17 May 2026 23:52:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
Message-ID: <agq3PCt_FhxIYgQ8@google.com>
References: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
 <20260507234959.EEC5BC2BCB8@smtp.kernel.org>
 <agAqESWvLdIJBErN@google.com>
 <agZgPBrlKZ655KdO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agZgPBrlKZ655KdO@x1>

On Thu, May 14, 2026 at 08:52:28PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, May 09, 2026 at 11:47:45PM -0700, Namhyung Kim wrote:
> > Hi Arnaldo,
> > 
> > On Thu, May 07, 2026 at 11:49:59PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [High] Adding `-mcpu=v3` to `CLANG_OPTIONS` forces all BPF skeletons to use the BPF v3 ISA, breaking backward compatibility for perf tools designed to run on older kernels.
> > > --
> > > 
> > > commit 2e8791aeccf694e1ae9ed9fda46e3a6f73332838
> > > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > 
> > > perf build: compile BPF skeletons with -mcpu=v3
> > > 
> > > This commit adds -mcpu=v3 to CLANG_OPTIONS to support the atomic
> > > cmpxchg instruction required by the lock_contention BPF program.
> > > This forces Clang to emit BPF ISA v3 instructions during skeleton
> > > compilation.
> > > 
> > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > index cee19c923c060..a9a8c84b6b006 100644
> > > > --- a/tools/perf/Makefile.perf
> > > > +++ b/tools/perf/Makefile.perf
> > > 
> > > [ ... ]
> > > 
> > > > @@ -1195,7 +1195,7 @@ ifneq ($(CROSS_COMPILE),)
> > > >  CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
> > > >  endif
> > > >  
> > > > -CLANG_OPTIONS = -Wall
> > > > +CLANG_OPTIONS = -Wall -mcpu=v3
> > > 
> > > Does this change break backward compatibility for other perf tools running
> > > on older kernels?
> > > 
> > > Since CLANG_OPTIONS is used in the pattern rule for compiling all BPF
> > > skeletons, this forces every BPF program in perf (such as
> > > augmented_raw_syscalls.bpf.c and off_cpu.bpf.c) to target the BPF ISA v3.
> > > 
> > > Kernels older than 5.1 do not support v3 instructions and will reject
> > > these programs during the verifier load phase.
> > 
> > I think it's old enough and we can move on to ensure v3 instructions.
> 
> Can I take this as an Reviewed-by or Acked-by?

Yep,

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

