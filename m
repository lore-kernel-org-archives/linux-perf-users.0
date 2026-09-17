Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6C30DD05
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622013; cv=none; b=RNQHq/UqoNSwjvTH9l/O+U9hthA7gFgFG6EybqKgGx7r8IYIZr8kslERVZjBEot0Q3UHY2Xlz0orS98ByeKdc5Ke0VEfgUKZqASGkgHMj2QWs1+v34sZyL1gVu1/J75IdwCZWG2qEsFKgLKG//tzKPVdTOAW5oFsl9WcadlcoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622013; c=relaxed/simple;
	bh=G8dUvVS8q7kn0wQ8gOzYrPRRz5yVGvVhTijTpWh561c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=abPtRcxOAhIVqKWW3wvUxGUERMJT+OQrLcMf5iT/mto9X0NNQaWTCkFOBCptCZw6zQH8m4tVTsRGbIVXYmnlT5452zZ+QVRz4gF+2lPPcF2uNlfp/RnV0WsPlBedwXM0PD96uVquuHbG0x9PpcxGpEXGsWE70hm2xv9qXNGNfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqmuKuii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqmuKuii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35F21F00893;
	Thu, 17 Sep 2026 05:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622011;
	bh=G8dUvVS8q7kn0wQ8gOzYrPRRz5yVGvVhTijTpWh561c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqmuKuii6oZes20nDu8Jny7bkTK++Gm+oXHYTcuv/PLMd4Ozax6jTp/IdsD+esigj
	 6FM01mLNDUb0pLIs8WxHo2Bonue/l0a9ti/xY0DQwq58Deibe16hNSyzUU0Nqa8Oxd
	 n6wXgj28atdFZhQK40l+NGJvXuO7/nhEZJ99CSvjQgg1YMExwd/DZCHpYOsSPx3uIO
	 eH2iAIc7uVfojeyzx+B3DLZUuoJI1602SI5jT9PEe+7pVQRViXyZh9tNwiNnuHuPfG
	 Y5G8Ata0CVWtbBcbx9QFMqn+ZGBsDNFtpqaMCzUmkzSNSRQmkc4LTRZ1RtEOkYU0dk
	 UR4W9hfvXP7BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] perf evlist: Toggle merged_hybrid_group properly
 in enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050708.704702-6-irogers@google.com>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:13:31 +0000
Message-Id: <20260917051331.B35F21F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050708.7047=
02-1-irogers@google.com?part=3D5

