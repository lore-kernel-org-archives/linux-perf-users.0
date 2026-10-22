Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701475;
	b=3oQnuhbdiWTULNYxUeO4IZ2sdvULVgSKtig3MTHIPxIOahBgMASHCf5Y4/n7n99JJaMU
	 ehWzhLDYDS+S+TmnTpJ7HT2RlbrtShAtdMV8kAH88WGuwwq2og7gPJ6p0PcLGNzJqzpRZ
	 HTrOtFF/czPQkfQ0M914BAx3Bc7GrXhJjtzfSboOxmOxtPY09a0lf+vnTwiTtbOz6t5Xl
	 6yXOLKYamv/dj6cG08sih/MJ52J2PHVlUaXMimmVz9d8H8yaPMGcjkFtXNcIF8Rtw29AO
	 dmTcGpq5BpU/DwL7xooksoK5xSVBzEhYOqj5TX0+wt4m7s/NQ2EPVHR7A6iSR9nuYwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j6HHIbWn2nyW/vtHG7KwXmE/KZBDRxlEE3QJbDiWrR4=;
	b=YT3z1s4twzlN0eU6gSbABH42JsvVe7XdFWX2zqVOMEpdgOdI4f9zg0YyPCfL3wPSSa7j
	 BXsDxL6jyM76/66rcrIZVPUb8lUYAn69OUJsIde2h2MqkH27StIkv7tVv055GPyRkTd9U
	 /lERIh48EDcyq+nFk/Jq4Hv7AVG26Fagt1w0ivUuuMsXmUINgOx7uKKgtlgQG0QPYc89o
	 WA9UDkOb1SXRh9G2ZJvdxigsgfPujooyx1vwHAuPqHHq+ebuc1L+LJRpGOnuppamTsxo3
	 i8qZf5CqVYdcYjpG5KtbPEfzxenGqN9xnm/G8leWjCIlc+kshbV/16bJSPxpCczA+dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/WyfPUd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAB606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/WyfPUd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAE21F01825;
	Thu, 22 Oct 2026 20:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701475;
	bh=j6HHIbWn2nyW/vtHG7KwXmE/KZBDRxlEE3QJbDiWrR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U/WyfPUdfQ0mkRzRB9cc0lg6wfMIn5aGD/0gzxpMon6osqDkLbKBm3fu30D0qIp3m
	 n5iQlrqykkSO8mF2XOux0hv59Emi/YTQxmeR3j8ikgbIwaodlT64l26RKDD34EmLIT
	 j9/B3Q87w74YoPZTf8y8FS9fWTuuiS7+zDhvyEEIf0PITdy7i+Ah68KfjAMJQAE1gl
	 jhSJ+RZFvhZGg1ZeAfWA5vdUj1QaCWFzNOGaLy9AZlfQ2W2umDM3lrZwIdgZipEa6l
	 UYdR7tUt27qGdmMEi0XoIA7kQ/l59Epntl08KVtRVZy2t66O7AmgmZ4nqfr2QXbMSy
	 7mL9nnkFCB6XA==
Message-ID: <sashiko-outbox-182017@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/11] perf test: Add tests for lock_held() BPF
 sample filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-10-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:37:54 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D9

