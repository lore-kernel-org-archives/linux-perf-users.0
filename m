Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A331E84F
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706178; cv=none; b=hQuGY7dBB5rAhcHp9fAIqA2QkWD3QXSXc+sPWP+xQ3jisfd49Zt09PCZanN7DSxxi2DXBWJWAISiApKOZsl7RUn81SBfzGf2AiObLVRRXw4E2WhNR4QWf+3N/WxxpflcKOYiJo6NpyusFmbbbLn0xReGu7OnjwgevjcFlzXYV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706178; c=relaxed/simple;
	bh=jchmT2RiybUpAUZda40PRScHiqLJnLnIHqgA5awTt6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JnVP15FR7ojgs4kEBxyqgFyIlFCzg0wRJSHfnedeEyFuLMDcVTyAsjTVgym9GdIETmmn7Zi04SMOLkW7XNnTBtNFR4OZRILuyuAetIWwoXaMmSUhl8WdQ54cm8vZy4JGolEdWK3xsiZINM/64/SV9GGFoMK5ikbP2EXrVlTnCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwJcAevT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwJcAevT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0EC1F000E9;
	Sun,  2 Aug 2026 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785706177;
	bh=RNrM/Z/lpvQ2W4rCtdwdTirfJ73+1nI3wP1yvP9D7SQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SwJcAevTAggCc9oKc+1dvy9vrnIqKzdM9ZWR9JuJ4Q6cO90uGXOtPJgOuzyFblVcK
	 HKRkmyP9ylw5P8Ddh4IVAZ6JoUKnM38KGF3VDimeZ2ghLsVRzFSzwHZLXFuLyDvfCC
	 oICTVywJq7pH4Ayx+UgZ8F+76DASvxs4SByTSKvHXhkQZ0lLhRbxeEJiwmXBL62Y8o
	 idoyC2zEwOZr32QDD2tYIaRs+xAgop559jiM3CUuK9f0LG6Ot2lm3nsm/479hqEBrN
	 DW9qyfu0A20hLtjtULzMXRBeEvIOzHY/eGJd1luj2qKq51WBwhjsGv/yY1LQFjsrxt
	 pD9HGrDQrInYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] perf sched: Handle missing trace samples in pipe
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260802210914.199941-3-atomlin@atomlin.com>
References: <20260802210914.199941-1-atomlin@atomlin.com>
 <20260802210914.199941-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 21:29:36 +0000
Message-Id: <20260802212937.4F0EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit `<string.h>` inclusion for `strcmp()`, violating m=
usl compatibility guidelines.
--

--- Patch [2]: [PATCH v7 2/4] perf sched: Handle missing trace samples in p=
ipe mode ---
commit 204b30b0b1a2539fa7ad4c2b18b98020812488df
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched: Handle missing trace samples in pipe mode

This commit improves the handling of missing trace samples when perf is
running in pipe mode. It dynamically registers missing callbacks, moves the
trace handlers array to file-scope, and dynamically assigns handlers.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 94a323da0799a..232e72537df36 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
[ ... ]
> @@ -1946,7 +1962,22 @@ static int perf_sched__process_tracepoint_sample(c=
onst struct perf_tool *tool __
>  	struct evsel *evsel =3D sample->evsel;
>  	int err =3D 0;
> =20
> -	if (evsel->handler !=3D NULL) {
> +	if (evsel->handler =3D=3D NULL) {
> +		evsel->handler =3D process_sched_ignore;
> +		for (size_t i =3D 0; i < ARRAY_SIZE(latency_handlers); i++) {
> +			if (evsel__name_is(evsel, latency_handlers[i].name)) {
> +				if (!strcmp(latency_handlers[i].name, "sched:sched_wakeup") &&
                                    ^^^^^^^^

[Severity: Low]
Does this file need an explicit #include <string.h>?

The perf tools musl compatibility guidelines require all POSIX libc functio=
ns
like strcmp() to have explicit, direct header inclusions to prevent musl
compilation failures, rather than relying on implicit inclusions through
other headers.

> +				    sample->evsel->evlist &&
> +				    evlist__find_tracepoint_by_name(sample->evsel->evlist, "sched:sc=
hed_waking"))
> +					evsel->handler =3D process_sched_wakeup_ignore;
> +				else
> +					evsel->handler =3D latency_handlers[i].handler;
> +				break;
> +			}
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802210914.1999=
41-1-atomlin@atomlin.com?part=3D2
