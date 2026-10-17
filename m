Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47448DB4A
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247535; cv=none; b=IJlUQKpnTlXRq0WCxo6BC/Y9+AmptpSkVeIztFqI43RmiyWL0JUfflWxE+1cg6vXpmjxqAgZhsaoq5PyovXY+Lio509/nkt0rbsp/70HXgxSTofNzRQ/afKetGeklXEGPLXdcURZSsYuXPpjd5tQZkpjZ2jExw40xKIjzMPT9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247535; c=relaxed/simple;
	bh=S0Gmbo+mYmbuEPUrh9LMcGVI07IALSjXy97bg5XJ3+s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=U/fLdkxneQcYIsk1Adb8/YdzVlOg9rHrk0EO1Fj8A1vD8oEBSeDc9/ye1eGbwaLH0mvH/4U9dgrQ0UtMAmEBek1fjkGTl/7b7+rzfEWgQTS/73YHn3dVbHfS5bNtFsrahcbh5w7qMFlQLE50dI+YgSCpuM/v2gOBbhajFOpwaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq52zJaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq52zJaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEC41F000C6;
	Sat, 17 Oct 2026 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247534;
	bh=S0Gmbo+mYmbuEPUrh9LMcGVI07IALSjXy97bg5XJ3+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oq52zJaCKyiZqvUVptlrAGxRxzu5faY//iVFbPhZa2YnObCcFfCD5TF4fgnAw+HpR
	 w+1bxbQ9bsRR5m34tOZBtj0pokQEbXOuoC648VMpg8cX6Bk0eY9MzFpKYOdIKM3lU5
	 xqtL8v/RYdNPYKEI7H2yIo0GfOQlSTdzD7CaGfxtQOgURTjUQD3wcdgf49JjSKrCSB
	 YYtu5fLoMEE+4xMJ0jgw7mORgIc09+jhCLgWpDIQAIacUQwQGf7MLn5Vr1Iw0Wu3uz
	 Xl11Yl+F1Fw2d1pTFQpSn8bimWaZP18lZgv0JQkFfGOfCEOigRoRTirDed/3JzOUIE
	 m8VdzREFkvcUQ==
Message-ID: <sashiko-outbox-175558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 7/7] Documentation: describe building tools with
 the kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016143143.3613501-8-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-8-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:32:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Mention CONFIG_TOOLS_BUILD and "make tools_build" in the submit
> checklist, ask for libc-only selftests to be added to tools/Kconfig,
> and note that USERCFLAGS and USERLDFLAGS also apply to the tools.
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016143143.3613=
501-1-sashal@kernel.org?part=3D7

