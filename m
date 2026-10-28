Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211191;
	b=n90GyN9k/r++ulelZal67PZSGy+haPLomVrLqdaCFCsvqhgQ8zwteDDujz2DrrXEKKZf
	 GZYZxzDhEMtuNpzyTCm26jmBmpL17jvp48gc0aoSSGGXydlxelMY/7Y0tN8F1EJ+Yc9PY
	 Y0z1lGGPbGVERUpNLLBJhS77TaCXOxJFrcpzm8EHLQwD+aj5xOHtvGilZyCnDM85xZt5X
	 FP7y+nkhvUpjCSf7Un9BQoUWClALoE2EhSpia9hGx1CfLHbmmEhxpPg/mrodgas0RaImf
	 V66jkd8d3htgZEQxZHTv6addt3/V2J0tiydr8C5gNg7X1Hx16pSctrsqZd1hA++6eAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3fbvYOznRCFrMxN8yeB1pBWYuJV4PNH7thrqcUSMNcU=;
	b=yb8Y3L4SwZBI6ZaqeThhBZoQSZYCci11wvlroBeQSGRyWpeDJQ1+qKCRa12ldhnnA+y/
	 rWxX8DW8y93odt4M+BYsc7EN1O1i21VwM+2CBDaDjGCLIavXRhBmiFm2LPXzmSydgn9ri
	 85Uu8673gfGBkD+E26+vaUwbgIPGlF5Mku0ISY5Xpm4qQTAHamLQcG6IjbShEGsJJBKwJ
	 1t+NcGAj7CAAZ2SqsYKdAuK8Sff62xH5ByVKGBMdF/MjnmqCPZZG2bSl6UJdr2M9i6KOt
	 0HLVbKFd03z1+7mt46QEpZWHZmU8+QNwSKTAWRsavCmegPpsDyGR/StqVO9dH+bf7fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdOm9LiS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461EE60A6F48
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdOm9LiS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF96C1F01825;
	Wed, 28 Oct 2026 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211191;
	bh=3fbvYOznRCFrMxN8yeB1pBWYuJV4PNH7thrqcUSMNcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdOm9LiSLeq0MZXgsr/x+e4PieA0NCEQiHS7usJ/jWgwzN+YKfVkJwyZ9St80EpMR
	 IKkUI+0WkkxCpAXMdeMQk6+keY9RkB9wTaveigp0QWUhzp0V0DgA21uymCoDEPt3gN
	 XL0ozGcsmImiOVfHZ1sV17VY9BdSY4tCZjCjOywwBq7J0ozw4SB6+LK8CU+vwtGYhO
	 pFx93VQY7rghfeMzmySMEjYcml0zmsPxHUcA06lwO7oaTSz/hGIRpClf6V+U5EMBvb
	 U8zI6Gb7TUU4kv0azNQWUqFGC+exbFnjKhSxoDGcAMAaGA90O4k+b6+pKJol9GNTyZ
	 g9fvRD816//eA==
Message-ID: <sashiko-outbox-188268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] alpha/perf: add sysfs format and event attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-alpha-profileme-v1-2-d44b52bf2500@gmail.com>
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
 <20261028-alpha-profileme-v1-2-d44b52bf2500@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:13:10 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-alpha-prof=
ileme-v1-0-d44b52bf2500@gmail.com?part=3D2

