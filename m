Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82701D90AD
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825015; cv=none; b=FttZaPnPGT6Ord4g4ocYTiLo+V+FqABCY6jQQeJ5oGD6xgqVTna3TG3z8MaNyXnJq5aegsdVRG6HZ0OWD9AYfw5VJh13O2jKNRznrx5lbR+bkdIsxEYlqnVIMuGzisoVX1jeAbI+EQOl4V/za0tRL4OhlNf4QKNhFcZ9LCRK/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825015; c=relaxed/simple;
	bh=gW9j6eoW34S43TNl1A7HOjT/67O5Vuw+Wjur2DwW3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQIQ1L63iR0OveMqwYPKIL9IpV7sOgPrQ2SwtOgz1Nh69Bqn6ySRPi6pHt4z30B5JKpUpkKN0xVkoRW4hSc/4LDpZiOhHFVImOI0BFQKqOVUx8d3VEV/1cQzYxv7wk85Zf0a1B+rjFeAIGhbz1dXm6fTI6FnbViVyM4oecngc+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIvjNnBU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIvjNnBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9382C4CEF1;
	Tue,  7 Oct 2025 08:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759825015;
	bh=gW9j6eoW34S43TNl1A7HOjT/67O5Vuw+Wjur2DwW3c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIvjNnBUhi5KIwLht7WPs1ZLpBkj4plqLmeBgw8+6b/c7F3BMT4+7fLuwgXVUU89q
	 38uo0XGBOlqv5kNzAKelddEhROMRCgvWrrWuQakopLHTVVrvZxBGhIxI1WfdcDAEBw
	 7byj9tVfP9qXIgguDz28oAH9+e7RYRpNPBF2sqICnxhy4tEJpyGzIjtCRJjR3KQBMx
	 CG7hdQXfj4K+B8p+zz8ESjPF0z78puvpS5UG+3ukZnfZNDwL1EgO/SJNX0ipHTdW73
	 gxkWYdUTP+arpFq8f0ba0kawB38lh8kbHC2P9Jhy6I0qzt45jHOlI/fUHKQuhkd1OY
	 LYo9T8W148hRA==
Date: Tue, 7 Oct 2025 17:16:50 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, irogers@google.com,
	jmario@redhat.com, jolsa@kernel.org
Subject: Re: [PATCH 0/4] perf c2c: Detect shared memory cachelines
Message-ID: <aOTMcmg1o2ZWGmFl@google.com>
References: <20251006175710.1179040-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006175710.1179040-1-mpetlan@redhat.com>

Hello,

On Mon, Oct 06, 2025 at 07:57:06PM +0200, Michael Petlan wrote:
> Hello.
> 
> Currently, perf-c2c tool has no means to discover a scenario when
> there is a single cacheline in shared memory, which is mapped to
> multiple different virtual addresses.
> 
> This patchset adds a mechanism to detect this. First, an "S" flag
> suggests that such scenario may occur (a cacheline in shared memory
> is captured). Additinally, another option is added (--detect-shm),
> which zooms to the SHM cacheline and shows the physical addresses too.

Any example output?  With a test program would be ideal.

Thanks,
Namhyung

> 
> Jiri Olsa has drafted this feature some time ago. I have rebased it
> to current kernel repository shape and reworked several things in it
> after some discussions with Joe Mario.
> 
> Thanks for thoughts and comments.
> 
> Michael
> 
> 
> Michael Petlan (4):
>   perf tools: Remove /SYSV from no_dso maps
>   perf c2c: Add shared mem flag
>   perf c2c: Add map name for cacheline
>   perf c2c report: Add --detect-shm option
> 
>  tools/perf/builtin-c2c.c    | 178 +++++++++++++++++++++++++++++-------
>  tools/perf/builtin-inject.c |   4 +-
>  tools/perf/util/map.c       |   5 +-
>  tools/perf/util/map.h       |   6 +-
>  4 files changed, 154 insertions(+), 39 deletions(-)
> 
> -- 
> 2.47.3
> 
