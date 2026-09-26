Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851EB38F935
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404608; cv=none; b=qmb6UD/+WJrp1kpCnZxRj7XIsOUwUCnYI9KCvXr/i0SfQMZklzFVC7CMQGfI/TjIE327oVEKLE2kH2iicifcUSrPXPcPOV3z7AQzVO2exKMTCUDMBYUgrsWe02GKLup4tfvuMMUiJG3sAgMmplWzMYrTQWuT28FgwnSaeKdrP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404608; c=relaxed/simple;
	bh=jfE+i6es5GotiwNCtLfbP7ostHP6r8kg6fio9nMZlL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jv0NRUhnRVOVWnHLzEoCBaDCjdKn9lSDgxI1ucu6SilZMGgAlk6f2DGufHt85T5D0DTDckhSK+oVNMt9GaPnc+Wmdm1oib+PNwGJPdToeebP2fI8X8/YnZzxzeBKvhtMcXTbu+cgNelnq9ghbfZ3+wvws1tmU/I581mTceNVALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwScfzlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwScfzlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4531F000FF;
	Sat, 26 Sep 2026 06:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404607;
	bh=jfE+i6es5GotiwNCtLfbP7ostHP6r8kg6fio9nMZlL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hwScfzlLOf+ewo9+xh5zctMeQxiScH2P6AHhz8ZM1DEiOJjEGcbeHJg06wcC50oKt
	 idfJ9cPb/y4qDWYBCk1KUNXAQYBdwbXmxKRmnRn4/UH2cNBygj4IBQNeyGQbFvAt/E
	 Btk3fGmoq6tXSqO2UUpCsMfPbmnxw1QQVDdMY1H6O/xZqj1DhRBSHCV2FB0z9IRrIV
	 HJVKVwPWYI0B4awNdo4Q3xmVlQdv3yEpyVjMqbaVrHIQt+WbUnZPou4oCStFQT702C
	 hpheRwciQyOu5PLF5C3RJQWB1SAJeXClT9mLi4UJDqiTeH24hAoID+akivvBqUcnqP
	 /9WdF9jEpikWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 41/49] perf test: Migrate Intel PT virtual LBR test
 to Python API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-42-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-42-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:36:46 +0000
Message-Id: <20260926063647.3C4531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Migrate the Intel PT virtual LBR test from generating an inline legacy
> perf script callback to using a standalone Python script
> (perf_brstack_max.py) with the brstack iterator API in the perf Python
> module.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D41

