Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B22E717B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782279270; cv=none; b=aPExYkI9chie8rKuG4B6PuWx4NZxsLnUrO/ZkSSXK6h03yolnG1vTKmkuQpHyJLnyymAABiLuYKkeWXohTNgCBFq5pTKyy3Tvj2QRUrhHN2PN765jYFhQThVyBH5mxhmnRct4TtGzHQ+GPea0HdOPTjd1SyIxgLLmQxuTdzUXR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782279270; c=relaxed/simple;
	bh=XULONmds4WD+0h8bjqbS1gJnBoCXYQ1EhFsS9Fb/0II=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mS4HvfiYt96+FHrZ6PUncdbZgAiq67ITbhWcF9N6Z0XPk05D79wH3L+9LNlQO+89Z+bIoUqF0cQoDmnB9gTe/DR9O0BURX3PCiBaixd2ZgiwkxzgGqITsokyj5njy4SMJN/G0HSID7ddpnDAF7yrwCqGa7KGxWK+0+0rGPk0cQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ8fFwvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ8fFwvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FA01F000E9;
	Wed, 24 Jun 2026 05:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782279269;
	bh=s1AdNrMURQzfSJGGb8is7wqgJfgEzjDK5QoXO4q1COU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZ8fFwvgfbx7SzIYn2OeSu3k+Pzt0uED2oU+2Jzs5dutt1FNLcJI2eN6Xlae+J6u8
	 PuQ4g1fmmWQ5OMv7LVD/0ASVym4Kl9KzqPXXgVyM9kvb1Ar/477oePsrFwh354t5P9
	 1vZXg1KLMJfHbunQHFuBnGuWjAowyX4cw9rDX/gYf5Kx9q7RQjh/eB8hUUiKm/RubZ
	 OZQnBBj3lzBZtoj0gcP9CE2JQgnfpHYKVk9oHm/H+FjLog1hvTcxxeAO7k8c1G23lj
	 u4KDSV1NHF+ba97YeC2YcQlDOPko/lqr8yiSFrMyIpq/+jV0AusVHLx9pRHPfMuehZ
	 LbULB7wAfRGkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/16] perf python: Add thread and PMU uninitialized
 checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624051535.3584977-14-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <20260624051535.3584977-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 05:34:28 +0000
Message-Id: <20260624053428.D1FA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added CHECK_INITIALIZED macro in pyrf_pmu__events() le=
aks the py_list object when the pmu is not initialized.
--

commit 579d96b72f035d8f31919edd0270e2cfa16975d3
Author: Ian Rogers <irogers@google.com>

perf python: Add thread and PMU uninitialized checks

Add CHECK_INITIALIZED checks to the thread attribute getters
(get_pid, get_tid, get_ppid) to prevent crashes if they are accessed
before being properly initialized.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 71be130b38c53..b17b191b16255 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1730,6 +1731,8 @@ static PyObject *pyrf_pmu__events(PyObject *self)
>  	PyObject *py_list =3D PyList_New(0);
>  	int ret;
> =20
> +	CHECK_INITIALIZED(ppmu->pmu, "pmu");
> +

[Severity: Medium]
If ppmu->pmu is uninitialized, won't this newly added check return early
and leak the py_list object allocated just above it?

Would it make sense to move the CHECK_INITIALIZED() macro before the
PyList_New(0) allocation?

>  	if (!py_list)
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624051535.3584=
977-1-irogers@google.com?part=3D12
