Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826662;
	b=LrwMlhu8vpDRYFWk7dx+rKJrxP8bZf5wDVXuElo0zOXu672SlRYT3daS1pldEoQ+1hhO
	 l4ZgjKZjCmiN/BbFpPgwu88Id76Yr3qOfUk/d+Z0iHDeEdKqWColJ/59bfb+uF4DxI/Jr
	 IuXMTVJnvcEnOgAj+UkiwqrxaBSJsLqBWSKgWxWoru9YaYV2NTaiPjhs7Yk409gT2qCCS
	 IBIS/UWGFhGEka4WQWgAdFcnc/FQjLtNdrnojzdKU1BWiDOPc8S7hE6nLI4p3UdJaI+j0
	 vQL4UR99EBmA7/tYBT4GniDC5v1phWZBXjAKGfdABfSPut8ikU4auFrlPkvd56zm4VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cUow0bhG1hjs0xXY6jjGHiqRQmmx1cl0qimtUo7vipw=;
	b=UH2RJ4a/QzbtmLqHnNr9B0jJ4P5ysFNxl9cofK+dn8/UwAM8lTKu88bgf6cUJkbA1Npn
	 Wt9asSX7ZCxNJPySXpgUym6d7t+n/OsdFQTB/xFCELEoAOWTEnjSEZxBCE4wlSy/mlof+
	 vC3clRy59t30m1lC0yJImMOSjAu2XvI2QlLA5qUHN+bOZTe+AmP5vwffD7r+VNxNbOPUF
	 bplY/g6tIxldQD/zM9QaB/XnrG1x7eTY8r+DIV0ZN9hTCl2Ll3S6zizNeHAdgPUubtXe/
	 0sz2AHEqdtoIwuipeV0WRTdljhYEfDeUNUKUF11sAINdth+hYM1jrhiZIxwknv8e07Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kncr2UuW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452216070F27
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kncr2UuW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C687F1F00919;
	Wed,  4 Nov 2026 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826662;
	bh=cUow0bhG1hjs0xXY6jjGHiqRQmmx1cl0qimtUo7vipw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kncr2UuWQhkjFqTgY6JA0YwPoN3Fzqpa81GDp5qE3/od1+G4OK9XWqfhM14xDCPCt
	 hs78tM78ZyXJxwqfo63tebhCgy1PAtUGg3fYqUWJHdkU3idM3K4Mrj4b3BYNeMR5Qq
	 JwBf0gNG3sMb+qY6VT7AoRWPFFiZ/VVpuz94AetFxX4DXQYKYYBTDxCPX9IsgGs/aZ
	 jsJWWJfTUdBboaruXESp6aHV4l0XBRhjwCgnt4B3/slip9YzpUL1aLFApbm/HESL9L
	 s1JhFlf77jX4pcQz5B5cUZVjA2LUjEDbgRnDfjKFglg7LQWmSgSjo2jgNJ4fEL/khB
	 ZVRtnkxFufIsA==
Message-ID: <sashiko-outbox-198052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/19] perf vdso: Fix unlocked __dsos__add() and race
 in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-8-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:11:01 +0000
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
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D7

