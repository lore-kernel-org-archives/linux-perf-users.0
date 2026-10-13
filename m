Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB148A8D9
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916491; cv=none; b=jppU9F9PBiApQiesSrnCKIG4Bbd2FQYfIu7BO1Ow1HHmuZe+QednQKHGvVym7yqEWOnAe9Ux87IFmnk0nzqoh9OzgwI9Bxaursi4Qry2QSaNYCbi6e0vNkqnU+9E3pwp5Lqf1m8mUyL7tafmhwKFU3C6xMau7L6Fmax8+rAPXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916491; c=relaxed/simple;
	bh=Hf9QT2CpkR+fWTZ4NdMZUXNLVTxILeINZ59WR0p7c1s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=e4w6P0Ur304wwoznmAR3Sjl4HJiBViMWHsLegcSu1FR+1iOXBMbMOvqWsbox6oobnNZ7PlmxdQYHt3NSvxu3QcFTNNMtlPQZZ7VVDs7SsjLzG/mtJXUGRciLJtZQoTP0ZzZvDHmMQDi9tR8DaS/ztpu/Pi2TOdDuEtE5ljKpWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaJBM3/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaJBM3/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136D91F000FF;
	Tue, 13 Oct 2026 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916490;
	bh=Hf9QT2CpkR+fWTZ4NdMZUXNLVTxILeINZ59WR0p7c1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XaJBM3/iwP/sF7KTvyQfTT78siMH3DWusH0P0OooQx/7F2+1Gw7+IHmMbzY/QbZSv
	 r9f2aOrEGE02XW0NFubVVHiw9DwsbJF3Aqt9HJkD8/IwUQNNMVpqqJJrn+lMv7UlZX
	 bE/o0zY0QNAYTr2IY9mEipN2UJ9+x+m7MvpVW0Jvsg3ipl/TRPT8QJAuEqvG7dhjsc
	 5Hzi6s8VhE0J+ZdVd/OrP/FZ0HDcInhiY4BwlWxCBogTjTpj5KEL79He72wTeEHgKr
	 6k9PwqIEfjehRFqAmsV4veNhuqfud0fdEQDudYSTiJaKUV6bZyfvIwxHDI8wAzt9N3
	 6J2wl7kvQGUOw==
Message-ID: <sashiko-outbox-170336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/10] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-4-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:34:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D3

