Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF48361944
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404389; cv=none; b=jxk1OhGtk/TN64cv7G47lvkOElBjH2zcUq+p/sjLtzDQ7vwX0yENj5xgiDHonYCVIoZJyzwmONmTWyMJhIe0tlp6cl5lOMuxedK/xBy7tVubnjDawNtod0BB5J1Bjdlah/SJ9257GQSA4vAl0Lww5UPwO0qwvHgOIAiysuVrMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404389; c=relaxed/simple;
	bh=17Frp+UQYx69FX5+62g499hr9Beg+TQbC8+XxqTMkc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ae093anvoOs/5YvsKzxlunAGa/gZZ2fHway8PKAyP7/Np7wt2ehxzED1qsv1jce0D1OhyPAkwjY5axeHgTQtEtCtB8Wxb0ewLv2/lXN0a62ktLUZqQzYi3Wk9V/J8PC05dIXW6FyDQIIw9E0diC9B4GrYxlUU/lonEB1NNiW5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmyk0jj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmyk0jj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028A11F000FF;
	Sat, 26 Sep 2026 06:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404388;
	bh=L2nzIfZLDAOK6il03V8rjEgU+cGc2m5U8EEUjddX/po=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dmyk0jj2BEe0VbLVanBGVGd81QiXZDOEL+0jRQpI5h2JjP+bh1MHsJU7Ru7GOnZk5
	 Ilp6pcz1WFmdX836VQrXsm4ysE3puwTduaDAg5EuB42FxAvhUONXzWHkLrg7rQPof+
	 /exQ4L+EQM2gUlJxSoCW52FL6d0IaMVFTVyKCAACZBuGoGJtTpXnwfRUIaibM85vjK
	 T752VorllZTIKZ/xO1VvXsauAmI2xFdnbDaFJT++iBVDEQXetvjRd2J/vUs7fGRp4Y
	 08CDM2btajJROstrZ06FizEo7Y/tIewFbCtI7gEIVHJcbR45YURAqOfrJEnoRizHQA
	 SXE+V0WpW8Hzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/49] perf python: Port stackcollapse to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-19-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:33:07 +0000
Message-Id: <20260926063308.028A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port stackcollapse.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/ refactored into a StackCollapseAnalyzer
> class.
>=20
> Improvements compared to the legacy script:
> - Traverse sample.callchain directly from perf.session without
>   allocating per-event dictionaries, and fall back to sample.symbol when
>   a sample has no callchain.
> - Replace deprecated optparse with argparse, adding -i/--input alongside
>   --include-tid, --include-pid, --no-comm, --tidy-java, and --kernel.
> - Handle BrokenPipeError cleanly when output is piped into downstream
>   tools (such as head or flamegraph.pl).
>=20
> Add a shell test (test_stackcollapse_python.sh) using a CPU workload
> (perf test -w noploop) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D18

