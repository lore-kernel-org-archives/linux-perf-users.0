Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0671445A2B4
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291987; cv=none; b=LJBwtLrCmi0XY/y9s2ixtxqVaHNejGZ7WJ8QytG2n089hcz3io9ZBvpJeYEtNbbEJX3f954qHMGIdmn8K1BAjayYzgyp4ScB0V1zvqKS9AsPkWDxdwP6mbl7tOI7QUaR63jIlVYrPoBoAuXPex+QazDj7toUaajUaKuNFGO18F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291987; c=relaxed/simple;
	bh=9pxjjPPUIUsDaEys/0jgEDJemtIAfksIfEhRpYdnZm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u9GXEdRfheN/C1eDnLKRMVMtTDGQhMtE0qz5AfNDMHHOXWz4/WL0M6pyrznauWJfsSM3ecvH/X16gvipW1ZShRUCOsCck1oFT2QeXbzr8Ycr9s42r6k2ZvMA/DkhFb5LtQsRlFi3pNbM8fsdd2rX+E0wjz40IZHv1P9WjzdwDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osDMuyYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osDMuyYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF401F000FF;
	Tue,  6 Oct 2026 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791291985;
	bh=GNY859pcj/nJU+0C0B0VxARBsgBmPwRJ2Ls2jCn5d+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=osDMuyYSFR7zlhTZrfpzZl+4UL0dJ4PRtqh5qF0IoVJtUt43fJ7k4n/t16i8VuDF+
	 ZAn5kZCBgroNBj2mEG+2kemsbkB/KGGXoop1VhbJ8b+0nEeL+o8VwxVzdCyR6wQZb4
	 2lnSyXgWG77vG4X7ez0WsVitw2yffro8khi1jxixLu928XzZni33hc+YDL8jTS9ENT
	 cJMZG7gSLVIZpO34AZ530ODP3EzTVa6/yAnDQhBYPH89Jg09XUMFlFkTjOGNiewdr7
	 MkgEK4o+a6LX7eKt5FyvGdkGExSZ/NFn11RS0gViCcFp9gdZQpTAU6oXXLyivh2Snv
	 tRmC+QukJsMdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf treport: Fix profile builder type narrowing in
 progress callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006-james-perf-timechart-mypy-v1-2-e2c7edf4dd31@linaro.org>
References: <20261006-james-perf-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org>
 <20261006-james-perf-timechart-mypy-v1-2-e2c7edf4dd31@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 13:06:25 +0000
Message-Id: <20261006130625.BAF401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Mypy does not retain the narrowing of an optional local variable inside
> the nested progress callback, causing the perf build to fail with:
>=20
>   python/treport.py:649: error: Item "None" of "ProfileBuilder | None" ha=
s no attribute "cancelled" [union-attr]
>=20
> Check the loading builder before assigning it to profile so the captured
> variable is inferred as ProfileBuilder rather than
> Optional[ProfileBuilder]. Keep the existing assertion and background
> loading behavior.
>=20
> Fixes: b379b70b7b7b ("perf treport: Show the profile while it loads")
> Assisted-by: Codex:GPT-6.1-Sol
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-james-perf=
-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org?part=3D2

