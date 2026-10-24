Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878394;
	b=jo5ap2u8VswzMo3j0D2vnt+u7MhnGM+VwTYHGfp8nQXZPl0zClu6QnWSsQI5Gm+jD8XP
	 /cC1hT5sCP2Idp/BBDPnH7VdsZIHKs4iH/FKkyei4E2N5p0nYlqFU+6FmdRnPzW0iLSbX
	 8JrRezD7mTY7JCVSDurvY8FSP0AvejfMDhPitq6cA6Vt6abBeQ4USkmhzAfEgYi6P3J4s
	 hwzcWlbFw/eKmVxQz0EKpxqHY2uz1fcpaH5JrtamL4eWdfsrzCWWBIphRCiRDTnJcVzr5
	 Hq8GGvmR4NU6Z+YSI9QXq3gecc7VCEweDJwLuwCRZrbi/o9XyB1dJNLAwt92hc3DR0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878394;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b35aHCKSShpQBEEdJq1RyhDoAsHCjys/d4sov/TRenc=;
	b=nn8YTsggdpK3Ezy3BIXluTA9y4/VfW6OJG0d7WgblCWnU1XiMTJsOxFED3g211lA9Fh8
	 CpWkM8EnZIxNns4CuLfKrpUa3hCphcSvfoXdMs8IppoiiwCt87PXCsbOCGdyunSCmKmGh
	 Hh7DXCQkcMy8jFhkfEhWHhrOsacPp73QRu8BsEJLl04Ct+ah4szlqYU5ZnvzsyS7iB/gu
	 f0iIFoffHg6wwMR4ARty5pmPwAwkhGaGPQ0LpeubFgwbfmO0j0xLQnqPEsOqz9D+z+fX/
	 Z9kJwtjJMYh7m9uJrCXdwXDO0aEOugLd5RlFIku7Uv7Stj3t/mJSaUYMPi9Y5dxH3dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzDogVtZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACE606A31B
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzDogVtZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E5F1F01825;
	Sat, 24 Oct 2026 21:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878393;
	bh=b35aHCKSShpQBEEdJq1RyhDoAsHCjys/d4sov/TRenc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EzDogVtZY0uck0GQN6nPwWD42JxSs76TZF+/vXSJJV1C0G/yKJ6Nqe83bAF+4IL5K
	 4R8bRImBi9J4gd43jt2Z1Gv0p+0VBu7szbCws0fd/LB5OQ6Y0Kcf/mzObh8DQGbG8Q
	 /jNH/4eLHMrJ32DpeR3fPCX2h2oWmBdhUcauYEk9D/wWywhpknxeHHHg0ijQ60CAzh
	 suBzMm47OHSCJl879Ou6SAoVlRp1XPM2GSxb4D3OOE+sIwovoSUAuEPTMTYAyRQ99Z
	 2ZzXTxeAWprScPZuMiOGylZ/dIgER0w5zJuBFxBZZeMKcivlRCcHuk3VnDQ0uKFayq
	 Po1xlyEYDTu7A==
Message-ID: <sashiko-outbox-183900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 10/10] perf ftrace: Filter
 extraneous functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-11-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-11-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:46:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf ftrace: duplicate struct members seq and min_raw_indent break =
build
--

commit f4f59c9c42f809fa549a2f95e0003511775c0575
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Filter extraneous functions in function graph tracer

This commit adds userspace callgraph state tracking and return-address
validation to perf ftrace to suppress top-level non-target functions and
detached orphan calls when tracing with function_graph target filters (-G).

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 72c3fddd93bce..ab8300602fa8a 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> @@ -48,9 +49,16 @@ struct ftrace_task_state {
>  	int max_stack;
>  	int depth;
>  	int inlined_depth;
> -	int overflow_depth;
>  	u64 seq;
>  	int min_raw_indent;
> +	u64 seq;
> +	int min_raw_indent;

[Severity: Low]
Does this break the build when compiling tools/perf/util/ftrace.c?

In struct ftrace_task_state, the members seq and min_raw_indent are already
declared immediately above, so adding them a second time causes compilation
to fail with duplicate struct member errors. Should the duplicate seq and
min_raw_indent declarations be removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D10
