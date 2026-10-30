Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333599;
	b=fEFGCJE60QNb1dFNbQT6UHdXRoB5XoNUOGYT9as4bytSjb6Yu+sPGGysKiQY4gheQ0U4
	 61/7AnoE/LH7gDpq+Yx3c27fco9Wib1LLF+0G5neT5Aw9bclB/G7+SiqJgrFHTgwfne73
	 0Qz0FGIeWBj4ETmLLuy1F3Joqw7LHcfXsXnYsSFjcnQRPvYe4xWEEOc37wQeYmxtbfl6O
	 CmeGPOVh9I8KYgxB5JR7jUQYptNCnlYlda4Z5X+oSZpAL4IAMmumOJMC1/Pqc40moDCZF
	 0zHUzsUwCVJUk56NF1CNEwX44p+Ka+noCX+rwKHxlvO/EWHgVQV6cupUQ1wS3Y5+2yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y2cHiXOFjThrnKA1dE7KD2mxOb0MEw7yNX+4wfLAZ/U=;
	b=X/ttWVrq1GZz5F/NPigBgHhTOPudpuVC5zzCeNCKs8T20WJK+JWRR2UmPgf/Q3AE0ed0
	 Th4bf5IX+gUkjAhfxPkorJf5lZdE+gWbiUQSFO/ZSqxlgo7pl2OYaFAtxp6cvll0P3QdS
	 7HdTJn7wfreVu4e2ojhZ1lj1JVEiNxu8sASgHN3dhqTiRfnPTulz8vk8vJ5XuEWON6wDY
	 Sy9XCYPf5/p8UpyN74I/WAL0sbRZJQs2zpc3Ufl9Y5t8X6Gjhcvtrp1BJOV855oL+LOhQ
	 7qhIyMYoTkVyzUzh8IWt/HAHsDiPt8spWdfdwdA1bvW8XxDm76Bhd9ObvXuCjcEwXjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpU9PWht;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A8606A32E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpU9PWht
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C311F00A16;
	Fri, 30 Oct 2026 04:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793333598;
	bh=Y2cHiXOFjThrnKA1dE7KD2mxOb0MEw7yNX+4wfLAZ/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bpU9PWhtMN2ZOlIGxLmUF5OxAc8tcAie4gCPk0JbU8/J3qxvd0vBdfTRShqjSxNOy
	 rNeFTqQmxqwqQLSwvAt7NiNtOBKGObAh6xcu+PGSzhev9ar0o5CJCGgRAiNYIeeWq3
	 2JsSs04A/J4spfqrPFJs+YwXfmrb/Cc7txBYJ9xp8tmQeSWlal6kwBeHbX7keTKAD5
	 ZvaeTwVuUaQTojP1W5DU67bjcXL/YYtURrDPWuMPVgSxj6+HXx37V3bnapGRtGyxux
	 5cl5UHHJIDU3S+GXNo5Lj9GzEDWMVj3qJKQHTwwuYZZpCmwOD+4f6MK07VnTx3B07G
	 7PAgPd7U3hsZw==
Message-ID: <sashiko-outbox-190290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf python: Add alpha-profileme.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf-alpha-profileme-v2-2-9ce2f0b0e622@gmail.com>
References: <20261030-perf-alpha-profileme-v2-0-9ce2f0b0e622@gmail.com>
 <20261030-perf-alpha-profileme-v2-2-9ce2f0b0e622@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:13:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf report shows where Alpha ProfileMe samples land but cannot
> aggregate the raw status attached to them.
>=20
> Add a standalone script, using the perf Python module, that summarizes
> it by symbol or, with --pc, by instruction, in the style of DCPI: the
> fraction of samples killed on a wrong path, not retired, mispredicted,
> taken or stalled, the mean PCTR1 window count, and trap counts by type.
> Mispredict and trap types are only counted when I_STAT[TRP] is set,
> since they are stale otherwise. Redirect traps are counted by their
> PALcode entry offset in PMPC.
>=20
> On an EV7, sampling a loop whose branch tests random data reports that
> branch mispredicted in 21% of its samples, and 0% with sorted data.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf-alpha=
-profileme-v2-0-9ce2f0b0e622@gmail.com?part=3D2

