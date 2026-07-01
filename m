Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421C3783AC
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878710; cv=none; b=WJV56mNZ4EjsMTwO61znt2T6poy6Tzd43ycR5TITgm5+0IEFtETfp0+RF18rx0CgjdqIdASgTpI46W24flrT/CffOhRIumSJd8ICZDjq1WNM8IHxPIUsaSDr3hNKiC6htkPpLGEO/ilphLd+JQ0RDbzvGp4JlA2oPm7O3HP400I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878710; c=relaxed/simple;
	bh=BDZQTnwS6hntB8bcYbaIJvCnYYJffKP9LvSqmKkmoXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mb9IFCZ9RJc6zIGesNGQP1PHHp1lBVz8qUIQ9F9pttSjueZQQJlfAs+4rulMS7w4LfLma/mu8iILPkL/6jBpHZmzTw4ftb4ogcpKGuP682Q5aD3PaX9j45i+ONaRawNPOjnmSAkDmfccxkGlo9v0OOxz9MqrXWwhM3pA048qeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl0E5ijv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl0E5ijv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1A81F000E9;
	Wed,  1 Jul 2026 04:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878703;
	bh=hJHgjbUzx5n04T2RHZW576f5UrhrUzjLS/VpbsOptQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nl0E5ijv/Rx63RPtyhAOXQIZLuu1brr9WrWYEH0nJ9glbi+maDoxH8MSoNPLWm6G8
	 xb0orjcnEDirI23XtXchYUsdmyBFnUqHfAEteSMRgTjqA71UQ6jjKKINuLla/HMz10
	 dYximx2OrztsYs88FrSiAu2Zy2o6mH1BsjVqtX/HqvxanIuJsk0TC/MCmzrRM3KjpY
	 PFJULhzuVwn1TGCBfHrDPzeDdTnG79IcViPraUzqgdB/tzkXgbYOq5+Bq69t1QsbpI
	 L2QOevmeHnfBO8IZBLBRheFZntNImdBTZlPR/cP6cTYS/9FFiNUczWJ9YB8ps+v17k
	 weDYybL0gMMXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/21] perf auxtrace: Set default period to 1 for
 PERF_ITRACE_PERIOD_INSTRUCTIONS type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-12-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-12-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:05:02 +0000
Message-Id: <20260701040503.8E1A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a regression where multiple `--itrace` opti=
ons silently overwrite a previously user-configured instruction period.
--

commit 37214515750cb3145373998c5f8b034630d80bf7
Author: Tengda Wu <wutengda@huaweicloud.com>

perf auxtrace: Set default period to 1 for PERF_ITRACE_PERIOD_INSTRUCTIONS =
type

This commit sets the default instruction period to 1 when a period is not=20
explicitly specified for the PERF_ITRACE_PERIOD_INSTRUCTIONS type. This fix=
es=20
an issue where a zero period resulted in zero percent values in perf annota=
te=20
output.

> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
[ ... ]
> @@ -1759,6 +1759,12 @@ int itrace_do_parse_synth_opts(struct itrace_synth=
_opts *synth_opts,
>  			synth_opts->period =3D PERF_ITRACE_DEFAULT_PERIOD;
>  	}
> =20
> +	if (!period_set &&
> +	    synth_opts->period_type =3D=3D PERF_ITRACE_PERIOD_INSTRUCTIONS) {
> +		/* Indicates a sample is taken for every instruction. */
> +		synth_opts->period =3D 1;
> +	}
> +
>  	return 0;

[Severity: Medium]
Will this silently overwrite a user-configured instruction period if
multiple --itrace options are used?

Since period_set is a local variable initialized to false on every call to
itrace_do_parse_synth_opts(), if a user provides an explicit period in one
flag and later provides another flag without a period:

First call (e.g., --itrace=3Di1000i):
    period_set =3D true;
    synth_opts->period =3D 1000;

Second call (e.g., --itrace=3DM):
    period_set =3D false;
    // synth_opts->period is overwritten to 1 here

Could this lead to extreme performance overhead during decoding by
unexpectedly dropping the sampling period to 1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D11
