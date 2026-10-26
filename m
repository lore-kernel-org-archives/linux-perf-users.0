Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006608;
	b=TzHqjd3i9jWIuhAxEVmR0osfhqLmbhAEX2rkfdNzmqGaURoCLFo1BsGs+R+jlA9X6fhp
	 cyCmSXFEMO6F1PaaIJanW9WxGQDH13QSVhH9q6T9lRaRwUKCf/n7WuyXzQrrb8iKA8PhV
	 nmv7n6Zi4M3v9Roa+1I4OjHhbaTF33FRUy7Qkgs2sYzzAofwrwru499OxeUcsWV6ZrPow
	 KQOSyxEUTK+C9m0nDH6CAVtRzGDjdLtLSA9hIekgv5tLj0hje5/4bB91wypjjL2+tf/2a
	 BGMl2K+YBcGuqez5BCzkwACyViG5K+Jd82UuGCONlNvqX6qCFHde2cHqDjS85HV9Z5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8eNjLVjBIE2lo/wVmsp7a2iyjvM3wb590o5iybcoAWM=;
	b=BUiRlFb+xZZCcZ+LWv0NKpyu3zwiVBuLGLzgE9RVzpF7H1y9ejxMmjIEpnqlthmdQekc
	 qsmeBk6afUd9+Wl/HhysoyxsH3WaEJ0YqN8PUMujrMuJ8gXD6XkwkvXy4ZVfqUGcWY7qw
	 qrk6cD0La24dtjDlV0viLCRRjWYmo3a5j4W0Up12t/TjSUQM/XBcsfeennOkGqT44qrM3
	 Vt7M2emztwz2OKYfIPrQSyVkKYpln/YjVMgcuBDwigebkbNji4BHj1HWu+Xj+H+yLWK5S
	 nRI+Cg7kEZrsKDYDVa9V3U0jyWM0+9TGo5bmmn6GuucG1A+xevqcKJzHc4KUUlYTOVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QE3jyX+Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D201606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QE3jyX+Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2C61F01825;
	Mon, 26 Oct 2026 09:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793006608;
	bh=8eNjLVjBIE2lo/wVmsp7a2iyjvM3wb590o5iybcoAWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QE3jyX+YeupVa/Khma5zdBS3kVZAkp5S9xC0gL/wDTrU4/STipM/afr4MLucEIOjl
	 FGtL5AnLqv1Sbvnh2ZFzS6rNjDoCZru0WlGs1N/MfEyaZzJpmKx6ppyFQVo3IDGQA3
	 bT+ZWmDMnps5vwgvmMAvEW3cLDcULIKhEmVZJ2Cmh6epaQaFEA8Q6M2of5M0HNvL/r
	 faelCpEMtuAVkeRNvRvwZXVnyjyKsrXJDzz4+CcufEnTeRzmovDqhj/E8Dqx+5yzjy
	 ufo7ElmkYpkI2TTFK/42k+geI1CBJ9dalvOYUQt2wsH2dYoVIA2adgc3vqo6Tmd2Te
	 x6GvMnxWHnznA==
Message-ID: <sashiko-outbox-184773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 01/10] perf ftrace: Handle signals,
 non-blocking reads and pager exits in __cmd_ftrace()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-2-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:23:27 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D1

