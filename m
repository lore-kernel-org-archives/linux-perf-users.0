Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333274;
	b=FalqaJ4os72Md/S7GkdxwZ1Ks3D7MIOl6L2/WcwTyWh0RumVaFKT1S3qi3F2D4Foz+zd
	 oj3EPSBzyBEL9ypBxJ4AosB6cjTBYprvoGdniSwQAmvNa0Jur/JAVs2cV9u+c8xF6tpbi
	 jR7w/tysL/DUnmh++WknpU8zB3HUSNCZQQ18AlA00EvuTvS5wXcEOKzxUb62MjSunIf6s
	 5RJEizJ/tlKHOQOCvHG0bV2RwUAVt18xBHVE2mmisthMiMXYw7aDN4gdoJBJQWa8nTsKr
	 rewHxvNXPEUK2vkfeASTViqeoGf3urk19gAZOhaEo4sUU4r6+h8bLRmLZXtradOGiEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xJ+Ak20HoIWqtkrAi8Lml4lR6ziqGHiID1I6j+h1zl0=;
	b=nlcyzI+kR4hWrxgDCtP0W5R7qBjA0fnPuTLqGCs2iXFa36boMwNo8VSkLDTGZQ63MA1k
	 eSF7W0tXLwI83RqiO7Izoc/cBMsq4r3wS7AX1f6b7Tcx3sHuEDKTgUoogitao7WW7noC0
	 O84mKpaoUBDWeizb7pP5IYEqimXaLQRTTEs855AvMf2YhY1PIiytKZ51gT8C8wCyPTrZ3
	 MaLuCHo0XAoeat3ZVnyHCh5NucEDz4C4AD60PewVF0wrZCR9kHSHncrCeElT4TlHQ5Wb0
	 iOZw3eXB2RznpFdq41vjMBO6heoOUdzAUGg0gQO48/x8O+8d/DtBV+4ztyTIeiFRNbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcGYSvBw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAFF606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcGYSvBw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39D21F000C1;
	Fri, 30 Oct 2026 04:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793333273;
	bh=xJ+Ak20HoIWqtkrAi8Lml4lR6ziqGHiID1I6j+h1zl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gcGYSvBwItvAPSn1vfQ7bI7X3wS6rMNYr1yofw7o/YciBeIJrmzzgjeA2BNivBmST
	 x3exiy87blqD/zue8JXjaJJ29zDKCIQOk/TGA2GLjfTq/IZCKofqtnKwQ8JlyH2Wc2
	 vPgEZScZwIngjsAzsT+mZ2UPDZWQ2r4X/H0C/P3WyeI6lDp7q+QP16DaPWOoDsOnrN
	 udsoas5VnffDMVUj4zJEQn47N/c5DE9K9No+gPPpAFhb9cnNVgryRNhACcbMcV6E1T
	 ItlNDmqM1zo6ao81Ag49b99FFSJU56/xnCWMJb9H/LulrPYzlasvAstov8nEUJHOYJ
	 58R2jZMsm2gWA==
Message-ID: <sashiko-outbox-190285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] alpha/perf: add sysfs format and event
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-alpha-profileme-v2-2-c702f1c65272@gmail.com>
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
 <20261030-alpha-profileme-v2-2-c702f1c65272@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:07:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Alpha PMU registers with no attribute groups, so the perf tool has no
> way to learn the raw config layout, and the PMU's own events can only be
> named as raw hex numbers.
>=20
> Describe the event field in format/event and export aliases for the four
> EV67 event types. mbox-replay has no generic hardware event, and can now
> be named as cpu/mbox-replay/.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-alpha-prof=
ileme-v2-0-c702f1c65272@gmail.com?part=3D2

