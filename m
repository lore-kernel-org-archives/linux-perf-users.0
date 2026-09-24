Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183C27144B
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270359; cv=none; b=oH7++BRYzrfYftEWQRdkyEb3n2ZU0a3m7uYZL6mY+/2uV6aWhs5zr06yovczTYWefIqHqaHOM1N6RElDdWtKIwvQ01NtHc4MUN8C4ydjBRmIY05aZbicq57Vas4rpJkcXtes/PmldKEK/67pOawNA9VtOFdFX6j+ld5t+t+x5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270359; c=relaxed/simple;
	bh=b7rNHhiiPwhP6bE4cfFxoh9oA9+xcZ8OXuhGHAAn9Es=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qwk7Dx5p25DqdhuM6R23ae9pfMVgXDZ9y2CI2fW68SxcU2eI6+7wX6el60kbjCerCKNaUFGORRPA1BIWVb9YrnwCoClBLX944R9eIuBVtgLyrNktUenozp6qu4nWi9CWdNhJr9mjN4GSbCXdE2vGc6uHUWR6ShTvRQnAO/4z2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLSxoYjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLSxoYjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E5C1F000FF;
	Thu, 24 Sep 2026 17:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270358;
	bh=b7rNHhiiPwhP6bE4cfFxoh9oA9+xcZ8OXuhGHAAn9Es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eLSxoYjkomIHji+mTZpJmDIeUt8SAZbM6QHZph2RT6m0nCtC0strhZww1szlcWfGG
	 rFC8bXbjxjKCpN0TNqGhKItfLxE0+3zCND3DEJnbsrkUrzyeOi1x++mwJEP5nsRDKJ
	 Qv9qSJXQf4c5/EJ83Vdt2zZn5YgtVABELmsQR/5qBi/inYUfltMQuHsfaMd9faf2f5
	 f1vEhz3+ruou1Ym9DhRODmtz5p3Sbk53zcOTmzfp4LLm19WoZeTFlUDS68+o0UJhfS
	 KAxFCbleCyWcfkBiuiTD2+1xkx0kCxeNX1gDH0zKCpRiCQHYqTPYne5lY7Fe+V90yx
	 emi5bYoxKrY6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/26] perf vendor events intel: Fix lunarlake umask
 encoding.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-24-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:19:17 +0000
Message-Id: <20260924171918.49E5C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Fix UMaskExt that was wrongly encoded when the UMask was 0.
>=20
> Fixes: 23878069de30 ("perf vendor events: Update/add Lunarlake events/met=
rics")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D23

