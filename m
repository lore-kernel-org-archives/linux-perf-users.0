Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C71390C85
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254674; cv=none; b=EbKzDrkBFXq0zfXnZ/G6kVPco5aE2Ihoe2z3U2Nf8tR6W/A6uKL3X7F+YoSxYd3dgN+J5kPNBLknhM6JRCk45LIYen25rPhNBqh+X0BXQaKkJ4Nqs7dopKGYh9uTKAigYU0KfKYYvf6rl/V6VuGvVefEdTrK5EIPjPw4h38+HZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254674; c=relaxed/simple;
	bh=jHEyIqOrjzf/PyKa0pi4bbSefVsE/2VHcRvTRpK12/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m+34HJthnHuWklT6ZuRPW/L14xeM2LH1QYzsDnFoIfeFQaokOr0P/axfi1s/BZJxaj+5M6M0rDt8eyF8jlez+Bvcr4DWy03Fu4BCXRhBJkulY7FoCHXt+KX0yfM4BgRzrWJ2npj6agD20WbgBcTnsca8kA9p3rXUwJNzElaEdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESV0lnlo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESV0lnlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35431F000E9;
	Tue, 23 Jun 2026 22:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782254673;
	bh=cNtk5EAjHL49A6DvfcBlaBakrgDFeExarc8v9z89NAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESV0lnloKDdW7IwI1CFeT9LlCHN7EDQErJmSCUNmdPV99GniMMQeLoyuQLPBLx4+B
	 pY2HQaucDlPFB2jDQIn5Pv3Z6xvCpDqTmq7D++UGvO3L9mZNBDd0wsT8h3o+bp9pg/
	 r2ghwi+8PPlJ0qB+2qbDpuLduMVNySUNWUiOb0uNYBa7LzEjpjfh4ucISRB++zO1gM
	 Dw3jx/USNuEOeB9sU4wVxC2ZSLU9TbKY947mTrFz+ynafoH4HIvtho71HHSvrH+MS+
	 S6vaQ0orYq1BE0sQ9QpAk5AjJHfX8w0pX9B5sMHUjcnZ1klP2MbcX8tXBiH+9G7eTf
	 //DjTx0A4FgKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/13] perf python: Zero initialize perf_data in
 pyrf_data__init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623053515.2677888-12-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260623053515.2677888-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:44:32 +0000
Message-Id: <20260623224432.F35431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing explicit inclusion of POSIX standard header `<string.h>`=
 for newly added `memset`.
--

commit 84d9f7832c422ee6951987ed0cdd0d5717fcc7d2
Author: Ian Rogers <irogers@google.com>

perf python: Zero initialize perf_data in pyrf_data__init

This commit replaces clearing the path with memset to zero out the entire
perf_data struct in pyrf_data__init.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index e277c89b83477..03b4e88091074 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -3607,7 +3607,7 @@ static int pyrf_data__init(struct pyrf_data *pdata,=
 PyObject *args, PyObject *kw
>  	if (pdata->data.open)
>  		perf_data__close(&pdata->data);
>  	free((char *)pdata->data.path);
> -	pdata->data.path =3D NULL;
> +	memset(&pdata->data, 0, sizeof(pdata->data));

[Severity: Medium]
Will this cause a build failure on musl libc systems? It looks like
memset() is added here but <string.h> is not explicitly included in
tools/perf/util/python.c.

Musl libc enforces strict POSIX namespace separation and does not implicitly
include headers. Could we add an explicit #include <string.h> at the top
of the file to ensure the build succeeds in environments using musl?

> =20
>  	if (fd !=3D -1) {
>  		struct stat st;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623053515.2677=
888-1-irogers@google.com?part=3D11
