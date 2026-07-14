Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522A4E379B;
	Tue, 14 Jul 2026 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048550; cv=none; b=NPr22iRP54jGc5tIrv10EDASTLIuCkB200PPXivEGga4Lh2/NmR9HxDcLkMz5nEV8+KFNU1mtv2pZi8NVNKVcKtJGBFgI9Fgyl2hi/TVjvh7TcdNa3ng4RMh/vWoqdaVUcThguKL7X/ftciHvjiisWBAnusBh4FKju6gvT59tpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048550; c=relaxed/simple;
	bh=MvymHsey+Tc4nfGKSxNRxtUnOorOB0ZCoGzd+6LjpmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBw/Hkj/Fu+0+GZFsUD37FJcNKS53GKdQoba9HGbjVL9Vny/5RddS0NS4fan6w6ci1ZuFM2EEZ6um8p+K4HubMS1XkTgDTX/YXM/PBwoupCTnQBh63rlgkiZbcZogWG4q+jFQ2J72LjtNTjWfy20NEsC3An/qF/QvHFNb7jj0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjurBg3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjurBg3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1701F000E9;
	Tue, 14 Jul 2026 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048549;
	bh=URdL0x17EwHb+bQMwFGXL2VatArNUK22qNoYgeG5kpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JjurBg3UMU/IQQitTqFAuG42vzvW/bp3NOP/5WCv5uZTiFIItBhSoxidhn7gVAc4X
	 roeGbynOmEdrZ/l1d0MBDZSGKDwIBJA9jkvxosg6zFQAe/I/BoFhiv8j+ojJwPzSfM
	 7/QB7LjL2Tmnsercc1pz56wNFnEcE/Pb2VEsF3A8W6wHnmMLkhseBhm1ZLEhxT2pHM
	 5Qn8aby7enSpl4JWm1t+zDSJNM3QWjoloGIGyV6O9vDSC1RhSZleQpO8LDGI7mLoCM
	 621eoJxRrG6f0E39gtKCaKOstLp1rwniOdi9YB4ZdquJMNorZCKFGuws730zi8d4zB
	 HxiUFVYUMZ3Iw==
Date: Tue, 14 Jul 2026 10:02:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf capstone: Fix build with Capstone versions before 6
Message-ID: <alZroz3uzOGmUTjk@google.com>
References: <20260713-perf_fix_capstone_build-v1-1-796ea08c04db@arm.com>
 <alUi7RgZkINlZOKP@google.com>
 <20260713182133.GC512733@e132581.arm.com>
 <alVQY7uJzapcfDCr@google.com>
 <20260714083652.GD512733@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714083652.GD512733@e132581.arm.com>

On Tue, Jul 14, 2026 at 09:36:52AM +0100, Leo Yan wrote:
> On Mon, Jul 13, 2026 at 01:53:55PM -0700, Namhyung Kim wrote:
> 
> [...]
> 
> > > Perhaps checking the Capstone version would be a safer approach?
> > 
> > I'm not sure.  IIUC RISC-V support was added to v5.0 and CS_MODE_RISCV_C
> > was changed before v6.0 is out.  Do you build capstone from source or
> > use a packaged version?
> 
> I checked Capstone source for two RISCV commits:
> 
>   ec6428f9 Refactoring the RISCV architecture to Auto-Sync on LLVM (#2756)
>   b8fcf27b RISCV support ISRV32/ISRV64 (#1401)
> 
>   $ git describe --contains ec6428f92
>   6.0.0-Alpha7~10
>   $ git describe --contains b8fcf27b2
>   6.0.0-Alpha1~513

I'm curious what `git tag --contains` would say.  I can see RISCV in the
5.0 source code.

https://github.com/capstone-engine/capstone/blob/5.0/include/capstone/capstone.h#L90

> 
> This is why I concluded that v6.0 is the version start to support. I did
> not build capstone from scratch but just use a packaged version.

What's your version?

> 
> Just remind, CS_MODE_RISCVC might break build when you work with the
> latest Capstone, as it has been renamed to CS_MODE_RISCV_C.

Yep.  https://github.com/capstone-engine/capstone/issues/2977

Thanks,
Namhyung

