Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C8399356
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994960; cv=none; b=Xo8Spz8XiNb420eSoGCRudD0AZvpWJ8COggojbOoudTjKhB95iS5n6zJAU3Tr2xloRt+17eAii47Ydy1w2ABDsexAhHdAl/qE1GBFLWJCxLZyqEWS0t4GgEj5NT8EB5LbeCMvyghNq5JVqDk8PTEo1k4kHDa7jnhVBLqnT6YdFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994960; c=relaxed/simple;
	bh=3sJXmlSMhPruGKWFy1MjhzbHaMO5vQ9fTfens5LNacA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AkMQYODfH/iCN+fDm6h++4cb8IKQS3BJ/31WCZA/sQyNKVWdiAtPA4NNaNUQMJaDyibumLD+/tkZ9aE7bWkm9t6wvX0SM+QzPPA5+4C/b8AeyD06zbjSpON3a6LgEa1QtUI4fbPz+ogJ9EHAyGfR9dWNrCJJ6UCG20C7l9JTEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPL+aFxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPL+aFxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634D11F000C4;
	Wed, 14 Oct 2026 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791994958;
	bh=3sJXmlSMhPruGKWFy1MjhzbHaMO5vQ9fTfens5LNacA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EPL+aFxNS1LtNGCFlI8I6a2DIrPZGDyjWIJHnriWym0IiEI5CeZ6euoFGcnbb16hR
	 C8GIJjGKRB8XMdpTvByMm12ch8GZRK2SYc2yOXwUvquG/FSTOpt0VslVwTMjOaVw/+
	 1Eefb+siBnbl+SvjX9KvWWuv+4CTcYlqss0tCVXXMVIAReOqBsoaK/wqnbOLV/B1Vt
	 OOc+MrAdD8AFLG4EGllaFzcocaHc1p8TFyUIoMrC6a11SkwszVaLBwSwO5L477nJ51
	 WIVb6P3SLHJ2XV84PBRjuEc2V8tKKrM6ZWESWfMynC3fInRHHapDnOV84UeYbhwcVm
	 wALT5Y7bboSLw==
Message-ID: <sashiko-outbox-171523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v4 4/5] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014161457.373253-5-atomlin@atomlin.com>
References: <20261014161457.373253-1-atomlin@atomlin.com>
 <20261014161457.373253-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:22:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014161457.3732=
53-1-atomlin@atomlin.com?part=3D4

