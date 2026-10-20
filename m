Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538969;
	b=r0V+fKTa3iIhk0N1EKm/iqVRAm6mfjLgtk16lX8w+inw3l6rcOLkqtUfK6Mb1dtUZnu2
	 GVQbqJz5zhIisIOL0me+fbw4kVlzCkHifLNAXESsaNG/XveroiyP9cACUrKfxOSBn2w83
	 75oTlnPs2pQ7BFEmlpEmRZfYXQ0Jg/8h04MBbhW/uruCTFcs9VhKP0LDhlOdkPtQqGqv5
	 vbzXLFcU0fLsS/NTymKTQkiKU5/KDo+AJP7X20I9i5vSJH5WVkS3MtvdsOJTUVQO2tDkV
	 2dKZrUCX5/SMNQ8DfY8FMKpzrFMWpqkebyyTw5zx8C2Jp/IWwVMtgK031aZ+sloohTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M+fwSJW22ARR5gNr/Bn5tV99OMoOBSslMq3sJNMzJO8=;
	b=fJD9BdyuVzNedqZdU0M+cfVPfIQuhswipltuLybjcfWgdxPUdIwD2pBCucRzaJVj+rw9
	 PzYQ4NFpoUL/YlK32uwGMOxMkn2ExYQWHsydUpqns1KhR8vnAk51375LIyZTboETpDnag
	 HDIz1rvRqu6YVRNXnn/Y76WUKKBHWvoRB8sIFcbzhTtYr5cB7ixzhG/RuScB8ea/+6rLo
	 XHaN/vxq8irz2Qj/+CyfmFkqmIl5fj0wYk8Po4DuwMeoyxT8QMvY5O4GzBt/2kIxwctrA
	 tB+OLerK5GrPmPVCznQr7EvzB0DNA77aLpBPy5ckfRetj4+TiV8Oqq0qlNQ70b9tQow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMufEW6E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D5606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMufEW6E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FE01F000C9;
	Tue, 20 Oct 2026 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792538968;
	bh=M+fwSJW22ARR5gNr/Bn5tV99OMoOBSslMq3sJNMzJO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMufEW6EPF801pMMgzotOGaINIRq1pNfo3Dil5bnaVNGPA2uPmv40A8b1s40asU7p
	 FUGF8iRAVlSOVTt2c6LXOblITV3al+8kM66w1MfZAEC7X3BL7Y0elgorBA/Fa5fiLi
	 EAVo7iMvT/Eo7fOdJfjL6broOPIUYBQk1iSDUDL374MzaTh7CFYOCnzt5OaPakUH+s
	 GrQQdALtKvcwxJHxPg+1zBcgHs6JoHqoH97W0OIzDZ3ZH8FN8oS1ennjqIXHl6GNzL
	 JTMyiqtJylj6JL4wz1MAbGiN5pUisk198ZeQYPa2wdvOJlzoQIEELpUNT9RVMBGNrm
	 3vorCdgjdaZEQ==
Message-ID: <sashiko-outbox-179603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] perf bpf-filter: Extend lock_held() to support
 RCU, Tasks Trace RCU, and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261020205859.1080743-8-irogers@google.com>
References: <20261019220915.3943592-1-irogers@google.com>
 <20261020205859.1080743-1-irogers@google.com>
 <20261020205859.1080743-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:29:27 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020205859.1080=
743-1-irogers@google.com?part=3D7

