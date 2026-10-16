Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0F3EFD3D
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185873; cv=none; b=WpOen1xaHQN8HfY497XbSrlH1wOMbjGB59+zs43ZqB0eZumNxrvAQ4XCoYgvycaXqe6wRe58C2/Tt9rRPkX6/JLUiy/B8F/uKUb+/qvq3JE6jGkJssrjTcqRfv2dMapSZqoj9wQeY+BkK8WZ9zt1jaEWFj5xoaCkIzA5xG7G8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185873; c=relaxed/simple;
	bh=+jeUC+6D+uJtQMcU+dEVGXpvgnjj5oV+gnmlQZ37VWU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K3wJeQ6zsYRkOpH1E8KV2WutUQpeWjOu12ZGAriwTl6hUiTtC28Lbu5bV5mjSvPvM7KQDVbNnwuXVSGsWlBOrqlqCri3t1egnWpKwayUS5+dvR7Ni9L/STjFx8sPlnc9zutcr4xqreDEjPZytY0Ry2FWrlQUvhRsf1yz+SC8zMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvwQwT9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvwQwT9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E9D1F000C4;
	Fri, 16 Oct 2026 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185872;
	bh=9zhtu8yAjB6YmLNuXecN9TCnyXgG3A0SuuOMtmRz7eM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OvwQwT9Y8CuYJ7Hv8fWf74N4m+onM9ve3rOn/RjQywrwt3la+QAETt51txHGILVeJ
	 p7TMTwVMO/Cj7Xw3ToVDvqIiqGrx7O2uMvdhrZDIzv9sZhbMi0iuk9KiwmagJ0aVMB
	 YoruY7jlLaKxFDZtgfiCGt2VyYbO4rUB76Y1RN/zjKm398ZcMCB59LlNKrySmKz/gj
	 F4uViyNTLfAktzw4D6q3mCBN9f1H7+3EYdX4o4LeXnqitI4WivPFrPVaPNYUV6ujYA
	 fEP7JBNK2cIPRhSq24B+VU8uP5bN/JHzicYddUDtpCi4Jl9r22jQgZkjYm1D/NrY4D
	 DA82gIf40wLDw==
Message-ID: <sashiko-outbox-174958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/21] perf test attr: Relax group checking for
 ungrouped expectations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-7-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:24:32 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> When matching the recorded events back against the expectations,
> attr.py requires every event opened in a group to match an expectation
> that declares the same group.  The perf stat default metrics open the
> events of each metric in groups, but the test expectations only verify
> the event attributes, so test-stat-default fails with:
>=20
>   FAILED '.../test-stat-default' - group failure
>=20
> Only enforce the group of a recorded event when the expectation it
> matches declares one.  Expectations that ask for a group are still
> verified in both directions.
>=20
> Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based o=
n default ones")
> Fixes: 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd metrics")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D6

