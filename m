Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255805;
	b=BBcXSkiTRIUdqAi6Hgj+Cn4ZSZ8u+S0na2MkaCoYg5KBQ5aUbQwxxDlL+G9NbeDQtBzA
	 Pvd0SHgqvcB5jsU8Tvsr8TjmF+jDToe8FxOxc33NSwCCTTuVbonohY7ipHLHkQDmOkeTG
	 d7PY0SE0mVRaVq3h2NdZPIEQk16hRcF9/R8RSmwQ4Vq9cEnqP7shokaYdpa1CQHwZctOB
	 xBfe9snUPSJbb47vwiTiPqBy0EJRDsvOidhLQnOQVGJHoqYlBSyFGIKPnqyF0dgeLfCp1
	 H74ywk1qs91pJFM+Qt8IHf76CGsI48bYSvfLQ9Ff/+0VrFXXUGMaq3G82BE0EgyGHng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yZ71TSP2QSZlnHs03lXj5r/IKQwEZ1TvuVNz7yxmPdI=;
	b=a1QymtmUrm3mF6+nkJ+wMQ9Kb5nqPNPra+wpsFcM8wLO2ry2tMLTEXKvVew7KrjjuLMT
	 r6W4nsku6xmd9C7gWII3MWWzdKtsfODgRjkFM5uSjfeJez0RZkkfzHypctl1R9INRvrBR
	 +SL+XffLdyyJh/gmm0Kh+aKtbO71WTZ0rLd6D7xUybQmzk8goFMS95YOKRzmImMsbwTmX
	 txpE3yO/I8IED6fACmHtf/9mfwpEQxg8kv4/slB+BiHeH7zzf1O9Nk4GjtcQpBaJi2npX
	 XJoNAo7u3I4XhJQwF4ylPIL7wTSNqTqW8JYBl4FJZi6O6KdD2vZdhcL0lKmfhCr69lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtMXuyOw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969E606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtMXuyOw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8271F0089F;
	Mon,  9 Nov 2026 20:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794255804;
	bh=yZ71TSP2QSZlnHs03lXj5r/IKQwEZ1TvuVNz7yxmPdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WtMXuyOwUbOHHbiC8YaKAM6Cs9ybMPTyCKuzzzPlTrgeR6U3x4rTWp7eb0eiLEo3u
	 d+u1rQLk12AQZhUQLDSLeKwrvdE3giaK6ola0IUFydfHMrzHhUTJab+SiZRTIOjKO3
	 6C6zzerMCDcfwqXp/sNW4Y++DtApolfw5fBAKoVimAVCpkuKlGvMA3m1aLSu3qSbJD
	 Xyc47VcOBFHv6tMk6DKA55Is49RJAVgld0kR5iDRtDuDQlXC9EoIYlt+9cO2FKV+0Y
	 SxqH2q2dGSfuiOIlASzmjQqhSwqa6gpmAhztQWsHvBkZE7jlvGL24vsknIxtZcZCiq
	 8EQkiSqR6+Hsg==
Message-ID: <sashiko-outbox-205576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/20] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-6-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:23:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D5

