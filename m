Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44FC377AA6
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991220; cv=none; b=pLExsBLTQ6B5ffELtjd4mr7+H1HUK/6+xzE18s66SBNInz+OB8IYwhx/6/1+ofk+5OHSCOaM9/uTAZIKGxY5YWgc9JS5qoQUAQONuXvDsd3EevDM42alxCcfxo+7deOSurxQxjku7kYOOnFfopAThrI7y0MqJYdeBywxCPFYUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991220; c=relaxed/simple;
	bh=915golX67whQ6/ofvlxeqBpVr/QLTEwqLRMpKX/k7Bg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ARXaX0uuFFzbsGpAqXfWyhOIcqFmgrP1fbuTbvkEjwM5DIeT3LPhfZn4EhXPxjniy+c81nYxXWRTnUL71lN4b3eNeU4w2POW90JoliFYz9ubpBtaGRdRSRn4eTrpQW42HJSACWZKweIYRj97kAY2LUaXMA4zSSN/+CvM5hDKeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm/XsK+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm/XsK+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4546F1F000FF;
	Sat,  3 Oct 2026 01:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991218;
	bh=915golX67whQ6/ofvlxeqBpVr/QLTEwqLRMpKX/k7Bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nm/XsK+n3eLdjORdK9BXnQUhupkzV8HHn5g4fX01Kx/6JAGLV6I2QCpvPeaf7es+9
	 Pp1dADdE8viW3YWJSdadGa1ZndHYFNa9Nj6XEpY4DGfK/PhI3jCl1HYeyAbJVyjtqY
	 whdmRqcqwXPxwKNsxB86x9h0KiKgg8NSjPBbghIoCMEoXEHC5YkIHwtmm5qFWOYTHP
	 Gi8obrBE5/2mUQUjAPRQ8Y8dfuLNAutAddk7NFPehAtu77iBdTB55PvWFRuGdtcf6H
	 OkUWWM3gmLRCl+E4X3ZuH5b/cU+GHAfZ/gbLV0nZsqw7ipcWEcKYCQrxEzcvcQbTvL
	 wD+YQXUrdbuSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] perf symbols: Factor out duplicate symbol
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-perf-symbol-memory-send-v4-3-0a592bb2539e@uber.com>
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
 <20261002-perf-symbol-memory-send-v4-3-0a592bb2539e@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:37 +0000
Message-Id: <20261003013338.4546F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> symbols__fixup_duplicate() chooses between symbols with the same start
> address through choose_best_symbol(), which needs fully constructed
> struct symbol objects. The lazy symbol loader added later in this series
> selects among aliases from its index entries, before any struct symbol
> exists, so it cannot use it.
>=20
> This patch moves the policy into symbol__choose_best(), which compares
> the size, name, type and binding of two candidates described by struct
> symbol_candidate, and passes the same description to the
> arch__choose_best_symbol() hook. choose_best_symbol() becomes a wrapper
> that describes two struct symbols. No functional change intended.
>=20
> symbol__choose_best() is not static so that the lazy loader can call it.
> struct symbol_candidate stays in symbol.h because powerpc overrides the
> weak arch__choose_best_symbol(), which takes it.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-perf-symbo=
l-memory-send-v4-0-0a592bb2539e@uber.com?part=3D3

