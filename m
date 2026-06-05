Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEB368299
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703763; cv=none; b=PrdZKg6TXo1xN4mQ+DvLKw2veR+y+xizD3DjFgNpgJUm+cHUgZuOURwEgcOWXPC2cDAPVQlEBZURL5ZsZZjWtxPk7QSI6qlIKH2AxJNO6TTNUJaZSWmdRciEQDvMCPHkSvZPrXD6RsaCDXpm09qf2GBE3UTATPErJv373v3rvuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703763; c=relaxed/simple;
	bh=n1kpgbWWLcl3Tm1MQwZGwQRay91ouBHw6apSIdWOo2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p3jGT0VGo7V6PmQ+gj6rNzweF7XkhxjEjvHSELdDntCq9KhyiKrxkIwoYNeGiOVZrppfxmEJtqzJgHC1os63b11CRyBuLwjGQYqS5/nWGYqEyCjqx8RqIviTf4LQwPqwdVt8FL66bHIDoIWuJJthUhOUJDNrlG9P0TzexmAk56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePANdH/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePANdH/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4411F00898;
	Fri,  5 Jun 2026 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703762;
	bh=wmAz6P0/f9SO2abhADHMc5QzuUu4VUyl0vUJJ7pFLCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ePANdH/rzonipnKGmogwtwNBCeM8XrBcEbH4Cfark5ceXufE1UjrA4sZt6la5mkoj
	 LcJZB44lD2iLX+q3MfgCx/cL6P64p4thwdq04Vpt3Qa7UijKmJ9HXe6SToBsu7AAoD
	 pL9bHPdG2VPRvMbEZFfycuRghVljVkhyllWTwy6gaN+seLBhl4V+Jonp6fMfhuiYGT
	 NOtTp4Yc6iIFo4kJXP9kW/thZf3yOvcYYuZBiDyB9exu4YwdehavEh2Uq3XAYgF8OD
	 CIQgJYU1yYH4P1C41enEG+8UrWg++c1WsAGHHtbA8klkQQTzLW5nh23r+zY0PlhYYN
	 Vw0mqdaJj599Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] perf sched: Fix thread reference leak in idle hist
 processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605233837.1773732-8-acme@kernel.org>
References: <20260605233837.1773732-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:56:01 +0000
Message-Id: <20260605235602.2A4411F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unchecked reallocarray failure leads to out-of-bounds array wr=
ite.
--

commit d067b628e210dabba51b3b303c2790b28507f63f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Fix thread reference leak in idle hist processing

This commit resolves a thread reference leak in timehist_sched_change_event=
()
by properly releasing the acquired thread reference using thread__zput() be=
fore
clearing the pointer during idle history processing.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 4600d70b48610..c0cd3cbb602aa 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2940,7 +2940,7 @@ static int timehist_sched_change_event(const struct=
 perf_tool *tool,
>  			if (itr->cursor.nr)
>  				callchain_append(&itr->callchain, &itr->cursor, t - tprev);
> =20
> -			itr->last_thread =3D NULL;
> +			thread__zput(itr->last_thread);
>  		}
> =20
>  		if (!sched->summary_only)

[Severity: Critical]
This isn't a bug introduced by this patch, but I noticed a potential
regression in a different file:
tools/perf/util/drm_pmu.c:for_each_drm_fdinfo_in_dir().

When expanding the minor device array:

		if (minors->minors_num =3D=3D minors->minors_len) {
			unsigned int *tmp =3D reallocarray(minors->minors, minors->minors_len + =
4,
							 sizeof(unsigned int));

			if (tmp) {
				minors->minors =3D tmp;
				minors->minors_len +=3D 4;
			}
		}
		minors->minors[minors->minors_num++] =3D minor;

If reallocarray() fails (e.g., due to memory exhaustion), it returns a null
pointer and the array's capacity (minors_len) is not updated.

However, the code proceeds unconditionally to write the minor into
minors->minors[minors->minors_num++].

Could this cause a null pointer dereference on the first allocation failure?

Furthermore, because minors_num is incremented without minors_len
increasing, would subsequent loops bypass the minors_num =3D=3D minors_len
check completely, leading to continuous and unbounded out-of-bounds heap
writes for each new file descriptor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605233837.1773=
732-1-acme@kernel.org?part=3D7
