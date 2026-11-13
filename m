Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591794;
	b=yvbaBeMKO1nnXfBTtL+H8TaYyyEo1TVkXfN/drXehW38c6SnZE6J4kf3ZkaRt5KAe8xE
	 p1/NccQV1LGz86f6265e3SueZUzF7Dvj+nJFpNDaZK0tn6CglkounCeiKra5168ucIjSV
	 WJ+yDcqSkmBUmPiTUVf0bsjHD7NT8YA50Cb+02wVYZW3SKSXR3/QN+2L4l7cDimVNCfsw
	 1pHpRDnw1gpLvEitKralMlFlyRvHY447B266q3pIkx/l4Yrbcl7WLGcOQu/BdV2UjSDxM
	 UdnLfyS8V7dMmnoVFlmKftoYxox+p3L+zunKmJ9N0PnEeS/P0UIuV7qNxlQMQhHno1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591794;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nKN2MngexaJPQdtQNVJDFJ/VySAkHzPyIpOiTiU7nxA=;
	b=sUW+rocDPywez5aKbHPWZvA85ekQj58BhHCoDYeQWYuv3MB9CUgpf7SnrGF6vw6PSqPY
	 cOh0Cd+cYAEWAyFD1GdzoRINw8Rf6rVhJ05DqXM/mFwcyCqjTR4z5pDJ7UTsVBK3nUtgo
	 5hyb33HckN7nHARebD3l+AH+p4fjJOuHuARh8dzTdJk/+FQj/wp0ueQJ/37xw88VnxnpW
	 G5IKHo0IF9WYx6fObGUkqOcFb6pb/Y46P16E3oORK6w6M5PGFFXiXUgfn18bIOjBp7XWa
	 PjEUw1+56UbtFiadVkjpsGe454pYGpRLXzm05Hkha33Ep3Z/k5K/uIXiAKRwAbbg4Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRT6i2qf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C0606B369
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRT6i2qf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F481F000C4;
	Fri, 13 Nov 2026 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591794;
	bh=nKN2MngexaJPQdtQNVJDFJ/VySAkHzPyIpOiTiU7nxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MRT6i2qf4iVXQgVtO8q4+FtRoYTlc8+ZyuUlhDpnU9gmaHD4xttaHiAy0vxZtwYQS
	 lBvynsBoH1VoIAj5dY1RTF6O5RPME7IuRiZLZnFnqlNPpuU+HbJOgFt6+2zg8uIV/s
	 9CgjaUaoOX/htPUg5cXCIRqjDN5NrkADn/UtDauk3inDxfIjfuOxHWdRZhliFpl3xb
	 Be77B1W8xOJ79/sRzbZYW7/84GDJe8UJDbiXKpFpxmayGHtXXOcCsv8fdlySmdBWIn
	 B86bpPkXQDfVjF1v9NdPYKoK0LGdCi7n8w/JVWRrmwuJNaXIESJ+5ereHyyiu3/2SL
	 3irdjVW+dPquw==
Message-ID: <sashiko-outbox-213357@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/23] perf maps: Optimize tail insertion and
 small-append sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-17-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:43:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> User-space map insertions (from /proc/pid/maps synthesis, runtime
> PERF_RECORD_MMAP2, and jitdump) and BPF ksymbol registrations all flow
> through maps__fixup_overlap_and_insert() -> first_ending_after().
> Currently first_ending_after() has a fast-path check for the first map
> (maps_by_address[0]), but no fast-path check for the last map
> (maps_by_address[high]). Because /proc/pid/maps entries are synthesized
> in ascending address order, every synthesized mapping starts at or after
> maps_by_address[high]'s end, yet currently executes the full O(log N)
> binary search loop. Add a tail check in first_ending_after() so
> non-overlapping ascending insertions complete in O(1).
>=20
> Additionally, track the sorted prefix lengths (nr_maps_by_address_sorted
> and nr_maps_by_name_sorted) in struct maps:
> - In __maps__sort_by_address() and maps__sort_by_name(), when the
>   unsorted tail is small (k <=3D 8) or the total map count is small
> [ ... ]
>   After (-6.9% ascending, -98.7% append):
>     Average ascending insert + lookup: 58.970 usec (+- 0.609 usec)
>     Average append + lookup: 96.670 usec (+- 1.353 usec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D16

