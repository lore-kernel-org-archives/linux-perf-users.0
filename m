Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655988;
	b=cI2yFwvpqvUuUZzTxs96OqMfYGz+8XND9hGwrJ6wUt+CBDWWckZ0tyoONOLcBi6yDpS5
	 i9N9f/1qLYijVJxFhbH1L8P35+kheB4NZabzRH2IiUYb2aOg3zmxeYYgwfML0FCYRY0YQ
	 Oh1z090QgCRvnGPKAG8EiwbqAl6UaTTiBMuP5yP3SGUOShI2oZXuDlOz+818V3ECaK1pC
	 nSQwkDfljS5wRegy22FQZP7QeRwzVTxpMXmF5HirVs00X778+U6KKJ1Rkl+OaKGGe1Tqf
	 /nut6wjWAD05gh7IVZq/58fPzDl8XTIW1mPk4REjZTPU4T35I37GqEGt9PUMEujIhpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mBSzmV8Fxx7AEov+0gLciVsFc2LfoNvY0oe3KNQz9LQ=;
	b=j/qSe5CLDw33lYg7EwnTwHtKJK++E169JpSh7A0GTKrlrkeSAhCs1KEDO3aul6kZDtbZ
	 eqIgYYKRFDo5yzaOoN4+LacfB22/ns0+10Y0oBNNwwEcmKuo7pSvN+u+GlAg4G8vLt/by
	 mVFU1ZIOKvrXnUGE5qSojppl75CrHJrjcdrMIu0DheLJc+OCYmUxlFnkO/pm/C4M7aChj
	 Pe8xOfzpziR9bz7NpvSQe1TkJQi5bPaGD8SIWOXI4ohdJms/f6GgePPZp7L7tFsZdFcax
	 KF5ZbOC8kXq5zblGCwO3NIftcoHXPuGWA/HhMRVgoiFYoifQDj3B61yFFZwBTawDDRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWoy1fBL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19148606A32D
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWoy1fBL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CA51F00A1B;
	Mon,  2 Nov 2026 21:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655987;
	bh=mBSzmV8Fxx7AEov+0gLciVsFc2LfoNvY0oe3KNQz9LQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WWoy1fBLHAZYdBnlz3tZOX8af5N1jmImb+wT77WjJE3FegGEmh9WudKeSqigbutpr
	 65m+UYMRxZRCK8YNC1UwIDVePeGIDj4ZJFDMf0CXg4Z0MZobuiLaUFT56w4Rjv95+i
	 yvsbu1BOVFURdJgpn+I8sJrLqM9c8eQQdfE2+4D7YLlv7airCEgzuqvn4Jk3PyCN18
	 nJafUUErYTmaHtoVfLH7Ga0l9gbCEF1icVNhKyugnHDxZXQsiQ6ZWf5Z5mI5hAnYRY
	 fxLrvJO4AMBvKzahZ/LGd2nXeqqnkA92vJjm2B58QXkYt5vMAqWagafyFxZl7y2JKQ
	 x0p82C3sNfl3w==
Message-ID: <sashiko-outbox-194232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 01/10] perf ftrace: Handle signals,
 non-blocking reads and pager exits in __cmd_ftrace()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-2-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:46:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In __cmd_ftrace(), trace_fd is configured for non-blocking I/O via
> fcntl(trace_fd, F_SETFL, O_NONBLOCK) and polled using poll(). However,
> the polling loop previously treated any negative return code from poll()
> or read() as an unrecoverable failure.
>=20
> If poll() or read() is interrupted by a non-fatal signal (i.e. SIGWINCH
> upon terminal resizing), errno is set to EINTR. Furthermore, read() on
> trace_pipe can return EAGAIN/EWOULDBLOCK even after poll() indicates
> POLLIN (for instance, under concurrent readers, spurious wakeups, or
> block-mode trace iterator options). In all such cases, breaking from the
> loop causes perf ftrace to terminate tracing prematurely.
>=20
> Additionally, output errors on stdout (i.e. when a pager or consumer
> process exits, closing the downstream pipe) were ignored by fflush(),
> leaving __cmd_ftrace() polling indefinitely until the workload
> completes.
>=20
> Resolve these concerns by retrying poll() upon receiving EINTR, retrying
> read() on EAGAIN, EWOULDBLOCK, and EINTR, and breaking on EOF (n =3D=3D 0=
).
> Furthermore, detect stdout errors and broken pipes via fflush() and
> ferror() to exit immediately when the downstream output sink closes, and
> handle EINTR and ferror(stdout) cleanly in the subsequent buffer
> draining loop.
>=20
> Fixes: d01f4e8db22c ("perf ftrace: Introduce new 'ftrace' tool")
> Cc: stable@vger.kernel.org
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D1

