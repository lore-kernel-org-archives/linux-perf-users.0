Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758225B0BD
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199002; cv=none; b=M953+OM2BN5JnluVDy5dgS1MPsMHo7UBYZn40ig5Fj7mQUOTnZ1aMjGaVfAOKebxqPYSwUC0P+98T3kxyFss3LwJC66rXZ1o8a+G96+OS64Ze/y1cnibq7kRXKRYMdQ6EoY/PCUrwO2W50SsFltiYwZ/j/2DKu68ffBgBbc/aik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199002; c=relaxed/simple;
	bh=9D0yaY8iq8dwh5WDaiTfFlzLH2IqcLc0KPPA2v1+bRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t5Ioqd87kb4J/yyjqnNBGC/kfGz23GwYtwGf1Ct+6srG61DeY8VvAPdgFOr34qm6fgi+geP9eqpwjEsN+JpV15GB+KJEpmklsNlw4fC6UuJJudnefOXIgSLBNC+O0Imge6QaT9sQJ3nqpWrwCdJdFVxpm1ImuGaR5rWTjAdVoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3jVOAzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3jVOAzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C2F1F000E9;
	Tue, 23 Jun 2026 07:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782199001;
	bh=RbV0H2XbLTwq2S/e8wZpYfSjehWehE9cQ7yIdxS/xHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g3jVOAzGiIIllLIHtor5uvXCEHS9kGQO3b3PiU3GUgM7VW0lTMpigPfbdCr/Pwf/s
	 iZEBJir9O+PaMmC5aBGFV/NGeb/t+XlvSz6qn5JvVg2cspyCY95HDrt/ajUAPwYk/j
	 0sng0NyiHKXeSGG3UX3C1lb1rf+VZY/O0QW0pYKLjjNZlYNdYEchnFC8Z84r7ARC2j
	 2wZqGOGEUVxTtFjc9nVOx2zpc7xqxR7qIEokpjMbJ7Vt+12vRQg+kGM5U35J/AF+XP
	 sVzra3VpKQev5LzezBo4PcfaqpnaYdu7wVqi/yvjo0T7Sp5xkZaCci6l7zCIvxDfbS
	 9ZvwFQ2RkoMxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf kvm: Factor out kvm_need_default_arch_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623070313.55225-2-namhyung@kernel.org>
References: <20260623070313.55225-1-namhyung@kernel.org>
 <20260623070313.55225-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 07:16:40 +0000
Message-Id: <20260623071641.61C2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `__cmd_top()` unconditionally appends the default architecture eve=
nt, breaking user-provided event overrides.
- [Low] Missing explicit POSIX <stdlib.h> header inclusion in kvm-stat.c fo=
r calloc() and free().
--

commit 3e2018b99366e21f6651143f8ed90e3f8257ec72
Author: Namhyung Kim <namhyung@kernel.org>

perf kvm: Factor out kvm_need_default_arch_event()

This commit factors out the logic for checking existing event command line
options into a generic kvm_need_default_arch_event() function. It removes t=
he
duplicated option checking logic from architecture-specific implementations
of kvm_add_default_arch_event() and updates __cmd_record() to use the new
guard.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 0c5e6b3aac74d..c236093eac473 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2015,9 +2015,11 @@ static int __cmd_record(const char *file_name, int=
 argc, const char **argv)
> =20
>  	BUG_ON(i + 2 !=3D rec_argc);
> =20
> -	ret =3D kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
> -	if (ret)
> -		goto EXIT;
> +	if (kvm_need_default_arch_event(argc, argv)) {
> +		ret =3D kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
> +		if (ret)
> +			goto EXIT;
> +	}
> =20
>  	ret =3D cmd_record(i, rec_argv);
> =20

[Severity: High]
Is it possible that __cmd_top() is missing the kvm_need_default_arch_event()
guard?

Since the option parsing logic was removed from kvm_add_default_arch_event(=
),
it now unconditionally appends the default event.

__cmd_top() in tools/perf/builtin-kvm.c still calls it unconditionally:

__cmd_top()
        ...
        ret =3D kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
        if (ret)
                goto EXIT;

Will this cause perf kvm top to ignore user-provided event overrides
(like -e some_event) and blindly append the default event?

[ ... ]

> diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
> index 27f16810498ca..dd599dd0e4322 100644
> --- a/tools/perf/util/kvm-stat.c
> +++ b/tools/perf/util/kvm-stat.c
[ ... ]
> @@ -271,3 +272,29 @@ int kvm_add_default_arch_event(uint16_t e_machine, i=
nt *argc, const char **argv)
>  		return 0;
>  	}
>  }
> +
> +bool kvm_need_default_arch_event(int argc, const char **argv)
> +{
> +	const char **tmp_argv;
> +	bool event =3D false;
> +	int i;
> +
> +	const struct option event_options[] =3D {
> +		OPT_BOOLEAN('e', "event", &event, NULL),
> +		OPT_BOOLEAN(0, "pfm-events", &event, NULL),
> +		OPT_END()
> +	};
> +
> +	/* parse_options() may change the argv, let's make a copy */
> +	tmp_argv =3D calloc(argc + 1, sizeof(char *));

[Severity: Low]
Should we explicitly include <stdlib.h> in this file to support musl libc
builds?

The new kvm_need_default_arch_event() function relies on calloc() and free(=
),
but <stdlib.h> isn't explicitly included in tools/perf/util/kvm-stat.c.

Because musl libc enforces strict standard header separation, relying on
implicit includes can cause the build to fail.

> +	if (!tmp_argv)
> +		return false;
> +
> +	for (i =3D 0; i < argc; i++)
> +		tmp_argv[i] =3D argv[i];
> +
> +	parse_options(argc, tmp_argv, event_options, NULL, PARSE_OPT_KEEP_UNKNO=
WN);
> +	free(tmp_argv);
> +
> +	return !event;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623070313.5522=
5-1-namhyung@kernel.org?part=3D1
