Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE1A3DA5B7
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416559; cv=none; b=ndfKFdBuS3XVFxdy78g9BilOEzqM6COHzsfBtWeibAACaOVhFrSf64TciqtUrNc2ar5gw5e++az13A6hIibsOzLF9wWhtHAEIQ7AN1XrKHSvVq0wQuC7lHsdkQpIPRajtCyVokbv+ONaEQX+VkKuPmgRoUqPQfxJ0RZzgJ5svuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416559; c=relaxed/simple;
	bh=cB0GlJS3AKx50361xN516y4fHxDgdIqtRfj6BnSoJfA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oxb6TgTgahHFKWjkTywb0WH5RDaPJCwf/Op5UWTFBmgL/BVSAWFklJ9QZg6VaddngCyd306nvmrRg0yBm2XMuln1D3wVck78o3A0paUHOmPwnEu7qVwgTQJVw6QLWOApjyJ4DlvZmmA13xbjingt81ley9+TUEHPqqYZiYgDN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPswSjuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPswSjuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B41D1F000C4;
	Mon, 19 Oct 2026 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416558;
	bh=cB0GlJS3AKx50361xN516y4fHxDgdIqtRfj6BnSoJfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CPswSjuAdE9CUFR4QnTFyYtJxH8OjINaAp7MtHEVUPa0yJP/2WL7bb5Jqb74VXSyp
	 TIkwDCP52t8NUcqSqg2iyLRU0KQ3FMihF6OR+JvT2XxUd9vB8ZRo1eDXd0Lj1iFCc+
	 cO5LZ4Ounv0Dwrlznub4gNiH4ObmoHx7vMnuRdF4qY4KRpJVq5sE4/DzfhA2iR/t1g
	 4I2RZDZNfi1SmX2C2DjANywLeAlHYjxbyX3UODDoWsjbH2+pxM/V/CYL8k181sATCv
	 5nHMLN5YnhCXOuDEGszV361p7ck5VXtkFDwcC3u97qrPlKGr/q3qUc4riCglL77gpL
	 2YstkY4dHk9vA==
Message-ID: <sashiko-outbox-177152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 16/49] cpu: Move CPUHP_AP_PERF_XTENSA_STARTING post
 stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019130856.49711-17-frederic@kernel.org>
References: <20261019130856.49711-1-frederic@kernel.org>
 <20261019130856.49711-17-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:29:18 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> all the teardown callbacks while stopping all CPUs in the system. This
> doesn't mix-up well with running RT or isolated tasks.
>=20
> In order to transition smoothly from global stop_machine to finer
> grained synchronization between teardown callbacks and the other CPUs,
> a new stop machine post function has been introduced to be executed
> after the main one with IRQs still disabled while other CPUs can exit
> stop_machine().
>=20
> This state doesn't have a teardown callback.
>=20
> Move it to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019130856.4971=
1-1-frederic@kernel.org?part=3D16

