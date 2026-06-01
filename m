Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36AB345CAE
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295081; cv=none; b=OHTNKUp1nIJqWomPML6rmr4Vd5VuWJcIAkamWzhgaSmXaXlseWjyPc9pRxv5ueV2cWh7GtJXbXCuoNme5of6UnEJ4tvcZy5n9/LPFTKakoF2gVJ5RiYzA5j+qXEA0wyph64oPQPpdyteJnHmf4HeaTI79ufzD6/c7LNCN+HrfuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295081; c=relaxed/simple;
	bh=p/muPOZWwyivQS8q7f2qJMVl74Kc/itkHwZCW874yTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kuLnMLRZFjSfE+iMsUEDzYRwi5mtI1VRAAFM/qj3BEZc4TE7VxtE+B9KN9BjcL166CNGBHw1AzU7491dZB3Bvf02M4MFNSLZtpKWdCvHXwyNnKYYirhirtIp2k9BkRApO5cJV7tC1vQR3AGibxW8tfZ2UvNmzR4F4K5krG59Jaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPVLvib/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPVLvib/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392001F00893;
	Mon,  1 Jun 2026 06:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780295080;
	bh=oe8NdzUkwWFW3nQ3DreZteYlgqHQ7IogZoeNWBROUDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nPVLvib/wX1rKyqYmGjPUBdt65+mdKGnXKdhFEt6fQjfXPNxRGOz0JgCmWDPHUxPz
	 4O+2mUPwVMYs8WrqK04ihA83jUgOFh3d+IvFrz2QKr+5735j1JhGSNBwNCz5aOu3vK
	 6Ty9yRo2SSjQPFF4u94zfnLd6B3/NibOFa+dvuwrHmouB3t30VcG6Hbs/1M/6N91eX
	 P7Hdt6QUyFqPNnZzEpdLdg/mae7hZYfVQ644nz/V8zL8slprVqbZu2ocTjpaaH5DeS
	 YEazK/EOW9BeOlDLx41Y6EMNu5vHBc/TR3xK1E8J7HOm6HvK9pbDdXcDZNMzO8LlPU
	 TwaJHLhOqS1mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] perf test: Add summary reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601061401.1541457-10-irogers@google.com>
References: <20260601061401.1541457-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 06:24:39 +0000
Message-Id: <20260601062440.392001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch completely removes the restoration of the signal mask =
in `strbuf_addstr_safe()`, causing SIGINT and SIGTERM to be permanently blo=
cked.
- [Medium] Unprotected `vsnprintf()`, `malloc()`, and `free()` calls in the=
 newly introduced `strbuf_addf_safe()` function are vulnerable to heap corr=
uption and deadlocks via `siglongjmp()`.
--

commit e684bcb42a8ce01d43caa88eb1009af815098cfa
Author: Ian Rogers <irogers@google.com>

perf test: Add summary reporting

This commit introduces an automated execution summary printed at the end
of a perf test run. It tracks pass, skip, and fail counts, and accumulates
descriptions of failed test cases for easy cross-referencing.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 6d7b4a952e909..5d319b9da7624 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -728,10 +748,36 @@ static int strbuf_addstr_safe(struct strbuf *sb, co=
nst char *s)
>  	sigaddset(&set, SIGTERM);
>  	sigprocmask(SIG_BLOCK, &set, &oldset);
>  	ret =3D strbuf_addstr(sb, s);
> -	sigprocmask(SIG_SETMASK, &oldset, NULL);

[Severity: Medium]
Does the removal of this sigprocmask() permanently block SIGINT and SIGTERM?

Because strbuf_addstr_safe() is invoked routinely during normal test execut=
ion,
such as via drain_child_process_err(), it seems the very first invocation w=
ill
permanently block these signals since the oldset is never restored. This wo=
uld
prevent users from interrupting a hanging perf test run.

>  	return ret;
>  }
> =20
> +static int __printf(2, 3) strbuf_addf_safe(struct strbuf *sb, const char=
 *fmt, ...)
> +{
> +	char buf[1024];
> +	va_list ap;
> +	int len;
> +
> +	va_start(ap, fmt);
> +	len =3D vsnprintf(buf, sizeof(buf), fmt, ap);
> +	va_end(ap);
> +
> +	if (len < 0)
> +		return len;
> +	if ((size_t)len >=3D sizeof(buf)) {
> +		char *dynamic_buf =3D malloc(len + 1);

[Severity: Medium]
Are these calls to vsnprintf(), malloc(), and free() vulnerable to deadlocks
if interrupted by the signal handler?

The perf test harness uses a custom signal handler that executes siglongjmp=
()
to abort hanging runs. If the signal handler interrupts non-async-signal-sa=
fe
functions like vsnprintf() or malloc() here before signals are masked, their
internal mutexes could be left permanently locked.

The subsequent error recovery path performs multiple free() operations that
could deadlock trying to acquire the same locks. Should signals be blocked
during these operations, similar to how they are handled in
strbuf_addstr_safe()?

> +		int ret;
> +		if (!dynamic_buf)
> +			return -ENOMEM;
> +		va_start(ap, fmt);
> +		vsnprintf(dynamic_buf, len + 1, fmt, ap);
> +		va_end(ap);
> +		ret =3D strbuf_addstr_safe(sb, dynamic_buf);
> +		free(dynamic_buf);
> +		return ret;
> +	}
> +	return strbuf_addstr_safe(sb, buf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601061401.1541=
457-1-irogers@google.com?part=3D9
