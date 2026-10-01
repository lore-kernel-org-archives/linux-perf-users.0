Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D336BCED
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 02:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790822354; cv=none; b=gvlcQE+Old379MjxmkXINmZ9Y5bSi1I45Td5P4M3dmhwAGIBpBXbaF4OTvobYedAIUQdNTxpXHjtjawAnhnDHSrq3e86FSSRjyt01xb75LsW64xYb5KOFoXmft29OTuLsl4hp4IjJUZAyTksLRi+SsLh9UbVH1FhEMBvhoph2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790822354; c=relaxed/simple;
	bh=qmsJJx9dVWOJfuSo0fxVhntRNZ+6QJ+D74p6CoQG9fw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dd4/AWyT1uwkvK/3YMWmNIlFVpwX32G8J+eOLGcrs/RudVCmKeQgCKroBPOzTaeaswCDSRr6PwlNCg9Fgx1A/kPaGFSxl0mOq91xzEA1FUc0VEly3+uZw28MeooeyvTgOY1pVyPgSZpxCkYiJqaiXE0LSOPfsJN790COP2jgxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyPNkkIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyPNkkIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660E61F000FF;
	Thu,  1 Oct 2026 02:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790822352;
	bh=qmsJJx9dVWOJfuSo0fxVhntRNZ+6QJ+D74p6CoQG9fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TyPNkkIqvs7+aJvzPaZTN1IYPsmCksdAMF32o66bOoIIP4oFN4DeyWCgyegTFpxtA
	 AHHxVZsi2gfVv11m2pbRYQ8Zy4bydEYOdC4DstCionkaGkK9n/CUsnZz99cAaIvldR
	 o1ATbg1hO4ulhlxEWuyVViK2Z6eLqiMO7LBByLY+5fOsbRuiTGnCPrH8hZhhDfUQJg
	 S3zJ+87128+G5Voo5X+unKoL1rLqi4PwtkJS8x8+MeukfDaarxjyIA03kg9ueLBCy2
	 HP6a8AxGFuLOPMiBbtp9xA0UWaoy+6ZJQV79rAsg7REGl+Tjq8RsTVdWWCYUchJEpE
	 5Tp/c+e7N3vvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf test: Update attr.py to use argparse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001023423.1225713-2-irogers@google.com>
References: <20261001023423.1225713-1-irogers@google.com>
 <20261001023423.1225713-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 02:39:12 +0000
Message-Id: <20261001023912.660E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> optparse is deprecated since Python 3.2 and triggers a pylint
> deprecated-module warning on newer versions of pylint. Replace
> optparse.OptionParser in tools/perf/tests/shell/lib/attr.py with
> argparse.ArgumentParser.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001023423.1225=
713-1-irogers@google.com?part=3D1

