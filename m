Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE79274B53
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110252; cv=none; b=VyiHZf4qjTjtrI3yfbDUw80Q6hqpvYE8LiB1kKhYy5jVZ9KA+FRPZwWKKS4lSOChVUY4IJOJ9vu2fUiQve75ih2Rt+G+fjjabjnou6IlmY3NVKvF4zAiEq4RwJW/D3Cv0SrFASkrhsEfgSdMobn4igaT/ImKeAkhoDWuwI+/j+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110252; c=relaxed/simple;
	bh=/uUV6xh0yqmGHn00QzLtYjqB89PbFbz96v5oG5JVTFo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pfWVZ862/+fmx0+2c38QX6fdshEqY3Sy1xWBoedc7dDK/79nvMt+/prX95C1SYdaajznH+FZflq+nDbbM17lasttL+pCjLjQaJ73z6AGbsZZzb4y5IPYKb1tJD/MAH02wi1baRF857NSwysqhW5RiNmBO3imJCsMSwiqwQM9jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7aBMMjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7aBMMjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1221C1F000C4;
	Fri, 16 Oct 2026 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110251;
	bh=e1RKHbphCOJVLIORUtvOa76J5rPcot4YPWB3L7dC6vQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c7aBMMjfkREDEz8YJule5MjVyT1gQz7n/YooUNg+YrVdA1bjR+dgnX+gnHFzH3PHT
	 wQ42OYV7wK7NVLteBD2Wygn9wHMjF0XHZP8LDBFsUQbwCaKqWxvzhrZRM+qZIxczwn
	 mm+PfHHjNYYpGu/JnsYN6bVv4rkp7GMjXFZNVwCoPKP8DvHfyjY6Gk/UMrR/MYN7cW
	 QkI4YgGbUd8VVKcpF8x58N5zBQ16s9uzOOpioKjcwrlNSBVrN61TcduQQNOwI2GlzA
	 TbnaLHscsTehqI/BSsGvIVb4cTBf19cddfounMbHXI6fzqCPTeOLZ4LcOzRUl9W5gm
	 hqS6RYUA0PK3A==
Message-ID: <sashiko-outbox-173517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/19] perf test attr: Leave out the events of the
 other core PMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-13-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:24:10 +0000
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D12

