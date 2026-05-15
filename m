Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA693016E9;
	Fri, 15 May 2026 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805569; cv=none; b=ZialmSMpb9S8KTqrv+rFX+3kNDJpcQqMH1XryJHsrjf+H5cjIOJcFGVit7H/8AUTRhMKnbhe2n12bHe8PSMurp+0Nq8cW201sSoDB+ExhY6wCxQjO0+VHYhQ1jFpzBDDAjHmruUhODq9HfnIgK763OJdniZX4SvpelrS4ImuYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805569; c=relaxed/simple;
	bh=Tu8Os6C/ahGbS6kVIJ44nQq/nityPs+wFR5QwdOeq8M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DGU9a4IKbgh27peJkbRBmN6/cKnxCu584QJ0DpcipO1vRjQv9cUPTdy4VyKL0iZnbCAKkZHOZ0vdzbThn2ZDzGXLzbCxIFFuGLtOnivLVnM9k0WiqlHACDh+qctjZRVRe+kuFSduSXhV1oT9Mq9+Hl68ECy2BMzxymfYA1bL7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcsS4iAL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcsS4iAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5564C2BCB3;
	Fri, 15 May 2026 00:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805569;
	bh=Tu8Os6C/ahGbS6kVIJ44nQq/nityPs+wFR5QwdOeq8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JcsS4iALLkW4WFG8NHnZ4o8K56ilZrmxk/3gBxZ5wuH2rR/P80MZyoB5TnUjmuNex
	 yA9q+66XEsOCfVM0a6J9pSJLcsQhqD8/saYDbZULxgEBkwZ7HuVyrsIfLwXUTQPXiv
	 fVgrRT2foE8jn5FGEoBZpmQukI1SSoVLlGbrcSqNlgMP6a5x68pfsRQNdvh/52aKdd
	 AoKNPuNq4AymA9hd1PZ4Nv3s4m670mnIwJJ6Ih8XKJWSoX9B2v6vWrfqXjQwQmgM7V
	 3iHVWy6Dat5C2hcU2Anfcc/Z8YWsohvq6raoju0f/Kru3ncTJFlNX77h0SssxgzbmK
	 XZXTyDdieWJhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/17] perf pmu-events: Split big_c_string storage
 into standalone compilation unit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260514163409.927816-14-irogers@google.com>
References: <20260514163409.927816-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 00:39:28 +0000
Message-Id: <20260515003928.D5564C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Incremental build breakage causing `perf` to be unconditionally =
relinked on every `make` invocation.
- [Low] Missing variable declaration for `big_c_string` causes a compiler w=
arning/error on Clang.
- [Low] Fragile multiple-output dependency chaining causes an unrecoverable=
 build loop if the secondary file is deleted.
--

commit c21d41481809344c6220821a1680882429693c05
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Split big_c_string storage into standalone compilation unit

This commit refactors jevents.py to output the big_c_string literal into
a separate pmu-events-string.c file. It also updates the perf Makefile
to build this new file, using a dependency chain pattern to avoid multiple
jevents.py executions in parallel builds.

> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index dc1df2d57ddc1..95172a2a851f5 100644
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
> +	@:

If a user manually deletes pmu-events-string.c, won't Make execute this dum=
my
recipe, assume the file was recreated, and then fail during compilation?

This could leave the build in an unrecoverable state until pmu-events.c is
also deleted, which seems contrary to the fully self-correcting goal mentio=
ned
in the commit message.

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
> +    for s in _bcs.big_string:
> +      _args.output_string_file.write(s)
> +    _args.output_string_file.write(';\n')

Will compiling this file with Clang trigger a missing-variable-declarations
warning?

It looks like big_c_string is defined globally here without a prior extern
declaration in the same compilation unit, which could cause a build failure
when -Werror is enabled.

> +    _args.output_string_file.close()

Does closing output_string_file here cause an incremental build breakage?

Since output_file is written to during the subsequent ftw calls that parse
the architecture JSON files, output_string_file will end up with an older
modification timestamp than output_file (which corresponds to pmu-events.c).

Combined with the Makefile rule $(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
having a dummy @: recipe, Make will see pmu-events-string.c is older than
pmu-events.c on every invocation, and unconditionally rebuild
pmu-events-string.o and relink the perf binary.

> +    _args.output_file.write('extern const char big_c_string[];\n\n')
>    for arch in archs:
>      arch_path =3D f'{_args.starting_dir}/{arch}'
>      ftw(arch_path, [], process_one_file)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514163409.9278=
16-1-irogers@google.com?part=3D13
