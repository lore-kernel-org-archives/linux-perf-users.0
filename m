Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F993A8FEE
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263523; cv=none; b=BWlT17UNM9LLOgS0Quu89VnSAK0bwAgSKx9tI8KJ0kff0jluiPaxzYE88EH8VJs9AIvPr/kn81R0ft/GR9M9cdF8iC1Rn87mgNe+1kBPFCaglWvHxClW/1Ug/8tM/pwHrBOghIA7U/EVzgeQcHhbWkGDHkUm/L8TbA7Mu4uH4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263523; c=relaxed/simple;
	bh=1f1rABpUDg2NbnpeOBuLokfWbrBFaIY2yRZQqF9FOBg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=atW0hb2g1wJf+0+USmJPJDr24QUw3MfKN/WfzQ1pBe+h9o08XDkfFCRUuOBcg32oeI5xtQyd5l7tpOo383Mqaj596q8r4K3nxfco4/5jnT0VDat1pDj8Hmz+OyBHulSX3uy9TC+tSbtaX6dgeQNosdWkMjw4Fm/t3YEhOHvsVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h71+4+U7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h71+4+U7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359B31F000C4;
	Sat, 17 Oct 2026 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263522;
	bh=1f1rABpUDg2NbnpeOBuLokfWbrBFaIY2yRZQqF9FOBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h71+4+U7S0BHCrAj9phNhsh49s4BPvYXbmaeQmeeQYH0Z4hdDnm7Zee8DbKenpiST
	 Vf/2K0vugDCkrdf2eeVLG2JGe94zTrKifsyfRlcdgooVYl3Nd9671ska1SgXuy6XaO
	 heMM64YAeKxCXd4I2XCIa2yyBzdewnNEcMWc40wZrLlzeiXTjGCL/wdwBjppFRxpjt
	 8x1Iwo+7ecP56esPz6Df/sQc3N3ENZdkbjb6JTLZOI9JNtQ/4yblNSRuU1mzyf/8Up
	 Spq/nJv5b3dtrPksVjvCOg+AQgR2G7L6JSty7Gk2MU90HtkES2FGK9FbD5zeanc8IQ
	 eSVrys0K/z0bg==
Message-ID: <sashiko-outbox-175770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/9] perf pmus: Expose duplicate uncore PMU
 scanning helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017185442.2137623-4-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261017185442.2137623-1-irogers@google.com>
 <20261017185442.2137623-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:58:41 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Export perf_pmus__scan_skip_duplicates() and add
> perf_pmu__num_duplicates() to count numbered uncore PMU instances
> sharing a common prefix.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017185442.2137=
623-1-irogers@google.com?part=3D3

