Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E46FBF;
	Fri,  3 Oct 2025 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519134; cv=none; b=D54c1ZkCXYfZKQdRLPiv5GA2Wpc+7/okbAY60nSWXlUK8/4P6AYEaoJd+T53w75s13GhCE9UYTgREOoy4123LgnrjBfnqC8wI+hFiyaMmRFyFG2KX/KCk7k0oOYZLsv08wN+hAGA0ojN+KjYMkJHWac8GILyi1F2OkXookV9nfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519134; c=relaxed/simple;
	bh=AtRqXRmFNjFsDXfMr5oPQTvSAptV++2wXKV5MuLn1R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYuyyH7UFsOY3maIElZDJ2wCG+ZdUsAb18d98tFzPnB9v9eq2TR87xdPOgmj/iUb/i+Il1pmjCOhIKB8ABlKxaFDeZWsd3hnwapbXBeQasz+nNyzNHE6lt/X3hE4OlLP6daj03pBGtTmvIQD7ovnvdEVHz/hPU4MNTqrrKpthLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDTZLH5t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDTZLH5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2211C4CEF5;
	Fri,  3 Oct 2025 19:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759519134;
	bh=AtRqXRmFNjFsDXfMr5oPQTvSAptV++2wXKV5MuLn1R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDTZLH5tDyz30Df2JvGsEJ27mrc87aFesP3dy82n2bh71VkQs/wQxKeeLXuVXlxU9
	 mAs5ZepbmQwK/C+/9WKOOECeWcHIp35G1JxMvY60LSriJ5omYQSRH+iPQ+mmkyXUB2
	 ARtQMNSqjbB8WZ+ItNKUue8o4Y7qyY+w6qug2U29yBVbcrRPoHp/EEVidYjJ1VMyrV
	 slyAmsED8mkV7zTftzYxHOix8JuD9MWyZNFSvWaq/Uk9Bz2oJVd8eGTNGPYCXR5Flo
	 8QbTg0lktPP1FdE8anlr66whw+DDg8RDUCcvWU5sB/UxxRKN0GywHK7xQ0cUzIqS/M
	 d8e/eaYC5X3TQ==
Date: Fri, 3 Oct 2025 16:18:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf build: Move libopcode disasm tests to
 BUILD_NONDISTRO
Message-ID: <aOAhmqTtuk5KrYcy@x1>
References: <20251003023928.2433640-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003023928.2433640-1-irogers@google.com>

On Thu, Oct 02, 2025 at 07:39:28PM -0700, Ian Rogers wrote:
> The disasm feature tests feature-disassembler-four-args and
> feature-disassembler-init-styled link against libopcodes part of
> binutils which is license incompatible (GPLv3) with perf. Moving these
> tests out of the common config will help improve build time.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 6e7c057b8ecf..0d4a62869855 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -933,6 +933,14 @@ ifdef BUILD_NONDISTRO
>    else
>      $(warning Old version of libbfd/binutils things like PE executable profiling will not be available)
>    endif
> +
> +  ifeq ($(feature-disassembler-four-args), 1)
> +    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
> +  endif
> +
> +  ifeq ($(feature-disassembler-init-styled), 1)
> +    CFLAGS += -DDISASM_INIT_STYLED
> +  endif
>  endif
>  
>  ifndef NO_LIBLLVM
> @@ -1024,14 +1032,6 @@ ifdef HAVE_KVM_STAT_SUPPORT
>      CFLAGS += -DHAVE_KVM_STAT_SUPPORT
>  endif
>  
> -ifeq ($(feature-disassembler-four-args), 1)
> -    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
> -endif
> -
> -ifeq ($(feature-disassembler-init-styled), 1)
> -    CFLAGS += -DDISASM_INIT_STYLED
> -endif
> -
>  ifeq (${IS_64_BIT}, 1)
>    ifndef NO_PERF_READ_VDSO32
>      $(call feature_check,compile-32)
> -- 
> 2.51.0.618.g983fd99d29-goog
