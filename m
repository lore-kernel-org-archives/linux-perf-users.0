Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803093B52FA
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717299; cv=none; b=Ui4TBaAiS8GG3WVTY0qVgjbYGi2toGGlW8Jns+DEX51RmlXVZiwoEiwYSk9+S7csbD/luAXvxu4ye60yjkMGqL+HOEhU+7Nrz+uihq9MIuTwZ2h1JU0B/LOKK6fSTQlgwcgBIUf+9eqwLazh5fpgJTwLyh+lwkduMA9I8x1eB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717299; c=relaxed/simple;
	bh=WOBr8e4QjE5d/4EmnKX4eEt9m09mgwiLDcu5nRtOQgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kYFPsVvqbJ8qx3iqqUnjRJBjpT8O4/Q29znx4Pb//ZR02pkK6Az3hh4crlxcAi683+aHiGyKpw360DMm3ubsqnwVYnC2NAnSOk+wv1Yu0TXKn6j6M9bum6ZgANCnKFuIf+iPF1kkgrVfF3sikuoUpBVS3syUM/ylivIaQ4JQBv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKMA6zDX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKMA6zDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A851F000FF;
	Tue, 29 Sep 2026 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790717298;
	bh=WOBr8e4QjE5d/4EmnKX4eEt9m09mgwiLDcu5nRtOQgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKMA6zDXC4x+3URyztOHl3huX549ziPMTktN50hTDsuM3u5dsIlAaW+B/3Y32yRxy
	 Mj8qjZekr2+FSxSqSqWNiaHngNt5KDkjp2hOE07q+sSoEvO4NWv8C5GN7xjdNc0cRT
	 lKCEjo31ocVJvDCN6tIJLycQQtlrLYZZcpMEjTJA0TayXJONffFQhwcvTXrZxDoTkZ
	 8fAkPM3PHanc/H7CNpp5l+mUNKW2q7wXZyWnY3rW+eb9Fhx3IjvVQqQez1AuUPIdNk
	 Qa/vA+Ra67FPGWa17sZm5hSOPWT4lib2v5Bf16MxxrQo9vPjpnCgT3JYkedePCpVNM
	 5r5G3VpaJWihA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929212246.2532021-6-acme@kernel.org>
References: <20260929212246.2532021-1-acme@kernel.org>
 <20260929212246.2532021-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 21:28:17 +0000
Message-Id: <20260929212818.05A851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Add a 'perf test -w false_sharing' workload that hammers one shared
> struct from several CPUs, shaped as a TCP connection: a read-mostly
> identity (five-tuple) shares a cacheline with per-packet rx counters
> (the false-sharing line), a second line has packet-path private tx and
> congestion control counters, and a third the connection config.
>=20
> The packet path runs in the main thread and up to four lookup threads
> hash the five-tuple and pull the config, reading one volatile shared
> instance directly so the accesses are PC-relative and resolvable by the
> data type profiler.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929212246.2532=
021-1-acme@kernel.org?part=3D5

