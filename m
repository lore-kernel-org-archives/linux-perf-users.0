Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA33DB32B
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560074; cv=none; b=JvVQ9TmDHZxxWLUZcVsN5eEc2Zr9lR1P2FHiCi4VT90h2lpFsjBgGy8pRcrOgGXIqEJOs5E7o/UFwp1b8qaSiRs3FD6I2FnTmJC8OOsmLknCyWmreDvZQscvR0YWCruZ60BTFtcBEJ9V83PvTB2Msw8/dC6r8vWnLOaEK7oMTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560074; c=relaxed/simple;
	bh=2zufNHMU+QG2XDMLvtMKK1cq+T4nR1CBmReUnb4BPOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NuwxEF68jGt5R/bJ0sFhM3KgQ30zkki0nqOc+Ld46AOvK++Tk8bWVWgEfPOx8zxpJ3QWkZ1knnvriI9P13E9eKgEaNGycxP7sSRBbRjMMRaxG0rN4IJVJ5tQhB3XuRnGKmiV+LALiDJ+KIfoQLaowXoBFICHMHevfU6vTcVKRyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSDAF8V8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSDAF8V8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2293C1F00893;
	Wed, 16 Sep 2026 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560063;
	bh=wFLb8PTHP1B2bubT0hxb1f9MRytSxVi3NjQq8dG7Nww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSDAF8V8Q51ylnZ5KJZrkWG5sy3LEirabOZbSmElUwI4+m5iMuuQ9Ufe13JxvHjEf
	 JHEwOncMtP+N0lPdQ3jzG5uYWOqCEQejF2SmEKKliRb/u30pZf4TANk4KZPnH93uuG
	 O8IKNredLqLwtNHW+CdQn2c+E8wyj5pHGjm4SYKdcPEPyPMtYzu0zbtrnrr0ZsZFbS
	 LHac79SZcTIZhb9bWEcZ5PTwNy4Od25/0lFWBCf99D2KjySrU69GnbDhpxU/wyT5q8
	 5ZmRe2BhgYQhT8bD/gdH8zyVFM7fFqCGJySe593X+WXeLKOWOW8y1y/FCCVpKWry5o
	 Z0HC/BXgupmOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] perf annotate-data: Resolve type DIEs in the
 debug file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-11-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:01:02 +0000
Message-Id: <20260916120103.2293C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A 'perf report -s type' on a 783 MB AMD IBS data type profiling session
> hangs, burning all of a CPU and producing no output:
>=20
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf report --progress -s type=
 -i perf.data.ibs > /dev/null
>   Processing events... [100.0%] 746M / 746M
>   Merging related events... [ 58.0%] 293828 / 506686
>   Merging related events... [ 59.0%] 298894 / 506686
>   Merging related events... [ 60.0%] 303960 / 506686
>   Merging related events... [ 61.0%] 309026 / 506686
>   [ ... nothing else, ever ... ]
>=20
> It is a spin and not a slow path: with perf-stuck the CPU time used
> grows by a whole interval on every sample, while the [stack] mapping,
> [ ... ]
>=20
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D10

