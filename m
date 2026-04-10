Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CAA2D8DD0
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783452; cv=none; b=Hm6XSrAj0/kIZRjEABDZ2OG9RGnqpLGHJHE7vkIHcy2dbMeIteLlZq2UFLjZ5ePWHjmq1QfT2z4EQRLuPqnXQKU3CnHpGz5ApdZshPUPQHKS8M56KwDMmQM8zf0w+BCd1StfEPxrtbnuPTTcLZDmP7UcG8g/sjfibLwll04Rr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783452; c=relaxed/simple;
	bh=+AvPPyAAHqL6Qmw1m8IbexLjIIBoHddBlvKJXvBXuIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=olso8kVD/+/q3xchmO2lsjqwUsivz0GX9OHopXd3KYBygBLweP/EeLWE5h/S+Oy/vMlKIBcYxDZ+slTdJzutk22EbzABNfc06pbYtGMOwCIgGabyIDX1YIbnV2SlPQuqBbAWYzyDDHNk/60u2p1EYQc8nQGAyN7QpI0BdmW2XjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZv7/QTY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZv7/QTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36A2C4CEF7;
	Fri, 10 Apr 2026 01:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775783452;
	bh=+AvPPyAAHqL6Qmw1m8IbexLjIIBoHddBlvKJXvBXuIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qZv7/QTYLNgA1yAsSRDIf7Mmz8MsY1Q6hpzimOyqC78g3lkZTLiR0MinjzUYgrJ6/
	 i/A2IZPl6q9glEpWdV6eSdN1y9YT140RBxkYIO2nDiI2075ptuiv+0vImKOKV9VKLb
	 wt80qZ8qyHgaZ95Yrt5P/POYL4d89B7+UcFn0rgZgIAOlwZ4ZEPw0M2F5FD+hEDGgp
	 9uHmDKuOLY72rFBWfVsKILNvzEhv1pWeeGSwMeHv50mnjzZNGOWP1ay0xVJC5iFBez
	 /JDuYlRdG57h26qUfSp3l89VCwXnENg4TwQc5wbDzff9YMwN4AqKTvyYUDwmGTwciT
	 1nmIEiQJWuanQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] perf header: Sanity check HEADER_PMU_MAPPINGS
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410004000.148138-8-acme@kernel.org>
References: <20260410004000.148138-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 01:10:51 +0000
Message-Id: <20260410011051.E36A2C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Incomplete Hardening / Brittle State Mutation leading to NULL Poin=
ter Dereference
- [High] Information Leak / Out-of-Bounds Read in `do_read_string()`
--

commit f8a3a1de8d8a986abb3e1819cdf6e18f8f1d826d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_PMU_MAPPINGS

Add upper bound check on pmu_num in process_pmu_mappings() to harden
against malformed perf.data files (max 4096).

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 45f533fbb8fdc..1d7ca467acf32 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3067,6 +3067,19 @@ static int process_pmu_mappings(struct feat_fd *ff=
, void *data __maybe_unused)
>  		return 0;
>  	}
> =20
> +#define MAX_PMU_MAPPINGS 4096
> +	if (pmu_num > MAX_PMU_MAPPINGS) {
> +		pr_err("Invalid HEADER_PMU_MAPPINGS: pmu_num (%u) > %u\n",
> +		       pmu_num, MAX_PMU_MAPPINGS);
> +		return -1;
> +	}
> +
> +	if (ff->size < sizeof(u32) + pmu_num * 2 * sizeof(u32)) {
> +		pr_err("Invalid HEADER_PMU_MAPPINGS: section too small (%zu) for %u PM=
Us\n",
> +		       ff->size, pmu_num);
> +		return -1;
> +	}
> +
>  	env->nr_pmu_mappings =3D pmu_num;
>  	if (strbuf_init(&sb, 128) < 0)
>  		return -1;

This isn't a regression introduced by this patch, but since the goal is to
harden process_pmu_mappings() against malformed files, does this leave a cr=
ash
condition if parsing fails later?

If an error occurs after env->nr_pmu_mappings is set:

	while (pmu_num) {
		if (do_read_u32(ff, &type))
			goto error;

		name =3D do_read_string(ff);
		if (!name)
			goto error;

the function jumps to the error label and returns -1.

If the caller perf_session__read_header() ignores the error, we are left wi=
th
env->nr_pmu_mappings > 0 but env->pmu_mappings as NULL.

Could this lead to a NULL pointer dereference in functions like
perf_env__has_pmu_mapping() that iterate up to env->nr_pmu_mappings and pass
env->pmu_mappings directly to strtoul()? Should env->nr_pmu_mappings only be
updated on the success path?

This is also not a regression introduced by this patch, but does
do_read_string() ensure the returned string is null-terminated?

		if (strbuf_addf(&sb, "%u:%s", type, name) < 0)
			goto error;

If a malformed perf.data file provides a string without a null terminator,
and do_read_string() returns a buffer that isn't null-terminated, could the
%s format specifier in strbuf_addf() read past the end of the allocation
until it hits a null byte in adjacent heap memory?

Could this lead to an out-of-bounds heap read, potentially crashing perf or
leaking heap data into the PMU mappings output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410004000.1481=
38-1-acme@kernel.org?part=3D7
