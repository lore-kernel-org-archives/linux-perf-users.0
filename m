Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75190396B68
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882560; cv=none; b=qibzdM3eQuIHgfMOHiHxvvm21xTyrReN5+5L60zhLV6SZBJJmiROHf1WgQZP0E5bmrL6V9/Nds8wIFFE6OFJTYNePCvyLMsXcIifDifY2Pz8bmudLJ1ZkmaH4H9wXSWCLqvt3PkLAQ5h5+Hze9le7GXNp84ghHlcrKopxS8VXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882560; c=relaxed/simple;
	bh=LNfOuxAzijADMcgRzYHNE1ri1qYCALodbY2E2a1dtr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SE8hKtSsECIbhCsmKSEtjrztAA+7moLo0xEPwykmrDGh2tqAYOglkv7a5rPJSCsGszP668QCqPliNJ51CTK5DrmTSKeKrpC+Ay7pZWmduTwKQj8HFlYal1GauhNu++gIL17J0v/bxKNphyFuSdU5HEOUoTsdAEZf1xeRFCbYjww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltYVyqFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltYVyqFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B6E1F000FF;
	Sun, 20 Sep 2026 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882559;
	bh=oO4FKIk+X/qzQuYC5sMV06UDZJdO1CufLXquC6fvsgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltYVyqFj6UA/RYXFv+yZ65YUwJt17ieNUVjfIGrDJl7h1mO71D71FhV0bZdH93dVi
	 LWCKvEO22MhC/Du1Ll3dSbyFED4NGBHy5TCeqfLRGRuY4P3od4GPnRsZxeNbFhyF1D
	 j+ArlWBliO3kDoUBT0kdev4Zx9zwBu4t7L7bY4IYM79bzbuDOlfdSBXiCXa4cyn19B
	 RncFXAuetSRSCQHuZ+cXJPl3QZGPWOVik0VWzW89RO5Dqfh5CO9LHw0HpZZS+vIy/F
	 KD0QnDxphA4Q7486vu2Z4OXFlyqkLaZ9Jx97fmQwnv2R4Wle9BXP9405KGWtTcVLWY
	 8pavtPkjEQKig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 30/49] perf python: Port futex-contention to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b15cf471e3d41c77f5697301e3e425053e1fb89c.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <b15cf471e3d41c77f5697301e3e425053e1fb89c.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:35:58 +0000
Message-Id: <20260920053559.06B6E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/futex-contention.py to a standalone
> script in tools/perf/python/ using the perf module. Avoiding the
> embedded interpreter overhead improves execution speed by ~3.2x:
>=20
> ```
> $ perf record -e syscalls:sys_*_futex -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/futex-contention.py
> ...
> real    0m1.007s
> user    0m0.935s
> sys     0m0.072s
> $ time python3 tools/perf/python/futex-contention.py
> ...
> real    0m0.314s
> [ ... ]
> Add a shell test (test_futex_contention_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D30

