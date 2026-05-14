Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E238D3FB;
	Thu, 14 May 2026 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778801716; cv=none; b=pdY2sB0oxK14QSYRFO+2MgoiHdR+y14lhkQ2WqrruQJ7pur9jIAmEUdV4eNlLlmACIqpMT3oKxkaxTRYGY3l0YY9r25pSjhhwNg3sAVNYuzyT1d//Ztdfw3XkTfn10e58aYeqm3hhwAtRw+C6Qyjr88U8UqIJx/m11RE+7WHpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778801716; c=relaxed/simple;
	bh=jEEqBH2/Kq+qK7Bx8uaH/nsSdy4UvFOX9OFsmtZ9I6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AY1ytMHSA8PsTg4ROjC6jOizGnS4hq7IuJjy26lMaTisyEPdlf1wE34zevrbNYGXKykKK/P1YRrIqdGrvyR0wqCYW9Ot39ygPvME3C0yfEFeTn+IP66xMGJYbDS58Dha/S0nqu0GVAITf0Gw/r6pip1rR5CMq3VCFoiOzSU1qJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9OWNpYf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9OWNpYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75582C2BCB3;
	Thu, 14 May 2026 23:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778801715;
	bh=jEEqBH2/Kq+qK7Bx8uaH/nsSdy4UvFOX9OFsmtZ9I6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=S9OWNpYf60nxMyLVzagroS8kbBbAWYB7lvFuvIZMjAHDWWH10IRp0tkuv5sgHFBRG
	 jblRghuR0YAGtcZqLS8IqMOC8MskOuV3KMV8P23IkM2FW3wcIZezvtis0rPc/6DYw1
	 TG7nM7rn5vW9mgsy4R/iJ4ljHQ7pj2K12P9LjzqJcjet+UhTwUSPUyP/byBtzxdj63
	 6CLUmSyzfohY9+eDGRxefCaSQgA0zc8Ij0MkRHOW+M41peArHThptkREUg6B0pgALw
	 z3LKNB28JXWisLqhKkxdBrcXijsWgRRWrXZJPxZ1bmAMVqFze6/8XA3STzLTuomGlt
	 U7VvvbDQ4Aarg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/17] perf build: Move static libbpf dependency out
 of prepare step
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260514163409.927816-10-irogers@google.com>
References: <20260514163409.927816-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 23:35:14 +0000
Message-Id: <20260514233515.75582C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removing $(LIBBPF) from `prepare` breaks the compilation of individ=
ual object files (e.g., `make util/bpf_counter.o`) and the `check` target.
--

commit 37c1263c37c9d7f14cf72b110d0a12d1429501e0
Author: Ian Rogers <irogers@google.com>

perf build: Move static libbpf dependency out of prepare step

This commit moves the libbpf dependency from the general prepare step to
the specific targets that require it. This reduces serialization during the
prepare step to speed up parallel builds.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf

[ ... ]

> @@ -636,10 +636,6 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
>  	$(LIBSUBCMD) \
>  	$(LIBSYMBOL)
> =20
> -ifdef LIBBPF_STATIC
> -prepare: $(LIBBPF)
> -endif
> -
>  $(OUTPUT)%.o: %.c prepare FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3D$(build-dir)=
 $@

Does removing this dependency from the prepare step break the compilation
of individual object files and the check target?

Since the %.o compilation rule shown above and the check target rely on
prepare, it looks like running make util/bpf_counter.o or make check in a
clean tree will proceed without first building libbpf.a and its headers.

Could this result in build failures for any C files that include BPF
headers before the library is fully built?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514163409.9278=
16-1-irogers@google.com?part=3D9
