Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448E3E559A
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377695; cv=none; b=p/WDkPxNhADgs7qP4UOBR9jjaFY5I6Ml9VfhEf/aFIQOtDEFwuzhaqLQNh4ceAP37p25Pp7lHFMq2iiWs0DNv4w9gVRfQuzH7BDROHoXfQ0GUfyS0++s5Ftja9h/PbZgqL1LAkzFfKUHMe7enOfP+ZniioQyx/2WcX2ploTB4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377695; c=relaxed/simple;
	bh=rO0d2ILcSt25ITYu4+ErpQ1pyyRjnouYWBAlBFd5Gec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TiUIB9AtwyWT+9DLH89OOl5+UXU8dA4kcaeAsQeOGaQO5V9thcQAVHs3+RASph6O0pVKljXPmWND4ImV4Y3YPTf4pvWfUC+k1W6PRrkIP8tx9JJ1s5+vgkPdyj1JIS+/sp1KBaudy9D00Z06b/fFlbADxDN/nlXKnPxE/8TsiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP60y+Qp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP60y+Qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6F61F000FF;
	Fri, 25 Sep 2026 23:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377693;
	bh=nfunc8J0r5bPaVzSwi+mHITfN6zuNljDK4B27sA7QBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZP60y+QpJE7HjIXZr48Uq75Ll48zwIUaeX1L8SndasNsoykzC8+naLyG5KBppGuXs
	 lsiFZB1Kcw1eVyWwWzmTlpt7DHYxSLZXYgT5nGQP3AqRcOwG6Umjy05U1o37CMWVq0
	 NVZY1iYS3WYiu/emwOzHav0Sx9mzEhtfohBMOKsiAvlrmAXnymlqdamxBaQ+sGNoC0
	 3l33cyY3MV9Dihj4NGNsIldQ1lvTXXRhDWacopAVWHpRw4xaBIxVZYxlvEQM7cXfQx
	 HMsj4HuMXnYRbbJbWTae+0Ega7CKbuUliihQD0hI8WY6DPiDuDk+mIXgy8qD2LKy6k
	 iL/EJI51aGLmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] perf tools: Bump the minimum Python version to 3.9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <arb9OMEQ8HCcw-9O@x2>
References: <arb9OMEQ8HCcw-9O@x2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 23:08:12 +0000
Message-Id: <20260925230813.6F6F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: incomplete python 3.9 version check leads to build crash
--

commit 7a016e98c4330410787d9ac22be5c76fe463b5ce
Author: Arnaldo Carvalho de Melo <acme@kernel.org>

perf tools: Bump the minimum Python version to 3.9

This commit bumps the minimum Python version required by the perf build
from 3.6 to 3.9. It replaces the custom removesuffix() implementation
with the built-in str.removesuffix() and updates the version check in
Makefile.config.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0ba307e78fe1f..549a809a88ca2 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -876,10 +876,12 @@ ifneq ($(NO_JEVENTS),1)
>    ifndef PYTHON
>      $(error ERROR: No python interpreter needed for jevents generation. =
Install python or build with NO_JEVENTS=3D1.)
>    else
> -    # jevents.py uses f-strings present in Python 3.6 released in Dec. 2=
016.
> -    JEVENTS_PYTHON_GOOD :=3D $(shell $(PYTHON) -c 'import sys;print("1" =
if(sys.version_info.major >=3D 3 and sys.version_info.minor >=3D 6) else "0=
")' 2> /dev/null)
> +    # Minimum Python version, the same one the kernel requires, see
> +    # Documentation/process/changes.rst: jevents.py needs PEP 585 generi=
cs,
> +    # list[...] and friends, that are subscriptable from Python 3.9.
> +    JEVENTS_PYTHON_GOOD :=3D $(shell $(PYTHON) -c 'import sys;print("1" =
if sys.version_info >=3D (3, 9) else "0")' 2> /dev/null)
>      ifneq ($(JEVENTS_PYTHON_GOOD), 1)
> -      $(error ERROR: Python interpreter needed for jevents generation to=
o old (older than 3.6). Install a newer python or build with NO_JEVENTS=3D1=
.)
> +      $(error ERROR: Python interpreter needed for jevents generation to=
o old (older than 3.9). Install a newer python or build with NO_JEVENTS=3D1=
.)

[Severity: Low]
If a user with an older Python version follows the suggestion to build
with NO_JEVENTS=3D1, won't the build crash later on?

Because this version check is inside the ifneq ($(NO_JEVENTS),1) block,
setting NO_JEVENTS=3D1 bypasses it. However, tools/perf/util/setup.py also
requires Python 3.9 for the PEP 585 list[str] generic in functions like
clang_has_option():

tools/perf/util/setup.py:clang_has_option() {
    def clang_has_option(cc: str, cc_args: list[str], ...
}

When the build reaches setup.py to build the Python bindings (unless
NO_LIBPYTHON=3D1 is also specified), won't it fail with a cryptic TypeError
("'type' object is not subscriptable") instead of a clean Makefile error?

Should this Python 3.9 version requirement be enforced globally rather than
just for jevents generation, or should the suggestion to use NO_JEVENTS=3D1
be removed?

>      endif
>    endif
>  endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/arb9OMEQ8HCcw-9O@x2=
?part=3D1
