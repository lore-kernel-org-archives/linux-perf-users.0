Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622903;
	b=rfzOUG0hC+HjLbZWFaiZte0A0sDrup9UnEYST+TwUGcIVBPT7AdAJimVO1V88to47/z/
	 TjCjx3+l/btg5/zz6nRJtLWCyO6F3TMhPgt333dTBWb2zXu0CSE/uWSS5WuToZtc34nlh
	 LRaDsNK8qp7P2O6RzDDzfUWWo9UpaOEQi1hurgjBLF3F+qFrvnK0dQG+ut0GkSNQ/g2fs
	 IPNxLN6oH1BK8RyRfa+gaYP4K17ZIpmoFaf5WZ2PmGFralG/btAY+VqTpPmuB99h72Sng
	 UEw46z55TUHRldHgrq//vGUlwvuP5kgaLKlaM8VMYFY2EG/8vklFCqmJHjJlZEJZZFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622903;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uAFXmhOTbJCjxNzHmmesJSywNfX2x78cQP8cbEFPeQA=;
	b=23E2JpRJwd1DpgiGPLnQoHGnnBOv6paMo03DnezbpiX1Ypmufk8F+5JQh/GNp9yyiSR4
	 MSPe3uIyiEoWOA7dFbhvMLZKBTSOKPxHwbiTxL8y/o1oEh3YDiBJpo0MARQ3jrHy91pmT
	 pgww2hrXLhP/VhRfthcQxSTg8t3Abvr5IFIh2iTbVZdw+z7PQF95JELtxHEe1n6ME1woG
	 uMCpAGpp5eKF28BQKst7ZnpgiHmbS3jy3zyuEgy6ijQywpGRSIAj/+bphU2w2UmMa+SsO
	 w0B5z5uE12hszIIx66hr1vKnqYNK7NNm9Mz8QcwQVKgAlepnrerOWvNGJOr5sHF16mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mBIDjmU/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92E606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBIDjmU/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B561F000C1;
	Wed, 21 Oct 2026 22:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622902;
	bh=uAFXmhOTbJCjxNzHmmesJSywNfX2x78cQP8cbEFPeQA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mBIDjmU/8RSRavvq4eMapUHqKF3ExcUvYsg1brtOueol2x20OK+DWT7uFsYzFhitv
	 jftJCjvXs4G7iPLRxy3LJY3QvGbrS1aA8knyqeyy1SNj80pnKGfW36qaLQgOE1zLDH
	 3+rrBU/jPs4teujx3KJsK11wFvkvG2rNMOEJWSiyTTl3q7P93sNBzf+Jg0vdK/12Al
	 vcCaopPUh34eAabYzGk/bMv5xApJHx9UWJthEv2ZCS4Ril2Z7C5VMhB1L7TSi2Ff3S
	 NYhw1czFvxMpIekAicDnr8P/CwMRLYuvBFhCy1X9EWgorjM7Hwldsz9lTG83RY7WN/
	 mMzzMFhXhoiyg==
Message-ID: <sashiko-outbox-180737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Drop stale
 BPU_FLUSH_MEM_FAULT entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261021224527.167637-1-takano32@gmail.com>
References: <20261021224527.167637-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:48:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> AmpereOne carried BPU_FLUSH_MEM_FAULT for EventCode 0x121 until it was
> renamed to GPC_FLUSH_MEM_FAULT in 10a149e4b4a9; that rename and the
> AmpereOneX table were patches 3 and 4 of the same series, so the new file
> kept the old name.
>=20
> The result is a table that names the 0x121 counter twice:
> ampereonex/core-imp-def.json has GPC_FLUSH_MEM_FAULT, and
> ampereonex/memory.json adds BPU_FLUSH_MEM_FAULT with the same code and
> the same description.  On AmpereOneX perf therefore lists two events for
> one counter, one of them under a name the documentation does not use.
> No metric and no other file refers to either name, so removing the stale
> entry cannot change a metric.
>=20
> It also leaves memory.json holding only the ArchStdEvent aliases the
> other files of that kind carry: AmpereOne's memory.json has no raw
> [ ... ]
> two names for 0x121 to one (rebuilt, counted in pmu-events.c).
>=20
> Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU e=
vents and metrics")
> Assisted-by: LLM
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021224527.1676=
37-1-takano32@gmail.com?part=3D1

