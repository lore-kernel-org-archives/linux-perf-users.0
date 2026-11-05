Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904839;
	b=zIvBIah/dYe732zbE6EmMdWPLf0m93oT49xgFELDR+tnZjCwFkfp9dX8lM5fvXWs/fj+
	 yOTCG/JpSgNyK7jKVCsgNVfUw6mX0ZQA7xUkgiY6KDZoAATwn1GjgLulq4187D9X2SJqk
	 25pUC98KkSOfwcluTmyCop4jh1KlI8OooEx9jZRL4+8ttKadonyG+xPBm4Xzch8XZRT/g
	 QbT+xvYXc13+eiG1jrr4h4ZaNYQ5gzRCyKUzpn/Gg4J5YShmNbgFx6ftvotKcwxrFTsqT
	 QtOaSkxAtqMXq+MiuO2hySNZiiSdzvWS2cA+Xp7jfmYTSmncE5wT8v7CTpeVLR27uqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904839;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=itQu5PcPY232SJrrA0HaUUGql0mHTrMBDHhRtuHvsXo=;
	b=kYiHOkQBTthqB9mBsdSLj/0n+A9s+kuWvY80NFbkIgfoW7+IRiNs/cXEctPfKnK9YHv7
	 vVkDhxG7BYNuvyJpa6jTu6ZsrOXaZC5eOjk/uZfaDFZuXl+Q3U4fo4n/50az9EogyrJ5m
	 j80L8HC4U/KN2rMu9eK6W+tv+oKMZoeJh7iUqqtBPb9GDfmKsBfbDFQRd9OxyTQW1s1HO
	 LFIkYRYVQgy+LEQUTuCe/hYCq7LhwA4vVA9hYor4DXeL7t8BOSE3xq/x/tdRhrf9MxbQ3
	 On8O/eoU+F044d6N0efYZI8aiW/XsT186bQmMkiA1vEDX5GlKT9uAE/6YnKn4+CL/XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vua1vXL+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DA606A328;
	Thu,  5 Nov 2026 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vua1vXL+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205FC1F00A1C;
	Thu,  5 Nov 2026 18:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904838;
	bh=itQu5PcPY232SJrrA0HaUUGql0mHTrMBDHhRtuHvsXo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Vua1vXL+7t7nGV6mXb1ezpiTvY0B1a0GwrzaBO9XZ8BPIjkPutOEApEayTFcSWK6Y
	 wACIMDKS0DGjmyBLDFMEY9oQE7IEI4Ga7RT/dgHFp/vA/mJOxGJ6Fanwyct7lorH0Z
	 ZROkwVGDqaPAFyvF5aVNDbYZjnmbZKQx/rKda3nlAFZQ6hb5f3fJSUkJb/HLKbeoD2
	 A59ifRRuWsW4Q5LMF8VKkICeMgD8Ts//Db90i97BMa5Vbdqli67UZYl6ztoTsls538
	 4Gxb2YEe6hMQWUFLepP3BpVAvdWaaauMLIlyqbEL8dyXmuw/r6HG+oUsTbKxPa4+iA
	 UH/0uoHjfCFEw==
Content-Type: multipart/mixed; boundary="===============3636885184756630589=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7fa310c2243ed68418183781564381babd057227650f47f20ee31aee04273a38@mail.kernel.org>
In-Reply-To: <20261105180923.3441359-4-irogers@google.com>
References: <20261105180923.3441359-4-irogers@google.com>
Subject: Re: [RFC PATCH v3 3/3] bpftool: Prefer zlib-rs over zlib when available
From: bot+bpf-ci@kernel.org
To: irogers@google.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,qmo@kernel.org,ojeda@kernel.org,nathan@kernel.org,nsc@kernel.org
Cc: boqun@kernel.org,gary@garyguo.net,bjorn3_gh@protonmail.com,lossin@kernel.org,a.hindborg@kernel.org,aliceryhl@google.com,tmgross@umich.edu,dakr@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,linux-perf-users@vger.kernel.org,bpf@vger.kernel.org,rust-for-linux@vger.kernel.org,linux-kbuild@vger.kernel.org,llvm@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 18:53:58 +0000 (UTC)

--===============3636885184756630589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Prefer zlib-rs over zlib when available

TL;DR: Possible behaviour issue: bpftool ignores perf's NO_RUST/NO_ZLIB_RS, so
"make -C tools/perf NO_RUST=1" may still build and link the bootstrap bpftool
against zlib-rs via cargo.

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile

[ ... ]

> @@ -115,8 +119,20 @@ ifneq ($(SKIP_CRYPTO),1)
>    CRYPTO_LIBS := -lcrypto
>  endif
>  
> +ifneq ($(CROSS_COMPILE),)
> +  ifneq ($(MAKECMDGOALS),bootstrap)
> +    ifneq ($(RUST_TARGET_FLAGS_$(ARCH)),)
> +      RUST_FLAGS += --target=$(RUST_TARGET_FLAGS_$(ARCH))
> +    else
> +      NO_ZLIB_RS := 1
> +    endif
> +  else
> +    NO_ZLIB_RS := 1
> +  endif
> +endif
> +
>  ifeq ($(MAKECMDGOALS),bootstrap)
> -FEATURE_TESTS := libelf-zstd
> +FEATURE_TESTS := libelf-zstd $(if $(NO_ZLIB_RS),,zlib-rs) zlib
>  FEATURE_DISPLAY :=
>  else

The commit message says bpftool stays aligned with tools/perf, and that
zlib-rs is shared with the bootstrap bpftool built for perf BPF skeletons.
In perf, zlib-rs is turned off when NO_RUST is set or rustc is not found:

tools/perf/Makefile.config:
    ifneq ($(NO_RUST), 0)
      NO_ZLIB_RS := 1

That NO_ZLIB_RS is a plain makefile variable in perf, so it does not reach
the sub-make that tools/perf/bpf_skel.mak runs:

    $(MAKE) -C ../bpf/bpftool OUTPUT=$(SKEL_TOOL_TMP_OUT)/ \
        $(BPFTOOL_RUST_OUTPUT) bootstrap

bpftool only looks at NO_ZLIB_RS and CROSS_COMPILE and never at NO_RUST.

Can "make -C tools/perf NO_RUST=1" on a host that has cargo and the cargo
registry installed still list zlib-rs in the bootstrap FEATURE_TESTS here,
run cargo to build libz_rs.a, and link the bootstrap bpftool against it?

Would it make sense to pass NO_ZLIB_RS=1 from bpf_skel.mak when perf has
disabled zlib-rs, or to have bpftool honour NO_RUST=1?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42083491750
--===============3636885184756630589==--
