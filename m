Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DC331ED6
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682475; cv=none; b=XfgR8zmR/8k/XyjKDiHce1kLA0Lk5P20+tQLAOVpP/zfJ0xlvgGcOmx3y1TLroWdN+XT2mAZ1PG7P9l3HNA9Er1M/Pc+eCepHa1J8jN0f0AH6bAWQoYZn/X58pBgdnOwpeZq7tL8DIuYaKn1S/wUpSL81ti++Yyk0XoscA7Mkm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682475; c=relaxed/simple;
	bh=rjRX7vfurqA4C4bjJOc/QAi+chFCdacw1kp+ewcmKn4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t0abDByWv1iOWZEdCCGK9yML7Vf9vhgCtS5YuGAKhj29DIrshfzV7aR3DcA7wwvopT9QTmNjK7aG4l/p/5dOQWEqjsdhtbXMEZPDtCziuxeIvB7UuNHnjeKOOwrx1CKVd7SwKqVkWgft22GOhl4dBpxDp0JVS207IBbtUPVwaUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1D0zkfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1D0zkfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA961F000E9;
	Sun,  2 Aug 2026 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785682474;
	bh=73CXkGXeoHZp7ET/qc9cictJjk8BZA2JQR3o2UMmG00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W1D0zkfGh+QZKX/QgNF9V2gbKR78mT/D76b3BA9AKDsciMY+y0uVhtivv2zVeiF8q
	 oSk/JsI9/2euCXPBi/Ya8j8KXAGAMawoT4MJgffU8cIfIZW+LiFrW7fURAt14XZL+Q
	 vVYjZclRe8h5KRkRhrOP0K4yjvTggLj7zXCG1uBO/8HZMf2Li+PN+FjFfsB5vHS7/+
	 LEnVulYUZ+L1wR43zPIjAscYCe6Kem2cABcOtVT05fJfjZrCY/iaV3cM+diDC43kyf
	 YROjfHk1r2VbuS8LVp+UfoFMsMlcyJCrnasIUFBYpveNCM15h7DBHNCk5zsci6l2Zm
	 qEabPZlhSybnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf dso: Guard against cache underflow on short
 reads in dso_cache__memcpy()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260802142022.154219-5-acme@kernel.org>
References: <20260802142022.154219-1-acme@kernel.org>
 <20260802142022.154219-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 14:54:33 +0000
Message-Id: <20260802145434.3AA961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Returning 0 from `dso_cache__memcpy()` causes a permanent EOF rath=
er than triggering a cache miss and re-read as intended, breaking reads fro=
m dynamically growing files.

Pre-existing issues:
- [High] The RB-tree traversal in `__dso_cache__find()` is performed lockle=
ssly, creating a data race with concurrent cache insertions.
--

--- Patch [4]: [PATCH 4/5] perf dso: Guard against cache underflow on short=
 reads in dso_cache__memcpy() ---
commit 06837abfd5cca9da5670ee54ec02e3164860900c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Guard against cache underflow on short reads in dso_cache__memcpy=
()

dso_cache__memcpy() computes cache_size based on cache->size, but a short
pread can leave cache->size smaller than the RB tree lookup window. This
causes a subtraction wrap-around and an out-of-bounds memcpy when accessed
past the cached size. This patch attempts to fix it by returning 0 (cache
miss) when the offset falls outside the valid cached range so the caller
re-reads from the backing file.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 207f8744aac97..a0de56c93592a 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1002,7 +1002,17 @@ static ssize_t dso_cache__memcpy(struct dso_cache =
*cache, u64 offset, u8 *data,
>  				 u64 size, bool out)
>  {
>  	u64 cache_offset =3D offset - cache->offset;
> -	u64 cache_size   =3D min(cache->size - cache_offset, size);
> +	u64 cache_size;
> +
> +	/*
> +	 * The RB tree matches using DSO__DATA_CACHE_SIZE, but a short
> +	 * pread may leave cache->size smaller.  Treat an offset past
> +	 * the valid data as a cache miss so the caller re-reads.
> +	 */
> +	if (cache_offset >=3D cache->size)
> +		return 0;

[Severity: High]
Does returning 0 here actually trigger a re-read?

Looking at cached_io() which calls this function, it seems to treat a 0 ret=
urn
value strictly as an EOF condition:

cached_io() {
    ...
    ret =3D dso_cache__memcpy(cache, offset, data, size, out);
    if (!ret)
        break;
    ...
}

If the file has grown and we hit this condition, won't this cause cached_io=
()
to terminate the loop with a silent EOF instead of reading the new data from
the backing file?

> +
> +	cache_size =3D min(cache->size - cache_offset, size);
> =20
>  	if (out)
>  		memcpy(data, cache->data + cache_offset, cache_size);

[Severity: High]
This is a pre-existing issue, but I noticed a potential data race when look=
ing
at the RB-tree lookups in this file.

In __dso_cache__find(), the RB-tree traversal is performed locklessly:

    while (*p !=3D NULL) {
        ...
        cache =3D rb_entry(parent, struct dso_cache, rb_node);
        ...
        if (offset < cache->offset)
            p =3D &(*p)->rb_left;
        else if (offset >=3D end)
            p =3D &(*p)->rb_right;
    }

However, dso_cache__insert() modifies the RB-tree while correctly holding
the dso__lock(dso) mutex:

    mutex_lock(dso__lock(dso));
    ...
    rb_link_node(&new->rb_node, parent, p);
    rb_insert_color(&new->rb_node, root);

If a lockless reader in __dso_cache__find() traverses the tree concurrently
with a cache miss that triggers dso_cache__insert(), could the reader obser=
ve
inconsistent tree pointers during the rb_insert_color() rotations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802142022.1542=
19-1-acme@kernel.org?part=3D4
