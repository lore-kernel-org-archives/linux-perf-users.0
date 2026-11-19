Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114936;
	b=41b9mCzOWQC8LuwROLpgLe2cJJzVMzJRBU8+wIso6r9+EtrNoYrHoX5VtMYyxzKDW+9W
	 6+MZ8m16MKH/kDsTGwZUWNoBOUho+Y9aQCGnTnYnnGGLW3h1PgZ4crz2YNkaZ8juvIWHm
	 b+AEO2A6g9AxsyqmT7SxDFwEKzHa5l9ZILoD9TvJfbII7B/3F3xH40+WKBJkW7h9/MRvt
	 8RhP7VAMksr98WV4fw1p4mYMW5IMz+PLbVGwtkaez94qC4QFspzVs7D7HPQQ+V23fgG9P
	 afwp3q58QKMXwp/5GRD8mp+hSNAqHzKwE3cO9EW3CfZJ43UQ2XfRzG9igOQj4jbwLoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114936;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+yebc8K3kPKxIKZV6zi3Gr4spcKflYXEYPhSSMN9YsI=;
	b=4VZzRKkreEnWu4xMjw+GiJn2grWZVg0Yc3aB4ZDCR9X6hSUnZvwOlcNI5KQymhIlcx8t
	 OVWQqqvE3CvGg59PuzRWfuDGDuwXY2Ujnpi0RDjev3Uz8VkY2kZtWtQuxkGGvIuIuiKOX
	 3p885Izdb+Hc7MrW3IpG9lHJQ3FhdXhl6qvVSGpO4FckR2R0jzTJ1g1tMVUi1adOuU1cq
	 kmev6iJh+yHMTtDa/nf1p7/WTZ+D4BotvUPlkD3JgkBz9a3r/UVTUmV/38YhobYqo82aZ
	 aNe8wmyWdYO2RCtcj2zEV5kOQD4PYn/IN+rHk4zFzUymGazEeobdSIM4TXfAx7oaxwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXiGntds;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945D606A32F
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXiGntds
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4828F1F000C7;
	Thu, 19 Nov 2026 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114936;
	bh=+yebc8K3kPKxIKZV6zi3Gr4spcKflYXEYPhSSMN9YsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BXiGntdsDgXA8CYsK1NDUQU6i3o41D2kS8H5FvRY5FlegCZgkIRTUtjaBJqyZpZzk
	 4PcZmnlCdpuLjVoCcMkjIfxPbdrEP06JZom52ATlMJT9TXtmsSVvcFTu8S+PUpjOdd
	 7T2rCVvNCBK0SK9TFcHQySG8wm+I1+E9uqfA38aAfO4Btx1dTNzKQ7EWFCCt0c4Z99
	 TcqO6agOC35PpwVuY7c1Dy7Vf0lkwKFPFljeFAdWKpUbnWMcdWLHwdouLIUla4dcsc
	 Fvi5ESqIiaD/uSy5W+N9S5uTdLSJ7kQenNCF1cSMzlIUzu9ZIaUseSs6gZpuqfkTpK
	 fyWMxCUu/apJA==
Message-ID: <sashiko-outbox-223823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 19/33] perf: Add perf_pmu_resched_update()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-20-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-20-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:02:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> To modify PMU guest counter reservations dynamically, the per-CPU
> available counter mask must be updated while host perf events are
> temporarily scheduled out.
>=20
> Introduce perf_pmu_resched_update() to update PMU state while holding
> cpuctx->ctx.lock in between scheduling perf events out and scheduling
> them back in. It accepts a callback invoked between ctx_sched_out() and
> perf_event_sched_in(), accomplishing atomic counter mask updates with
> minimal perf API expansion.
>=20
> Refactor ctx_resched() into __ctx_resched() to invoke the callback at
> the appropriate point.
>=20
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D19

