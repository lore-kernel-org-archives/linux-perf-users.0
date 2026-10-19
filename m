Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448373;
	b=1MFo3cwYxuxVDbP0peXlhsW2zWLBsYJ6Utnttl7dPMAnZN+VIJZ2krtQwAIpPS5OOa3i
	 +YRkvNDiMSQeG9BJgbGZhGsd/fMnYh1wVOzkSAdsqk+EcYNHxUUmHeG5CjTnD7EcSpHzR
	 5ItklhVcmV1BKxFcrkE4vBoOJfFrcKzNSHz3kg7r/IjKIHuFI5kCG/9x68W2AHp84Fx95
	 nVVeCudqxbNe/hm15L2/y4sd5BQKAbT806Ose7XizzlnTJHj8D/TJm+OIFJSSFssSi/d1
	 /G9mMuXWrnBpGhE6XcjOZUsjLWmG5waqj1V7xkZL8Yg1XnvQY4EtoeRGuiHFRxkqo1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9bv8whaEZsL1jA+KwdtpBKYI9BEUa0UxIPPIu/lIe5U=;
	b=mgdiC30mMQtT8Xfx57dv3u2b0qTQZ/aiF74xzfOHnfbs/sgJezIbYzSn4X1FOM7OaaCL
	 QEn7J8/V6o/uSlNc8Xo/WqjM7hixfGr5+BRPgNjIZ4SjBEIz5wTqdt6tTlxOjYoYKpUiF
	 iZNeimNwLCSMZaPkQ5W8icXng2xBKbPjIGwcZiY7Jj6pP+7T8jqeujzKYQf5Q6vSRiVjj
	 l0B3/JAbD3MkFuxBeZi2DAPA9aXp9CiVREhZFJAVWmyaM6VJO382US8kpiRYu/eQW0lhB
	 Y9kL2WO/xQPtsNGkU4iPvMWtBtPuH8R7tCNT36WMSq2OSkM3O39OSuMsNdNoVkerFYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LSQodLFe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DB606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LSQodLFe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA361F000C4;
	Mon, 19 Oct 2026 22:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448372;
	bh=9bv8whaEZsL1jA+KwdtpBKYI9BEUa0UxIPPIu/lIe5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSQodLFebxKSeG4y5YWRX8S8O2WUag20ZVyuWxoJZhPuwdmAbHJ1sOcdc4uvWThaB
	 HPYsAZU2CDAiUlGvW3HTN5VKbFh5huTtDmbepwEhrLkA8m8AJ0QVD9pCQ2V7R5U8mx
	 RU6sR+uGlj3sQl3WWOkFur0YH5/F0R+Lt02bEam2yuTwbEiVHueXAkipodO5scPVMZ
	 t23c2lMQN1ieZyWnkxA3tCFvlietr0HbLx1UihJ+QcIaXRq0Wy2XcRVA5GwzxCx18S
	 71pCU4fz7Q8SYNtJgcqtY0WWEQPMGRvdr27vv8dgqY42BXYsdlyt/QhXBOyHRJn/Za
	 Tktg2y7DxPU8A==
Message-ID: <sashiko-outbox-178307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] perf bpf-filter: Extend lock_held() to support
 RCU, Tasks Trace RCU, and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019220915.3943592-7-irogers@google.com>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:19:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019220915.3943=
592-1-irogers@google.com?part=3D6

