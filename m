Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847373F9A18;
	Fri, 15 May 2026 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868546; cv=none; b=iqXa9zRIk3z+FGbNE0YZcxWoyYY7T+Orhh5MU7m6pY/I+n7fxRKs6GG/xnrVb7fP+e+XaN9jA3GaoRueS67lMl6llVHhBkSvSkzT20uKZ5fLmMJ61J1Aus8Hee6skIJnE8JcA/0JcAWgReRFrA9ZA/vgAFV1H4pykjHC/sB1pcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868546; c=relaxed/simple;
	bh=tsOSeZ8nXV1cEulyggrhOrxLareLerjjc6os2g3jyRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jq8CRd5r6nTqkY+nN9ujIwMIQMxfxg21TqlhH3cQDOoaci/J7csVnRVWKIM6vpgtbTZ8g8oCptTeXsYMOD4f7mthYvU7I+OkaaIxCcaQGMK032jcsDNtBojUXTVqD4bDRk9sqpf4lILdIjIWHqbnGi2Dx5MHYw0+aXCDwgcfLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghwzTZy5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghwzTZy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8EEC2BCB0;
	Fri, 15 May 2026 18:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778868546;
	bh=tsOSeZ8nXV1cEulyggrhOrxLareLerjjc6os2g3jyRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ghwzTZy5uF3kK1V4KFMzhkc3stmJUD148ELjpPldcmOlshFk2rond2kQsBLKEpvqR
	 i/Q2Y/ipNBx6yEPf5FMNLpcXywirxCszNASMPfWhECwg2ykaDDED5naEJaQDnoBoj4
	 V5w1KpRp3IibyOJxIEW9BnljdLjhGZvyK4F9daGBz0LEbKnGz+LviPFw1Y9iyRsbtJ
	 qUr+WDkJd0+r374Mj7BqPlmKKPLNV7jGp7ag0Jqvqdb1C8r+grif1qIYitrTg2Yoz4
	 PW4ZHe7WAgqdEit31dC/M2FZ82DbTzr2n+A8iUocGEtGZU2+bppVVnvelNb/jcNcmp
	 L30O03NsMPVUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/14] perf pmu-events: Split big_c_string storage
 into standalone compilation unit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260515173852.1378571-11-irogers@google.com>
References: <20260515173852.1378571-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:09:05 +0000
Message-Id: <20260515180905.DA8EEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Race condition in parallel builds causing non-deterministic 'No =
such file or directory' errors.
- [Medium] Meaningful code and commit message mismatch regarding dependency=
 chaining.
- [Low] NO_JEVENTS=3D1 fallback and default jevents.py mode fail to compile=
 due to big_c_string linkage conflict.
--

commit b03f8034531e9c582fd4777daf59f93349bcf916
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Split big_c_string storage into standalone compilation unit

This commit splits the generation of big_c_string into a dedicated
compilation unit to speed up Kbuild. It modifies jevents.py to
optionally generate this file, adds it to the build system, and
updates the pmu-events.h header.

>     To guarantee 100% backward compatibility with GNU Make 4.0+ (avoiding=
 the
>     Make 4.3+ grouped target &: syntax which causes older Make versions l=
ike
>     4.2.1 to spawn multiple concurrent jevents.py processes during parall=
el
>     builds), implement a robust dependency chaining pattern:
>       $(PMU_EVENTS_C): $(JEVENTS_DEPS)
>       $(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
>               @:

The commit message states that a no-op recipe (@:) is used for dependency
chaining, but the actual code implements a file-recovery shell script
instead. Could the commit message be updated to match the code?

> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index dc1df2d57ddc1..00ae173cdb5c8 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build

[ ... ]

> @@ -224,6 +234,10 @@ endif
>  # and inputs are dependencies.
>  $(PMU_EVENTS_C): $(JEVENTS_DEPS)
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVEN=
TS_MODEL) $(OUT_DIR) $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVEN=
TS_MODEL) \
> +            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
> +
> +$(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
> +	$(Q)test -f $@ || { rm -f $<; $(MAKE) -f $(srctree)/tools/build/Makefil=
e.build dir=3Dpmu-events obj=3Dpmu-events; }

Does this introduce a race condition during parallel builds?

If pmu-events-string.c is missing but pmu-events.c is up-to-date, a
parallel build could execute this recipe concurrently with the compilation
of pmu-events.o. The rm -f $< would remove pmu-events.c while the C compiler
is trying to read it, leading to a "No such file or directory" error.

> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/p=
mu-events.h
> index d3b24014c6ff1..fb4eb5b7ec163 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -141,4 +141,6 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, vo=
id *data);
> =20
>  const char *describe_metricgroup(const char *group);
> =20
> +extern const char big_c_string[];

Will this cause a compilation error when building with NO_JEVENTS=3D1?

The build uses empty-pmu-events.c which still defines big_c_string as:

static const char *const big_c_string =3D ...;

Including this header will result in a conflicting type and linkage error
between const char[] and const char *const, and between extern and static.
The same conflict appears to happen when invoking jevents.py without the
output_string_file argument.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515173852.1378=
571-1-irogers@google.com?part=3D10
