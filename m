Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E55395AFE
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742776; cv=none; b=BmQe03YFL5m/3zAtLcWYNI6TI0OClsKsKPBbOWidZPdWN4F9Hz/8PCSPeYvWRsN+0XBumnQ8PdYWHyftRDI3wQjXyhwIpowUa2j8BmJh3cCUkE0FwkdgnDcetTx3PzcQG0cgFMXFt88WAbTIjpWlIkaNm/mvFAzhN3ItNxNsca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742776; c=relaxed/simple;
	bh=iwU/pTm6udeFJh03Tyjh5j7cIfxjY/tCffvpZd6X1nE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jbhOdHe5Trs/mgRkepb8TQoAQpCSpnDMnULKAq+3uBpJK8piqzLTdRU+m0iymwylQvhBODNayF6NuqMlHjuO8/xqSca5R7n+4H38vYNzbzSY2NBlo+RgSI2//p9++Z8h6SPaRBA2iTYD8w9nupLu9Iwp1omrZ8AxGff7zXIgRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYa6eO62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYa6eO62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFBA1F000FF;
	Fri, 18 Sep 2026 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742773;
	bh=iwU/pTm6udeFJh03Tyjh5j7cIfxjY/tCffvpZd6X1nE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NYa6eO62Ayl9Md8tsqff/Vrx+7iuLW7x3Kad0Qk75gfuyUFxapbB2koS+5Si8n+HY
	 9ozh0FED8l02xrGCeoW2utl6Y0oiUPc3LSYL5f+l+WkhcVixppaPtlB2NG3gZZPUSy
	 yzUaYaYAZBQuF35IiH8HB/OBwrd/KkVOMcyhQjzrQjHEHKxuRarkJ+g491gbEGtFXS
	 6H9qcYvl/rBWbdpbk5Vhq7Vg7XhFCoDkmY9J0HtzlOP54kn0nKlGlcXfhlpcomw9Mw
	 uAZ05ppfnHdvQqR2vzH2mv8sy0g7ADeEI5QahOeNJ05uYPSgh79jAabRvLAZwCYt7P
	 JC6auq/FkAvSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/16] perf test common: Only disable probes in
 clear_all_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-11-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:46:13 +0000
Message-Id: <20260918144613.BBFBA1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D10

