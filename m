Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792968332;
	b=K/HGWz13IfDMoGsPGQwQBulUJGf4MDvWej4dKlVR7OWW6MMk68eIC7xFoUEZGt1HUVCI
	 fgXbDwNcxc/VrxyUShe5p1k5G66Sw1C4t82U1hlesUsjCkBaMUq6QS4BImgvAPg79bqeV
	 UyPWAAgt+fVxeHu/xbHCk6Y1NP9QeGog8XvY/JaigSMwGp/4+40MrMGljNB8nXgFmJdrb
	 NXxwhNoU75KlsuSRWaDcd55VG3og4y5sOMPMgKdsf+yhM5GU6bd3ldiumq/B6f4kmQiPv
	 MoNw4bzY7AZi8skuAwpbS/U4YdceBfnBBAI20r5SscIZdOqs8BHXD94bEye51i6EB4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=81+zj+nax038y8hlaP7nrR+FQw43DFfLYtnOfSha0eo=;
	b=JJknAq+OzLu4GeIjlb+Hrzxj5des/MYCxczkwnW8oFULFVW6WUawTn54HIX7Q1JgscJB
	 +mvwaeQrj63VCDyOh5Z7wfHrATQhK8iuYnjSl1YocfBqoiFN4s8h4f4kLlpYCWUcrKXQL
	 Q6YtPL7XPoljih9vRIPh8f9eqNWsPdYzNaz/MKg8YZyu+m6RJY3KSKvCyCjOOU4m3uc8X
	 fG7iO70zDY2NFMoVfej2XyxPj+NDuvtIfK2PNqNcd0wS9knqzHSUsHT/Q4Xeo30Aw7MyG
	 rjpZxTxnmACJNDGuIYHCcgA14uAVnw+X5xemVK3+oKtolsNFyp3I/JeotxPcGLLdaPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhmQ0V8R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0B606A31F
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhmQ0V8R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8521A1F01825;
	Sun, 25 Oct 2026 22:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968331;
	bh=81+zj+nax038y8hlaP7nrR+FQw43DFfLYtnOfSha0eo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VhmQ0V8RldVjB8OEgKDfQeiemQ5XlitoWgjC+FH7b6mIw+u4wXcyTjc5LGEROhZyh
	 XLdwbtsQidftiX/pSlriyRIpvaJV6Gfs61ELP5rwW6mlF4FUANSmS3mwszl9mfSqR0
	 E/o0HIzIopQpbmCOOuzQrKkYgNSgkTiNa9bM9E1CXpoFpLfin0VgVFmVsYRCipSXpl
	 WIj/801vW1IlaJ3KmZICpaa8r1j3HrFr7f2KzwL1LiaxA6lMJWCjr0WSzgkhHCKaBk
	 2wfz/t4AzNf5wnC6bDVLMGZ+jXVIaocIbUEAcEsCUP1Fk3pHBunQzrY/aYAn6T2sFu
	 PlEEjT6/cegWw==
Message-ID: <sashiko-outbox-184500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] perf session: Fix minimum event size for
 PERF_RECORD_CALLCHAIN_DEFERRED
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025220349.1244499-1-irogers@google.com>
References: <20261025220349.1244499-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:45:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> struct perf_record_callchain_deferred contains header, cookie, and nr
> (24 bytes), but perf_event__min_size[PERF_RECORD_CALLCHAIN_DEFERRED]
> only checked for header + one u64 (16 bytes). Use
> sizeof(struct perf_record_callchain_deferred).
>=20
> Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025220349.1244=
499-1-irogers@google.com?part=3D1

