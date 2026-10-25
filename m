Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952310;
	b=exwLIdHekzz3eARzQp2DEh7YKdKecw7Hb7HMBKcUR4ah4mLrvIwsIbf8D9kYA1mBnB+R
	 pxUBG0l90/cMtWVQc2cMaKGflAV54lEEjcH4jWpPysAiZd8YyI21tIP+i/HfYYnKcLtDN
	 qdI2DMjo4lcb3NTfKJdku8OGH6Qr3WVBiogNK7hkZ2IN4LBkDo5i1j7FVHEwdFal05H1o
	 s36QRFERoVyNrvjl0iKOYvyET3L6HHYJe5nozPw0b3f+vxE3uEvSUdq6DeoUHDYLc5GCV
	 GvGEIfz1+sQfs9OzUu268hHZp9FvBdWe+flV7cVbRRagBqmPzrd3YUOvjUdXa9LD/FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FYNIKvvCnn9srpjfd6517ema8O6nw1bHLz/4nmsdxdE=;
	b=lNi/3NCrScOdCQN206ip9LlkikOTlX3o8xLg0qsBZVi4puF30xR+FEEFErzizqVXPq6y
	 kIm84c88Vdxy/AiGvJxhgWLF2vV3eNxwFJp0cAuSquTsBODKFXZkczi8eE+p+lvImGE1F
	 X99jJkzC33nlnKhbGR8UYDhUqTEFoOaDVrJ+ehMq7i/ijX579xsanPKQvBkqfhaAClt0a
	 nIYQwTiWT2v1hdfMhvX7c+d28S47CnyAZJSZNbWRNr36s5B2jTMBueuUd3C/dcTTecb6q
	 0zUTC3+dewdjR5H8f5/jYWs+ivAufexndcAxFqkoOS0ePHI+LtJJFkv9ytx+a0rv6gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A03Hp79P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F07606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A03Hp79P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED891F01825;
	Sun, 25 Oct 2026 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952309;
	bh=FYNIKvvCnn9srpjfd6517ema8O6nw1bHLz/4nmsdxdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A03Hp79P5bmc3GRwMYJYH6ksJCCSf0DjFfUywrY/jCxcz4eQLv6tWv0TjsBvw5pPe
	 VrxVIhQYGhC9ZnTJJ8PJO7Y/Cly9/CcUmTpoM4mLyfe1KMvAQ23r9mLqd4il8fXEng
	 ZXxTRB+tj/eY3Je2Ux1F6OyxD/ZT6HtP32xF9ShYWoX79lp9Iy4sZFexYD8bwkvYOb
	 2Xz9qPzuNXV6q0iHI1sC3IpxMdugWF+bWIYun35nKST04t/oDHCLJcfKtFGMep4rvI
	 1AbXnyy1xUZTDrvlsUEl4KT1iMFv+eMvfNMeqkO7M7lqPio9Cb5Wb0GHgCsjPtv12P
	 4LLTgiG/DRX+w==
Message-ID: <sashiko-outbox-184326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 01/10] perf ftrace: Handle signals,
 non-blocking reads and pager exits in __cmd_ftrace()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-2-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:18:29 +0000
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
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D1

