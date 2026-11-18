Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041790;
	b=IuhDpHw7TzqdHfvbhnFtcdXgfl0IZZD7f8k5Pa6LG2Lk2YCt96qW1zecdsUhtq54gYQz
	 SseKBv7+sm2+8Gr1cn618jZFdhq1Uo16Os1IpDLaeId+tljnFBvuQLPnPKRP/IyHTjIa8
	 p6qP8NWZYj+d0iCoGZIaHM7OzUO258y3ca8Rv1gK5gRrdzxPDeuMEEQO/xwW1sCFxcqPs
	 JWBfB/ln/ZHK1gAzkj/HsVIE0jsQFHrzagCvAxyftJq8CfOHd6oCnT5mQGspj5la5WD00
	 6ceVp9L9GXuR/e/ms5Nh6ASu1MJ5Ob6jNIHmLT86RCCqQ9UzpdxR5D+Sr8UXVq82f8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041790;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xVUe0R9jDNAS5ltbZWF2CkJbXRoH+TzTrCLLJ908jl0=;
	b=VDlCnLL4axAbMWilMwC0URaUtu4BmyVPYT3uKH9upEE/JvLjOq8HZy/XqT7KjyuULEZl
	 1PKu+CsfvrebTPAifbp2Qo0tXvrrXunsn3DhV2ubVBw/SAXKAT759Ki8ycxDTWHoQUmua
	 cqcXiI3gdywDnQOGAmOGhvi88v/s/+K2C7+1qf5BrBDcwd7UW/a/4tI2fejWACzBBFPjX
	 vc5xIKccSaccPELUZnIHoEI1tU4SZgDwg8Zzuy+us2hIwzQIoKUtyfAPTTmK80IYyzwVN
	 6yCirFvwP9SZ+6qSeIykjzPaQxy5L4waHPmUrFaRTt7C6/lKAg8mP8hUierpoeJsrnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2tVZMxm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3794606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2tVZMxm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989321F000C4;
	Wed, 18 Nov 2026 22:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041789;
	bh=xVUe0R9jDNAS5ltbZWF2CkJbXRoH+TzTrCLLJ908jl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i2tVZMxmfQRmHeeRzkVfkS3Vz470yirwxvmWvv+DN7hLRumiuZBkeP3gGfD7BvQjd
	 cQukY5OZ8aI9EyhzK9PscVush1ALi/z0ilzzl1QxA1XkOhkSGJMqJX/EXAxpZwo8b6
	 CS9ipeYeJ59r4whVTa6JRIhahy/jibtDw3B5h0rSxB3+ZRkba2KXLGh7jBFzDDu6iH
	 JGYYMeQUONdeuRlBUzocAjMZM1iCacs8QDWlnk+HXCrmQVOEEMqd05nSNs1kTrurV0
	 m4FMMWQWq0LiZbxekJcw7EztfSsfiOsaguCux0T9MZsvpzKghcAvJe9E5RPlncloNk
	 J/xtU3pAMAGnw==
Message-ID: <sashiko-outbox-222115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/13] perf test: Drop samples without an IP in the
 dlfilter test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-13-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:43:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a user-only event skids
> into kernel mode, so that kernel register state is not exposed to user
> space: commit 166f10836a653dfa ("perf/core: Fix kernel register info
> leak via hardware skid").
>=20
> The test records without an event modifier, which is user-only only when
> perf falls back to cycles:u for an unprivileged user, which is why root
> runs never saw it.  The dlfilter keeps those ip 0 samples, and the check
> that nothing but test_loop survives then trips on their lines: the comm
> column reads "perf".  Drop them, as everything except test_loop must be
> filtered out.
>=20
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D12

