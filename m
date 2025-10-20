Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F629D270;
	Mon, 20 Oct 2025 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933813; cv=none; b=YpCZsl4HH+TK+8lPlrEGQjJmQHutq8I8Sd4kSLuWH89CFeIrMFCbV3IQlCKNi/6QzPZNdKqvSjrWX/wMKD1MP7xZcN1byaVYTpo8y9nTnqh38fOQ2ZYGf5bdLWZ9oeDSrXjcQrc6SsdbPZynPaY862z35NiELu08qV4CPiwzCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933813; c=relaxed/simple;
	bh=VSw1Tt3KHFlv77P9gugt1YJuYopNoKHPw/Gf/Hm1sm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVY0+lcH0mZjzOZFzuMeQqHNkDT5cN6gzIYkRSlFVV6DwnuM1L/omWsRQU2HMwrWRovJJX4VVVYsExlXk2y6M0qfPUBYZAoyzKjrzwRTfHIwtM+L/JK0cUdoQh9EGDB3cfT50iRI+hpIRcSOjDi1nGQ7x3pdweyRt/S1ys5dF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIOghvpT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIOghvpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DACC4CEF9;
	Mon, 20 Oct 2025 04:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760933813;
	bh=VSw1Tt3KHFlv77P9gugt1YJuYopNoKHPw/Gf/Hm1sm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIOghvpTo35l5zKJsO9PxB0p542CN92M/uNgRWQDN0qoT9dHdxfHRUf0iNtK0+a/t
	 boZ8E2/w5PjmXV5bXeWNvnkQhwHqiiNmuBcjr1Ltbny/hATCmNqFujXqeO8O9pc3Vh
	 uVuhoMhKCrzrvgpTJZIKx1haZs6+x52sEdREChSGdHofPAOmyC+uR49E28XqwZOPoG
	 hKG72hk9C+V2UcetgV74MAze79wnyPLsa2PtpC5dPNq6mB9L8PVCKP9z5HdFjlvD0f
	 Kdl43iQ2Z/uZBhj6UclDmSOxFlEf+8IPZwpnWkvJjzGdxnTsmOUtVf5mRvMlp0LJT6
	 5SS8FjhdrvOtw==
Date: Mon, 20 Oct 2025 13:16:46 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: hupu <hupu.gm@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, justinstitt@google.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: Re: [PATCH] perf build: Support passing extra Clang options via
 EXTRA_BPF_FLAGS
Message-ID: <aPW3rilb8DtFDIMC@google.com>
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020024049.6877-1-hupu.gm@gmail.com>

On Mon, Oct 20, 2025 at 10:40:49AM +0800, hupu wrote:
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
>     EXTRA_BPF_FLAGS="--sysroot=$SYSROOT"
>     make perf ARCH="$ARCH" EXTRA_BPF_FLAGS="$EXTRA_BPF_FLAGS"

Why not just:

  make perf ARCH="arm64" EXTRA_BPF_FLAGS="--sysroot=..."

> 
> Change history:
>   v2:
>     - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
>     - Update commit message
>   v1:
>     - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options
> 
> Signed-off-by: hupu <hupu.gm@gmail.com>

Leo, are you ok with this?

> ---
>  tools/perf/Makefile.perf | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 47c906b807ef..f1f2efdbab8c 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1249,6 +1249,11 @@ else
>  	$(Q)cp "$(VMLINUX_H)" $@
>  endif
>  
> +# Allow users to specify additional Clang options (e.g. --sysroot)
> +# when cross-compiling BPF skeletons, enabling more flexible
> +# build configurations.

Can you please move this comment or add new one at the top of the file
along with EXTRA_CFLAGS?

Thanks,
Namhyung

> +CLANG_OPTIONS += $(EXTRA_BPF_FLAGS)
> +
>  $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
>  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
>  	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
> -- 
> 2.43.0
> 
