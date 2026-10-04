Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BED3AFD12
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109725; cv=none; b=q6ApPIWb5A0Y0Jn80CHgJupAJFCH+hPTloUhWCRHpsPQu3L8IkUPuzr6R6wW/syVTma7qpaUWZ7Y9zI+RQgUK+/X+I7jAviSp2Aega4+fyZyfQN6YGkKzIlqImN3KZvgXU/qb8urBPmINXN3IbXAxH0pBiMQW5l+XRMa7214wv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109725; c=relaxed/simple;
	bh=jFZl9sNRbmhB9PP9NwggHONeiLNde7aorxOAtw7gQeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sIb2JSyNsf9+n4pCk5ZWbhSN0Kw2zwi2zApAHgzxmC0vrAYO5RxShLqejVHJ5lc/aV+a0L+kfmFYpNpr/wGBJWJB5A9ZEt88z39nRm+Cd2WIMkSdSNrnmeWqFlEO4g8xP+ZVWesbK3mR/i6W/YOFG/nHtzQFpMG9Nu5USUX4gEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmzS9kK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmzS9kK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3158C1F0089D;
	Sun,  4 Oct 2026 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109724;
	bh=GRPwGfDaIDoMS5fBjgNiFwxcWNX5ejaWWZikAjdW8Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jmzS9kK5zw1NewpiLmzcgoFbTnsn2DSdas4VfYETc147zSDy9aR3takWwpXrzXW9i
	 S2ciqhv8dKo5xlhuWmf0XyH2OBBGpPmK5HEHsgM4g+JCLCUs4D0qn/7OTXOul9UtLi
	 PEM0dW3aIUCpnqi3lF3L/EMA47wVyCBNL8Ilq3dCL1HW9CynZfqdBxazGvAMODl9Lk
	 ueQc8d9nPVo2u056Q0LxIOzI/q7Z3PHzYj9NyjSoYQPGW3Xn8VH1IdE1bGf7+xDoR/
	 htDA5McjQZwojmEzJoFI5iAMDdUk7vl2FvFJQm3g4V7VcLPNRTdLXGLVfeiafpumZI
	 Dr/rn/i8Cj3Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/9] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004102133.26392-7-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
 <20261004102133.26392-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 10:28:43 +0000
Message-Id: <20261004102844.3158C1F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: ui_progress updates are
> only shown by the TUI.  Add --progress, installing a stdio backend
> (ui/stdio/progress.c) that prints the phase title, percentage and
> counts:
>=20
>   Processing events... [ 42.3%] 317M / 746M
>=20
> Phases can be nested, so the backend tracks the ones started to
> complete the right one on ui_progress__finish(); that requires
> init()/finish() pairs, fixed in ordered-events.c and the pipe and
> directory event processing.
>=20
> With a pager both stdout and stderr lead to it, so isatty(stderr)
> turns false and the updates end up printed one per line in the
> pager's output: use /dev/tty in that case, so that the updates keep
> updating in place, untouched by the pager.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004102133.2639=
2-1-acme@kernel.org?part=3D6

