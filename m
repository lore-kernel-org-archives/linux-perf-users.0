Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD2346FCA
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111459; cv=none; b=PDa8IHi083iw/xBJVdHAuajTuoSPDwp0c1AW6NJ8lk0OBKJO5lSZ4H2ZQCqVt9i7nPfO9bQXKFfvLdbtrZEdJ+ZfIwkWpAbANXOcNkahm4PxOPfikyukH3L0npVm1oOuGJ4lx9V0nfgCSSLtRVl/R3qYJISWx091Zog/VB2qNrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111459; c=relaxed/simple;
	bh=iTeFL0F8vtf4xVFtOAML8dwqUyFmZzbx5AmQqbdq6ZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bf6W5dQwymEUPMX4molCGiAbUy6WE21TViVCy9IWWFbyM2wypgwkUeO7M4Faellr0Z4pzg3E1rUr+JOF3Z9kNph3GS5znjmbXMH2bWIoTsFxgSr+DECFibtXTjaD84eRnmSUt7ap428B9HqxIH/n4IaIr+PkwD23wpeZUg7P/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhaHfMiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhaHfMiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F1A1F00893;
	Wed, 10 Jun 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111458;
	bh=QAxbqxXj+poenkhaaxS3jxHoIwfdvTjy5yX4mmz8vVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FhaHfMiXBrBRarSNdZ9AZrDC1feOzxbxFw3FBY+z4ADEm85qE6cUyG4/bHJkvZEHe
	 crG3KGvkINfjlkdB3kklw8fpWE96o7yI2artx803s7L0HUwCPZlIDMHYVIOVDeIfxc
	 ka1rJi2zTlwcjUQSWilkn4oy5F7rJaTEf+M2+tljEVt41wz9KevWjViwpXER/SLi7W
	 RatKtsmLjZmvePBgVBHveZO5OtSkqZptHqRejvUeeZJRr3mOt1qhvOy16LbUZemsba
	 9sFOHWiiS3Y1tx9cVD5wsuj6rm1YsRopURgn1WGyd+8lBVTbWQ3M8M/towSBRUh3EF
	 ZSpOZCmzBlqSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] perf sched: Fix idle-hist callchain display using
 wrong rb_first variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610165207.2077258-7-acme@kernel.org>
References: <20260610165207.2077258-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:10:57 +0000
Message-Id: <20260610171057.E9F1A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The bounds check in `machine__resolve` fails to prevent `s32 al-=
>cpu` from truncating to `int16_t` for large CPU values, leading to silent =
topology resolution errors for systems with >=3D 32768 CPUs.
--

commit c3733692a65101be8730c41702471672bacd7115
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use perf_env__get_cpu_topology() in machine__resolve()

This commit modifies machine__resolve() to retrieve CPU socket IDs using
perf_env__get_cpu_topology() instead of direct array access. It adds a
bounds check against env->nr_cpus_avail to prevent out-of-bounds heap
reads before casting the CPU index to a struct perf_cpu.

> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 66f4843bb235d..ea75816d126a1 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
[ ... ]
> @@ -836,8 +837,18 @@ int machine__resolve(struct machine *machine, struct=
 addr_location *al,
>  	if (al->cpu >=3D 0) {
>  		struct perf_env *env =3D machine->env;
> =20
> -		if (env && env->cpu)
> -			al->socket =3D env->cpu[al->cpu].socket_id;
> +		/*
> +		 * Bounds-check al->cpu (s32) before casting to struct perf_cpu
> +		 * (int16_t): without this, e.g. 65536 truncates to 0 and silently
> +		 * returns CPU 0's topology.  Can go once perf_cpu.cpu is widened.
> +		 */
> +		if (env && al->cpu < env->nr_cpus_avail) {
> +			struct cpu_topology_map *topo;
> +
> +			topo =3D perf_env__get_cpu_topology(env, (struct perf_cpu){ al->cpu }=
);

[Severity: Medium]
Will this still truncate to int16_t if env->nr_cpus_avail is larger than 32=
767?

Since env->nr_cpus_avail can legally be up to 1,048,576, the check
al->cpu < env->nr_cpus_avail evaluates to true for CPU values like 65536.
When cast to struct perf_cpu, which wraps an int16_t, 65536 wraps to 0 and
silently fetches the topology for CPU 0 instead of the requested CPU.

For CPUs between 32768 and 65535, the cast results in a negative number,
causing perf_env__get_cpu_topology() to return NULL.

Prior to this patch, env->cpu[al->cpu] successfully handled large CPU indic=
es.
Does this code introduce a functional regression on high-core-count systems
or when parsing perf.data files with a large nr_cpus_avail?

> +			if (topo)
> +				al->socket =3D topo->socket_id;
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165207.2077=
258-1-acme@kernel.org?part=3D6
