Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D458472F7A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663896; cv=none; b=oFR1vAMYes2JsLI1UEpHNxH5PeKvUy17iQav055j05XJhU6hodkeulvVImiczhZC/RwzcJlFRTwpHR+Tl9VBUkQHFFT7R+8yOBBwwXmmvFFDyPleVT8A1yipBNZh0oD99epihC0OBgrOISC9GN851XIxkauml3Yze556vNYrFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663896; c=relaxed/simple;
	bh=xyqSLTr22m9yn+iG7TaBO21GhNeCuE590nEMFt5X6Qc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K0LsSJRjKP0dCN7ETEr4rl8Ya7HbHikGQ02cTE0l93y1yE76ucyby9xOXfl5XtHl8slwqqvtZwS6oLpCzIlTTg1Uq+s5QIr+R2qxoR1I/2OvVOuF0s1Mg3YOXzeKLzB915uFCzTVg27l/5rQnUuUQ8JZHxWQtHCzXQovRE9wjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rpms4tHm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rpms4tHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131CD1F000FF;
	Tue, 29 Sep 2026 06:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663895;
	bh=HvMR38JCS3O25JgihOrYu4/JX3iZsTzq8bYzjnEaMV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rpms4tHmy643mu78/YaVr0rM9SkMnAOPlV9wI0Ysitv7QythtfK72z+CxdVLqZPEr
	 tqaTmgekpLkmWXDZ0D8k/S4pciKZmtQmA4BMu1GFLRy+58AOATt8RU36C3jJwdLJAL
	 jmnBpCqYFdMM3Owdxh9oom5oNbsnLlNdMf5k4+gxZfeWiUWpmA19zz2KAwlaPDDOlc
	 7AhGohec1b2eIG/npnb6XfZf4I+rkc3cY+C3LozzDzE/uj/1MFuDQOtTkrG19hKQvj
	 k/1TKJP7LVMf0Rwo46mxF+gb7Eeuctp6YeR6OUlAIsx+uQ92HwEUYXcAN9knaJir9T
	 Cy3GySNLd/ibg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] perf pmu: Fix race with concurrent tracepoint
 creation and removal in perf list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929062937.374137-10-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929062937.374137-1-irogers@google.com>
 <20260929062937.374137-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:38:14 +0000
Message-Id: <20260929063815.131CD1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929062937.3741=
37-1-irogers@google.com?part=3D9

