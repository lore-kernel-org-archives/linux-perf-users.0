Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04940A92B
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185965; cv=none; b=bFNazps17q7temWox+QCMvw112e5lub/98qybnNDGaKTcRKStInof5PusA+V89VVFoCn65qKe8x+N71Mdd68e5kDOelptUKYqY1i3RArcnqZkjAB1sxJZruX89UkepZNEQlc7bmuKUSLAMJnNfuXCXJPF7/2ZaQZriv7qQj6nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185965; c=relaxed/simple;
	bh=hc0g22U4vJ+ZjjWwqhf5oOjH7VdoE/IdqGz3hqUuWW0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sUxl8w1MN4iZkD6z3oDjzlS1bBdupYpTc6vn5+7Hng1DJDKTHFzx70A69cUM0hfqr6h+LWH27SR3I3xAOouhs6OCYmf6508kYA3KG0ZHylaqxgUV6HpmUpUlY1uYsQlBnOORgwEy3m8EdQ0IP0151+/iW4YtNF6XdXNSfh7l8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAQ/FoOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAQ/FoOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AF21F000C4;
	Fri, 16 Oct 2026 21:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185964;
	bh=Nc38DxmBhyY3jEBxOQu3vCCLukPzJ6xcYI49tRDvnWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAQ/FoOzErUQN66DHZxtVxSOgg9YbinVBZLgri71NGxBinkynrRNG9ze22l2w3g91
	 X8OQxk7Vs45cCqfbyCkEKEf59Wk9i0QDySYUgp0F7LRI5Eu1+k/YS8CynbjLbrFiZw
	 qMsbW4l7xoLrdMFtXqkn5LJ75PFE4P2qbQ8ckJ1mYCDOTqbKwLYxeCdpTKCADQgKj4
	 SM+iQb3HCeYmaiLmeF6SRJmapb2LjSjKsTzkCEnFbB9y583K1PaCEuJT0JBVWmsN/J
	 ohUJ1YqWZa4NkvQbKXo2KuacfK0MhJ/SKCD1p8PqcWFrLO3Xts1SuUpCSDCLoEu5iC
	 w38Lp60fu+duA==
Message-ID: <sashiko-outbox-174968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/21] perf test attr: Leave out the events of the
 other core PMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-15-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-15-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:26:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> On a hybrid machine the default stat metrics are opened on each core PMU,
> and the events of the other one have their own encodings: on an i7-14700K
> cpu_atom (type 10) opens UOPS_RETIRED.ALL, config 194, which the
> expectations, written for cpu_core (type 4), don't name:
>=20
>   expected type=3D4, got 10
>   expected config=3D209|391, got 194
>=20
> The test already masks the core PMU type out of 'config' for the legacy
> events, but raw events keep their type and encoding, so leave out the
> events of the core PMUs no expectation names, like the dummy tracking
> event.  Core PMUs are found as perf finds them: 'cpu' or 'cpum_cf', or a
> PMU with a 'cpus' file in sysfs.  Nothing is left out unless an
> expectation names a core PMU, so single core PMU machines and the tests
> with only legacy expectations are not affected.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D14

