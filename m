Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706537A841
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008032; cv=none; b=tih6aWjMt9kRmHs4OMgfPOC9yRJs3kBeAAfDuRMqCQZTRao/uOexZTXusriudIWK6PFrLk3UFpXiLpCbBMlfOGOqlfJYAFA/p3QkDvTEf7Pfd+uIO4OcnhAMub9gDDGcI8Bb16A9OPUrUF+DoC0tMfIl4l8cT0PGgoNNJQgQdJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008032; c=relaxed/simple;
	bh=yavp+Qp9wv9SjhY6RxZ0txdKW+9dHX/o9YkVk92anbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dLeTiM99ck/a0eoEZLTwlOxzr3GbffWo2UhGpBvXAO2GBEfBgGyRxOg6KP3aVU3MRN+n0LcWqvbNpLf3NfXtb5CatYOkf9gLbyyagw8QeS41uhFhKBeZFhJQhFTlfiCt9/SWOYx6y3jA9l4io7IDBXJPKb7NHHSYRAqjgqM39KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgWHhhSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgWHhhSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C331F000FF;
	Thu, 10 Sep 2026 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789008030;
	bh=yavp+Qp9wv9SjhY6RxZ0txdKW+9dHX/o9YkVk92anbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GgWHhhSZMmvobStbM4RKnnvH1rDbV2JqW7DDT9HvFwZU2JKB3aTcImWYddvWLFEQV
	 df31QV1bheOCZ3apj8UOsTVSwIswAOZnToWomIH+2koc5Aqopxpr8hRkvtcQf0Wkyo
	 LfW5E+1eKWkG+qRVo9CRzqsBfO5zIv94JRlodS+CZYo2pPfZn2sXhqkMeUWaEXma1U
	 XUmj/U/dLpKUE8KTez2PLDvzgLlcsa01gt/ZDZIBlXB8cJyTl6mZ/nZbMfOrPLeLf9
	 fEV6XB7wGv9/g+G3EuRLWpOMKTVTzY1YVSgDoXqAL+CWJGXKRbE6wvly58Jv3G/aWo
	 71UVhLqH6c0ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf evlist: Don't restrict uncore events to PMU
 CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nia Su" <nia.su@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909-perf-evlist-uncore-cpu-b4-v2-1-dc673a1f4592@sifive.com>
References: <20260909-perf-evlist-uncore-cpu-b4-v2-1-dc673a1f4592@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 02:40:30 +0000
Message-Id: <20260910024030.B7C331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The PMU CPU map has different semantics for core and uncore PMUs.
>=20
> For core PMUs, pmu_cpus contains the CPUs on which the event can be
> opened. Intersect the user-requested CPU map with the PMU CPU map to
> reject CPUs unsupported by the PMU.
>=20
> For uncore PMUs, pmu_cpus is read from the PMU's cpumask sysfs attribute,
> which lists the default CPU to open the event on per socket/die, not the
> set of CPUs it can only be opened on. The user-requested CPU may override
> these defaults, and the driver can redirect the event to the appropriate
> control CPU.
>=20
> Currently, __perf_evlist__propagate_maps() intersects the user-requested
> CPU map with pmu_cpus for all PMUs. If the user-requested CPU is not in
> pmu_cpus, the intersection becomes empty and the evsel is removed before
> perf_event_open() is called.
>=20
> Add evsel->is_pmu_uncore, set once from pmu->is_uncore at parse time,
> to skip the intersection for uncore PMUs. Core PMUs, and other
> non-core PMUs such as software events, breakpoints, or tracepoints,
> continue to be restricted to their PMU CPU map.
>=20
> Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with thr=
eads/processes")
>=20
> Assisted-by: Claude Sonnet 5
> Signed-off-by: Nia Su <nia.su@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-perf-evlis=
t-uncore-cpu-b4-v2-1-dc673a1f4592@sifive.com?part=3D1

