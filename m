Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448246;
	b=KlsWtQWuhF+/SzpYSZuKNCuWPDpDJqJZXLEVUhZe1oYtR3IpPJzbFoXtgG/S6hCL42KC
	 0qwQhCcAHEQiUCZ9k1cPxffGKce2X8xF9fU9bHzFa5Cc2BmdlFaDgn6oryvqLfth+Mqoe
	 3jlfJ7+BOetGR7Be8ByIaXEJkw1uwMqUF5Q3PvbHm8j8S4+I5TVEN4Yoa5FbzhfVUzlZ8
	 7nTjBMhd32bQSD7h4tJiWquzZEso5GtUAG1JTa1gQdEchxLQgd8WwPob/gH6e2dBd0YUT
	 v/mY5OKz/xweSRINMPMwJ7BWwuQJt9zjgZHt0kE9ZFFqxNxb+PosCuDlp+VpWF2RFVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AVvWdSE0h6xDH1WrQPHKxGKEkLH1OcA3zqtdty4rvpc=;
	b=e+IiBPF3qANm2AYvpslAUoh2SYuRTE/IvroCVPIngvS1f6u/fK+rZnSF6uz0kko6ONSc
	 F4xPYl8WMEV8Y0d1pnfMSLhlslXNP3WN8LXletIM53sXp3UCduwl90Ak9wBTZkR7AEeCd
	 cmAnbXYVrNN7CH9Y061FM/SOiKqGmvwsI5DfruJF8Nliog/a+odLJ8umW65OiTdstBuEf
	 0r0GDrP0W4yyWmDRRZBm94ky6kqMLhWkWJnodvvsE/0ffzfSf6s2fSe1Y9LT94ZLoLJh6
	 14ooi0m9twtBMWy+cXpwbxa/TMOgd6OizGinwfT3iAAy8DCTx3V9zxGpwpdDJTCUBaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNQicxU8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029E606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNQicxU8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6D41F000C4;
	Mon, 19 Oct 2026 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448246;
	bh=AVvWdSE0h6xDH1WrQPHKxGKEkLH1OcA3zqtdty4rvpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iNQicxU8EJI+1pl7sFTEp5IETG+cxcqhiCQhhNXzhGd0AlfWhbWGa/09ZtlkiDcRb
	 QCGVdjzAeIHrLIGIlhouvTQK53mZ80IXCYPSkoZU98mAaBHFyLNeiO1iHVnw6GaI7S
	 uxn6RhvqwSov5G9sSakMhgHTEwIWsquleJGNhxTWzUlL2OjiRA04nbQHmbA0noGbmb
	 /hh/t4SILjUiEtmsee+jOAhkdVPBbk2TJArqeK4uJa6/IeLBzY4d4PgOjsgvNIWjln
	 JMWasYNJhcpH5XcEvZyqFK/1ENMMVrsHax2cBRo6ema3FPciZ5975mnozOsJMVdcwV
	 KPiW1qum1piUg==
Message-ID: <sashiko-outbox-178303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] perf lock contention: Share common BPF and lock
 type definitions in lock_data.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019220915.3943592-4-irogers@google.com>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:17:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Move lock_type_table, LCB_F_* flags, and the common BPF lock helpers
> (get_lock_owner, get_current_mmap_lock, get_current_siglock,
> get_lock_addr, check_lock_type, do_collect_zone_lock,
> do_collect_lock_syms, do_slab_cache_iter) and shared CO-RE structs into
> tools/perf/util/bpf_skel/lock_data.h so they can be reused by BPF
> sample filtering.
>=20
> Also add rw_semaphore.count and struct rt_mutex_base to the minimal
> vmlinux.h and extend get_lock_owner() to support rt_mutex and check
> the mutex handoff flag.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019220915.3943=
592-1-irogers@google.com?part=3D3

