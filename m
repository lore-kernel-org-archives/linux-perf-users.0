Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5C46D0A5
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306527; cv=none; b=lhqp2g2npzWB+2OXZ9XyTrjLiM4S6STOi/DVVzxGpuii6kC3ncrgyBKvXO6gHmlIffWpPAnfG39oQCqaGV7LIfdqT68nzsXGZC6RMy98kb4T8nroOoJ2NHRHbp3Fg1jnIXSKQ0l1a04FYIPoRTkvuIx75nZwpcO1WCVS6xKCu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306527; c=relaxed/simple;
	bh=rYSbgHOq0fI6flWYMziWY+pNsi0R4vzEkpRIl5Q513M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UhxxCx5o21c0sqDYczpeUF18/QrVCk3CMmYXVxTwgasDZkAfxOznjDFm6zozVLNGmI850BEc0KcXLDAWzrd5tVLqhlrlu9pTQBPJKi+3Pf/Oexj1BDlLqMVEwwdqdC1klZTTMe4O9AOMyC1z5Egzd2FZK1RAWfTECIrNNMzFDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep+CPYdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep+CPYdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3241F000E9;
	Fri, 21 Aug 2026 10:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306511;
	bh=l9g95NXqcD3Szx34+PqbXNMOKjd1+nctZL7kCCxooLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ep+CPYdDimxbwMMaLM7+MQLeAlop1RlbRvI2hhFRHMqQo8ZHG3yAny7xMjVI9O/z5
	 b3Rmpr/mECVXkAk76dmiF8ANW7puiRt+m5Ab1eYMw9rOgi7N55LNg4iqWd61bUwsU5
	 +BbitKRGlUonngiaplES7SNSbLNb/rkoleHgqshdAxwcjvlSfhsXX/fYBHegGwhGqC
	 DMpHGGsbPrkpK3SWLOMHNQbvfjTa7Z0m6Inq95t2h9wrDeu1xLaiTlyUZdrgM02dZB
	 CTO/3lyGKLykkE9A3jk98mEkgzWqOLFziT5U2GXv3EQqP982IUImOHUBTzfcaBR9QE
	 2rj24pOFKZlSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/14] perf cs-etm: Turn on context packet timestamps
 in per-thread mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-3-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-3-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:01:51 +0000
Message-Id: <20260821100151.6E3241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditionally enabling timestamps in per-thread mode breaks re=
cording out-of-the-box on hardware without timestamp support (e.g., ETMv3 o=
r ETMv4 without TRCIDR0.TSSIZE).
--

--- Patch [3]: [PATCH v2 03/14] perf cs-etm: Turn on context packet timesta=
mps in per-thread mode ---
commit 23dc37429523715cdb26c5647b22b1a9dc0c89ab
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Turn on context packet timestamps in per-thread mode

This enables context packet timestamps in per-thread mode, replacing the
previous unset default. It helps keep samples in order when supporting
multiple per-thread mode threads.

> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util=
/cs-etm.c
> index acfdb3f53821e..d0486a164a700 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -453,13 +453,22 @@ static int cs_etm_recording_options(struct auxtrace=
_record *itr,
[ ... ]
>  	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> +		/*
> +		 * Timestamps are required to interleave samples from different
> +		 * CPUs.
> +		 */
>  		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
> +		/* Context IDs are required to associate trace to a process */
>  		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
> +	} else {
> +		/*
> +		 * Enable context packet timestamps only (no periodic
> +		 * timestamps). Even in per-thread mode with a single process we
> +		 * still need to correlate trace to a specific mmap around
> +		 * execs, which can be done with just context packet timestamps.
> +		 */
> +		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", UINT64_MAX);

[Severity: Medium]
Will unconditionally setting this timestamp break recording out-of-the-box =
on
hardware without timestamp support, like ETMv3?

Looking at cs_etm_validate_timestamp(), if the timestamp config is set but
unsupported, it aborts the trace:

tools/perf/arch/arm/util/cs-etm.c:cs_etm_validate_timestamp() {
    if (!val)
        return 0;

    if (cs_etm_get_version(cs_etm_pmu, cpu) =3D=3D CS_ETMV3) {
        pr_err("%s: timestamp not supported in ETMv3...\n");
        return -EINVAL;
    }
}

Does this mean users running perf record --per-thread on such hardware will
now get an error by default unless they explicitly pass timestamp=3D0?

>  	}
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D3
