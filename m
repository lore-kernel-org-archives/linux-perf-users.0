Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20C39A04F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522667; cv=none; b=sZEc6BzGqfiHgccAJ27Zx8VGvNTS7GihtmtHxIhhiAIK2HYTd2ntQpziePCeCxVrUIJYBBIipenfSqu1I0l5IKXI/gz/ZzLDwIcntDE3+F/S/jHyJsbAP0uwz91VIRli0wsgt8fN+TPHEk4ke1NJf2feCZKY81zmdNNA7F13+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522667; c=relaxed/simple;
	bh=qbs3tjok9GTG0Hi/gHagZWHRiVN99BkvWveAw06Yi1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kb7NiIxRswT3pUtwgc38ISTLR+CtEjJgixu5IXf8NiQk/06dLEnTpUyokGS7YbnDguD8UxGbgCUFjWeDpWyn5t38yDh7ZBjI24OwOnQvXTy27gwJwr2AbwBZE9uBurJvkOnH3u1cLsYvGz7PoaL9YZxy2f2jEMbJZk4DVlnDI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZsId3Q7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZsId3Q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ADA1F000FF;
	Wed, 16 Sep 2026 01:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522654;
	bh=qbs3tjok9GTG0Hi/gHagZWHRiVN99BkvWveAw06Yi1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZsId3Q7Q88hvYto7QvAZ0FVSa6X85KOQE/5aLNx1DdBoSNIJnAwiH9XYWmeo1/KL
	 xEcE28tjgkdlG2KYLDxESvIhfqkriJ308b0kG6lVdu+SEueWimaGnolDWiAwgJOjfZ
	 /T1usP7tYwGBaiJwYSRaCByjnmikUQyzr5/C2PQaI8UvqGoQ1jL6yr8tix5N70/UsJ
	 qdCxbFg/O1uA0Nn8+6VqN3hPH+xjcjE1ymEnEbprbn4ZAiqYkLA9GTOHlnoH3RV2Yd
	 CApGyVAx5JA5vqgY12NwUMBSDlZBLMLRfCK/5ZgW1c1CvPd4NNALkWLFOSmcht++bl
	 cWl2/p70ydd5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/26] perf annotate-data: Extract
 invalidate_reg_state() as a common helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a0278c0d5f01dc636823ffb4b5312a9ad7916d3e.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <a0278c0d5f01dc636823ffb4b5312a9ad7916d3e.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:37:33 +0000
Message-Id: <20260916013734.53ADA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The invalidate_reg_state() function is currently static and only used
> within the x86 data type profiling implementation. To prepare for adding
> arm64 instruction tracking support, extract it as a common helper that
> can be shared across architectures.
>=20
> No functional change intended.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D12

