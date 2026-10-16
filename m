Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C910D3ED3BB
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187030; cv=none; b=prh8WP/HbmHeJ76vlVPDeoYUSrl5Kwea0nlGnWR7Bd1RSVCDVkvPz5UNnee0ujLG3N+ZIpOpTamAHFTBOSTDCAZxJm0fb3agbleDRyc4Ifswqzz1rEm3KeiiE5blyiXrPE08lFZdmF1bdcXsKC13OUsNBJrwkovYdXTYAvHzqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187030; c=relaxed/simple;
	bh=/Gu1MgWGFdJPP5KpAh9DMTwujWHeFd8rbMdQAsCcOqI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=guruwQvA4JGINK2Ih2/b/KuDF/7OnJe4ek/mJdmv3klqgfFmG/pbrAXycOcp4hv85AksVzNuR5cvrxL8zJaF323E5DBksOyWSVHECsuE5D0mqzN1gFr+1xOFfgZmlxe7BlWROztx/+gQU1VrFfVDGGnd7HgKbbAmQwU887MfXuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvSgWqmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvSgWqmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEDC1F000C4;
	Fri, 16 Oct 2026 21:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187029;
	bh=gTyAl57sXqYAQAq/s1Dzizp1190sSGp3fj7k5aQU/mU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvSgWqmvz9Qvok85wjSY4Se/oWnXBl7XZruwPSYUpokLj8a7WgzJp1KSO6QrKw5Ly
	 q25iw7OQTeFdaHofjHmy2pHYkn5bqmIpYHiSDkGZe/bmVlQW6hb/wBKjxjQlMinC5V
	 0//u/+tJKy4Gd9x+d+eaRo4Eom607Tz4XI7SUAwqJ+oIj0KG4uYh9TXuzBAkVRAkhU
	 FYqApk4dZcQBiW13L3vhfiMk9gGkVwFaCMoK8rxlmFCp5vcOHpIIGHRMH48qao/rSK
	 aI01MV7AvJxzhx7rLpTAQmqpSEy43sf103noikWj2Tj0ibYK1Qf2/X0bDSeGPN84P/
	 MtkXAqT1ejMkw==
Message-ID: <sashiko-outbox-174974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/21] perf test attr: Fix default stat metrics
 expectations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-6-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:43:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since commit c7adeb0974f1 ("perf jevents: Add set of common metrics based
> on default ones") and commit 2dfc0cab3da4 ("perf stat: Add detail -d,-dd,=
-ddd
> metrics") the perf stat default metrics open their events in groups, so
> group leaders and members have read_format=3D15 and members are enabled
> without enable_on_exec, while standalone events keep read_format=3D3 and
> are disabled until exec.
>=20
> Also, since commit b1c5efbfd92e ("perf parse-events: Remove hard coded
> legacy hardware and cache parsing") bare hardware events resolve to the
> core PMU sysfs/JSON events (type 4), so add the raw encodings the Intel
> and AMD core PMUs use for instructions, branch-misses, cpu-cycles and
> stalled-cycles-frontend/backend to test-stat-default and
> test-stat-detailed-1/2/3.
>=20
> Add base-stat-group, that accepts both the standalone and the group
> variants of read_format, disabled and enable_on_exec, and point the four
> default/detailed expectations at it.  test-stat-basic, test-stat-C0 and
> test-stat-no-inherit keep base-stat, whose events aren't opened in a
> group: for those, a change that groups or enables them differently is
> still something to catch.  test-stat-group1 does open its events in a
> group, but pins read_format, disabled and enable_on_exec itself, the very
> terms base-stat-group loosens, so it doesn't need it either.
>=20
> Fixes: b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy har=
dware and cache parsing")
> Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based o=
n default ones")
> Fixes: 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd metrics")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D5

