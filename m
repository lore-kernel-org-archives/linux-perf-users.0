Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827192;
	b=S6qCXMqLq/99GZgXmrZhRP/CW0BjNqnzxyHXMWPCUHX5s6BSX5PRZyFxivcjyaJklwmD
	 TI6AIH27bAk+89+F0fhSrZP5aslC+eMFgM4yUujB6I3LR+Ge7hOSpuS2KApa4OlI2em2T
	 EvEU4W8fIMDjBWBC0qgchBXocTB+ObCYJkWMY7NvTsOlSwLHlcucshoRyHNuFhlPIcotD
	 EnxitV4cZ7Fp8Hh3Y2jpHJp3fLdWlwMmoHBIhsamd3G8mCEgFne6GK+bscXPKYpJosg5A
	 HtiRG9glG486s5mHO33tNWuFPnv2agdQMx0jWmA8LjFDaQ6oqBsTa4wUT08fMM31ARA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827192;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3HwDoMpu8BCO2+9f+D95orHKlwE6UHSm5PulwZZPj+w=;
	b=IsxvHLxCFASvfvcWznMhaayCuWI9R4pxUtBn/NfVxsraES8AzzPWbkEzg9KoCbGM716x
	 bH0OVxQQjPYofSqcQg9YG02M+OQvxEaMTuLSgKcUr6wx6PaZsPCZ9uHCxAC1G+A3pILIp
	 oG0ILdFHRpBucaCZ+AD7T7QBdOgUtIt9a1AbW3M8+dqaf1FYPhKurnKVL4UeZOWspd8gm
	 OGCszo2p7aWVJNTC6BjezJALemyFKIERudKpAibUiFGbmBiNGSTisM0uwpn8363itWGg1
	 Ky8Eu9Zt6MAlGwOA/f74MY7mPzCxanhoMcvepfux/reHvKOy2yDh1RzWMlHQjDDNelQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCUlu4uE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD66083601
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCUlu4uE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9202C1F00919;
	Wed,  4 Nov 2026 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827191;
	bh=3HwDoMpu8BCO2+9f+D95orHKlwE6UHSm5PulwZZPj+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WCUlu4uECub5d33PkeHbhPY/QDqv4F1KPZ0wO8e0d4K7mZWTzhvh1RRnrbnGahvrl
	 O9kxtgvhXxj4znHR0qalUL4kEUHZaD2/DYGJK9sJOMpVfksc+XDPz2KX9wpkKPrEPg
	 oH49EOVn5wg76Kd1zhqqEV4JPaO5CdmGZ8ptGuG/SWT+dSmmNJLZ+DF7SUN0b7fvNO
	 zRAEm67Qppz0fKRsST1/R3Zt8TnMNGQZ/LAPPvpfsN1gWP52eLDxilob4ZBgoi6Fg1
	 wLNG9uJWYbpecyBZM0V1ULvup/1JYZb6LGFLfynXbB/BsIbm1+aU6dAuBlWPHppsYi
	 B4yWHuMEfiH3Q==
Message-ID: <sashiko-outbox-198096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/19] perf dso: Pass dso_data to close_data_fd() and
 dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-11-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:19:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> close_data_fd() and dso__list_del() only operate on struct dso_data
> fields, while close_first_dso() retrieves a struct dso_data * from
> dso__data_open. Pass struct dso_data * directly to close_data_fd() and
> dso__list_del() so close_first_dso() does not need to recover a
> struct dso * from struct dso_data *.
>=20
> This removes the REFCNT_CHECKING dso pointer from struct dso_data and
> avoids dropping _dso__data_open_lock in dso__list_del() to call
> dso__put(), preventing lock-order inversions and races during EMFILE
> eviction.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D10

