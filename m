Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021877;
	b=KH1rTzT6uRimSPxLoLuvWGYh9YUdHwSIxVRNB0bdXwM6wTLe88yLQbu/7wHJ3xgElzEJ
	 iQWseSCXxPFaIguxpbQ+phWai8qJDw98MZwp3AP/DmthPkKssrYZi5IuC/JuLJgvt1Uxp
	 w9hXQa245DMU04wZTyDU1B2v3S3w0cD0I0rzMV0Fq9lUbOunHWb0pGd6QpEnDTwIlsRzc
	 5kt0vZomt+sDAztj9dd1RrxHV52cH5jiwZ/FcCZfw7K0gF5HUrnN9mHDDAS557EjFVHfP
	 G5pxGqZY7/wkcnwkf7D+Mlg7x5ESSneyHJlTCivbNPiP6jPAmGMRN8A2Ho48liYq98A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021877;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SWMcDxE644OgpuQayvdJeRwqdo6HNfIqc8FisL7O+Bk=;
	b=jk6JaQWxXdNkJnqIIjENdUSE+PfnQrIOiSTF29SSGe7kkp9CfVQV1w/COWUEaMQnUzcR
	 YcF1RI0UNheP9Pkxeb3LwuGhcIOKElRYZTHBWj6zOxvehP+0TtyXAweEYQiVPKeqMK2LQ
	 /JP+fQiEdDVuLm3x8lH4xdZH26WnBigLAd+wuIf5ySHdd6hzwvq2eXCCI7hQsGujfrC6J
	 CDJ5twVRvnTqUNoLQ0smvcG7ElCI5QSDeL69fzu66Ax2VRJGX//JNGGDXUl2TtBXwWeIq
	 cICa8tOT5pHRRvRzrIMba5TV8lmB4+MiijcCHKcyQvahdbaLiKAfW4611nBrh+LFSCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXzEFkLN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F78606A32C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXzEFkLN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BC91F000C6;
	Wed, 18 Nov 2026 17:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021877;
	bh=SWMcDxE644OgpuQayvdJeRwqdo6HNfIqc8FisL7O+Bk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HXzEFkLNGFzr+MtaGdKmhQQNcf5WsxZL8BqaYSA2BtbcV7zt0HNQLpbId2JjyTOi2
	 D6KDT2m6yDBvKO6afwrodQaJ9egmEQ8z936g1Sb10HJzwvxvUwUY5kKXTJXiAF2ld2
	 wlBP4HAgFBQvp/ZJJ6fRTLu2PP4YhAEIHJdmzbXd4axyjHAOerhJ+PgNmW7LPuMVRG
	 AtNpw2nE6p74cKfXZYh3DkV6Pf60HGdkFDhyB4nBaZTBc/ODplssg5hE6mSSiJ7EX8
	 x43PvUvqKpMez8qBaEIsmPWPrRFVCq99TT1XgQ2l96XHlF4O1REXnalV94MpITNU7a
	 IBKv0LBh7ubpg==
Message-ID: <sashiko-outbox-221594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/34] perf cs-etm: Don't read past the end of the map
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-6-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-6-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 17:11:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf cs-etm: __cs_etm__mem_access() uses map bounds before
  map__load()
- [Low] perf cs-etm: Fixes trailer cites c9a01a11dfe6 instead of
  20d9c478b01a
--

commit 12640a74a59159fbba9b39a02acb1bd86e89bf8a
Author: James Clark <james.clark@linaro.org>

> perf cs-etm: Don't read past the end of the map
>
> OpenCSD caches instruction memory one page size at a time. Perf reads
> this requested size from the file on disk without limiting it to the end
> of the map, so the page can contain ELF metadata from the file that
> wasn't mapped. If a subsequent read for a different .so file falls into
> this range, then it won't be decoded properly.
>
> Fix it by clamping the read size to the end of the map. Now when OpenCSD
> requests an address outside of that range, Perf will load the next .so
> file rather than OpenCSD using the mis-cached data.
>
> Fixes: c9a01a11dfe6 ("perf tools: Add support for decoding CoreSight trac=
e data")
> Signed-off-by: James Clark <james.clark@linaro.org>

[Severity: Low]
Commit c9a01a11dfe6 ("perf tools: Add support for decoding CoreSight trace
data") only added packet buffering and trace element printing in
cs-etm-decoder.c.  The unclamped dso__data_read_offset() call in
cs_etm__mem_access() was introduced in commit 20d9c478b01a ("pert tools:
Add queue management functionality"), so should the Fixes tag reference
that commit instead?

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 3fce3c3579438..fb4582dc378e1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1213,6 +1213,12 @@ static u32 __cs_etm__mem_access(struct cs_etm_queu=
e *etmq,
> =20
>  	offset =3D map__map_ip(al.map, address);
> =20
> +	/*
> +	 * Clamp to the map size to avoid putting unmapped ELF file data from
> +	 * the .so into OpenCSD's cache as map data.
> +	 */
> +	size =3D min_t(u64, size, map__end(al.map) - address);
> +
>  	map__load(al.map);
> =20
>  	len =3D dso__data_read_offset(dso, maps__machine(thread__maps(thread)),

[Severity: Medium]
Can map__end(al.map) - address underflow or evaluate against stale map
bounds when decoding kernel or module traces?

When symbol_conf.lazy_load_kernel_maps is false (the default in perf
script and perf report), thread__find_map() calls map__load(al->map) after
maps__find(), which shrinks vmlinux_map in place to the .text section
(e.g., via remap_kernel_cb()) and splits other executable sections into
separate maps without re-looking up al->map.  If address was in one of
those split sections above the new map__end(al.map), map__end(al.map) -
address underflows u64 (or evaluates to 0 at the boundary, causing
dso__data_read_offset() to return 0 and fail decoding).

Conversely, when symbol_conf.lazy_load_kernel_maps is true (such as in
perf inject --itrace), thread__find_map() skips map__load(), so offset and
map__end(al.map) here are computed from the unloaded map before
map__load(al.map) updates map bounds, pgoff, and mapping_type.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D6
