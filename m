Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604381;
	b=u3mpC/oFOGBsoYcx6H7vXq25bm1+dYw8I0/Bev4oJtcHBJVDH0izyJHwU1QegByCmFpl
	 xzQy4PXUblKvjRZCfdtK6mpxhAwsCRXCJEEegsJmI6+1IRka0Mr+NbtC3wOu/+vbWvGFR
	 Un/TQZe+Juwe+KkkrsUxtyLDUUSVVneaencN/6vOXe/IVdB3QpUVtosBeee3i+MFOG0bL
	 GM9QO6atfKAKhDpGVUejRBXTW7+6GjF4CFqnTZ7P5KgNhE5Shy+sySzWJKfqC67YPsNNO
	 jtjEzn0n94I/HUvYpsZEWvBH/lC8rGX1FQZ14d2md2WPlUzrhrdrJO/cjiT4lnUs+dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604381;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7FRN86Z1txinDX9M3FkprixpyfNMz7qdHZy/7yWjbHk=;
	b=ZoAwQODC5mTpkYiGN9VxaLOpF/y2nlJbh0PFE2daFuxkOJ6ZqtfOS4V0BspmpfvhlM7P
	 Vxarg6FlAAZwutRq7UqWdSryA6oU4oDGZvGRevmkeLKuNYtOh5m9lTIJjbI431RBfy2Mb
	 GpVnSphO9vRxJAhKW5EoczC8YR/8fftk+Ci5TykX0ofOvxUJu0EH/JdCcBL3k0banns/i
	 Ti9WwBeC3pFZyX5ZLLsa3OWWdXLKHWCimkLPs5nhQLFohFDx5GOMXE5xv0kBvTsIn0tZ9
	 R4Lroq7OMV9xn+xzdC1fjT0l0LtS9EGdcZrilQghJH4QR7Z78RCqY0TnZVGvUg76zEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5aOqDep;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4C606A339
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5aOqDep
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2F91F000C4;
	Fri, 13 Nov 2026 21:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604380;
	bh=7FRN86Z1txinDX9M3FkprixpyfNMz7qdHZy/7yWjbHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5aOqDepAk+/b+b6hjq1/N7qIDok5+aDrtNajvjd6UW4MfkqUrQZOHIDtLRKj1Z4K
	 aknYnUpLSzxERw+qVo50/FnEFv7CfWXIkwL2TN66Erq1DHsVanzfewzgQ+luiAl1aG
	 ol7id9kLjjXh36rzPUSYqbo/x2rCxxhhjiMZMTZ/ZzXyUiJ114Mc2v0P8jcoE2Oro0
	 R+L6rRv5DLgyjt9oCv9NhvAIqCSayKDAcwOVlO3Noo3/BWvbgy0VhXJ7aigBs2LpbQ
	 sPLWVUHsbt7tb0McWPU+qydF26dV/dMD6wSEKzP3P0kzhJp4Fjxrcf3d2IlPvjnnIL
	 innWGQtA77kJQ==
Message-ID: <sashiko-outbox-213694@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] perf jevents: Sort BigCString entries
 alphabetically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-3-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:12:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently BigCString partitions non-metric event strings before metric
> and metricgroup strings, and orders deduplicated entries within each
> partition by first-seen insertion order (insert_point). Because strings
> shared across multiple CPU models stay at their earliest insertion
> position while model-unique strings are appended later, later models are
> already fragmented across big_c_string, and identically prefixed event
> and metric definitions from different models are scattered far apart.
>=20
> Drop insert_number/insert_point so non-folded BigCString entries are
> still partitioned with event strings before metric strings, and sorted
> lexicographically by their raw UTF-8 byte sequence (which starts with
> the NUL-terminated event or metric name) within each partition. Grouping
> identically prefixed event names, event encodings, descriptions, and
> metric expressions adjacent to one another prepares big_c_string for
> block-indexed string compression (splitting big_c_string into
> independently compressed ~8 KiB blocks decompressed on demand by block
> index and intra-block byte offset), shrinking the compressed blocks by
> ~20-23%.
>=20
> Regenerate empty-pmu-events.c for the updated string offsets.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D2

