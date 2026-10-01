Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1F3E315E
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870261; cv=none; b=qTHs0f2cPzs44DxBFsmPz225sKCN75J/FV33xZofEaEnmmnB8v+oD2lImAWRdhp0JtffncXWwiyE1CeWvVIcgUv9OZCNDlJJjqIWpeM1fr+jc1Dz5gLyspyaJWaTOIZZ3ShK/5p5ekdqjGLHMADJjiaPyXMnIrtMvVWNLRsH+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870261; c=relaxed/simple;
	bh=P5lpP2ZqvMFYvQuI+CYhdn7gK8WfkZdXbMrh/eedgTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YBlkXn6LvZbYe8kE1cJ5BkfM87XdrDMdLFV0Q+9d/jZ95i51JQU6dV29c6dSbI73AsECwsDqD+mnvtEm6Q3UNljgnSpWajNEtswZPz5EDVTPQVGIhKEPECZcKstIN1exZjeRmjAliwt21Qf/kGfBs3Sz2065k4kb7hLqiLYhxD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN/HNai1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN/HNai1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7081B1F000FF;
	Thu,  1 Oct 2026 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870259;
	bh=fTkUPIvLmPR58tzyZZX26RdT3n+jI1TsqQGX+yhDkek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HN/HNai1GbLCZSI3wop8ts0whOpDFfx+F36YzX5oyp0TLmRhxzMWgLiSsEHf3+5nv
	 Iz22UysDK+77kurLETfsq7ydzmVsM3ipij5jgCqg6iVJDqof7BYdwttwGjH0AccmAR
	 EYB3r2qIdICTkPuN0G70qFHIbAqR9NcDd46+QCZIjmMMfGq9H2vzqNOW2RQ3vpbU/U
	 Z8LBvuZlVD6CvE8XfPtBhSc2COKOP5xGTyJqFdGix8nSx+8ppglHwjGmcw7iXxJQsv
	 /spUD9s/MnaKA6AY+qtoox9EZof9mSPirTanOhNmnNN1pvX5J4cwR3bgg4hyr7goLz
	 rvHsGX1pLogKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Replace optparse with argparse in attr.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001-perf_replace_optparse_with_argparse-v1-1-268b604f8e55@arm.com>
References: <20261001-perf_replace_optparse_with_argparse-v1-1-268b604f8e55@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:57:39 +0000
Message-Id: <20261001155739.7081B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Depending on the Python and pylint versions, pylint can report that
> optparse is deprecated and fail the lint check. Use argparse to avoid
> this potential warning.
>=20
> Preserve the existing options and defaults, and let argparse handle
> help and unexpected positional arguments.
>=20
> Tested with:
>=20
>   # ./perf test -v 'Perf attribute expectations test'
>   78: Perf attribute expectations test              : Ok
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-perf_repla=
ce_optparse_with_argparse-v1-1-268b604f8e55@arm.com?part=3D1

