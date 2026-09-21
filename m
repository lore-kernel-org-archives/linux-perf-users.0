Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C24A49B5
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005867; cv=none; b=TbU/Lj/jFr/aL5+IRmsZMhSvszA8ui+QpIQgizoa1zvIVer4my9h1oTSKtCRNVAeq5Tgwp/vdLfQm/5TMB9nLB9VIMrpeVWQ2XIIOSf7+c2dxQIVpj7HIdFBl1Lx47cfQP+0l6w7txU84Csqt/boAWj2Tojiv+3sG7ggiVnu6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005867; c=relaxed/simple;
	bh=Yecvu6r75NpG6nYn8nutv7JgD+p/3CmJqK+qRv5ciN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L0lys/84BLsVM1y/AnmeprvXMJbxvuIyIbKIt2dJHQfU539gH9rymgIqT1j1JQq9hHaqTXJE9SUYcyPBzN8JgC8v5jZKJXcDVIld4rYROJ/sa7iEP8Iac7tWpWpiCRVgv+OKbxEw/pUmSpEWC1gouQoD9CiW37FgfkEiKBkbDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTH7NUGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTH7NUGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F571F000FF;
	Mon, 21 Sep 2026 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790005860;
	bh=zKXAquTL/7qH58nVRiN8qkINQtpnItgQxdPw8r5NayM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hTH7NUGwQ5SJOpbGdI9gB+LXY11p53TTw0jUXQxK5gV2edNuSpJe/KY8nRIeZAneE
	 7+MmLMZ9oepTucXpFrlArA7kU7+s/EJ1u6LNA0Gy92wm9IfjmJMHiSGAo/jbnB4QCU
	 Do4EjmaCtytdpuqHQaBx1hMYzEj18Or1YpUbimen/5MRDyaFhKgG4zrzt0eBKwEYS5
	 VmT3ht/w8Nk5htUWD0RQV549YUiPNaw9E4D0hlbR30Mo2zyKOM61UPa6sfbwlDLPVx
	 okIWJ7MEJnsAcKdgT883BIrq8//9vkMLOYAeW6t+dv3Ybg9KEVlUlE6n9ecjqvLJtG
	 0Jqe2ivCjhffA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf test: Remove redundant shellcheck source paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921-james-perf-shellcheck-source-v1-1-adcfc107c997@linaro.org>
References: <20260921-james-perf-shellcheck-source-v1-0-adcfc107c997@linaro.org>
 <20260921-james-perf-shellcheck-source-v1-1-adcfc107c997@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:50:59 +0000
Message-Id: <20260921155059.E0F571F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The minimum required shellcheck version treats paths with leading
> variables as starting from the script's current directory, so shellcheck
> is able to source all of these files without needing the extra
> directives:
>=20
>   v0.7.2 - 2021-04-19
>=20
>   Changed
>    * SC1090: A leading $x/ or $(x)/ is now treated as ./ when locating fi=
les
>=20
> Remove them to avoid future copy pasting and confusion that they are
> required. Because the paths weren't actually followed, they didn't have
> to be accurate and accepted any string to silence the warning.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-james-perf=
-shellcheck-source-v1-0-adcfc107c997@linaro.org?part=3D1

