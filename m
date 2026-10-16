Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EE547041
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110448; cv=none; b=DDQtXfL28JygavQs2xIWLZrjmU+/hzX/KFa6ZC6cGmCiK8PTTFaEaALL3PBCT6Gy2raMzHQ303uxtA2jhXbl+nuHyufkcVWL1T+Kkk5jeSzxSprR40VWu68KDrlWpSvjAl2b1xKEA+5L6k8IfEJPIK8iz63+HFLgKmpdTi7qlzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110448; c=relaxed/simple;
	bh=2/zSyCVb18wefTU+I5fE3w69yI9HdQBuVw6xEEK4PjE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RfpTJsUxa2jEPTWZxQUY8qtEGjxKW/f0vi0KaCwJ2sUlaH+4ukcctzRE19O2oi0Wpwf/bfRqEQ0ASA0bEdErUDw8faRlTU4EkX2EcK7KHilxebXuTcrJzH/OfuRok2pnlvLsG4jiqkKnPPpZTX/51LaXw3oJ+zU289oDDEIswDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp2qfZCA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp2qfZCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF611F000C4;
	Fri, 16 Oct 2026 00:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110447;
	bh=xAbJo6DNO1GJgsvP0sGMG2l9V4UrZcPbOEWFD7kIXDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qp2qfZCAy4xrx2T6wh4vTa4YdxBlnHM7OAuqsFjMJardnp7wtd1worsuSkF4eGEuC
	 E5nL2w1OStmjShqhh4UpxonIveDnoDt/0dqM2fzZmI7f2AjsvgKks/Oiy5C9eejVHn
	 LGH5uSb/T0ciWrdT6fqY5JL47CFgt6wjmTFIF4b+DouvSFT/izG6COZKnAiQKzlVzn
	 pKjN1fmHg7KvW76oHVE8PrObKmA109RsDNBRGDqzLji7NeaC7WJqqphFXCAXuqYH7g
	 CoAUdEbGsN9RfOLUiQmxAauU/BSU9QuH/ld0kqVORJNFoASvvW+6nwZZU2KXuFgRiE
	 Lg0HTFPlfveOA==
Message-ID: <sashiko-outbox-173527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/19] perf tests: Introduce a 'needs_mlock' suite
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-16-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:27:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf test: missing stdio.h inclusion for musl libc compatibility
--

commit 0cd49c7e0c286b9d1bb7377465b008f3b907a53c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests: Introduce a 'needs_mlock' suite flag

This commit adds a 'needs_mlock' flag to 'struct test_suite' to distinguish
test suites that map ring buffers from those that do not, allowing them to
take turns using the kernel.perf_event_mlock_kb budget. It also introduces
a 'requisites' subcommand to list test requirements.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 98134b1c74cf8..acffa0d0d33d6 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -283,6 +285,30 @@ static const char *test_description(const struct tes=
t_suite *t, int test_case)
>  	return t->desc;
>  }
> =20
> +static void requisites__fprintf(FILE *fp, const struct test_suite *t, in=
t test_case)
> +{
> +	bool needs_mlock =3D t->needs_mlock, exclusive;

[Severity: Low]
Since this newly added function explicitly uses the FILE type and fprintf(),
should <stdio.h> be explicitly included at the top of the file to ensure
compatibility with musl libc?

> +
> +	if (test_case < 0)
> +		test_case =3D test_suite__num_test_cases(t) =3D=3D 1 ? 0 : -1;
[ ... ]
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index 0370bc7013737..0bc84372eae09 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
[ ... ]
> @@ -187,7 +260,8 @@ static void append_script(int dir_fd, const char *nam=
e, char *desc,
>  	struct test_suite *test_suite, **result_tmp;
>  	struct test_case *tests;
>  	ssize_t len;
> -	char *exclusive;
> +	/* Shell tests run perf, that maps ring buffers, so they need the budge=
t. */
> +	bool exclusive =3D false, needs_mlock =3D true;
> =20
>  	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);

[Severity: Low]
This isn't a bug in the patch logic, but the code relies on snprintf() here.
Would it make sense to explicitly include <stdio.h> in this file as well to
prevent potential build failures on systems using musl libc?

>  	len =3D readlink(link, filename, sizeof(filename) - 1);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D15
