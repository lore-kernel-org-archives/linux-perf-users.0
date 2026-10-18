Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5563C1F57
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302046; cv=none; b=QkLHdBKumpeTV5/XlFwE86ob+M65sKhpyTl/bUGSyf0EF4XN8+XvQPA5LKmjBxC0Iledv/cB15+yUXYLMwjlXYiBaHDvLOZMMKmi53b8oiV09C8zoBFMdwd7F6IFTCsfQgo3ce1k9LitRhQeKCj4/H3qKs1nS/eH4uinHM1kU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302046; c=relaxed/simple;
	bh=MmtMEiMlKClX9hWamn/vwEsyOk9Wh04zWRHj/CUN6b8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZkTmO2MNK2v8/c/UqSR1KYfY+xmmUiBCk4WjUvOgwDW6vlESzQp3OEHgju/FYKSUGCWuGn0ITeP+JLqMKOzqYdTs44C/xfMwcmmGp9hlhv4LzsByI+msyoCRsYIMS2Vneqb+xD93TLnm2unctPoTASz35zFydSUX7ChX8sKQKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrPiE6Md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrPiE6Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8831F000C4;
	Sun, 18 Oct 2026 05:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792302045;
	bh=MmtMEiMlKClX9hWamn/vwEsyOk9Wh04zWRHj/CUN6b8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DrPiE6Mdg4FLJbuWk4AVNdjvRg6JhrrasyoKUdAZjm4Bg73YysfKnYsWiE0hqC21g
	 JQ3B9X3LK5daFdT1rSjhUNU0ABPkt7anFz/RP5fKWAuUZhJQSw1svzfiLzPJpgB/xP
	 2I+M6o2lwhXec6ZZCPk2YKpTBr4rXB4zX04edDAZW2DBWVlRTq43Th+Mpa/mNrakby
	 Lz/O2AXhBq24xveZfNHs8G2AkajsCVPv+U3JvnVDQx5bhC8Od0wPPQQsfxv0SXdVmK
	 u221COqbjqzcnYHizZ+9jnUit7xSyz8xqv3/3s7/t1BNZre0H/wdtd+VRP0BJUJqje
	 bRkYyKgULsQjw==
Message-ID: <sashiko-outbox-175948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] perf lock contention: Filter events before
 creating lock_stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018053710.2572636-7-irogers@google.com>
References: <20261017171437.2066343-1-irogers@google.com>
 <20261018053710.2572636-1-irogers@google.com>
 <20261018053710.2572636-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 05:40:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In report_lock_contention_begin_event(), lock_stat_findnew() was
> called before checking filters.nr_types (-Y), filters.nr_addrs (-L),
> and match_callstack_filter() (-S).
>=20
> When a filtered-out lock event (such as a mutex contention when
> running with -Y spinlock) shared the same aggregation key as a
> subsequent matching event (for example, contention on the mutex's
> internal wait_lock spinlock from the same caller), the first event
> created the lock_stat entry with the filtered-out lock's flags and the
> second event reused that entry, causing non-spinlock entries to appear
> in -Y spinlock output.
>=20
> Check the type, address, and callstack filters before looking up or
> creating the lock_stat entry.
>=20
> Fixes: b4a7eff93c39 ("perf lock contention: Add -Y/--type-filter option")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018053710.2572=
636-1-irogers@google.com?part=3D6

