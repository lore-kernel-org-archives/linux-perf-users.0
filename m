Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767934F48D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341230; cv=none; b=otvmshLJ8VyVfhN732uKxwzSG1oBnKWXsYOu69I4nPcsZCnjNRTLkoLQixoPn8yLoUh6d/uM10v2vtfwEveVSAB3zX0dtqMzjUOmW1Y5XYW2hEDeB9SMDBVtrDmcGwR/+MnYEOpOTSQD2XNZlTAyh6Hpp0KXZx4Fk9KMrjaN2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341230; c=relaxed/simple;
	bh=bTUJoutSIbGfWmWbDvE6RnJnIGctD3GudcYD1PSZtVE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a0GV5cd6hkzI38F/aydaN98NCsIFzf+NgeQxSbbyA/Z11Tj0qmz+GKXXex6T5+AcQI2VYf672Tm2R1meWS4ThWYINLuUyHSbSEFcURwIRY73qQdJE3NOy3rN3qCPYnEgi11i8JaiQCS17RV/bRfJOfKHVcs4+3i3fDY+5BU7jr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g09rKB15; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g09rKB15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95649C2BCAF;
	Thu, 16 Apr 2026 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776341229;
	bh=bTUJoutSIbGfWmWbDvE6RnJnIGctD3GudcYD1PSZtVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=g09rKB15RsOg9KFmSta5CsS7sGqr6ZlNj0+r4kgg5obJo7miY7l/gxy32J1NcKyTQ
	 gwIzJhgbbA/0/T8sbeyGDtbCSBqHIuOREyTlKGdsyAJu3fqix7RDu7goRbXCwDq01q
	 CiGCTamhweUAs5m3WFg8xheUy5FAyoMW0abtTnZei+A1M3GU6rti4lz95GinEI1l91
	 4yFl6Um54+GWNijhGoe9xo/1FUBT/QMGXqpWZlWaalQYXsCrVh7EGvFxA6TOEuqnI+
	 nTKdpGYGOjdDXv3KgIbu67eKrLZgSzhaiWhFDG6CAfL4rqDX6KGhG383SwCcOKgYWp
	 VmNexXuL5C/kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/7] perf test: Provide setup for the shell test
 suite
Reply-To: sashiko@lists.linux.dev
To: "Jakub Brnak" <jbrnak@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416111419.385010-3-jbrnak@redhat.com>
References: <20260416111419.385010-3-jbrnak@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 12:07:08 +0000
Message-Id: <20260416120709.95649C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unescaped directory paths passed to `system()` enable arbitrary =
command execution and break the test suite if the path contains spaces.
--

commit e6010a1e8737e6a67dc7b0bb3ea8439fbf49269b
Author: Jakub Brnak <jbrnak@redhat.com>

perf test: Provide setup for the shell test suite

This commit adds support for running a setup script before executing test c=
ases
in the perftool-testsuite. It checks for the existence of "setup.sh" and sk=
ips
the test suite if the setup fails.

> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index 680dfe650f146..33f1e46267f41 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c

[ ... ]

> @@ -255,6 +262,23 @@ static int shell_test__run(struct test_suite *test, =
int subtest)
>  	else	/* Single test case */
>  		file =3D test->test_cases[0].name;
> =20
> +	/* Run setup if needed */
> +	if (test_info->has_setup =3D=3D RUN_SETUP) {
> +		char *setup_script;
> +
> +		if (asprintf(&setup_script, "%s%s%s", test_info->base_path,
> +			     SHELL_SETUP, verbose ? " -v" : "") < 0)
> +			return TEST_SETUP_FAIL;
> +
> +		err =3D system(setup_script);

Does this code handle directory paths with spaces correctly?

If test_info->base_path contains a space (for example, in "/tmp/perf test/"=
),
system() will evaluate the string using /bin/sh -c without quotes around the
path, which breaks the test suite.

Could this also allow arbitrary command execution if shell metacharacters
are present in the path?

> +		free(setup_script);
> +
> +		if (err)
> +			return TEST_SETUP_FAIL;
> +	} else if (test_info->has_setup =3D=3D FAILED_SETUP) {
> +		return TEST_SKIP; /* Skip test suite if setup failed */
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416111419.3850=
10-1-jbrnak@redhat.com?part=3D2
