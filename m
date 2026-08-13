Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F6F483BD4
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634972; cv=none; b=KnPEUvxQVANcsQQmbbZwO7tT9wi0fbaLMDXNXjbEmH8Kxcx0x3y2CXdvCpKccGdaDm65TCbZrc1+qwq2KsVm5o35en5UV6ptbWwtwyK1knPXX2qrfshIpSpDcphAbLp6KgSHSRIVFpisQFAIyD7ThMw4vBVjsipqANyWBXnovyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634972; c=relaxed/simple;
	bh=5kniw2rThqAG/r6AHYKFqfNA2vkE9GzSwGvKJus34MU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h+d43rffbltxaGBo1PT6Up7/g+qjr1B1x1F5uLte4/V6/hBJ9M6mGjPlXK6Z19+xMTFjW3ntZmUDnf0QCmtvhfWSG+G6CSvZelepmps9U2w5mx0S6uPz58a//ZWfXVyb/EjByi46VBaSWW8l0N2hKDIuMmmoWwtxR2Fk+omiNrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTTJ4nvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTTJ4nvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8CD1F000E9;
	Thu, 13 Aug 2026 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634971;
	bh=iujboVqRSCyDnSV7Ig2NojPCRp9UOsslSc2QmXRhPGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTTJ4nvBWm8FMqyjWNpT7Qcdzw/YtOQvK1hUDLZX7MBWMyZMrQ4z7X0uMNQx+GBFN
	 aYHZFXs/a3WSLgQExqgUq/NMNjx+HBGt4EsZN4PfmYggh/FnBhXSzDl6Hj8sMbtLpT
	 CYQK6yBztDrM5cF2QkDoQPTgi3LKSP086VwzXPcVpp6K4iTf645TYfFPDNkSbX/d+3
	 05lXgvJw1mJiv6w3OgUP9xqjteuoR2k+u42BcfFsBTPyt06wO51Gfl2vpe9XI8BwA6
	 SW35LD+orMZuxdFzYa8J6o8J9fwD9X/mzsUXoiumfng6DoQ+9hE3BbN05m72ZhEu1B
	 LZ7sJ8wqUd3gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf dso: Guard against cache underflow on short
 reads in dso_cache__memcpy()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813151148.23169-5-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
 <20260813151148.23169-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:29:30 +0000
Message-Id: <20260813152930.DA8CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> dso_cache__memcpy() computes cache_offset =3D offset - cache->offset,
> then cache_size =3D min(cache->size - cache_offset, size).  The RB tree
> lookup in __dso_cache__find() matches using the full
> DSO__DATA_CACHE_SIZE window, but cache->size reflects the actual pread
> return value from dso_cache__populate().
>=20
> A short pread (e.g. near end-of-file) makes cache->size smaller than
> DSO__DATA_CACHE_SIZE.  If a subsequent access targets an offset past
> cache->offset + cache->size but within the DSO__DATA_CACHE_SIZE
> window, the cache entry is found but cache_offset exceeds cache->size.
> Since both are u64, the subtraction cache->size - cache_offset wraps
> to a large value, min() selects the caller's size, and memcpy reads
> out of bounds.
>=20
> Return 0 for an offset past the valid cached data.  For a regular
> file a short pread only happens at end-of-file, so 0 is what a direct
> pread() at that offset would return: cached_io() stops its read loop
> as on EOF.  Re-reading from the backing file would not help =E2=80=94 a
> second pread at the same offset returns the same short count.
>=20
> Fixes: 366df72657e0 ("perf dso: Refactor dso_cache__read()")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813151148.2316=
9-1-acme@kernel.org?part=3D4

