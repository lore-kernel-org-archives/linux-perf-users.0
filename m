Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773357;
	b=Zkh5AvfgKO7K1hBqQF8NwXAKwPg135HhfYLszZi5wIcUU/kyqz2QCsNyjgWwoj80kips
	 wR0rlhKKf74RT6HzWijOb/lqyT2j96FlrFVAZo4bKLvMIt161CugXtbo45pKqcvVcEGgS
	 th7hbmUT8xccNGEY0z8O6GtyhM7RxYXZ4vZP8e1hh3DcxUnRkrg5mWmbKcXLpxvwD99Oc
	 euMovVU5QNjSjnh1k/1Qr56fvlc2jwSLDoF3B1/9+02P17pTUsrR6RVUw1pCh8Y0oyhB9
	 9105tbOrHrv3yK2nVd3WUTm/QIxBR6LsCskbBLIlkv3V9+i7l/k8D8vUzYFMINOUVgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773357;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fc9MEdfjx3XKEuwmfNE+vzyQ0rCAyDCCJrUKD6sJh84=;
	b=Vn2nU1oU0xkfNgXJoM+h3MGcA0riRn4DdfdypAm/D+o1g83gt28mjahPmFsx7PomiPey
	 D/O7eudLZH6srTXKuqaLXcDLF/EBLL25Fr8xCEFtwYJ0eDsdBNpWbB0VTvC1j+TG177Zb
	 2fhO6Q3Ook8dqzDgzkQVTUIItWkmiwvQJwPeuu1/EyoXxiVCqm4jd3sP6tZJFE4YSVEiY
	 r7bAqPnFZrI9dNHr2ve3RG7PPXVdz4eCZr3qc3A24GrejBQmm67KKtotmu0bIe1XhEmt/
	 sEAFqn3UiH71SToB3FNVLrdJULeG8kPbPCZ4aM9Di9IJxqld3IHvB/KU8wJbzfu7sMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S43rI7Fg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A3606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S43rI7Fg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A4D1F000C1;
	Wed,  4 Nov 2026 06:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793773356;
	bh=Fc9MEdfjx3XKEuwmfNE+vzyQ0rCAyDCCJrUKD6sJh84=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=S43rI7FgfR5DxGLgZRanHxL2vPJOOVs2E7U5Gzf8zraw8a2EURGX2NodV1LXqnQnk
	 lmbBR+OV1MoDe7OYDzdKVCafTP0FuHr+BtEQlOAD56RbQZUTl14f/HZIZ4AaLAJ8x5
	 AztIfTPXLFAs9Qvi2iddgs3EX3VKOTuwpd6oUqiTqC1crguCryazVN3C7w5RPlMJDT
	 bybJNbpMF9g/cI8tNZC5Z7cCqDfkG7yoH9WGeE82GMicH/qjCnR7+h9j5WqTWJBava
	 MTTX71sPXNhIFOxYR62POlJNbWo1pvcm761jbrTgDDUoeQZCuROnr593Wkay3NXKUZ
	 5QSqvg7CRsk9g==
Message-ID: <sashiko-outbox-196754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 33/41] perf pmu: Probe event group size limits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-34-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-34-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:22:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend perf_pmu__probe() with check_group_active() and
> probe_group_limits() to determine the maximum number of events in a
> group that are counted simultaneously, without multiplexing
> (max_group_size). After each event is added to the group, the group is
> enabled and checked to be counting by comparing time_running with
> time_enabled.
>=20
> The number of events in a group accepted by perf_event_open() isn't
> reported as it doesn't reflect what can be counted: disabled events are
> accepted so that groups may be scheduled by hand and many PMUs accept
> groups of enabled events that can never be scheduled.
>=20
> On core PMUs, where cycles and instructions may use dedicated fixed
> counters, also probe a group of general-purpose (GP) hardware events to
> determine max_gp_group_size.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D33

