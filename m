Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768926;
	b=TZ7DrgYeRbcbIa2JHXOmzrGWOWo6HAxv6mXIbyePt3hNtzZwmyhFJOYMpkwhYfaOR6v0
	 TROPGpQl5lXpi0WmIQ59nWiufdoGMyrVPWW3LQZHAAJpXngUvhhICfa4y85cizUK0YWqB
	 ZMnKG3kaiIvexuV5fsGl3U3rvcML54McZGCuuCqTVUY5WOXNd/sB5cngOxqNr5wwzw4EC
	 2CUYLLPKf7BaflQ2hz4rcv96p5hlV2A6sj/m5KxUcBzeaQUaxS/qtP5N4C2GjU4vyAF3G
	 qnki7/XTvyVd4M/F/oSDnzndwpAgb0J8gh+CmAJzwDSWR5cFeA/aOsFWZ2UBS5EMxcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768926;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+KkS+mMwOMss5q65HV7RLZ77NWh0C4W+UGBWvRx5kWQ=;
	b=bWICU/X7kMHpIwnY+tg48EGO2m5ozD1PcfrDsbrJPAEk5BDoOGpBKoULG5FGjAsVh+pb
	 LvRDdj61oRDYdc60+QijGDOz6iP67UJK8zMpPHgu5kf5I94qfDBhyFSjOR+TbceHwT+Bm
	 YuHzehptB9Qj9CqmsWy29hfW8mCzGrEilsfHaNJeRE9aGXxeCvpzZoFoWtxYib0UIFo7a
	 sMF4Fqyurcv1q2iXwoHsbGDcrTDSLBbt7LMLgO+Lf+wTHS7lKC7Iidfb4yoAIb7Ey58KG
	 9FXUPjXsdTO7uC53+yjFFMaxrWHlwSDElcvMy2ogavbOmPbtjSJHofElLnsFWWowPdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SviuXrjp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977F606A337
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SviuXrjp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A833A1F000C1;
	Wed,  4 Nov 2026 05:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793768925;
	bh=+KkS+mMwOMss5q65HV7RLZ77NWh0C4W+UGBWvRx5kWQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SviuXrjph5rZwr9O6tcLbxPaFqUlTM/wqDonRzbRCGOqnkE8Jx8VThwlmQt/b823B
	 jeJ6VXj/DUHWbNDFWHKbohbOakhno8ouRhnf6ZqZMDgDVRRi8CwkPXCC5DQB1sGTRt
	 gMZbYM0A9RvHI5YUyyGLGfRVVhgG5HuYapok57SalxaYR8AGCOBmt4wjWc+akzTApe
	 S8j9WAR9WPiwmyU59DzLNiu0QTNnWq9t+Z1Bx10EoV0snc/GmY9V+kh+39danj5msI
	 JH7LlWgODvQijlyBFVBUeCReYw3UOj1e8wrlKLzUp5y3AQML3tAWUx0xwuhYOnuayc
	 PMUa42wL3/3PQ==
Message-ID: <sashiko-outbox-196667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 26/41] perf pmus: Expose duplicate uncore PMU
 scanning helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-27-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 05:08:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf pmus: core PMUs deduplicated in perf_pmu__num_duplicates()
--

commit fc95f9db4dada04fd07609d248553e615737f338
Author: Ian Rogers <irogers@google.com>

perf pmus: Expose duplicate uncore PMU scanning helpers

This commit exports perf_pmus__scan_skip_duplicates() and introduces
perf_pmu__num_duplicates() to count numbered PMU instances sharing a common
prefix so subcommands like perf sysinfo can collapse duplicate uncore PMUs
and report their instance count.

> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 908959abbd3da..aa088c9c9aec4 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -484,7 +484,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(st=
ruct perf_pmus *pmus,
>  	return NULL;
>  }
> =20
> -static struct perf_pmu *
> +struct perf_pmu *
>  perf_pmus__scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu =
*pmu)
>  {
>  	bool use_core_pmus =3D !pmu || pmu->is_core;
> @@ -522,6 +522,29 @@ perf_pmus__scan_skip_duplicates(struct perf_pmus *pm=
us, struct perf_pmu *pmu)
>  	return NULL;
>  }
> =20
> +size_t perf_pmu__num_duplicates(const struct perf_pmu *pmu)
> +{
> +	const struct list_head *head;
> +	const struct perf_pmu *pos =3D pmu;
> +	size_t base_len;
> +	size_t count =3D 1;
> +
> +	if (!pmu || !pmu->pmus)
> +		return 1;
> +
> +	head =3D pmu->is_core ? &pmu->pmus->core_pmus : &pmu->pmus->other_pmus;
> +	base_len =3D pmu_name_len_no_suffix(pmu->name ?: "");
> +	list_for_each_entry_continue(pos, head, list) {
> +		size_t pos_len =3D pmu_name_len_no_suffix(pos->name ?: "");
> +
> +		if (pos_len !=3D base_len ||
> +		    strncmp(pmu->name ?: "", pos->name ?: "", base_len))
> +			break;
> +		count++;
> +	}
> +	return count;
> +}

[Severity: Medium]
Should perf_pmu__num_duplicates() and perf_pmus__scan_skip_duplicates() avo=
id
stripping suffixes and collapsing entries when pmu->is_core is true?

On heterogeneous ARM systems (such as those with armv8_cortex_a53 and
armv8_cortex_a57, or armv8_pmuv3_0 and armv8_pmuv3_1 in pmus->core_pmus),
pmu_name_len_no_suffix() strips trailing decimal suffixes and hex suffixes
longer than two characters.

In tools/perf/util/pmu.c, pmu_deduped_name_len() explicitly avoids stripping
suffixes for core PMUs:

tools/perf/util/pmu.c:pmu_deduped_name_len() {
	return skip_duplicate_pmus && !pmu->is_core
		? pmu_name_len_no_suffix(name)
		: strlen(name);
}

Because perf_pmus__scan_skip_duplicates() strips suffixes while iterating
pmus->core_pmus:

tools/perf/util/pmus.c:perf_pmus__scan_skip_duplicates() {
	...
	if (use_core_pmus) {
		list_for_each_entry_continue(pmu, &pmus->core_pmus, list) {
			int pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?: "");

			if (last_pmu_name_len =3D=3D pmu_name_len &&
			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
				continue;

			return pmu;
		}
	...
}

and perf_pmu__num_duplicates() walks pmus->core_pmus using
pmu_name_len_no_suffix() instead of returning 1 when pmu->is_core is true,
won't distinct heterogeneous core PMUs sharing a prefix like armv8_cortex or
armv8_pmuv3 be collapsed and counted as duplicates of the first core PMU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D26
