Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590867;
	b=sH+8y/I3bb4mhNEl5LBbOXb+LP31lfxThQwYGQ0FGvJky2BkrSt7989PPM4THK7THOWx
	 KOl0hUG2cVgmGN3v1ROKXPI/jiSVURyHrb8645v8pkgmZtzB/maKMRy4niRoPM0DMUT+f
	 t+MA0BZitM/qD8/jd+k33f7dgaa8oVu2Qkp9BRil/7G+LW+PfkKP1SUt9+beX0uLzFab1
	 E6/EGrmp2CYMDwl82eV+UPxY1ScVLnXL9h5JUaPEbQqxVm07oA/SW4dSrk9pwycC59Ygk
	 EWyHpsQUDQbHe0Hy/leHzzFq4X8wx1EE4QlFXh/hEgUocpjeDs2488w4AisqRLXI13g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bt1ta6IRKXFF60Wz28XxiAQkHAXgTLwecutwDfhAqy4=;
	b=JixIIDzUefL0k5iy5yHWokcQhWwbhSoUERoLlndo43SxiPF5v0LP5J7vXTCR1YqVxDrs
	 lCa17yer/sfI+Lx60IS8wFTxs0tWw2S9Z7rZQTe/5Xo2da/yCS9EkPYbN1F6/xIO2hjEY
	 EiTh50kB0WcF9KzLEULYYDGd99yeOZGHUD0yXWbsnKraw1OIRXaGcA3BUktEs7u+A08qh
	 OeywUPbL8KAZwD+aS4YmTHbcnneRKpbCkYvPor75lt6qSk/l2vg3AdQpvQK7hW2+yXBpY
	 cJU9Y55wvpr6PL6t5iTsR4sKAhElKR8IL/HNV0FsQK8y+jukaaZZrgpGoZ8Jgze30bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAEp0Iw5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36D606D852
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAEp0Iw5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FC41F000C7;
	Fri, 13 Nov 2026 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590866;
	bh=bt1ta6IRKXFF60Wz28XxiAQkHAXgTLwecutwDfhAqy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAEp0Iw5GpCp1AobCKdSMSX92YAjvV6bj1Jx0CQWfuNQ8VhkGC7k2I79DwNW0XQn0
	 JrUyJgZeerBx4KlvYYe7eOMlxozJE47nONKQSajsumIBmF51HelkX7NB5Fimhes+pn
	 IBUByikzEdgrZZKb0YQ6zdqBHM0YHdvC1XX9pySbaUb4tovHklqDW/VGYwV2uJajE5
	 wdOsNbwrgg27Q0Lm71+LlFjQb06T6CpYaWSf7RmEWUsMEZxbrsr47SnLSOF780JfcL
	 Zf07KccdjzrZBN3IV7VQJN0+4pu6/TxTPlPd5UBmzaMvucirg5P0Hsjlk0FhjIAy9d
	 FiE8jzR7gXl7A==
Message-ID: <sashiko-outbox-213307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/23] perf rwsem: Add down_read_trylock() and
 down_write_trylock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-8-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:27:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> On-demand memory shrinking (perf_session__shrink(), dsos__shrink(),
> symbols__shrink()) can be triggered from OOM recovery inside allocation
> wrappers while the current thread already holds a rw_semaphore (such as
> symbols->lock, dsos->lock, or machines->lock). Non-blocking trylock
> primitives are needed so shrinking paths can safely skip any locked
> container without deadlocking.
>=20
> Add non-blocking down_read_trylock() and down_write_trylock() wrappers
> around pthread_rwlock_tryrdlock() / pthread_rwlock_trywrlock() and
> pthread_mutex_trylock() along with SHARED_TRYLOCK_FUNCTION and
> EXCLUSIVE_TRYLOCK_FUNCTION thread-safety annotations.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D7

