Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5A54705B
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027166; cv=none; b=SD3aB9FN5/MPpjQyqts39WK+0h9gnC98s8LxBYe59aYBq1hnac3/yFU5ty1xtSEAMawnaySpzHsIzFwgjPkH2YJuKP5RZ8hlWQ74/mTLWaiZ1i3OPJOC5SCELtqYTJowIoyI/RQy7G0oj66nySzXDnHW9Gk6sxNTiH4/wW+vKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027166; c=relaxed/simple;
	bh=rs7cg12rvG0uZGbxHg5bAdsBMrK42e/klGLrhFLzj0I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Axz3BZdlKqqUOu/8znZOyshMZCwJBtpyTf8cZEpAcIdf7LKGgw8Txm3zRFKSdTe3XUN+RZUoDCgPz2TW1ER8XjlR0WIo8CCxdETHmpI6HwWuGkoY+nmSZKCam4PK+7+TZuPFLPl3ARaSLKhe5hyNhS5odq2Brd48lXnwhLAiTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5McM4wX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5McM4wX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B611F000C4;
	Thu, 15 Oct 2026 01:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792027165;
	bh=rs7cg12rvG0uZGbxHg5bAdsBMrK42e/klGLrhFLzj0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5McM4wXIHEdTl6G3RBolvpa7+Gd9xhV9tOZm16YgFI9DndG/LX/oIcN4B+Cb9xAG
	 Tid6KqEvLGlq/kgnDNzUeIo605pi4hVUNYQlchiUAey5Zoix7Vjh82rksGvNSm+iDI
	 YklymFer6Nyg2pBrj7J994TW7qfGMxe8cl0pGZjXxxzlemiDpxf13XC2Nm+14L9GOK
	 JJoD+ESpL+4fn7Kl2AsbrnIMqJn/sdw4VKtCe8tatdkf3djzjplQ/ZAK+x2npT7Gcf
	 fdLp4EqfVicP0wG7BrbdgAUtr00cHZf8vIKI05JU76b7RMuW3AawjdMoEceI1WOJI5
	 uVdKuEksCefqA==
Message-ID: <sashiko-outbox-172084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v5 4/5] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015011155.414667-5-atomlin@atomlin.com>
References: <20261015011155.414667-1-atomlin@atomlin.com>
 <20261015011155.414667-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:19:24 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The Linux kernel's function graph tracer displays the execution duration
> of completed functions by default via the funcgraph-duration trace
> option. Whilst informative, in scenarios where the user is solely
> interested in the call graph topology, call flow sequence, or inlined
> hierarchy, the duration column can add visual clutter and widen each
> trace line.
>=20
> Introduce support for omitting function duration by exposing the
> noduration sub-option under --graph-opts. Consistent with the existing
> nosleep-time and noirqs sub-options, it accepts an optional value, so
> noduration=3D0 explicitly retains the duration column; when specified
> more than once, the last occurrence takes effect. When enabled, perf
> ftrace configures the kernel's tracing instance option
> funcgraph-duration to 0, and restores it to 1 upon resetting tracing
> options.
>=20
> Because the profile subcommand fundamentally requires function execution
> duration to compute timing statistics and call counts, combining
> noduration with perf ftrace profile is rejected with an explicit error.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015011155.4146=
67-1-atomlin@atomlin.com?part=3D4

