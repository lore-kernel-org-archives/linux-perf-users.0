Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2684A0F1E
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363643; cv=none; b=GaDi97gIm9vumCWG5LL0XB3zERrGQQEHmmRq4fwt3yH5lmDen+tBCwqB6mzijDPL7WWCK9rEVwLFGirL9FrbU/Leh60hYYWgfyEOAS8m7xqdVLYnFyZb9BV+gn6U+Ew49PQ1+Vs2nsJbB4jD0KrSf5PyADqlDT4BQxki1hJR1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363643; c=relaxed/simple;
	bh=/xVcJQIzcYAYC2vcJ3YrL3gqvYFbJf/d+1EBq9yezaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sMJpzs9Z7nO1MGXKIe1DAwdpi+bLfpDEHOxLjXoG9cwhONDaAV1qGMhGTJ+E1tjhRZ4dJWJnphO1c2JRd2nIMMaxa6PHamvdtHQ4x+lTnXai/brHWLxdwHDi1qFCSftSdo7D/gtlZN2/UxTyqApqI3WmQV/LsrACH6fIklYz4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLEo2ipy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLEo2ipy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F69C1F00A3A;
	Wed,  2 Sep 2026 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363641;
	bh=h3KsdUppUo18gVe6x4nWLvMUCccnyxRPbJjSSPd9w7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JLEo2ipypH68xtuix/tne8R78roGPHJv9xs8Zu1eIV/BcIv3BlNW1g38BBp9zAXTD
	 PZ8LsDdFo0QoAL8hPhdUsZWAErl1gRp+qqrWDqYItVAIMEjKdRtcfAcJOpQsX/Kztz
	 hveifUrh624widkrW9VAF7zCRXsr04/WFdYTPaACvzGZjwIzOHflvFm9FVYX6AQJx/
	 z97dHQgczaUeJNHFotqu93e6Q2z7BaY+Pp8LiBpp2FzJpMCY1d27X4k2J7347rOmlc
	 XSLBC4zUYPMkAJ0ZKjYm+iRSWnxpp+8Lv7SOvN8V64AJly5lMPYwMhZiOyIafDl31p
	 CJvqZrMLqX26g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf tests: Improvements to build-test performance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902153135.2067365-1-irogers@google.com>
References: <20260902153135.2067365-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:40:40 +0000
Message-Id: <20260902154041.5F69C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `out` target explicitly passes `-j$(cores)` to a sub-make, bre=
aking GNU Make's native jobserver inheritance and triggering an unbounded f=
ork bomb if `cores` is undefined.
- [Medium] Removing `$(call clean)` from `$(run_O)` causes out-of-tree buil=
ds to execute on a dirty source tree when run sequentially after in-tree bu=
ilds.
--

commit 169a507e0cde997201a5b5a2dfdbe4652f1a9fa0
Author: Ian Rogers <irogers@google.com>

perf tests: Improvements to build-test performance

This commit aims to improve build-test performance by using $(MAKE) to ensu=
re
GNU Make jobserver file descriptors are inherited by nested builds. It remo=
ves
sequential bottlenecks like $(call clean) from isolated tmp directories and
wraps the out target list in a parallel sub-make call.

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index d2c2f526e1db0..4f14c6b72416a 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -339,7 +339,6 @@ make_static:
>  	rm -rf $@ $$TMP_DEST || (cat $@ ; false)
> =20
>  $(run_O):
> -	$(call clean)

[Severity: Medium]
Does removing this clean step cause out-of-tree builds to execute on a dirty
source tree when run sequentially?

When the default all target is executed:

all: $(run) $(run_O) tarpkg make_kernelsrc make_kernelsrc_tools

The $(run) in-tree builds execute first and leave the source tree dirty.
Since $(run_O) no longer calls $(call clean) before starting, it appears
the first out-of-tree build begins on that dirty source tree, breaking
build isolation.

>  	@TMP_O=3D$$(mktemp -d); \
>  	TMP_DEST=3D$$(mktemp -d); \
>  	cmd=3D"cd $(PERF) && $(MAKE_F) $($(patsubst %_O,%,$@)) $(PARALLEL_OPT) =
O=3D$$TMP_O DESTDIR=3D$$TMP_DEST"; \

[ ... ]

> @@ -383,20 +382,21 @@ all: $(run) $(run_O) tarpkg make_kernelsrc make_ker=
nelsrc_tools
>  	@echo OK
>  	@rm -f $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
> =20
> -out: $(run_O)
> +out: $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
> +	@$(MAKE) -f tests/make $(run_O) PARALLEL_OPT=3D -j$(cores)

[Severity: High]
Does passing -j$(cores) here break native jobserver inheritance and risk an
unbounded fork bomb?

If a developer runs the out target directly without setting cores, the
-j$(cores) flag expands to -j without an integer. This instructs GNU Make
to spawn unlimited jobs, which is then inherited by all $(run_O) sub-makes.

Additionally, even when cores is defined, passing it explicitly to $(MAKE)
overrides any --jobserver-auth tokens passed from a parent make, breaking
the jobserver inheritance this patch aims to fix.

>  	@echo OK
>  	@rm -f $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902153135.2067=
365-1-irogers@google.com?part=3D1
