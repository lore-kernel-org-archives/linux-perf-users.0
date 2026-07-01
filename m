Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881703C4563;
	Wed,  1 Jul 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934009; cv=none; b=CwgdXkzVDDCC6BI39nr3b+qfMgKszw8yzfhdTREMrEojZ/gEUz7NZVAofXx9mESWBILugV9BTx+8rczG5dAsFWei4L3H7Us5h9pApet1O6Ma/b+1kE6ZVz71saFZ7Ts+64MhbhKKsz38Dl+LEkV8wFTq/pzpp1HTvSLmvSuWgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934009; c=relaxed/simple;
	bh=6uakvJRmc82Va6e8ldGVVNfFirUyb7zP51//8OnT6tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmqjYBVnAjzk1NBXDABbU+99bXPFJoGKQV0cRoBm60gNdxRo58b6aKcdswq8NlCuzaXSJOReCNk9NHNbq0EeZ82smax5KIXAbipUMfwvcCSK0nihCgXB1Wu/VHrybV7nJp1ss0nVRVMtmPJorPsvJZrWaHCyl0knEUjaJ1Nds04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBOL+9jl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBOL+9jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BB21F000E9;
	Wed,  1 Jul 2026 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934006;
	bh=bF7v1g8PVzqVTIYcNBK3G6NqnoGk2CT9dJgouE1GCNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fBOL+9jlqtS1C67UM/lSsBlp4ZpRYM+UiHqdIGVOUtSjd7lqkt2K1GTiM+i48KL7O
	 W4DnSHP/9Jc211kvO02Bj97rJOEJUdVc1Nn/u4pix1Yhi1+kgbVUacVPjSA6cg0YjS
	 8ko0tcx5PUTsuyP1B1ADiO8MQkRROCbYjIIAB/LskgtvUShgkuno4qeC/9mnGyAJ04
	 6fByJtnEC/cCmjrWB52B3CJE9eGGTWXlRk75oiIn5JEMiuJfEKBDGQWsEFW3TG5i6p
	 tUfI5iGGM1COcngFJDQoLx5JeAF5ihIF5rD49l4OL4ib4Twrft9Q5Svg5MvwRwpoq+
	 GEE0PKzgEv8bw==
Date: Wed, 1 Jul 2026 12:26:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix compiler errors with old capstone
Message-ID: <akVp9YZ-15b1xUwu@google.com>
References: <20260701182824.347941-1-namhyung@kernel.org>
 <20260701183830.65EA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701183830.65EA21F000E9@smtp.kernel.org>

On Wed, Jul 01, 2026 at 06:38:29PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Defining CS_ARCH_RISCV as CS_ARCH_MAX causes incorrect architecture selection when dynamically loading newer Capstone versions.
> --
> 
> commit c55db50010b415e5aa95bfca7819cc985aa51d2f
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf build: Fix compiler errors with old capstone
> 
> This commit fixes a build error on systems with Capstone versions older than
> 5 by defining missing RISC-V architecture and mode constants. It uses the
> major version macro to conditionally define these symbols.
> 
> > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> > index 5ad537fea4360..dd7cd97d0a380 100644
> > --- a/tools/perf/util/capstone.c
> > +++ b/tools/perf/util/capstone.c
> > @@ -24,6 +24,13 @@
> >  #include "symbol.h"
> >  #include "thread.h"
> >  
> > +#if CS_VERSION_MAJOR < 5
> > +#define CS_ARCH_RISCV    CS_ARCH_MAX
> 
> [Severity: High]
> Does mapping CS_ARCH_RISCV to CS_ARCH_MAX cause ABI compatibility issues?
> 
> If perf is compiled against Capstone headers < 5, it will use the integer
> value of CS_ARCH_MAX for CS_ARCH_RISCV. If the resulting binary is later run
> on a system where libcapstone.so has been upgraded to version 5+, passing
> this hardcoded value to cs_open() might silently initialize a completely
> different architecture that was appended to the enum in V5 (such as WASM or
> BPF).
> 
> Could this result in cs_open() succeeding but silently producing garbage
> disassembly for RISC-V targets?

Ok, I'll use the actual number from v5 then.

Thanks,
Namhyung

> 
> > +#define CS_MODE_RISCV32  1
> > +#define CS_MODE_RISCV64  2
> > +#define CS_MODE_RISCVC   4
> > +#endif
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260701182824.347941-1-namhyung@kernel.org?part=1
