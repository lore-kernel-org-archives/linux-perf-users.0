Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602967;
	b=CZVO5J3mq8QUjjjEzO5qD82vDfwe8AuPqMEcwmOjB25FsBFaaZA7/XSSC38JRx9IQ34S
	 /AeKK+gihQiAJAfLClkLRS8583bPvlclVTaWK2Qp7qN5SrXKGHvt0aQLjewV/B6kbubYQ
	 hC9eujnUj8eGn/Yx6fLa5y0/cgjXT+R+PB6eI7wWGVBzLMZC62fJPLKqxHAmFSuzvcws+
	 NwOXMizhHLfjtfr/9mpnn0DHxjvwcEdzq/h9v4GOKVHSIWoiin5u2gBZWFbAmbCkyFefJ
	 NrPl7DHLHoIM8MMbHCo9B74ODw3rD5G0zYo/mqiBoOa1wUbReMZWlbi4mw1lorNHHRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C0IAaMrLaLw0uQkxSC69ueCQGelW0c4KkvmwCj/Wa7M=;
	b=OITPtXSp2DV3mKeaTj24MpN4hrK1yMMvIW09Q+myAeK5EWPhCNbvS679HqOUEb2CVOFh
	 n8cEIy3ehBDbqTmMKHyHVttR1TgE++z3fe7Tt83ujA03CySdX1Fc9teGZdIWX2CkXjT7W
	 EUtVDkjn329dnkiYnueeYWZwg+u2RhJ2uJ6D5WaIM9QiNSN0SMPCvAQNSwtErvGGK8dki
	 YaN4er12goSBMth5Tu4y2cgLdloW9m4N1dKZ6Y3+2/TmuNDs+cwzaPe8JUyPllnatDPMp
	 rXnCfYuk0L/ss3n29+6vfVWBcf2MWepkdMiHuoo8MZbngYvnxPq5yAcPsnO57gVPnZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLOuXtwn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC3606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLOuXtwn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774921F000C2;
	Wed, 21 Oct 2026 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792602966;
	bh=C0IAaMrLaLw0uQkxSC69ueCQGelW0c4KkvmwCj/Wa7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VLOuXtwnfZQI0joAOttYFpSUP4UQum5Mpplpx7luAJwHZo/fB4tzmUIg1CrCExYJd
	 UuK0gu53PiIFXq99dU1UW23m8CehELMfgOdfJGyQeNUT8tqWy0/XXd6Hn0wCtAq3Og
	 lLtwNG81J13EmyIfDX31Nt/lPYsIvg4SvUVhfFiX+YGwfBB0zBJkiuxOwF3MSawG7x
	 vkdHxyKzL06EKCIwqfTWUg9XA3NUcZGl0qbW8ZfaiXCJUST/GpIhzM5DnnKJKKAsT1
	 ijCrI5unZlr1srTZM7ZbyMyd8pntK5iej+u3N+z2Jb3hgif+lEpd3JWQTq1tfQ/GHI
	 tPvtBJY7cZmow==
Message-ID: <sashiko-outbox-180503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/17] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-10-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:16:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D9

