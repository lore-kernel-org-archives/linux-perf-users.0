Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884663;
	b=iH9n04QpUUNVtzPBz3CSxaV4z52p+uvgpNvJZkp+/qOqlSo6d8y1aZyY6kQwWjHMPw9d
	 Rmxpsn05EKQeRO6y8X+U/bNtWCD0721ek8FilG0q8JP0nT2uwfi9ugAJySZOVqD/yMyeD
	 VTYfYrvciK8vWYI4UdWXfXYr4TVMAkBPFBUHzttahww+inP9vqFOQ2hlWYGUu2D1GAXXG
	 Ia0/pFMsEGBs81/nkvBZ9DosNMmqhTBf1mCqXrU5YAYT6Seveo9eCpNxldliBU60BjBbr
	 O+IgyPrqPUEQG0+BmesARgjgWpGhQpwUwtwKgA37l+pGd9CLMDKuKU366w5RhQDSYjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884663;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4GwiUb8L9VG9zRiZY53pBII4Q4lD6UHxsAkrbvQijEM=;
	b=HzNwmUOrW14ZcyuvFcZtJT/NBhLsUOq1JryRkzfrB9UgoyJaNfGv9KtYi5rpXMbDydSK
	 1KuEYyQ4x6IArdRPMDWWRb67P4c+3oKXIWAxT8oGBE6Edy+MrUPc8uxOwKE93bkc04WNG
	 F5Av6pEb8LZRXFDN4EfcPvfiBxXA0W9W0zB9JV7jKHyonWbEN85wb46hJ0dXGf5f8FLtH
	 sQjkyxGc5/5u5cwc95l5lfHf6x58lZkiJpuKPThcP1kNySDVhJnJO+M649P14pVNC9HBy
	 gMzNxxzqn2S9pZFyT9ZME8J7OvK85pLQW2vY2oWoCsD8IBN0PmuVx+EN4TYJuP1JFFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs3stgmD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A204606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs3stgmD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126131F000C4;
	Tue, 17 Nov 2026 03:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884663;
	bh=4GwiUb8L9VG9zRiZY53pBII4Q4lD6UHxsAkrbvQijEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vs3stgmD3eBvMYFBtrdVm7oa8mLIYM0VdnoZlMuaFElUXvXfPhjWVKYIKqT9Byw+1
	 eZcwFEQh4jP6mzyM4OP9uVmPseO4ekeXiO1qQcvAlXXYBxwYZJQrakc9viYRXqeM74
	 1PBveUaGk2jsdniwAz/3nkmS6OWehebpyNeCXdwENpLnWBled76IlDdNKtV6TtBc07
	 wBhOO+p3DgWO+wMSuKZfPD7vqBhZbNef8U5+AYkMikSHgUvx/3egdFc7lQVYojL5Dd
	 A0KER+iemwp1rFw+1/gCFAM0Ti2e775tGsmMGRAWfxRNttgyc60aJphXiO5vCzB4Ok
	 nhcbCrgaLFSsA==
Message-ID: <sashiko-outbox-218117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/12] perf test: Skip the LBR inline unwinding check
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-13-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:04:22 +0000
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
> The check only looks for the PMU's caps/branches file before recording
> with --call-graph lbr.  AMD BRS advertises branches but only samples its
> own retired branches event, so the record with cycles is rejected and
> the test fails instead of skipping.
>=20
> Probe the record and, when it fails with "Invalid argument", "not
> supported" or "doesn't support branch stack sampling", exit with status 2
> so the test reports Skip, as the branch stack test does.  The last string
> is how evsel__open_strerror() formats EOPNOTSUPP for branch stack
> sampling.  Any other record failure still fails the test and shows the
> error.
>=20
> Fixes: 446c595dc0dd ("perf test addr2line_inlines: Ensure inline informat=
ion shows on LBR leaves")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D12

