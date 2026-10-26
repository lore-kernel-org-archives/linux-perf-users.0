Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052012;
	b=193U74xcNGCjtdNHmxYCuW+/t5/CK2wRJQ6JP2pUbwQUaTA0qt2Y6+5/s7bL9TgBLiMM
	 r9VxoJmD/rn1aXWfGDxnOIKPk4L9djqSeZBGT5zQ9F8ccFPv7bVyxkBHksugU0Fr1ydfk
	 MTpPTIaxUzWq6asPqOU1g0xMV8MWDxffAFzpLEkSQwXGuT48EYn+zYIqGk/HrpgObIVof
	 Kj8VZzh9XCFTeKDBDWkxxdJEF1LO8u7fuV2cmaOZaZBCR9sL/qs2MQZ46kAUQIJvRatVY
	 KiuY0OI3TI3Je5J2gwE4rRXfqE0iE0odmP+GVuPUMUmUgsBcRHQg5pRT8jShKJUgQIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052012;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fUufDr2sgtvmCy2Zem+au44nLpjaIiOa+hGXsybmNiw=;
	b=FYbgCGegPodJSWHtWeOZeYie2hGJnzrX7sl4ptp+1bHXFY1cChb3wZRidXzm30mX4ZZt
	 iIyzXSSAhEbBHVMO120gQBYFpfpMM2GV4d7uvF7ivdnS19Mbogd7L9HzYEeKp3zOrdRGl
	 y/0QLYznzqWZlyPaJ0QLimiaHjbiMUrSH6nKfQ0lmKXGj+o2lTtncQasLApM+ua7/31ss
	 OzCVr7nVU4N32NbrWicm812J918fn20+t6B7SHa6gHtfKmv/5D3dmPmNRM1th+65Gro66
	 ysbYhXtlYOjLpI8HpN7Vx6MCX6EV+mcs8BMohk6Ap/gZm0Q08wuYGW0/FRw73uAK9Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcosaV6R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FED606A31D
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcosaV6R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB461F01825;
	Mon, 26 Oct 2026 22:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052011;
	bh=fUufDr2sgtvmCy2Zem+au44nLpjaIiOa+hGXsybmNiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RcosaV6RB2zzPX0BK/Kme0Xcgv6SZSOa9S0IGjiDFNQc7HuksDffdg2Q0bMoc8JdB
	 qbtPAs+1qa4NXDlobGRjuBuau9qJW57ZrA9aUy74skyIyQBLa/tk/Y1yv8+xVLWaAJ
	 hjYo1wKCf1r3qvDUslngvtWXlg7NC7Y5FDRaPFMybjSjvNSvVXNHL6Z8dDS8GjXfTi
	 awl2eAve4BBwsb+TXILOyB/HL4ttZGyFTu3cOu23LZtOixBlXj6/3Z0rrbo8F7hOjS
	 +Hry21aEXUGz4sGRljDNgeEZCKMfqykzOk4jxH4X3Yc0jad4CJHVDiVrQIbXIWhk33
	 3NgxgOP7NGAgA==
Message-ID: <sashiko-outbox-185774@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/10] uaccess: Refuse and warn on more user
 accesses without an mm
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-10-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-10-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 22:00:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Several generic user access paths don't go through the copy helpers
> that check for a NULL current->mm. Add the uaccess_without_mm() check to
> them as well, so that they warn and fail without attempting the access:
>=20
>  - __scoped_user_access_begin(), covering scoped_user_*_access() and
>    get_user_inline()/put_user_inline() on all architectures, including
>    when masked user access is used.
>  - strnlen_user().
>  - check_zeroed_user().
>  - The iov_iter user copy routines that call into architecture-specific
>    helpers: copy_to_user_iter_mc() (copy_mc_to_user()),
>    copy_from_user_iter_nocache() (copy_from_user_inatomic_nontemporal()),
>    copy_from_user_iter_flushcache() (copy_from_user_flushcache()) and
>    zero_to_user_iter() (clear_user()).
>=20
> Only check for a NULL mm here rather than using uaccess_should_fail(),
> so as not to start injecting failures in these paths.
>=20
> Paths implemented entirely by architectures, e.g. get_user(),
> put_user(), clear_user(), and direct users of user_access_begin() or
> masked_user_access_begin(), are still not covered.
>=20
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D9

