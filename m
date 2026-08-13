Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78783E5595
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659789; cv=none; b=KfsjE6L/OhpKecrLDfMsdgXvRGfaT92og1dwj3s1K7gTGkPkxZxEQzFE3a1GS4PKndJLYNGkJYb1AmgQV4nS/k6bDisWqKfSo9Bq00oGUeqe/7ITbFYAwxU0wiM2TgQFfsSKlZCP3RzerfjAHtn+XS9uX8eCxGAGx8EAHkXZQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659789; c=relaxed/simple;
	bh=z+cealm0nOovOYN+bsDZjEE0oZ4zj1eQUTUPWlz25bw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E4hasnd+dZ08Q2nK9oLTSeHX2pv6NKpABtVTrqdpAZnuYmkA6WKOtEWgOjSxwm1nLmXxUAIP38LwYnbo75DvCO3iesjhDaDoZQYP8iP7thgIA8rd8vHsXB5JGwFnV0rrIF40nzByDKUCHOvHXbSHX78XGYXk8VW+dxn6XeRy78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCVZ3ULF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCVZ3ULF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688201F000E9;
	Thu, 13 Aug 2026 22:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786659788;
	bh=z+cealm0nOovOYN+bsDZjEE0oZ4zj1eQUTUPWlz25bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cCVZ3ULFV6nGIKolqKavPusM/NaBGXKV6y8PyjdmJdLLSRVmevtVR1SvgP3/znsya
	 d8ZgpcszQIXcYmnwAlt0W29ndzudWVA7xjk9n9BJhcJCeG2ZXsfg3bTBRXQ8ngshTU
	 eFzhQY/BFx5O1q7Zd4l6q8B2oQ3XBTU5CE6wqE0C0flDfId0Kw0mlp9Yxp3Xuh0acy
	 8z+6QXQJd0jTzAqJ36fFrr3uiyaHHMca1xUcspBXpGeWv8IeWHpiKERQudxuh65mUX
	 dazO+JYVzIyECyCNgEgdj8cLQZsZZ8RVgs2cuFveEC6M9ju9Y63QVdzY7kuBkEGZvZ
	 870u0ekx9nWyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/25] perf callchain: Don't pass evsel and sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260320080835.724836-9-irogers@google.com>
References: <20260320080835.724836-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:23:07 +0000
Message-Id: <20260813222308.688201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Change callchain resolve code to not pass an evsel with the sample,
> instead just read the evsel from the sample.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260320080835.7248=
36-1-irogers@google.com?part=3D8

