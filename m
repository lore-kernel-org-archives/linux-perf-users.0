Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084C37EFFB
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860429; cv=none; b=sdOTd/IrObe8OJDle0UjlSnfBYd90hx2p/BTPncCCJYxfPsC0v66epE1bkI2TZ8Yec931snAzlMHt9wVFHMhI+ajSAa8Ve3HyyvPDJEwrdW+1Ib5PMOG8zZAaowHvQUV57QQbhGFhUqdjXhU1cH+SHzAEHelnnrKahmYMOCMnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860429; c=relaxed/simple;
	bh=r2kDbq48g/Rh6Gk9Jw806g42w2U6M76DdUrEhIra2SA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XS8BZHyGiF3iGBtLLz1kdJRCPr9GknlUDtiXWw3qgWC3dBQ+A7OwppAOT5Uw5UWDkBn7NsCNOgXg8JEO6U/5JAqQcuV1l06rCDYMB1f1YrXPYWuZL5FWPMJbOYcSusXMLLb27L3JSA3GYit8e/OQ8wn/uC6W4gh2n0aqDS9t0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvMArDpg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvMArDpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DA5C19421;
	Fri, 10 Apr 2026 22:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860428;
	bh=r2kDbq48g/Rh6Gk9Jw806g42w2U6M76DdUrEhIra2SA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jvMArDpgY/T9ObfeHOBRhEvc4rrxRTWOpN3muWqUV9bZJa4S9eETrLAnr9y2M2eYu
	 nmmO3x5xJmMhpE7JcrZUIS6fUDnW0ar8+I72yMOZd9Tkez4OlFdQHLMJMErrzQcTvG
	 knGaQePANcaS/Cohtf4BsK1ainSklOA87/+ph53OxfPi1nMog+meKM6tMul8lWSu4i
	 J4JnEjuUdQAMN9cPOvmEmVVjlZ/dSTsR0ww9xFZNWrf+re48GHF9lgX8GlZs0qpYfV
	 dIGPcjwwFoh85hM5hqekO7i4utb3RSJ2KQh7eXwSZMT9FgNMuQFxEnkYbLkyd7StKc
	 mw4t+838VH6jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] perf header: Sanity check HEADER_PMU_MAPPINGS
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410220905.200051-8-acme@kernel.org>
References: <20260410220905.200051-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 22:33:48 +0000
Message-Id: <20260410223348.C2DA5C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] State corruption on error paths leads to a guaranteed NULL pointer=
 dereference when parsing malformed files.
- [High] Missing null-termination check on strings read from the file leads=
 to an out-of-bounds read in `strbuf_addf`.
--

commit 5a25c2d6480a45a3a7a4134af439a72344304a5c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_PMU_MAPPINGS

This commit adds an upper bound check on pmu_num and a section size check
in process_pmu_mappings() to harden against malformed perf.data files.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3069,6 +3070,18 @@ static int process_pmu_mappings(struct feat_fd *ff=
, void *data __maybe_unused)
>  		return 0;
>  	}
> =20
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

This isn't a bug introduced by this patch, but if strbuf_init() fails or if
an error occurs in the while loop, this function returns -1 but leaves
env->nr_pmu_mappings set to pmu_num.=20

Because the caller perf_session__read_header() silently ignores the -1
return value from section processing, the session initialization succeeds.

Later, functions like perf_env__has_pmu_mapping() will iterate
env->nr_pmu_mappings times over the NULL env->pmu_mappings pointer:

bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name)
{
	char *pmu_mapping =3D env->pmu_mappings, *colon;

	for (int i =3D 0; i < env->nr_pmu_mappings; ++i) {
		if (strtoul(pmu_mapping, &colon, 0) =3D=3D ULONG_MAX || *colon !=3D ':')
			goto out_error;

Could this lead to a NULL pointer dereference when passing pmu_mapping to
strtoul()? Should the assignment to env->nr_pmu_mappings be deferred
until env->pmu_mappings is successfully constructed?

>  	while (pmu_num) {
>  		if (do_read_u32(ff, &type))
>  			goto error;
> =20
>  		name =3D do_read_string(ff);
>  		if (!name)
>  			goto error;
> =20
>  		if (strbuf_addf(&sb, "%u:%s", type, name) < 0)

This isn't a bug introduced by this patch, but does do_read_string() ensure
null-termination of the read string?

If a malformed perf.data file provides a string exactly equal to len without
a trailing null byte, passing the buffer to strbuf_addf() could cause
vsnprintf to read past the end of the allocated buffer.

Could this lead to a heap out-of-bounds read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410220905.2000=
51-1-acme@kernel.org?part=3D7
