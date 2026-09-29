Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CCE39524D
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665562; cv=none; b=T8OAv5mmmwDu1vH2IHQ7oLKM1mEilfFHxnOGLo4v1AK0UVySkibi25GEVdYRMo2ezxO5Pu7h9/CMckBz1C7chiYiTTEq13apT0QrFuZOPkRijExXsY3w6zCZPoc1TxrerELopcV2vNx6+1oGzYAa9dF4/H5vMY/fFWTTsqPacCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665562; c=relaxed/simple;
	bh=PNwk+oBOBElxSnLctiI+40vTGZTXpWUcEeVdAh6hFeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cY/HvIBjdc0l5xD8o655COwuKAWlQSLGZW+x2tZf5axfVnUt1KbuIWSLqJukuQ6EktjgkwFfXB8ZNm4F3nBlH2tLnUfu4y2OoLXXFyoyhRhehPQPc7IjvA6tDUS4zcm7cnRFWblkJgQ4CPheHq2w9Qg+dbPxrVM2BFCWqmSwVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efwNSZ10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efwNSZ10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1801F000FF;
	Tue, 29 Sep 2026 07:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665560;
	bh=5uoAbo1zkvK3dQUq8/DqY5KO1WcFE6nQAkHda0rmqhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efwNSZ10KdtPTT+082Tux247L1Uc/PE//GaNj5JVv6z6lF0mAUepd7qpVgJMq8peq
	 5LRWZiLpz6Aw6x3Jj77HBoWF4MtGgmZtSz6rs8GR8T1qVu+hxddjpl3a+3bmiQAoRB
	 jm8DKjHDKGy1b9XFQ8OZnK6IvkB9adHYi4ZWOTEF66Xo4bvVhjjGjFCc58HCJzJ1E+
	 sU5t25alGydebZFkE/ly0SdjwrDPmPTq07iSFY3lH8bHe4uL6DRopmkg+Y0UArB3EH
	 YtTgW2Ku7PC3MBYVEj5hs0NshYEmgildQT21mfsNhBjylTSqSHknBiz3Oxk/nv4MVH
	 WEXeCaua0AFuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] perf pmu: Fix race with concurrent tracepoint
 creation and removal in perf list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929065839.407062-10-irogers@google.com>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
 <20260929065839.407062-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:06:00 +0000
Message-Id: <20260929070600.AD1801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf_pmus__print_pmu_events() first counts events via
> perf_pmu__num_events() to allocate the aliases array, then populates it
> via perf_pmu__for_each_event(). When dynamic tracepoints (such as
> kprobes or uprobes during 'perf test' runs) are concurrently created or
> removed between the two passes:
> - If an event is removed, state.index is smaller than the allocated len,
>   leaving trailing zeroed entries in aliases[] with name =3D=3D NULL and
>   pmu =3D=3D NULL, which causes qsort(cmp_sevent) or the print loop to cr=
ash
>   with SIGSEGV.
> - If a dynamic tracepoint subsystem directory is removed while scanning
>   /sys/kernel/tracing/events, tp_pmu__for_each_tp_event() returns
>   -ENOENT and aborts enumeration of all remaining tracepoint subsystems.
> - If an event is added, perf_pmus__print_pmu_events__callback() aborts
>   enumeration when state->index reaches state->aliases_len.
>=20
> Grow state->aliases dynamically via realloc() when needed, use
> state.index as the actual populated length for sorting and printing, and
> ignore -ENOENT when a tracepoint subsystem directory disappears during
> enumeration.
>=20
> Fixes: c3245d2093c1 ("perf pmu: Abstract alias/event struct")
> Fixes: 45b6e281cb06 ("perf tp_pmu: Add event APIs")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065839.4070=
62-1-irogers@google.com?part=3D9

