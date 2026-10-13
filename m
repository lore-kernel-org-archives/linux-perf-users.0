Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA68547071
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849865; cv=none; b=kpNHz2Kf/tWyrqpTLHGjWIushrNgcJmpJ44JgZCsW3ouaRdWdu/Mf+oPDckaI507Nlb+Y5u2hClfbYmMXInrQF1yeHoDsBwR8LOHpHGq3A3TR0sfWn93eLOqHTn6foiDYjfXTjv7B2EzxwaIOh0YRjODoxVIck0XF5qkL79lq9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849865; c=relaxed/simple;
	bh=AONga7dVCvRfM9cPDonN5St78ZeA0PIc+iW35/9SNVI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iQNkXS5/ZPadWHQLKzvf2lES1TzdnjDu8WdPFk8opp/Ov961UVqL1CpyLTfdlPGSjbkDAdTJToDItFdYrV4Si7+D0CJY1psikBHQ3Xa74x/PDki+lOg0c7Z9eUHVmcdI/bdmSOlgfjES3gnBm3wNZTiTcTw+KTHCqo11EJRX0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAP3uP5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAP3uP5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6001F0089B;
	Tue, 13 Oct 2026 00:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849864;
	bh=ROV+gTHf8xx6CoMw3fiXjZpr4hvXyjm263InlpCXuC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oAP3uP5Fu0zdQwgf20yc6c7nbylS8zTfsaN2Lym5tsuCLm69T61V7Ij38g+nYdY17
	 IarErZn8y6ESojBI8/IqYXNh2thL5Brjh7fAq9lxH03gFT4RXlLfOoBsDN+Hfl4CiA
	 l7wD2ATET16cM4hozWqc6KnnCAabkHyiyB2slr887Q6HFTuxKYoh0b11JRIA1PpK53
	 l7KPbm6aqXemdAdvoJ26gI91UXFMr+iOy6uKkbz4b41ieYcSlGiMNmwZ2hlP3LbUGw
	 huuqztG3zA7/QhcxCvrZyLd2M6BUa1x9HEwQQPEGOmg+YDRSwnx4DEMXX1Wyxga8Wh
	 cJDg2ect5du0w==
Message-ID: <sashiko-outbox-168768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] iperf symbol: Add missing symsrc__destroy() for
 libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012235938.87912-2-namhyung@kernel.org>
References: <20261012235938.87912-1-namhyung@kernel.org>
 <20261012235938.87912-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:04:24 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When libbfd loaded symbols and there's a pending syms_ss, it'd be lost
> or overwrite existing symbols.  Let's destroy it before breaking the
> loop so that it can safely return from the function.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table wit=
h libbfd")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012235938.8791=
2-1-namhyung@kernel.org?part=3D2

