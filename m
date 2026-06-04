Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B767290DBB;
	Thu,  4 Jun 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580325; cv=none; b=PYhLHdcBIQZpnJ1iQRp4+0nn+B4jy4fnAzopUnhVpSCeF8JuLhZbLJuECC89b/PwSln+2cXe2hpylpAd+UiwMGMm0eT1SdFD+8oesKKBfUxsIwWqORc1DiEHDNS/GwcXFyGLmauMxME+hpZuauu5r4Edu3KlM5wYSYvKCAIiNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580325; c=relaxed/simple;
	bh=NdwV69ZBouzPJAoi5E7IaT3INyfqv0o/qd5OhUX6cGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4nFW7UiadL0sUtHIpic6hJI6/KB8CWe9L9RF0FJmrF8NsekRxbqG57Kxkd4+B+nrAn8KOxNkZz9lSqle2A25DJA5a3WcPCdRtqGAY8gGVhkysdvNEj6v1sse+Pw/AmdOuxgYSbSG4rB1oBiTy950gmB/0hw2xUjKlqaqug1St0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haR5alLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haR5alLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D3A1F00893;
	Thu,  4 Jun 2026 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580324;
	bh=vWWMdHRC0jnfTkV2PUnJXfwlavK0YCbEJDUS1HSqoxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=haR5alLB01i106wHg4D3ErIgAnXgvle+Z2Gc4tY3PTlNu3EWq+6Px/0qoNT1FG3uB
	 sgI+TY1WWtrtRJW8jhxilaDDhJWxuEpNeCSsxN9sakKoHtzqAzSg8n38YVx6/Ii/wS
	 P1QufIFMfR6Geuk/DKRrwbBQraEqi8fCHgUgCSD5TApC8nBJCZTWo9SsH5EbetCtoP
	 trCO6LobhzLYUZsrVstusUz9/O3xNnyOfEhhKo4SELkYTC0Topwjtqpk0AMiO4AhOR
	 ynX66bppBB/QByT0wUX5U1+R8jwQE3aIMhAatJdHtNSSURM8RCmLwQKfSS38nnfXX7
	 co5FcG/w33/kw==
Date: Thu, 4 Jun 2026 10:38:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Yuzhuo Jing <yuzhuo@google.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] tools build: Fix feature checks to touch target files
 on success
Message-ID: <aiF_4cz_8oLPnKXa@x1>
References: <20260531010924.525824-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531010924.525824-1-irogers@google.com>

On Sat, May 30, 2026 at 06:09:24PM -0700, Ian Rogers wrote:
> In tools/build/feature/Makefile, test-clang-bpf-co-re.bin and
> test-bpftool-skeletons.bin redirected grep output but never touched or
> created the $@ target file upon success.
> 
> Because the target file was never created on disk, Kbuild could never cache
> the result of the check. Consequently, Make treated the prerequisite as
> missing and continuously re-executed the Clang BPF backend and bpftool
> feature checks on every single sub-make evaluation during build startup, or
> on every incremental build.
> 
> Refactor both feature check recipes to touch $@ on success. For
> test-clang-bpf-co-re.bin, group the shell pipeline within curly braces
> and redirect both stdout and stderr to .make.output to allow errors to
> be inspected and not appear in build output. List
> test-clang-bpf-co-re.bin's input C file as a dependency so
> modification triggers a rebuild. For test-bpftool-skeletons.bin, add
> it to the FILES list so that it will be cleaned.
> 
> Tested-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This patch originally appeared in the now merged perf patch series:
> https://lore.kernel.org/linux-perf-users/20260518154638.2798789-1-irogers@google.com/
> ---
>  tools/build/feature/Makefile | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 704c687ed3ad..5b4a984973c4 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -75,7 +75,8 @@ FILES=                                          \
>           test-file-handle.bin			\
>           test-libpfm4.bin			\
>           test-rust.bin				\
> -         test-libopenssl.bin
> +         test-libopenssl.bin			\
> +         test-bpftool-skeletons.bin
>  
>  FILES := $(addprefix $(OUTPUT),$(FILES))
>  
> @@ -383,9 +384,9 @@ $(OUTPUT)test-libaio.bin:
>  $(OUTPUT)test-libzstd.bin:
>  	$(BUILD) -lzstd
>  
> -$(OUTPUT)test-clang-bpf-co-re.bin:
> -	$(CLANG) -S -g --target=bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
> -		grep BTF_KIND_VAR
> +$(OUTPUT)test-clang-bpf-co-re.bin: test-clang-bpf-co-re.c
> +	{ $(CLANG) -S -g --target=bpf -o - $< |	\
> +		grep BTF_KIND_VAR; } > $(@:.bin=.make.output) 2>&1 && touch $@
>  
>  $(OUTPUT)test-file-handle.bin:
>  	$(BUILD)
> @@ -397,8 +398,8 @@ $(OUTPUT)test-libopenssl.bin:
>  	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
>  
>  $(OUTPUT)test-bpftool-skeletons.bin:
> -	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
> -		> $(@:.bin=.make.output) 2>&1
> +	{ $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons'; } \
> +		> $(@:.bin=.make.output) 2>&1 && touch $@
>  
>  # Testing Rust is special: we don't compile anything, it's enough to check the
>  # compiler presence. Compiling a test code for this purposes is problematic,
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
