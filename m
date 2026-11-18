Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041805;
	b=IZujCrrqesN3xGqqB1Tky4S4PLLvJPwGM5tNxjbcZeeSy/NuQWxBunNC/PWD0WkqYSTn
	 D5p9rufZ1CTkFkjWcuvt3zZY2A0P8d8ueVrdUqm2EOPTXFAFZ9rvaD0XchNLntiT7rztW
	 w8h7vsiiOpylKiLTrhT/48LaeKeRi8UlldKZQe+xeDHFa7hRMQOtUZk8YDgCMYMpVW8p1
	 6P5gI4Hf6c6XtpyA9R0QtSJh/ATSJ7JGzXwrYoKY3eH5Xnxs7HQ3tkre2Uv3dwFkVD6JT
	 zbgdjySZe2nYLDuwO5W3UjxAl2wC9+fIfAVnM+eaBEcGnyeXLzV/k1KnFamtxxB4GVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RoWtE0BtC6tuYKcEg6kqS+6eBlLPJL0nmBXvbLX+Ijo=;
	b=aKks/l7GbNxqvc8EB0XAz5OUpBRsSylHoEJVOWkbaHTROiWlw5RdRl4SfmOtmCEfQ9IC
	 /vUY5bx2MOJdaQ15hVQB95MWz7lwiaSDMguYG9COZ/kEy46P6KEpQd4GXfY5Wxqvsoydf
	 lm19x9XZJwIO6G1BauPVTFcj1JbiXeiIwUg7n3D+Jz4LR3fK6TY+69/k+tJXOz6Cn/lzT
	 mM6GNlVuaToJWIm9ziHasysy+WGOLFhaft4lSci7j3M3/TPc2V/O5BbtYnw+LEzA8l8GC
	 E9PcWtbguTVImrgEtIOCsvvgPZESKSyBW5VdpsrVOTKV1aarn0kcPiWw/rmF2vNufkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpJAJnOC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1E606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpJAJnOC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F631F000C4;
	Wed, 18 Nov 2026 22:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041805;
	bh=RoWtE0BtC6tuYKcEg6kqS+6eBlLPJL0nmBXvbLX+Ijo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LpJAJnOCl0SqC5zQkKS3rIlgwt4KjdWGQiQ/Layp0iCtHPTeAqp7Y+M4DIy4J355y
	 czpdnvvpAFFAcDplLodqG7yBVkaOsWmZfl1mmsw5A3+F3S9tkrARCM3J8sjaGFweQd
	 kX8UY4MO99Bud2RmTAKdLrPuB7oQMCLidAy/u9ZlEmunwhgh7wCBxd+E7ut+QcXu+K
	 UoDSklflOQ3FIs0cer6jsIHNQ59X8Ge9tvF2gpHNpOIh8IyfiUtWz3u08jXQAH+/Qf
	 bHID4OX/L/84Cg3OPYizzQdtVtjXRoV9MvimQF/dBS4ftSIAw+ofti4sITkdOLKphZ
	 gMiGTGr1mHvHw==
Message-ID: <sashiko-outbox-222116@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/13] perf annotate-data: Count flexible array
 accesses for the whole struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-7-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:43:24 +0000
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
> The per-member percentage sums the histogram entries in the member's
> own [offset, offset + size) range.  A flexible array member is resolved
> past the end of its struct, so the struct row only covered its declared
> size and showed 0.00% while the member row showed 100.00% and the
> header said N samples.
>=20
> Take a member's extent as the end of its furthest child as well, so the
> struct counts what was resolved past it.  Union members all start at
> offset 0, so a plain union keeps its size; a member that is itself a
> struct with a flexible array extends the union too.  The TUI browser
> accounts the members the same way, use the extent there as well.
>=20
> Extend tests/shell/data_type_flex_array.sh to check that the accesses
> count for the struct in the percent, samples and period columns.
>=20
> Fixes: aaca646915a1bb53 ("perf annotate-data: Adjust type offset for flex=
-array")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D6

