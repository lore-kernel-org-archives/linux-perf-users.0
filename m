Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFF2931EF
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618969; cv=none; b=ODEDtp76uabuaNcNR7A6Fa9CjrMCj22f1TQ4BGrATMLD0BLtVb4Q7JjRxP2z/6cufo7+6K3BnPRdtnJtpXgrVB/74rTEkQdOYKciIHX3/nnZmppY/+qZ27MbqYlfE3UL1BWUbLiuhAVGE4tInBPLRMNKDh5QjuRLftawY0h1rJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618969; c=relaxed/simple;
	bh=mTB7UQ9o/05RA99ikB+QPZ162H7epQ1mnNCAx6wGUXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YfwuVaesFOKf4DaXJKI9mo3su4WftwZxsPVWRQiLjLRSzojaebhoIOwrDcoCoa+CQLza3p+GGfXoYaZTtk/ofefbFO0Ho2Ej6JvJSHtTbXw/rWmmYBgSnh8yv/vT+KdWr/Zlz2LHrWmClz9VL+BSzb8FPgtxkBdL/7VNo9d6zjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU5wB3Qe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU5wB3Qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4411F000FF;
	Mon, 28 Sep 2026 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618968;
	bh=mTB7UQ9o/05RA99ikB+QPZ162H7epQ1mnNCAx6wGUXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JU5wB3QeVHKdpRlWjzu+W9Le9L1muBzvCmYO5cn5WhqDQX4uZOkjRvCwFSnMEgegq
	 jz+TV3zoehgeMdaxEfzi7KFV6hqMNvTx0SE5mZ8JLHVrOHdbL/Ue9opB3OCk2PzGbv
	 eyiMywW9Yl/gFA30wMV5B7PJa6IW9iOQuYDdGAgWQ0csXqlXeWdYEhw/qysaLbaAnN
	 5GVeDTxv8sOz8bvRbQAIq5f0ASXMM7xnPq39sfsRZ2+vMbW9TK25EqU984RP2guUVX
	 X1dfNVLpLsghtU8xjmqDBhE9LX+bmZ482H6giSFfSq7f46eMvI0E/IIb0ZO3nLmei0
	 Y01t026XETV3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] perf/core: Require kernel access for text poke
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhengchuan Liang" <zcliangcn@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com>
References: <cover.1790573390.git.zcliangcn@gmail.com>
 <99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:09:27 +0000
Message-Id: <20260928180928.3F4411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Perf events with exclude_kernel=3D1 can be opened without kernel perf
> access. However, exclude_kernel does not suppress text-poke sideband
> records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
> and contains a raw kernel instruction address.
>=20
> An unprivileged task can therefore open and mmap a task-local software
> event with text_poke=3D1. Both opening a count-only tracepoint event and
> configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
> the observer receives the relocated addresses of the modified instruction=
s.
> For a known kernel image, any such address reveals the runtime kernel
> text base despite KASLR.
>=20
> Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
> exclude_kernel. Events that neither monitor kernel execution nor request
> text-poke records retain their existing permissions.
>=20
> Fixes: e17d43b93e54 ("perf: Add perf text poke event")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790573390.gi=
t.zcliangcn@gmail.com?part=3D1

