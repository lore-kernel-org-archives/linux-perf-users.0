Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8931352B
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299273; cv=none; b=mWQm3YkdIQzb0jXCpmgNWEaV98qMAL5tXYspUxjb3CI5+Mc+OQcvYdYV35iCCjbNjzn0YXck6x8NQO6c4e+2j1DjFDGG+jAHETgQAoX0osR1wTO4tDHDBASaQcGmSenjtx+sr1vQcz0nOVS2CS21VSwLqUz6bSl43zI78Abn1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299273; c=relaxed/simple;
	bh=Ere0L08jU/QZlSMX67RnW3PjgHaZMqq3Vo8MqfpnlNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=do5dbSIHIvToL1k4Gzzj/wDeBwEA89zGnXsnk/YSSMXFFzqvbcJQKbZ/zMc7kdRp45O5ow+QFA2F2M0NEHt6NwoS5oPlicgpYTrLJNZlMiTZUVx5nncia8YsKgYbPKKLKSBNIW7BHonowZm3BoLAWKT8raaFIbD9PSt1RjX9Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsZVvswU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsZVvswU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A951F00893;
	Mon,  1 Jun 2026 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780299272;
	bh=VIopeOPtayESCsI+tFmpR7rsR8S7c6oz+vja7KdZB5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hsZVvswUlqJjZarwaSvBKH8wo753qXlD/odWJtpz0Dpqvkkws6ncXh0cGfEKfJBGn
	 IC8lUm4Ned78Q9Po6akSWCYHK9u5a3/q4VLakRyQK+8roO4KLbDcac3TyyMZvm02L3
	 EI7P4hUz77rO57+pybTax+f5yAQh7RCuHvp6SevwQJwje3ZAsr/5IF1spe3MebkcIv
	 Eu8bFP4p6QJvoR7snb6yBxG4Jm+8nAC/x1lBGO/UJnzqpo+igP5WbRlRsfOFSDo9Za
	 JTto0WFmXGi4ksfc798BJFdpnWUykg/MXzUxhg83fM8GK1gcy4X8PMa1BrXdeARj0n
	 9YaUsEO8pHddg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/18] perf env: Refactor perf_env__arch_strerrno
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601065407.1597927-15-irogers@google.com>
References: <20260601065407.1597927-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 07:34:31 +0000
Message-Id: <20260601073432.16A951F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing dummy inline fallback stub for `perf_env__arch_strerrno` wh=
en `HAVE_LIBTRACEEVENT` is absent.
- [Low] Undeclared identifier `symbol__inlined` in error cleanup path cause=
s a build error.
--

commit a93192909b20934ddb15d354806178b9b8b10838
Author: Ian Rogers <irogers@google.com>

perf env: Refactor perf_env__arch_strerrno

This commit refactors perf_env__arch_strerrno to take an e_machine
parameter instead of using a global architecture string function pointer. It
also updates the build script to map architecture strings to ELF machine
constants.

> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index dd9907dbc3450..ba51b871c401a 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
[ ... ]
> @@ -191,8 +188,9 @@ void cpu_cache_level__free(struct cpu_cache_level *ca=
che);
>  uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_f=
lags);
>  uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
>  const char *perf_env__arch(struct perf_env *env);
> -const char *perf_env__arch_strerrno(struct perf_env *env, int err);
> -arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *=
arch);
> +#if defined(HAVE_LIBTRACEEVENT)
> +const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
> +#endif
>  const char *perf_env__cpuid(struct perf_env *env);

[Severity: Low]
Does this code need a fallback dummy inline stub when HAVE_LIBTRACEEVENT is
not defined?

According to the subsystem guidelines for build feature detection, header f=
iles
should provide compatible dummy inline stubs when the feature define is abs=
ent.
Omitting the stub pushes the ifdef responsibility to the caller, which can
cause implicit declaration build errors if the function is used in
feature-agnostic code.

> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> index 84713b2a7ad5d..d5d2958902c0a 100644
> --- a/tools/perf/util/libdw.c
> +++ b/tools/perf/util/libdw.c
> @@ -130,7 +130,7 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
>  	return 0;
> =20
>  abort_delete_sym:
> -	if (inline_sym->inlined)
> +	if (symbol__inlined(inline_sym))
>  		symbol__delete(inline_sym);
>  abort_enomem:
>  	args->err =3D -ENOMEM;

[Severity: Low]
Is symbol__inlined() declared at this point in the series?

It looks like this might cause an implicit declaration build error in
libdw_a2l_cb() during the error cleanup path, breaking git bisectability. I
notice the fix for this is added later in the series in commit
62331f0aa0a35ba8 ("perf symbol: Add setters for bitfields sharing a byte to
avoid concurrent update issues").

Should this change be moved to that later patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601065407.1597=
927-1-irogers@google.com?part=3D14
