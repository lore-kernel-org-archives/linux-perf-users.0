Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E82F619D
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111428; cv=none; b=HSsABCKSzKNISA4Q9xPdWzOPll145G7nkv6anWYbcwMJvSKyrxwYvDnBEbs6nMd2EK/Axohdzr3Efubn5an8mzTtOgTiFos0dxhP047ZkrNRXkj8TqDMTRy+xV1J3odQHfTpgVMLsbSCGjNGZNjl5PEDbYeArgsJgolAo0XGJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111428; c=relaxed/simple;
	bh=+IcV3X+MH9eeN65b1V9l6HAMaO+TjjIPJNgtBlF18Rc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nadlg5fsDbebfGpBCFBcBfFxYlvjUrT3GQv5rp/a+CWH9SukQeuAXYwx4Nv+/GHPVa8i8yHD62oY+K6Z/F8aycUrC+cggHaKgnvhv6j6Khi737fSLVcnApq4bVwkw4wI1jRi8+IXD5jHFDmeF2JtbRAjXeRtg1pgnny1E685Ycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBsp6+wj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBsp6+wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1095C1F00893;
	Wed, 10 Jun 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111427;
	bh=wIzisUhxh7S/tbhP3O3sqZXfW2QBy0VaM4XsVniMeQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jBsp6+wj391h+nb54QbJT0Wq2tagTWeidGCxsV/0DvD/Lunf+uuWG4DG5HtjRUU8P
	 swDWez3/aJKVul5AomD9x4SHYYbjmPX+3V1VKrMzwNwG2KtDSORSB19WJ7/ljpsqql
	 QBEY03NkxsyAE5oXPukaXIUXnlA3NFiSf8ztHbqGwJF06zlU0VoUY8emP4tqA2R04W
	 bH+4X/D0txjqSD86yNmJ3EqvpVxZj4/zsZTqwy9P2+d1h7Ujxmr5z/1jdSY/j8L0mH
	 gkaCDyaq7kSM/8ly+SSPoUCwPI8ZchDotMlZuW+YFmcZrly6GMC/vYVk6Eul0bXqlC
	 oek1gi5ezeKIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] perf tools: Use perf_env__get_cpu_topology() in
 machine__resolve()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610165207.2077258-4-acme@kernel.org>
References: <20260610165207.2077258-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:10:26 +0000
Message-Id: <20260610171027.1095C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The bounds check on `al->cpu` fails to prevent 16-bit integer tr=
uncation when `env->nr_cpus_avail` exceeds 32767, breaking topology resolut=
ion and bypassing the patch's stated fix.
--

commit c3733692a65101be8730c41702471672bacd7115
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use perf_env__get_cpu_topology() in machine__resolve()

This commit fixes an out-of-bounds heap read in machine__resolve() when a
perf.data sample contains a large CPU index. It replaces the unsafe array
access with perf_env__get_cpu_topology(), which performs bounds and NULL
validation. A bounds check is also added to attempt to prevent 16-bit integ=
er
truncation during the cast to struct perf_cpu.

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
Does this bounds check prevent truncation if env->nr_cpus_avail exceeds 327=
67?

If a perf.data file specifies a large nr_cpus_avail (for instance,=20
process_nrcpus() bounds it to 1,048,576), could a malicious al->cpu of 6553=
6=20
still pass this check? If so, wouldn't it cast to int16_t as 0 and silently
return CPU 0's topology, bypassing the fix?

Additionally, does this break valid topology resolution for CPUs >=3D 32768=
? A
valid al->cpu of 32768 would truncate to -32768, causing=20
perf_env__get_cpu_topology() to return NULL since it verifies cpu >=3D 0.

> +			if (topo)
> +				al->socket =3D topo->socket_id;
> +		}
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165207.2077=
258-1-acme@kernel.org?part=3D3
