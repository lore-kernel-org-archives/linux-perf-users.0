Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA212BF29;
	Thu, 21 Mar 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037202; cv=none; b=hw3ACg9kdQSNYNZvS/H7It1PLTozniF8m9pTxJJdeAoR/nZCXVVD5Qr3Eu2bTZ9ld4UkK/SHF1QRNkf1bu9RsgFw9ryKnFj+8KKsdLN238ApFLpYc6Sf/6jl8GPtavXgGxfW2MEqIjvrfzKzPcogYvtj9lpgTQvwYWRHSpu+Gc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037202; c=relaxed/simple;
	bh=CwtQp+tuiw5FkHQcjpn8qQcYzlPRzza/n03hWkrheGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH5LA1N17dV8cq7lucf5SSaz8q+8YDf+anjhCGX6El8qzeU+ntSN4zgXLik0lO0BdKIpApBgfW+rKOBaZ/5s1n9Xg7ET+DP/D27ZaFKrgXCPrsIRKUXaSKkdVO2lGR83gX9OPDeBZgBSesfAC3xWmtgsRmyTwWXx3g76xbKiLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1M96/rd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1M96/rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEDAC433C7;
	Thu, 21 Mar 2024 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711037202;
	bh=CwtQp+tuiw5FkHQcjpn8qQcYzlPRzza/n03hWkrheGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1M96/rdsa0lTwM1ZOz0uA6uQ3+Tz6zqPurt2vmKMTaB6JQIMWU0o1ZMqWa4BlzFU
	 8LdLY7YsyfTtyMWsQO9dVWShH88cz7ZIT4ol03xlAZ2Nw2e1SXG6CpDiCqvJEFdImS
	 AgTC8CDtOZXA9b12Xs+2JVonwHphw4z/W3KpPwStbNWKnU4e3sGcz2OUpcbaEqHQkn
	 OgTwcqgvSdpnA30oe42X8TIOpJXVtRyu8KQyo+mARgAuFVg0lr2k3AGQOcNn6rR1ke
	 UF//Aa9o3xzR1VsY5eE+vocJIntVvzmYt3HjEXS9zwTq8Tfyd20wJ3p43n9EaOBY1I
	 k5e+39KSaLUXg==
Date: Thu, 21 Mar 2024 13:06:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] libbpf: Use (uintptr_t) for a u64 cast to a void
 pointer to fix build on 32-bit arches
Message-ID: <ZfxbD5AuBvKOMal5@x1>
References: <ZfxKeSF5e6mXpnrs@x1>
 <CAEf4BzY2iVCDPajdzNvJPfFHCjHiMb2eq7rk-rfKejhkD9v48A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY2iVCDPajdzNvJPfFHCjHiMb2eq7rk-rfKejhkD9v48A@mail.gmail.com>

On Thu, Mar 21, 2024 at 08:59:57AM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 21, 2024 at 8:16 AM Arnaldo Carvalho de Melo
> >   dm.log/ubuntu:18.04-x-sh4:libbpf.c:5355:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >   dm.log/ubuntu:18.04-x-sh4-     map->mmaped = mmap((void *)map->map_extra, bpf_map_mmap_sz(map),
> >   dm.log/ubuntu:18.04-x-sh4-                        ^
> >   perfbuilder@number:~$

> > I think Namhyung mentioned as well on a chat conversation about noticing
> > this on a 32-bit build on Debian.

> > Fixes: 79ff13e99169ddb0 ("libbpf: Add support for bpf_arena.")
> > Reported-by: Namhyung Kim <namhyung@kernel.org>
 
> We've already landed a similar fix in the bpf tree, see [0].
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240319215143.1279312-1-andrii@kernel.org/

Great, uintptr_t looks cleaner tho, but fits the bill.

- Arnaldo
