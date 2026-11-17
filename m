Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941764;
	b=CQ7PTn8EKznEzsbpWNEuBf9JCbtqzwP1sNjUFqFsnJy280SBCvoLQx06OL5d4T7hxc39
	 m8LIuqkoKggyieDYGGKG72xyOKcLmrmiTWvdaVJmuFIGFYCjh8eUPHtKRrg5T4JWQkjzQ
	 vFeh8tP+JnkmgElyP89YxpLwmuZ/nVwO7U3GK1i6nSLIzIOIwJoV/VZEH/LeK7Y+9sZag
	 ZcfhyU0tEtI+XAK4UPxTnvn+vy8LqiF+YQVp9EkPrTd53Uk7vFIo+eRCl4nP9i39sUbS3
	 GJ4jeF8czbqbRFzy0iy/A+0nFh6x8hEdoQ3VLzxq/sk1EAtFbSkgH7e0RbeH9z4mEow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941764;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JbjgJpSS39nj6kSP3z1tpP5BZR8QcFg5yEZl6Np1cPI=;
	b=A3mGZAkQA6RT9dhtHMXXzvj3VOnlPwRU43NOMJcW3/4EHzQBTWzfcrUaRmzZNAqpUM9V
	 PoMpW6KApPnpzMZt622LdqcefJswQq8+4hs0WQd5uCkjowR3s7eaeyijIAgp6kA1IfaKi
	 4VDPQktxS9s3wKe4w97f5ZJoIOFRBlJMFYgd6ccBXGq0UMs77WyQofNW74j/7WTsw2E+f
	 W/BcCPhbTieE3nd3nXnDX74oR9eAXuRZg4LXKx1T8Bct4J9VI/fqxRMeDR/S9Stet+39x
	 gOieLbMdCt8ZbUW1LeMaHRjNEbN6OH5iIE3FBEezuCehJLTV0wrs7G6CRXgQExkt34Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6t6n4iy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF423606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6t6n4iy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648BB1F000C5;
	Tue, 17 Nov 2026 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941764;
	bh=JbjgJpSS39nj6kSP3z1tpP5BZR8QcFg5yEZl6Np1cPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I6t6n4iyTI7v9EyMyqkEmVjIrQZ1/IP8regCkx0PQPo3m7LfRcDIGgBcJ4Tuq894Y
	 yrbzc+BQrxfxJXqqY+q4sTwUyrW84R8uy5lDXWw2zjOCUJVyu+Rd2NWQwT4tVRpefF
	 nLziU4dYck0LVcB5/4No9c//kHoX5UHWd7QZkzvOHnYHINHZpDZX2gTOqiWGAUZvYn
	 iCi+WKhbTWf5rzSV0VIK8i8nTPZskGeo8FhLHF3ISa1Vty5/6vbUQAIcBoZ7tuz8p6
	 Jc/6SWhy7ljfXgb6rLm7N4a9c9czlvD5uBVlxsMNH8aZ2IZ4ZqMFQXYTdfzR6uGepo
	 GcYW6fzkFXKMQ==
Message-ID: <sashiko-outbox-219409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/23] perf vdso: Fix unlocked __dsos__add() and
 race in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-8-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:56:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
> holding machine->dsos.lock, and machine__findnew_vdso() and
> __machine__findnew_compat() initialized machine->vdso_info and created
> temporary VDSO files without synchronization. Acquire
> machine->dsos.lock in write mode across machine->vdso_info
> initialization, duplicate checking via __dsos__find(), temporary file
> creation, dso__set_long_name(), and __dsos__add().
>=20
> Fixes: f649ed80f3ca ("perf dsos: Tidy reference counting and locking")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D7

