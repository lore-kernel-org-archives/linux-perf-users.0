Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9267175A9C
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789872217; cv=none; b=BnsdxIaQe30zJ5GMw1fCdhTgpd8dAxdKtQlmmzMgnDxu/USNdDPPdHqZAt42N4LXV3e/ywM+i7wNKKdw8ZieFDEn9uZIlAMyBo0YLZMbnDmIjNnFLkOtpPKgcrlzJyDp9EpgwV03qIjc5NABxN1qn4de/cmmmJMCxOUVazK6s7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789872217; c=relaxed/simple;
	bh=l9x5rhs4UoRSrxjvH/ICH5iBIESY69mPT1MU2mJ2Quw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZxZ3SppXLRiB7NfIMYbBWbKAktJNOsfpA8DxxeGPqH4nTZJOMvyVf+NclkTWD+DOSPzEleWFx4p+PQKIKOXiMZepSkIfIL0VGDnVagKl27n63etOaF0zoA4Kan0QiCH+Vl+W0h/MemXaaeB3pAHc7CLG+xnnULegpIdXotHYn5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h62xf2mc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h62xf2mc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F2A1F000FF;
	Sun, 20 Sep 2026 02:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789872216;
	bh=PmCVp85rNwWyCypugCE/d0RZtHkVPotXNRBVFYuJrIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h62xf2mc/miGenC723y6oq8kQY4O7F4ghXMrBK/FZZ/mU4aSJPBE45x9pmVuBTfXO
	 KpSNscGgs1rLkc0dIEPIx4HCYHF2tlljel0bxeA5VbrkibMeSVbDiFl0GZwPt7NYxQ
	 Y+mp8vFahNY21e96tRPWvZ1Hv93Z8KPRs5Mb+uTRqUKmW76e6KM+ufA9UWF2cVjNj4
	 gknHuxJD+x0NIb4xdiZ+MRPa1B+CjrpfwQxz/Y3xSjNgPcvQqxXb8Ahyy8G9dtiDtO
	 1+n5kW+JXlu7AMLUuQYcOtm4s3N6qlNbGMGcZHJybwl1Jdp+SEat0UTLTT31U7Espc
	 V1oxwxNxnX8vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf script: Add --max-symbol-bytes to bound ELF
 symbol memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919-perf-symbol-memory-send-v2-2-495b8f00ad7c@uber.com>
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-2-495b8f00ad7c@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 02:43:35 +0000
Message-Id: <20260920024336.67F2A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing <stdbool.h> in symbol-bytes.c
--

commit 43444932791d9e1c6b50bba8362920738abe2410
Author: Alireza Haghdoost <haghdoost@uber.com>

perf script: Add --max-symbol-bytes to bound ELF symbol memory

This commit adds a new --max-symbol-bytes option to bound the memory consum=
ed
by struct symbol allocations. Once the specified budget is reached, the ELF
loader stops loading new symbols and prints unresolved addresses as unknown.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c

[ ... ]

> @@ -4035,6 +4036,44 @@ static int parse_callret_trace(const struct option=
 *opt __maybe_unused,
>  	return 0;
>  }
> =20
> +static int parse_max_symbol_bytes(const struct option *opt,
> +				  const char *str, int unset)
> +{

[ ... ]

> +	if (!strcmp(str, "0")) {
> +		*max_bytes =3D 0;
> +		return 0;
> +	}
> +
> +	len =3D strlen(str);
> +	if (len < 2 || !strchr("BKMG", str[len - 1]) ||
> +	    strspn(str, "0123456789") !=3D len - 1)

[Severity: Low]
This is a pre-existing issue, but parse_max_symbol_bytes() introduces direct
calls to libc string functions like strcmp() and strlen(). Since this file
lacks an explicit include of the POSIX <string.h> header, does this cause
compilation failures in musl libc environments where headers are not
implicitly included?

> diff --git a/tools/perf/tests/symbol-bytes.c b/tools/perf/tests/symbol-by=
tes.c
> --- /dev/null
> +++ b/tools/perf/tests/symbol-bytes.c

[ ... ]

> +struct reserve_arg {
> +	size_t bytes;
> +	bool success;

[Severity: Low]
This struct uses the bool type, but the file doesn't explicitly include
<stdbool.h>. Can this cause a compilation failure under stricter libc
environments like musl due to the missing type definition?

> +};
> +
> +static void *reserve_bytes(void *data)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-perf-symbo=
l-memory-send-v2-0-495b8f00ad7c@uber.com?part=3D2
