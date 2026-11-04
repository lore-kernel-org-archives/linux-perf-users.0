Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766125;
	b=yA2u9LirOaMoEw9t/6hLsyk06ZzwUrHbA9mdVlQf/1llJMlz1uv8N1HDzP0uTWb2kq98
	 AtcyxZ1NNrbsghQMncaoRvQ/5lAa2LOFynzQ8LyO/Z01LBdnOLZXdb+Po7ycN+3UhZi0m
	 87cXkicFWUORh3PZCUksWXNzvZHlYiwBtAuH+ZbBykqesbYJzNeO0rRUsq3Lp/q8pQjUG
	 R1He4mOVuu5IFd+PdO34IUww7+Kfo0mzZC+4vZBftH4/VnGOLE3eu9rAhOob8SYedct1h
	 TwhI6uJwlkrZoVGnXPtT+PzToKh7v1iGrZzmQ0emZ8NjhA+IkX9lPcWkbQ0ec1REQkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766125;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7RbFcSAwVQ8Gs6qSIjoLoaNRdfB3dkTurDdyPHugFok=;
	b=ReosoW/YkHLEojPcjKpP5DlU48XDUGgaylOIwTJ4jjR3tyIOJ+UZ8gBTs+XbTBF5OSAM
	 4tum9Zn5VXESTeoMuKFMM9IjnmDQmB1hx1EBIsRftmvzM8T7uidPe3hsO3d6lXhAomFtl
	 7dsF6sRo9ei04vXNkZeCxhA6yrfDvE4B8lISoxBStfu1p7Fc664nSDAtPhuuvrGDOXtzy
	 vn0GFC10y/sIaHnJ9jFknewczUoNp117OldwW6uSRSr4ysaChTo4ZsHRPXMbSP7tRSZuh
	 7yFipfW+ifoFqbWmkQ7cf19Jq3fiGHLDh0so3kpNYj6MXTttFoXoxJ+R/o6hlGZmk4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qt3jHUNg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C2606A32D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qt3jHUNg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA5B1F0093A;
	Wed,  4 Nov 2026 04:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793766124;
	bh=7RbFcSAwVQ8Gs6qSIjoLoaNRdfB3dkTurDdyPHugFok=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Qt3jHUNgyFazKwmW4Kj/gzH0g+Fhz5rndr+DpIYBl4AxVzJqruWMvO61oW/PwAP2X
	 gCyvF5ozC/Hr7AnOvRWBVyNNgQx95Zc+j+c2QxwLyMps0TSkocEXVokl58VhrPTuoD
	 I89DdUYD1K9gXuBDqGyaciRM1/4sOYazIfY8eL1RMXfl+eshwwcpvfesj9GSzhQMAp
	 fnx4fd9KTzZfrBgoZ4UEcwRy7xjQALHE6ZdLpt3kPJnN2MsliJZAfzKwICAeZeY2zB
	 g35rnS1m9h9qEgQZFwQhulQypv5+Fpwd8asph3/kjoMf4rqBdjATZYudO/S1tk+W0v
	 oFtkLze0TdAvQ==
Message-ID: <sashiko-outbox-196650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 22/41] perf script: Don't drop metric samples for
 CPUs missing from the evsel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-23-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:22:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf script -F metric looks up the index of the sample's CPU in the
> evsel's CPU map and, when it isn't present, prints "Missing CPU map
> entry for CPU <n>" and ignores the sample. When the perf.data file
> doesn't record the CPUs of an event, as is the case for perf record,
> __perf_evlist__propagate_maps() sets the evsel's CPUs to the host's
> online CPUs. If a CPU is offline when perf script is run, or the
> perf.data file was recorded on a machine with more CPUs, then every
> sample on such a CPU is dropped from the metrics with a message, for
> example thousands of:
>=20
>   Missing CPU map entry for CPU 1
>=20
> perf script currently only supports global aggregation of the counts
> used for metrics, the counts of all CPUs are summed. So place the counts
> of a sample whose CPU isn't in the evsel's CPU map in the first CPU of
> the map, as was already done for samples without a CPU. This doesn't
> change the metric values computed for samples of the CPUs in the map,
> the summed counts just include the previously dropped samples, and so
> isn't a regression. Aggregating per CPU, and using the CPUs of the
> perf.data file's environment rather than the host's, would be future
> improvements.
>=20
> Fixes: 3622990efaab ("perf script: Change metric format to use json metri=
cs")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D22

