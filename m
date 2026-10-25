Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966108;
	b=5ZsLFvxvz7awmZTxb1sOVLm2oKllxsHkDYtw6gGmE6A2UBqcQvX5hbk8G6LeUbNp/GMw
	 wlXkMSJ/OnOHLkGcTBxP6Ewv9SzW8Wp1HLnCi2XtJ6mnUk2Cz0mLlWD/0DtUamEllMvkk
	 yyp6wkHnBMU5+GIi3upAaMMkbjqW2CGB+M+BoWGZ0+IrwIffkbBiTogcMB9nKbNF47vC+
	 yQgqMsO+naXfkTwDupdFSevKILRrwZ529JggfjHYr0Bgwa67k3m06p5EYApiLJCaZWhe1
	 H7Cotdpd/XcSWFmNlLIi5t9bMNhR7FXn0LihA1Qt0/or6fglLfLpfFtGYU5L8txk+Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966108;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LOGtp0bnUvDnoqq/l/fL5lpi/rLPjuWXSLSilCVpDP8=;
	b=j+Ul8hC9jw22+dS8ooS1s5e0EH3iIASM70PZ8R7ndpt27OrZbRwCv2/igbV68vT7DR9z
	 rLNbhPdBiZ4jqmcP+8ZOxvV35KMHWYV1URxXHLXUIg6d/aXTJXrsb8LwZmCvYy6bqH4ct
	 fSuNoa2aa7isoIoJGQuWgea8xMYqWJ3EPdcsYsAQNf+9gS33fTBdpbxZn871qfQfl22SS
	 dIi2yw5ckmtHFiCXwKGDTkwUg0HpeAwmPg3WBbJ2lVWXzruzQF3qyXB4DCjZGreGedgTW
	 4Qo/WEbmqNWAvDEUCx2zS6pG/hkubAA/Ront57GYWXQu9wsQXHjrgTFjw4NRH+uzj2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a1JT5/Mp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A963606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1JT5/Mp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCD11F01825;
	Sun, 25 Oct 2026 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792966108;
	bh=LOGtp0bnUvDnoqq/l/fL5lpi/rLPjuWXSLSilCVpDP8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=a1JT5/MpAt36Hdcnw2TI/A0avcHpGZ4Xb9FvvS651096Wom0w9EhuHlPjNzcTd6f6
	 vfH0zfVloYUBwSuRGN+23xapScusaFPiHh17qr/cZTmoh8aIduogWep6CI4yV+euTk
	 Vjqdx/mdH/EMh5afFMXGzdqMIxRugGsEPmekdz+2BOvC7v4cfOrx1jIDs9JajdHdJH
	 IwxkRb/AFqGE0m0niwdVLCBV6wmvURj9sEjxI5ldRU1GRsDS0hehU+rGdGDUZ1FpEF
	 6jx0mTDZaljEGGKjZn8WF27dcJhV2sAfuG018qFYOacT8wxGzeg2FwiRci6UJ8bUTc
	 u6G4BPgyDlokw==
Message-ID: <sashiko-outbox-184461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf test task-exit: Fix POLLHUP busy-loop race
 waiting for SIGCHLD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025214928.1225895-1-irogers@google.com>
References: <20261025214928.1225895-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:08:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In the kernel's do_exit(), perf_event_exit_task() runs before exit_mm()
> and exit_notify() (which delivers SIGCHLD to the parent). Once
> perf_event_exit_task() completes, PERF_RECORD_EXIT is written to the
> ring buffer and POLLHUP is set on the perf event file descriptor.
>=20
> In test__task_exit(), once POLLHUP is set on the fd, evlist__poll()
> returns immediately on every call without blocking. If the child is
> still in exit_mm()..exit_notify() on another CPU when the parent reads
> PERF_RECORD_EXIT, exited is still 0 and the retry loop spins through all
> 1000 non-blocking poll() calls in less than a millisecond before SIGCHLD
> is delivered.
>=20
> Sleep briefly with usleep(1000) on subsequent retries (which also wakes
> early on EINTR when SIGCHLD arrives), mark exited as volatile
> sig_atomic_t, and reset exited and nr_exit on test entry.
>=20
> Fixes: 791ce9c48c79 ("perf test: Avoid infinite loop for task exit case")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025214928.1225=
895-1-irogers@google.com?part=3D1

