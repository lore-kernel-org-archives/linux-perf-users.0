Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716FD531;
	Thu, 14 May 2026 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802751; cv=none; b=ukwmAngKD8kJANLd2Q6PK4NxX34MPbesWboLOZTFzoMB+WfLLCuWPBtHr8uXQR8hEE+TmC4y5OU8i/2pT4keqZRkPqj41OLrC7zr59XxMXrMcRWlBrOBGO6Hk481tKkutzs0iUe5QpetTgVTDy4CBZBFTwLN72uL88ybr7pEjP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802751; c=relaxed/simple;
	bh=8gBdZj8p4vxO62UTlphW3YXe/kFgFk28/fjvN+rFz1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzhVP/l51SfWM0mUMfhKSM0DxxE5vDlNUOTZlhD8Up8bi3c92LR0aDhsXCaQwQwc8G+tUeGN2hYo+Zwt1/BlUGmnkqTGb+0Vd9cMoKmUYAAGzwTKOEQkK8Rpk000nHmvoBCuknUNzmwfLYVdX/SK9BbaCj2WTKQ7Fk4pP2Z8oR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBf2vY0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBf2vY0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5C6C2BCB3;
	Thu, 14 May 2026 23:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778802751;
	bh=8gBdZj8p4vxO62UTlphW3YXe/kFgFk28/fjvN+rFz1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBf2vY0s//DQD3rIVeJ5p1uwIwOShXzpPtfoqpFsGm1oZ5+OpWaDARssQmqmJIORu
	 Tk1lLUq1HetrPWOECIS76HL2TVAHLeuWjP1MlXX0TUTQDOoEDB8qLtVzbZ6Oz22D4n
	 vdBkpmpVDUs5b5m0C3WQJEKVmploy1iNjJvt8IAcIqk8Q7RwhDlhRU0h3KSetoxRj6
	 CMx98TJRY+uT3QSo32wqGQiYpzEjj7gygUZMHkMzFyvlwuWivazbsZC1A/69Y9Hyiu
	 k0wdE8Cl8xVSxvMBMe5LUEIcR893m1esalo7V3DgQQQ470JNwhZ6caOtC+fhCupriQ
	 4E983hWS8SYPg==
Date: Thu, 14 May 2026 20:52:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
Message-ID: <agZgPBrlKZ655KdO@x1>
References: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
 <20260507234959.EEC5BC2BCB8@smtp.kernel.org>
 <agAqESWvLdIJBErN@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agAqESWvLdIJBErN@google.com>

On Sat, May 09, 2026 at 11:47:45PM -0700, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Thu, May 07, 2026 at 11:49:59PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Adding `-mcpu=v3` to `CLANG_OPTIONS` forces all BPF skeletons to use the BPF v3 ISA, breaking backward compatibility for perf tools designed to run on older kernels.
> > --
> > 
> > commit 2e8791aeccf694e1ae9ed9fda46e3a6f73332838
> > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > 
> > perf build: compile BPF skeletons with -mcpu=v3
> > 
> > This commit adds -mcpu=v3 to CLANG_OPTIONS to support the atomic
> > cmpxchg instruction required by the lock_contention BPF program.
> > This forces Clang to emit BPF ISA v3 instructions during skeleton
> > compilation.
> > 
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index cee19c923c060..a9a8c84b6b006 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > 
> > [ ... ]
> > 
> > > @@ -1195,7 +1195,7 @@ ifneq ($(CROSS_COMPILE),)
> > >  CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
> > >  endif
> > >  
> > > -CLANG_OPTIONS = -Wall
> > > +CLANG_OPTIONS = -Wall -mcpu=v3
> > 
> > Does this change break backward compatibility for other perf tools running
> > on older kernels?
> > 
> > Since CLANG_OPTIONS is used in the pattern rule for compiling all BPF
> > skeletons, this forces every BPF program in perf (such as
> > augmented_raw_syscalls.bpf.c and off_cpu.bpf.c) to target the BPF ISA v3.
> > 
> > Kernels older than 5.1 do not support v3 instructions and will reject
> > these programs during the verifier load phase.
> 
> I think it's old enough and we can move on to ensure v3 instructions.

Can I take this as an Reviewed-by or Acked-by?

- Arnaldo
 
> Thanks,
> Namhyung
> 
> > 
> > Should the -mcpu=v3 flag be restricted exclusively to the target that
> > needs it, perhaps using a target-specific append for lock_contention.bpf.o?
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260507184238.65280-1-suchitkarunakaran@gmail.com?part=2
