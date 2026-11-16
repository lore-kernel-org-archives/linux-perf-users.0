Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807730;
	b=V3d9/UzOQOsIA2ZcW/MKbnhsXxefOziUiYHmCXvvUkwIrZ56iR8cv8k+cIuD5Midx3Vv
	 dkdlekdPAjXxDpPaD3eWRXILfGeLScPzPc29WCU8m53oyWmNwmGmred9TEiRhub3bMbcM
	 cGCO+9GWeKtwjHla66K30HbSp6l7cYiLYhiVx2W+Nh9VB5/JSeYHGBvjGLknLkr2kHwtC
	 mXEyvqLKMPNtMydaG+MvJHUoeppFiBNo9cFFPhSAvcue3NRCwos4J/q2wuVtYvFNg3/gR
	 X/ROBmKxjEiS4EZs5RcFEbKtUKGTanv8/gq22fjbqDaDi4ks0CdQUcv1xtTVte96W1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807730;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SJ1dM98vZXyxYwzNicvRdZj+K8KZ4aJ3tcWC8NAKDSw=;
	b=XmzFGyViYCCMAQwtyIsLfGTuANEtk5n5q2ZP9wihYxI4Qta4fcAu/V7CzNUAk56qKDO8
	 KsqrfGYI+5kAQJWLvtKGHb4I9weLLw5pLnAynKf+6d9byjZq8fkyIzJdjqMRaLa9pyssJ
	 KpJ1UafKqIB7l2Nah+B56qxX5xPFhDgsi8X0D1Gor+zyRGYfyBdSTnXBGuptviMNWOSF/
	 MlxJShqECf5SGuqHvc1/auJLbe9AmM4bVXWbZOLvBbbiTw5D/YLn7+xWlymeoOPFX6N6L
	 foNxmIGX0LBs0nZzk4VCBDLUhJlMfIDwr9h46aPOVQc96GXSnypfJ04yxx/NKolIIqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LumxJTt/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D1606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LumxJTt/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6051F000C4;
	Mon, 16 Nov 2026 05:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794807729;
	bh=SJ1dM98vZXyxYwzNicvRdZj+K8KZ4aJ3tcWC8NAKDSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LumxJTt/3eFZiqlhYgFkYp6y8oQd/MNeLdzLWu97FTMZ10xSsZmn5a8Arivim8wHr
	 tAk87G+9hogZwfhqrNZWvjtpwr3fS9g9hEvI02VkojnDkuFDN2uvabqn8L4DIRYSWG
	 IlRDlcX2er6MUAW+4oOkNzxn30ltA77BeDJqGHCUdF1xk2dUWgKUlTykOWO8I4L2j9
	 eG9EgNKFmd4N2f+HBEOltaXoCTjWY0a8mebunuX7P88f7uezV7KPwcQp9+RrXmwDOB
	 PUiywmWyj0xt0FF4qG7fF0NFmQnxwTiQjAA330TfXk5LpY/wqzW4bBFUChHOJTh3UR
	 j1YZHDlh2gMgg==
Message-ID: <sashiko-outbox-216221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 07/11] selftests: tracing: Add syntax testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179480683347.38065.11389672080760832332.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480683347.38065.11389672080760832332.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:42:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
> of the watch probe events.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D7

