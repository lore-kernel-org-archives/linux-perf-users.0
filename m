Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926042F3C3E
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892008; cv=none; b=Gn05QEg6F+sYBtzc8un5qhdGcT2wtqOm6YoG4M/1Q8GXxIiuYpfqSWaYkr7ZBUOkrP+i44UDsdEEOD1rMTlqyJaFYAp+/+bbOX7YIclDnxC3rIHvyTucGFlXi9n8m8FtimAj3LctGqsphYocx0wDbEyBLGsdMpDuE4ahSUWM4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892008; c=relaxed/simple;
	bh=Gmkw/TefzgnOvueHcNybuVxDwvbO1qBpOJxhUUa6Slo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b7gxQxahIllm19RUmvB3ItSGJ7RQ6PU8sFuMOXQxD289F1B+rQGblmqFDJO7AJ24u4ttMTMMScjHo6MCWX/cFneteOE/tY7B/Xi0AgAbHEcVN8F11LkJ4VhtdgecUZe2lBuOFlIHsDrRMuQzH7wAYn/5R5UgWagP+kBdhhExujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJb23xh0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJb23xh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DE1C4CEF7;
	Sat, 11 Apr 2026 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775892008;
	bh=Gmkw/TefzgnOvueHcNybuVxDwvbO1qBpOJxhUUa6Slo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oJb23xh0PPNgezwle0x0uo4XcLteyInkXw2Ye/guKYQywy+LDNVDHgMxjyrMW1IoP
	 e6XtcltHrkLDxf/QEHralcuK5eBva65Kl49P7kAeJmc3QP2szoJbkVL+eJRCK5kQXC
	 Fk2V/2T8uhBKMYumm56uf4+duS4DMT9YEDdSdQWKwzWm9b6Vv96qF2KrjL4whXGMx2
	 RjPL6x9srTIXK7lZjH67vFAejgsuDeNrUbvv7QPPC0vccEIMSrTs8Y2FTt0TY2xtO8
	 L1krcz1xB0i49wUksvppzrZjZ85v83yiqzuOzHhzQMSmydlaC+e3B2f3cj24fXvuBy
	 A4veXxTj6DEBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 28/29] perf kwork: Fix address sanitizer issues
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-29-irogers@google.com>
References: <20260411065718.372240-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 07:20:07 +0000
Message-Id: <20260411072008.25DE1C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Memory leak of the `rec_argv` array if the `to_free` allocation =
fails.
- [Medium] Memory leak of duplicated argument strings on the `STRDUP_FAIL_E=
XIT` error path.
--

commit 4177ff06047a8ec115a7e41c18ecb9f7b6bbf2d5
Author: Ian Rogers <irogers@google.com>

perf kwork: Fix address sanitizer issues

This commit addresses a double free in the record array caused by how
parse_options mutates the array. It fixes this by maintaining a separate,
unmutated array to track the pointers for freeing.

> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -2279,6 +2279,9 @@ static int perf_kwork__record(struct perf_kwork *kw=
ork,
>  	rec_argv =3D calloc(rec_argc + 1, sizeof(char *));
>  	if (rec_argv =3D=3D NULL)
>  		return -ENOMEM;
> +	to_free =3D calloc(rec_argc + 1, sizeof(char *));
> +	if (to_free =3D=3D NULL)
> +		return -ENOMEM;

If the allocation for to_free fails, does this code leak the newly allocated
rec_argv?

> =20
>  	for (i =3D 0; i < ARRAY_SIZE(record_args); i++)
>  		rec_argv[i] =3D STRDUP_FAIL_EXIT(record_args[i]);

[ ... ]

> @@ -2296,15 +2299,20 @@ static int perf_kwork__record(struct perf_kwork *=
kwork,
>  	BUG_ON(i !=3D rec_argc);
> =20
>  	pr_debug("record comm: ");
> -	for (j =3D 0; j < rec_argc; j++)
> +	for (j =3D 0; j < rec_argc; j++) {
>  		pr_debug("%s ", rec_argv[j]);
> +		/* Save the pointers as the array will be mutated by cmd_record. */
> +		to_free[j] =3D rec_argv[j];
> +	}
>  	pr_debug("\n");
> =20
>  	ret =3D cmd_record(i, rec_argv);
> =20
>  EXIT:
>  	for (i =3D 0; i < rec_argc; i++)
> -		free((void *)rec_argv[i]);
> +		free((void *)to_free[i]);

Since to_free is only populated immediately before calling cmd_record(),
what happens if STRDUP_FAIL_EXIT() triggers a jump to EXIT midway through
the string allocations?

Would the loop here iterate over NULL pointers in to_free and leave the
successfully duplicated strings in rec_argv leaked?

> +
> +	free(to_free);
>  	free(rec_argv);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D28
