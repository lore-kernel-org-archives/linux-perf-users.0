Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F3255F2C
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306532; cv=none; b=f2WB6TL7Z8DGin+cNVXPJhTiH9KrETA5Oaer3yK/c8dHWkiImv3Yr0w2KvvdJ9C5/rdWe8NZmMZfv0BE474VKiofT0iB7Fl/6nrbZnA8P/ySey/1aQk0mnk3a4Pt3wpzrNmkhCJlzSekdPJ/bY9CuixTFKYegwpaJvuFFyTHrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306532; c=relaxed/simple;
	bh=a5e4M1b9eqpuOIP0iroXn7EUk2FM0x7OTP0zREexxFE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Vwmi22iCQeEi9f5JbimUG57sfe2szQcHur5+Bqo+dcFLRvxf+SQr6lBydREAqo439/pIgQ7cW7JK0yFBNv2Cq1go0B876S8rLTLscUCNBpJImgMnfh2AXV7FfIQJoBnHEniaFTkyBdpRSW1onTYEy95y55o1LnmVvR1PifGCEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkUl7UZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkUl7UZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC681F000C4;
	Sun, 18 Oct 2026 06:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792306530;
	bh=n/0FbNWkxBzruYe/rrNIh9CceRiiSyYlyQDtd4HZqNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DkUl7UZuYF37OOM5LSjch+4Rfye2wEJBWF9XQrtG67c/ZOSYimxzIyA1klYWjTo88
	 gjLTPFQr4H9AnjlJTMA+UKDfQm/WBBWkyIe2+4enaK3igbqYWmFUGkv+Mtej8ctG0g
	 b22sSYhOv7Yet2tMjLcp2GsO1VNzrqgbXw9oQd4iJQmgGfhxNjVk7DHTQh0CIkkJW/
	 Gm5nQWecljbnyb1p6l8pdcReTL23mYXfzns1FchSchX3yw4Mo+hGxZ57+lIK5MOEn1
	 IAUxf//P6Jpfc65/UfYgZzGwLU86fNtXt6EaEJaqzSbE83RSviLyOvWEFErFS1YVDh
	 dvqK+7wwal0lw==
Message-ID: <sashiko-outbox-176000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf pmu-events: Fix jevents.py type annotations for
 mypy 2.x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lalit Maganti" <lalitmaganti@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018065345.918176-1-lalitmaganti@gmail.com>
References: <20261018065345.918176-1-lalitmaganti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 06:55:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Since the build runs mypy whenever it is installed, the perf build fails
> with mypy 2.4 on 7 errors in jevents.py, e.g.:
>=20
>   pmu-events/jevents.py:542: error: Item "None" of "str | None" has no
>   attribute "replace"  [union-attr]
>   pmu-events/jevents.py:563: error: Item "None" of "BigCString | None"
>   has no attribute "offsets"  [union-attr]
>=20
> Both come from wrong annotations rather than from code that can see
> None:
>  - unit_to_pmu() is annotated as returning Optional[str] but always
>    returns a string, so JsonEvent.pmu is typed as optional where it is
>    used as a str.
>  - _bcs is set to None before the BigCString class is defined and only
>    assigned an instance after it, so mypy types it as BigCString | None.
>=20
> Correct the return type and declare _bcs with its type instead of the
> None placeholder. The generated pmu-events.c and pmu-events-string.c
> are unchanged, and mypy 1.9 still passes.
>=20
> Fixes: b3e9c396d0ac ("perf build: Make mypy build test opt-out (NO_MYPY=
=3D1)")
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018065345.9181=
76-1-lalitmaganti@gmail.com?part=3D1

