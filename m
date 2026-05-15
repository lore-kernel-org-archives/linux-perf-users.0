Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F133FE0A;
	Fri, 15 May 2026 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874783; cv=none; b=DaED3RY6WQTsmO+kNoZVO13i1lIiFG0DxU77lXckpzdbNd4v2WU2i7+BWii1p34/wwzJ2TCggUhtps2b6rCODGpwjxh61i+JLTSxxu0mBT6utUB3FeA1N1lgSp7aX7WJKiEOAzlLxLG78cy30CRsaPdFY/ZY+2iQJ86pAI8+XW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874783; c=relaxed/simple;
	bh=EWJtPOGLqzf/IAtmaPmrI+ZNjVDc7cgB37dvTFS1AlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SFxK/EIa4Us4+nCOs8O84hB1PYTFSGRhLECOmoUTEvUx3EvPRaLg0L0eEFjS6NBUTxAv1UlKCrnAevVeGoAJO7ZAhtsmIOoE+WNhxPyp2h8D1AjJyPdGn72q/zwyWX/4LvB65GOscrxzqb4ZqosAr0ug5u+yGnWOJQboSVEVKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bykl5A1B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bykl5A1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AD5C2BCB0;
	Fri, 15 May 2026 19:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874783;
	bh=EWJtPOGLqzf/IAtmaPmrI+ZNjVDc7cgB37dvTFS1AlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Bykl5A1BWVJeq2TeHd9xOn+MfJMe+JG7rBEcYDvHXvMwjNTnNa4aKhWOKcfUBtsyJ
	 ck6tS4AFMhLJdErq73+GD8AVnmo0GRjd+wfjVkCKczOuO09qv8adzduUvlMOGFg2k9
	 KFQPt95DHRE/scZKNJMI9WKSaP4PZgDDNy4EiUHHhBUary0V5GV47ffAirGO9iYAMI
	 g6KIhv/rObxZft5X+rrJCzepMHQx0lyEnCJzg+cHaaGHkfZl2+8Jadpo28Nxje70Vd
	 Y3NJUgN0NlDgVUCRaYIOSPHs3WE3iGmT4as4PM0tLbT9cLak86Ru/Icqua4p2YgtYt
	 xnHfiNOKAUx6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/14] perf build: Move libsymbol dependency out of
 prepare step
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260515193314.1593560-9-irogers@google.com>
References: <20260515193314.1593560-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:53:00 +0000
Message-Id: <20260515195302.B0AD5C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removing `$(LIBSYMBOL)` from the `prepare` step breaks the `make ch=
eck` target and manual object file compilation (e.g., `make util/symbol.o`).
--

commit 6df47358116c567d6b28b1ca848835d2f69dc679
Author: Ian Rogers <irogers@google.com>

perf build: Move libsymbol dependency out of prepare step

This commit moves the libsymbol dependency out of the prepare step and into
the dependencies for the bench and util libraries to reduce serialization
during the build.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 876065a02de6f..96a68723109fc 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf

[ ... ]

> @@ -637,8 +637,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
>  	bpf-skel-prepare \
>  	$(LIBAPI) \
>  	$(LIBPERF) \
> -	$(LIBSUBCMD) \
> -	$(LIBSYMBOL)
> +	$(LIBSUBCMD)

Could removing $(LIBSYMBOL) from the prepare step introduce a regression for
the make check target and manual object file compilation?

Both the make check target and the generic object fallback rules, such as
make util/symbol.o, depend exclusively on the prepare target:

check: prepare
	if sparse; \
...

$(OUTPUT)%.o: %.c prepare FORCE
	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3D$(build-dir) $@

Previously, prepare triggered the $(LIBSYMBOL) target, which installed
required libsymbol headers like <symbol/kallsyms.h>.

By removing this dependency, are we no longer guaranteed to have the
necessary headers installed when running make check or manually building
object files from a clean tree?

It appears this could cause them to fail with a 'No such file or directory'
error when processing files that include libsymbol headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515193314.1593=
560-1-irogers@google.com?part=3D8
