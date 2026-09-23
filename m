Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D73F20ED
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187850; cv=none; b=jzah3wh/yLliR8fvqjR7pOFNAFxRDIxRMngZ7ayEN1fqvpNOxRmqAiv6oZQ4B923xnn+ujbZrIIyNjnXdhxRIBIRNVmb6ynlrhO0O0UJo/FpRGInX4KyCxaK2W49MWXvqQM90cpicdbWF2LcvoGwHQXl3+aEJ6qGCGxyNV4PdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187850; c=relaxed/simple;
	bh=6A0cqHTmRXOgwXaf41nZIZ6JV3j8Sy7wSBVsMrVOEgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nZp7l7YZoySeo4SHvCIQklkggqDy0/hBdOhSXIoJe1J+njFFXuhrEGEu4tIpOxjQiNOBXE/eDjYosCC2GsiRXazIzESsmXZ6lPIXgczxgjjCLawF/7EhmkKYS0KUQWWTF7ZwhkNwGyHPvw5mIXCZVEAgxJGJJthejkK/UcDiH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWNcPBEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWNcPBEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F382A1F000FF;
	Wed, 23 Sep 2026 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187849;
	bh=VngPdLsSlkAVTS6vOX9xW9oEDz3D3tIRYG2QJ2qCvug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWNcPBEGGbQGCYDs/2zzfYVipt0jRjWRRlHofpETORcnt+6KhkrxIlHIMmtx5pppl
	 0Xaa/S8Pg52QPB318lo8s+T55m1x/S0uEYby3Zr14OQyqs+kt+IUfd8rumSI5RfwLv
	 QppdiIYpw7QzAT0aMrUim4WP2D7jfU/Kz4m00QbwxJAVFa4tDSG/EH2z4+8t2V2EIQ
	 Id6S9RE+9iODoRk3yDFcVGR+DZviuiIM9fCzbEydwZ40MoKoRBc0jzMuUHOIWBJGr4
	 kaUPKYRwm3PDrgHYGRKlGj/cp9l9pvv2ayjz5qHeWhDDHOWszFWV1z2+vFXyhwJm5q
	 ZT24TsF/d8JWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/49] perf pmu-events: Clean up mypy and pylint
 issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-12-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:24:08 +0000
Message-Id: <20260923182408.F382A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up mypy type errors and pylint warnings across the pmu-events Python
> scripts (amd_metrics.py, intel_metrics.py, jevents.py,
> make_legacy_cache.py,
> and metric.py) in preparation for making MYPY and PYLINT build tests
> opt-out.
>=20
> In addition to type annotations and unused import/variable cleanups, fix
> three bugs in intel_metrics.py exposed by static analysis:
> - Fix references to undefined 'args.model' (instead of '_args.model')
>   inside
>   try/except blocks in IntelL2() and UncoreMemBw(), which previously threw
>   NameError and silently disabled Skylake/CascadeLake L2 silent eviction
>   adjustments and uncore memory bandwidth JSON loading.
> - Define DC_WB_U and DC_WB_D before their first use in IntelL2(), fixing
>   an UnboundLocalError that silently dropped the l2_out_rate, wbn, and isd
>   metrics.
> - Fix Event-to-string comparison and addition in IntelFp() by comparing
>   and modifying 'f_assist.name' instead of the Event object 'f_assist'.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D11

