Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1838B127
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404238; cv=none; b=sxI7nDHlH9tSpvDxgvdm+NGUQHDkHmnlPWsWdHezE91kOoB6gVYNwv2rDnziomzmxRXcYf/ZlZJCOCQ/goyMBXszPygiNL6UPzI/i6/xM1og0660pkVy5vfEjbHDK2shVvBG/lD257eD+fGpO0cuVIdYYJvY1sPiVBB3bCaz198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404238; c=relaxed/simple;
	bh=c2FexwFqrX97dbgVW1zHvnXeFeUA3YNotWJTiy5pxtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOvGsVliR6RJme4/jPFzobiAiHeD8pcf1avHDpJinkjeUYHemxPrpNstfYVq0DiwQFRYIpVVHSawqSk46qaOyLQ76Zx4dtyIb3N83Yy71jC0nmac2KBVe0TLrg6jh58x28I9OK74fUyJK8fD/89FtvCY1TkF+LN41xbUKCEyADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3irjT1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3irjT1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E25A1F000FF;
	Sat, 26 Sep 2026 06:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404236;
	bh=XKkDf1yP5uPAyBBHgKAkbyLZSch2PdW3vR/gT7makbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O3irjT1Dr16rrh515N52PBcLLfezvu6kOOP3l8ijxXAD6kWK+SHBkOQ+RxDzJtYhP
	 w+pv3YpYnM4e7nqrip5n4Q96QpOBfDOs+SYMl/2msNGE2ZE5xvXMlHLS5XtW0kvtrY
	 qDPXeyLZ8H0teaVro0XsGytDZLXVOMXQy/J/aavNniIlG6cktdPBxaBLSP3J+d1i15
	 CfZ35pcXF1/Noda9M56vcWJJl4flQXJ1YZi6xWXuPbWf1KK7KXNLtlZ/gXVmE2Oj61
	 lFkpla5rTVAzDrz1/Nq6/0/K1O111WG87NYWplbYCGbidQbTfnUUOedls7qrqlHWQ7
	 SJ3wzaqY8/zJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 26/49] perf python: Port sctop to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-27-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:30:36 +0000
Message-Id: <20260926063036.8E25A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port sctop.py from tools/perf/scripts/python/ to a standalone script in
> tools/perf/python/ using an SCTopAnalyzer class structure.
>=20
> Improvements compared to the legacy script:
> - Support both offline perf.data analysis (via perf.session, advancing
>   display intervals deterministically using event timestamps) and live
>   monitoring (via LiveSession with automatic tracepoint fallback from
>   raw_syscalls:sys_enter to syscalls:sys_enter_*).
> - Resolve architecture-aware syscall names via
>   perf.syscall_name(id, session.e_machine) without requiring
>   python-audit.
> - Replace unsafe signal.SIGALRM dictionary mutation and os.popen("clear")
>   subshell spawning with a synchronized threading.Lock / threading.Event
>   timer and direct ANSI terminal escape sequences ('\x1b[2J\x1b[H').
>=20
> Add a shell test (test_sctop_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D26

