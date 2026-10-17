Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C33E3176
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263998; cv=none; b=bEIdl+VYLUyCp9cHOK+cc1Jdwuo5jvLRrvmNxkyAw+LdJ7B7+VuCA6w1CMG41HEmeVJBDr0+HjGNiFQjNdC9I4ruCATcXIwoxvk+saoYkb4VdchBxw+Y6bnPMPCVvZBjZqiwvqv1j0BVyNeAklYltpfd6IyBNCW/bRfYIbOtCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263998; c=relaxed/simple;
	bh=4YZgmNapOxv7U/K9XVjPsuAwrH4G7ZpavwG5Zp8z34w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=G4pjZ/Q5eWbgEIEyyLyYsBALGJEqLUG0aKoQ6IQ4zU2K2VX4+CEUYrH6HpuI06Jh8nX2ShWJfeDGA1LgiUkD0aCJytZsqMvA6vkorkvga9O3z7gkxE8MNxQng69rYWMjEY/Fe2dsLtWjWPqckLfHJigiBiWY1OcDg3KxbsDLffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCFUk92O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCFUk92O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A1D1F000C4;
	Sat, 17 Oct 2026 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263997;
	bh=4YZgmNapOxv7U/K9XVjPsuAwrH4G7ZpavwG5Zp8z34w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DCFUk92Ol5oZN+A19fpemVOVejIwE2uSfvZJy7gb4ESATTJDCcE02Hg2xHVI9UaIw
	 LOPQ2L7O7O2yAMNIGvKo7aag5cTXUBHxLc+Q+oobAx2U2SlrzmiRqr2uqnZpVDtqDY
	 9xrWdpwuRsR+GK/M9nnmcbtd+0OnQqgTDqSq6ujFBVZQWTn4RBVGnQYfbX9u80lmJU
	 OlsEjBI2gzp5oJ5Axg1+0ISEjO2JPd+bsXm5U6M9p6GPG5DvCAXAj7QCSIGROJ/crj
	 kMe8QHy337UE70ynaIpiNMWJr6XNvewwyDukjO8NT2I1QRFTGDDBxX3Q0MxZT+Uy6y
	 Q4OXQXFcLm0dA==
Message-ID: <sashiko-outbox-175771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/9] perf pmu: Add from_env parameter to
 perf_pmu__init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017185442.2137623-2-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261017185442.2137623-1-irogers@google.com>
 <20261017185442.2137623-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 19:06:36 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a boolean from_env field to struct perf_pmu initialized via
> perf_pmu__init() to distinguish PMUs reconstructed from perf_env
> headers from live host PMUs. Guard tp_pmu, hwmon_pmu, and drm_pmu
> callbacks on !pmu->from_env so perf.data-derived PMUs do not access
> host tracepoints or cast plain struct perf_pmu allocations via
> container_of().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017185442.2137=
623-1-irogers@google.com?part=3D1

