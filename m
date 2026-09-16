Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB33E3140
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584322; cv=none; b=o39kRdRw9qjLPWI1iQxwBw8JiVgLgbfN340CP/z+/h/K4U60DobXPdS05KIARQN6dsL3CeHQKqb3KseDsoWU9+RX/Ftc3kaEIf7OdNcaI4avne5k6qf6xyVIQzUGuwC8DIc9p3Ka8csRFsBy3aNCqWVEZsjsD5iuYPGw3canyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584322; c=relaxed/simple;
	bh=bubCCqIlXl6/2nXR83xBdCL+1Ica5B9gBmJlyXTpAk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u4jlnFvxw0F6TgWgUKANsRid3wYstVJgIRE9HRAOebUIx1q2AYyvkg52ltQlh+Cyw6EVVd1ErvhfK9entmUjizFe2vW1oLD3l5dY+XbVv+xWe6cHCC1M5bsYB/fBVJczVT4aMsVlUGdXLEFb8BQmYARlH44jIoM/c/aqsteP6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZMS+4t2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZMS+4t2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0201F00893;
	Wed, 16 Sep 2026 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584295;
	bh=avLYZ+ZnJUa2fu1BpSUjtmku3YfBrcKjcyrHMutuvgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZMS+4t2IBKxkjiqb2l4xXnZYJhkIqwzcdX0kdc9fLu9vzibuBIDseVIMEb0uFQlu
	 vVBPc0Yj8K3/kdqjWiH+6EDNcbH9DqJgCtAn8NWWWxJn4tJk6xRxszGbN5bH0/BlUy
	 cCPk79PxtiGwV6urZm6kP4/o7sMe6l+ZUVdKce9+eIlSzldxRH6+ztkiqm0QOn3BNs
	 TJp1WqbiICKVPk6DSWOqU/cMghcWe95uJDNYFqd/yqfNVmLQy3VAqCo95h2JaRnFmg
	 LqPp5mCtBKHu5LiVt0nAMX0D+Zguw8Ty9ZjvbuloWk5JyKFkD1KreXA+z+Pj+j+vRb
	 bvA7zeBgKatNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] perf annotate-data: Resolve type DIEs in the
 debug file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-11-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:44:54 +0000
Message-Id: <20260916184454.DF0201F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D10

