Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C43921FB
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257450; cv=none; b=NvY5RxgV1kUJH05ShRs4QY0uvfQZayDQPWjeic4S2vFCJ+2EtXeEQIdU5aFnsKsk/8/mtep5+4Q5DX7wWAl3wOAjBxhWYpn2iidr6LJ0hhpb/GzczOb6aqG68KgNdUP2j9kCWDhtWQYq241slTFtVhvT+GNmiYyN+G4jBt08O/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257450; c=relaxed/simple;
	bh=grUSTDq3fA2d4W62dBQCs+1Wtlc6pSx2OT59suIfhlg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JegB5dwUQjE7OsDs/WZfZxNNfgCLFazRvkyvoRL65g9ALAWgZ/PlqKu9zidoc0y7uKKm1Wc3QByOF2e2780l8GD8YQegC52XSbbHWyyqarqqbax9nx1e+6N8uKmpipSX/PM7ufftKJuZkG6S+E21OJ/qey+pPNsuabQzyLGueFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4taGaty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4taGaty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4775D1F000C4;
	Sat, 17 Oct 2026 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257449;
	bh=grUSTDq3fA2d4W62dBQCs+1Wtlc6pSx2OT59suIfhlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k4taGatyPcKDCmAXJ+8c18zylOw/rKgWXXlWO1cZlPm1s7uaN08Px8gDJrXAkNEAM
	 zlPmozQw6ilQI2Z71ZqqZT5GgtBVz7WPVT2IEJND2JVIBjH+xYhTfGjC2Kyh2BSzzI
	 cwtpyy/vs6Mb7UW/j4tNuikqtPxG7S1nU7j4KecbIvnOxMfz2G21QscOB4MmUpLQ0d
	 8xAL0wP0Iqwj8uRrpiVVWUf8+64ej51ORSh1sLXf3V8sKsbCFdth9O4fWSygZuHTjr
	 kiwHS+cyzBUsSb8YgEK0K6SaDJNOlgkmx0IJY6gYIekexIfmJ2CzqRUdux4njqqu7f
	 z44fQ1D9JlybQ==
Message-ID: <sashiko-outbox-175697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] perf lock contention: Filter events before
 creating lock_stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017171437.2066343-7-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017171437.2066343-1-irogers@google.com>
 <20261017171437.2066343-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:17:28 +0000
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
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017171437.2066=
343-1-irogers@google.com?part=3D6

