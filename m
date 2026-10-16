Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C53803D3
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124998; cv=none; b=i+TrTe5u/4kBsc7GlDk40XLHzY8PCNNIt9Mb7m35zlIXQnDfbEKEyBn4lJ8np9vHE2Y2I674EoS0JZwgHnXBkDiO8zLzPMmC1/hk3weQoPcHOKRRHQBe0sCquSH7ADqplQXX3p9061+H/8TyIdhiv9yGG/edsmnr4FUvSaykzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124998; c=relaxed/simple;
	bh=71NCba5VgkWUudZn4J0XHYnVhTM9XUv+umLJTYxEGw8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sA2Tu5MCNKH3WrC/SqK0QNuExN62DN1tNvpBznUjaWC7nQWuIn+fkJLSY2pamkPwSz85VCsHqVN5ftA20nPcgRQnFgVUH9bVmDBb+MT0u1UC7a7zS+vEoH/3Qe6/fhEYQxJsWOw8FWfEzz5mhqcvUP6X8ZBahEapYeOIpKzdSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTwSBuKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTwSBuKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4E41F000C4;
	Fri, 16 Oct 2026 04:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792124997;
	bh=71NCba5VgkWUudZn4J0XHYnVhTM9XUv+umLJTYxEGw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NTwSBuKTJFIo8myvSrHVrxYG7RL+t4KaJVd/J2qHI43lMni7mawq87W+TcowKBPVl
	 ZkOxdf3y2GETgYL2rk3KNodZYLrF2PGWwTYlJQfSWIlVCYlnZVGtRFY5heVtjnlYLk
	 /qnNUeLJ1fLa3fm3dByRexGl7Ig0cSTaQtq8D4iBJyWWpN7+95P5Zoki9LOjIJhJ2i
	 VezrQ9z+EpUvmeSTah+1r341SFiYS/EBJOt3oGZAbzm7I/GQu4vHOieZZ3DK0Xf+Q6
	 zg4Qw34gY4Uu6KqLVRxaPiyh0wA1JyUMurt/Qq3eiHXgio6RCTIu8u+TsrHPIhHN7q
	 VeulZFINxgBvg==
Message-ID: <sashiko-outbox-173782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 4/5] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016040310.482876-5-atomlin@atomlin.com>
References: <20261016040310.482876-1-atomlin@atomlin.com>
 <20261016040310.482876-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 04:29:55 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016040310.4828=
76-1-atomlin@atomlin.com?part=3D4

