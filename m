Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794750413;
	b=e1T0g0hNUsPLLCY++lQSJJ/u8LCZ1yTsc3R8LWcdSyKJNGkK5+3z68LiWsqppLZD4XQR
	 /WUkTa8V+/Cfl/bUqBxK/NQXPz8DtUNkz+AaARYfdZVwwVfNyFfLN56cNJ/14nO1LyNgo
	 CS/92gC0EhWz4JMYD5RbHaXctwNG7ixY/lE4IHLyAPZ6lClKlUtyxvunQ/u7MZiULNowq
	 y6TqYGIOvIQCqfCkH61uZxrppQUhUntIq67fxWbYOcABKUuOOEq+wQ5ZvGDBYQekISUd2
	 4ioLOiMBHsEG0XzM+sMjD8OxJMhLEcelWzgng/5vJLc+4tMu4bqR9+e/LEzgJH8GkdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794750413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HrmERiRhoUGgaXqecMFLrnZYHaaWVLq1l1MJtgH3Jzg=;
	b=a+BDltrSryetBpI35d748+g9gFDYEwiC7YYDkFkUtL+z6+x2GexyhPhgM5UmWgb9x7dM
	 RvTb7i0AdOcfThxTpLSJ1NSrDB4L39nB8rTLWjYfrfSa+v/s2EgLW5OovXtuoXF7lD325
	 8jTWehb8akHzYGeb7QFN35IzWbhGbEvo7eod1y2Lbiae1KNK+gUop3ZaPI0TSAN/Cy1lB
	 wce2WJiChhogyYimPOlgiWKkatheYVel6DJURjC2Ku2JWHURGQq5+yC5AL3P3VK4D4BTc
	 4KQ3HK0slS8Rj8H2BNYfDu6B1t8ReGUv3tQxYfG/tOcBhQ/QeXb/YZlJ8XqjoIp4vig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUpQQI8l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F619606A31D
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUpQQI8l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059611F000C4;
	Sun, 15 Nov 2026 13:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794750413;
	bh=HrmERiRhoUGgaXqecMFLrnZYHaaWVLq1l1MJtgH3Jzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUpQQI8lRNVL9a0wElZMM5hqTlq8XBUNPCC0lken/7cCTeBNbhrAs6sV5vCulB011
	 KZVScpRy60zzBKveFQvXoLNnmIQ1OP9j+J84IUxzAHdYr7PVoPZacY3039RdexABd6
	 nesHfYS4RlYGiB+IpRbsjHo6j5Pu9DG9JVZArPAveFiiJ/RxBVdQmbBXkdBVsK08yx
	 QVgIrDapGSgyTBR/HvEW1OLTV5fDki1xaSxwj2+P2gDEnjEDpDhjI35G01/iFPV+S0
	 HRrfY/SHKcH7R7Lfr4QwOMsuPRv3jmXW0N26zAJ7lmHs+241vbdEzS498FK+rq68aU
	 mXZTPazuJlWWQ==
Message-ID: <sashiko-outbox-215545@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf synthetic-events: Split oversized thread maps
 into records
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115-perf_fix_large_threads-v1-1-69c9b86b9ae5@arm.com>
References: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
 <20261115-perf_fix_large_threads-v1-1-69c9b86b9ae5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 13:46:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> PERF_RECORD_THREAD_MAP has a 16-bit header.size field. With 16 bytes of
> fixed fields and 24 bytes per entry, a record can hold at most 2,729
> threads within the 65,535-byte size limit.
>=20
> For larger maps, header.size overflows and no longer describes the
> entries counted by nr, so readers reject the record.
>=20
> Split larger maps into records that fit the size field. Set
> PERF_RECORD_MISC_THREAD_MAP_MORE in header.misc when another record
> follows, and clear it in the final record. Preserve entry order and the
> existing encoding for maps that fit in one record, including empty maps.
>=20
> Stop synthesis if allocation or the event callback fails.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-perf_fix_l=
arge_threads-v1-0-69c9b86b9ae5@arm.com?part=3D1

