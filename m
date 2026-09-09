Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B337257F737
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970431; cv=none; b=uwVo5wh36vkWZJ+VZFeFs1e5ftsUXUOWaOsiT/cv43azKCm6gK6HZl+LHML183eNVeAfoJgkqu0Q0U8sUs47d/4rMDZr4tMnT1xgtYQO3Wm2r48wqolwUqUVscVFX7l0wZ6AnHE7e7NVhlWCZfKSWyBcOPD6CxkgN2oGRGumRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970431; c=relaxed/simple;
	bh=NQipTkbBWmvq2tCbdQ3fSoEAf/V4iKMyl+SDY6lTObo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bAuun6MflpsET3vr5CFApisF8030dVq0sRIwhj0Ib1zxivWgmrUgFy25LN+DEA1vtSidfQlRMh6bJ/fd6hg0jcoVLFhO8Ebv2S+faU36gDgJXalW1LRFD2hiAEuTBqlRYe3hCUZ9Wv9JZw7JI/81c+4CRr9d1yTGAkiSdT9EG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb59km89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb59km89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116891F00A3D;
	Wed,  9 Sep 2026 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970430;
	bh=fac0OYmaApf8+zng0bOosb1jSLNB/gEDODDo8Y/5hQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nb59km89rx4slirWRAJrVKo4aPzoziRtZzqHNrhur0jCaOna+Maan/TqLOcuiBtAk
	 QeqmITzshV2EP1uJKgazYYBYFB+EEClVv6uH93n6zaOF180FR+RBbI6lmIK/L8bq9D
	 73IHOau1VzLyR+SIK/MELrne9s2O+UQczF3rG0K1W3sOEx2sCdNvzHAvcs6ESFGXgb
	 9bRDeJg6vlrbzGW/wWnXdCjJJLHzZA5Udns/LuIGXS5ZHZcxWSxNBeQQe+MOX5XNhO
	 GH78/F+NLDGGQqmDFGzWH7twuXilVQFhHR/Mz0AmUJtA2Y6E2sh1fckfLeGqZYK48Z
	 HZTWgMklQEWmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909160218.174928-5-thomas.falcon@intel.com>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
 <20260909160218.174928-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:13:49 +0000
Message-Id: <20260909161350.116891F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Add memory region field to the cacheline list view to help users
> identify the memory region to which the cacheline belongs. The memory
> region field was included with the introduction of support for the
> Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
> Nova Lake architectures.
>=20
> An example of the new perf c2c output including the memory region
> field is shown below:
>=20
> Shared Data Cache Line Table     (112 entries, sorted on Total HITMs)
>        --------------- Cacheline --------------      Tot  ------- Load Hi=
tm -------    Total    Total    Total
> Index             Address  Region  Node  PA cnt     Hitm    Total  LclHit=
m  RmtHitm  records    Loads   Stores
>     0  0xff1b7032a1e8c5c0  N/A        1      47    2.25%       50       4=
4        6     1024     1023        1
> [ ... ]
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909160218.1749=
28-1-thomas.falcon@intel.com?part=3D4

