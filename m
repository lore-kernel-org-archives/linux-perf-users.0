Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592652D2C0
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602840; cv=none; b=aNm3ZKSCwPwcZI4PMpiUFA02NOE7q7TPDAcJTdfW8oCcLehjb0LXnDV33b5W5W5zNz6WCya/kOA/+ON7MBjVmP0wGiQB2uC3SKLWBp1PLyxX/a8NriCHMOxitm54svnJBVJ3OV0DgjdgT8yqiBMMV2zpczTAymvB/9B3md/Qt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602840; c=relaxed/simple;
	bh=2cUzVPz7OJlQLqI7uMTQ7EEpK1cLzXLbBJnfXfTh2L8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gK/czALiqbnIjd/zBVKhIR60OrqtSyywEgvSKjMN6BxT7XTY9h/slApsPz/kc3Y3NyStBe72Ql40hJWDflrY3YDdaf6KX1qR/VBkE5b3TtoOD7A1QE9swdN9rtuUSFgifjwqLaVWrqVsszhNukQ/TENvrhhiNthpz36iawa5QlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU4H/Bfl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU4H/Bfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C541F000FF;
	Wed, 16 Sep 2026 23:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602836;
	bh=2cUzVPz7OJlQLqI7uMTQ7EEpK1cLzXLbBJnfXfTh2L8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RU4H/BflWdhA8gLpZ/qkHbifQn+5pXNcXZkK6WkK/OF9dd1RgMoj9kNTDbmGOAwgu
	 monGrRJjeC07ucNRWLY1J2vh0hN1dXTJD9XXiQSWbs5olJpa2bTTHKwkJxBuq7gHWD
	 qSxgGoBqEW7uS1XlpCR8p+bwbgRFeJshgxUVTQGE3pkdt96mW/bByFY2sfq6O4XhKN
	 8SlT8D7JlL6XNjhhhL61gTHpbsokPgJp7vVcASCQl8pg41ehPNn3Sb+y1Rvr1tW7yV
	 A+GtzcK/6D+bXHLaFjy1u+ITjBo84zfl5siDph58vFpdizsXl8EHfAcjCa+7GYiF2W
	 S4YY8fIReASnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] perf evlist: Toggle merged_hybrid_group properly
 in enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234652.439778-6-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916234652.439778-1-irogers@google.com>
 <20260916234652.439778-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:53:55 +0000
Message-Id: <20260916235356.14C541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Merging makes the merged event the leader of the events of the other
> core PMUs so their histograms can be linked, but the result isn't a
> real event group. Each event keeps its own file descriptor and has to
> be enabled and disabled in its own right.
>=20
> __evlist__enable(), __evlist__disable() and evlist__is_enabled() skip
> anything that isn't a group leader, and the first two then walk the
> group members of the events they do act on. For a merged set that is
> backwards: the members are skipped by the leader test, so their file
> descriptors are never touched, and the walk over the leader's members
> only updates the bookkeeping in evsel->disabled.
>=20
> Treat an evsel with merged_hybrid_group set as a leader so that it is
> enabled and disabled in its own right via its own file descriptors.
>=20
> perf top enables and disables by event name. A merged member carries
> the name of its own PMU rather than the name that was asked for, so
> also match it against its leader's name, otherwise naming the event
> toggles only part of the merged set.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234652.4397=
78-1-irogers@google.com?part=3D5

