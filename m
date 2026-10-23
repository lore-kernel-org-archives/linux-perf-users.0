Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783549;
	b=WWBNltsa6xusgHbWessr/bQcaP2+/dcKjdk7Xw53h3mgFk1cYMk94YOWj50AzyYmxHx6
	 5aV3rVRav427TT14t5QcFZKqjZR4HdAJlAFEdqnBpjSeADC/+LzOK49pHoTXE7GogEMo8
	 NnJ/GE7HiM32h4X83JhMu9WUWqYoBlTC9WpRdTO9nahl6uIcrjD6AzZvxPw43EDoav/55
	 fFYCG7NzvPGZz9LCe1pLLFRHWRrTf1kxl71exV1DRwV+YC5o0GhxvNB5rKnaWaG3crmmE
	 PalBAePHYxIszG5l2zo3ilfn9cm7bRfzJI0uebFITBAEXR4aJlyww5H6NMvD9WNb3mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783549;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EVaAeruK1JlabJVm7NfEdm2Uob2SKF9RDR9EGSSZS9w=;
	b=Gk7BC5YC7d0ETB1fom3naE8yHN08T7LCJNE70E9Jwj5wt+QYfxGinW9JNdB4jwpuUeHm
	 pu0dAohKO964bA4V+jesOTI15tx40SGTmX9YiphbKZUZsfI8GWRaIH0fA0BYh+2BBr6wT
	 krFZI8Mp0npXNV8Wru/jDMIA43tLyxQtt92zal0kz5OqOcxaEvQ+sOtNYoTE1NyiDJvoV
	 nQQtlmL9aEWGC4wwuMEFdv+7Nt6E1hmlkOwp6mrLQmkFQITgPg1t0hdy8hQFEDrvoBl/8
	 u6xkbbpwOhVZbjCkAyTYKvOAQqo2cNa8UhfFT5IUCeTR+SB6G8J9Fea5ZHcVFDLnL/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofO7eknE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F99606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofO7eknE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B131F01825;
	Fri, 23 Oct 2026 19:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783548;
	bh=EVaAeruK1JlabJVm7NfEdm2Uob2SKF9RDR9EGSSZS9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ofO7eknEsIAKp1Vb5/H0CPXz4Ta579efiR3zd3T4iXBP7FqKYkJnkln/b+/03EWo7
	 iXUnKZRQVIfzOMhSUmSWg9dmWwDsNf0eQpJSccmHwsyIB6cBBbYIRaQXboUEPAfdmZ
	 v/esLoWOpOmwccUkCxn4ZZgS/37FNQ+C0cYbNeaTn8twgyjGiMWiIQE7VbPHHXMC6Y
	 Ro+M6FXVHOqRSimTKoKK8j+oDZs73ocmOD1KLSAhP26qUW4ll/TIy60Ze4DJ8eFvKn
	 bVHD1Edv1rIKNtozMum5dOjauhce3+xumMrtuKt54LWCgrzWD0JXCbZPs75dOEeqI7
	 EwXprK1cUT0rA==
Message-ID: <sashiko-outbox-183111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/11] perf lock contention: Extend BPF lock
 contention to RCU and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-12-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:25:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend 'perf lock contention --use-bpf' to track RCU and SRCU
> grace-period and barrier waits:
>=20
> - Attach fentry/fexit programs to synchronize_rcu(),
>   synchronize_rcu_expedited(), synchronize_rcu_tasks(), rcu_barrier(),
>   synchronize_srcu(), synchronize_srcu_expedited(), and srcu_barrier()
>   when available in BTF.
> - Support filtering by lock type ('-Y rcu', '-Y rcu:W', '-Y srcu',
>   '-Y srcu:W') and by lock name ('-L rcu' or specific srcu_struct
>   symbol names).
>=20
> Example usage:
>=20
>   # perf lock con -a -b -Y rcu,srcu -F wait_total,avg_wait -- sleep 1
>      total wait     avg wait         type   caller
>=20
>        35.12 ms      8.78 ms        rcu:W   cleanup_net+0x284
>         7.84 ms      3.92 ms       srcu:W   __fsnotify_parent+0x114
>=20
>   # perf lock con -a -b -l -L rcu -F wait_total,avg_wait -- sleep 1
>      total wait     avg wait            address   symbol
>=20
>        35.12 ms      8.78 ms   ffffffff83754dc0   rcu (rcu)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D11

