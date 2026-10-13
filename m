Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7C489FC4
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913071; cv=none; b=s7Psj88TnDUYCL+p35X+VcI7I6TeFLzo5Gwtl/fhyb02Rlb3OEZZPD1NM2gtDk4qV0Wln8E5ctGsxpAAyE0rdU9DXwmy8RT7i5DKJLnlP2/FnA1iefqzU8qEZsWoLRBPTd/xboJ1FfRVRCcNc2SzCFbUjUXrIqpZ/yxnSGXMEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913071; c=relaxed/simple;
	bh=uhdCd5Vl45iGRJO6YmSBiVys1ZBOSskknDt3hZs4Hk8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=D1F47vmVqtIf0iWJP0mSNfz1pX9jg/PmrELaT2q7OsVZ8P2pR5LPvzoLJkbeMhTDitM3xOMfTZVN3ynd0gfaJHgKEqF7twXF8GtNf5sAEWq/FykNnhO633CD6X0F07rjw8pYEiXiKm0vcrPaiM+LvQUI7RvBMCQd1rliOmyPqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re89w1ZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re89w1ZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2065A1F000FF;
	Tue, 13 Oct 2026 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791913070;
	bh=Ck36cCH5KtEuJ31DV7KRWeTyKNivSWI8bm6l9M0eDAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Re89w1ZDyEzR4xPOLeiVnujXE4X9f7b+AP4oOjEphe891M9APEMtZ4V5SQ+ty0CQH
	 NsfomDVaoPCAl4RyDTMQJp+v6Ltw+hZ8Wk3rdabAWAdgvavuUH2MTBtJYYhn8s/47E
	 yfeSmIg2IGT/yhAY6S0+B5sKdg5l9opNJWPJSKYpUydLeqzynJ74/561avMan81xCo
	 RG5oe5wYFCKpdR11/9yEucQdC6AfmxVUb7oOCBa6QoEe20O4ZgPxSuxlpY9JdkHZP2
	 t+5N/nOqBQWP/t93Kv1ttJtqOhd/G8bR+x12IHCSnyBi0T/RiRjIl/8YdZYwBFT7/S
	 SLnUCGNatviFQ==
Message-ID: <sashiko-outbox-170240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/11] perf symbol: Get rid of
 machine_or_dso_e_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-7-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:37:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf symbol: NULL pointer dereference in dso__load() on error pa=
th
--

commit a7899d8622f5885c1647a9ddbd7a9ae67999aeeb
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Get rid of machine_or_dso_e_machine()

This commit removes the machine_or_dso_e_machine() fallback logic and relies
directly on perf_env__e_machine() for kernel maps. It aims to prevent
recursive locking issues and assumes kernel DSO architectures are correctly
described by the machine environment.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 56b8d75966133..a7afecb5816c2 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> @@ -1855,7 +1838,7 @@ int dso__load(struct dso *dso, struct map *map)
>  			ret =3D dso__load_guest_kernel_sym(dso, map);
> =20
>  		machine =3D maps__machine(map__kmaps(map));
> -		if (machine && machine_or_dso_e_machine(machine, dso) =3D=3D EM_X86_64)
> +		if (perf_env__e_machine(machine->env, /*e_flags=3D*/NULL) =3D=3D EM_X8=
6_64)

[Severity: Medium]
Does this code cause a NULL pointer dereference if machine is NULL?

By removing the machine pointer guard, if map__kmaps() returns NULL (for
example, if a kernel DSO is incorrectly associated with a non-kernel map fr=
om a
malformed perf.data file), maps__machine() will also return NULL. Passing
machine->env directly to perf_env__e_machine() in this state will then trig=
ger
a segfault.

Could the machine check be restored before attempting to read its environme=
nt?

>  			machine__map_x86_64_entry_trampolines(machine, dso);
>  		goto out;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D6
