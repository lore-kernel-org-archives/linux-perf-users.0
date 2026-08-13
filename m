Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C62EF66B
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582703; cv=none; b=JkSTEusN5vcI7WiD/Wx0IPIBL/QRGUrX9TOJHD55O07jfRtrqk9/87jroQxSj7r/HBkH85LrwfgK2rVq/SJTxcEKEQ/IpaSoVi/GxqxB62CQWFj0AtU1J8b+bKefggLkSpUoPC2VzJypr4eFbkpTCKokG2J25CtzQuh9jlzDb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582703; c=relaxed/simple;
	bh=a/XENXDsa5yMbQR23pHX4/nV2YIKUb1eow/nJftwyro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dANvp3OuhMyjBZWRo2eawVQ7ku0T2grZ7728WKWz69aoRZsYZv6ZM5rUElx9L1P16bg9xgXeS5rACutMv1RwX3KmIyNkhKGA30hB+q/w+HSxix7QKdtR86Fkx+flxXdoGAhbA5cIAeAfpJXuLwbIxdla2K0f8A/lZl8XS4cRum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcDW7cWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcDW7cWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3E11F00A3A;
	Thu, 13 Aug 2026 00:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582702;
	bh=DiD1O2ZustmD/Ttb20ItM6gKfgYkLuxD8oCUDMz6qng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BcDW7cWaBIHHYLNje0y0vrwhvQDMiKl787yqnA9GuEio9Oka0giQoKdhkMd3qdiSl
	 Di0SVdq1xId1qDcf/Fmccq7mJUBX7GHKVuxlkMWm8xvaUZNljScZnDc+rSinM4SAMK
	 LvA3EYuYIhjpGCVm7YzEOYmwbq49WAtbiimhGxNsjUmrWrm3gGdiOuu59R3+1Zk44p
	 HMqXT4hWn+9eqcvdhFjnSWazN2Sv1tVTd9/iRWF3UJz2nYrOHHsRm5lwUGjRaVowXx
	 67qRI0SBzZpgA0XeabSdeX6N68UJIX3672hGguWHyN8lWr5V+481crx14QdNcts/DJ
	 j7N0beKo7r9fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf dso: Guard against cache underflow on short
 reads in dso_cache__memcpy()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813004927.16738-5-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
 <20260813004927.16738-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 00:58:21 +0000
Message-Id: <20260813005822.5F3E11F00A3A@smtp.kernel.org>
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
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813004927.1673=
8-1-acme@kernel.org?part=3D4

