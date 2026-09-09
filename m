Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6B57D221
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970881; cv=none; b=hg/HnQKTA2t6MjkuschjGoekkRbP0HJ+ku1AitOSP8HU4SSMx18wCK2iYhFmLZkppGuZeb/2sL0My53VExbfwgIileiFB1t54qu+kol4L39fLYwvSBTWmT6no0BN52ZqaUdJ+7aPilzwrBqT4B6k0WZZow/XSRcqosZzQAxD2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970881; c=relaxed/simple;
	bh=ILldpJYrRs4K2mC4XF1rbuhkBMW9NgxPdkWETsgo8IY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ARS2TvOkXC+jDfzWh4BQhz+zHYPioJgEV7aENc590sDgwGaWJtffT8ZtRQ39S+jOX20x4Hd5kq4m6jc0U6z/6nA9Jw8ViPPCrVwhLyPAFQfVJbTwdQ6RQuM7riVq1I30eBAuply00F2tX9/kCaJDBWzIj1qLkNg7tyXfbfWeZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTn92Sts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTn92Sts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3B51F000FF;
	Wed,  9 Sep 2026 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970879;
	bh=tbVjuZPybYzUsB6ieqwGSMuePNFunNxN+L2+PiS9SOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GTn92StsyKOctbNP7R66eavYrMLgZzoXPjeYktSTF1kri/ayu9kIioEflhYlgwrry
	 lDAzv0k3f8/7efRRnOGPJPQN467AD+kh6zeHb4nNJfRthU+iQkMTriY4Fa46EszJSs
	 b4rXhuqdzpdkVwb//tSFVfhnn2HObMx6ZS1+hgZfquNzh0M+EhLGWmiqQZY9sZe7jr
	 DHlbLrtYiR8tdVJp0lJnWDqCXA/Xl5SJLUJY7vB4FYZyOaFtVgZjtwZQAKBJe+4aTa
	 29DGSSOkJxy5gq8cBExkzC+tQqOxz4OwejrmDLVLXNtnqSqy6ERryFunCd6Rz98fV/
	 ElZNBGpZ3BhTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf tests: Improvements to build-test performance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909161041.1745638-1-irogers@google.com>
References: <20260903045603.3611902-1-irogers@google.com>
 <20260909161041.1745638-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:21:18 +0000
Message-Id: <20260909162119.3C3B51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The parallelization of the `out` target causes destructive races=
 between `FEATURES_DUMP_FILE` and `FEATURES_DUMP_FILE_STATIC` within the sh=
ared source tree.
--

commit 8a5611d5732e412e746570eca199bea2894c319b
Author: Ian Rogers <irogers@google.com>

perf tests: Improvements to build-test performance

This patch replaces hardcoded 'make' calls with '$(MAKE)' in the perf tests
Makefile to ensure proper GNU Make jobserver file descriptor inheritance. It
also removes 'unexport MAKEFLAGS' in favor of native GNU Make conditionals
for parallelism. Finally, it optimizes the 'out' target by wrapping the tar=
get
list in a parallel sub-make call.

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index d2c2f526e1db0..4a865e58f2bea 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
[ ... ]
> @@ -383,20 +391,22 @@ all: $(run) $(run_O) tarpkg make_kernelsrc make_ker=
nelsrc_tools
>  	@echo OK
>  	@rm -f $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
> =20
> -out: $(run_O)
> +out:
> +	$(call clean)
> +	@$(MAKE) -f tests/make $(run_O) PARALLEL_OPT=3D O_CLEAN=3D0 $(if $(find=
string jobserver,$(MAKEFLAGS))$(findstring -j,$(MAKEFLAGS)),,$(if $(cores),=
-j$(cores)))

[Severity: Medium]
When the out target invokes this parallel sub-make for all run_O targets, d=
oes
this expose the feature dump dependencies to concurrent evaluation?

>  	@echo OK
>  	@rm -f $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
> =20
>  ifeq ($(REUSE_FEATURES_DUMP),1)
>  $(FEATURES_DUMP_FILE):
>  	$(call clean)
> -	@cmd=3D"cd $(PERF) && make FEATURE_DUMP_COPY=3D$@ $(O_OPT) feature-dump=
"; \
> +	@cmd=3D"cd $(PERF) && $(MAKE) FEATURE_DUMP_COPY=3D$@ $(O_OPT) feature-d=
ump"; \
>  	echo "- $@: $$cmd" && echo $$cmd && \
>  	( eval $$cmd ) > /dev/null 2>&1
> =20
>  $(FEATURES_DUMP_FILE_STATIC):
>  	$(call clean)
> -	@cmd=3D"cd $(PERF) && make FEATURE_DUMP_COPY=3D$@ $(O_OPT) LDFLAGS=3D'-=
static' feature-dump"; \
> +	@cmd=3D"cd $(PERF) && $(MAKE) FEATURE_DUMP_COPY=3D$@ $(O_OPT) LDFLAGS=
=3D'-static' feature-dump"; \

[Severity: Medium]
Will these feature dump recipes race destructively?

Since some run_O targets like make_static_O depend on
FEATURES_DUMP_FILE_STATIC while others depend on FEATURES_DUMP_FILE,
evaluating them concurrently means both unconditionally invoke make clean a=
nd
make feature-dump inside the shared source tree.

Could this cause them to wipe out each other's intermediate artifacts during
make build-test out-of-tree builds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909161041.1745=
638-1-irogers@google.com?part=3D1
