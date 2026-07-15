Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65134214A;
	Wed, 15 Jul 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119522; cv=none; b=CHyEyGkzeKFZTa+5Dz6fScusFwkbP6BRAE2g4kFn2IPvOxD87Hn3a5wIgxU/JlIq/uILKupcmPANx43iUXDjYQW5VVcHphUA8fwivHdcSCnGkklJfniuEnl9g04RA9IpV0Sp/OwD7osEIcaFmKzfHPqRzbl9omdlkk/AJZe4k4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119522; c=relaxed/simple;
	bh=K91TfvCzgbDScGtuSCSnPD/N2SbYUwr3UW3bgdP56n4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DKSCEmhM7sMs6kYuKFGLKD0RGkvR4rGORWbnsgkrloZLFEq4rHxyE/mhrSJ9hRQ6xye5Qvy/UBxJ7CHtAuLjO1Uu07HNdBxfm/wapjHTWF+PYtITIRnZZ4ucdzhqdxWCrsPjx7YTf5JJ/NCh5t6Ax6pSc8UethbZ+Ch7/4sI3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUg3mL6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUg3mL6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA9E1F000E9;
	Wed, 15 Jul 2026 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784119513;
	bh=8X71RFnEW3/+gILzNZnilKWuMfJd0zaQ+eNCyzdiOtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUg3mL6pVwI1uiTTzv8jWI6COj0Aciln1MZjPdF/Oy9rIO8pXoRBvno9au4CrPzOK
	 7PGc/OK6HlYV7lE0JMNE5YLKFXQBpvjTkhlfeBqfTUGfyMyUG0m3ohKzH3b7d6Gq5J
	 HyKZhRgbWxp91TyopMreE087/cUbUIK6Qin6L1W3RjcooZ7IRU6odUW+cqk7gB3MKS
	 /nObN+KJL6YRRPZ7YEwLD4vu1ONL8MFVXKFC4El9Y0Sm+H0nbbg3cHFmtRClHbXUJC
	 ApSUbobeSvo8/rPvSxcMxl8NLg/vuq5O/cfRfwx6afZWxklVphiGJb05hcOZiDpvov
	 bDYuEo7fhH9uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] tools/build: selftests: Allow versioning LLVM
 lld
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260715-james-perf-llvm-version-v3-4-8854bfe5af7e@linaro.org>
References: <20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org>
 <20260715-james-perf-llvm-version-v3-4-8854bfe5af7e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:45:13 +0000
Message-Id: <20260715124513.8DA9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Bypassing Clang's internal linker path resolution causes silent =
linker version mismatches for out-of-path toolchains.
- [Low] Unbalanced parenthesis in the `USE_LD_ERR` error messages.
--

--- Patch [4]: [PATCH v3 4/5] tools/build: selftests: Allow versioning LLVM=
 lld ---
commit cdccb2d14502b0641ebfd4e8ddb945bdb605ed46
Author: James Clark <james.clark@linaro.org>

tools/build: selftests: Allow versioning LLVM lld

This commit updates the BPF selftests Makefile to use the LLD variable
from Makefile.include to ensure consistency with the rest of the LLVM
toolchain. It explicitly resolves paths to the linker via shell commands
and passes the result to clang's -fuse-ld flag.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -264,30 +264,34 @@ $(OUTPUT)/%:%.c
> =20
>  # LLVM's ld.lld doesn't support all the architectures, so use it only on=
 x86
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
> -LLD :=3D lld
> +USE_LD :=3D $(shell command -v $(LLD))

[Severity: Medium]
Will this shell resolution cause silent linker version mismatches if a user
builds with an out-of-path compiler (e.g., CLANG=3D/path/to/clang) without
setting LLVM=3D or modifying the system PATH?

Previously, passing -fuse-ld=3Dlld allowed clang to natively resolve the ld=
.lld
binary relative to its own executable path. Bypassing clang's internal link=
er
path resolution with `shell command -v` might cause the build to pick up a
system linker (like /usr/bin/ld.lld) instead of the bundled one.

> +USE_LD_ERR =3D linker '$(LLD)' not found - add it to PATH, or pass LLVM=
=3D/path/ or LLD=3D/abs/ld.lld)

[Severity: Low]
Is there an extra closing parenthesis at the end of this error message stri=
ng?

>  else
> -LLD :=3D $(shell command -v $(LD))
> +USE_LD :=3D $(shell command -v $(LD))
> +USE_LD_ERR =3D linker '$(LD)' not found - add it to PATH, or pass LLVM=
=3D/path/ or LD=3D/abs/ld)

[Severity: Low]
Is there also an unbalanced closing parenthesis here?

>  endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-james-perf=
-llvm-version-v3-0-8854bfe5af7e@linaro.org?part=3D4
