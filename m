Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BACDDCD;
	Sun, 10 May 2026 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778395667; cv=none; b=Wk8c3I2YArIgqK1FNf2LqoD3HEcoxXQxWozqwig1s2cHk6IgQfyzeNeK7aN4WqoG2pHZxfbpCqFch4lqG7wSTkvMzHYA2Cw6xzLT7K/Zdaic3mr+uIvosmob6SW6GAeD4q6vN794jK1kLhIzGYwXSuP1QrMNOUIBNGKTuHpHe94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778395667; c=relaxed/simple;
	bh=KNZIrYpGwNRftJiQ9A0g2ltDh6kfdL2YCDTt9NO0NkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6Q+I2a6Qri4q1oCk8iHA7prMRH151AjkpoMh2qvOLPpcNiigRwbS1jw6C+XNSfkWEU3YvXxkn9p0vmnuHsyhy6M5rDFkHDrbuk/KqC9lEOMiFNhJfX2OIR8gVTxkecfylqsbCGHWkI/JOqSoQqAAw8LKTrLl6bc9p3p9fZ4DQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBdwCGyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBdwCGyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E833C2BCB8;
	Sun, 10 May 2026 06:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778395666;
	bh=KNZIrYpGwNRftJiQ9A0g2ltDh6kfdL2YCDTt9NO0NkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBdwCGyTToNBAcUx8TOBNk1kRZa9YCtGzMaRydwswIehU4y5RhSokEZgQ4q2rBNo/
	 CdSqVExPzI7+Cf7pOcNnPM+RoEJLcAz1g5siBr1PBqk1WkOEF9r+2Pe7P+nedKeDVV
	 A2IDTRsfpzCuJQN3DsvM9qXljVPqrQ9ZBEdTAg3DrHrN/RUuWhttW2WRaZudpLWRZH
	 ZgWxrpgke488/qhDwM0DP1KiR6rOym2KL7MJRu5q9Fd5bYUeJNo0V4lenzlGtk/UQw
	 KF7drDERX97sxkZq2wxLENMmPpgbWqH2omT4JVmu1Y30W5OqeBPkDF/5n6UdgeL6z2
	 U6mzhlqwD1Y1Q==
Date: Sat, 9 May 2026 23:47:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
Message-ID: <agAqESWvLdIJBErN@google.com>
References: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
 <20260507234959.EEC5BC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507234959.EEC5BC2BCB8@smtp.kernel.org>

Hi Arnaldo,

On Thu, May 07, 2026 at 11:49:59PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Adding `-mcpu=v3` to `CLANG_OPTIONS` forces all BPF skeletons to use the BPF v3 ISA, breaking backward compatibility for perf tools designed to run on older kernels.
> --
> 
> commit 2e8791aeccf694e1ae9ed9fda46e3a6f73332838
> Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 
> perf build: compile BPF skeletons with -mcpu=v3
> 
> This commit adds -mcpu=v3 to CLANG_OPTIONS to support the atomic
> cmpxchg instruction required by the lock_contention BPF program.
> This forces Clang to emit BPF ISA v3 instructions during skeleton
> compilation.
> 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index cee19c923c060..a9a8c84b6b006 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> 
> [ ... ]
> 
> > @@ -1195,7 +1195,7 @@ ifneq ($(CROSS_COMPILE),)
> >  CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
> >  endif
> >  
> > -CLANG_OPTIONS = -Wall
> > +CLANG_OPTIONS = -Wall -mcpu=v3
> 
> Does this change break backward compatibility for other perf tools running
> on older kernels?
> 
> Since CLANG_OPTIONS is used in the pattern rule for compiling all BPF
> skeletons, this forces every BPF program in perf (such as
> augmented_raw_syscalls.bpf.c and off_cpu.bpf.c) to target the BPF ISA v3.
> 
> Kernels older than 5.1 do not support v3 instructions and will reject
> these programs during the verifier load phase.

I think it's old enough and we can move on to ensure v3 instructions.

Thanks,
Namhyung

> 
> Should the -mcpu=v3 flag be restricted exclusively to the target that
> needs it, perhaps using a target-specific append for lock_contention.bpf.o?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260507184238.65280-1-suchitkarunakaran@gmail.com?part=2
