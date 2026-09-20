Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402B360EF6
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882623; cv=none; b=I0fjmw3zUA538lH03d7Y7lqI3XdFgjIFRS0dpV/OAdPwoxx95RyMgYKSzabBSn+V+Xh234KSgaCH5mXyQIZiW2kLaN0OiOX7qyqta9kBidSF3H7+tBaM36JpWuu2Fo5RWjBcsjwQoTfdUKlUFGkwm+Qeu2Fo4rZnmb/rRyIJP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882623; c=relaxed/simple;
	bh=A1ijP84lNTiwbAF7jg1AxD0TKXrcfBBUUMVcEIVzeNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JFL7IUUIN0DGooKDrRTlaf2Lau0xAd4xy9+NNje4dsLF9XwXZuaSMkLMO8LR7CbD8wskK1dNlHm80qwl+79DohM94xdtMMXW3ANjQNqWnY1SqOHqxA11vNYQ4ZgvRbbL2h9wBuOb9M9Oi7Pi75q2HvS6cPyl10cwVwHPAHoiNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flkHctIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flkHctIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610E01F000FF;
	Sun, 20 Sep 2026 05:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882622;
	bh=2rl8uoVuJAJwwTLRD6EZw24fqFZtzPVl8vpKkQwwa8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=flkHctIzh+8YNsaAHQ0EXielFVB3B/8djys/uBXWwButYle9iiUFiSnNC+f2ric52
	 hAjqofRwjvYJ30LfrJdSBELsQUKGEsR4cAOaO5cW0d+6QKd6iuPgqwZV574DyaJgQ3
	 +wshRM5tBDJCjpuMnedfvq5jA2RMfZ6DEM6BZuULwSi9F3YC7PsvvUT3nIrRzOC+rG
	 EheNtq7jxZYFCiZQ/QSZJ7rjEByKh7LWp3mAvitfGuvCl13znUN8P8ioUG1O0yNBrY
	 5Yq1Mzjd+Ch/xY2oxCAvmFOB0PAumsW3RwnCn+mXACU39EOGQGi3+PYeZjRuXDfvRz
	 27EFOVtF7TMmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 37/49] perf python: Port check-perf-trace to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d9c044b5bbee092583b5bec727b06df44e618d49.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <d9c044b5bbee092583b5bec727b06df44e618d49.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:37:02 +0000
Message-Id: <20260920053702.610E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port check-perf-trace.py to a standalone script in tools/perf/python/
> using the perf module directly.
>=20
> Improvements compared to the legacy script:
> - Access tracepoint fields directly as attributes on perf.sample_event
>   instead of per-event dictionaries and legacy Perf-Trace-Util helpers.
> - Decode symbolic flag and enum masks for irq:softirq_entry and
>   kmem:kmalloc directly in Python and add -i/--input CLI support via
>   argparse.
> - Add full type annotations and clean up Python 2 idioms.
>=20
> Add a shell test (test_check_perf_trace_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D37

