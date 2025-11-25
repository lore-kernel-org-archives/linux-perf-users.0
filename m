Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB92D7DF2;
	Tue, 25 Nov 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058435; cv=none; b=G1qgLiVAnYqFMQq5bpKsmPQZnxEog59ecKJwqPGMxLHtanZqHlRdRHEUhe2yU4rswlTKAYeG4PI3EhIbPkJqyE8TMOaA4XP9W51Repx+lZnehhPs7aUnuzUCxw3m8h1r+Us3L0bQ6UeNcfDaQxuXI7kmPLWG2IwlR9yelUWLQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058435; c=relaxed/simple;
	bh=5B4S9Wbk7WVGsAmTNI0yyt5e2qGMc0oyI+GmfoaHfYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCr4WcgfypRn1FNdNGI5eOkB+3hpo9t0L5qg7xjaF9aXWUmQezE1Xyz9DEmKXC6aIXOx1LYPBCH1RzAgxWgzC2oyORP7rxHt1+KUhGR3h3Un6zktKrRzzkYIMRqI0w3Q5FpQ4WuxLMq7QJ5kxfmwCPZhDuprPlEsmeEsRewH0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siBTTwEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siBTTwEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12587C116D0;
	Tue, 25 Nov 2025 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764058434;
	bh=5B4S9Wbk7WVGsAmTNI0yyt5e2qGMc0oyI+GmfoaHfYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=siBTTwExikwuCEzsvFoWpZ8xkIcONZ2/BERf+jiXu2XTRoiz4Na/zK/aq4gjXdUKB
	 +9frmjXhvvKZwgGV0b3hp1b6KerXXDbRsnOkSwpZtKVhz1psafXRZFqiP4fVWwieLS
	 L9D+bTWwlC5gTd0eTdUlV6/sJMYa3T4Eg0Q4KxkRYD7OB8kGP8ZL/dHtcLhgxev2tN
	 FLpmZOnenKiKcsl/nM7bVGOd/UbSSc4Y6op1dFrNLF9G9nFrdT+5dJrhc9rIKxJzCJ
	 IEuRJCdbTBPiSRjcwCud6GVjW4z4QQpygo//A0Za6bF493Y2+QtgGg264cD5grUn5q
	 2Mi+1PPatnSRg==
Date: Tue, 25 Nov 2025 00:13:52 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: hupu <hupu.gm@gmail.com>
Cc: leo.yan@arm.com, acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: Re: [PATCH] perf build: Support passing extra Clang options via
 EXTRA_BPF_FLAGS
Message-ID: <aSVlQHJ9xcGcZULp@google.com>
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124073445.3709-1-hupu.gm@gmail.com>

Hello,

On Mon, Nov 24, 2025 at 03:34:45PM +0800, hupu wrote:
> When cross-compiling perf with BPF enabled, Clang is invoked during the
> build. Some cross-compilation environments require additional compiler
> options, such as `--sysroot` or custom include paths.
> 
> This patch introduces a new Make variable, `EXTRA_BPF_FLAGS`. During BPF
> skeleton builds, it appends user-provided options to `CLANG_OPTIONS`,
> allowing extra Clang flags to be set without modifying Makefile.perf
> directly.
> 
> Example usage:
>     make perf ARCH="arm64" EXTRA_BPF_FLAGS="--sysroot=..."
> 
> Change history:
>   v3:
>     - Move the variable description comment to the top of Makefile.perf
>     - Update commit message
>   v2:
>     - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
>     - Update commit message
>   v1:
>     - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options
> 
> Signed-off-by: hupu <hupu.gm@gmail.com>
> ---
>  tools/perf/Makefile.perf | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 47c906b807ef..c1a66cf3d1a7 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -35,6 +35,9 @@ include ../scripts/utilities.mak
>  #
>  # Define EXTRA_CFLAGS=-m64 or EXTRA_CFLAGS=-m32 as appropriate for cross-builds.
>  #
> +# Define EXTRA_BPF_FLAGS="--sysroot=<path>" or other custom include paths for
> +# cross-compiling BPF skeletons
> +#
>  # Define EXCLUDE_EXTLIBS=-lmylib to exclude libmylib from the auto-generated
>  # EXTLIBS.
>  #
> @@ -1249,6 +1252,8 @@ else
>  	$(Q)cp "$(VMLINUX_H)" $@
>  endif
>  
> +CLANG_OPTIONS += $(EXTRA_BPF_FLAGS)

While it seems CLANG_OPTIONS is used only for BPF skeletons, I think
it's better to add it directly to the below lines instead of adding it
to CLANG_OPTIONS like following.

> +
>  $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
>  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
>  	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \

	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \

Thanks,
Namhyung
