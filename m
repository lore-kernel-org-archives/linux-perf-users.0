Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A83E559C
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335206; cv=none; b=nu0Dcn3GkV11cgPQzYz3xFUI9uuZoowbykurgBFaGFLlH5ypSMV8KDxPVW8JXq7lSSmFPEUpcjMrCxYyNyOp3hXclKOdXZkzZ28xtJywJ1Buce4GKnzyn1fyqDsNXORNcT2xnLPa07Hoaq2oqoLlrVA6qGtoW+layH8b/JYxAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335206; c=relaxed/simple;
	bh=utXIq8/WY20p3LsnUXn0xyYBUyfgJSd6aYM0/oH6mx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CUPeJrwQOsPLV/oK5RU4sj97aJmdcHuccC0oLSb7z9d4P1dClAwMHG2pXf7UTvixyNLvwRcCZIfLvXWCs5mMAiS0kvXz3xu3Dh5g6Xe8f0NyfqB00+JKV02OHmF8M5aK5P6PDbCTLogn/yyOOINBXPaxnmqKLsQxWN8NC1xxjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVbXQYeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVbXQYeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FEE1F000E9;
	Wed, 24 Jun 2026 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782335205;
	bh=qEPju2cfO4gNKyrQbkcBvQ2u0yxecJYCTcoc2lkxBhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVbXQYeoZH1Vzv2Db0BA5zoyiaLyPV2VBjKnmn16B4qTYWTxUvaACnrOcOoEzuWEc
	 N06EZYFvXBGJcsNSLI3INpA2yshaZ5kL9KiByHYdSS/6HtJfsvLAxrPd/kofBMSJEl
	 tCjvtsLkGzlDb9yueHsDyC0VCLaRx0WGGB+bW71WW5G+9vIWU3YX+cEeWmDBZVrZdT
	 83ECE5P2ARqOyANvaQQ361OKGnf7O2Y03eEhhErscxvGYYFZ2yePISH8Q+MoZ5JI3o
	 sGnL4uwmOtlk8v5pP/bXXJbBJOaunecci4VRGs06vruwyhMvPZoIc1N6axvlrEjuzi
	 DvQQOffv4AoGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] perf timechart: Fix memory leaks during record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624205852.3864874-7-namhyung@kernel.org>
References: <20260624205852.3864874-1-namhyung@kernel.org>
 <20260624205852.3864874-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 21:06:44 +0000
Message-Id: <20260624210644.F1FEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing explicit POSIX header inclusion for `free()` (musl compa=
tibility guide violation)
--

commit e9f4fbcd6ed720db9d6b0daaf8a565c9bbbd415e
Author: Namhyung Kim <namhyung@kernel.org>

perf timechart: Fix memory leaks during record

The command line options can be passed without copy as their lifetime is
limited within the same function.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 27d17268395ed..a73f0ab22fd64 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
[ ... ]
> @@ -1891,7 +1892,11 @@ static int timechart__io_record(int argc, const ch=
ar **argv, const char *output_
>  	for (i =3D 0; i < (unsigned int)argc; i++)
>  		*p++ =3D argv[i];
> =20
> -	return cmd_record(rec_argc, rec_argv);
> +	ret =3D cmd_record(rec_argc, rec_argv);
> +
> +	free(rec_argv);
> +	free(filter);

[Severity: Medium]
Does this code need an explicit inclusion of <stdlib.h> at the top of the
file?

The perf subsystem musl compatibility guidelines mention that files using
POSIX libc functions must explicitly include the relevant headers, as musl
strictly separates declarations unlike glibc. Could these new free() calls
cause a build failure on systems using musl libc if the header is omitted?

> +	return ret;
>  }
> =20
> =20
[ ... ]
> @@ -1966,24 +1972,27 @@ static int timechart__record(struct timechart *tc=
hart, int argc, const char **ar
[ ... ]
>  	for (j =3D 0; j < (unsigned int)argc; j++)
>  		*p++ =3D argv[j];
> =20
> -	return cmd_record(rec_argc, rec_argv);
> +	ret =3D cmd_record(rec_argc, rec_argv);
> +
> +	free(rec_argv);

[Severity: Medium]
Is it possible this free() call also requires an explicit <stdlib.h>
inclusion to ensure it builds correctly against musl libc?

> +	return ret;
>  }
> =20
>  static int

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624205852.3864=
874-1-namhyung@kernel.org?part=3D6
