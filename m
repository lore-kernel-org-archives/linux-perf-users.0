Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607456;
	b=dF2LMbf60GvxzMlrwpuaEEjBNz/6gRj2BJjEpDbeOfGY9EHDsqN66UvpLufEq6lUyP+U
	 r+ow3T9hy8CZjx29KKHDUlbm23gA9Of0yNLIpkHA5fVS8OFmYhvFWeorzSIN7yuhPdnuT
	 8YVcOqcn+QJW2Yy0Tutb/ucVSLCbDTFIjojFgTz4ThtY9NBNNBReiDBs4hVaFU9j+iom1
	 Sndv9q6rCWvMAaDDV9OJFJ1kAhRQP20tDRr8fQtUhfcMp3PdV/0hEudDYDbPALvPPRNJF
	 Jaj06IEcFNqklgLkEDmdkwkE/xtLncnRgzYbwvXCHTEDwTupBjn+XmmtnoPUqeBqzBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607456;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BScDCg5LCO/KNMAyfIlt4shKfCRH7eM7O4Hkw9v2sO4=;
	b=UMhBX2ttPP5JDma4HwsyUXB7v//WcspI+BU4Y9A7GSf/kQPLQl4nFIM5prctHUJfVlHQ
	 yQnAqkP1TbuSYuSEO+zCCVIRcYXxuvR0nZGzv8fpn7Omum+GsJwZjcIgzoO15P8GLDUjh
	 TnfNHTWfVxyUMSpFR+fr9bm3DygMNsL7rbm/B2AypFtk2ZxG35jmbogzG2ccGfG4Y6PSY
	 GD0knowrUdnqGJP67zEwhGk/I0/rIrTdOlM92MEDlucvC+zYc6V0DlAxtidICjaB3Y5Ik
	 vrHQd3NgvZi2Ks/71Q6gisvDa/Jpq+isd0hNE+2bAYrevB3GX7Mk16QWKoEL1ymvabg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFH05gaM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAD606A332
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFH05gaM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540D51F000C4;
	Fri, 13 Nov 2026 22:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607455;
	bh=BScDCg5LCO/KNMAyfIlt4shKfCRH7eM7O4Hkw9v2sO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oFH05gaMxDj2vC3zuZTpY/qGuoAawRkG13P24NcEyrJjbMuCJhFjnxuCe1zjzkBk3
	 y2NWZw8K/Xq5uoQcKceWPm2gUDd/Wgy+gbk4v+lWArWApAyvOUJzFnhiyuHT91UTws
	 /I+sz/gw6F7jltJpZ1R6WJsXY99RA+H30jiUySGhdWyx3Rc1EA+WEHIAaMUG6jfMTa
	 V5mp1HZ7XnkcYo7vsC06tP3WI2tBNuwz3wi3LTYP3J4bkgBN8X0zJ8LlUEt5jHxvFq
	 vkFsH7f9+2AVxoevaOZ2aHXhLHePnPEKhrLKj94lJiMOUWXMJ0pp2W35SLJ8hdBmU+
	 4zVtsW1ma46IA==
Message-ID: <sashiko-outbox-213770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 16/26] perf pmu: Use generic hashmap for pmu aliases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-17-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:04:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] perf pmu: memory leak of alias on error paths in
  perf_pmu__new_alias() [1]
--

commit 728d5dacfc35f09b0b16561c8cccc0e78616532f
Author: Ian Rogers <irogers@google.com>

perf pmu: Use generic hashmap for pmu aliases

This commit converts perf_pmu::aliases to use a typed generic hashmap
declared with DECLARE_HASHMAP(pmu_aliases_map, ...) and updates alias
iterations to use hashmap__for_each().

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index a63fa0d9cfa59..cabc14260719d 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c

[ ... ]

> @@ -676,7 +676,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, =
const char *name,
>  		break;
> =20
>  	}
> -	hashmap__set(pmu->aliases, alias->name, alias, /*old_key=3D*/ NULL, &ol=
d_alias);
> +	hashmap__set(pmu->aliases, alias->name, alias, /*old_key=3D*/NULL, &old=
_alias);
>  	perf_pmu_free_alias(old_alias);
>  	return 0;
>  }

[Severity: Medium]
This problem wasn't introduced by this patch, but can perf_pmu__new_alias()
leak alias on its earlier error paths [1]?

tools/perf/util/pmu.c:perf_pmu__new_alias() {
	...
	alias =3D zalloc(sizeof(*alias));
	if (!alias)
		return -ENOMEM;
	...
	if (!ret && pe && pe->retirement_latency_max) {
		ret =3D parse_double(pe->retirement_latency_max, NULL,
				   &alias->retirement_latency_max);
	}
	if (ret)
		return ret;

	if (val_fd < 0) {
		alias->terms =3D strdup(val);
	} else {
		...
		ret =3D io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
		if (ret) {
			pr_err("Failed to read alias %s\n", name);
			return ret;
		}
	...
}

If parse_double() fails on any of the retirement latency fields or
io__getline() fails when reading the sysfs alias terms, the function
returns ret directly without freeing alias.

[1] https://sashiko.dev/#/bug/linux-11ab1439-acca-4a2e-9366-3dcd430baf6e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D16
