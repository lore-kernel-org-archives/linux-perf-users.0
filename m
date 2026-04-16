Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D720C029
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365777; cv=none; b=d556y5YdKvorWXQU5IfMs3JOIWlimv69anOfZZmlDgPvDo9EPBVJA9iGOQmm6AR6JPcJTzqpVfxRB6/RmXTVOlQ+/rArUVVqvg/sFatB4gdRcCpMTeOcJz++stwB7xVBRppMjxOUUSxi8NZRt1TtdYR0p43DtPePMEgtWL6M8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365777; c=relaxed/simple;
	bh=gRWFQdOQweeEIKD0jQggvRdtaTO2Nwa6zFHUoVI4eYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OUcAByZM6Ukxom05Nf2lRMZdNdMw73pXuoc+PXbnDGDUliduOp0/8RYc3XxKJA4t2imikTzp1C5ZAgA7jMUVTKCtgJlahecZAga4EZQIK4/3U0YtD0BioDDu9xuA3SXg4XgUORmtIuvm/XvpMMz/fnCR0vIcOIyrfWhaakHxE4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN4vUa+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN4vUa+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15AFC2BCAF;
	Thu, 16 Apr 2026 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776365777;
	bh=gRWFQdOQweeEIKD0jQggvRdtaTO2Nwa6zFHUoVI4eYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XN4vUa+fw//qEMpTdKM8cwJJ+XHeeGxLb2krz159tnHQV3KHgQnvHn1WJUeRYMvI4
	 WqGQS4VHDVc9hmVrrHjvnV2d7NF8ISv9vi7XFPlBPXWbgygfve/CG4in1Rvfqq1YKt
	 eV7Unf5DD49IdDHRieTLrw7H5VFTA6N24swLsdFCffaLIDKNpAE+3OnFwk77150Bih
	 nzxhw7cTZgtUbeKR51kq3g4MlxY77RD/GJY6RtyYByI3KefE0RZEgB/ysEAe/kkjeB
	 dydgqqqtCtH0ZqHqlzPrlPrfX26TYSNwfKXbvd3gi4rhHfCyJR7sygUFId/rdtkROC
	 kkjccrs+fgn6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/7] perf test: Format log directories for shell
 tests
Reply-To: sashiko@lists.linux.dev
To: "Jakub Brnak" <jbrnak@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416111419.385010-6-jbrnak@redhat.com>
References: <20260416111419.385010-6-jbrnak@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 18:56:16 +0000
Message-Id: <20260416185616.D15AFC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Temporary directory resource leak when strdup() fails.
- [Low] Implementation of character replacement is overly aggressive and mi=
saligned with the commit intent.
--

commit deaef0503b790e27361344881ded63d280631c12
Author: Jakub Brnak <jbrnak@redhat.com>

perf test: Format log directories for shell tests

This commit creates a temporary directory for shell tests using a template =
based
on the test suite name. It replaces non-alphanumeric characters with unders=
cores
to avoid issues with whitespace or special characters when logging.

>     Replace the whitespace characters with an underscore to prevent the
>     possible issues caused by the name splitting.

This isn't a bug, but the commit message mentions replacing whitespace
characters, while the implementation replaces all non-alphanumeric characte=
rs.
Could the commit message be updated to match the code?

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 306ecfe5e22ff..6cdff3687a828 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -342,16 +342,28 @@ static bool create_logs(struct test_suite *t, int p=
ass)
>  	return false;
>  }
> =20
> +static const char PERF_LOG_PREFIX[] =3D "/tmp/perf_test_";
> +static const char PERF_LOG_SUFFIX[] =3D ".XXXXXX";
> +
>  static char *setup_shell_logs(const char *name)
>  {
>  	char template[PATH_MAX];
>  	char *temp_dir;
> +	size_t i, len;
> =20
> -	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name) >=3D=
 PATH_MAX) {
> +	if (snprintf(template, PATH_MAX, "%s%s%s", PERF_LOG_PREFIX, name,
> +		     PERF_LOG_SUFFIX) >=3D PATH_MAX) {
>  		pr_err("Failed to create log dir template");
>  		return NULL; /* Skip the testsuite */
>  	}
> =20
> +	/* Replace non-alphanumeric characters with _ in the name part */
> +	len =3D strlen(template);
> +	for (i =3D sizeof(PERF_LOG_PREFIX) - 1; i < len - (sizeof(PERF_LOG_SUFF=
IX) - 1); i++) {
> +		if (!isalnum((unsigned char)template[i]))
> +			template[i] =3D '_';
> +	}
> +
>  	temp_dir =3D mkdtemp(template);
>  	if (temp_dir) {
>  		setenv("PERFSUITE_RUN_DIR", temp_dir, 1);

If strdup(temp_dir) fails right after this and returns NULL, do we leave the
newly created temporary directory on the filesystem?=20

It looks like mkdtemp() creates the directory, but there is no cleanup if t=
he
memory allocation fails. Additionally, should we unset the PERFSUITE_RUN_DIR
environment variable on this error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416111419.3850=
10-1-jbrnak@redhat.com?part=3D5
