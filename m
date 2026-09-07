Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921F388880
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746806; cv=none; b=fsThjWHCTxMX6LEtfEHSbJxIWUwblMfL+3QcI7VhjWT6xqc9JUgiqFk7Q77QMQRivbCq9CvJveBrl7Ep4dUKHd61HQIgt9y+PNj9uX3MIQ0A+K09Yf6l28VpIHCFCa9z15rf1EBPa8zREn2ZXftjY68NeU8M2mU6fFDZSKgDFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746806; c=relaxed/simple;
	bh=AB0+w8bXmArkWSTWJMJn4NC4VYz3Sf+xPbMvxqAeyy0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cmX9HT3e6yVJDO00/cjnJ79XnBEV+Ye/L2obCgD4093vi22vb7oz548Wi43o43qi7ttjMSNYnFxPknvEpTO6YVEMPDiAg4g+puHSj8SOMzF3sE0tYu0iA0zRgmEUVzlyWg38fKPKUF68XdaEjyZGdLvYxFgvhqVt2BYTouMpIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atLYl3U4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atLYl3U4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7261F00A3A;
	Mon,  7 Sep 2026 02:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746803;
	bh=D4q4Osgt+0XVowVxviuYA/igDzKAnEHVaNddekeTXSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=atLYl3U4c/nxhXYxlGM5wf4lkfNTMBMeOV7NxuRtxJobevL6tKatyKpDliBm/kECv
	 cjydLQfyj9XPIuL6iQZCwam8eWK1LmRubeeTtT8tv6EmcwqpsCL9CjI/6QccOLaPk9
	 cn9iW6ZuKo7FFO5cEFSLE56XfYhTBfrva8Bxa2cR+QMbXrGllKg4I9v0hbJhqDFrEo
	 HT6zTrsEMlfnPvx2Dv5JKdv5O9b1ZmXwdRrvpHZPIRRcT4M6xn90ac3P7qvZSv8LzR
	 /p96ZIySRbqfN+eDXAldkknGRsbtZlTVkU0+dFkSHza1LSJs04Rso/TcJA/SqvACAn
	 WtAooV7Rrp0Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 perf-tools-next 2/6] perf trace: Validate payload
 bounds in augmented string beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907015140.363076-3-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
 <20260907015140.363076-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 02:06:42 +0000
Message-Id: <20260907020643.4F7261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failing to validate memory alignment of malformed payload sizes ca=
uses SIGBUS traps on subsequent arguments.
--

commit 2e5b760b204b32d343eb2501c4ff84ed16a4618a
Author: Aaron Tomlin <atomlin@atomlin.com>
Subject: perf trace: Validate payload bounds in augmented string beautifier

This commit adds bounds validation for augmented_arg->size when=20
pretty-printing augmented string arguments in the perf trace tool. It=20
ensures the payload size is within the remaining buffer bounds before=20
calculating consumed bytes, preventing potential buffer over-reads and=20
integer overflows.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 20fffc24507b5..91461ab927b63 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -1898,12 +1898,21 @@ static void thread__set_filename_pos(struct threa=
d *thread, const char *bf,
>  static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg=
 *arg, char *bf, size_t size)
>  {
>  	struct augmented_arg *augmented_arg =3D arg->augmented.args;
> -	size_t printed =3D scnprintf(bf, size, "\"%.*s\"", augmented_arg->size,=
 augmented_arg->value);
> +	size_t printed;
> +	int consumed;
> +
> +	if (arg->augmented.size < (int)sizeof(*augmented_arg))
> +		return 0;
> +
> +	if (augmented_arg->size <=3D 0 || augmented_arg->size > arg->augmented.=
size - (int)sizeof(*augmented_arg))
> +		return 0;
> +
> +	printed =3D scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmen=
ted_arg->value);
>  	/*
>  	 * So that the next arg with a payload can consume its augmented arg, i=
.e. for rename* syscalls
>  	 * we would have two strings, each prefixed by its size.
>  	 */
> -	int consumed =3D sizeof(*augmented_arg) + augmented_arg->size;
> +	consumed =3D sizeof(*augmented_arg) + augmented_arg->size;
> =20
>  	arg->augmented.args =3D ((void *)arg->augmented.args) + consumed;

[Severity: High]
This is a pre-existing issue, but does failing to validate the memory=20
alignment of malformed payload sizes cause SIGBUS traps on subsequent
arguments?

If a user uses the perf trace tool to read a malformed or maliciously=20
crafted perf.data file where augmented_arg->size is not naturally=20
aligned, the tool advances the pointer by this unaligned size without=20
correcting it.=20

Can the next argument read dereference a misaligned pointer and crash=20
the perf tool on architectures requiring strict memory alignment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907015140.3630=
76-1-atomlin@atomlin.com?part=3D2
