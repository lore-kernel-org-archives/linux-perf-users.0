Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04B328611
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154527; cv=none; b=uUJsQrTbd5IqJBCyneCJY0cBRbRhUte+vWnneybIZY9sWvEPAmkIG+a7C4wG3tyNpXlllHqOhZwe/uI9qWqpigKUyuA3yIOBJM/MHdtm6iflkhbOgiQB9FW9Lr6k/ZZOO2QewFw7OtEuCEIDgBUy1HwnWSTPSYhqOmLOeOsPfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154527; c=relaxed/simple;
	bh=kC2FmY3iYRVhZyL8KYRF5E6y92UpmxOMfLrbnl0GYZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNCmzilVKVoa1hp2/fBmqKSPSoewoW8dB0//poZxNNUAftmk4UzQCl8rn3XDtz6zU3PgkOjlbdZmDGLXSYW28/HNrRQY0SfjasaBhV2fgWJrbZYfIBetkzfE6aGNCrM6fwKEneUlQpr9m9r5MXdDEbwLpPFc2sbnbrN9Q2O8ABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQM697ma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQM697ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED018C2BCF4
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 08:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776154527;
	bh=kC2FmY3iYRVhZyL8KYRF5E6y92UpmxOMfLrbnl0GYZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UQM697maKeDSiPzZ9tqLdIyechHyqVM2jCEXGhvwMqrzl9dZObp5/DlKLY07w2I5y
	 udNt5DrZZuLg9S2Vx6es+LKILW9/KXwKbJ8h6+kVcCDokjI5122TKYsZbbo8A/7+P/
	 LNUknGSgcUt6MNKZYXkx/ATn5ckF5+butpAoXuF0TPG0+OS8Yj4cfTQBwKNU79rmEI
	 jRNlJ/sDQ4cpepjB5pD4j10V18kkWS+w7lHACUXKxCpsj/1X6mCt2IjgmylwnTjlhp
	 usrSiOWTFZ0OQ4eT5EXc6vL9dVTlLiXuT/GeaAH+IEh29gFMMa9tS99SMFJGpnDUkV
	 5qhq/0pidSBPA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671ff4b716cso443557a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 01:15:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+QiwtRoutl1R+KJiNxXPy+q54pFxCMtPcoY9L989lq3pkG4aZMh2Vs8l8xdNoWPx1geQgmRNldN8XDq12sk9ov@vger.kernel.org
X-Gm-Message-State: AOJu0YwtYiXBWoxIJ0YEExHI3uiHYCIpK9+bhA8mPKNiUrjWR1rvkL/T
	+lDHSaaFcKbX6e2bDylw3ccaSoafX+eWRMi5DkvsWgIJDHBQyIt76wfYEwhjuw533VSrKJiOFnl
	CEtp9I94iZ8mDwRmb9Rs4/zMTNYIdLqk=
X-Received: by 2002:a17:907:3ea9:b0:b98:1b18:782c with SMTP id
 a640c23a62f3a-b9d724f0c4amr885938166b.6.1776154525171; Tue, 14 Apr 2026
 01:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414080500.320095-1-r@hev.cc>
In-Reply-To: <20260414080500.320095-1-r@hev.cc>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 14 Apr 2026 16:15:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4q-LUUVLQEXtpm2dARfqZGfKk6Tz=f1_2Uo_ixAjebOg@mail.gmail.com>
X-Gm-Features: AQROBzBU7HT0TAgIhCIul-iItWaFERzy-4SvP-K2qZwQXR57-2ug8EXdNo_AD2M
Message-ID: <CAAhV-H4q-LUUVLQEXtpm2dARfqZGfKk6Tz=f1_2Uo_ixAjebOg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Add clang and rust target flags for loongarch
To: WANG Rui <r@hev.cc>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	loongarch@lists.linux.dev, Haiyong Sun <sunhaiyong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:05=E2=80=AFPM WANG Rui <r@hev.cc> wrote:
>
> From: Haiyong Sun <sunhaiyong@loongson.cn>
>
> Add missing CLANG_TARGET_FLAGS_loongarch and RUST_TARGET_FLAGS_loongarch
> so that perf can be built with clang and enable rust cross compilation.
>
> Signed-off-by: Haiyong Sun <sunhaiyong@loongson.cn>
> Signed-off-by: WANG Rui <r@hev.cc>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>

> ---
>  tools/perf/Makefile.config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 15fbba9f4..1340744a6 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -27,6 +27,7 @@ CFLAGS +=3D -fno-strict-aliasing
>  ifeq ($(CC_NO_CLANG), 0)
>    CLANG_TARGET_FLAGS_arm       :=3D arm-linux-gnueabi
>    CLANG_TARGET_FLAGS_arm64     :=3D aarch64-linux-gnu
> +  CLANG_TARGET_FLAGS_loongarch :=3D loongarch64-linux-gnu
>    CLANG_TARGET_FLAGS_m68k      :=3D m68k-linux-gnu
>    CLANG_TARGET_FLAGS_mips      :=3D mipsel-linux-gnu
>    CLANG_TARGET_FLAGS_powerpc   :=3D powerpc64le-linux-gnu
> @@ -1167,6 +1168,7 @@ ifndef NO_RUST
>    ifneq ($(CROSS_COMPILE),)
>      RUST_TARGET_FLAGS_arm      :=3D arm-unknown-linux-gnueabi
>      RUST_TARGET_FLAGS_arm64    :=3D aarch64-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_loongarch        :=3D loongarch64-unknown-linux-gn=
u
>      RUST_TARGET_FLAGS_m68k     :=3D m68k-unknown-linux-gnu
>      RUST_TARGET_FLAGS_mips     :=3D mipsel-unknown-linux-gnu
>      RUST_TARGET_FLAGS_powerpc  :=3D powerpc64le-unknown-linux-gnu
> --
> 2.53.0
>
>
