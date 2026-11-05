Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904837;
	b=csAaV+OKXHEGH7AK6b3K5Z/oMMOHORpKjJ8lK+9G1Jo83cSEDY1xkG5XvZuqEFN630w6
	 EObjk47MzYQIzK/fWsSH9gfYNq/QLxGvXYzBEwhbmDlaTtsBcVrgLoC9YvTk9xA2/F5B/
	 tQshpnkO9hvoyCqjEFIHFdu+CKF3iVymx2CRz45IyzRQ7BWuxtllyh70ZdFPSDV/UndIV
	 /sN8sfb71N+6P4F3krLEgCjMEscL/6Q9wTBVLYq8s6hAmS4+pFVtowC3gvSNKQYSM+s2R
	 coEf0c89KDOAVwRKQHEYSfWv7svd88Bdj9F5trbAD6pdBftpmeEC/LfURcFVSwYNkdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904837;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=zXP2C12Rqxd/DFjQ9FI75BDat4fCWKVfuDfnPCCcV+s=;
	b=IjCFcPxxBlD1/V7Rln/FZrbGKUeM42x8PypIGo1UzFD+hN11HzQaonJcQ8CIlNjgb5jp
	 s7+WUNCTcBiptDq65cm/PPZ/RLOPMA2miQC8l9aqPUc+U3yyiBhEfQXuS34ixW0uFbnMh
	 SVx8/gRyy07XKMYFM/6jseDuluNa5EbUrYlc/ozZOiCiylq69RLno18r4vOQemqLaHtII
	 qIo6FMCQTBvB7l99dfoT6RORgoqFumFD2YmNd6ILa2lDixJyWgZCKKTxUkJOm9gT9gLTY
	 N9mYt2+WOHorM+tllBoSCrWrzrs3+kZdEFBYkgsTgnOsv3WDT3lxOlKVd+Lxi2Lg+uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gK/LAXFU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CBC606A32E;
	Thu,  5 Nov 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gK/LAXFU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200A61F00A16;
	Thu,  5 Nov 2026 18:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904836;
	bh=zXP2C12Rqxd/DFjQ9FI75BDat4fCWKVfuDfnPCCcV+s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gK/LAXFU/KpD2j0k3Xa7YGoTULjcLF1sNVp+imDHEHUcNwifExDTnTAVVyWCw2+l4
	 yRBpikZ/rE7zd7ZED2TIx8vpldoCK7Sg8KTzNMCMSKCZ3BM1wYzKaFsrAUXM1xugDH
	 vYGRnCVLyqlkedoYQahgz7OycfLuuH7M+xKnLK+SPg/KVuStnVEocdKvP+rq9RG0PT
	 sxvMnSFRIlhnvtZ6Idm0gYacOMtZ3yGeUcDH7sSHYMwoT3gUzCVozwHkCH4FiKp7nm
	 ziueTB5XjT+rpWWq89z5O7XWVGnXEfmkNpk70PL7uK5Qe1SSPI2z1J9KuyGrdyAPW/
	 1Zfj4h3j8ZxFw==
Content-Type: multipart/mixed; boundary="===============5086896221721732210=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a05891adfdd81e0ba070615ac434052257f0f0fb5c462725677f7b48c62a43b0@mail.kernel.org>
In-Reply-To: <20261105180923.3441359-2-irogers@google.com>
References: <20261105180923.3441359-2-irogers@google.com>
Subject: Re: [RFC PATCH v3 1/3] tools build: Add Rust library build infrastructure and zlib-rs feature test
From: bot+bpf-ci@kernel.org
To: irogers@google.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,qmo@kernel.org,ojeda@kernel.org,nathan@kernel.org,nsc@kernel.org
Cc: boqun@kernel.org,gary@garyguo.net,bjorn3_gh@protonmail.com,lossin@kernel.org,a.hindborg@kernel.org,aliceryhl@google.com,tmgross@umich.edu,dakr@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,linux-perf-users@vger.kernel.org,bpf@vger.kernel.org,rust-for-linux@vger.kernel.org,linux-kbuild@vger.kernel.org,llvm@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 18:53:56 +0000 (UTC)

--===============5086896221721732210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools build: Add Rust library build infrastructure and zlib-rs feature test

TL;DR: Prepending CLANG_CROSS_FLAGS to CXXFLAGS in the feature tests may break
C++ checks (cxa-demangle, llvm) when cross-building with CC=clang but a g++
CXX, silently dropping perf features.

> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 4d37d11f674c..ecf27626d493 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -5,10 +5,11 @@ ifneq ($(OUTPUT),)
>    OUTPUT_FEATURES = $(OUTPUT)feature/
>    $(shell mkdir -p $(OUTPUT_FEATURES))
>  endif
> +RUST_OUTPUT ?= $(abspath $(or $(OUTPUT),$(CURDIR)))/
>  
>  feature_check = $(eval $(feature_check_code))
>  define feature_check_code
> -  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)" CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
> +  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) RUST_OUTPUT="$(RUST_OUTPUT)" CC="$(CC)" CXX="$(CXX)" CARGO="$(CARGO)" RUSTC="$(RUSTC)" $(if $(PKG_CONFIG),PKG_CONFIG="$(PKG_CONFIG)") CFLAGS="$(CLANG_CROSS_FLAGS) $(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(CLANG_CROSS_FLAGS) $(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" RUST_FLAGS="$(RUST_FLAGS)" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
>  endef

Is it correct to prepend $(CLANG_CROSS_FLAGS) to CXXFLAGS here?

CLANG_CROSS_FLAGS is computed in tools/scripts/Makefile.include from a
probe of CC alone (CC_NO_CLANG == 0 && CROSS_COMPILE set), and holds
clang-only options such as --target=<triple>, --prefix=, --sysroot= and
--gcc-toolchain=.  Nothing checks that CXX is clang.

With 'make CC=clang CROSS_COMPILE=aarch64-linux-gnu-' (no LLVM=1),
Makefile.include leaves CXX as $(CROSS_COMPILE)g++, so each C++ feature
test would run as something like:

  aarch64-linux-gnu-g++ --target=aarch64-linux-gnu ... --gcc-toolchain=/usr
      -MD -Wall -Werror -o test-cxa-demangle.bin test-cxa-demangle.cpp

and g++ rejects the unrecognized --target option.  The probe is silent
(output goes to /dev/null), so feature_check for cxa-demangle, llvm and
llvm-perf would return 0 and perf would drop HAVE_CXA_DEMANGLE_SUPPORT
and libllvm support without any error.

Before this patch CXXFLAGS in the feature sub-make did not contain
CLANG_CROSS_FLAGS, and Makefile.include only appends it to CFLAGS and
AFLAGS, so those tests passed.  The same kind of failure was already fixed
for native perf builds in c8592f8da838 ("perf build: Only pass clang flags
to CXX when CXX is clang"), where tools/perf/Makefile.config probes
CXX_NO_CLANG separately.

Could CLANG_CROSS_FLAGS be added to CXXFLAGS only when CXX is clang, or
left on CFLAGS only?  The commit message also does not mention that
CLANG_CROSS_FLAGS is now passed to every tool's feature tests.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42083491750
--===============5086896221721732210==--
