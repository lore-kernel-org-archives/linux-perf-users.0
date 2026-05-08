Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C14382F08
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271646; cv=none; b=DQLUnJIYxmL1n2yJVqGghWOUO8ppM0/f3MqqZK2yAdbvjubDaAUWmAvlTewk877ljXnbuNCb2hCOLoOmWOpU4yKU1dAtr8z3edseXyTgZG5uo52xw8/6nfkG2c0VJGcv9XggVGjDJtpx6BsotKEavsCfZ6bP5gJ8rt4sWI0gMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271646; c=relaxed/simple;
	bh=jAdWm0pBCB0ZjFurtR+CkMA3HY16p2xvIUZ3aen7oyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ky+Vk0KTJxqIuYiYqTDrmT6ah1ATj0XYwP4DaU0lHHTaCkO15/XvNCBj3ZArKIr01K1BFb76ZpX/M6ID6MJsKvH5OSn70vSNluzLozqm3Yl/i5hdrgIFkTDeK9aTMQM+nRqzxz1mS7aSlZNxAUuyBNah2Dkqsz6tzheXExPemNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQYz+pUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQYz+pUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759CCC2BCB0;
	Fri,  8 May 2026 20:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778271645;
	bh=jAdWm0pBCB0ZjFurtR+CkMA3HY16p2xvIUZ3aen7oyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uQYz+pUnMxKDmw0vA5lwnUwljkYa1GsR1LZdhrRflxgWOXG9g3yC2GthfN2WZVmCC
	 +l8t8SCTbp+RApK9vecy55Ls0lnbXJ0bhVjtBgzt3hgVZX3PjteivocTwC3iPXq58i
	 KYE+2iyZWPzv3muI+QUO+ULqIpySnxQ25U8ESqBvklkZOqoKj2ar0YspUffvtW4Iu4
	 M4f1uuz39n3klYo8kSgvEj8s7+NvkScvMKoPd3HxkU6COqRB+3hYtyEhYSYeiQkHs2
	 w3n1LGMZQKD/p+mBUXpZ5Is96lp5c6rs+shPzJH9Gi6rYrKu1+VtA2RM+YuVvXwYK6
	 i0QucO9wNFW4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Make leafloop workload immune to compiler
 options
Reply-To: sashiko@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260508-james-perf-leafloop-stack-v1-1-637c260b2da8@linaro.org>
References: <20260508-james-perf-leafloop-stack-v1-1-637c260b2da8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:20:44 +0000
Message-Id: <20260508202045.759CCC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] LTO build failure due to hardcoded static variable name in inline a=
ssembly.
- [Low] Missing ELF `.size` directive for inline assembly function.
- [Low] Fragile section management in top-level assembly.
--

commit 57b4e20838dd06862703b6049b087e60606a2dd4
Author: James Clark <james.clark@linaro.org>

perf test: Make leafloop workload immune to compiler options

This commit replaces the C implementation of the leaf function with an
inline assembly version for AArch64. This ensures compiler options like
-fstack-protector don't inadvertently add a stack frame, which would make
the test_arm_callgraph_fp test pass incorrectly.

> diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/wor=
kloads/leafloop.c
> index f7561767e32cd..58367fd1daece 100644
> --- a/tools/perf/tests/workloads/leafloop.c
> +++ b/tools/perf/tests/workloads/leafloop.c
> @@ -6,10 +6,9 @@
>  #include "../tests.h"
> =20
>  /* We want to check these symbols in perf script */
> -noinline void leaf(volatile int b);
> -noinline void parent(volatile int b);
> +noinline void leaf(void);
> +noinline void parent(void);
> =20
> -static volatile int a;
>  static volatile sig_atomic_t done;

[ ... ]

> -noinline void leaf(volatile int b)
> +#if defined(__aarch64__)
> +/*
> + * Write leaf() in assembly so it stays as a minimal leaf function with =
no
> + * stack frame and won't get silently broken in the future by any Perf w=
ide
> + * compilation options like -fstack-protector-all.
> + */
> +asm(
> +	".text\n"

Could using .text here instead of .pushsection .text and .popsection
interfere with the compiler's section tracking?

If the compiler assumes the previous section remains active after the asm
block, it might place subsequent data or code in the wrong section under
certain compilation flags.

> +	".global leaf\n"
> +	".type leaf, %function\n"
> +	"leaf:\n"
> +	"	adrp	x1, done\n"

Since done is declared as a static variable at the top of the file, if perf
is compiled with link-time optimization (LTO=3D1), the compiler might
partition and rename the C variable to avoid collisions across translation
units (e.g., done.lto_priv.0).

Will the hardcoded string "done" in this inline assembly cause an undefined
reference linker error under LTO builds?

> +	"	ldr	w2, [x1, #:lo12:done]\n"
> +	"	cbz	w2, leaf\n"
> +	"	ret\n"

This isn't a bug, but there doesn't appear to be a size directive
(.size leaf, . - leaf) at the end of the function.

While perf might handle 0-sized symbols internally, could omitting the size
cause issues with external ELF tools, debuggers, or profilers trying to
resolve the symbol bounds?

> +);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-james-perf=
-leafloop-stack-v1-1-637c260b2da8@linaro.org?part=3D1
