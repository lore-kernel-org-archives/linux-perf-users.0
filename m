Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782981;
	b=UEGcj29/bhVD6T/nFv/qBKekHpD7fmlybcJmjiEGndNn7xSz6aWO58yUNLeyTfudQgrB
	 ICXECw7E0FN8PF8dL7Ftbo4mQ7h5UqlXbc6RuSBz2pUrAINCbAw5hOj/N9ZbOWqv54M5l
	 74xg2MZZQA+RUJ3E99otW70SQyOgbnj7BMGkdJUSrXGkD5jti4Ug7wCngGhYK3ASEcAi8
	 BAmxsuYp/FtXMqY4pSYg1gnfnUYUEQ0Hbhgox6o38dS8ZTVvCbiornz3iBZ6orLzZdwuh
	 PuFLPh0ULcm+GIDckb7qFW7Qde+9iCaLQJhz1ykqBJM6XOO5OLyAQqjb9eDGjWUaYlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782981;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6aNV7lWHqGV91ZEgsY8Zl32WLrYT08EU29arM8Z8rI0=;
	b=tlkbP6qhMRqaJ2XEy+vf5dAVYJ0N1kBLvZdLx0bhZ5h9m9wGfDtppiAU8LH9s0xw4rLu
	 dIRbAV1jA11ZP4KmnNEwKyH4RGSKJNxDCVKr1YPe5nxDrjfa+JbGJMfdUMDCqbdUFY04F
	 5eBISdraeJ/t/16ZAv8zojjaRB3OGJ1nVksDPanQlPxKhNmml8wh0Fai86fIe6F9c1pMy
	 IRpDCCAhpO7OMXDLzK8rsuNVLSsvKDb9GVf8seJxDXklLKJzE0HP0HFmNK5G/GhuSnauR
	 gk07tPtjbb0m9zi4GeDW5ZqE3nPYijm0/l+ZArlNFhB4iP3BFw9FNEafuGuePfunZTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiyQUB1Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F966606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiyQUB1Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919D41F01825;
	Fri, 23 Oct 2026 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792782980;
	bh=6aNV7lWHqGV91ZEgsY8Zl32WLrYT08EU29arM8Z8rI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KiyQUB1YOKVham7x/JP1UJ0RFQL4/IMvWc0tkf/yBjpkx4cytUX9SzllDB5lDbnC2
	 j1XQgfMEalPUWHX22dcx+hwwS2gB0vei4S/CcJfuMfO8ZyLPC5rDO3G1cVWsZTvaW5
	 KNopavKN3LhYhcGPcHzoyNm3ztV41nU4pnLA4BFuIg6TL22Vd9lfrSZ4sx1yLaEKr1
	 j3j1se42vQpRrtrB5khvfNQd8tZLaVyohtbDb7MZPNzJLUkzMdgg0qeP5WFAzJ5DUw
	 slbAvTVslA+933iBZJctLNtR1xCV1X3JgSTdqvU/8OPxharxpec2lMINyNUYj/EbqO
	 AkFQpXC2CIrNw==
Message-ID: <sashiko-outbox-183101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/11] perf test: Add tests for lock_held() BPF
 sample filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-10-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:16:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add unit tests in parse-events.c for parsing lock_held(),
> lock_held_read(), and lock_held_exclusive() BPF filter expressions
> (standalone predicates, negated predicates, and compound group
> expressions) and extend record_bpf_filter.sh with lock_held(),
> lock_held_read()/lock_held_write(), and ':R'/':W' recording tests.
>=20
> Example output:
>=20
>   # perf test -v 'Parsing of BPF sample filters'
>     5: Parse event definition strings               :
>     5.7: Parsing of BPF sample filters              : Ok
>=20
>   # perf test -v 'perf record sample filtering (by BPF) tests'
>   112: perf record sample filtering (by BPF) tests  :
>   Checking BPF-filter privilege
>   Basic bpf-filter test
>   Basic bpf-filter test [Success]
>   Failing bpf-filter test
>   Failing bpf-filter test [Success]
>   Group bpf-filter test
>   Group bpf-filter test [Success]
>   Multiple bpf-filter test
>   Multiple bpf-filter test [Success]
>   Cgroup bpf-filter test
>   Cgroup bpf-filter test [Success]
>   Lock-held bpf-filter test
>   Lock-held bpf-filter test [Success]
>   112: perf record sample filtering (by BPF) tests  : Ok
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D9

