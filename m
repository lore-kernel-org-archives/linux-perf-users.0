Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158F93C0A0C;
	Thu, 14 May 2026 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793025; cv=none; b=lGG2GZ8SByYuFGdpgXUYrQ0cg56a1QQUkTM80BWPErqYmylieJ6bOZDXMO6HzDg9p4OuQ2Lf6LU7pnLpQ45cmS/mqjjmiPmpzXcabP+6jpwx/K6J4pfy3aqmmzlTozq17arx6O67/zHD7zA7KDbgJRWCEgUU6oo0fYDpKxD0/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793025; c=relaxed/simple;
	bh=decDz5d4+a1I7sr08qV9Ojb0MxrLoeuG4PAa0zCsH4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XvKCO6bbNxGAIykaitSEp3KEOR8wHOaoro9eJZwXN5GZ/S14rtFmEjht0fgsCOAsJqcpzq42eHl+9c6vyZbd3E8A+lal7vEeUAFSu9zLxJ8vnkP0RzmG2LYlDBzrT8ZJddiH5etRiaDq1fYx2SaBIljwaI7eCeFrNhB2c/dxXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcf40fcf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcf40fcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A54C2BCB7;
	Thu, 14 May 2026 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778793024;
	bh=decDz5d4+a1I7sr08qV9Ojb0MxrLoeuG4PAa0zCsH4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tcf40fcfXDXyOTDOSijprx7WTotVLz88rpXe8+J+2JtRq/TyOkNS7/LawHHapPUSK
	 9G5QLkxfvKRMhIWzlLREcDkly7cK9ueAG+YE7qB3CcZO3NI8x6EO1ce51/ha6X8YwE
	 PNB/cnaXOa/5tgiKB6UKEtcUOHEAeOTrG8JUxT1UtOi7RJbxC/efDl3acZyyaLKs5y
	 P8qTyk7KwtMzHKuL20GDE2VrPreNUZb96nIR02HTV2T4Gjs6GINTtUOD43WZVWP8Sm
	 keVGTF+RJb3UQbrKq0BUEwz6CuX2V/uvp2IEH+9/NGkV62ImNJAugHq4BqV8i7/YAn
	 5LWVsaI4CjTiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/17] tools build: Fix test-clang-bpf-co-re.bin to
 generate target file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260514163409.927816-4-irogers@google.com>
References: <20260514163409.927816-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 21:10:23 +0000
Message-Id: <20260514211024.89A54C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Broken dependency tracking for `test-clang-bpf-co-re.bin` due to=
 missing `.d` generation and prerequisites.
- [Low] Incomplete implementation: `test-bpftool-skeletons.bin` suffers fro=
m the identical missing target file flaw.
--

commit 57e84770100052aa7d6b943326d9f33e586ed45a
Author: Ian Rogers <irogers@google.com>

tools build: Fix test-clang-bpf-co-re.bin to generate target file

This commit fixes the test-clang-bpf-co-re.bin feature check to ensure
the target file is created on disk upon success. This allows Kbuild to
cache the detection result and avoids redundant sub-make forks.

> Because the target file was never created, Kbuild could never cache the
> result of the check. Consequently, Make treated the prerequisite as missi=
ng
> and continuously re-executed the Clang BPF backend compilation check on
> every single sub-make evaluation during build startup.

The commit message identifies that failing to create the target file
breaks Make's caching. In the same Makefile, test-bpftool-skeletons.bin
redirects its output but never creates the $@ target file:

$(OUTPUT)test-bpftool-skeletons.bin:
	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
		> $(@:.bin=3D.make.output) 2>&1

Should test-bpftool-skeletons.bin also be updated to ensure the target file=
 is
touched upon success, to prevent the same redundant sub-make fork overhead?

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index dc828523b50ad..c34faccdf28bd 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -385,7 +385,7 @@ $(OUTPUT)test-libzstd.bin:
> =20
>  $(OUTPUT)test-clang-bpf-co-re.bin:
>  	$(CLANG) -S -g --target=3Dbpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
> -		grep BTF_KIND_VAR
> +		grep BTF_KIND_VAR > $@.tmp && mv $@.tmp $@

Since this manual $(CLANG) invocation doesn't use the -MD flag (unlike
standard targets using $(BUILD)), no .d dependency file is generated.
Additionally, there is no explicit prerequisite on the corresponding .c sou=
rce
file.

Now that the target file is created on disk, will Make consider it
up-to-date indefinitely and silently ignore future modifications to
test-clang-bpf-co-re.c during incremental builds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514163409.9278=
16-1-irogers@google.com?part=3D3
