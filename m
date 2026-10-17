Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFB3B38B8
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216604; cv=none; b=XxzkgbUy9ZsAveEohNIH2IxzJDL/L05GnmL9d8RvXiPKQfulUySZ2qbwkFLTuxEjKq5VW+X+n8Efi9Zq18v+4SRfGJ5x1beLDVa7k7kTt3gyaPinnoV0rTTSrzixL0R6ZG720+MitO3PGJKjPwYGv1w4pU/KmxW2WSMs5RJkZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216604; c=relaxed/simple;
	bh=XiQmxW1/6aNWLhuDxOCTy0xK2JLB2IcsClnfpfkjdvQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=s2VbGxqW3/sQIfCDKY2E/AOqAV5yLK/eZRPY61Z+o7n4ir+J82a4+Gtb3rHXOqahe1l3lfSzOYHv8FZ7BGhteLDh/Z7AzeXMwVdl+O6f6p6VO+iK5I2PXcZtsNPLVmx4trfOScjnblYJV9RaKWMQVaQhvhOPk0rGi/AdyPdlhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYPS8NRN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYPS8NRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F741F000C4;
	Sat, 17 Oct 2026 05:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792216603;
	bh=vY47diuTwx7enIsrCDvJ6GQVceNV52PY11ezRCLgHH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jYPS8NRNAFG2C4JaHxn49NIxC6K82ZNsFStViIwpHp4IqGfNpPpGSL/CCCnIKR4ms
	 5HAVLFT55ht4J46aAxD2ilpgm/i0dJ2zHplVcX0F1pujlPRCuzWr/GdIrHfN8Vo6e8
	 SGOQjM7m6bELTKjwwTkyD3cltolZBySPe3TTiu6LmIHXQ/JSf+RURBJq2wpKWDbBk7
	 NhMgAfD6IFHnuVXIN6WIdMlm3ThM959HFOuy8yJAT1h0PoY+TPo3j4e2QrqTefN97b
	 HQhblIwufG/TwwCs1tDWniPVuCNHNaeZ5taSKrYPdaH0ZS3QFM0Ntjb+SO9ixIzxWO
	 D4v0ZvXA/R8YA==
Message-ID: <sashiko-outbox-175318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/5] perf bpf-filter: Extend lock_held() to support
 RCU, Tasks Trace RCU, and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017054555.1655407-5-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017054555.1655407-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 05:56:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend the lock_held(<lock>) BPF sample filter to support RCU, Tasks
> Trace RCU, and SRCU locks:
>=20
> - 'rcu' (supports both read/shared and write/exclusive modes):
>   - Read/shared ('lock_held_read(rcu)', 'lock_held(rcu:R)',
>     'lock_held(rcu_read_lock)'): directly inspects
>     current->rcu_read_lock_nesting in perf_sample_filter via CO-RE (on
>     CONFIG_PREEMPT_RCU kernels), accounting for the baseline
>     rcu_read_lock() nesting acquired by the perf overflow handler itself
>     (bpf_overflow_handler() and do_perf_sw_event()) with zero extra
>     fentry/fexit tracing hooks.
>   - Write/exclusive ('lock_held_write(rcu)', 'lock_held(rcu:W)'):
>     attaches fentry/fexit hooks to synchronize_rcu(),
>     synchronize_rcu_expedited(), synchronize_rcu_tasks(), and
>     rcu_barrier() to track grace-period and barrier waits.
> [ ... ]
>=20
>   # perf record -a -g -e task-clock --filter 'lock_held(rcu:W)' -- sleep 1
>   # perf record -a -g -e cycles --filter 'lock_held(srcu)' -- sleep 1
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017054555.1655=
407-1-irogers@google.com?part=3D4

