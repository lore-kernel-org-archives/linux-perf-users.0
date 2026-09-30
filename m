Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360D489FDE
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810655; cv=none; b=RYheFBIoJytVOLKHSqVvsVO/oBcqdtvfFkJFLvWZB9tqiLM1xkmv5/BHrdwe8D0h7rzIlWOc73JlvCLdCtgfT8yPyhFcg6CX0kx2tPnfN+V/qp2xmsRd77b66/sA0pshoxBv1uIbmzXkRUjpE5RmklRb3qUDsx6LPFYQKuT7/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810655; c=relaxed/simple;
	bh=ODKJZxCzpgbYTIaC6syrxJvyYKVUHpHckU3/O3kuKnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qLANSpoFtkFToH70RYVefmuj6PSq6AGonZ4p8cILetyFesmURf8RG9JwejZ3OS5AK9GkoGmIUjLPl6VhHoQ3bjGmQ6LoipjWjM2xGHJI2mTK2waHdfJ9zRh4+H6Pwr94sdGL+K3lirTt+8BA7wchbMmmwgSkP2N0VIw1nxQzO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKkTTz0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKkTTz0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D170C1F000FF;
	Wed, 30 Sep 2026 23:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790810648;
	bh=3V9IdHg7Z8pzSZ5KhwwzoaX8X8YqC1gV9bWYg1Rt0ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lKkTTz0gOEKp73++mBfLiBXXeRMmcQr1cuCNSPv/dONbvMXvaAqP4P5IGmkmr9L+a
	 Kpt60N7vF8qU1OQbrjCeQPP/PgrpPVpN9o4L1EdjUjXYj0sdyqyMFZUmebmFuvU4bI
	 pk5jkrWYXYAIfYQ8I+Kpl3h78vw5VjlMnU9zbHnLNMGFNwe9nPdvL4Blqmg5h8PCkK
	 JIrDL0fynYFO5K0nM82ULcSiNkRvA3FodANS25b//jFjv7UkZBflQHMj9cp8/LpSb7
	 OZexirQuht8BrZZoPeRvzWnS4qImeh3cWw+kGoxoMEoW9lAl6KloPLwe0yHRPI8S9N
	 PCizpjpSV2dFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf/arm-cmn: Allow userspace to select the
 PMU's CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haris Okanovic" <harisokn@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930231127.3094040-3-harisokn@amazon.com>
References: <20260930231127.3094040-1-harisokn@amazon.com>
 <20260930231127.3094040-3-harisokn@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 23:24:07 +0000
Message-Id: <20260930232407.D170C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> arm_cmn_probe() picks the CPU that owns the PMU with
>=20
> 	cmn->cpu =3D cpumask_local_spread(0, dev_to_node(cmn->dev));
>=20
> and arm_cmn_event_init() then binds every event to it unconditionally.
> That choice is only revisited by the CPU hotplug callbacks, so in
> practice the PMU stays on the first CPU local to the interconnect's NUMA
> node, which is usually CPU 0.
>=20
> All of the PMU's recurring work therefore lands on one CPU. This is
> problematic on systems which reserve particular CPUs for latency
> sensitive work or confine background activity to a chosen set of
> housekeeping CPUs.
>=20
> There is no way to set it explicitly. perf_event_open() and 'perf stat
> [ ... ]
> The attribute expresses a preference rather than a guarantee. The
> hotplug callbacks may still move the PMU, for example when the chosen
> CPU is offlined.
>=20
> Signed-off-by: Haris Okanovic <harisokn@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930231127.3094=
040-1-harisokn@amazon.com?part=3D2

