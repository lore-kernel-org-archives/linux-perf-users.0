Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD852CCF2
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766828; cv=none; b=WYcXsYsxVsShnGkddaYs548KI3ccjb9qxbEH3fuAs0sbxc8T9seZg8F7VXL3+h7TeLCN1knW5kcRyBVnyyoET3wXzInziqPD+0gQFlXvzhRHBqBgl/QJq5QUscF1tmDiU8Dni4EMvJq5MeX4vCz5eZMdmX5g93/JyOlald7jkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766828; c=relaxed/simple;
	bh=piLflDFKUCoNukIhCzUgG+tvHuGX5m2gPhBG0Fu8HK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aBWilYyIINyXFPo6iSyoDi5AEZD7wZIoKdJSQceKDA72feunGruIOLijnA8tsWJVp3XdpW5fImjZP8+dAbNw1q/v8hxZgL5QxBJwY3glNmuAYVx0fxB5/PzahmmkV6VK7nRgqVWGH63AJFNAJWFqNb3Z7cXq2iX3BdSooQEiBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7bHzt+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7bHzt+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064BD1F000FF;
	Fri, 18 Sep 2026 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766827;
	bh=n1IHA0VREv+SoBbOId2BJAIIBtc6z25v95yBRwTRwVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X7bHzt+lv95umoNBH5AWaUfxQRPNVolvn3WJxXY1Th6rc7xdaD7mdd+8bYJ+2MKFA
	 9wkq0Tx+d4jK7eQpVvnp6Xm5AF7Z4FGAdqPYGLVsU323ApBBxDMr57NvgF1LUOIJ1H
	 0da2DUEO4n7L0Lv+NCAWMoCG8PYcpWtqe+VjzPoItsrxaZlT8OCjBXTDAEx5Tdvj1X
	 2FMvuR6xfeVWfq5pWaQa6/AFeXSqMMyfMgm4grUGuWS0YZrV6Kiz8/7K1E1yOLcr0+
	 LwmchLHRHqI5Rr4ZhMO8jMKld6A2Gtdm6iOvXSILkLfokgZhECUREV5lf76MHMuD63
	 /3VislER+Y1+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/18] perf trace: Drop targets that died before they
 were filtered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-11-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:27:06 +0000
Message-Id: <20260918212707.064BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> sched_process_exit() takes a task out of pids_to_trace and pids_filtered
> as it dies, which keeps the maps holding live tasks rather than growing
> for the length of the session. It only finds a task there if userspace
> put it there first, and userspace writes a pid some time after reading
> it:
>=20
>  - trace__set_filter_pids() writes the thread map and the --filter-pids
>    list before the programs are attached, so for those there is nothing
>    watching them die at all.
>  - trace__set_startup_pids() writes what it enumerated after the attach,
>    which is a much smaller gap but still a gap.
>=20
> A task that dies inside one of those windows is never evicted, because
> the delete that would have done it ran while the map had nothing to
> delete. Its pid then sits in the map for the rest of the session: it
> [ ... ]
> last ')' in the file is taken as that one, since no field after the name
> has parentheses in it.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D10

