Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486812;
	b=fOP22NE3Mqzcqt+PKj8+RrvufuEAvcbtnbnFo6xQPoJ+xArA8q6t3wZvs7kjWEsEoTLy
	 unbKoa4Abh+AXyFS7iLgxlXIW+gWfQ8fdzdyn8cOSvw7gY+2AgfT0xQJe/J5924SxMrT5
	 rNbaYXJZIQN82tc6zphJ38sjqM3GAO7xubM9+lQVMhymAbRhxL9/UwPBSEQTcxNL70sNb
	 6JEjxtIYhxyfD3xdjApAZmdl/HbAk9NP5S9BFOycjXpUuGvJJHXoaZpWuyoHxr5YFYzMX
	 z9jhjLlGTmtKGi1qEGttZH9wPffQRYQeqZkytaluxmUEZGc5o5RavkxUjmR7WWnXIxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486812;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=axu+zG+jc0HWfAhxo8Bq9QVWhrmgyND+OCuACE8C12I=;
	b=z/UlIzcXdk3S+nxvboWgQQCih0V3UC6JR2FOqD6W+lltjoXXpORZ1tNSi2BLe3jdZG9i
	 7ABk2APg/FjYvXhHv5emEFIIvVNvZcziX+DGbOIPZpy2vh/gpttmCZWOkEyfSZzWAF1hi
	 Yjyg5p1KyADA5HvkfuGq67Zw+U14l0Admvt9QqTt3NBDM3h8NuQv0up3l9cEmqwf6aJkI
	 kaa+6urqicmBKSIPBYSXtXfj9nH0nfXB2QQEyT47uuWD+PImDNvvAqpd5V99JSoGiIMuT
	 keplhWYJJ6e0pfY0QG3Mn7T0fFgiV4TaFNK0LjsmWUXFvNW98edqaVn5auOfrX2Mccg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIQSNYt4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCA606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIQSNYt4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0E21F00A06;
	Thu, 12 Nov 2026 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486811;
	bh=axu+zG+jc0HWfAhxo8Bq9QVWhrmgyND+OCuACE8C12I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iIQSNYt4KScSw8Nx8pBG257+r3ZjauwagWtQUY+tXfNvLbADioMMGV1jRs6gp5HgQ
	 kRMXcLg1hc1YNn2uHPkYdP57sIgMPufEr55TyqKy/uz3AdPlSmNVzaE+Amm+4qk6HQ
	 X+SCc86XpoBPL/DFPNPYIwdDPnjlFTLfRY5oiSYauxpjmD11AaSiOqCGh8qyfS+p9c
	 ipc2wvtXXMom2K0PWybOXcbsdZPqEHf6GEV4SEYANRMQ/bY3HPnS+7SKr2HVrfnuu7
	 ulLpz9LBpF4hoH9ta85EZpMVS6SsqSHnOIOnmcVkFm08XzHYjvJumJJqgOc6DIYIqy
	 0flPPleNjqUeQ==
Message-ID: <sashiko-outbox-211092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] MIPS: CM: add CM3 performance counter GCR
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112-i6500-cm3-pmu-v2-2-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
 <20261112-i6500-cm3-pmu-v2-2-cd2569571819@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 12:33:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The CM3 implements two programmable 32-bit performance counters and a
> 32-bit cycle counter, controlled through registers in the GCR global
> debug block (GCR_DB_PC_*, offset 0x6100..0x61a8 from GCR_BASE).
>=20
> Add GCR_DB_ACCESSOR_{RO,RW} helpers for the debug block and define the
> control, overflow status, event select, cycle counter, qualifier and
> counter registers along with their fields, as described in the I6500
> register reference (MD01189).
>=20
> Each accessor comes in two flavours, as the CPC ones do: db_<reg> for
> the local cluster and redir_db_<reg> for the debug block of another
> cluster through the redirect block. GCR_Cx_OTHER.BLOCK value 2 selects
> the debug block in the GCR, where the existing _BLOCK_USER name only
> describes its GIC meaning; add CM_GCR_Cx_OTHER_BLOCK_DEBUG for it.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-i6500-cm3-=
pmu-v2-0-cd2569571819@mobileye.com?part=3D2

