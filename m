Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69A3A3830
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783395; cv=none; b=Q43lU85wssTOFwNGLDgpC6mD1qp4ktwm2phCogs1B9eO/VtQ5goLwOTmffkoW/Wnnp/Pt4/3YfhbmQGug5fdEXFWzCfny2hLXqTXHTTwuEkzjNt7g7XtOvM5e3Pf981njUoZ0UO9Yp2Fbp66KUK/FglVWX+R1fhdK8yl1XFdsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783395; c=relaxed/simple;
	bh=FhChpj6+oanbZkOeGOu7/Oa33HEGBy34PgjwA3R8I5w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mgFEqs9zbQCSi+q6I+4Ps1f1YFOrskuSc6skTRb/S63U/bG1ytTu2n5NwyPSb820BWQSNCy3U0udCILwt4MIsPKgPqCRANxNwIEeDxpJSYEFFEl2VlRwdOkvFD0ttQvseQNOvt6f+wz/72X7ZWLcJRtoOVV1KDR1dzWmpyN7JSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jykW2y6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jykW2y6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301561F0089B;
	Mon, 12 Oct 2026 05:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783393;
	bh=XurFOp+K3cH6PAsZemMjRYcVkdQXBK43za81vkz4TYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jykW2y6/LzNVoPJQ799nx+Qv0nQQ4AzHPd7ohuNvaSZq6tSH5iF8BVoZQRQBqRA6d
	 wM8MPKbYOLuL/WMQ48DNecQSiiC4GIjh1pn4lll0iY5Lnn5rAlPWdPZlLd4XkW5HkE
	 vzANES2UqlRGOcUo45ktc1cIIkCivTiFWFm3NhP9Jcz2QrKLvvDqNZzkY0BBL1Dyjq
	 ZOP99SYrIV6RVgiCO7Sz9kSvepkY0oFNKUfQS0vqoo7ME8Dr0z28eNQomExHTyNKyS
	 vC597sXGGk2WZCPv27fyLjsuOGpcnsiWGwFt/m5ZJnKoPvvSrdM+sQNrcvt+vla3+O
	 po8ypOt9MSoPQ==
Message-ID: <sashiko-outbox-167675@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf symbol: Add missing symsrc__destroy() for
 libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012053013.14378-2-namhyung@kernel.org>
References: <20261012053013.14378-1-namhyung@kernel.org>
 <20261012053013.14378-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:36:32 +0000
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
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012053013.1437=
8-1-namhyung@kernel.org?part=3D2

