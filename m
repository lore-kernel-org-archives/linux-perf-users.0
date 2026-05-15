Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF783EFFB2;
	Fri, 15 May 2026 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868284; cv=none; b=HozSo83cwzozUh23btGiCKBtskmhTbFnXyj3QRz0+qvUDZqRMdMPWNZe/CkztvTWOMKHszhAhNoItx2rNbKsdlgGGddJfDKxzP6hJcA8oPXvzRvKf5KconOVnVCanbev43Bo3BJfPouzgg4a4Y53cGhcBX7f5MtbqtdZhz6bF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868284; c=relaxed/simple;
	bh=XQUeR9WLWM1bYFhHSY6dnds7dKJzX/NkWxk1KegAYzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mNDsdt9yc1JBjBUQFLge3ccEUmM5MZOZDIlJCJkTKrh+tIPvP3dBYITMW9lkmE9GIm4/y/hdKQA9GgQgFmo79Iz14/mt7Y4JLdiBrxjcPPi20heeU8Qtm9geS1CoXUhcUSLsTR5FVVw6gGupIaO4iqf3E2vMTiqmio6dWuJVFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy5zFhtx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy5zFhtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B4DC2BCB0;
	Fri, 15 May 2026 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778868284;
	bh=XQUeR9WLWM1bYFhHSY6dnds7dKJzX/NkWxk1KegAYzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Zy5zFhtxiLjnrt4OtMgE2vBzI+jvz8qX93nLm21fxyfTgfSRGflaLSyflUlEwFVUw
	 sJ5xlTdaXbbRuZc5sFy3ZTpAcHQL3a6lqWH/bFrTncfVs0vzgzpaOl4AaevOvByxES
	 OvFnQs6oDm0edIbG3VhWq1MKfeMpHll84YmpNZF+NJwGSob+QveJ7U8f/MYMRdgxra
	 nWZkHmDaIeJCcG6cuyd8VQB2TZVTUnhTK07tqS0mt7BMmYsvq9OFW2sOKcTFx7cre0
	 on0YfL5MoQU0s7EzyJj/uKDanz6On88unqvmurHDV5VDnq4N8/rR2XAfiF43hauIzv
	 l1AU2oTu3hGJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/14] tools build: Fix feature checks to touch
 target files on success
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260515173852.1378571-2-irogers@google.com>
References: <20260515173852.1378571-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:04:37 +0000
Message-Id: <20260515180443.D1B4DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Build Artifact Leak / Make Clean Breakage
- [Medium] Error Reporting / Diagnostics logic fails to capture actual comp=
iler/tool errors
--

commit 566bad233a12ce681515edad91fc35069a93ec9e
Author: Ian Rogers <irogers@google.com>

tools build: Fix feature checks to touch target files on success

This commit modifies the clang bpf and bpftool feature checks to physically
touch their target files on disk upon success. It also adds redirection to
create a .make.output file, allowing Kbuild to cache positive detections
and avoid redundant sub-make executions during build startup.

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
[ ... ]
> @@ -383,9 +383,9 @@ $(OUTPUT)test-libaio.bin:
>  $(OUTPUT)test-libzstd.bin:
>  	$(BUILD) -lzstd
> =20
> -$(OUTPUT)test-clang-bpf-co-re.bin:
> -	$(CLANG) -S -g --target=3Dbpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
> -		grep BTF_KIND_VAR
> +$(OUTPUT)test-clang-bpf-co-re.bin: test-clang-bpf-co-re.c
> +	$(CLANG) -S -g --target=3Dbpf -o - $< |	\
> +		grep BTF_KIND_VAR > $(@:.bin=3D.make.output) 2>&1 && touch $@

Does this redirection only capture the output of grep?

Because the output redirection is applied strictly to the final command in =
the
shell pipeline, the stderr from the compiler might flow to the parent shell
instead. Since the parent Kbuild feature check suppresses output, this
regression could prevent actual compiler errors from being captured in the
.make.output file, defeating its purpose for diagnostics.

[ ... ]
> @@ -398,7 +398,7 @@ $(OUTPUT)test-libopenssl.bin:
> =20
>  $(OUTPUT)test-bpftool-skeletons.bin:
>  	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
> -		> $(@:.bin=3D.make.output) 2>&1
> +		> $(@:.bin=3D.make.output) 2>&1 && touch $@

Since test-bpftool-skeletons.bin is now physically created on disk upon
success, does it need to be added to the FILES list at the top of the
Makefile?

The make clean target relies exclusively on the FILES variable to remove
generated artifacts. If this binary is missing from that list, the generated
file will permanently survive make clean. This regression could permanently
poison the Kbuild cache, causing it to treat the feature as present even if
the underlying bpftool environment is later changed or uninstalled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515173852.1378=
571-1-irogers@google.com?part=3D1
