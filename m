Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AF3E6DEB
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622064; cv=none; b=genAv3qisX8TYTineNzibCKiYk4Ns1BEWdcwp4hqBvfvjXI0PjZOx0JtAGwrxlp+W3jovLEDiMK41jSMNf7x6+jppxMXaH6wTuVWV1bvY5frhSpqz3QE5KS88j4m4PX0XM8kqz61rfC/Tn+DbUhdgu33PexfdYSz60phETJ5+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622064; c=relaxed/simple;
	bh=kY8W0IEDVQJwuCIqp2c2oDVp4uV9CuCA89cPBGexoBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rQ25pti2glWso86xKLPLho1bjiA5fX6XzZNpfGtaheFDqRcWJBnjk3dI9SM/e5ZDhkl0zv26jew7Djg/BwnmBN+vQ8cb47C60IxGp4Tny9ud24/uMs3Q3FhvERyb3ahbziHCoyQ9euGRvPPCD2GkzrKsGIzPXUL5+2wsb0iBi6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxU7Tk51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxU7Tk51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C0B1F000FF;
	Thu, 17 Sep 2026 05:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622062;
	bh=kY8W0IEDVQJwuCIqp2c2oDVp4uV9CuCA89cPBGexoBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxU7Tk51ZIMLvs+pAnA0WxAWLAMjBEgQI+g2/0HHAjAdfsfGIkx6noK6FOaebRotE
	 cH0OzQKYy4yB622q8Sj6hdR3HWA3QuydKaekAwaSmIx7YotI2q3empRsCubJzT0ac3
	 VT8EAjGY3zB2kOEvnmPnAAFOmF4z9wPVK7XKGJRORB05+plFI0+NIAbIkCUadX4JiO
	 aCvGTsSq1HK31jh66Xg4HqrlogfR5QEaMH3NmUwDbXUY5A5aQXjkvjMgmQlAOxsxWy
	 4hq/AGhL9KLLOZqcY1v7nMOVDOYVYnwER45PDiVqLwSnusDD7+Ip+Yze3zZcO/y9xz
	 89ZSWqjXZw/lA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] perf tools: Add TUI hints for --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050708.704702-7-irogers@google.com>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:14:22 +0000
Message-Id: <20260917051422.69C0B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add dynamic TUI hints prompting users to restart with --hybrid-merge
> when heterogeneous core PMU events are populated in the sample view.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050708.7047=
02-1-irogers@google.com?part=3D6

