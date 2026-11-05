Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893386;
	b=nTMIsNYfPotSORBOyy7Bf6Q7PJPDasq+D9oeMcncqDbMqwQlW8K8x4MB7bpAj+DGZZ0Y
	 a+pJ5sgAMYMKjvGdAkSfuWYdflEkuilhYOpjZCxZErAKL0f7NUCYpA7/hWXoz29mPfWb/
	 6TW5syaMiwmh3T99MkadAHYlyA8QUsfOeX52tYxpqoUr9Whaniqgg3aypHHVkkuPuA4GB
	 0WQsLlGCTtJmD1S371MlFmYEBcav1iaIQD7sProwMVK4MmuTe8CpojlB0T8q/585HwOPR
	 D1mGQFII/SbgzXfMkMYyS9+aH6qphosiCoM5fp4Rl0S/xNxcR8DiMEGY7uWIXvtgmOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893386;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JlXEgbD7CG6/O+yxcD0LO4sjk9+j57VApQPQ848zYnc=;
	b=guM5qDeHrWwU/pMrRKoiEP4JmxKwVGNkASOsY71J25CB538NdJ8evMXjfaaTMvBztmZU
	 HMbtJ9cQtFQt2FXeZpGAECghXDm0fXLU3JV4RZfcQxNdKkn53K9BKRCYfLi3iU15DREgG
	 xtxg4M31yRpB0FmEmPqAuP6DCIYlyr+34xu871IQxs2HQGLw58iZeyw2Av/JWEY+7qFl5
	 2w9y1pyZH0asTtABaN4OHx2xl1ivoUnzehAJ8KGP0m2uIYqMSQZbS2ZfG6+T+QA8pMqOq
	 9vS09icCGbKMTaACKk3B8hZAzBK9mgAnN8acvZEtD6xI2YD3BfHS3Yo9UMNWf1NeSnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGqfK5yZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69517606A334
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGqfK5yZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2911F00919;
	Thu,  5 Nov 2026 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893386;
	bh=JlXEgbD7CG6/O+yxcD0LO4sjk9+j57VApQPQ848zYnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oGqfK5yZ0aLXZEYmsAtyZmhDQpfjWSu5QBKS//NgGy/WRcY1sWyPfi68Cro/RDikx
	 qqTbvjYZ6assNf4mNBpyCMSDTUfEmIknnbCEjuVfR5VllvILcmxfHSfeqZatJ3/G2G
	 HxGANECHiRZcOBS7UMS5pZjEK1bWM1/eJD1cZ+pWVa3MIq0UFWzX6rNpfFFm+iqCyh
	 hicpDsD/vvcVKKHITD9AGSd2GJAeHGd4By0U81E4PKtXC3EyHOAUHytAwPQo7eduO2
	 RyiPEWK4R7CeHw7g8uL0P/y1+t+hI3Xi1G5npWYmVZz2Rg/lPkEOcgQfTASMHvbLAQ
	 2zMZLMEqMKx3g==
Message-ID: <sashiko-outbox-199330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/perf_events: use the ll64 types on powerpc64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103155516.535193-1-sashal@kernel.org>
References: <20261103155516.535193-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:43:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> On powerpc64 __u64 is an unsigned long unless __SANE_USERSPACE_TYPES__
> is defined, so printing attr.config with %llx warns:
>=20
>   watermark_signal.c:85:58: warning: format '%llx' expects argument of ty=
pe 'long long unsigned int', but argument 3 has type '__u64' {aka 'long uns=
igned int'} [-Wformat=3D]
>=20
> Define __SANE_USERSPACE_TYPES__, as other selftests do.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155516.5351=
93-1-sashal@kernel.org?part=3D1

