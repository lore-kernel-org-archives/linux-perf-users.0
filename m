Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812842;
	b=TbDAaQsf5X5LNH2k5yBZTEuUyUwgXM74JvHB+uWC83YWcXIiHWbEYtSF88tFa5ff8SJM
	 CFyKxSdA80M/NGL7QIk0zvSNndn2x5/0LhVXGMmSpu5uIU9G+qjHwdjgoCLx5iEdxyOkx
	 LiTnHJOAeTrVHvX4DAq+fHXTASCoeAgkAE1twrFwG5PcKe2a+EMfBpemPFlG8Lj7xOK4U
	 28keVcH7OrguItc6I0bOfOMUUj+oohEgZQMEE/+7aCxym3s7fpGn3wYEjYPsj6uvMNRfI
	 5dFvP53LXOPO0JjWeiBvxF00RVYXuRB2RXbzul43I5XOvFvj/Z6AIadbhT7PCvxI3Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Jqhy9dkXX0CrZnb8SGbK/4HJf/fQqLrV39kMGmaQcL0=;
	b=Ogc9ULWx8dbhN5s1It0djF4aJTDB0/WzvWez2E52Lilb0YED1OXe32XfZOchBd73JPtg
	 2xlYQqj6nOe1fb6u7xoh8PwQN7BgfG8Gss/GjF/HcaxnBjE3Yt6MKJ5GNr7Sfs/uso7vx
	 FUdqc3I7yT1bZ3jueZFz+ylfZ1BAZBM4YlKLAZWN7LxM1rmgScMrjyXl1MjFemaTVToQM
	 jCrZ1IrSVnpKKfYJmArNVPVUUeqNnQOOrj2/JpdWg/saMbA0GNzRlC6Xf//aL5gRLjp2v
	 XkEq8sAeCV5s/LH2nctWNVTBgSyJx33W163FK3rJjMzvYJJvQNFLnY4MaJ/bGi0/nWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gYY/O9I5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6C606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYY/O9I5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A902A1F000C4;
	Mon, 16 Nov 2026 07:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812841;
	bh=Jqhy9dkXX0CrZnb8SGbK/4HJf/fQqLrV39kMGmaQcL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYY/O9I5McTDFdt+heLRK/rBWaQaHEFAFrMcWQvAWPRd8siyphMV/2DP/SOCRP7Sf
	 bXvAbJMIPakzYE6eM9aCmvFcqDcNIzsVAj2rXWerhuPN6Q95ZNHK48gHygsCI2C3mb
	 qCZ7M0hTSOGDhNPV+v8+CDwqZBEKm+PnQBB3z4YMpCjnyRqEx6J2wI4zQVIQigko3p
	 j9H7QFTGLSb+fpPmhGdHuD7zlG65TQZVI8iSOy0pXiLaImMJJg9Ph1yDTumkbQ+oKK
	 LJ+eIEeL0n3qL0V7hPeHSnADo0JM06ZdLSgmrnlh1OGSHLkA8wHRYUIsDXCkfXYRCK
	 GBZmA+wkObesg==
Message-ID: <sashiko-outbox-216383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] perf jevents: Add block-indexed string packing
 and --compress=zlib
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-6-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:07:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Compressing big_c_string (~6.9 MiB on x86) as a single monolithic stream
> would force perf to allocate and decompress megabytes of unused CPU
> models' strings on startup just to look up a single event or metric,
> whereas compressing each short string individually suffers from poor
> compression ratios and per-string framing overhead.
>=20
> Introduce "block-indexed string compression" via a --compress=3D<formats>
> option to jevents.py (defaulting to 'none'):
> - Sorted, non-folded BigCString byte records are packed sequentially
>   into ~8 KiB blocks without splitting any multi-field event or metric
>   record across a block boundary (with suffix-folded strings inheriting
>   their parent record's block and intra-block offset plus suffix delta).
> - Each block is compressed independently into big_c_string_blob[],
>   indexed by big_c_string_block_offsets[] and big_c_string_raw_lens[],
>   while sharing a common dictionary across blocks so ~8 KiB blocks
> [ ... ]
> --compress=3Dzlib shrinks pmu-events-string.o from ~6.90 MB to ~716 KB
> (~9.6x reduction) while only decompressing touched 8 KiB blocks on
> demand.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D5

