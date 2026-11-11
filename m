Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428208;
	b=N62ouZT4Csu5XOk60Z448YUJXOfMwbUfpQQ68EX+Z5f8ucNLEHQbP6LouxQ/6dBOogCA
	 /uufXxHPrfVzvZDlOjcYdBzYeD9yEP91QdgndZU5iceLhvqgXxBNKUPdZMRFAy0OcfWUY
	 VRWYUkn5aieHFx6FO/zhS6zzWrt5O9xlFC7oVCI9iSqEjA8Y/gGWGq6cBUbvKvDMVXueZ
	 iRa3mxawVHnPcyLCRJCo1OOcSmnPpon9+zkAr+pT0aCr0IgnDD67L81Mc58TJ3xR3CP5k
	 vUYNLKlZfpir8kEcumpRQoTETX3JwgXghx6ZIjGCuFAQDzhnMe4tBrKjghqiRTtRPog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428208;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9mv3Vpa3xUpO5GeH53nYgAzwRS8bVj2aaMvuTwrPR6I=;
	b=GjcKnB4noUonluGsPIIzzLIopVVzX5puOm+2lJNm0WXxwYpNA/YlvnTVrDR2Jid2Pz/n
	 Lp1ClRB1KUwc6sY4lLFhH/DMTXu75mC5iMgazTN9kij4EBZLhIPSPJISAg/LNxCHRD8AL
	 TOU8h7Fs0c+fGMu3lYIDl2d+VwVT/4SNagU7LOYY3cuKRCuCAYlTRjI3XTbgAIEzhegDm
	 qL7iJsWq4NTwUAy2Lhvz4UjhZjsALKtpN7/NFO4JXsupWw4e7FgfgwUEjailzGIMkiV9P
	 5RB8+x7xvH0G8V6GkxzvZNhO3SBAByOtb8TfqDk/UnHb/1wVEZnxoIepFnJ5jkIkgNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IyxjYsmQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC9606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IyxjYsmQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9FC1F00A06;
	Wed, 11 Nov 2026 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428208;
	bh=9mv3Vpa3xUpO5GeH53nYgAzwRS8bVj2aaMvuTwrPR6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IyxjYsmQQM+mfL4KASfYyN6AoqR0p2ZRxEAeTqTedpb37EnfMSK0jp6izDQiG0yyi
	 c1lnXUvgRZUisoGpSL4ygdLEvLIen7I1vnuF2uorlqFp4z4L2qy86bDLhx7PsMwMla
	 GalYpfOviTwL2ASaHEVQDrZ+XOyCFJNEzH/z+xcraULvsGltALdMpsPjyexGWf4fGq
	 yme9FjnWI+g0vFqxtqFf7bV2+lQdNhhuF0/Tb4TxRBUW93j6MMPHDQz7gqFgOruHxT
	 XjLojoRH2I2Ll42gEWMIQx9dpTQSmBTSm3BI/Z5wJwnpkBEL/iPEFRrImv9lPgT8jh
	 xxsGyflKc2BHQ==
Message-ID: <sashiko-outbox-209629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/20] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-12-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:16:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D11

