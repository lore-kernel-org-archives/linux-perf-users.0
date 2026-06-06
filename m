Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4E39DBC0;
	Sat,  6 Jun 2026 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748948; cv=none; b=IQcd6fYaCDAF0B5kSMP2qBepEtwlOlZ0bafOD+2CKXDa4cppYEu1mSlQspSl9dONAYEul162L4NnucI75UVGr0gEPsXvSAw7wv1SsdjXe2/yDNgIahv7W+QMTj1hQkU0x3nrIQLuuX7TdGXSQTkHvPcocakM3qge/2+epZeo1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748948; c=relaxed/simple;
	bh=ipn4GiYRQaR4eMw9Ma0aXUxh/aSJl2HtqbA95ETYGF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4SQ1qi+Z+lrcpMLjcOThbwAuh3NNwCMXJAT3iqRzfWiwKxPgxjf/NQQ1BMJcmJumL9cX+gKTv+Fs+Q8+6FX/4C1kT6Y3cIEohcfu9JjkhV7m1OYDfpjHsxFAHYC7qNDwvr7/Q5Mi3xUcUBTjGw7ZvBGOAuxuzKv9AiTl2TbPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/v42rIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/v42rIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7EE1F00893;
	Sat,  6 Jun 2026 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748947;
	bh=t7T0o1NIqi6y/PD+h03tscKbherPdIttwUvKqeVWnLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E/v42rIFX2rfyyXGsbNh9JgpXSov/tvPMhGfg01C5+9jFdEKJsJHm6u2OgCrDV7zS
	 byOTWDD4OqZc8yBTk5FflzEj4NzUK7T/FEQ/GQDWE7gtQ46a9PEeMab9VAy4wB9/Qm
	 dcfgOWqHnueRqi2gEIpFmjq7idcEggtzPKewHmlAsh2AkGmaiN53dckv/VYmNFnVlU
	 jK7Wi6prGX4pNAGAnOUNZxTTdsyOUZ2R+QCFFjjaA0Xm3jHztfmNPO59+Xykvq0EQ0
	 HGZQELQ+LNCkc/4TuoBG/f6VO7rlKdFoODvfV+5onGMEeStgZws5hN2Ydk/YboD630
	 sGoNgSzGJ3IBA==
Date: Sat, 6 Jun 2026 09:29:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/9] perf mmap: Guard cpu__get_node() return in aio_bind()
Message-ID: <aiQSjhuaPIObo_em@x1>
References: <20260605233837.1773732-2-acme@kernel.org>
 <20260605235626.BAD231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605235626.BAD231F00893@smtp.kernel.org>

On Fri, Jun 05, 2026 at 11:56:26PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] NULL pointer dereference in `perf_mmap__aio_free()` when memory allocation fails in `perf_mmap__aio_mmap()`.
> - [Medium] Sign-extension out-of-bounds write vulnerability in `perf_mmap__setup_affinity_mask`.
> --

All comments in this series are for pre-existing issues, taking notes
for future series and applying it to perf-tools-next.

- Arnaldo
