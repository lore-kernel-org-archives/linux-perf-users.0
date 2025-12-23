Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF93145348;
	Tue, 23 Dec 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766514008; cv=none; b=e/WUk3fQpr6LCa0Dg5QeIn6YmyLf6L+Wa/TwIHfQ6QhDjjPPzy74PiZ1Jz7XF5NKQxGP0hhu+AGA0PzprykXEc1D8+37wgj18qB/gYEVHOwiICF3jjzKao2pHAkqqNsTrCbDA1gIQmhvCklzcvBMnO192j3HoD99ghJz/rYcy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766514008; c=relaxed/simple;
	bh=qP8JlGY2zKnl3CsC/Of+DeZQ3W4+/+J2vDf5Z6TRA+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTIdTPqTn5/KsRZ5pnlo6J88tizW0BmC9IyFhYe/imp0VaQFk9XyYxeREwbsV382vZrMQfFOpZ2zzZc2gsdO8jP1zm7BBpuSMd8WcOkRpvqoGxvrJQfmbUpqyZJpfE49o8ii3vfd82c0RsFE7yBMKrSxx7sgC6/e0e4Im8td4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMxKOY9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMxKOY9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E3CC113D0;
	Tue, 23 Dec 2025 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766514005;
	bh=qP8JlGY2zKnl3CsC/Of+DeZQ3W4+/+J2vDf5Z6TRA+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMxKOY9dUOVkKpUD0HDDBP9MK2f489JCWoFpsTVXbxe5Kgn3yhXpeGg42ib25um+V
	 PdQuIeKjNhQcwFjOh3bIv5cJRIov8xHLqRaVEGdvoxOwPdD8ojxoYLDRImtA89AQOc
	 ycflux+TvZZUlNR6O7thQ3omaHk1bkgmvC6g6w3GGZuWaPOy+TtwjssqLcxY4GjgA1
	 R/FGzwJdZ7A9sV678eyS8sh7RTrCfMihq7eGgPbCuAaH+qBbD50Z2zi9ChBHgM2bkC
	 OcpkOWavTWsuuMAky38fyhGyUYc+94dL3v9BtoJzDomdnV0yTbQzeHlRbjXRWNvbyi
	 /clwe2Qz6dsCQ==
Date: Tue, 23 Dec 2025 10:20:02 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: hupu <hupu.gm@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC 1/2] perf build: Allow passing extra Clang flags via
 EXTRA_BPF_FLAGS
Message-ID: <aUrdUjqVEjJW9VBl@google.com>
References: <20251223084337.3789-1-hupu.gm@gmail.com>
 <20251223084337.3789-2-hupu.gm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251223084337.3789-2-hupu.gm@gmail.com>

Hello,

On Tue, Dec 23, 2025 at 04:43:34PM +0800, hupu wrote:
> Add support for EXTRA_BPF_FLAGS in the eBPF skeleton build, allowing
> users to pass additional Clang options such as --sysroot or custom
> include paths when cross-compiling perf.
> 
> This is primarily intended for cross-build scenarios where the default
> host include paths do not match the target kernel version.
> 
> Example usage:
>     make perf ARCH="arm64" EXTRA_BPF_FLAGS="--sysroot=..."
> 
> Change history:
>   v5:
>     - Update commit message
>   v4:
>     - Apply EXTRA_BPF_FLAGS directly to BPF skeleton build command
>       instead of modifying CLANG_OPTIONS
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

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/Makefile.perf | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index b3f481a626af..8b8647fd4f41 100644
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
> @@ -1250,7 +1253,7 @@ endif
>  $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
>  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
>  	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
> -	  $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> +	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
>  	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
>  	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
>  
> -- 
> 2.43.0
> 
