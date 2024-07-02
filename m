Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB25282E1;
	Tue,  2 Jul 2024 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960655; cv=none; b=suSXydhMcRzcASTscPHiaE4CF10UbYmT8vL/Mdt2bP2IhRrQWycsS15xOkCxQ8He088z9rpk8aL0DNBWOKT1GkOhpiIzGO+jbCMQowzsiu/JArWf+Wr/Sdf+F2dy3hH5U4xzQ8vfat/KDZYHqXLwmEoZK0PABgVRCCd2rUiGV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960655; c=relaxed/simple;
	bh=AOujz8aguJYsCAHdUUOWt4d8AiyQOabVrQR8iGmp2io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBovzm03ptl4osV6HKtXbmx27G5QDh9Pc3ub5WbmmA0LXwILBm+2bVAsu4x29xbIlBVdTI+KRdqw57Io/wETjWy9j4PGdLUEgmlu6f+xZRJtXF7C2JxcR2IUYdO1UFzK9Ox3JpoU17zhx7x5ae0rI01dp+G5VReQKh1oA8oEbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHGWKwy2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHGWKwy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64013C116B1;
	Tue,  2 Jul 2024 22:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719960654;
	bh=AOujz8aguJYsCAHdUUOWt4d8AiyQOabVrQR8iGmp2io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHGWKwy2Epm62cw2FTwUeRcGdiwCoVRYsIHqvx1QQPZ4wuHgT4TdvE7nNtfQ1yvXl
	 Jkx39rXSkkFpCI6LqPCFer+hLnMy+keUeWjZfzUfQ8j76aKHWEBeJH/aH+IFF6bylK
	 Flfr2jeVNie+d9x2HJjP7Pv4JRIa1nubspkvr2nHMyiXafGlNk9KGFQ4TrTN5YRCpD
	 MRuXhkvkVj0jN7OLFjbougnGMYLUcHPx8T6d+T5PYdiqZwmvQ/IMJ/ozDAqJGhJQYT
	 juDtki60LdtKN5ZT7W+kunsFJURYuhsizv701Sl1TaJWNJ1YP8ecQfR/eOT6nWWzAK
	 ckc6fMkufKKWg==
Date: Tue, 2 Jul 2024 15:50:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	yzhong@purestorage.com
Subject: Re: [PATCH] perf probe: fix missing references to maps and map in
 thread__find_map
Message-ID: <ZoSETO9_QjvHktcU@google.com>
References: <20240627213619.718-1-cachen@purestorage.com>
 <20240627213619.718-2-cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627213619.718-2-cachen@purestorage.com>

Hello,

I think the subject prefix should be "perf tool:" instead of "perf
probe:" as it's generic and not related to perf probe command.

On Thu, Jun 27, 2024 at 03:36:18PM -0600, Casey Chen wrote:
> With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> thread__find_map() would return with al->maps being NULL when cpumode is 3
> (macro PERF_RECORD_MISC_HYPERVISOR), later dereferencing on it would crash.
> Fix is to add back the reference to maps and map.
> ---
>  tools/perf/util/event.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index f32f9abf6344..259cb137e5bb 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -638,6 +638,8 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  			!perf_host)
>  			al->filtered |= (1 << HIST_FILTER__HOST);
>  
> +	al->maps = maps__get(maps);
> +	al->map = maps__find(maps, al->addr);

First, can you pleas fix the indentation?

And I'm not sure if it's the right fix.  It returns NULL so I think we
should expect al->map and al->maps being NULL.  Maybe we need to fix the
caller to handle NULL map or maps properly..

Thanks,
Namhyung


>  		return NULL;
>  	}
>  	al->maps = maps__get(maps);
> -- 
> 2.45.2
> 
