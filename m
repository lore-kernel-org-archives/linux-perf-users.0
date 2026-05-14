Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01042641FC;
	Thu, 14 May 2026 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717711; cv=none; b=ZFxBv8NZluZ1u+y+K/LiavWilba58y2vkiIJ5LcBYFbRdtVs47RPSTfgCY5H/5LAUyuB37xhVfjA2PahmvDspy6DPXIGTnkXdfbSa7UwJPfKEkDQu9jDJxZmCpzK2uveD848PEulwVYMDm9s0KrPwAjbcJEdrVxD+kpflz0uYqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717711; c=relaxed/simple;
	bh=Z3LBK28iLzNUpwBrMlTkY/DiDwaaxjDR2HyRG7ZJ6nU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oo9+XT83qC5firZ47cNPNgIpOiMsDV8miH3AgolXdveJb08NJbcuaPc/59y46nBUlYXdx3sl3tXqkX71jGR94B+MVuyg5M+3zB/zZoCeqyXcer+xoK5/vFLgsSPBTfDOIvk0mT57EOWmR8JjYZsH/CZx1KzHWjgUmasd+yuBuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyoLqziN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyoLqziN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5378BC2BCB3;
	Thu, 14 May 2026 00:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717711;
	bh=Z3LBK28iLzNUpwBrMlTkY/DiDwaaxjDR2HyRG7ZJ6nU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XyoLqziNjUhG019Tb4B4gwsQoE59wKe2mG78WomAZhG7ByUHm7c24zRn8hiXk/MEe
	 XpZNiB8Q+VFrKJdjLIZMqrV94Myf0r/tN09hGAUuInlUjNFYDuTdxv4OjrsQacjoyQ
	 G26a1fNYrvHtNrzqCTwJlZ/ZyR2oh3oRj6kt4qBLToOc7oMca/LJ9r3BwMbSZp0Ltl
	 /9e7uBMHCBkTQyhiTvDzo2ZM6dudDxUN6rwwzp8Gf22M5eNnk8Y94BVmuYAP9185Cr
	 aB3YioaUXwmA3DwdVnYggFGEFfgIrOoarlWUCFV2f/OXupgukkm2R6Wv1F5HjvTcIJ
	 9aI/d+50CqsaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/18] tools build: Fix test-clang-bpf-co-re.bin to
 generate target file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260512174638.120445-4-irogers@google.com>
References: <20260512174638.120445-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:15:10 +0000
Message-Id: <20260514001511.5378BC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally redirecting the feature check pipeline directly to=
 the target file (`> $@`) causes Kbuild to permanently cache failed detecti=
ons as successful.
--

commit c952ccdf6ac3df2b44fe927cf8066c42efc727a9
Author: Ian Rogers <irogers@google.com>

tools build: Fix test-clang-bpf-co-re.bin to generate target file

This commit updates the test-clang-bpf-co-re.bin feature check to
redirect the grep output to the target file. This ensures the target file
is created on disk upon success, allowing Kbuild to cache the result.

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index dc828523b50ad..f43f85738b5db 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -385,7 +385,7 @@ $(OUTPUT)test-libzstd.bin:
> =20
>  $(OUTPUT)test-clang-bpf-co-re.bin:
>  	$(CLANG) -S -g --target=3Dbpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
> -		grep BTF_KIND_VAR
> +		grep BTF_KIND_VAR > $@

Could this unconditional redirection cause Kbuild to permanently cache fail=
ed
detections as successful?

If the host compiler does not support BPF CO-RE, grep fails to find
BTF_KIND_VAR and exits with 1. However, the shell processes the redirection
by creating the target file before execution.

Since tools/build/feature/Makefile lacks the GNU Make .DELETE_ON_ERROR:
special target, a failed grep leaves a 0-byte $@ target file on disk.

On subsequent evaluations, make checks test-clang-bpf-co-re.bin, sees the
file exists, and considers the target up to date. This causes make to exit
with 0, which breaks negative feature caching as Kbuild incorrectly
interprets this as feature-clang-bpf-co-re=3D1.

Would it be better to write to a temporary file and move it on success
(e.g., > $@.tmp && mv $@.tmp $@) to ensure the target is only created when
the feature is actually supported?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512174638.1204=
45-1-irogers@google.com?part=3D3
