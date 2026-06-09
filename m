Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903325B0B0
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968133; cv=none; b=Y9VaaXtUk3On+TzPx9tNhtobuB9u3bhR555yyU29G/guDRKGqE04OiaUBPd82CT9pYlyRP3lZGHjgVDOXm/NSqYZf1uKYyW0pL12LESgKQUGmdehuooxWUE824jQ4LwHuU9lhmtqCswB+L1pEqxXkiEb5Re1RiETyOKySt3SAHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968133; c=relaxed/simple;
	bh=+PyTdqcot7+G7mrcceVxHpY4UBO5m5rz8kc0CdsH8dc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ga9NyWi6CYpw2OsexOkpL4XPLSz2kg0uSAbZM6aNmDqWzZkj92Zrbmz0p0LkAMAb9oVMSOlyNESoFbMW0VoUu+mWwLBHkN15oKnm+aMOAw/84Bwgt54iF2UWrwi787rgMOnfdaNIDald+F4Jo4CpSw56PTtjF/d7TUEzKD72tfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdQhTEDQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdQhTEDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2BA1F00899;
	Tue,  9 Jun 2026 01:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780968132;
	bh=ydyXi4uvFPbYTm/X5cxljUpP8wPUtaJs1caSEg+WPEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdQhTEDQoS4gNcN/0cKZ5WJcVWx+rHxIDTrZz85B3xO4ZDAUUXZchWm2PjMvtKOR0
	 XyJ+uM/dVJ3xeqh/NoPxL8RjP9WnQj8MaleToyLUvB26VPcfa+vW/wWdIadBZp9YHe
	 GwVDddHZs5jKRAWV/GxuX7fzcyVcLerrQUFxoRc3yRao0LTghAdPtVRJpqcP/cpCEo
	 1LGcUeidSoNKK/Wf0IUGaOSlCInboijvpAuvuA+n4cqnMo7SEKYK6LwLPUpzGfZ/is
	 WGUbjn+XBDWNYTj7pTBWBj44iCzQg1F1QInCfB3HPk7a8bOnrSpWqTBttioUR+jHdc
	 YZajMDi1y+/pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] perf tools: Use perf_env__get_cpu_topology() in
 machine__resolve()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609010526.1998472-4-acme@kernel.org>
References: <20260609010526.1998472-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:22:11 +0000
Message-Id: <20260609012212.0A2BA1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read on the global `symbol_conf.parallelism_filter` =
bitmap due to unclamped `al->parallelism`.
--

commit 02d9d799b673cb65dd2a323c5686a0235ee2e563
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use perf_env__get_cpu_topology() in machine__resolve()

This commit fixes an out-of-bounds heap read in machine__resolve() by prope=
rly
validating al->cpu against env->nr_cpus_avail before accessing the CPU
topology. It also adds a bounds check before casting to struct perf_cpu to
prevent silent truncation on large CPU values.

> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
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
> +			if (topo)
> +				al->socket =3D topo->socket_id;
> +		}
>  	}
> =20
>  	/* Account for possible out-of-order switch events. */
>  	al->parallelism =3D max(1, min(machine->parallelism, machine__nr_cpus_a=
vail(machine)));
>  	if (test_bit(al->parallelism, symbol_conf.parallelism_filter))

[Severity: High]
This is a pre-existing issue, but does this test_bit() allow an out-of-boun=
ds
read on the global symbol_conf.parallelism_filter bitmap?

Since al->parallelism is computed using machine__nr_cpus_avail(machine),
which depends on the HEADER_NRCPUS value in the perf.data file, a crafted
file could specify an extremely large number of CPUs.

If numerous PERF_RECORD_SWITCH events artificially inflate
machine->parallelism, the unclamped al->parallelism value could far exceed
the bounds of symbol_conf.parallelism_filter, which is statically sized to
MAX_NR_CPUS + 1 bits (typically 4097 bits).

Could reading so far beyond the mapped boundaries of the global symbol_conf
structure cause a segmentation fault when parsing an untrusted file?

>  		al->filtered |=3D (1 << HIST_FILTER__PARALLELISM);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609010526.1998=
472-1-acme@kernel.org?part=3D3
