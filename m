Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889A52BE29
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766818; cv=none; b=lmTWAuyfS4m8SDx6vK4Y1Rv7Jy/DU5W9aw/t2piHKT4ndhbMBYkphYzGNu9DBQwj3eG//mShEkFoDWx7TFMpgMeRBbhyHjHlLIJh+9+FRlzOhvxUEqV6pr7cYkSpvbbQ9hb/Bl1GlDgfN345ybln4f22qLtU15/437IVvexIaCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766818; c=relaxed/simple;
	bh=iBYV5enTHKPdRgHboDFDmAy1aZEclxXVXWbIN1bHblk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KJTLX4JCzu49I+VSEbEgrhKh21oBLugTNCK16A7RpHVuhmok/SaDnWx45cUPQ/bclyKwLdEYU/DQzN8KB6YAT5RfUMJ4HJs2MhdKauldGr0c/j7Hl/svLIIfxdWBAIeAwNtuJL9lmV5aBj/oHaNPoHPiya+k1yeUxWyjMkY0EfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOuZvql2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOuZvql2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598401F000FF;
	Fri, 18 Sep 2026 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766816;
	bh=iBYV5enTHKPdRgHboDFDmAy1aZEclxXVXWbIN1bHblk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oOuZvql2MdvCqntdyOlRej+LQZL19xc9+o9d+NHKBri0PVaWi696EXu0o28lC+BUT
	 fa3AfbnpCUz8pS6BjUJnXkqJV+7bOkqdBkuHCduNyPp9WP3SYS1+u2y9VncW5jC1vr
	 ZgdfbPpHWpY5UwfmUggIMhmMQFTpngrEohzrNfkaIVQJmgmDK8HnDMxH9oR98lfij/
	 B6Pb+Sjbddal0Rj+rmxPJDeB7iJq+q3Ok+IUCjei0YBXDlQpSRd0milW4z3loFlvF5
	 Uo1eNIDzsNuXa9MdXC7ggm47cd2VtZkku07gTCwy9mofW1ugcSt0eST0c+eAp/r5ry
	 qjC3uL8SvB0nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/18] perf test common: Only disable probes in
 clear_all_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-13-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:26:55 +0000
Message-Id: <20260918212656.598401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> clear_all_probes() began by writing 0 to
> /sys/kernel/debug/tracing/events/enable, which disables every tracepoint
> on the system rather than just the probes the probe tests created. When
> tests run in parallel that also silences the events of any concurrent
> perf record, perf trace or ftrace session, so unrelated tests lose the
> events they are waiting for and fail.
>=20
> The write cannot simply be dropped. Clearing kprobe_events or
> uprobe_events is all or nothing: dyn_events_release_all() walks every
> probe of that type first and returns -EBUSY without removing any of them
> if it finds one that is still enabled, where enabled means TP_FLAG_TRACE
> from tracefs or TP_FLAG_PROFILE from a perf session. A probe left enabled
> through tracefs would therefore block the whole clear and leave stale
> probes behind to collide with the next run.
>=20
> Disable the probes and only the probes. The set to disable is taken from
> the kprobe_events and uprobe_events listings rather than from a guess at
> which groups perf uses, so it matches what dyn_events_release_all() is
> going to inspect: a probe an unrelated session left enabled in, say, the
> kprobes group would otherwise still abort the clear.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D12

