Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263013B893C;
	Wed, 13 May 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701943; cv=none; b=LZwhlCHq4QBicER+lktnVbxIR9WyU6KSL532o/TY85F3G3oizpatPQpBav4T5L9+xVPsLcgWvl0eX/ZirvWlmZQF27AemQVrqz74X7BKKcbJMmavnAnRTQLf+7tY44y4/DN6OxYHDXz2mL/3B/aMgiX5wERnJlhi+7LQ59D7tTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701943; c=relaxed/simple;
	bh=DU7P2xoGBj+NDCzBfpteGc1keySqh/LGc49XPI7HXwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WTMaB6GGsASqM6GSSQXSPq3HYwNdtMAtzYleIP0X0+ZUZ7lpFgYcjevvZ3+FauEKrLS7ZL3MDV7GNXcKpeJs9N5dzDDWR1JPF0342XB3WAXXIASKUm7V3bumBoVlOtkoBxwd2q7ZDMdQGVK4UzAUHc/7Ph9YU6nKJITJH6i7mzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSdSHb/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSdSHb/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FEBC19425;
	Wed, 13 May 2026 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701942;
	bh=DU7P2xoGBj+NDCzBfpteGc1keySqh/LGc49XPI7HXwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NSdSHb/0vnBwIKfq3YALaIL/6dOwO+q59wALbvmDNk/503iv0Aie29UVtcUfvjXny
	 /Gvzpe1LgJOJJU5mASI0he783+3D1zm6txKb9XndS9qSQWstfUauKDxAnZNtVJ7hNM
	 btXD5SXF4c2w2EB6y04ymm8KqHAYsbTGiR25ZQwvQ7eS9XR9QBPy7fR8KKnpgGZWfW
	 kFOyfdFhgKpw6Ig/KMESMUrcWZtYmx0PIY9XVkuHhKNShT+c0dbK6ysUd5bT7cwUXk
	 hef5wtIn10hmhnndcSPFuJWRHOD0PJ3Xije/JgsyQoeiS9KCCF21PnLs39PvrMzRbr
	 xgq2LQyVJ1wXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/14] perf build: Move BPF skeleton generation out
 of Makefile.perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260512053539.3410189-6-irogers@google.com>
References: <20260512053539.3410189-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 19:52:21 +0000
Message-Id: <20260513195222.21FEBC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `prepare` target evaluates the `$(BPFTOOL)` variable before it =
is defined, causing it to silently expand to an empty string.
- [Low] The `bpf-skel-clean` target fails to clean the intermediate `.tmp` =
directory for bench skeletons, causing a build artifact leak after `make cl=
ean`.
--

commit ba0748386f00351749ad3ff0cb9d88e512a55543
Author: Ian Rogers <irogers@google.com>

perf build: Move BPF skeleton generation out of Makefile.perf

This commit refactors BPF skeleton generation by extracting the infrastruct=
ure
out of Makefile.perf into a shared bpf_skel.mak file. It isolates the direc=
tory
structure and prevents unrelated sub-makes from serializing behind bpftool =
and
clang BPF target evaluations.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 24581941e912e..d4fc10f36781f 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
[ ... ]
> @@ -914,44 +913,13 @@ python-clean:
> =20
>  SKEL_OUT :=3D $(abspath $(OUTPUT)util/bpf_skel)
>  SKEL_TMP_OUT :=3D $(abspath $(SKEL_OUT)/.tmp)
[ ... ]
>  ifeq ($(CONFIG_PERF_BPF_SKEL),y)
> +prepare: $(BPFTOOL) $(SKEL_OUT)/vmlinux.h
>  BPFTOOL :=3D $(SKEL_TMP_OUT)/bootstrap/bpftool

Does the prepare target evaluate the $(BPFTOOL) variable before it is defin=
ed?

In GNU Make, variables in target prerequisites are expanded immediately.
Because the prepare target precedes the BPFTOOL assignment, $(BPFTOOL)
silently expands to an empty string. The build seems to succeed only
circumstantially because vmlinux.h has a transitive dependency on bpftool.

I note this regression is fixed later in the series by commit e42b6c2f3098a
("perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak").

[ ... ]
>  bpf-skel-clean:
> -	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(S=
KEL_OUT)/vmlinux.h
> +	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKEL_OUT)/*.sk=
el.h $(SKEL_OUT)/vmlinux.h $(OUTPUT)bench/bpf_skel/*.skel.h

Is the intermediate .tmp directory for bench skeletons left behind during
cleanup?

While the target explicitly removes the generated headers from bench/bpf_sk=
el/,
it misses the temporary object directory $(OUTPUT)bench/bpf_skel/.tmp where
intermediate .bpf.o files are generated, causing a build artifact leak after
running make clean.

This regression is also fixed later in the series by commit e42b6c2f3098a
("perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512053539.3410=
189-1-irogers@google.com?part=3D5
