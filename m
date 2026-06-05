Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C235DA7F
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703750; cv=none; b=oZjoRxKcpfVnMmKqqTilxfU/ztldG6Ukvo3B/PKI9GdXPfxXCgmAK3mJtaPZ1uDVJsxVD02N7VW2J6YVBOWwgDzJaL+IifarmygjzibgHCgPsTNJ9aUP4vzL8ZGsCvnqWOISFLS/HRI54iLHFHijkExWmdoshqASP8zy79FC/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703750; c=relaxed/simple;
	bh=NK18kB0fiB8udz8Rq4ylCrc64naX/62Lv+qOhMn4xTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mDBZu0dcRNSRt0Amad0Z7lOH4woWyA4LptFf5WYawTnWJEshi3xdSkOnq1F+XEqhhKfGsS0R1Yx6ieIvVHrOeKHXr/sCxH0xP8JdwQlUq69I1hIDyiJd+TnYPYp7vIhJ4qz62I0wIfqRDMmmdfrWyUzVKz1WSKH2ipV7ryg5fDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdHjjhIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdHjjhIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7337F1F00893;
	Fri,  5 Jun 2026 23:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703749;
	bh=vCAf3O4FoEi565xEyptgkaTX4+AMB+/DVXHaCANAMRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdHjjhICD41gEdB597ZN1qR8HL7hmx1R1cFIc1Tq8ZUaSp8tXKZRZHdzg7BPua2bx
	 7Y5HmSLLeRCYdOPXjgY12A+zFM1nQMEBSrzEMBPHHNNt7qfCEqhP4BP8hdZsc2so6G
	 TzdHzq1WLsuDZk32CFWzH4Y0E1fm08H2fZURZLy0X2UW87Uk9Fcdln842wJ+m8Tp0u
	 ZegOmWkwiK2dhuadR7Jv6kjD7ViWXGBwpqAObGXVm1yddEhY9MjjzMfuEucp2tqxLu
	 cE6dka/Jjb+q5WPJQtF2IAppmqp17XX79lxy15xvK9Zd7zwZA7N8Up49N0hbQV7258
	 pod/iwTj4uDgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] perf stat: Bounds-check CPU index in topology
 aggregation callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605233837.1773732-3-acme@kernel.org>
References: <20260605233837.1773732-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:55:49 +0000
Message-Id: <20260605235549.7337F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete bounds-check fix: Missing NULL pointer check before acc=
essing `env->cpu` array in `perf_env__get_*_aggr_by_cpu` callbacks.
- [High] Out-of-bounds heap read due to unvalidated `sample->cpu` index in =
`perf_event__preprocess_sample()`.
--

commit ebd8bf34de713904cef201f9c6fa2181cf91d727
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf stat: Bounds-check CPU index in topology aggregation callbacks

This commit updates six perf_env__get_*_aggr_by_cpu() functions to properly
bounds-check the CPU index against env->nr_cpus_avail. This prevents
out-of-bounds heap reads when processing untrusted perf.data files.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1638,7 +1638,8 @@ static struct aggr_cpu_id perf_env__get_socket_aggr=
_by_cpu(struct perf_cpu cpu,
>  	struct perf_env *env =3D data;
>  	struct aggr_cpu_id id =3D aggr_cpu_id__empty();
> =20
> -	if (cpu.cpu !=3D -1)
> +	/* env->cpu[] has env->nr_cpus_avail entries; reject untrusted indices =
*/
> +	if (cpu.cpu >=3D 0 && cpu.cpu < env->nr_cpus_avail)
>  		id.socket =3D env->cpu[cpu.cpu].socket_id;

[Severity: High]
This is a pre-existing issue, but is it possible for env->cpu to be NULL
here while env->nr_cpus_avail is greater than zero?

When parsing an older perf.data file, process_cpu_topology() can free
env->cpu while leaving env->nr_cpus_avail populated.

If this occurs, the bounds check cpu.cpu < env->nr_cpus_avail would pass,
but accessing env->cpu[cpu.cpu] would result in a NULL pointer dereference.
Does this code need an additional check to ensure env->cpu is not NULL?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while looking at CPU index
bounds checking, is there a similar missing upper-bound check in
perf_event__preprocess_sample()?

In tools/perf/util/event.c:perf_event__preprocess_sample(), the untrusted
sample->cpu value is checked for negative values, but does not appear to be
checked against env->nr_cpus_avail before accessing the env->cpu array:

    if (al->cpu >=3D 0)
        al->socket =3D env->cpu[al->cpu].socket_id;

Could a large positive value for al->cpu bypass this check and cause an
out-of-bounds heap read from the env->cpu array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605233837.1773=
732-1-acme@kernel.org?part=3D2
