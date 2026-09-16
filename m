Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C21395AE9
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523071; cv=none; b=C34HUoT56oX0z91+lSeavtUORzwNFadeKqMv8dKaLy+2FRGUS7rLRmU6QFyNL0Rs/W5FaYSS7WJ8mNoJ0LY0ecrAbGQaK7pkb6mriA9MieHOweO08XknrRJgNdShsfHXFvgLSw0CmZYZ5mNFt/LonlUaxLUky4cKQXDbuA8WCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523071; c=relaxed/simple;
	bh=4TSXOyAYbtNa56pZqOS+cRg5P3uINuu2j7YBjbCFB5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MTsMJ2cmAa+BZUDo7WooshmUegjo8NJ4L55sOf+N5f8F0jc+8RfX03VdQFwHhN5ayyu9DdAjdGCbeJ+zAu1ZDnLn7cw2d1hhcBefV6YTdYGaTe2b6d/oLNS60JC0olg4SFmOeZc2rO18GQfPqglOrJjK1zSkFLVYBpZwa3Prp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E62TF2Wh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E62TF2Wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F891F000FF;
	Wed, 16 Sep 2026 01:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523067;
	bh=4TSXOyAYbtNa56pZqOS+cRg5P3uINuu2j7YBjbCFB5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E62TF2Whsb47hvFjB9T6XAgTzPR1CPd1plRRzqsBGiTKb6iLv6jvxkNe8Qtt27WjI
	 8RglbdzTvFQNjOznAA0V8nIMDcKjAJ6nqi3hO6bTUWFX/Zv5y4MQo6h/koV6G/7oMX
	 iKSckLw1ZuXPkA1wZDG6lNHmLUBhIDCwnVVtMvcXAStaGW1XOf0Ejwx+y0sSdFiD9e
	 CCkfSpLCRNkxcBR2M/n+uwJQKhyGl+aKkEfczpEPeWQTtNPGCBbmh6oT4CEKDVoQ4i
	 uVa6CCfHz3iRP18H2ZntIJmr8/tJVPRPZ5jdYsVbWK0r4q9OkDqSb4njqsanoGe8iJ
	 fB1sTy7tu+RdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/26] perf annotate-data: Expand type_state_reg
 imm_value to u64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <12af931b0d7a666f1d8403c01f1a3677698374ba.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <12af931b0d7a666f1d8403c01f1a3677698374ba.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:44:26 +0000
Message-Id: <20260916014427.37F891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The arm64 'adrp + add/ldr' instruction pair involves global variable addr=
ess
> calculation and passing, which requires storing the 64-bit address in
> type_state_reg. Currently, there is no field in type_state_reg that can
> hold such an address. The most likely candidate for reuse is imm_value,
> but it is defined as u32, which limits the size of values it can carry.
>=20
> To address this, expand imm_value from u32 to u64. Also update related
> compilation warnings and fix the sign-extension issue introduced by this
> change.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D18

