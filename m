Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5AA2FE07D
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930893; cv=none; b=r+3siVRIRC4p+7n1HtekyDWDOzYIt9AcOBIXgXDfbAwMWJQBX1zPOsqkdmUI6p56xhoZBeSiDngPOI5f5+Zp28irYR9tLtYBraI+PHnaLE72sjU3hDsauG5K1lvdqjSxqwd5bDEljYKlgDv6lDjTLGhboDwbj4539k2eQDVjnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930893; c=relaxed/simple;
	bh=ZtSF4S85dX5G7TvAYLTZzG9oBZcuIREFOsR68z3rW3g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=D8V+RYHzU3iquzWHefnbj0lBFAD3HRgi4UuGujX8PVGJFGLwq1RRKbMdszW/5+yWJNqAVgVYu5PUg17vdbaYsRHGZhonpTDCT25p6oQW6Cqi15wkGXFgJ3Bn/he3EIm1HT2I1dJhumFl9zS39Uxi6uL+zPpvHyL0no4Zo8LPZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApZxeIsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApZxeIsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC24B1F000FF;
	Tue, 13 Oct 2026 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791930892;
	bh=ZtSF4S85dX5G7TvAYLTZzG9oBZcuIREFOsR68z3rW3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ApZxeIsIqPv+dY4W023LW1X0KRqaLk/wC7vV2X2wuxMRZRE+UsjyQlTF9oqySjkyg
	 /KaR3a0s5xEoaLv0bB8ODxWge54iZfuW5xm41Nu0LHGhtWepMhRrLAASvAaUSqBE+1
	 RIbqGVPDdXMNuXbYautTkEkzrcBcknmkI47e9IZQ37U0a9Gg2yc0QhNLDutkArOyys
	 /SoAct8gV9dPslkxT6LyeQDPiUyRcfsS3BnZOEJR/JbW4dHNYUfpOONf9RMdSq3Bf2
	 /mVWPyLX3DQbXsck43WzktNezZ8ZPUHaf/nR6tnJ4X3IGTSs0E7K3tx21FGbOVNgX9
	 OQ1C+YxYy36Ng==
Message-ID: <sashiko-outbox-170582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-6-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:34:51 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D5

