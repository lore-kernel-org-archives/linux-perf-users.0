Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350804;
	b=CDou68SqL2UyzkXQ34LHIc0lMj8sITasoy0aCtjDHh3EO25EYvztzjtTBJJ9F6Grn0Yf
	 5zNhjny/gV7Ez2RVmjXMiEfRk0vVIR26EZbLHuhTPt27lpQMAgkDi3nbsNGdts4S7lc+O
	 o8nY+Jgm8ra2B6U3UAQh4oIfmgVAfmrQAyVPW60nF24Qo6Rc4Od09Pe0M6svnJyNXc7eS
	 hoKsWjpatP/xMTcL8mr1m0lSsJJlw4nPtcQTpGjtrII8cIKf1MFwwlvDZ2x6FDKXr5ktO
	 jScaVa64dLWFKviRF/gnDakyHQJlSwhufBoeZYdTi/eUeQG8PwLtVSZ9e2efDlQP1XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zLyEzQ8m0qUGhB2OpNApLM8h4Ar8qk3n6XExhKbX3I4=;
	b=K+OHSGsaYMRfXLeYg4DdnEriCrRLQhTBskqCfdchW8YoA8m3TqX2W+NlQdHvr03w4jvV
	 47Fh1xoTxqWCLjFjSVnEoDLeziO8nD5QXHHN8rSPvFMojweCeQg/p9hy1j5a+osBUw0zC
	 U25ZwL+q5JCfaE3M5sY/62JCa9pFPYnGfJRY/px4bBtx/EKuSJNlfTDlRKGWxz5NBIiN/
	 BM62Trg4/8KmRifj6o8znxpBghov0VdsI98sz3i0eBtBP++JrtThGK0o3fbEEldDugKZx
	 A8DPxgrIB3jFXXt5BDuwbHLBWgHpiA6hYc82AnNXXQP9tJX3Gs4G9mz/+gzY/8iwkxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxzB19Yd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E0606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxzB19Yd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEA11F0093C;
	Tue, 10 Nov 2026 22:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350804;
	bh=zLyEzQ8m0qUGhB2OpNApLM8h4Ar8qk3n6XExhKbX3I4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxzB19YdlWJQGoXmo2lOx3rYxdLkNXOoIK9QAbPcgTKsreL5FaaBjYImjbkFCLlJh
	 I9qo8iJJUSLe+FOPrZVm9KZHY0ItGKK5RB5+PUyZ1e4csV53cWiV1koBQvooaJBWf+
	 QK3LAD0e42Ad9EJEiAQq8nr7/YiKLWCOW8Zwx7Vh9k9heynDO/KmkO0wIuMqB544Ru
	 QLxv68qYqJuSFoMfFy5zMF4Z06XQ6lqvG2x3JinwZ1kqveIiYNC97LE97nrXQqHniH
	 KKn3ekecj0pmY/EG07vsewjdQK6welimVoksOmRS5uya4nBJRgBaAlJ8zR8xdgIYJx
	 bneKB6uEHWujQ==
Message-ID: <sashiko-outbox-207846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/20] perf session: Add dso__session() and
 session-scoped allocation wrappers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-19-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:46:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add explicit session-scoped memory allocation wrappers:
> - perf_session__malloc(session, size)
> - perf_session__zalloc(session, size)
> - perf_session__calloc(session, nmemb, size)
> - perf_session__realloc(session, ptr, size)
> - perf_session__strdup(session, s)
>=20
> When an allocation fails and returns NULL, if a non-NULL struct
> perf_session is provided, the wrapper invokes perf_session__shrink() to
> evict unreferenced symbols, DSOs, and cached debuginfo across the
> session's machines and then retries the allocation once. This avoids
> the thrashing overhead of periodic heuristic shrinking while allowing
> perf to recover from memory exhaustion.
>=20
> Also plumb a back-pointer from struct dsos to its owning struct machine
> so machine__session(machine) and dso__session(dso) can resolve the
> active perf_session.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D18

