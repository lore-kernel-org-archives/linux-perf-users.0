Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59D3CD8CC
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129249; cv=none; b=CoQFTKgkN36hWm7FQe91R7PEDCo2Dr6mgIkaBwIx1URQ7cSgDevecN93Qwql+l34ccAPRc19R+fFWnklUhySeOROnNhBpvhzB97qFow/LxKDgDJwi+QumbMEqCtrCWlP44rTSvW3ZRGKSCpuezmURINUlH1qjumggNr6hgICVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129249; c=relaxed/simple;
	bh=oKIZT85hkEtJfaVpZSvchm6YdJo9zWS1OG0NX8fKK4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ocUMtLIN0JrPpAYFOpIzymEHK37OmJL2qmLDxYDJIZSVaJRLFn1wzeL/LgNVkmVfxNtqI9EFaVQaQis+eyJEXtwUJeNqaCBohfWUsIQ8zejSah8aL+Ziho8CmbV/U2ZplJWiJsmHo63E1Zw2Bvm49A7BZrz9z/HQuob8pvVhseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2AWTefJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2AWTefJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF941F000FF;
	Fri, 11 Sep 2026 12:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129244;
	bh=oKIZT85hkEtJfaVpZSvchm6YdJo9zWS1OG0NX8fKK4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2AWTefJkesAWAuOJG+vdX6k4YsVAFMU+dwRPb9u7br2UjzjqslVTebzrTtI50dJ5
	 AblfeLYvWQrkI0vW4mHRK/duB3cvOOQX8sANwZmYhBwPHqKEwou40EA8OWtzWmNIs7
	 XxI8zAOa2jzOuaHn5DsNuMQg9FFjM/gkxRSTCq3ICJYpaqSVXFoA0P3euFwb7SyD0T
	 5cwTP3jSxdCjtutDx5krkwtUI2/bxtWsoClYjl3E9eVf2tCoZ1ZG6/tRdg6mPSenVW
	 j823wgqBh+kj3oqByR12zEjm1mqyXECJp/KEJY5+QKHviOmET1HXIdTSLIO3qHn7+l
	 E5+6U3VlS8/eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/9] riscv: add SBI SSE extension definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911121456.33223-2-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
 <20260911121456.33223-2-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:20:43 +0000
Message-Id: <20260911122044.6BF941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>=20
> Add definitions for the SBI Supervisor Software Events extension [1].
> This extension enables the SBI to inject events into supervisor software
> much like ARM SDEI.
>=20
> [1] https://lists.riscv.org/g/tech-prs/message/515
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911121456.3322=
3-1-zhangzhanpeng.jasper@bytedance.com?part=3D1

