Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA466359A6D
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969274; cv=none; b=UfWYbBGdEHueDCFQiKSqvEeQY4181RCzZcIXGbDqBr+WsgVHm5ywX1OzS8OKg2lTCJoVGaaj3vFASHPkCEmKixDQHxSGHJpwNXNYAgGh0Q1n24pzzE3ucuHA/wonniWnGg32jaDAabjn4CBHCB3Q08sUAItW4yuCohON0z8w2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969274; c=relaxed/simple;
	bh=chqzvWX5Jb2cZftjh8afjWborjX8YGZUwhF/37ASbJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VsQzR7jOpSrBjMGBa/OxJALVWIqqOJ9PnucZVLBnRhqH4sb3edz+9uIXzFzE6bY40kSsivSLsqXV5eHMMEPIZkL2yPHqr1HCvZ6tpNVVQXgbMr0B44PUnWSmuAOhvs8lRsnpJxjZV9couJ2JvOHbta4sxenxUtXNfwYr2jIR5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHqgDXxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHqgDXxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2201F000FF;
	Mon, 21 Sep 2026 05:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969273;
	bh=Dm/aPs2UiGbrkf0+QSyME2duJZ8W9CalkVEpWvYT5YY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fHqgDXxWfzO2S3sT2mjyF+cxZp1uZ8GRfIXIOp6b5pKLEYdfxL2kCW67O62xI7vjQ
	 V+N8IcCgxPzb0IUZYeWy/4r9dFVGfu/nIMOpdaT5BI/Ccjkd6E5yaWRGpb6dDx6AJY
	 Kmijt8HHb5O/wY3F3KVyKO20U5VYNiXqNYDQVHTJ6WPelbVFMKp7i0Ya8LWuRnoKbw
	 vbJiIHNFOWEUeGZkmQlaQTDR8+7DI8lu+y4cFDU3+WvGA8sx3D9H/dXkv0LnjvkfRv
	 2V5gQYa+HpXgj6lZ/hEFG7Ic9ONMgjwrGVzb+ViGPQ2U9WKqlxFNr55c7h61Dpsf9x
	 ovnQcvYppOteQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/49] perf python: Port sctop to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <34b516365b1309e631459ef0871e2330565d5150.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <34b516365b1309e631459ef0871e2330565d5150.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:41:13 +0000
Message-Id: <20260921054113.8F2201F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D26

