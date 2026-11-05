Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838954;
	b=hOuHPoXN7SbySt7RW7lY2RxHlqDrMxVwGf/m3LBoVqhKEXp+9NG9kvekwVvAvRq9ltJQ
	 LLI9wz+ylcpfBmeSGDgIxxi90I/Qi8dq8ezBJQ1ysYpffAA5dnS6yxoxF2NF2vvVnxaSG
	 q5eL2JqXpHymWG2Sm3L0fOHPr8vgVlZ6ST6PEQCWjdtpmNh6wqG2eKEBMYwWSkOFBhzqH
	 GZGX5llQ8CO9XStOVP8L1wQR1EE/VjK0g/uqgk3gZ8XeG5caK6SbABsmadUbj0cZpccFr
	 zvYAlu1KsOGO4Kr+uFhzMZmb49rErJj1H7mhxGTe0Dael2dfOzeWkApBz1WIm3cV+Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mf4Y63hLNr6Efl22ISbXgFDnaclWNUCWygKnMm2J1is=;
	b=hHvBX9+GyBNSBersjSJ6fbGeIC17K+C+GasC45IGj2CXvehmcySLQBT5Ra9VE7JyP6ie
	 BkkltgFV85fHa3x1NGqe/LQEtD864uZh4f147TxAM2gOAtJT4q7QKbnzEmZTkesMzdyoF
	 5Aud5CiXJ+d5Bry2nZ10tyLMQ43hQNvYdcd/kttGQ6pTjQ1yG5sv2ZnJQOSV2k3PM3kbB
	 Z7Y7kCHIUHS/7eCkc9rlvsPSLrhN3M7o3z7z/24vYfEwRSjf5CT02Ef7uZWWcLQjsx7BO
	 QuPdLNsTVMW07TR7Df1hJ2H4glDdagEzt4+Uev8Ak/vB6efMs6VUY7Wf2Ii/hEBPQhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRr8q3UC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09622606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRr8q3UC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6601F000C1;
	Thu,  5 Nov 2026 00:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793838953;
	bh=mf4Y63hLNr6Efl22ISbXgFDnaclWNUCWygKnMm2J1is=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZRr8q3UCcKAH/ritvbWat5X9BeFvIAXyOsRYavN7Lp4UfvjFbd9cwmpHFjnYGT1Cz
	 sZjXJGMpHJDkXUa4puKLFTOBotzpouBjoen7HssFxhw98RXIvLa/8zH9xPRh7MGWw9
	 zto3PYHGlbTlqHg9xaacJjWTX93jHB34UF7Wz6swyIPLQJdthCyk4xgrIiDe/L8Bsx
	 9OlT6q9Fv2hVypK1oi96LypwWgZX4k+pTaTuVKStrFUJaKKQvyrGefiNpggdsI13Mi
	 UBPnnStcUSovyUpiW63HxagZ5RscazfE+TskiSsGw9uBknDHVQceF60njOLwUcZr4H
	 DpIV+JycsRdww==
Message-ID: <sashiko-outbox-198365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] tools: pass the unused prctl() args explicitly for
 PR_FUTEX_HASH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bradley Morgan" <brads@mainlining.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105003129.3130709-2-brads@mainlining.org>
References: <20261105003129.3130709-1-brads@mainlining.org>
 <20261105003129.3130709-2-brads@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:35:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> prctl() is declared variadic in sys/prctl.h, so an argument the caller
> leaves out of the call is whatever that register happens to hold.
> Neither file passes all five.  The two SET_SLOTS calls leave arg5 out
> and the two GET_SLOTS calls leave arg3, arg4 and arg5 out, so those are
> whatever the registers hold.  The kernel does not look at them today so
> it works, but it works by luck.  I checked that against a running
> kernel, garbage in arg5 on SET_SLOTS and in all three on GET_SLOTS are
> accepted.
>=20
> Pass the zeros.  No functional change.
>=20
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105003129.3130=
709-2-brads@mainlining.org?part=3D1

