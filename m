Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578162DC79A
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122096; cv=none; b=g8FuAflsZu1p+GdKiQXVISETaI64NdE2u2ZP/+RQIHvG8ig2OPiazE2Hh67+6wZUt7V6OuDDj98lj4IN6xjExhkoU8c3K0qCnVETUp9HwHNfs3bi2XBdEitUxKdpmRfWwm6FrHr/HFtYG55jeB+nXs2mnwy8ntn5M1i1l6gQEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122096; c=relaxed/simple;
	bh=xCZSAgLoWiP1uQtm+G0rhHSomly1rYykN5h0sLyydtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=auXPpDPT3Lu8KXL5KLHcvjtmGq7836oMoNoXZSkMylb49kI2PTA4NH2MvuuTASFWI9dATboc7sfRLn4ESJMnGFD7OQzDQhXa0+vbwSF1Eoa4qUUm3WZhpUkaN5nkfWQHNCcUbPr8Jvjal6ip9A84hOgZRBvI6rdYJTIvrDNLUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeEK9oeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeEK9oeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D93F1F00893;
	Wed, 10 Jun 2026 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122090;
	bh=jZ1SzX1KcUngKs8hw3M9bOhECUrS5OfBoc+7sqphXdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DeEK9oeYxVbFMErxJAZSRLUEsCuQdiUrG8pwp5MHkRjGIOLi7iFFgKwXwdK/OyBfp
	 cAI32T6NVhvaD39Lb+txhcU8KbPjwOAgNwFRgQkTuM7/HQwe1D5/qlnWzzbU2kBGQo
	 yCwz9HQjkZU8RxqPJIGIqLyLj2U85QLm2URJCZMSkoumbjLeEOmhnSvifLOut6U+v9
	 m83D0hOA6jAFLRaLRjMGo03EkTKQndNrqXunVotpg4jbufQ5bV8MErS/Q/ypq3UyNj
	 wYyxlXMSLk4eChC5OjVlzW/eQu+vzdooN32NXn592gTD2d1/Ah+zsbEZGkzKzKZtzL
	 rQaEbqZ4uE/2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/23] perf tools: Fix uninitialized pathname on
 uncompressed fallback in filename__decompress()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610195157.2091137-14-acme@kernel.org>
References: <20260610195157.2091137-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 20:08:10 +0000
Message-Id: <20260610200810.8D93F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message explicitly describes a logic flow that would =
cause a severe data-loss bug, while the code implements the opposite (safe)=
 logic.

Pre-existing issues:
- [High] Missing error code propagation and improper negative error handlin=
g cause `__open_dso` to mistakenly return valid file descriptors on failure.
--

commit 5ae85aedfdb730a58a0d285fd77526ec0c92c20e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Fix uninitialized pathname on uncompressed fallback in filename=
__decompress()

This commit addresses an issue where filename__decompress() left the
pathname parameter uninitialized on the early return path for uncompressed
files. The code is updated to set an empty string in this case, and
callers are modified to check for this empty string condition.

> Fix by copying the original filename to pathname before the early return,
> matching the behavior of the normal decompression path.

[Severity: Medium]
Does this commit message accurately describe the implementation?

The code below sets pathname[0] =3D '\0' instead of copying the filename. If
the code had copied the original filename as described here, wouldn't calle=
rs
assume the populated pathname was a newly created temporary file and call
unlink() on it, deleting the user's uncompressed kernel module or binary?

[ ... ]

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ee06a252a54d3..6a34717c9f31f 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -343,8 +343,11 @@ int filename__decompress(const char *name, char *pat=
hname,
>  	 * To keep this transparent, we detect this and return the file
>  	 * descriptor to the uncompressed file.
>  	 */
> -	if (!compressions[comp].is_compressed(name))
> +	if (!compressions[comp].is_compressed(name)) {
> +		if (pathname && len > 0)
> +			pathname[0] =3D '\0';
>  		return open(name, O_RDONLY | O_CLOEXEC);

[Severity: High]
This is a pre-existing issue, but if open() fails here, it returns -1
without populating the *err pointer.

If open() fails, could this sequence occur?

filename__decompress()
   returns -1 without setting *err

dso__get_filename() catches the failure:
   errno =3D *dso__load_errno(dso); // errno is overwritten with 0

__open_dso() handles the NULL return:
   fd =3D -errno; // results in fd =3D 0

Alternatively, if decompression fails later in this function, *err is
populated with DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE (which expands to
-10005).

In that case, would errno become -10005, and fd =3D -(-10005) =3D 10005?

Since both 0 and 10005 are non-negative, does this cause callers to treat
the operation as successful and attempt to read from standard input or a
bogus file descriptor?

> +	}
> =20
>  	fd =3D mkostemp(tmpbuf, O_CLOEXEC);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610195157.2091=
137-1-acme@kernel.org?part=3D13
