Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878218;
	b=moKmQod20RsV72xr0aNV3o/+0aEL86ACM2xVnC7iMQTzOmN84z+AGBknOkpx7+dR+FZ2
	 23mu6zLYo8gcI+50mKMbaFo8z/yrXnmDYgqb5yggPS+BoX3AWRMI5sP14pyxfRCAQzvp/
	 zfUBhRmEbl0oMT4YR/a4jXPVVPwmretCzDSRev/ydGLdzZ3tctOw/ZNS3VpNGYP1BTMnr
	 i00nAhjW5dsJVgA2QsTVk6FqyTWkb7cNGXznJ3OMxg6YRup0qdr623crwPpiTuFSxjrL3
	 N/g2RIVY2BmITrSJcdcLiJMB8+eccwM+3DO1ZAd7WmqCbfUC3d6kHshVvPHG+tMaBRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Uzoj6Hi9gVrmhZVx8+qvCC046qBNwGaq57aGGco9wqo=;
	b=YcK29lWdr99L2M7EdKDJblRcLohdo0KLFCPUOGNk6DrccNB2Vk9hUcUzBzD9Otr6UbmQ
	 mHa0fVMLg2xzZZKt7LkAx2hG3RZdGpol0GyjgR6t6SK+9NFNvommIdEJXJUiWhaY7jAnl
	 XkNJYHS5l1TuP2/AtNYUfn9p63uk68Zd10L+BH8D5N5nqbi+7WMeE/EM7bD2fYz5w/m+f
	 8nJMn2grbghC0cgfn6V6sate1UnxPhzWpS3frYhXYcddmaUBrUWboPTdFvTfyo6acjs9t
	 Cs5olLdCJZ+IjB90Ch28Bh/gCoAeKzow7Ij6L58BKlXmNQ7vwdsdhbPtu13haCdNlQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsAanbn5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74486606A335
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsAanbn5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD5E1F031E1;
	Sat, 24 Oct 2026 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878218;
	bh=Uzoj6Hi9gVrmhZVx8+qvCC046qBNwGaq57aGGco9wqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nsAanbn587L64Gzc7lq7EocMCScc9/PRDyddIu3WA+dyTgI3ED8JTTmhbM3mg77qJ
	 gFJKJXlRp27V7jyWmGuLM17qa2P3STp6zykgnTVkWmoR1270vCqeVkImxo9x8C0rUu
	 VfwELfb/a6GOBjZxs3DtHDvNy1YUPt3hSR+4ODAfHxx9Wn7+BGbAVEFhIsfUYkjRKv
	 4eF+pyqFPa4e7lA4hThiPxp6E7AEG/WtzwO+gXjc5B5vJWs+MMR7DjgVlwMYCBIisN
	 fXcg7U+ukgIihaRPVE8uvxpeVV7xrCSpICO31O8xMdrCLVL6P8J9DNUIt2iXAoGob4
	 KBKdUBjTRGzTg==
Message-ID: <sashiko-outbox-183899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 01/10] perf ftrace: Handle signals,
 non-blocking reads and pager exits in __cmd_ftrace()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-2-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:43:37 +0000
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
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D1

