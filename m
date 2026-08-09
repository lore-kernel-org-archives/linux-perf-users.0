Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B51E492D
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786261056; cv=none; b=lpGPTq9nVcqgG7U7sI5nkOez1n2MjXQIRcMx9E8iZIjWGrHBNsfWjYBAe6r8tOsG9gdBIue+o/4uQfSusiu8LgEFg5OvFYVKqRkW35qyAUiiwiWpFFw/byYD3jDowe422kw5fT0Vlw8sBtCmXPTGGmJIp6XlxaGlXkJkaGWFKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786261056; c=relaxed/simple;
	bh=h4Nojy5O4QGxR60oyYF1tsIW2dYNoO+0q419D4x+EpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ras5SVQFhEt/WbKUN/1eBpz9ty5gaFAlN4FxaQcQ3GAyxwvQPhprAKjvYT4IOj4B7Ig7nYrc0d0Z89LfwEQzoeuFFAL5W2Q8Fra6wFLQ8aZGWhxNdKkQD6s3JfB7VXAEsduPKHTY5qknIts3sosflGLxEEEHSPWV1npxmk/HnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIo8lbOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIo8lbOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70901F000E9;
	Sun,  9 Aug 2026 07:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786261055;
	bh=YPK2deluE21XUpMicM7qKj9UzW7/eC0F/Ub3mh/kZjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cIo8lbOYBV32coqOEMy/mhZlW9Zcx3LfNbyNxTPeSNTI1d6XBaCoV7PVEtXUJ5M/p
	 KJSHvColLkMnSrNBMg9i9rZvbTzrIziiU724JKXkS12xwuVpOErhLdDJvTi/PeO0CI
	 A6St8y5XyIvkKv/wyszEugjUxjLL8A2BzCDvZQETpowrdtdUiyLiMBjlaFvSRb6OsL
	 IheZnFLgtpIA/HFVvsqsKNHfDS4eyFkmDswy8LKCF6TKq2m0A/+xGr/6rzkVCXAbSu
	 XvHT2KHGMwzxJyLoKlJ/olx6e5LqTmkzqOQyuT0R1raIkhpkFMWjiZIv6ollFI0cKl
	 GTkrI+OlmFvyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/15] perf script: Fix metric_evlist leak in
 script_find_metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260809071455.1221514-2-irogers@google.com>
References: <20260624051535.3584977-1-irogers@google.com>
 <20260809071455.1221514-1-irogers@google.com>
 <20260809071455.1221514-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 07:37:33 +0000
Message-Id: <20260809073734.D70901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Prematurely setting `metric_evsel->metric_id =3D NULL` breaks subs=
equent metric event lookups, null-terminating the `metric_events` array and=
 dropping events.
--

--- Patch [1]: [PATCH v3 01/15] perf script: Fix metric_evlist leak in scri=
pt_find_metrics ---
commit 5fba9e29ce353d01c2f25b3b58a05d2fc79eb299
Author: Ian Rogers <irogers@google.com>

perf script: Fix metric_evlist leak in script_find_metrics

Fix a memory leak in script_find_metrics() where metric_evlist is leaked
when returning early on error paths.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c

[ ... ]

> 	evlist__for_each_entry(metric_evlist, metric_evsel) {
> 		struct evsel *script_evsel =3D
> 			map_metric_evsel_to_script_evsel(script_evlist, metric_evsel);
> 		struct metric_event *metric_me =3D
> 			metricgroup__lookup(evlist__metric_events(metric_evlist),
> 					    metric_evsel,
> 					    /*create=3D*/false);
>=20
> 		if (script_evsel->metric_id =3D=3D NULL) {
> 			script_evsel->metric_id =3D metric_evsel->metric_id;
> 			metric_evsel->metric_id =3D NULL;
> 		}

[Severity: High]
This is a pre-existing issue, but could clearing metric_evsel->metric_id
here interfere with mapping resolutions later in this loop?

[ ... ]

> 			list_splice_init(&metric_me->head, &script_me->head);
> 			list_for_each_entry(expr, &script_me->head, nd) {
> 				for (int i =3D 0; expr->metric_events[i]; i++) {
> 					expr->metric_events[i] =3D
> 						map_metric_evsel_to_script_evsel(script_evlist,
> 									expr->metric_events[i]);
> 				}
> 			}
> 		}
> 	}

When map_metric_evsel_to_script_evsel() evaluates the required events,
would a NULL metric_id from the earlier transfer cause evsel__metric_id()
to return unknown?=20

It looks like this might fail the ID comparison against the script event
and return NULL, which would prematurely terminate the expr->metric_events
array and cause events to be silently dropped.

[ ... ]

> -	evlist__put(metric_evlist);
>  out:
> +	evlist__put(metric_evlist);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809071455.1221=
514-1-irogers@google.com?part=3D1
