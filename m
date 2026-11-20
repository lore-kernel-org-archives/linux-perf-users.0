Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138746;
	b=JBioMnH55UB35yrUTGx5GJmuPgG7/3MkKOOw+95IxFd1Y3Z4OFj3kh6k1N1fmWUdFsKC
	 stiFodazQyDVrAtuO04nnxY8wNsqbR+FCEZu8sbMrRnBNGxZj/kuEA08S0AqkxsbSiScj
	 cEn/bMGZWLAzs9BwlHjxoe+kdU3EUnTFjFWcu7zunh20iHxHvYhrcfF/AwGvDXAH470Ri
	 shdbvBf+3oJqBzxEZlfz40jjC4H03dS0MSBoAHG39IJuQDLRZpF+eFxErCRl2ICyzBz4k
	 zh/Kv0gUa75qSTju7h6q7brm4chm7eEXE9EMigSKOh48N27ygf7+p/JCn+e/nQsECmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=frmmX6LbfmVnZZshmqw0cNMzmxbt8zxHzqZVIK6oH/U=;
	b=IKnuElnXJiWPT/BwKLq/Jd9YxsJ1pTbhpDPivmyOxaqyQvmwV8EuIlr2v6RcHvzpsV/M
	 ryUhBtMehULXDCrMPBzEEC0OYYm+AEgb5hmQHVM17vUHvu/Un/uXhO6NHxuy6fArQPQlB
	 qELHLIVDzKVFotsPHLzAfHASyN2rFCQGFTW0r+1HAazwmqrBqC9YYqU6osgZsVPTOoPKF
	 or2BsQmWHf7J1lKm1egWn4cf3zq+U1tDh3IugPcP/P4T5uInyp4r9Oet99/kmOO+LP544
	 xd/aQPaYZOycbpg3qaiLZFlC5z1TEakfVGl6K0VAU4bAmsSpf7kphKYBOAx3JO+x6qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMgWdKjy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A9606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMgWdKjy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EAA1F000C6;
	Fri, 20 Nov 2026 01:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138745;
	bh=frmmX6LbfmVnZZshmqw0cNMzmxbt8zxHzqZVIK6oH/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KMgWdKjyodayMDyC8V9ISs9azZNK0t+2l9tZjbqsTqLU4H9KF2IcypGkh7QMK39dy
	 shJPAS5dgtBB+b7Fd6CWrazF9IGq1dwJEvKwg3dFGLxE6WnadbH2CWXRsWk2qW2/WW
	 pv3OuMxYrRLPfGXurN0NllV7WJeT+WlntS45pLe1jSnv9eVP5njvPx5ptwzB775rP5
	 5b/j5HzYOLloar0mtVbxsf0sVUn9lB+y6t7q5OKOgNpk0WyrJMrcyolVvsQrJNRPMn
	 J5gVBbs5jQFdkJ5LrxYr0rQOkQgPz/rD5vXnYA/xDewSujBAlX0RAR9RyeEQJgZUUK
	 Wvgr79y2UZYJA==
Message-ID: <sashiko-outbox-224328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/13] perf test: Drop samples without an IP in the
 dlfilter test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-13-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:39:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a user-only event skids
> into kernel mode, so that kernel register state is not exposed to user
> space: commit 166f10836a653dfa ("perf/core: Fix kernel register info
> leak via hardware skid").
>=20
> The test records without an event modifier, which is user-only only when
> perf falls back to cycles:u for an unprivileged user, which is why root
> runs never saw it.  The dlfilter keeps those ip 0 samples, and the check
> that nothing but test_loop survives then trips on their lines: the comm
> column reads "perf".  Drop them, as everything except test_loop must be
> filtered out.
>=20
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D12

