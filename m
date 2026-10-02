Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8F481223
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932473; cv=none; b=ZUiKhq8mHMyBZjaCUZzyiX/egF7PQxTjFN1uoJ7wmOLZ/ei+x/yT73k01DkdaBDxZskgv+w064gjHdVEYZ2k5MbneDkf5+xBqvJG5uRUB24eB9YZgFVz8Y9x53MKgisalObd10CNGG1t48XDFPDLRO9dghCsbbP17qALUPi88II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932473; c=relaxed/simple;
	bh=syyU9MtoMOivozB7h3pdVI5AHbUUpQh2WkgOl9HH3M0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qIjBUXy03w6XmZkE8JcgNwkpQHiLVLEg+fUiSwj8uLPiOVz3os0Uwy/kZuZIFhkrVRq2qBLzrtHVQp0E3nMR3AskUcJnqU0yAdslvd3Ioom8Wg6DNxAcFQoxIgvMYKDSyL8PhVKbrRLAAsXhYaYITufHhtAyHnTWtAfuDTC7UD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEQRKn+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEQRKn+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3089A1F00893;
	Fri,  2 Oct 2026 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932471;
	bh=/clz67bd0c5V3Oaf/X+WBficueWesjSLY6Whot6qUJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GEQRKn+1ejI6gUBeBA2BA9dUVxcCa51GZqoEHZriWGD50gLgHZm5EyaXbZJumePgu
	 G/ZVxyD7mVx4GO2Wa2KM3uyEW4X1PfRkGPEccAjhFKq3a2XfeQ/jRtPzbpRwo1e3rb
	 YyJ+B1shCsvPMLWYskXB1sKMCh0SjYVFAJtM9qTAALEnpFmFQjqAsjhmPzYGZHYYLE
	 bSBUN6n9M73/ANfO6w10/RPD27GzhLI1Sqe+OPS8sjsz6qMPrcteNctgjpMMGK+7Qv
	 6QSc/mPE76U+jFeA5uIUTvxCwU+xgCP+CDFuvxibVyFKa0IdpL4X5z4JRoWTBhdjgW
	 NYsyObHCzkIoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: Fix aggregation of cgroup events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002054832.64980-1-namhyung@kernel.org>
References: <20261002054832.64980-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:30 +0000
Message-Id: <20261002091431.3089A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> I got a report that perf stat with BPF and cgroup is broken with
> aggregation like per-socket or node.  On my machine, running the
> following command shows the problem.
>=20
>   $ sudo perf stat -a --bpf-counters --per-socket -e cycles \
>     --for-each-cgroup /user.slice,/system.slice  sleep 1
>=20
>    Performance counter stats for 'system wide':
>=20
>   S0       12      <not counted>      cpu_atom/cycles/                 us=
er.slice
>   S0       16      <not counted>      cpu_core/cycles/                 us=
er.slice
>   S0       12      <not counted>      cpu_atom/cycles/                 sy=
stem.slice
>   S0       16      <not counted>      cpu_core/cycles/                 sy=
stem.slice
>=20
>          1.002798147 seconds time elapsed
> [ ... ]
>=20
>          1.003231856 seconds time elapsed
>=20
> Reported-by: Chun-Tse Shao <ctshao@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002054832.6498=
0-1-namhyung@kernel.org?part=3D1

