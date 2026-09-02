Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAA4A8421
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364639; cv=none; b=eBnHuqG7tBwhUuvAKqHGAECcI3w4tg+Nbky4NIbyVnO+H8QrlCvKtj7yS0xFcIUWT245UGtXV+o7c2vGMYy9Xz8tFzsoylMAGBT/5BIwTpaKb9XosMu823HFJbURSTkEA+/1aDAcOU/0fWPEpKNKXcZTLJ9GElnSfS3JsRvoeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364639; c=relaxed/simple;
	bh=ga3INXNnAzgFoogz2t6GQ/33brsdPPOdi0vJuZfjfxE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A4MLfbpf8s3Ad00oCtct/iD86Gg/q9xJkkPc5zdWkggviV2duVPqa1olJ42Qchgnr68ZZdGbDNXZdB1Cp+hCzB2GliV7PIx3ZkzHJ4+rN20gs4zJcDanvtbpMjtJyrbpTsXTnqELmcaz3H6TfG9HPvGm11txkcA+bgIDh9KfazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgt6g7zU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgt6g7zU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A02A1F000E9;
	Wed,  2 Sep 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364638;
	bh=ga3INXNnAzgFoogz2t6GQ/33brsdPPOdi0vJuZfjfxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgt6g7zUI8uD/3A7TUsCDmsn/VP5/MbIK9Vv5KKH3OmzJdq9B7GpUTWMFwpGDQuWP
	 lHQAi9o9uTJa/V1E6mN+gVPCx6uSq5VMW7iDwHUjCynQkVTAsQMKkAieNxn6XdRZ7w
	 bBnQFiFA3PPhUWBf4pS62ubMPfpRbzKwsZR9/4tqTPKvcHWTs/DvVEvtz3BJ6CTGiV
	 kWzN+PHl1htzpf/gkMZdPVV+QwYJMytK0M72bO7M1gpjXU5Jpzs7lWOjdEhH0b7wqR
	 0M1F013Qm9MOq0lw8fO/jkHAiyzXNxfIMIT5+Rgw82KTCuSEdND4bmCeCFwpgj+oZ8
	 Lbgw9SmLJupLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] perf tool: Remove util/cache.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902154858.2078885-2-irogers@google.com>
References: <20260902154858.2078885-1-irogers@google.com>
 <20260902154858.2078885-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:57:17 +0000
Message-Id: <20260902155718.4A02A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Move definitions to places they are used, or path.h in the case of
> path.c's mkpath function. Remove unused definitions. Fix transitive
> include dependencies.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902154858.2078=
885-1-irogers@google.com?part=3D1

