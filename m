Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D023B2FC6;
	Wed, 13 May 2026 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709381; cv=none; b=O5e0ldvXDWYLskN/foOg+Yy868x6ZstXe3h+/Ws3Net+ZkwnVgp6B6TQGlOCeojsnZndiWjEisYce/7q/h3YRUlXjr6mQeuLQAGYhoR5pqCq7JUaeOauJGpWCzYJyEAF+FeoF58HPJu/jeD4/bZ8Vhs1eTlGGqRzXX9R2rQL3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709381; c=relaxed/simple;
	bh=q8Cf0P1DAD1ZUob8BaZVBhkMZaoKPdp9LOW6UExyZW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjFkz679F08mypbBy+mAYgE2xjmYc3bY1Yi5SXdpmfbkSDyQvwMCrFc/B+hjmzu7C+DCvX9JWXUneq7XskAChJU9yJkVyIl3bu/XOkUaSpLCitcH6kSxN/reMtlCIu+1YpDzyenZG88Y6dBy5YO3ciZPfEPJ+fE+qUUEMWnYTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS8xH92X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS8xH92X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ACDC19425;
	Wed, 13 May 2026 21:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778709381;
	bh=q8Cf0P1DAD1ZUob8BaZVBhkMZaoKPdp9LOW6UExyZW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oS8xH92XSOLzHYrRAMRMIg3VV0WEntP3W9ClTVUKtuw439RbZ9MPZIoWUjYxgmW2U
	 +TDCG/pI4p8Vd84+3GOBNKSd5U4cmO7ISMU9k6yEkvQrQXPBr0yEIb7nsy7AuF04iT
	 G113sqzm55aSJNsArU/vLbNiK/4INhgM3Ze9DvB1Fv6HAqBWpHCOsCJput5tJDCgZf
	 MU+dauoniH2j3G+FtIYd6gRVEpyOJ3zkloSd1vaVR0PB/Rhd7wd3BsBkcBbajMYT04
	 P4JlFaKlq298V4TtHBvUMPwqZmWIBy/946vK60yDKBc+4umSbDa4fLyZo/w/xKwTKP
	 +BMdhQ+ufxynw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/14] perf pmu-events: Split big_c_string storage
 into standalone compilation unit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512053539.3410189-13-irogers@google.com>
References: <20260512053539.3410189-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:56:20 +0000
Message-Id: <20260513215620.E0ACDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing header declaration for global variable `big_c_string`.
- [Low] Flawed multiple-output Make rule causes build failures on configura=
tion changes.
--

commit 5d2e7b3d9410693c44dfde4428eb25c3e52c21d2
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Split big_c_string storage into standalone compilation unit

This commit modifies jevents.py to emit the large big_c_string literal
into a dedicated pmu-events-string.c file instead of pmu-events.c. This
allows the build system to compile both files in parallel to reduce
compilation latency.

> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index dc1df2d57ddc1..f8f5ec7daa5f1 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build

[ ... ]

> @@ -224,6 +234,9 @@ endif
>  # and inputs are dependencies.
>  $(PMU_EVENTS_C): $(JEVENTS_DEPS)
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVEN=
TS_MODEL) $(OUT_DIR) $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVEN=
TS_MODEL) $(OUT_DIR) $@ $(PMU_EVENTS_STRING_C)
> +
> +$(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
> +	@:

Does this dummy recipe correctly handle configuration changes?

If switching from NO_JEVENTS=3D1 to NO_JEVENTS=3D0, pmu-events.c might alre=
ady
exist from a copy of empty-pmu-events.c and have a timestamp newer than
JEVENTS_DEPS.

Make could consider pmu-events.c up to date, execute this dummy recipe
for the missing pmu-events-string.c, and then fail to compile
pmu-events-string.o with a missing file error.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 3a1bcdcdc685f..70a45e62f5d16 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py

[ ... ]

> @@ -1463,10 +1465,20 @@ struct pmu_table_entry {
>      ftw(arch_path, [], preprocess_one_file)
> =20
>    _bcs.compute()
> -  _args.output_file.write('static const char *const big_c_string =3D\n')
> -  for s in _bcs.big_string:
> -    _args.output_file.write(s)
> -  _args.output_file.write(';\n\n')
> +  if not _args.output_string_file:
> +    _args.output_file.write('static const char *const big_c_string =3D\n=
')
> +    for s in _bcs.big_string:
> +      _args.output_file.write(s)
> +    _args.output_file.write(';\n\n')
> +  else:
> +    _args.output_string_file.write('/* SPDX-License-Identifier: GPL-2.0 =
*/\n')
> +    _args.output_string_file.write('/* Autogenerated by jevents.py */\n')
> +    _args.output_string_file.write('const char big_c_string[] =3D\n')

Since big_c_string is now emitted as a non-static global variable in a
separate compilation unit, does it need a shared header declaration?

Without a prior declaration included in the generated pmu-events-string.c,
compilers may emit -Wmissing-variable-declarations warnings during the
build.

Also, is big_c_string too generic of a name to place in the global namespac=
e?

> +    for s in _bcs.big_string:
> +      _args.output_string_file.write(s)
> +    _args.output_string_file.write(';\n')
> +    _args.output_string_file.close()
> +    _args.output_file.write('extern const char big_c_string[];\n\n')

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512053539.3410=
189-1-irogers@google.com?part=3D12
