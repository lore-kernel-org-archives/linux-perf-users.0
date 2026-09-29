Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB6280A56;
	Tue, 29 Sep 2026 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721305; cv=none; b=uOiKwR04oTvVOHswjaAn5kMiyugpcqM8H+QzE/D1dVmM2sJa6a+euK0GKQ9OJKyUsyOPm/J2+iJ188/W6cCZLRtxBAeo1MeQ4ReOHYZOx2kqlX9fNKR/fxMuoC/xUPgJ1vKH1qFRYirj9qN6jVYNTgGNLTsHRwJOrGsagadATSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721305; c=relaxed/simple;
	bh=NArT7zYVmmsbEyMU7zv7ZoCHqWJfQqwv+afUIPvbG8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IX5GtfYmVcYYhxSNCULD0CS+mv4j+ZLECR4xvgCulLQ+9JQXl5vTdVF3PSwC0Sobme/5K+kJzRI2uaJeU19e1xSDVr5ck7lXcdkmJV6+LZoHfzC1uX6R1PjGdS8eJQ8Qs72Eps9kLx97w0TXoudM8jJSxEo91/5eWshQIQm/7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr9tv62T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr9tv62T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F91F000FF;
	Tue, 29 Sep 2026 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790721304;
	bh=NArT7zYVmmsbEyMU7zv7ZoCHqWJfQqwv+afUIPvbG8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yr9tv62TEbOcOiRhMOZURDEMDrnrnJs518YQUs+yxHc52if+zldK3M84K5TatAvG2
	 /vS2tOO5Abd2pbe3XNQFxM99j7c8gCtK3JP0q+ZpYwGmE+lZxIJvQajWij5qF08O8F
	 MCJChYBmrDO1CXcWuRQ/1+UjtqifUV8cLBQf9AiSIEZUejzMInvDJy2Nrt0D/Mf5dC
	 bWCDMNduX0QTeO7Kd9YJFnLR4lhGZT8ut2tQNGKSRw79nsgiyMXtvPvEvceqK46aL2
	 XtzHxt/HdrXIdmupvfOMTPda9SFPJDWaKXJRoFBRpmeMDyFxxJYyBj4LMpoiGY6vi9
	 eoOkzd6TOlUEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf/core: Replace perf_event_header__init_id with
 full header init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260929222332.973435-1-irogers@google.com>
References: <20260929182108.794434-1-irogers@google.com>
 <20260929222332.973435-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 22:35:03 +0000
Message-Id: <20260929223504.037F91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf_iterate_sb() invokes its callback for each matching perf_event on
> the CPU and task context, passing a shared caller-allocated event
> structure.
>=20
> perf_event_header__init_id() mutated header->size in place by adding
> event->id_header_size, requiring sideband output callbacks to save and
> restore header fields across iterations. Three sideband callbacks failed
> to save and restore header.size around perf_event_header__init_id():
> - perf_event_ksymbol_output()
> - perf_event_bpf_output()
> - perf_event_text_poke_output()
>=20
> When multiple events with attr.ksymbol, attr.bpf_event, or
> attr.text_poke and sample_id_all are active on the same CPU, each
> subsequent event receives a record whose header.size is inflated by all
> [ ... ]
> Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
> Fixes: e17d43b93e54 ("perf: Add perf text poke event")
> Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929222332.9734=
35-1-irogers@google.com?part=3D1

