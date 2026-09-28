Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF037B023
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620506; cv=none; b=BWiqtkabGu+IIrAcxmZ7J8KolDzVRbZotBFUy7e872LssI/rc+hJ5GWOp8SDcrkWhmCJTT3eOyVUnCS7fxU0jUCvU40UMgBsIoiuWVZnE/SXLZ5F/1OFhctLrYTs1e7An7+8LDAGhGvXNSHrl1ggv+FXvF6tQV/yHB95/HN670Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620506; c=relaxed/simple;
	bh=q8lhfmxMuTuLwoKsgKT3HuDL6gE92DS6JTjWLsUn8Yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEPHk+Rc+HKhtuYcdHhzlpmRMDS/ObMt0StPXH4tNpzr6CkBTR4ljbZ/XL/X0mBXm1TWyerbq0a4N4mo9VcPoXELqDb9adb5GxjqYKqrP5HXDd6kbWdpVDFBpBgVLOvzszx07I8a0KhQ0BDrxRJO6LsTtKU6MR0mk8tUZDu4qXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEBT9wVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEBT9wVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728211F000FF;
	Mon, 28 Sep 2026 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620503;
	bh=q8lhfmxMuTuLwoKsgKT3HuDL6gE92DS6JTjWLsUn8Yw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEBT9wVpgf+PNMLnCGCV2jXvSx/xtPgodBMSi3zeOak1d85H8mNahBW8LF/+1dzv/
	 vVLwnJV16JQ2E+wUpi03MVjmnz6emx8SyulRAsKoLMULWyqfg0CitR3tHe7T3FVYJc
	 /7/YkFkc23Pde3uilaeis9eGWEfU0NEy3zfNDKkP+SfoNlj3xp07z3Gs8FK67xS5ez
	 Y3BdoHsV+n/0R08RW6anM6eVY4tAKsqPkgfxj531u2lmv6LZxvBnMLK6Qzgyg6coJ5
	 wYl2QfEXyloZoZUMHaw35cwIcvDbZk1m9JTvt+vAPQpaR1hWspKNjz0Ix1O1OeEIeD
	 Jj1QQgaors96A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/26] perf trace: Start BPF summary before starting
 workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-8-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:35:02 +0000
Message-Id: <20260928183503.728211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_start_bpf_summary() is called after evlist__start_workload(), so a
> short lived workload can make its syscalls, or even exit, before the BPF
> summary is enabled. It also ignores --delay. Enable it along with the
> evlist, before the workload starts or after the initial delay.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D7

