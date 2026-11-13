Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590799;
	b=ybrSRe7GBCOK8Yw5Gcc261lcVIKpdRCv/fuMCGkp18nwh5rQDlL7wZ28L+TmvwB+5KtG
	 0F5u2AjjuEunMOV2+mK5/JheFwUfAF6lUsx/WbMan3G9XZjM/880RFlLPZBJOxKH8z3pj
	 QWZbtmEF8EFAWkvKVeDprf1WealAzzpalHRGDtPJW6BqVxAxykRGE4AfFr59T0RvGeolN
	 dYe67ZFrwClv4YEFRwIHpwQKnnmQUHuaEbO6oPzunkvn8NgHfkK/4kmu5AD0C5c1Scccj
	 N4M7RWcxfEbdkG3Qpn/cEE66ePP9n1n6lNyHBz9diOEacQ86T6W+45M8JZ2Fc43nfAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590799;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tSRn6u44qc6LyS1TU22HAgpkF43d7i+1LQKLQqFT+6E=;
	b=Es8ZXATUQbbLxdU989dAI0QIEeXMvdQC/0u2yMsyCYEka/b6t0YvZ1RxnSwpT9Q6YVC9
	 1dDF4j4C8VC5/d264Rsfq+W2fJJ8aTo2fuYhd028QiQDSWD0ZpmYzzIvv48O+GsoTmFaj
	 jV6sa48Enqzir0ILQXb6LtP8QmeN61H+IVrshcmM3YOS4M+asPtJ8DtHQ03MOc5Euuo6u
	 x0as54TJC05uqLlfZtuYlVaQc0G3C756Jasi1lJYIpHxQ1K61ohfR3qGIKnyL26uVladW
	 hDlcWYg5aixfHCx73x6ZQD3IDfifXrSU6K0Dy94+zZeJAff8t/94PNafn8V0E0LH4WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYQUtV+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70997607D2E1
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYQUtV+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5581F000C5;
	Fri, 13 Nov 2026 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590799;
	bh=tSRn6u44qc6LyS1TU22HAgpkF43d7i+1LQKLQqFT+6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aYQUtV+uAm0fJWgFdoYhKWwtxbfNumubh5vjjv1S++7ciWRRq0pqDxV2CenCxmAZw
	 rCnMZKo3sMRj9LIS9oUA+6QHkH7TqubYURWqkIiqP9CUAppVvgONWBDEfRRR+qLQdE
	 +I66jJQUW+gaLcIFFn/6U0otw2siC/XPIwyT199TzCPoiVh1tG7bG4ANNM6le4LL2W
	 BflTwJvZLUPQlRpEqn2mxGEdWjMKVBU9FaAFqS2XuN2sKMZoTM6DjK4sZwqe4qgBDH
	 ZFeIQWF5iy0lUsFAe3lKt1mDgKiclgAUM5CH6ogSsn73XlF4v237QV0xlb4njD+ASx
	 rtvYrYmtuSCxg==
Message-ID: <sashiko-outbox-213305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/23] perf machine: Fix NULL deref on allocation
 failure in __machine__findnew_thread()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-2-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:26:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When threads__findnew() fails to allocate a struct thread (or fails to
> insert it into the shard hashmap and no concurrent thread inserted the
> tid), it returns NULL with *created =3D=3D false.
>=20
> In __machine__findnew_thread(), the !created branch unconditionally
> passed th to machine__update_thread_pid(), which immediately
> dereferenced NULL via thread__pid(th) instead of propagating NULL to the
> caller.
>=20
> Guard the machine__update_thread_pid() call with 'else if (th)' so
> allocation failure returns NULL cleanly.
>=20
> Fixes: d436f90a64f3 ("perf machine: Move machine's threads into its own a=
bstraction")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D1

