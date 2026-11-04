Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825770;
	b=ZdxLJPlO1IyWx6RyCmpL/UxjrmzSPEXTK+iMLiw6Fit1sB3LXc8U7m2K9te4pqc/WJN9
	 sBgbDAG3HsV5SVS+OWqludQdD7KZky//rkGhqp3XsteB6/Zvt2hPn71wTuOlOgTj6DD4Q
	 OcfeoMWn48Mrr3J2MOeWtmD0rDCrexH6baMflHN2YjZrTHEesrp1ckYqCD6Kk9E12+Txq
	 P7NqSQXiNX82j7bzUQ7qlnrv+o9YI8oWgSLsQSxNoLgFOb7wjAlMos7io2QUZKvREs/P5
	 ZUA24PjpLApU8al+PKgfo7No2wWRmbJzfKZocuO2Hjs/yHfWyEMBoMtSPzfMfJoweeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825770;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uxSwOQErIZ3I0/QVGsS3gJtYrLgdNJzU2U+0Lm6R/OU=;
	b=WKZ8wMSDxPgaV3mAN883qy0lBRuSGWG3L2+kRAFAGi6/+g3jpeXh6dcK0xOVPVCeDiI4
	 vkjP7zDzU8zkwyPoxt2FXEgB/cyOWcw14/9eXngfI6JNxGTG/dw8pNT+QnTAd3JPZOwbb
	 9VwswROmSPvJmcGzg44Jf6YacImvcQkmrHIc69GChy2Uz0o4GH3Or0+iE1WW8EOnt1ruY
	 nYD80Z5P91Q6iSafZ89doQyjOg69T5miynq6A1DbPmkl56Ha8xhiAUXcIJbYv0chHUGoe
	 jif3N6/XSbhuffu2FZodZS5/31kd4JrrI14In+GG+IjmOTtv0wQYgZiMxVgmguvp5kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npxON8ct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DB607870B;
	Wed,  4 Nov 2026 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npxON8ct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0221F000C1;
	Wed,  4 Nov 2026 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825769;
	bh=uxSwOQErIZ3I0/QVGsS3gJtYrLgdNJzU2U+0Lm6R/OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=npxON8ctjayv/xaG/yJuR9cNX8EfIeBxdMK0yWC8rNnFViRoSjgpbMCnj5nbYqymm
	 dO7o/cR4xnl3TeDQ1NKo4QpZL/iWCK7R4EIuW2RM+xtAAdnUVnlsxldwIvrmbimNZk
	 ZTxmyWXLBzs2+I8uxVsrG+ndtSDvKpJ7eGLIxqaGAUyI3101wtF2a7bXVKAzDWP7ju
	 MzSPNjgWX1XY9hVIGe9sS/zWcclo3bVyuHOkkTpuSZFL0Tld9YNyKvi0g8qdpODuqQ
	 UZqyUYyJyvCH9adn+Qcjw9/CxRIYD3V9N1YxUzop6+Ob3JzWxGiiK5kvcMGBqJAH+r
	 rdi6sLmyYiyAA==
Date: Wed, 4 Nov 2026 12:56:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alireza Haghdoost <haghdoost@uber.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf symbols/callchain/annotate: Bug fixes from
 symbol reference counting review
Message-ID: <auub590i-CGpgjJ6@google.com>
References: <20261031063549.1281324-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031063549.1281324-1-irogers@google.com>

On Fri, Oct 30, 2026 at 11:35:46PM -0700, Ian Rogers wrote:
> While reviewing the v2 symbol reference counting series [1], Alireza
> Haghdoost identified three existing bugs in callchain merging, ELF
> zero-size symbol end calculation across .symtab and .dynsym, and basic
> block range splitting/cleanup in 'perf annotate'.
> 
> Pull these three fixes out ahead of v3 of the main series so they can
> land for the v7.4 merge window:
> 
> 1. perf callchain: Fix loss of symbol in merge_chain_branch()
>    Restore .sym = list->ms.sym when constructing the temporary
>    struct map_symbol in merge_chain_branch(), fixing missing symbol
>    names and inlined frames in 'perf report --children'.
> 
> 2. perf symbol-elf: Fix zero-size symbol end calculation across .symtab
>    and .dynsym
>    Move symbols__fixup_end(), symbols__fixup_duplicate(), and
>    maps__fixup_end() from dso__load_sym_internal() to dso__load_sym() so
>    zero-size .symtab symbols do not get extended across following
>    .dynsym-only functions before .dynsym is loaded, and add a unit test
>    in 'perf test symbols'.
> 
> 3. perf annotate: Fix block_range symbol loss on split and leaks on exit
>    Preserve .sym = entry->sym when splitting head/tail basic block
>    ranges in block_range__create(), add block_ranges__exit(), and release
>    resolved branch_info addr_map_symbol references in
>    process_branch_stack().
> 
> This series was prepared with the assistance of Antigravity and Gemini 4.
> 
> Link: https://lore.kernel.org/linux-perf-users/20261027231513.816148-1-irogers@google.com/ [1]
> Assisted-by: Antigravity:Gemini-4
> 
> Ian Rogers (3):
>   perf callchain: Fix loss of symbol in merge_chain_branch()
>   perf symbol-elf: Fix zero-size symbol end calculation across .symtab
>     and .dynsym
>   perf annotate: Fix block_range symbol loss on split and leaks on exit

Applied to perf-tools-next, thanks!

Best regards
Namhyung

