Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BD17BED0
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257956; cv=none; b=YtuktmdCSXu6nbANu4uZ6ZtRkybD+01MMN8p+8e9w1fd1aMu/91/8bfwsAEu/PXjmkMaiAm4pGMpxUEzB6yN6S2zAD/ICoMKrYW5fpDkhJl3E3ZLPOT0zGYsMkoIvsgjNpdRmawQ7DKjN9RlJkC2d6j/S8Zw672rcs7QJoqwDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257956; c=relaxed/simple;
	bh=IiESyPzB8dODkrSAQpyWOR8UoCMiz+N0MFpuQhsgrDQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uCeyG7jyEd+LpIsbwJNbAq6i5mnnl07YNMsJ9LHarIkXOZXDF5SIUHb7hN9WB/Dq1qk6vVWime4gpVtdIBQyurILWb10eZ/2dvTKuPfOPmABX3eI2Qv15k92AX5cmqMfPSEGgVogmrZzN+FjiD3gm0Hz2P3WdWQ8CJfoNraLTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ese1X73X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ese1X73X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5485E1F000C4;
	Sat, 17 Oct 2026 17:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257955;
	bh=SEYJQm2JugqW/j2nIx9BArjIMOUJ4w2DspAf7OlGpSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ese1X73XnVM0p6sOPXt57k8PbDVk6Ga+Owehr76S8r6ejp0lBqbzzukZYaze9SZWm
	 adY33u6cYk2cTzPZuxIywj7kJ3/1+NgrUi2I+nm7uWm9AJgW5vrqRfchACKhsu01H2
	 8YlxQgRq5771dcYyEj6BoL4wW616U1JTRC6JqNjBsFjeNQIDlOd1Ffp93goF3VUmuF
	 zFZPALt86Ny98OQoUuSuMQXs2K6MBOqO570bjXVem5KOaw0S43qI145GBSTkEEpUfn
	 Yey51IvGUVpJHWc3mIvUU3RsgJi5fFaw3rs1b8whRAU6miUphQY8lP27L3LLFhg0nz
	 fFMQfAPqmvNxA==
Message-ID: <sashiko-outbox-175703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] perf bpf-filter: Extend lock_held() to support
 RCU, Tasks Trace RCU, and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017171437.2066343-5-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017171437.2066343-1-irogers@google.com>
 <20261017171437.2066343-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:25:54 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017171437.2066=
343-1-irogers@google.com?part=3D4

