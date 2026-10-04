Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F976470112
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135356; cv=none; b=rwwcqOXjnRggiXQ8cdPBDXq3QRSktwLRNdVOZw39cz1sj4rdgGfNhue1XgwrzT6vl5KqKxYtvUGc09KTfy+W5cEoCdLqC9uTbqj7IAtv3BbDLSRWg3gislzERxq3meDh3lOppz+9Xnm9+zxtbLi8g+uqj7ihFIrgr9ljAxX7yIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135356; c=relaxed/simple;
	bh=t6TiFUHmWSXwUx+yfUNP1QJgq5eAvtxlzBsZvrkOSzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IMtJJWnCvSf9SRfAMFWv1hdXCJWk7kTvMDAGdl+BHItMQNyHxPdgrKA6PjwpbPxGSiXObm3gd8K9wiTsWhwNHdgeF+UFXgr5/bKGZp8GrB+KQwQeW/VT4U6ymMuDs5tebjyjQP5HbZ2GpEjzUakfyNrE9kcjQ/0Bpp8OflY0AjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfsyD5HC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfsyD5HC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357091F000FF;
	Sun,  4 Oct 2026 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135347;
	bh=XsqWwc+BNNAFgOaANohgG8LB/G6+18/YKkvh+zqDIH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfsyD5HCO24j4oxe0VW2+tU2hU6dBkUcz5tAIYyXCKw33s8IjXQclTH4aM+NtuM9t
	 lKAelwsZYT1Tthm5P9hgcrTxH6Tt0UbgEofgdB/8Nhie6OcSyLEbX8xYPLji+Hz7j2
	 ASz55/A8sB8hebTFhHyzvOKitNMFwlvQFNfAUBsXuGujF+irzA4BghAuagrnaJnROQ
	 zAHjX9e6h89tIUZKOdhZnETEMM7OwowsECW/wu0zyyjd6/dqYQN+3nl8ce+kIsbedb
	 IQVKYizXM1I9aw+sDnn41n7lWqOfViESZy+dRcWdUMeHsxqpca/GDVQ0Rj5AaeaiGK
	 8AHg+3eAoDPRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/9] perf mutex: Add DEFINE_MUTEX() static
 initializer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173000.2863935-4-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
 <20261004173000.2863935-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:35:46 +0000
Message-Id: <20261004173547.357091F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> For file scope mutexes, so that they don't need a constructor function
> to initialize them at startup, mirroring PTHREAD_MUTEX_INITIALIZER
> while keeping the clang -Wthread-safety annotations of struct mutex.
>=20
> DEBUG=3D1 builds have mutex_init() set PTHREAD_MUTEX_ERRORCHECK, making
> the CHECK_ERR() paths in mutex_lock()/mutex_unlock() report relocking a
> held mutex and unlocking one that isn't held.  PTHREAD_MUTEX_INITIALIZER
> gives a default type mutex, so statically initialized ones would silently
> lose that: use PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP, a glibc
> extension, falling back to the default type in libcs that lack it.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173000.2863=
935-1-acme@kernel.org?part=3D3

